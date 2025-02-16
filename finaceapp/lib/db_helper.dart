import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'usermodel.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        age INTEGER NOT NULL,
        bankname TEXT NOT NULL,
        balance REAL NOT NULL DEFAULT 10000.0
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        type TEXT NOT NULL, -- "deposit" or "withdrawal"
        amount REAL NOT NULL,
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');
  }
  // Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  //   if (oldVersion < 2) {
  //     await db.execute('ALTER TABLE users ADD COLUMN balance REAL NOT NULL DEFAULT 10000.0');
  //     await db.execute('''
  //       CREATE TABLE transactions (
  //         id INTEGER PRIMARY KEY AUTOINCREMENT,
  //         user_id INTEGER NOT NULL,
  //         type TEXT NOT NULL,
  //         amount REAL NOT NULL,
  //         timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  //         FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
  //       )
  //     ''');
  //   }
  // }

  // Insert User (Sign Up)
  Future<int> insertUser(User user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get User (Login)
  Future<User?> getUser(String email, String password) async {
    final db = await instance.database;
    final maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<double?> getUserBalance(int userId) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      columns: ['balance'],
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      return result.first['balance'] as double?;
    }
    return null;
  }

  // Deposit Money
  Future<void> depositMoney(int userId, double amount) async {
    final db = await instance.database;

    await db.transaction((txn) async {
      // Update balance
      await txn.rawUpdate(
        'UPDATE users SET balance = balance + ? WHERE id = ?',
        [amount, userId],
      );

      // Insert transaction record
      await txn.insert('transactions', {
        'user_id': userId,
        'type': 'deposit',
        'amount': amount,
      });
    });
  }

  // Withdraw Money
  Future<bool> withdrawMoney(int userId, double amount) async {
    final db = await instance.database;

    // Get the current balance
    double? balance = await getUserBalance(userId);

    if (balance != null && balance >= amount) {
      await db.transaction((txn) async {
        // Deduct balance
        await txn.rawUpdate(
          'UPDATE users SET balance = balance - ? WHERE id = ?',
          [amount, userId],
        );

        // Insert transaction record
        await txn.insert('transactions', {
          'user_id': userId,
          'type': 'withdrawal',
          'amount': amount,
        });
      });

      return true;
    }

    return false; // Not enough balance
  }

  // Fetch Transaction History
  Future<List<Map<String, dynamic>>> getTransactionHistory(int userId) async {
    final db = await instance.database;
    return await db.query(
      'transactions',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'timestamp DESC',
    );
  }
}

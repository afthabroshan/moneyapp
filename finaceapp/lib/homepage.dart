import 'package:financeapp/db_helper.dart';
import 'package:financeapp/loginpage.dart';
import 'package:flutter/material.dart';
import 'usermodel.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double balance = 0;
  List<String> transactionHistory = [];
  @override
  void initState() {
    super.initState();
    balance = widget.user.balance;
    _loadTransactionHistory();
  }

  Future<void> _loadTransactionHistory() async {
    List<Map<String, dynamic>> transactions =
        await DatabaseHelper.instance.getTransactionHistory(widget.user.id!);

    setState(() {
      transactionHistory = transactions
          .map((tx) =>
              "${tx['type'] == 'deposit' ? 'Deposited' : 'Withdrew'} ₹${tx['amount'].toStringAsFixed(2)}")
          .toList();
    });
  }

  void _showTransactionDialog(bool isDeposit) {
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isDeposit ? "Deposit Money" : "Withdraw Money"),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Enter amount"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                double amount = double.tryParse(amountController.text) ?? 0.0;
                if (amount > 0) {
                  setState(() {
                    if (isDeposit) {
                      widget.user.balance += amount;
                      transactionHistory.insert(
                          0, "Deposited \$${amount.toStringAsFixed(2)}");
                    } else {
                      if (widget.user.balance >= amount) {
                        widget.user.balance -= amount;
                        transactionHistory.insert(
                            0, "Withdrew \$${amount.toStringAsFixed(2)}");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Insufficient balance")),
                        );
                      }
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  void _showTransactionHistory() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Transaction History"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: transactionHistory
                .map((transaction) => Text(transaction))
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showLoanSuggestion() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Loan suggestion"),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
                "Based on your previous expenses, the loan of 1000 is suggestable."),
          ]),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.user.name}"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${widget.user.name}",
                        style: TextStyle(fontSize: 18)),
                    Text("Email: ${widget.user.email}",
                        style: TextStyle(fontSize: 18)),
                    Text("Age: ${widget.user.age}",
                        style: TextStyle(fontSize: 18)),
                    Text("Bankname: ${widget.user.bankname}",
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Balance",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text("₹${widget.user.balance.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 18)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              _showTransactionDialog(true);
                            },
                            icon: Icon(Icons.add)),
                        IconButton(
                            onPressed: () {
                              _showTransactionDialog(false);
                            },
                            icon: Icon(Icons.remove)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Transaction History:"),
                        IconButton(
                            onPressed: () {
                              _showTransactionHistory();
                            },
                            icon: Icon(Icons.remove_red_eye)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 173, 173, 173),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextButton(
                        onPressed: _showLoanSuggestion,
                        child: Text("Loan suggestion")),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

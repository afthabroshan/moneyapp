import 'package:financeapp/transview.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  final Map<String, List<Map<String, String>>>
      accounts; // Bank name -> Transactions

  TransactionsPage({required this.accounts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Bank Accounts")),
      body: ListView(
        children: accounts.keys.map((bankName) {
          return ListTile(
            title: Text(bankName),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BankTransactionsPage(
                    bankName: bankName,
                    transactions: accounts[bankName]!,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

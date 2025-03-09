import 'package:flutter/material.dart';

class BankTransactionsPage extends StatelessWidget {
  final String bankName;
  final List<Map<String, String>> transactions;

  BankTransactionsPage({required this.bankName, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$bankName Transactions")),
      body: transactions.isEmpty
          ? Center(child: Text("No transactions available."))
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  title: Text(
                      "${transaction['type']} - ₹${transaction['amount']}"),
                  subtitle: Text("Date: ${transaction['date']}"),
                  trailing: Text(transaction['status'] ?? "Pending"),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';

class InterestPage extends StatelessWidget {
  final Map<String, double> accounts; // Bank name -> Current Balance

  InterestPage({required this.accounts});

  // Dummy interest rates for different banks
  final Map<String, double> interestRates = {
    "HDFC Bank": 3.5, // 3.5% per annum
    "SBI Bank": 4.0,
    "ICICI Bank": 3.75,
  };

  // Function to calculate interest
  double calculateInterest(String bankName, double balance) {
    double rate = interestRates[bankName] ?? 3.0; // Default interest rate 3%
    return (balance * rate) / 100; // Simple annual interest calculation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Interest Calculation")),
      body: accounts.isEmpty
          ? Center(child: Text("No accounts found."))
          : ListView(
              children: accounts.entries.map((entry) {
                String bankName = entry.key;
                double balance = entry.value;
                double interest = calculateInterest(bankName, balance);

                return ListTile(
                  title: Text(bankName),
                  subtitle: Text("Balance: ₹$balance"),
                  trailing:
                      Text("Yearly Interest: ₹${interest.toStringAsFixed(2)}"),
                );
              }).toList(),
            ),
    );
  }
}

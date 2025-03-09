import 'package:financeapp/AddAccount.dart';
import 'package:financeapp/createExisitng.dart';
import 'package:flutter/material.dart';
import 'dart:io';
// import 'package:image_picker/image_picker.dart';

class BankListPage extends StatefulWidget {
  @override
  _BankListPageState createState() => _BankListPageState();
}

class _BankListPageState extends State<BankListPage> {
  final List<String> banks = [
    "HDFC Bank",
    "SBI Bank",
    "Federal Bank",
    "Canara Bank"
  ];
  List<String> banksWithExistingAccounts = [
    "HDFC Bank",
    "SBI Bank"
  ]; // Pre-existing accounts
  Map<String, Map<String, String>> accountDetails =
      {}; // Store added account details

  void _addNewAccount(String bankName, Map<String, String> details) {
    setState(() {
      banksWithExistingAccounts.add(bankName);
      accountDetails[bankName] = details;
    });
  }

  void _showExistingAccountDialog(BuildContext context, String bankName) {
    final details = accountDetails[bankName] ??
        {
          "ACC Number": "1234567890",
          "IFSC Code": "ABCD1234",
          "Balance": "\$10,000"
        };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Existing Account - $bankName"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:
              details.entries.map((e) => Text("${e.key}: ${e.value}")).toList(),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Close")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select a Bank")),
      body: ListView.builder(
        itemCount: banks.length,
        itemBuilder: (context, index) {
          String bankName = banks[index];
          bool hasExistingAccount =
              banksWithExistingAccounts.contains(bankName);

          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(bankName),
              trailing: hasExistingAccount
                  ? ElevatedButton(
                      onPressed: () {
                        _showExistingAccountDialog(context, bankName);
                      },
                      child: Text("View Existing Account"),
                    )
                  : PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "existing") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddExistingAccountPage(
                                bankName: bankName,
                                onAccountAdded: _addNewAccount,
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateNewAccountPage(
                                bankName: bankName,
                                onAccountCreated: _addNewAccount,
                              ),
                            ),
                          );
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            value: "existing",
                            child: Text("Add Existing Account")),
                        PopupMenuItem(
                            value: "new", child: Text("Create a New Account")),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}

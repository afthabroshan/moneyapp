import 'dart:developer';

import 'package:financeapp/AddAccount.dart';
import 'package:financeapp/acc_details.dart';
import 'package:financeapp/userId.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class bankpage extends StatefulWidget {
  const bankpage({super.key});

  @override
  State<bankpage> createState() => _bankpageState();
}

class _bankpageState extends State<bankpage> {
  final supabase = Supabase.instance.client;
  final loggedInUserId = UserSession().getUserId();

  List<Map<String, dynamic>> bankAccounts = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchBankAccounts();
  }

  Future<void> fetchBankAccounts() async {
    try {
      // log(loggedInUserId.toString());
      final response = await supabase
          .from('account')
          .select()
          .eq('user_id', loggedInUserId!);
      log(response.toString());
      setState(() {
        bankAccounts = response as List<Map<String, dynamic>>;
        isLoading = false;
      });
    } catch (e) {
      log("Error fetching accounts: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomePage()),
            // );
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              "Add Your Account",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddAccountForm()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle, color: Colors.blue, size: 30),
                    SizedBox(width: 10),
                    Text(
                      "Add Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Your Available Accounts:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : bankAccounts.isEmpty
                    ? Center(
                        child: Text("No Accounts found"),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: bankAccounts
                              .length, // Replace with dynamic account list count
                          itemBuilder: (context, index) {
                            final account = bankAccounts[index];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.account_balance_wallet,
                                    color: Colors.blue),
                                title: Text("Account ${account['bank_name']}"),
                                subtitle:
                                    Text("Account No: ${account['acc_no']}"),
                                trailing:
                                    Icon(Icons.arrow_forward_ios, size: 16),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AccountDetailsScreen(
                                              account: account),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}

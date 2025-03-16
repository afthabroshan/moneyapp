import 'dart:developer';

import 'package:financeapp/userId.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddAccountForm extends StatefulWidget {
  @override
  _AddAccountFormState createState() => _AddAccountFormState();
}

class _AddAccountFormState extends State<AddAccountForm> {
  final supabase = Supabase.instance.client;
  final loggedInUserId = UserSession().getUserId();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController accNoController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController balanceC = TextEditingController();
  Future<void> addBankAccount() async {
    final bankName = bankNameController.text.trim();
    final branch = branchController.text.trim();
    final accNo = accNoController.text.trim();
    final ifsc = ifscController.text.trim();
    final aadhar = aadharController.text.trim();
    final balance = balanceC.text.trim();

    if (bankName.isEmpty ||
        branch.isEmpty ||
        accNo.isEmpty ||
        ifsc.isEmpty ||
        aadhar.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields are required!")),
      );
      return;
    }

    try {
      final response = await supabase.from('account').insert({
        'bank_name': bankName,
        'branch': branch,
        'acc_no': accNo,
        'ifsc': ifsc,
        'aadhar': aadhar,
        'balance': balance,
        'user_id': loggedInUserId, // Linking to logged-in user
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account added successfully!")),
      );
      Navigator.pop(context); // Go back to previous screen
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Center(
              child: Text(
                "Add Account Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            buildTextField("Bank Name", bankNameController),
            buildTextField("Branch", branchController),
            buildTextField("Account Number", accNoController, isNumeric: true),
            buildTextField("IFSC Code", ifscController),
            buildTextField("Aadhar Number", aadharController, isNumeric: true),
            buildTextField("Balance", balanceC, isNumeric: true),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: addBankAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Add Account",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, TextEditingController controller,
      {bool isNumeric = false, bool isEmail = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: isNumeric
            ? TextInputType.number
            : (isEmail ? TextInputType.emailAddress : TextInputType.text),
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

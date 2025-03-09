import 'package:flutter/material.dart';

class AddExistingAccountPage extends StatefulWidget {
  final String bankName;
  final Function(String, Map<String, String>) onAccountAdded;

  AddExistingAccountPage(
      {required this.bankName, required this.onAccountAdded});

  @override
  _AddExistingAccountPageState createState() => _AddExistingAccountPageState();
}

class _AddExistingAccountPageState extends State<AddExistingAccountPage> {
  final _formKey = GlobalKey<FormState>();
  String accountHolderName = '';
  String accountNumber = '';
  String ifscCode = '';

  void _saveAccount() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onAccountAdded(widget.bankName, {
        "Account Holder Name": accountHolderName,
        "Account Number": accountNumber,
        "IFSC Code": ifscCode,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Existing Account - ${widget.bankName}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Account Holder Name"),
                validator: (value) =>
                    value!.isEmpty ? "Enter Account Holder Name" : null,
                onSaved: (value) => accountHolderName = value!,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: "Account Number"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? "Enter Account Number" : null,
                onSaved: (value) => accountNumber = value!,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: "IFSC Code"),
                validator: (value) => value!.isEmpty ? "Enter IFSC Code" : null,
                onSaved: (value) => ifscCode = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAccount,
                child: Text("Save Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

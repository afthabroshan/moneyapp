import 'package:flutter/material.dart';
import 'dart:io';
// import 'package:image_picker/image_picker.dart';

class CreateNewAccountPage extends StatefulWidget {
  final String bankName;
  final Function(String, Map<String, String>) onAccountCreated;

  CreateNewAccountPage(
      {required this.bankName, required this.onAccountCreated});

  @override
  _CreateNewAccountPageState createState() => _CreateNewAccountPageState();
}

class _CreateNewAccountPageState extends State<CreateNewAccountPage> {
  final _formKey = GlobalKey<FormState>();
  String aadhaarNumber = '';
  File? profilePhoto;
  File? addressProof;
  // final ImagePicker _picker = ImagePicker();

  // Future<void> _pickImage(bool isProfilePhoto) async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       if (isProfilePhoto) {
  //         profilePhoto = File(pickedFile.path);
  //       } else {
  //         addressProof = File(pickedFile.path);
  //       }
  //     });
  //   }
  // }

  void _saveAccount() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onAccountCreated(widget.bankName, {
        "Aadhaar Number": aadhaarNumber,
        "Profile Photo": profilePhoto?.path ?? "Not Provided",
        "Address Proof": addressProof?.path ?? "Not Provided",
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create New Account - ${widget.bankName}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Aadhaar Number"),
                validator: (value) =>
                    value!.isEmpty ? "Enter Aadhaar Number" : null,
                onSaved: (value) => aadhaarNumber = value!,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                // _pickImage(true),
                child: Text("Upload Profile Photo"),
              ),
              if (profilePhoto != null) Image.file(profilePhoto!, height: 100),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                //  _pickImage(false),
                child: Text("Upload Address Proof"),
              ),
              if (addressProof != null) Image.file(addressProof!, height: 100),
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

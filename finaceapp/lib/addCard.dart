import 'package:financeapp/userId.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// Assuming you have a UserSession class to get the user ID

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final SupabaseClient supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();

  bool isLoading = false;
  final loggedInUserId =
      UserSession().getUserId(); // Fetching logged-in user ID

  Future<void> addCardToSupabase() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await supabase.from('cards').insert({
        'user_id': loggedInUserId,
        'cvv': cvvController.text,
        'expiry_date': expiryDateController.text,
        'c_number': cardNumberController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Card added successfully!"),
            backgroundColor: Colors.green),
      );
      Navigator.pop(context);
      // Clear form after successful submission
      cvvController.clear();
      expiryDateController.clear();
      cardNumberController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Failed to add card: $e"),
            backgroundColor: Colors.red),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Card")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField("Card Number", cardNumberController,
                  TextInputType.number, 16),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField("Expiry Date (MM/YY)",
                        expiryDateController, TextInputType.datetime, 5),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: _buildTextField(
                        "CVV", cvvController, TextInputType.number, 3),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : addCardToSupabase,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Add Card", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      TextInputType keyboardType, int maxLength) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        counterText: "",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Please enter $label";
        return null;
      },
    );
  }
}

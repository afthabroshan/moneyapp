import 'package:flutter/material.dart';

class LoanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomePage()),
            // );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Adjust for different screen sizes
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.3, // Adjust for better spacing
          children: [
            loanTile(context, "Loan Reminder", Icons.notifications,
                Colors.orange, true),
            loanTile(context, "Gold Loan", Icons.account_balance_wallet,
                Colors.yellow.shade700, false),
            loanTile(
                context, "House Loan", Icons.home, Colors.blue.shade600, false),
            loanTile(context, "Agricultural Loan", Icons.agriculture,
                Colors.green.shade700, false),
            loanTile(context, "Educational Loan", Icons.school, Colors.purple,
                false),
          ],
        ),
      ),
    );
  }

  Widget loanTile(BuildContext context, String title, IconData icon,
      Color color, bool isReminder) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon, size: 40, color: color),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                if (isReminder) {
                  // Navigate to Loan Reminder Page
                  showLoanReminderPopup(context);
                } else {
                  // Navigate to Loan Application Page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoanApplicationPage(title)));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isReminder ? Colors.orange : Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(isReminder ? "View" : "Apply"),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder for Loan Reminder Page
void showLoanReminderPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)), // Rounded corners
        title: Row(
          children: [
            Icon(Icons.notifications_active, color: Colors.orange),
            SizedBox(width: 10),
            Text("Loan Reminders",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today, size: 50, color: Colors.blue.shade700),
            SizedBox(height: 10),
            Text(
              "You have upcoming loan payments:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            _reminderItem(
                "Gold Loan", "Due: 25th March 2025", Colors.yellow.shade700),
            _reminderItem(
                "House Loan", "Due: 10th April 2025", Colors.blue.shade600),
            _reminderItem("Education Loan", "Due: 5th May 2025", Colors.purple),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Dismiss", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}

Widget _reminderItem(String loanType, String dueDate, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Icon(Icons.circle, color: color, size: 12),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            "$loanType - $dueDate",
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    ),
  );
}

class LoanApplicationPage extends StatefulWidget {
  final String loanType;
  LoanApplicationPage(this.loanType);

  @override
  _LoanApplicationPageState createState() => _LoanApplicationPageState();
}

class _LoanApplicationPageState extends State<LoanApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  bool isSubmitted = false;

  void submitApplication() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSubmitted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.loanType} Application"),
        backgroundColor: Colors.blue.shade900,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: isSubmitted
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 80),
                    SizedBox(height: 20),
                    Text(
                      "Your application for ${widget.loanType} has been submitted!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Wait for further instructions.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildInputField("Full Name", nameController,
                            "Enter your full name"),
                        buildInputField(
                            "Email", emailController, "Enter your email",
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => value!.contains("@")
                                ? null
                                : "Enter a valid email"),
                        buildInputField("Phone Number", phoneController,
                            "Enter your phone number",
                            keyboardType: TextInputType.phone,
                            validator: (value) => value!.length == 10
                                ? null
                                : "Enter a valid phone number"),
                        buildInputField("Loan Amount", amountController,
                            "Enter loan amount",
                            keyboardType: TextInputType.number),
                        SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: submitApplication,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.blue.shade900,
                            ),
                            child: Text("Submit Application",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget buildInputField(
      String label, TextEditingController controller, String hint,
      {TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          SizedBox(height: 5),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            keyboardType: keyboardType,
            validator:
                validator ?? (value) => value!.isNotEmpty ? null : "Required",
          ),
        ],
      ),
    );
  }
}

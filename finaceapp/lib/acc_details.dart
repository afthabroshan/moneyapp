// import 'dart:developer';

// import 'package:flutter/material.dart';

// class AccountDetailsScreen extends StatefulWidget {
//   final Map<String, dynamic> account;

//   AccountDetailsScreen({required this.account});

//   @override
//   _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
// }

// class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
//   double balance = 0.0;
//   final TextEditingController amountController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     balance = (widget.account['balance'] ?? 0.0).toDouble();
//     log(balance.toString());
//   }

//   void updateBalance(bool isAddition) {
//     double amount = double.tryParse(amountController.text) ?? 0.0;
//     if (amount <= 0) return;

//     setState(() {
//       balance = isAddition ? balance + amount : balance - amount;
//     });

//     // Clear input field
//     amountController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Account Details"),
//         backgroundColor: Colors.blue.shade900,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.blue.shade900, Colors.blue.shade300],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 20),
//             Center(
//               child: Text(
//                 widget.account['bank_name'],
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     buildDetailRow("Branch", widget.account['branch']),
//                     buildDetailRow("Account Number", widget.account['acc_no']),
//                     buildDetailRow("IFSC Code", widget.account['ifsc']),
//                     buildDetailRow("Aadhar Number", widget.account['aadhar']),
//                     SizedBox(height: 15),
//                     Divider(),
//                     Center(
//                       child: Text(
//                         "Balance: ₹${balance.toStringAsFixed(2)}",
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue.shade900,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             buildAmountInput(),
//             SizedBox(height: 15),
//             buildBalanceButtons(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildDetailRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             value != null ? value.toString() : "Not Available",
//             style: TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildAmountInput() {
//     return TextField(
//       controller: amountController,
//       keyboardType: TextInputType.number,
//       style: TextStyle(color: Colors.black),
//       decoration: InputDecoration(
//         fillColor: Colors.grey.shade100,
//         filled: true,
//         hintText: "Enter Amount",
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }

//   Widget buildBalanceButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton.icon(
//           onPressed: () => updateBalance(true),
//           icon: Icon(Icons.add, color: Colors.white),
//           label: Text("Add"),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.green,
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//         SizedBox(width: 15),
//         ElevatedButton.icon(
//           onPressed: () => updateBalance(false),
//           icon: Icon(Icons.remove, color: Colors.white),
//           label: Text("Subtract"),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.red,
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:developer';

import 'package:financeapp/loanpage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> account;

  AccountDetailsScreen({required this.account});

  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  double savingsBalance = 0.0;

  final TextEditingController amountController = TextEditingController();
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    savingsBalance = widget.account['balance']?.toDouble() ?? 0.0;
    print(savingsBalance);
  }

  void updateBalance(bool isAddition) {
    double amount = double.tryParse(amountController.text) ?? 0.0;
    log(amount.toString());
    if (amount <= 0) return;

    setState(() {
      savingsBalance =
          isAddition ? savingsBalance + amount : savingsBalance - amount;
      widget.account['balance'] = savingsBalance;
      log(savingsBalance.toString());
    });

    amountController.clear();
    // Navigator.pop(context);
  }

  void navigateToLoanPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoanPage()),
    );
  }

  void showTransactionsPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Transaction History",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey.shade400),
                SizedBox(height: 10),
                Container(
                  height: 200, // Adjust height to fit more transactions
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        transactionTile("March 15, 2025", 500, "Debit"),
                        transactionTile("March 14, 2025", 1000, "Credit"),
                        transactionTile("March 12, 2025", 200, "Debit"),
                        transactionTile("March 10, 2025", 750, "Credit"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Divider(color: Colors.grey.shade400),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: Colors.white),
                  label: Text("Close"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showBalancePopup() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // Add StatefulBuilder
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Savings Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Balance: ₹${savingsBalance.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter Amount",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.blue.shade50,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            updateBalance(true);
                            setStateDialog(() {}); // Refresh Dialog UI
                          },
                          icon: Icon(Icons.add, color: Colors.white),
                          label: Text("Add"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            updateBalance(false);
                            setStateDialog(() {}); // Refresh Dialog UI
                          },
                          icon: Icon(Icons.remove, color: Colors.white),
                          label: Text("Subtract"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Divider(color: Colors.grey.shade400),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.cancel, color: Colors.grey.shade700),
                          label: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(color: Colors.grey.shade400),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await updateBalanceInDatabase(
                                savingsBalance); // Save to DB
                            Navigator.pop(context); // Close the dialog
                          },
                          icon: Icon(Icons.save, color: Colors.white),
                          label: Text("Save"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade900,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> updateBalanceInDatabase(double newBalance) async {
    try {
      final response = await supabase
          .from('account')
          .update({'balance': newBalance}).eq('id', widget.account['id']);
      log("Balance updated in DB: ₹${newBalance.toStringAsFixed(2)}");
    } catch (e) {
      log("error $e");
    }
  }

  Widget transactionTile(String date, double amount, String type) {
    bool isCredit = type == "Credit";
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(
          isCredit ? Icons.arrow_upward : Icons.arrow_downward,
          color: isCredit ? Colors.green : Colors.red,
          size: 28,
        ),
        title: Text(
          "₹${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isCredit ? Colors.green : Colors.red,
          ),
        ),
        subtitle: Text(
          date,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        trailing: Text(
          isCredit ? "Credit" : "Debit",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isCredit ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }

  // void showBalancePopup() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         backgroundColor: Colors.white,
  //         child: Padding(
  //           padding: const EdgeInsets.all(20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text(
  //                 "Savings Account",
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.black87,
  //                 ),
  //               ),
  //               SizedBox(height: 10),
  //               Text(
  //                 "Balance: ₹${savingsBalance.toStringAsFixed(2)}",
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.w500,
  //                   color: Colors.blue.shade900,
  //                 ),
  //               ),
  //               SizedBox(height: 20),
  //               TextField(
  //                 controller: amountController,
  //                 keyboardType: TextInputType.number,
  //                 decoration: InputDecoration(
  //                   hintText: "Enter Amount",
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(12),
  //                   ),
  //                   filled: true,
  //                   fillColor: Colors.blue.shade50,
  //                 ),
  //               ),
  //               SizedBox(height: 15),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   ElevatedButton.icon(
  //                     onPressed: () => updateBalance(true),
  //                     icon: Icon(Icons.add, color: Colors.white),
  //                     label: Text("Add"),
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Colors.green,
  //                       padding:
  //                           EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                     ),
  //                   ),
  //                   ElevatedButton.icon(
  //                     onPressed: () => updateBalance(false),
  //                     icon: Icon(Icons.remove, color: Colors.white),
  //                     label: Text("Subtract"),
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Colors.red,
  //                       padding:
  //                           EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: 15),
  //               Divider(color: Colors.grey.shade400),
  //               SizedBox(height: 10),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   OutlinedButton.icon(
  //                     onPressed: () => Navigator.pop(context),
  //                     icon: Icon(Icons.cancel, color: Colors.grey.shade700),
  //                     label: Text(
  //                       "Cancel",
  //                       style: TextStyle(color: Colors.grey.shade700),
  //                     ),
  //                     style: OutlinedButton.styleFrom(
  //                       padding:
  //                           EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                       side: BorderSide(color: Colors.grey.shade400),
  //                     ),
  //                   ),
  //                   ElevatedButton.icon(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     icon: Icon(Icons.save, color: Colors.white),
  //                     label: Text("Save"),
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Colors.blue.shade900,
  //                       padding:
  //                           EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget buildAccountTypeBox(String title, double balance, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "View",
                style: TextStyle(fontSize: 16, color: Colors.blue.shade900),
              ),
            ],
          ),
        ),
      ),
    );
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
            Center(
              child: Text(
                widget.account['bank_name'],
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDetailRow("Branch", widget.account['branch']),
                    buildDetailRow("Account Number", widget.account['acc_no']),
                    buildDetailRow("IFSC Code", widget.account['ifsc']),
                    buildDetailRow("Aadhar Number", widget.account['aadhar']),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                buildAccountTypeBox(
                    "Savings", savingsBalance, showBalancePopup),
                SizedBox(width: 10),
                buildAccountTypeBox("Current", 0, () {}),
                SizedBox(width: 10),
                buildAccountTypeBox("Fixed", 0, () {}),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: navigateToLoanPage,
                    icon: Icon(Icons.account_balance),
                    label: Text("Loan"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: showTransactionsPopup,
                    icon: Icon(Icons.history),
                    label: Text("Transactions"),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

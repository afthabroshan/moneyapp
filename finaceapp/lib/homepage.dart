// // import 'package:financeapp/bankpage.dart';
// // import 'package:financeapp/db_helper.dart';
// // import 'package:financeapp/intrestPage.dart';
// // import 'package:financeapp/loginpage.dart';
// // import 'package:financeapp/transaction.dart';
// // import 'package:flutter/material.dart';
// // import 'usermodel.dart';

// // class HomePage extends StatefulWidget {
// //   // final User user;

// //   const HomePage({super.key,
// //   // this.user
// //   });

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   Map<String, double> userAccountbalance = {
// //     "HDFC Bank": 50000.0,
// //     "SBI Bank": 75000.0,
// //   };

// //   Map<String, List<Map<String, String>>> userAccounts = {
// //     "HDFC Bank": [
// //       {
// //         "type": "Deposit",
// //         "amount": "5000",
// //         "date": "2025-03-01",
// //         "status": "Completed"
// //       },
// //       {
// //         "type": "Withdrawal",
// //         "amount": "1000",
// //         "date": "2025-02-28",
// //         "status": "Completed"
// //       },
// //     ],
// //     "SBI Bank": [
// //       {
// //         "type": "Deposit",
// //         "amount": "7000",
// //         "date": "2025-03-02",
// //         "status": "Completed"
// //       },
// //     ],
// //   };
// //   double balance = 0;
// //   List<String> transactionHistory = [];
// //   @override
// //   void initState() {
// //     super.initState();
// //     balance = widget.user.balance;
// //     _loadTransactionHistory();
// //   }

// //   Future<void> _loadTransactionHistory() async {
// //     List<Map<String, dynamic>> transactions =
// //         await DatabaseHelper.instance.getTransactionHistory(widget.user.id!);

// //     setState(() {
// //       transactionHistory = transactions
// //           .map((tx) =>
// //               "${tx['type'] == 'deposit' ? 'Deposited' : 'Withdrew'} ₹${tx['amount'].toStringAsFixed(2)}")
// //           .toList();
// //     });
// //   }

// //   void _showTransactionDialog(bool isDeposit) {
// //     TextEditingController amountController = TextEditingController();

// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text(isDeposit ? "Deposit Money" : "Withdraw Money"),
// //           content: TextField(
// //             controller: amountController,
// //             keyboardType: TextInputType.number,
// //             decoration: InputDecoration(labelText: "Enter amount"),
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.pop(context);
// //               },
// //               child: Text("Cancel"),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 double amount = double.tryParse(amountController.text) ?? 0.0;
// //                 if (amount > 0) {
// //                   setState(() {
// //                     if (isDeposit) {
// //                       widget.user.balance += amount;
// //                       transactionHistory.insert(
// //                           0, "Deposited \$${amount.toStringAsFixed(2)}");
// //                     } else {
// //                       if (widget.user.balance >= amount) {
// //                         widget.user.balance -= amount;
// //                         transactionHistory.insert(
// //                             0, "Withdrew \$${amount.toStringAsFixed(2)}");
// //                       } else {
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           SnackBar(content: Text("Insufficient balance")),
// //                         );
// //                       }
// //                     }
// //                   });
// //                   Navigator.pop(context);
// //                 }
// //               },
// //               child: Text("Submit"),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void _showTransactionHistory() {
// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text("Transaction History"),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: transactionHistory
// //                 .map((transaction) => Text(transaction))
// //                 .toList(),
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () => Navigator.pop(context),
// //               child: Text("Close"),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void _showLoanSuggestion() {
// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text("Loan suggestion"),
// //           content: Column(mainAxisSize: MainAxisSize.min, children: [
// //             Text(
// //                 "Based on your previous expenses, the loan of 1000 is suggestable."),
// //           ]),
// //           actions: [
// //             TextButton(
// //               onPressed: () => Navigator.pop(context),
// //               child: Text("Close"),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Welcome ${widget.user.name}"),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.logout),
// //             onPressed: () {
// //               Navigator.pushReplacement(context,
// //                   MaterialPageRoute(builder: (context) => LoginPage()));
// //             },
// //           ),

// //           // circle
// //           IconButton(
// //             onPressed: () {},
// //             icon: Image.asset(
// //               'assets/money_logo.jpg',
// //               //  width: 24, height: 24
// //             ),
// //           )
// //         ],
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             Container(
// //               decoration: BoxDecoration(
// //                   color: Colors.grey,
// //                   shape: BoxShape.rectangle,
// //                   borderRadius: BorderRadius.all(Radius.circular(25))),
// //               width: MediaQuery.of(context).size.width,
// //               child: Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text("Name: ${widget.user.name}",
// //                         style: TextStyle(fontSize: 18)),
// //                     Text("Email: ${widget.user.email}",
// //                         style: TextStyle(fontSize: 18)),
// //                     Text("Age: ${widget.user.age}",
// //                         style: TextStyle(fontSize: 18)),
// //                     Text("Bankname: ${widget.user.bankname}",
// //                         style: TextStyle(fontSize: 18)),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: 10),
// //             Container(
// //               decoration: BoxDecoration(
// //                   color: Colors.blueGrey,
// //                   shape: BoxShape.rectangle,
// //                   borderRadius: BorderRadius.all(Radius.circular(25))),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Column(
// //                   children: [
// //                     Text("Balance (Primary Account)",
// //                         style: TextStyle(
// //                             fontSize: 18, fontWeight: FontWeight.bold)),
// //                     SizedBox(height: 5),
// //                     Text("₹${widget.user.balance.toStringAsFixed(2)}",
// //                         style: TextStyle(fontSize: 18)),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         IconButton(
// //                             onPressed: () {
// //                               _showTransactionDialog(true);
// //                             },
// //                             icon: Icon(Icons.add)),
// //                         IconButton(
// //                             onPressed: () {
// //                               _showTransactionDialog(false);
// //                             },
// //                             icon: Icon(Icons.remove)),
// //                       ],
// //                     ),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Text("Transaction History:"),
// //                         IconButton(
// //                             onPressed: () {
// //                               _showTransactionHistory();
// //                             },
// //                             icon: Icon(Icons.remove_red_eye)),
// //                       ],
// //                     )
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: 10),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Container(
// //                     decoration: BoxDecoration(
// //                         color: const Color.fromARGB(255, 173, 173, 173),
// //                         shape: BoxShape.rectangle,
// //                         borderRadius: BorderRadius.all(Radius.circular(25))),
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Column(
// //                         children: [
// //                           TextButton(
// //                               onPressed: () {
// //                                 Navigator.push(
// //                                   context,
// //                                   MaterialPageRoute(
// //                                       builder: (context) => BankListPage()),
// //                                 );
// //                               },
// //                               child: Text("Bank")),
// //                         ],
// //                       ),
// //                     )),
// //                 Container(
// //                     decoration: BoxDecoration(
// //                         color: const Color.fromARGB(255, 173, 173, 173),
// //                         shape: BoxShape.rectangle,
// //                         borderRadius: BorderRadius.all(Radius.circular(25))),
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Column(
// //                         children: [
// //                           TextButton(
// //                               onPressed: () {
// //                                 Navigator.push(
// //                                   context,
// //                                   MaterialPageRoute(
// //                                     builder: (context) => InterestPage(
// //                                         accounts: userAccountbalance),
// //                                   ),
// //                                 );
// //                               },
// //                               child: Text("Current Intrest")),
// //                         ],
// //                       ),
// //                     )),
// //               ],
// //             ),
// //             SizedBox(height: 10),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Container(
// //                     decoration: BoxDecoration(
// //                         color: const Color.fromARGB(255, 173, 173, 173),
// //                         shape: BoxShape.rectangle,
// //                         borderRadius: BorderRadius.all(Radius.circular(25))),
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Column(
// //                         children: [
// //                           TextButton(
// //                               onPressed: () {}, child: Text("Budget Map")),
// //                         ],
// //                       ),
// //                     )),
// //                 Container(
// //                     decoration: BoxDecoration(
// //                         color: const Color.fromARGB(255, 173, 173, 173),
// //                         shape: BoxShape.rectangle,
// //                         borderRadius: BorderRadius.all(Radius.circular(25))),
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Column(
// //                         children: [
// //                           TextButton(
// //                               onPressed: () {
// //                                 Navigator.push(
// //                                   context,
// //                                   MaterialPageRoute(
// //                                       builder: (context) => TransactionsPage(
// //                                           accounts: userAccounts)),
// //                                 );
// //                               },
// //                               child: Text("Transactions")),
// //                         ],
// //                       ),
// //                     )),
// //               ],
// //             ),
// //             SizedBox(height: 10),
// //             Container(
// //               decoration: BoxDecoration(
// //                   color: const Color.fromARGB(255, 173, 173, 173),
// //                   shape: BoxShape.rectangle,
// //                   borderRadius: BorderRadius.all(Radius.circular(25))),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Column(
// //                   children: [
// //                     TextButton(
// //                         onPressed: _showLoanSuggestion,
// //                         child: Text("Loan suggestion")),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:developer';

// import 'package:financeapp/addCard.dart';
// import 'package:financeapp/bank_page.dart';
// import 'package:financeapp/budget_page.dart';
// import 'package:financeapp/interestpage.dart';
// import 'package:financeapp/loanpage.dart';
// import 'package:financeapp/mainloanpage.dart';
// import 'package:financeapp/userId.dart';
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class CardWidget extends StatefulWidget {
//   @override
//   _CardWidgetState createState() => _CardWidgetState();
// }

// class _CardWidgetState extends State<CardWidget> {
//   final loggedInUserId = UserSession().getUserId();
//   final supabase = Supabase.instance.client;
//   Map<String, dynamic>? cardDetails;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchCardDetails();
//   }

//   Future<void> fetchCardDetails() async {
//     if (loggedInUserId == null) {
//       log("User ID is null, unable to fetch card details.");
//       setState(() {
//         isLoading = false;
//       });
//       return;
//     }

//     log(loggedInUserId.toString());

//     final response = await supabase
//         .from('cards')
//         .select("c_number, expiry_date")
//         .eq('user_id',
//             loggedInUserId!) // Force unwrap, but safe due to the null check above
//         .maybeSingle();
//     log(response.toString());
//     setState(() {
//       cardDetails = response;
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     if (isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }

//     return Column(
//       children: [
//         cardDetails == null
//             ? Card(
//                 child: GestureDetector(
//                   onTap: () {
//                     // Navigate to add card screen
//                     Navigator.push(
//                         context, MaterialPageRoute(builder: (c) => AddCard()));
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade300,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Center(
//                         child: Text("Add New Card",
//                             style: TextStyle(fontSize: 18))),
//                   ),
//                 ),
//               )
//             : FittedBox(
//                 child: SizedBox(
//                   height: 200,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: size.width * 0.67,
//                         padding: EdgeInsets.fromLTRB(16, 10, 0, 20),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.horizontal(
//                               left: Radius.circular(15)),
//                           color: Colors.blue.shade700,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.asset('visa.png',
//                                 width: 60, height: 50, fit: BoxFit.cover),
//                             SizedBox(height: 20),
//                             Text('CARD NUMBER',
//                                 style: TextStyle(
//                                     color: Colors.white.withOpacity(0.5),
//                                     fontSize: 12)),
//                             SizedBox(height: 5),
//                             Text(cardDetails!['c_number'],
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 15)),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: size.width * 0.27,
//                         padding: EdgeInsets.fromLTRB(20, 10, 0, 20),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.horizontal(
//                               right: Radius.circular(15)),
//                           color: Colors.yellow.shade700,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Spacer(),
//                             Text('VALID', style: TextStyle(fontSize: 12)),
//                             SizedBox(height: 5),
//                             Text(cardDetails!['expiry_date'],
//                                 style: TextStyle(fontSize: 15)),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//         const SizedBox(
//           height: 20,
//         ),
//         Container(
//           padding: EdgeInsets.all(5),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _buildFeatureItem(Icons.account_balance, "Bank", bankpage()),
//                   _buildFeatureItem(
//                       Icons.pie_chart, "Budget Plan", budgetplan()),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _buildFeatureItem(
//                       Icons.money, "Loan Suggestions", Mainloanpage()),
//                   _buildFeatureItem(
//                       Icons.percent, "Interest Schemes", InterestPage()),
//                 ],
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   Widget _buildFeatureItem(IconData icon, String label, Widget page) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => page));
//         },
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon,
//                 size: 40,
//                 color: Colors.black), // Customize the icon size and color
//             SizedBox(height: 5),
//             Text(label,
//                 style: TextStyle(
//                   fontSize: 14,
//                   // fontWeight: FontWeight.bold
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'package:financeapp/addCard.dart';
import 'package:financeapp/bank_page.dart';
import 'package:financeapp/budget_page.dart';
import 'package:financeapp/interestpage.dart';
import 'package:financeapp/loanpage.dart';
import 'package:financeapp/mainloanpage.dart';
import 'package:financeapp/userId.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CardWidget extends StatefulWidget {
  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final loggedInUserId = UserSession().getUserId();
  final supabase = Supabase.instance.client;
  Map<String, dynamic>? cardDetails;
  bool isLoading = true;
  String username = "User"; // Default username (can be fetched dynamically)

  @override
  void initState() {
    super.initState();
    fetchCardDetails();
    fetchUsername();
  }

  Future<void> fetchCardDetails() async {
    if (loggedInUserId == null) {
      log("User ID is null, unable to fetch card details.");
      setState(() {
        isLoading = false;
      });
      return;
    }

    final response = await supabase
        .from('cards')
        .select("c_number, expiry_date, cvv")
        .eq('user_id', loggedInUserId!)
        .maybeSingle();

    setState(() {
      cardDetails = response;
      isLoading = false;
    });
  }

  Future<void> fetchUsername() async {
    if (loggedInUserId == null) return;

    final response = await supabase
        .from('users')
        .select('name')
        .eq('id', loggedInUserId!)
        .maybeSingle();

    if (response != null && response['name'] != null) {
      setState(() {
        username = response['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // **Header with Username & App Logo**
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hey, $username! 👋\nWelcome to Money Map",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/money_logo.jpg'),
                    ), // Adjust logo size
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // **Card Display or Add New Card**
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: Colors.white))
                  : cardDetails == null
                      ? _buildAddCardWidget()
                      : _buildCardDisplay(size),

              const SizedBox(height: 20),

              // **Feature Options (Bank, Budget, Loan, Interest)**
              Expanded(
                child: _buildFeatureGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddCardWidget() {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (c) => AddCard())),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white),
        ),
        child: Center(
          child: Text(
            "Add New Card",
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildCardDisplay(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [Colors.blue.shade500, Colors.blue.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 20,
            top: 20,
            child: Image.asset('assets/visa.png', width: 60),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("CARD NUMBER",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 12)),
                SizedBox(height: 5),
                Text(cardDetails!['c_number'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("VALID THRU",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12)),
                        Text(cardDetails!['expiry_date'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.credit_card, color: Colors.white, size: 40),
                        SizedBox(height: 5), // Small space between icon and CVV
                        Text("CVV",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12)),
                        Text(cardDetails!['cvv'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 1.2,
        ),
        children: [
          _buildFeatureItem(Icons.account_balance, "Bank", bankpage()),
          _buildFeatureItem(Icons.pie_chart, "Budget Plan", budgetplan()),
          _buildFeatureItem(Icons.money, "Loan Suggestions", Mainloanpage()),
          _buildFeatureItem(Icons.percent, "Interest Schemes", InterestPage()),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => page)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 8),
            Text(label,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

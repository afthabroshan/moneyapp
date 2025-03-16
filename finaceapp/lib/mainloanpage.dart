import 'package:financeapp/AddAccount.dart';
import 'package:financeapp/acc_details.dart';
import 'package:financeapp/loanpage.dart';
import 'package:financeapp/userId.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Mainloanpage extends StatefulWidget {
  const Mainloanpage({super.key});

  @override
  _MainloanpageState createState() => _MainloanpageState();
}

class _MainloanpageState extends State<Mainloanpage> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> bankAccounts = [];
  bool isLoading = true;
  final loggedInUserId = UserSession().getUserId();

  @override
  void initState() {
    super.initState();
    fetchBankAccounts();
  }

  Future<void> fetchBankAccounts() async {
    setState(() {
      isLoading = true; // Set loading to true before fetching
    });
    final response =
        await supabase.from('account').select().eq('user_id', loggedInUserId!);
    setState(() {
      bankAccounts = List<Map<String, dynamic>>.from(response);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade900,
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
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade900, Colors.green.shade500],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              // AppBar
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text(
                      "Loans and Schemas",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : bankAccounts.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.account_balance_wallet_rounded,
                                    size: 60, color: Colors.orangeAccent),
                                SizedBox(height: 15),
                                Text(
                                  "No Interest Suggestions",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Please add a bank account to see loan suggestion and schemes.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddAccountForm()));
                                    // Add navigation to bank account addition screen
                                  },
                                  icon: Icon(Icons.add, color: Colors.white),
                                  label: Text("Add Bank Account"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orangeAccent,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.all(15),
                            itemCount: bankAccounts.length,
                            itemBuilder: (context, index) {
                              final account = bankAccounts[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoanPage(),
                                    ),
                                  );
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  margin: EdgeInsets.only(bottom: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Bank Name
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.account_balance,
                                                    color: Colors.blue),
                                                SizedBox(width: 10),
                                                Text(
                                                  account['bank_name'],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Icon(Icons.arrow_forward_ios,
                                                color: Colors.blue),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        // Interest Schemes
                                        ..._dummyLoanSchemes(),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _dummyLoanSchemes() {
    return [
      _loanTile(Icons.home, "Home Loan", "7.2%"),
      _loanTile(Icons.directions_car, "Car Loan", "9.5%"),
      _loanTile(Icons.school, "Education Loan", "6.8%"),
      _loanTile(Icons.agriculture, "Agricultural Loan", "4.5%"),
      _loanTile(Icons.business, "Business Loan", "10.2%"),
      _loanTile(Icons.credit_card, "Personal Loan", "11.8%"),
    ];
  }

  Widget _loanTile(IconData icon, String loanType, String interestRate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal, size: 20),
          const SizedBox(width: 8),
          Text("$loanType - $interestRate Interest",
              style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        ],
      ),
    );
  }
}

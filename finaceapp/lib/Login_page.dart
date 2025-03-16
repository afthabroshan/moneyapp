// import 'package:flutter/material.dart';
// import 'db_helper.dart';
// import 'usermodel.dart';
// import 'loginpage.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();
//   final TextEditingController BankNameController = TextEditingController();

//   void signUp() async {
//     String name = nameController.text;
//     String email = emailController.text;
//     String password = passwordController.text;
//     int age = int.tryParse(ageController.text) ?? 0;
//     String bankname = BankNameController.text;

//     if (name.isEmpty ||
//         email.isEmpty ||
//         password.isEmpty ||
//         bankname.isEmpty ||
//         age <= 0) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please fill all fields correctly.")),
//       );
//       return;
//     }

//     final user = User(
//         name: name,
//         email: email,
//         password: password,
//         age: age,
//         bankname: bankname,
//         balance: 10000.0);
//     await DatabaseHelper.instance.insertUser(user);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("User registered! Please log in.")),
//     );

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => LoginPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Sign Up")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(labelText: "Name")),
//             TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(labelText: "Email")),
//             TextField(
//                 controller: passwordController,
//                 decoration: InputDecoration(labelText: "Password"),
//                 obscureText: true),
//             TextField(
//                 controller: ageController,
//                 decoration: InputDecoration(labelText: "Age"),
//                 keyboardType: TextInputType.number),
//             TextField(
//                 controller: BankNameController,
//                 decoration: InputDecoration(labelText: "Bank name")),
//             ElevatedButton(onPressed: signUp, child: Text("Sign Up")),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Already have an account? Sign in'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:developer';

// import 'package:financeapp/homepage.dart';
// import 'package:financeapp/SignUp_page.dart';
// import 'package:financeapp/userId.dart';
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// // import 'package:loginuicolors/home.dart';

// class MyLogin extends StatefulWidget {
//   const MyLogin({Key? key}) : super(key: key);

//   @override
//   _MyLoginState createState() => _MyLoginState();
// }

// class _MyLoginState extends State<MyLogin> {
//   bool isChecked = false;
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();

//   final supabase = Supabase.instance.client;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage('assets/login.png'), fit: BoxFit.cover),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: [
//             Container(),
//             Container(
//               padding: EdgeInsets.only(left: 35, top: 230),
//               child: Text(
//                 'Welcome Back to \n Money Map',
//                 style: TextStyle(
//                     color: const Color.fromARGB(255, 0, 0, 0), fontSize: 33),
//               ),
//             ),
//             SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).size.height * 0.5),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(left: 35, right: 35),
//                       child: Column(
//                         children: [
//                           TextField(
//                             controller: email,
//                             style: TextStyle(color: Colors.black),
//                             decoration: InputDecoration(
//                                 fillColor: Colors.grey.shade100,
//                                 filled: true,
//                                 hintText: "Email",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 )),
//                           ),
//                           SizedBox(height: 30),
//                           TextField(
//                             controller: password,
//                             style: TextStyle(),
//                             obscureText: true,
//                             decoration: InputDecoration(
//                                 fillColor: Colors.grey.shade100,
//                                 filled: true,
//                                 hintText: "Password",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 )),
//                           ),
//                           SizedBox(height: 40),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Sign in',
//                                 style: TextStyle(
//                                     fontSize: 27, fontWeight: FontWeight.w700),
//                               ),
//                               CircleAvatar(
//                                 radius: 30,
//                                 backgroundColor: Color(0xff4c505b),
//                                 child: IconButton(
//                                     color: Colors.white,
//                                     onPressed: login,
//                                     icon: Icon(Icons.arrow_forward)),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 40),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => MyRegister()),
//                               );
//                             },
//                             child: Text(
//                               'Sign Up',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                   decoration: TextDecoration.underline,
//                                   color: Color(0xff4c505b),
//                                   fontSize: 18),
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void login() async {
//     try {
//       final response = await supabase
//           .from('users')
//           .select('password, id')
//           .eq('email', email.text.trim())
//           .maybeSingle();
//       log(response.toString());
//       if (response == null) {
//         // No user found
//         log("User not found");
//         return;
//       }
//       final String password2 = password.text.toString();
//       log(password2);
//       final String storedPassword = response['password'];
//       final int userId = response['id'];

//       if (storedPassword != password2) {
//         // Incorrect password
//         log("Invalid password");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Login failed. Please try again.")),
//         );
//         return;
//       } else {
//         UserSession().setUserId(userId);
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => CardWidget()),
//         );
//       }
//     } catch (e) {
//       log(e.toString());
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: ${e.toString()}")),
//       );
//     }
//   }
// }

import 'dart:developer';
import 'package:financeapp/homepage.dart';
import 'package:financeapp/SignUp_page.dart';
import 'package:financeapp/userId.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool isChecked = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final supabase = Supabase.instance.client;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildBackground(),
          _buildLoginForm(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 250),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeText(),
            SizedBox(height: 40),
            _buildTextField(email, "Email"),
            SizedBox(height: 20),
            _buildTextField(password, "Password", isPassword: true),
            SizedBox(height: 30),
            _buildSignInButton(),
            SizedBox(height: 20),
            _buildSignUpButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('assets/money_logo.jpg'),
        ),
        Text(
          'Welcome Back to',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Text(
          'Money Map',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return GestureDetector(
      onTap: isLoading ? null : login,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Color(0xff4c505b),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? CircularProgressIndicator(color: Colors.white)
            : Text(
                'Sign In',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyRegister()),
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 16,
            color: Color(0xff4c505b),
          ),
        ),
      ),
    );
  }

  void login() async {
    setState(() => isLoading = true);

    try {
      final response = await supabase
          .from('users')
          .select('password, id')
          .eq('email', email.text.trim())
          .maybeSingle();

      if (response == null) {
        showSnackBar("User not found. Please sign up.");
        return;
      }

      if (response['password'] != password.text.trim()) {
        showSnackBar("Invalid password. Please try again.");
        return;
      }

      UserSession().setUserId(response['id']);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CardWidget()),
      );
    } catch (e) {
      log(e.toString());
      showSnackBar("An error occurred. Please try again.");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

// // import 'package:financeapp/signuppage.dart';
// // import 'package:flutter/material.dart';
// // import 'db_helper.dart';
// // import 'usermodel.dart';
// // import 'homepage.dart';

// // class LoginPage extends StatefulWidget {
// //   const LoginPage({super.key});

// //   @override
// //   State<LoginPage> createState() => _LoginPageState();
// // }

// // class _LoginPageState extends State<LoginPage> {
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();

// //   void login() async {
// //     String email = emailController.text;
// //     String password = passwordController.text;

// //     User? user = await DatabaseHelper.instance.getUser(email, password);

// //     if (user != null) {
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (context) => Homepage()),
// //       );
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Invalid email or password!")),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Login")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //                 controller: emailController,
// //                 decoration: InputDecoration(labelText: "Email")),
// //             TextField(
// //                 controller: passwordController,
// //                 decoration: InputDecoration(labelText: "Password"),
// //                 obscureText: true),
// //             ElevatedButton(onPressed: login, child: Text("Login")),
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.push(context,
// //                     MaterialPageRoute(builder: (context) => MyLogin()));
// //               },
// //               child: Text('Register'),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:developer';

// import 'package:financeapp/homepage.dart';
// import 'package:financeapp/Login_page.dart';
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class MyRegister extends StatefulWidget {
//   const MyRegister({Key? key}) : super(key: key);

//   @override
//   _MyRegisterState createState() => _MyRegisterState();
// }

// class _MyRegisterState extends State<MyRegister> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   final supabase = Supabase.instance.client;

//   void registerUser() async {
//     try {
//       // Store user details in a separate table
//       await supabase.from('users').insert({
//         // 'id': response.user!.id,
//         'name': nameController.text.trim(),
//         'email': emailController.text.trim(),
//         'password': passwordController.text.trim()
//       });

//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => CardWidget()),
//       );
//     } catch (e) {
//       log(e.toString());
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: ${e.toString()}")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage('assets/register.png'), fit: BoxFit.cover),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         body: Stack(
//           children: [
//             Container(
//               padding: EdgeInsets.only(left: 35, top: 30),
//               child: Text(
//                 'Create\nAccount',
//                 style: TextStyle(color: Colors.white, fontSize: 33),
//               ),
//             ),
//             SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).size.height * 0.28),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(left: 35, right: 35),
//                       child: Column(
//                         children: [
//                           TextField(
//                             controller: nameController,
//                             style: TextStyle(color: Colors.white),
//                             decoration: InputDecoration(
//                                 hintText: "Name",
//                                 hintStyle: TextStyle(color: Colors.white),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 )),
//                           ),
//                           SizedBox(height: 30),
//                           TextField(
//                             controller: emailController,
//                             style: TextStyle(color: Colors.white),
//                             decoration: InputDecoration(
//                                 hintText: "Email",
//                                 hintStyle: TextStyle(color: Colors.white),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 )),
//                           ),
//                           SizedBox(height: 30),
//                           TextField(
//                             controller: passwordController,
//                             style: TextStyle(color: Colors.white),
//                             obscureText: true,
//                             decoration: InputDecoration(
//                                 hintText: "Password",
//                                 hintStyle: TextStyle(color: Colors.white),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 )),
//                           ),
//                           SizedBox(height: 40),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Sign Up',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 27,
//                                     fontWeight: FontWeight.w700),
//                               ),
//                               CircleAvatar(
//                                 radius: 30,
//                                 backgroundColor: Color(0xff4c505b),
//                                 child: IconButton(
//                                     color: Colors.white,
//                                     onPressed: registerUser,
//                                     icon: Icon(Icons.arrow_forward)),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 40),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => MyLogin()),
//                                   );
//                                 },
//                                 child: Text(
//                                   'Sign In',
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                       decoration: TextDecoration.underline,
//                                       color: Colors.white,
//                                       fontSize: 18),
//                                 ),
//                               ),
//                             ],
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
// }

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:financeapp/homepage.dart';
import 'package:financeapp/Login_page.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final supabase = Supabase.instance.client;
  bool isLoading = false;

  void registerUser() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showSnackBar("Please fill all fields");
      return;
    }
    setState(() => isLoading = true);
    try {
      await supabase.from('users').insert({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyLogin()),
      );
    } catch (e) {
      log(e.toString());
      showSnackBar("Error: ${e.toString()}");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildBackground(),
          _buildRegisterForm(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/register.png'),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
        ),
      ),
    );
  }

  Widget _buildRegisterForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 40),
            _buildTextField(nameController, "Name"),
            SizedBox(height: 20),
            _buildTextField(emailController, "Email"),
            SizedBox(height: 20),
            _buildTextField(passwordController, "Password", isPassword: true),
            SizedBox(height: 40),
            _buildSignUpButton(),
            SizedBox(height: 30),
            _buildSignInOption(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('assets/money_logo.jpg'),
        ),
        Text(
          'Create Account',
          style: TextStyle(
              fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          'Start your Money Map journey today!',
          style: TextStyle(fontSize: 18, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return GestureDetector(
      onTap: isLoading ? null : registerUser,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff4c505b), Colors.white10],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? CircularProgressIndicator(color: Colors.white)
            : Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  Widget _buildSignInOption() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyLogin())),
        child: Text(
          'Already have an account? Sign In',
          style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.white70,
              fontSize: 16),
        ),
      ),
    );
  }
}

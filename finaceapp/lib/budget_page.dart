// import 'package:financeapp/groqservices.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// class budgetplan extends StatefulWidget {
//   const budgetplan({super.key});

//   @override
//   State<budgetplan> createState() => budgetplanState();
// }

// class budgetplanState extends State<budgetplan> {
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   bool _loading = false;
//   List<Map<String, String>> _messages = [];

//   // Function to send message to GroqAIService and get response
//   Future<void> sendMessage() async {
//     if (_controller.text.isEmpty) return;

//     setState(() {
//       _messages.add({'type': 'user', 'message': _controller.text});
//       _loading = true;
//     });

//     String prompt = _controller.text;
//     _controller.clear();

//     try {
//       final response = await GroqAIService.processPrompt(prompt);
//       String aiResponse = response['response'] ?? "";

//       setState(() {
//         _messages.add({'type': 'ai', 'message': aiResponse});
//         _loading = false;
//       });

//       // Scroll to the latest message
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       setState(() {
//         _loading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     }
//   }

//   Widget buildMessageBubble(Map<String, String> message) {
//     bool isUser = message['type'] == 'user';
//     return Align(
//       alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//         decoration: BoxDecoration(
//           color: isUser ? Colors.blue[300] : Colors.grey[200],
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(15),
//             topRight: Radius.circular(15),
//             bottomLeft: isUser ? Radius.circular(15) : Radius.circular(0),
//             bottomRight: isUser ? Radius.circular(0) : Radius.circular(15),
//           ),
//         ),
//         child: Text(
//           message['message'] ?? '',
//           style: TextStyle(
//             color: isUser ? Colors.white : Colors.black,
//             fontSize: 14,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       // appBar: AppBar(title: Text('AI Chat')),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 return buildMessageBubble(_messages[index]);
//               },
//             ),
//           ),
//           if (_loading)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Shimmer.fromColors(
//                     baseColor: const Color.fromARGB(255, 16, 15, 15)!,
//                     highlightColor: Colors.grey[100]!,
//                     child: Row(
//                       children: [
//                         Container(
//                           height: 14,
//                           width: 14,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Text(
//                           "Let me think..",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[300],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Ask something...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                       contentPadding: EdgeInsets.symmetric(
//                         vertical: 10,
//                         horizontal: 15,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 GestureDetector(
//                   onTap: sendMessage,
//                   child: CircleAvatar(
//                     radius: 25,
//                     backgroundColor: Color.fromARGB(192, 68, 137, 255),
//                     child: Icon(Icons.send, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:financeapp/groqservices.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class budgetplan extends StatefulWidget {
  const budgetplan({super.key});

  @override
  State<budgetplan> createState() => _budgetplanState();
}

class _budgetplanState extends State<budgetplan> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;
  List<Map<String, String>> _messages = [];

  Future<void> sendMessage() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add({'type': 'user', 'message': _controller.text});
      _loading = true;
    });

    String prompt = _controller.text;
    _controller.clear();

    try {
      final response = await GroqAIService.processPrompt(prompt);
      String aiResponse = response['response'] ?? "";

      setState(() {
        _messages.add({'type': 'ai', 'message': aiResponse});
        _loading = false;
      });

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Widget buildMessageBubble(Map<String, String> message) {
    bool isUser = message['type'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft:
                isUser ? const Radius.circular(15) : const Radius.circular(0),
            bottomRight:
                isUser ? const Radius.circular(0) : const Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 5,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Text(
          message['message'] ?? '',
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget buildLoadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[700]!,
            highlightColor: Colors.grey[400]!,
            child: Row(
              children: [
                for (int i = 0; i < 3; i++) ...[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Center(
            child: Text(
          "Budget Chat",
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Color(0xFF1E1E2C),
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
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E1E2C), Color(0xFF2D2D44)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return buildMessageBubble(_messages[index]);
                  },
                ),
              ),
              if (_loading) buildLoadingIndicator(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: TextField(
                          controller: _controller,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Ask something...',
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: sendMessage,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueAccent.withOpacity(0.9),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.send,
                            color: Colors.white, size: 24),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:flutter/foundation.dart';

// class GroqAIService {
//   static const String apiKey =
//       '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';
//   static const String endpoint =
//       'https://api.groq.com/openai/v1/chat/completions';

//   static const String userDetails =
//       "my name is XYZ, I am working in bilbalo, my age is 25";

//   // Function to process a prompt
//   static Future<Map<String, dynamic>> processPrompt(String prompt) async {
//     return await runGeneral(prompt);
//     // final route = await routePrompt(prompt);
//     // debugPrint('Route identified: $route');

//     // if (route == "ADD tool needed") {
//     //   return await runAddMeeting(prompt);
//     // } else if (route == "USER_HISTORY tool needed") {
//     //   return await runUserHistory(prompt);
//     // } else {
//     //   return await runGeneral(prompt);
//     // }
//   }

//   // Route prompt to determine if a tool is needed
//   static Future<String> routePrompt(String prompt) async {
//     final routingPrompt = """
//     Given the following user prompt, determine if it is a normal conversation or if it requires a tool to answer it.
//     If an add-to-database tool is needed, respond with 'TOOL: ADD'.
//     If the prompt is about users past, history, user profile etc such as who am i, respond with 'TOOL: USER_HISTORY'.
//     If no tools are needed and the conversation is casual, respond with 'NO TOOL'.

//     User prompt: $prompt

//     Response:
//     """;
//     log(routingPrompt);
//     final body = {
//       "model": "llama3-8b-8192",
//       "messages": [
//         {
//           "role": "system",
//           "content":
//               "You're a routing assistant. Determine if tools are needed based on the user query."
//         },
//         {"role": "user", "content": routingPrompt}
//       ],
//       "max_tokens": 20
//     };

//     final response = await _postToAPI(body);
//     final routingDecision =
//         response['choices'][0]['message']['content']?.trim();
//     log(routingDecision);
//     if (routingDecision.contains("TOOL: USER_HISTORY")) {
//       return "USER_HISTORY tool needed";
//     } else if (routingDecision.contains("TOOL: ADD")) {
//       return "ADD tool needed";
//     } else {
//       return "no tool needed";
//     }
//   }

//   // Run the add meeting tool
//   static Future<Map<String, dynamic>> runAddMeeting(String prompt) async {
//     final body = {
//       "model": "llama3-8b-8192",
//       "messages": [
//         {
//           "role": "system",
//           "content":
//               "You are a content extraction assistant. Extract the Date (in DD-MM-YYYY format), Subject, and with_whom from the following text as a JSON object. After extraction, use the upload function."
//         },
//         {"role": "user", "content": prompt}
//       ],
//       "tools": [
//         {
//           "type": "function",
//           "function": {
//             "name": "upload",
//             "description": "Adds a value into the database",
//             "parameters": {
//               "type": "object",
//               "properties": {
//                 "date": {
//                   "type": "string",
//                   "description": "The date from the prompt in DD-MM-YYYY"
//                 },
//                 "subject": {
//                   "type": "string",
//                   "description": "The description of what the prompt is about"
//                 },
//                 "with_whom": {
//                   "type": "string",
//                   "description": "People involved"
//                 }
//               },
//               "required": ["date", "subject", "with_whom"]
//             }
//           }
//         }
//       ],
//       "tool_choice": "auto",
//       "max_tokens": 100
//     };

//     final response = await _postToAPI(body);
//     final responseMessage = response['choices'][0]['message'];
//     final toolCalls = responseMessage['tool_calls'];

//     if (toolCalls != null && toolCalls.isNotEmpty) {
//       for (var toolCall in toolCalls) {
//         if (toolCall['function']['name'] == "upload") {
//           final arguments = jsonDecode(toolCall['function']['arguments']);
//           final uploadResult = upload(arguments);
//           return {
//             "prompt": prompt,
//             "route": "ADD tool needed",
//             "response": uploadResult
//           };
//         }
//       }
//     }

//     return {
//       "prompt": prompt,
//       "route": "ADD tool needed",
//       "response": responseMessage['content']
//     };
//   }

//   // Upload function (dummy implementation)
//   static String upload(Map<String, dynamic> query) {
//     final date = query["date"] ?? "Unknown date";
//     final subject = query["subject"] ?? "";
//     final withWhom = query["with_whom"] ?? "unknown people";
//     final result =
//         "-- Appointment with $withWhom on $date about $subject has been uploaded successfully";
//     debugPrint(result);
//     return result;
//   }

// // Run user history tool
//   static Future<Map<String, dynamic>> runUserHistory(String prompt) async {
//     // Simulating a user history retrieval
// //     final userHistory = {
// //       "user_name": "John Doe",
// //       "history": [
// //         {"date": "12-01-2025", "activity": "Logged in to the system"},
// //         {"date": "10-01-2025", "activity": "Updated profile details"},
// //         {"date": "05-01-2025", "activity": "Added a new appointment"}
// //       ]
// //     };

// //     // Extract the details the user asked for (e.g., history of activities)
// //     final historyQuery = prompt.toLowerCase();
// //     log(historyQuery);
// //     log(userHistory['history'].runtimeType.toString());

// //     // Safely cast the history to a List<Map<String, dynamic>>
// //     final List<Map<String, String>> historyList =
// //         (userHistory['history'] as List).cast<Map<String, String>>();
// //     log(historyList.toString());
// // // Filter the relevant activities based on the query
// //     final relevantHistory = historyList
// //         .where((activity) => activity['activity']!
// //             .toLowerCase()
// //             .contains(historyQuery.toLowerCase()))
// //         .toList();
// //     log("this is the 350 ${relevantHistory.toString()}");
//     final body = {
//       "model": "llama3-8b-8192",
//       "messages": [
//         {
//           "role": "system",
//           "content":
//               "You're to extract the user information from the user prompt and the provided user details. only answer within the context and do not answer anything that is outside the user context. user context: $userDetails"
//         },
//         {"role": "user", "content": prompt}
//       ]
//     };

//     final response = await _postToAPI(body);
//     return {
//       "prompt": prompt,
//       "route": "USER_HISTORY tool needed",
//       "response": response['choices'][0]['message']['content']
//     };
//     // return {
//     //   "prompt": prompt,
//     //   "route": "USER_HISTORY tool needed",
//     //   "response": {
//     //     "user": userHistory['user_name'],
//     //     "relevant_activity": relevantHistory
//     //   }
//     // };
//   }

//   // Handle general queries
//   static Future<Map<String, dynamic>> runGeneral(String prompt) async {
//     final body = {
//       "model": "llama3-8b-8192",
//       "messages": [
//         {"role": "system", "content": "You are a helpful assistant."},
//         {"role": "user", "content": prompt}
//       ]
//     };

//     final response = await _postToAPI(body);
//     return {
//       "prompt": prompt,
//       "route": "no tool needed",
//       "response": response['choices'][0]['message']['content']
//     };
//   }

//   // Helper function to post to the API
//   static Future<Map<String, dynamic>> _postToAPI(
//       Map<String, dynamic> body) async {
//     try {
//       final url = Uri.parse(endpoint);
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $apiKey',
//         },
//         body: jsonEncode(body),
//       );

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception(
//             'API call failed with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error in API call: $e');
//       rethrow;
//     }
//   }
// }
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class GroqAIService {
  static const String apiKey =
      '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';
  static const String endpoint =
      'https://api.groq.com/openai/v1/chat/completions';

  static Future<Map<String, dynamic>> processPrompt(String prompt) async {
    return await runGeneral(prompt);
  }

  static Future<Map<String, dynamic>> runGeneral(String prompt) async {
    final body = {
      "model": "llama3-8b-8192",
      "max_tokens": 100, // Limits response length
      "messages": [
        {
          "role": "system",
          "content": """
You are an Indian financial expert specializing in **budgeting, loan recommendations, and financial well-being**. You **must** provide short, precise, and actionable responses.

User Query: "${prompt}"

Your Response Should:
- Offer **clear financial advice** tailored to the user's question.
- Suggest **loan options** (interest rates, tenure, eligibility) if applicable.
- Provide **budgeting strategies** and **investment tips** when relevant.
- Stay within finance-related topics. **If the query is unrelated, politely decline.**
- Keep responses **short and to the point (max 100 tokens)**.
"""
        },
        {"role": "user", "content": prompt}
      ]
    };

    final response = await _postToAPI(body);
    return {
      "prompt": prompt,
      "response": response['choices'][0]['message']['content']
    };
  }

  static Future<Map<String, dynamic>> _postToAPI(
      Map<String, dynamic> body) async {
    try {
      final url = Uri.parse(endpoint);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'API call failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error in API call: $e');
      rethrow;
    }
  }
}

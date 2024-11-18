import 'dart:convert';
import 'dart:io';
import 'package:Smart_pluts/constants/constants.dart';
import 'package:http/http.dart' as http;

Future<void> main(List<String> arg) async {
  stdout.writeln('What do you like to ask?');
  final prompt = stdin.readLineSync();
  if (prompt != null) print(await callChatGPT(prompt));
}

Future<String?> callChatGPT(String prompt) async {
  const apiKey = Openai_Key;
  const apiUrl = Chat_gpt_url;

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey'
  };

  final body = jsonEncode(
    {
      "model": Model,
      
      "messages": [
            {
                "role": "system",
               "content": "You are a helpful assistant."
            },
            {
                "role": "user",
                "content": "what is the tomatoes price if it grow up in Lebanon al Bikaa in green hous ."
            }
        ]
    },
  );
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      print("#######################################");
      final jsonResponse = jsonDecode(response.body);
      final result = jsonResponse['choices'][0]['message']["content"];
      print("chatgpt: $result");
      return result;
    } else {
      print(
        'Failed to call ChatGPT API: ${response.statusCode} ${response.body}',
      );
      return null;
    }
  } catch (e) {
    print("Error calling ChatGPT API: $e");
    return null;
  }
}
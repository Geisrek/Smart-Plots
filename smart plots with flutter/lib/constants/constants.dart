import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String IP='192.168.1.9';
const String Openai_Key='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';
const String Chat_gpt_url="https://api.openai.com/v1/chat/completions";
const String Model="gpt-4o-mini";
final Map<String,List<String>> cities={
   "Lebanon":["Saida","Beirut","Tyre","Tripoli","Byblos","Bekaa","Mount Lebanon","El Chouf"],

   "Syria":["Damascus","Aleppo","Homs","Deir ez-Zor","Suwayda","Al Hasakah","Delicacy","Al-Zabadani","Tartous"
   ,"Albukamal","Al-Shaghour"],

   "KSA":["Riyadh","Al-Medina","Macca","Jeddah","Der'aiyah"],

   "UAE":["Abu Dhabi","Al Ain","Sharja"],

   "Iraq":["Baghdad","Al-Najaf","Karbala","Ramadi","Fallujah","Sulaymaniyah","Kirkuk","Anbar","Mosul"
   ,"Tikrit","Nineveh","Basra","Wasta","Dhi-Qar"]
  };
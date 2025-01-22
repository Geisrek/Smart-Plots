import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String IP='192.168.1.6';
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
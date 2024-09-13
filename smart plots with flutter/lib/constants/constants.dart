import 'package:shared_preferences/shared_preferences.dart';

const String IP='192.168.1.7';
Future<int> getIntegerFromPrefernces(String name)async{
 SharedPreferences Infos= await SharedPreferences.getInstance();
  return await Infos.getInt(name)??0;
}

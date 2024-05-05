import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
   PasswordInput({super.key});
  final state=_PasswordInput();
  @override
  State<PasswordInput> createState() => state;
  String getText(){
    return state.getText();
  }
}

class _PasswordInput extends State<PasswordInput> {
  bool _passwordVisible = false;
  final TextEditingController _textController = TextEditingController();
  @override
  void dispose() {
    _textController.dispose(); 
    super.dispose();
  }
  String getText(){
    return _textController.text;
  }
  @override
  Widget build(BuildContext context) {
    return  Container(child:TextFormField(
      
      controller: _textController,
      obscureText: !_passwordVisible, 
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7),),
        labelText: 'Password',
        labelStyle: TextStyle(fontFamily: 'Nunito',fontSize: 18),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              //print("------------------------");
             //  print(_textController.text);
              // print(" <------------");
              _passwordVisible = !_passwordVisible; // Toggle state
            });
          },
        ),
      ),
    ),height: 48,width: 300,);
  }
}
class InputText extends StatelessWidget {
  InputText({super.key});
  final TextEditingController TextValue =TextEditingController();
  String getText(){
    return TextValue.text;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(width: 300,
    height: 48
      ,child: TextFormField(
      controller: TextValue,
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(fontFamily: 'Nunito',fontSize: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7))),
    ),) ;
  }
}
import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => _PasswordInput();
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
class MyWidget extends StatelessWidget {
  final String text;
  MyWidget({super.key,required this.text});
  final TextEditingController TextValue =TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Container() ;
  }
}
import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
   PasswordInput({super.key});
  final state=_PasswordInput();
   String getText(){

    return state._textController.text;
  }
  @override
  State<PasswordInput> createState() => state;
 
}

class _PasswordInput extends State<PasswordInput> {
  bool _passwordVisible = false;
  final TextEditingController _textController = TextEditingController();
  @override
  void dispose() {
    _textController.dispose(); 
    super.dispose();
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
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    ),height: 48,width: 300,);
  }
   
}
class InputText extends StatelessWidget {
  String text;
  double width;
  InputText({super.key,required this.text,this.width=300});
  final TextEditingController TextValue =TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
    return Container(width: this.width,
    height: 48
      ,child: TextFormField(
      controller: TextValue,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(fontFamily: 'Nunito',fontSize: 18,fontFamilyFallback: ['Nunito', 'Arial', 'sans-serif']),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7))),
    ),) ;
  }
 String getText(){
    return TextValue.text;
  }
}

class InputTextR extends StatefulWidget {
  String text;
  double width;
  dynamic onChanged;
  InputTextR({super.key,required this.text,this.width=300, this.onChanged=""});
  
  @override
  State<InputTextR> createState() => _InputTextRState();
}

class _InputTextRState extends State<InputTextR> {
   final TextEditingController TextValue =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Container(width: widget.width,
    height: 48
      ,child: TextFormField(
        onChanged: widget.onChanged,
      controller: TextValue,
      decoration: InputDecoration(
        labelText: widget.text,
        labelStyle: TextStyle(fontFamily: 'Nunito',fontSize: 18,fontFamilyFallback: ['Nunito', 'Arial', 'sans-serif']),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7))),
    ),) ;
  }
  String getText(){
    return TextValue.text;
  }
}
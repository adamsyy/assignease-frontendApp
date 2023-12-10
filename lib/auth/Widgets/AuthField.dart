import 'package:asignease/Controller.dart';
import 'package:flutter/material.dart';



import 'package:flutter/material.dart';

Controller globals = new Controller();
class Authfield extends StatefulWidget {
  final String hint;
  final Function(String) onChanged;

  Authfield({required this.hint, required this.onChanged});

  @override
  _AuthfieldState createState() => _AuthfieldState();
}

class _AuthfieldState extends State<Authfield> {
  bool _isObscure = true;

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 325,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(231, 235, 243, 1),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(  onChanged: widget.onChanged,
        obscureText: _isObscure && widget.hint == 'Password'||_isObscure && widget.hint == 'Confirm password',
        style: TextStyle(
          color: globals.text_darkblue,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: 'Urbanist',
        ),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: globals.button_purple_shade,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: globals.text_lightgrey,
            fontWeight: FontWeight.w900,
            fontSize: 12,
            fontFamily: 'Urbanist',
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(20, 17, 20, 17),
          suffixIcon: widget.hint == 'Password'||widget.hint == 'Confirm password'
              ? GestureDetector(
            onTap: _toggleObscure,
            child: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
              color: globals.text_lightgrey,
            ),
          )
              : null,
        ),
      ),
    );
  }
}

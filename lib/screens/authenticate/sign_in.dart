import 'package:flutter/material.dart';
import 'package:yabber/services/auth.dart';
import 'package:yabber/models/Constants.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  const SignIn({Key? key,  required this.toggleView }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Text field state
  String email = '';
  String password = '';
  String error = '';
  bool _rememberMe = false;

  Widget _buildEmailTf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: kLabelStyle
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: (dynamic value) => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value) ? null : "Please enter a valid email.",
            onChanged: (value) => {
              setState(() => email = value)
            },
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans'
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPasswordTf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: kLabelStyle
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: (dynamic value) => value.length < 6 ? "Your password will be atleast 6 characters long." : null,
            onChanged: (value) => {
              setState(() => password = value)
            },
            obscureText: true,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans'
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle
            ),
          ),
        )
      ],
    );
  }

  Widget _buildForgotPasswordButton() {
    return  Container(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () => print('Forgot Password button pressed'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(right: 0.0),
          elevation: 0.0,
            primary: Colors.pink.withOpacity(0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(2),
              ),
            ),
        ),
        child: const Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      )
    );
  }

  Widget _buildRememberMeCheckbox() {
    return SizedBox(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: const Color(0xFFE91E63),
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          const Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()){
            dynamic result = await _auth.signInWithEmailAndPassword(email, password);
            if (result == null){
              setState(() => error = 'Oops something went wrong.');
            }  
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          primary: Colors.white,
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: const Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFFE91E63),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
  
  Widget _buildContinueAsGuestButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          dynamic result = await _auth.signInAnon();
            if (result == null){
              setState(() => error = 'Oops something went wrong.');
            }
          },
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          primary: Colors.white,
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: const Text(
          'CONTINUE AS GUEST',
          style: TextStyle(
            color: Color(0xFFE91E63),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap:() {
        widget.toggleView();
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF48FB1),
                Color(0xFFF06292),
                Color(0xFFEC407A),
                Color(0xFFE91E63),
              ],
              stops: [0.1, 0.4, 0.7, 0.9]
            )
          )
        ),
        SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 120.0
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  _buildEmailTf(),
                  const SizedBox(height: 30.0),
                  _buildPasswordTf(),
                  _buildForgotPasswordButton(),
                  _buildRememberMeCheckbox(),
                  _buildLoginBtn(),
                  const Text(
                    '- OR -',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  _buildContinueAsGuestButton(),
                  _buildSignupBtn(),
                  const SizedBox(height: 12.00),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.white, fontSize: 14.0),
                  )
                ],
              ),
            )
          )
        )
      ],),
    );
  }
}
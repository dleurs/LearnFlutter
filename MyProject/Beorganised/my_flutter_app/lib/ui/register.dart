import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app/models/loading.dart';
import 'package:my_flutter_app/utils/auth.dart';
import 'package:my_flutter_app/utils/validator.dart';

import 'package:my_flutter_app/models/user.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pseudo = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final loading = Provider.of<Loading>(context);

    final pseudo = TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      controller: _pseudo,
      validator: Validator.validatePseudo,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.person,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Pseudo',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _email,
      validator: Validator.validateEmail,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.email,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _password,
      validator: Validator.validatePassword,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.lock,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final signUpButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          _emailSignUp(
              user: user,
              loading: loading,
              pseudo: _pseudo.text,
              email: _email.text,
              password: _password.text,
              context: context);
        },
        padding: EdgeInsets.all(12),
        color: Theme.of(context).primaryColor,
        child: Text('REGISTER', style: TextStyle(color: Colors.white)),
      ),
    );

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                pseudo,
                SizedBox(height: 24.0),
                email,
                SizedBox(height: 24.0),
                password,
                signUpButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _emailSignUp(
      {User user,
      Loading loading,
      String pseudo,
      String email,
      String password,
      BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      loading.switchLoading();
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        //need await so it has chance to go through error if found.
        if (user != null && user.isAnonymous) { // user != null should implies here that user.isAnonymous
          print("Anonymous user convert email");
          await AuthService.convertFromAnonToEmail(
              pseudo: pseudo, email: email, password: password);
          user.updateUser();
        } else {
          print("No anonymous user create account");
          await AuthService.registerWithEmail(
              pseudo: pseudo, email: email, password: password);
            print("ok");
          //user.updateUser();
        }
        loading.switchLoading();
      } catch (e) {
        loading.switchLoading();
        print("ok");
        print("Sign Up Error: $e");
        String exception = AuthService.getExceptionText(e);
        print(exception);
        Flushbar(
          title: "Sign Up Error",
          message: exception,
          duration: Duration(seconds: 5),
        )..show(context);
        //String exception = AuthService.getExceptionText(e);
      }
    }
  }
}

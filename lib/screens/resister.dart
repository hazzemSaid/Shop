import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shop/screens/phoneScreen.dart';

import '../cubit/auth-cubit/auth_cubit.dart';
import '/screens/customebutton.dart';
import '/screens/cutometextfild.dart';

class resister extends StatelessWidget {
  @override
  String? Email;
  String? username;
  String? pass;

  bool loading = false;

//using key to validate the form and save the data
//using email and password to store the data
//key show the error if the user enter the wrong data
  GlobalKey<FormState> form_key = GlobalKey();

  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is emailAuthCreate_loading) {
          loading = true;
        } else if (state is emailAuthCreate_success) {
          loading = false;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Phonescreen()));
        } else if (state is emailAuthCreate_failed) {
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${state.error}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: loading,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 82, 28, 188),
              title: Container(
                  child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      'Shop App',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Form(
                key: form_key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(children: [
                        Image.asset('assets/images/Shop App.png'),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                    ),
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(7),
                            child: Text('Resister',
                                style: TextStyle(fontSize: 30))),
                      ],
                    ),
                    fild(
                        type: 'username',
                        onchanged: (val) {
                          username = val;
                        }),
                    SizedBox(
                      height: 5,
                    ),
                    fild(
                        onchanged: (value) {
                          Email = value;
                        },
                        type: "Email"),
                    SizedBox(
                      height: 10,
                    ),
                    fild(
                        onchanged: (value) {
                          pass = value;
                        },
                        type: "Password"),
                    SizedBox(
                      height: 10,
                    ),
                    custombutton(
                        onTap: () {
                          if (form_key.currentState!.validate()) {
                            form_key.currentState!.save();
                            //it is work
                            BlocProvider.of<AuthCubit>(context)
                                .createAccount(email: Email!, password: pass!);
                          }
                        },
                        type: "Resister"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (' Already have an account?'),
                          style: TextStyle(fontSize: 15),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/Sign_up');
                          },
                          child: Text("sign in",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blue[900])),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

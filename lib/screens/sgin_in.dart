import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shop/cubit/apiCubit/apicubit_cubit.dart';
import 'package:shop/screens/AllCategory.dart';
import 'package:shop/screens/resister.dart';

import '/screens/customebutton.dart';
import '/screens/cutometextfild.dart';
import '../cubit/auth-cubit/auth_cubit.dart';

class Sign_up extends StatelessWidget {
  String? email;
  bool loading = false;
  String? password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // Sign_up({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is emailAuthSignIn_loading) {
          loading = true;
        } else if (state is emailAuthSignIn_success) {
          loading = false;
          BlocProvider.of<ApiCubit>(context).getAllCategory();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AllCategory()));
        } else if (state is emailAuthSignIn_failed) {
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
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
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(children: [
                        Image.asset('assets/images/Shop App.png'),
                        SizedBox(
                          height: 10,
                        ),
                      ]),
                    ),
                    Row(
                      children: [
                        Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    fild(
                        onchanged: (value) {
                          email = value;
                        },
                        type: "Username"),
                    SizedBox(
                      height: 10,
                    ),
                    fild(
                        onchanged: (value) {
                          password = value;
                        },
                        type: "Password"),
                    SizedBox(
                      height: 10,
                    ),
                    custombutton(
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            //bloc provider trager
                            BlocProvider.of<AuthCubit>(context)
                                .signIn(email: email!, password: password!);
                          }
                        },
                        type: "Sign up"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ('don\'t have an account?'),
                          style: TextStyle(fontSize: 15),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => resister()));
                          },
                          child: Text("Resister",
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






/*
class sign_up extends StatefulWidget {
  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  @override
 
  Widget build(BuildContext context) {
   
  }
}
*/
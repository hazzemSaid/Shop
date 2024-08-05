import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shop/cubit/auth-cubit/auth_cubit.dart';
import 'package:shop/screens/cutometextfild.dart';

import '/screens/OTP.dart';
import '/screens/customebutton.dart';

class Phonescreen extends StatelessWidget {
  String? phone;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: loading,
          child: Scaffold(
              body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Image.asset('assets/images/Shop App.png'),
              ),
              Expanded(
                  child: Column(
                children: [
                  fild(
                    type: "phoneNumber",
                    onchanged: (val) {
                      phone = val;
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: custombutton(
                          type: 'done',
                          onTap: () async {
                            //blocprovider phone auth
                            BlocProvider.of<AuthCubit>(context).sendOTP(phone!);
                          },
                        ),
                      )),
                ],
              ))
            ],
          )),
        );
      },
      listener: (context, state) {
        if (state is phoneverifyPhoneNumber_loading) {
          loading = true;
        } else if (state is phoneverifyPhoneNumber_success) {
          loading = false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTP(),
            ),
          );
        } else if (state is phoneverifyPhoneNumber_error) {
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "${state.error}",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },
    );
  }
}

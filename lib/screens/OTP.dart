import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shop/cubit/auth-cubit/auth_cubit.dart';
import 'package:shop/screens/product_item.dart';
import 'package:shop/screens/cutometextfild.dart';

import 'customebutton.dart';

class OTP extends StatelessWidget {
  @override
  bool loading = false;
  String? otp;
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
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
                  type: "OTP",
                  onchanged: (val) {
                    otp = val;
                  },
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: custombutton(
                        type: 'done',
                        onTap: () async {
                          //blocprovider phone auth
                          await BlocProvider.of<AuthCubit>(context)
                              .verifyOTP(otp!);
                        },
                      ),
                    )),
              ],
            ))
          ],
        )),
      );
    }, listener: (context, state) {
      if (state is phoneSignInWithPhoneAuthCredential_loading) {
        loading = true;
      } else if (state is phoneSignInWithPhoneAuthCredential_success) {
        loading = false;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => product_item(),
          ),
        );
      } else if (state is phoneSignInWithPhoneAuthCredential_failed) {
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
    });
  }
}

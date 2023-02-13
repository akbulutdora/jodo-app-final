import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jodo_app/repo/auth_repository.dart';
import 'package:jodo_app/routes/authentication/signin_cubit/signin_cubit.dart';
import 'package:jodo_app/util/action_status.dart';
import 'package:jodo_app/util/colors.dart';
import 'package:jodo_app/util/dimensions.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: AppColors.notesPrimaryColor,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: BlocProvider(
            create: (context) => SigninCubit(
                authenticationRepository: context.read<AuthRepository>()),
            child: BlocConsumer<SigninCubit, SigninState>(
              listener: (context, state) {
                if (state.status == ActionStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage.isEmpty
                            ? 'Sign Up Failure'
                            : state.errorMessage),
                      ),
                    );
                  context.read<SigninCubit>();
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kHorizontalPadding,
                    vertical: kVerticalPadding,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const Text("Jodo App",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.notesPrimaryColor,
                          )),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextFormField(
                        onChanged: (email) {
                          context.read<SigninCubit>().emailChanged(email);
                        },
                        cursorColor: AppColors.notesPrimaryColor,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              AppColors.notesPrimaryColor.withOpacity(0.3),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(height: kVerticalPadding),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextFormField(
                        onChanged: (password) {
                          context.read<SigninCubit>().passwordChanged(password);
                        },
                        obscureText: true,
                        cursorColor: AppColors.notesPrimaryColor,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              AppColors.notesPrimaryColor.withOpacity(0.3),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(height: kVerticalPadding),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (state.status == ActionStatus.submitting) {
                              return;
                            }
                            context.read<SigninCubit>().submitSignup();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.notesPrimaryColor,
                          ),
                          child: state.status == ActionStatus.submitting
                              ? const SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Sign Up'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

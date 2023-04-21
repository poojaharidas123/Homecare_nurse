import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homecare_nurse/ui/widgets/custom_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../blocs/auth/sign_in/sign_in_bloc.dart';
import '../../util/value_validators.dart';
import '../../values/values.dart';
import '../widgets/custom_alert_dialog.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (Supabase.instance.client.auth.currentUser != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE3F3DF),
      body: BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(),
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInFailureState) {
              showDialog(
                context: context,
                builder: (context) => const CustomAlertDialog(
                  title: 'Failed',
                  message:
                      'Please check your email and password and try again.',
                  primaryButtonLabel: 'Ok',
                  secondaryButtonLabel: 'Cancel',
                ),
              );
            } else if (state is SignInSuccessState) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (p) => true,
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "HomeCare",
                              style: GoogleFonts.dynalight(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: primaryColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Sign In",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: emailValidator,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: isObscure,
                      validator: (value) {
                        if (value != null && value.trim().isNotEmpty) {
                          return null;
                        } else {
                          return 'Enter password';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(
                          Icons.lock_outlined,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            isObscure = !isObscure;
                            setState(() {});
                          },
                          icon: Icon(
                            isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      label: 'Login',
                      buttonColor: Color(0xFFAAD013),
                      textColor: Colors.white,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<SignInBloc>(context).add(
                            SignInEvent(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                      isLoading: state is SignInLoadingState,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

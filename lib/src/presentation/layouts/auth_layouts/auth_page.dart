import 'package:flutter/material.dart';
import 'package:piece_autos/src/presentation/layouts/auth_layouts/widget/sign_in_form.dart';
import 'package:piece_autos/src/presentation/layouts/auth_layouts/widget/sign_up_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SignInForm(),  
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SignUpForm(),
          ),
        ],
      ),
    );
  }
}

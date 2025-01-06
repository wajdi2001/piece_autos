import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/src/presentation/layouts/auth_layouts/widget/sign_in_form.dart';
import 'package:piece_autos/src/presentation/layouts/auth_layouts/widget/sign_up_form.dart';

import '../../../../core/services/injection_container.dart';
import '../../controllers/auth_bloc/auth_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => sl<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.loaded) {
            _showCustomDialog(
              context: context,
              title: "Success",
              message: state.message,
              color: Colors.green,
            );
          } else if (state.status == AuthStatus.error) {
            _showCustomDialog(
              context: context,
              title: "Error",
              message: state.message,
              color: Colors.red,
            );
          }
        },
        child: Padding(
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
        ),
      ),
    );
  }
  void _showCustomDialog({
    required BuildContext context,
    required String title,
    required String message,
    required Color color,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: color),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

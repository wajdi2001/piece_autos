import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/src/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:piece_autos/src/presentation/layouts/auth_layouts/widget/custom_text_field.dart';

class SignUpForm extends StatelessWidget {
   SignUpForm({super.key});
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  TextEditingController nameController= TextEditingController();
  TextEditingController phoneController= TextEditingController();
  TextEditingController confirmPasswordController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Créer un compte",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 16),
             CustomTextField(label: "Nom*", controller: nameController),
             CustomTextField(label: "Email*", controller: emailController),
             CustomTextField(label: "Tel*", controller: phoneController),
             CustomTextField(label: "Mot de passe", isPassword: true, controller: passwordController),
             CustomTextField(label: "Confirmer mot de passe", isPassword: true, controller: confirmPasswordController),
            ElevatedButton(
              onPressed: () 
              {
                context.read<AuthBloc>().add(AuthSignupEvent(email: emailController.text, password: passwordController.text, name: nameController.text, phoneNumber: phoneController.text,));
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text("S'inscrire"),
            ),
          ],
        ),
      ),
    );
  }
}
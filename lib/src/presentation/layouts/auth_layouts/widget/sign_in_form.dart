import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/src/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:piece_autos/src/presentation/layouts/auth_layouts/widget/custom_text_field.dart';

class SignInForm extends StatelessWidget {
   SignInForm({super.key});
   TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();

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
              "Connectez-vous",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 16),
             CustomTextField(label: "Email",controller: emailController,),
             CustomTextField(label: "Mot de passe", isPassword: true, controller: passwordController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (value) {}),
                    const Text("Rappelez-moi"),
                  ],
                ),
                TextButton(
                  onPressed: () 
                  {
                  },
                  child: const Text("mot de passe oublié?"),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () 
              {
                                    context.read<AuthBloc>().add(AuthLoginEvent(email: emailController.text, password: passwordController.text,rememberMe: true ));

              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text("Se connecter"),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.facebook),
              label: const Text("Continuer avec Facebook"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.g_mobiledata),
              label: const Text("Continuer avec Google"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/src/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:piece_autos/src/presentation/layouts/auth_layouts/widget/custom_text_field.dart';
import 'package:piece_autos/src/presentation/shared/constants/app_colors.dart';

class SignInForm extends StatelessWidget {
   SignInForm({super.key});
   TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
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
                if(emailController.text.isEmpty && passwordController.text.isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Veuillez remplir les champs"),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                }else 
                {
                  
                  context.read<AuthBloc>().add(AuthLoginEvent(email: emailController.text, password: passwordController.text,rememberMe: true ));
                  emailController.clear();
                  passwordController.clear();
                }
                                    

              },
              style: ElevatedButton.styleFrom(
                backgroundColor:emailController.text.isEmpty && passwordController.text.isEmpty? Colors.grey:AppColors.primaryButtonColor,
                overlayColor:Colors.blue,
                
                minimumSize: const Size(double.infinity, 48),
              ),
              child:  Text("Se connecter",style: TextStyle(color: emailController.text.isEmpty && passwordController.text.isEmpty? Colors.white:AppColors.primaryButtonColor),),
            ),
            const SizedBox(height: 16),
            
          ],
        ),
      ),
    );
  }
}

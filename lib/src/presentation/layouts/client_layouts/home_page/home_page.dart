import 'package:flutter/material.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/home_page/widgets/home_app_bar_widget.dart';
import 'package:piece_autos/src/presentation/shared/constants/app_colors.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
        
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/mechanical_back.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: 
            [
              
              HomeAppBarWidget(),
              SizedBox(height: 20,),
              Column(
                children: 
                [
                  Image.network('http://192.168.1.182:8080/app/uploads/Brand/95fbaba1-e4e6-42b1-976a-2d4a8ce689e3_client.png'),
                  Column(
                    spacing: 5,
                    children: [
                       Text(
                      'Rechercher une pièce',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                     
          
                      SizedBox(
                      width: 300,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Entrer la référence ou la pièce',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    ],
                  ),
                  Stack(
          children: [
            
            
            // Overlay content
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Trouvez des pièces pour votre véhicule',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Row(
                      spacing: 10,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          hint: Text("Choisir la marque"),
                          items: [
                            DropdownMenuItem(
                              value: 'Citroën',
                              child: Text(
                                'Citroën',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Dacia',
                              child: Text(
                                'Dacia',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Nissan',
                              child: Text(
                                'Nissan',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Peugeot',
                              child: Text(
                                'Peugeot',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            // Add more items here
                          ],
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                         Expanded(
                        child: DropdownButtonFormField<String>(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          hint: Text("Choisir le modèle"),
                          items: [
                            DropdownMenuItem(
                              value: 'Citroën',
                              child: Text(
                                'Citroën',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Dacia',
                              child: Text(
                                'Dacia',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Nissan',
                              child: Text(
                                'Nissan',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Peugeot',
                              child: Text(
                                'Peugeot',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            // Add more items here
                          ],
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                       
                       Expanded(
                        child: DropdownButtonFormField<String>(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          hint: Text("Année"),
                          items: [
                            DropdownMenuItem(
                              value: 'Citroën',
                              child: Text(
                                'Citroën',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Dacia',
                              child: Text(
                                'Dacia',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Nissan',
                              child: Text(
                                'Nissan',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Peugeot',
                              child: Text(
                                'Peugeot',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            // Add more items here
                          ],
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                       Expanded(
                        child: DropdownButtonFormField<String>(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          hint: Text("Choisir la motorisation"),
                          items: [
                            DropdownMenuItem(
                              value: 'Citroën',
                              child: Text(
                                'Citroën',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Dacia',
                              child: Text(
                                'Dacia',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Nissan',
                              child: Text(
                                'Nissan',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Peugeot',
                              child: Text(
                                'Peugeot',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            // Add more items here
                          ],
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                       
                       
                       
                     ],
                    ),
                  SizedBox(height: 10),
                   Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade300,),
                    
                    child: GestureDetector(
                     
                     child: Center(child: Text("Valider",style: TextStyle(color: AppColors.theardingColor,fontFamily: "Montserrat",fontSize: 15,fontWeight: FontWeight.bold),)),
                    ),),
                    SizedBox(height: 20),
                    Text(
                      'Recherche par immatriculation',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: 1,
                          groupValue: 1,
                          onChanged: (value) {},
                          activeColor: Colors.white,
                        ),
                        Text(
                          'TU',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Radio(
                          value: 2,
                          groupValue: 1,
                          onChanged: (value) {},
                          activeColor: Colors.white,
                        ),
                        Text(
                          'RS',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: '*** تونس ***',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                      ),
                      child: Text('Valider'),
                    ),
                  ],
                ),
              ),
            ),
          ],
                ),
                ],
              )
          
            ],
          ),
        )
      ),
    );
  }
}

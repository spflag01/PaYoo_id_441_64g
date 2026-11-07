
import 'package:flutter/material.dart';
import 'package:ziaul_64g_441/auth/register_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              width: 350,
              height: 400,
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                child: Center(
                  child: Text(
                    "Explore The Thing You Need",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: 30),

            SizedBox(
              width: 550,
              height: 500,
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 10),

                        Text("Login to your account"),

                        SizedBox(height: 30),

                        TextFormField(
                          controller: controller1,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter your email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required!";
                            }

                            else if(!RegExp(r'^\w+@\w+\.\w+$').hasMatch(value)
                            
                            )
                            {
                                return "Invalid Email";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20),

                        TextFormField(
                          controller: controller2,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter your password",
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required!";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 10),

                       

                        SizedBox(height: 10),

                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                String email = controller1.text;
                                String password = controller2.text;

                                print(email);
                                print(password);
                              }
                            },
                            child: Text("Login"),
                          ),
                        ),

                        SizedBox(height: 10),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                 context,
                               MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                         ),
                          );
                          },
                          
                          child: Text("Create New Account"),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

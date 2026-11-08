
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:ziaul_64g_441/auth/Login_page.dart';
import 'package:ziaul_64g_441/widgets/input_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  final _supabase = Supabase.instance.client;

  Future<void> register() async {
    if (_isLoading) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      debugPrint('Step 1: Registration started');

      // Supabase Authentication
      final authResponse = await _supabase.auth
          .signUp(
            email: email,
            password: password,
          )
          .timeout(const Duration(seconds: 20));

      debugPrint('Step 2: Authentication successful');

      final user = authResponse.user;

      // Insert user information into profiles table
      if (user != null) {
        debugPrint('Step 3: Inserting profile');

        await _supabase.from('profiles').insert({
          'id': user.id,
          'name': name,
          'email': email,
        }).timeout(const Duration(seconds: 20));

        debugPrint('Step 4: Profile inserted successfully');
      }

      if (!mounted) return;

      // Clear input fields
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful'),
        ),
      );

    
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } on AuthException catch (e) {
      debugPrint('Authentication Error: ${e.message}');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
    } catch (e) {
      debugPrint('Registration Error: $e');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 82, 118, 181),
          fontSize: 22,
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 700,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Get started on Facebook with a Payoo account',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 69, 151, 218),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'A Payoo Account lets you access multiple Payoo '
                  'technologies easily and securely.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                Card(
                  elevation: 2,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Form(
                      key: _formKey,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          InputField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            labelText: 'Name',
                            hintText: 'Enter your name',
                            prefixIcon:
                                const Icon(Icons.person_outline),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty) {
                                return 'Enter your name';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 15),

                          InputField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            prefixIcon:
                                const Icon(Icons.email_outlined),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty) {
                                return 'Enter your email';
                              }

                              if (!RegExp(
                                r'^[^@]+@[^@]+\.[^@]+$',
                              ).hasMatch(value.trim())) {
                                return 'Enter a valid email';
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 15),

                          InputField(
                            controller: passwordController,
                            keyboardType:
                                TextInputType.visiblePassword,
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            prefixIcon:
                                const Icon(Icons.lock_outline),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your password';
                              }

                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 15),

                          InputField(
                            controller: confirmPasswordController,
                            keyboardType:
                                TextInputType.visiblePassword,
                            labelText: 'Confirm Password',
                            hintText: 'Confirm your password',
                            prefixIcon:
                                const Icon(Icons.lock_outline),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm your password';
                              }

                              if (value != passwordController.text) {
                                return 'Passwords do not match';
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            height: 42,
                            child: ElevatedButton(
                              onPressed:
                                  _isLoading ? null : register,
                              child: _isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Register'),
                            ),
                          ),

                          const SizedBox(height: 10),

                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Already have an account? Login',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

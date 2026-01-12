import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/provider/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //AuthProvider
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD7BDE2), Color(0xFF9B59B6)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'gambar/notes.png',
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 181, 122, 205),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Welcome to Notes App',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      Text(
                        'Manage your notes easily and securely',
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                      SizedBox(height: 24),

                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                      SizedBox(height: 20),

                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                      SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: authProvider.isLoading
                              ? null
                              : () async {
                                  if (emailController.text.isEmpty ||
                                      passwordController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Email dan password tidak boleh kosong',
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                  bool success = await authProvider.login(
                                    emailController.text,
                                    passwordController.text,
                                  );

                                  if (success) {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/dashboard',
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          authProvider.errorMessage ??
                                              'Login gagal',
                                        ),
                                      ),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 181, 122, 205),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: authProvider.isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 24),

                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Don’t have an account? ",
                              style: TextStyle(color: Color(0xFF9B59B6)),
                            ),
                            Text(
                              "Register here",
                              style: TextStyle(
                                color: Color(0xFF9B59B6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

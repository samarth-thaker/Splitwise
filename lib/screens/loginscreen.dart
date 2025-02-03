import 'package:flutter/material.dart';
import 'package:splitwise/widgets/customButton.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

final _emailController = TextEditingController();
final _passwordController = TextEditingController();

void login(BuildContext context) {
  Navigator.pushNamed(context, '/dashboard');
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Back'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
                maxWidth: 400), // Adjust max width for better UI
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Avoid taking unnecessary space
                crossAxisAlignment:
                    CrossAxisAlignment.stretch, // Stretch text fields properly
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    label: 'Login',
                    onPressed: () => login(context),
                    buttonWidth: buttonWidth,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

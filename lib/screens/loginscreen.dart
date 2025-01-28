import 'package:flutter/material.dart';
import 'package:splitwise/widgets/loginButton.dart';
class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

final _emailController = TextEditingController();
final _passwordControler = TextEditingController();
void login(BuildContext context) {
  Navigator.pushNamed(context, '/dashboard');
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome back'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _passwordControler,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20,),
            LoginButton(label: 'Login', onPressed: ()=>login(context), buttonWidth: buttonWidth),
          ],
        ),
        ),
      ),
    );
  }
}

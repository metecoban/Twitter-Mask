import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Twitter Mask"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 50, right: 50),
          child: Column(
            children: [
              Container(height: 200, child: Image.asset("assets/logo.jpeg")),
              SizedBox(
                height: 20,
              ),
              Text(
                'Login',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Email',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  // suffixIcon: IconButton(
                  //     onPressed: () {}, icon: Icon(Icons.remove_red_eye)),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Password',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Login"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/RegisterPage');
                    },
                    child: Text("Register"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/**Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text('Login',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
              SizedBox(height: 30),
              Text('Sign in to continue'),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Email',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  // suffixIcon: IconButton(
                  //     onPressed: () {}, icon: Icon(Icons.remove_red_eye)),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Password',
                ),
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/second');
                    },
                    child: Text('Login')),
              ),
              SizedBox(
                  width: 300,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () {
                        Navigator.pushNamed(context, '/RegisterPage');
                      },
                      child: Text('Register'))),
            ],
          ),
        ),
      ), */
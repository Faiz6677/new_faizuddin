import 'package:flutter/material.dart';
import 'package:new_faizuddin/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  moveToHome() {
    if(formKey.currentState!.validate()){
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return HomePage();
        }));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Image.asset('assets/images/car.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: username,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'username section is empty';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'username',
                        hintText: 'inter username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password section is empty';
                      } else if (value.length < 6) {
                        return 'password cannot be less then 6';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'password',
                        hintText: 'inter password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(), minimumSize: Size(120, 50)),
                      onPressed: () => moveToHome(),
                      child: Text(
                        'LOGIN',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Login Page",
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController iconAnimationController;
  Animation<double> iconAnimation;
  TextEditingController email = TextEditingController();
  TextEditingController passw = TextEditingController();
  String link = '';

  getData() async {
    //Map data={
    //'mail' : email.text,
    //'pass' : passw.text
    //};
    //http.Response response=await http.post("http://127.0.0.1:8000/login/",body: data);
    debugPrint('1');

    // String json = '{"email":'+'"'+email+'"'+',"password":'+'"'+password+'"'+'}';
    final response = await http.post('http://127.0.0.1:8000/login/', body:"{}");

    print('2');
    if (response.statusCode == 200) {
      debugPrint('2');
      print(response.body[]);
    } else {
      debugPrint('3');
    }
  }

  @override
  void initState() {
    super.initState();
    iconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    iconAnimation =
        CurvedAnimation(parent: iconAnimationController, curve: Curves.easeOut);
    iconAnimation.addListener(() => this.setState(() {}));
    iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              image: AssetImage("images/girl.jpeg"),
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.darken,
              color: Color.fromRGBO(0, 0, 0, 65),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(
                  size: iconAnimation.value * 100.0,
                ),
                Form(
                  child: Theme(
                    data: ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.teal,
                        inputDecorationTheme: InputDecorationTheme(
                            labelStyle:
                                TextStyle(color: Colors.teal, fontSize: 17.0))),
                    child: Container(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                              labelText: "Enter E-Mail",
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormField(
                            controller: passw,
                            decoration: InputDecoration(
                              labelText: "Enter Password",
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          Padding(padding: EdgeInsets.only(top: 40.0)),
                          MaterialButton(
                            height: 40.0,
                            minWidth: 100.0,
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            color: Colors.teal,
                            textColor: Colors.white,
                            onPressed: () => getData(),
                            splashColor: Colors.lightGreen,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Text('Welcome Everyone'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelguide/controllers/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Get.put(SignUpController());
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();
    // final _formKey = GlobalKey<FormState>();

    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
    );
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                    image: const AssetImage("assets/images/onb_1.png"),
                    height: MediaQuery.of(context).size.height * 0.3),
                Text("Create a new account",
                    style: GoogleFonts.poppins(
                        fontSize: 28, fontWeight: FontWeight.bold)),
                Text("Hop on and get ready to explore destinations!",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.normal)),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: controller.fullname,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_2_outlined),
                            labelText: "Full Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: controller.email,
                          decoration: InputDecoration(
                            prefixIcon: Icon(FontAwesomeIcons.mailchimp),
                            labelText: "E-mail",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: controller.phone,
                          decoration: InputDecoration(
                            prefixIcon: Icon(FontAwesomeIcons.squarePhone),
                            labelText: "Phone Number",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: controller.password,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            prefixIcon: Icon(FontAwesomeIcons.fingerprint),
                            labelText: "Password",
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  SignUpController.instance.registerUser(
                                      controller.email.text.trim(),
                                      controller.password.text.trim(),
                                      controller.fullname.text.trim(),
                                      controller.phone.text.trim());
                                }
                              },
                              child: Text("SIGN UP",
                                  style:
                                      GoogleFonts.poppins(color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("OR", style: GoogleFonts.poppins()),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: Image(
                            image: AssetImage("assets/logo/google.png"),
                            width: 20.0),
                        label: Text("Sign-up with Google",
                            style: GoogleFonts.poppins()),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Already have an account?",
                          style: GoogleFonts.poppins(color: Colors.black),
                          children: [
                            TextSpan(
                              text: " Login",
                              style: GoogleFonts.poppins(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

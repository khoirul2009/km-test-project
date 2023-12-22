import 'package:flutter/material.dart';
import 'package:km_test/components/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  String? palindrome;
  String? name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Image.asset(
            'assets/background.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Image.asset(
                    'assets/person_add.jpeg',
                    width: 116,
                    height: 116,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                    decoration: customInputDecoration('Name'),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    validator: notEmptyValidator,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: customInputDecoration('Palindrome'),
                    onChanged: (value) {
                      setState(() {
                        palindrome = value;
                      });
                    },
                    validator: notEmptyValidator,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 15),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: const Color(0xFF2B637B)
                            // Set your desired button color
                            ),
                        onPressed: () => {
                          if (_formKey.currentState!.validate())
                            {
                              checkPalindrome(palindrome!),
                            }
                        },
                        child: const Text('CHECK'),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 15),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: const Color(0xFF2B637B)
                            // Set your desired button color
                            ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _saveName(name!);
                          }
                        },
                        child: const Text('NEXT'),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  void checkPalindrome(String text) {
    String cleanStr =
        text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();

    bool isPalindrome = cleanStr == cleanStr.split('').reversed.join('');

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            isPalindrome ? 'isPalindrome' : 'not palindrome',
            style: const TextStyle(fontSize: 20.0),
          ),
        );
      },
    );
  }

  void _saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('saved_name', name).then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/second', ModalRoute.withName('/second'));
    });
  }
}

InputDecoration customInputDecoration(String hintText, {Widget? suffixIcon}) {
  return InputDecoration(
      hintText: hintText,
      suffixIcon: suffixIcon,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      fillColor: Colors.white,
      filled: true,
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orangeAccent),
          borderRadius: BorderRadius.circular(16)));
}

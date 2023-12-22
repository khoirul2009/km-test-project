import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String savedName = "";
  String selectedUsername = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSavedName();
  }

  void _loadSavedName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedName = prefs.getString('saved_name') ?? "";
      selectedUsername = prefs.getString('selected_username') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Second Screen',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', ModalRoute.withName('/'));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF5F6F52),
              )),
          backgroundColor: Colors.white,
          elevation: 0.1,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcome'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    savedName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Center(
                child: Text(
                  selectedUsername == ""
                      ? "Selected User Name"
                      : selectedUsername,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 24),
                ),
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
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/third', ModalRoute.withName('/third'));
                    },
                    child: const Text('Chose a User'),
                  )),
            ],
          ),
        ));
  }
}

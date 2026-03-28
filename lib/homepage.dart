import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // ⭐ tüm Row'u yatay ve dikey ortala
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // yatayda ortala
              crossAxisAlignment: CrossAxisAlignment.center, // dikeyde ortala
              children: [
                // 🔹 SOL (Contact Us)
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // dikey ortala
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Contact Us",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(width: 60, height: 3, color: Colors.orange),
                    ],
                  ),
                ),

                SizedBox(width: 30),

                // 🔹 SAĞ (FORM)
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // dikey ortala
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Name",
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Surname",
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Phone Number",
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      TextField(
                        decoration: InputDecoration(
                          labelText: "Subject",
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      TextField(
                        minLines: 3,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: "Enter Message",
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value ?? false;
                              });
                            },
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ), // normal metin
                                children: [
                                  TextSpan(
                                    text:
                                        "Kampanya ve yeniliklerden haberdar olmak istiyorum. Paylaştığım kişisel bilgilerin ",
                                  ),
                                  TextSpan(
                                    text: "Aydınlatma Metni", 
                                    style: TextStyle(
                                      color: Colors.orange,
                                      decoration: TextDecoration
                                          .underline, 
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        
                                        launchUrl(
                                          Uri.parse(
                                            "https://example.com/aydinlatma",
                                          ),
                                        );
                                      },
                                  ),
                                  TextSpan(
                                    text:
                                        " kapsamında işlenmesine izin veriyorum. İptal hakkım saklıdır.*",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Text("Send Email"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void launchUrl(Uri parse) {}
}

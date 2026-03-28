import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';
 import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isChecked = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  void openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Link açılamadı: $url")),
      );
    }
  }

 

void sendEmail() async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: 'yesimgunduz366@gmail.com',
    query: 'subject=${subjectController.text}&body=Name: ${nameController.text}\nSurname: ${surnameController.text}\nPhone: ${phoneController.text}\nEmail: ${emailController.text}\nMessage: ${messageController.text}',
  );

  if (await canLaunchUrl(params)) {
    await launchUrl(params);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Mail uygulaması açılamadı")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Contact Us",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(width: 60, height: 3, color: Colors.orange),
                    ],
                  ),
                ),

                const SizedBox(width: 30),

                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                                controller: nameController, label: "Name"),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                                controller: surnameController, label: "Surname"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                                controller: phoneController,
                                label: "Phone Number",
                                keyboardType: TextInputType.phone),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                                controller: emailController,
                                label: "Email",
                                keyboardType: TextInputType.emailAddress),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _buildTextField(
                          controller: subjectController, label: "Subject"),
                      const SizedBox(height: 20),

                      _buildTextField(
                          controller: messageController,
                          label: "Enter Message",
                          minLines: 3,
                          maxLines: null),
                      const SizedBox(height: 20),

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
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                      text:
                                          "Kampanya ve yeniliklerden haberdar olmak istiyorum. Paylaştığım kişisel bilgilerin "),
                                  TextSpan(
                                    text: "Aydınlatma Metni",
                                    style: const TextStyle(
                                      color: Colors.orange,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        openLink(
                                            "https://example.com/aydinlatma");
                                      },
                                  ),
                                  const TextSpan(
                                      text:
                                          " kapsamında işlenmesine izin veriyorum. İptal hakkım saklıdır.*"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: sendEmail,
                        child: const Text("Send Email"),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int? minLines = 1,
    int? maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
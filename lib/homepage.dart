import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; //Dokunma tıklanma hareketleri için gerekli kütüphanedir.
import 'package:url_launcher/url_launcher.dart'; //uygulamanın tarayıcı, e-posta, telefon veya harita gibi uygulamaları açmasını sağlar.

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
    final uri = Uri.parse(url); //url yi uri ye çevirir
    if (await canLaunchUrl(uri)) {
      //bu url açılırmı diye kontrol eder.
      await launchUrl(uri); //url yi açar
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Link açılamadı: $url")),
      ); //ekranda snacbar gösterilir.
    }
  }

  void sendEmail() async {
    //emaili yollama fonksiyonu.
    final Uri params = Uri(
      scheme: 'mailto', //urinin bir e-posta olduğunu gösterir.
      path: 'yesimgunduz366@gmail.com', //alıcı.
      query: //formdan alıp buraya ekler.
          'subject=${subjectController.text}&body=Name: ${nameController.text}\nSurname: ${surnameController.text}\nPhone: ${phoneController.text}\nEmail: ${emailController.text}\nMessage: ${messageController.text}',
    );

    if (await canLaunchUrl(params)) {
      //bu url açılırmı diye kontrol eder.
      await launchUrl(params); //url yi açar
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mail uygulaması açılamadı")),
      );
    }
  }

  void validateAndSendEmail() {
    String name = nameController.text
        .trim(); //baştaki ve sondaki boşlukları kaldırır trim.
    String surname = surnameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String subject = subjectController.text.trim();
    String message = messageController.text.trim();

    void showMessage(String text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    }

    // 1️⃣ İsim kontrolü
    if (name.isEmpty) {
      showMessage("İsim boş bırakılamaz");
      return;
    }
    if (!RegExp(r'^[a-zA-ZçÇğĞıİöÖşŞüÜ]+$').hasMatch(name)) {
      showMessage("Geçerli bir isim girin");
      return;
    }

    // 2️⃣ Soyisim kontrolü
    if (surname.isEmpty) {
      showMessage("Soyisim boş bırakılamaz");
      return;
    }
    if (!RegExp(r'^[a-zA-ZçÇğĞıİöÖşŞüÜ]+$').hasMatch(surname)) {
      showMessage("Geçerli bir soyisim girin");
      return;
    }

    // 3️⃣ Telefon kontrolü
    if (phone.isEmpty) {
      showMessage("Telefon numarası boş bırakılamaz");
      return;
    }
    if (!RegExp(r'^\d+$').hasMatch(phone)) {
      showMessage("Sadece rakam girin");
      return;
    }
    if (phone.length < 6 || phone.length > 15) {
      showMessage("Telefon numarası 6-15 rakam olmalı");
      return;
    }

    // 4️⃣ E-posta kontrolü
    if (email.isEmpty) {
      showMessage("E-posta boş bırakılamaz");
      return;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(email)) {
      showMessage("Geçerli bir e-posta girin");
      return;
    }

    // 5️⃣ Konu kontrolü.
    if (subject.isEmpty) {
      showMessage("Konu boş bırakılamaz");
      return;
    }

    // 6️⃣ Mesaj kontrolü.
    if (message.isEmpty) {
      showMessage("Mesaj boş bırakılamaz");
      return;
    }
    if (!isChecked) {
      showMessage("Lütfen aydınlatma metnini kabul edin.");
      return;
    }

    // ✅ Tüm alanlar doğruysa mail gönder.
    sendEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: IntrinsicHeight(
            //row un içindeki childlerın yüksekliğini ayarlar.
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1, //genişlik 1/3
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
                      Container(
                        width: 60,
                        height: 3,
                        color: Colors.orange,
                      ), //alt çizgi
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
                        //kutucukları yan yana almak için kullanılır.
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: nameController,
                              label: "Name",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                              controller: surnameController,
                              label: "Surname",
                            ),
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
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                              controller: emailController,
                              label: "Email",
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _buildTextField(
                        controller: subjectController,
                        label: "Subject",
                      ),
                      const SizedBox(height: 20),

                      _buildTextField(
                        controller: messageController,
                        label: "Enter Message",
                        minLines: 3, //yazdıkça genişler.
                        maxLines: null,
                      ),
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
                                        "Kampanya ve yeniliklerden haberdar olmak istiyorum. Paylaştığım kişisel bilgilerin ",
                                  ),
                                  TextSpan(
                                    text: "Aydınlatma Metni",
                                    style: const TextStyle(
                                      color: Colors.orange,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        openLink(
                                          "https://example.com/aydinlatma",
                                        );
                                      },
                                  ),
                                  const TextSpan(
                                    text:
                                        " kapsamında işlenmesine izin veriyorum. İptal hakkım saklıdır.*",
                                  ),
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
                        onPressed:
                            validateAndSendEmail, //butona basınca butondan kontrol eder textfieldten değil alanları butondan kontrol eder.
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
    required TextEditingController controller, //textfield içindeki yazıyı okur.
    required String label,
    TextInputType keyboardType = TextInputType.text, //klavye türü.
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

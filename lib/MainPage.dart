import 'package:flutter/material.dart';
import 'package:untitled/appBar.dart';
import 'package:untitled/secim_sayfasi.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Image.asset("assets/images/idea_logo.png"),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Yardıma ihticanınız olan konuyu öğrenmek için sıradaki ekrandan Sınıf, Konu, Ünite ve Ders seçimlerinizi yapınız.",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecimSayfasi()));
              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Konu Seçimine Git",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

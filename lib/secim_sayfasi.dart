import 'package:flutter/material.dart';
import 'package:untitled/appBar.dart';
import 'package:untitled/ders_icerik_sayfasi.dart';
import 'package:untitled/veriler.dart';

class SecimSayfasi extends StatefulWidget {
  @override
  _SecimSayfasiState createState() => _SecimSayfasiState();
}

class _SecimSayfasiState extends State<SecimSayfasi> {
  String? secilenSinif;
  String? secilenDers;
  String? secilenUnite;
  String? secilenKonu;
  final TextEditingController _notlarController = TextEditingController();

  List<String> siniflar = konular.keys.toList();

  final Map<String, List<String>> dersler = {
    for (var sinif in konular.keys) sinif: konular[sinif]!.keys.toList(),
  };

  final Map<String, Map<String, List<String>>> uniteler = {
    for (var sinif in konular.keys)
      sinif: {
        for (var ders in konular[sinif]!.keys)
          ders: konular[sinif]![ders]!.keys.toList(),
      },
  };

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Sınıf Seç'),
                    value: secilenSinif,
                    onChanged: (String? newValue) {
                      setState(() {
                        secilenSinif = newValue!;
                        secilenDers = null;
                        secilenUnite = null;
                      });
                    },
                    items: siniflar.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Ders Seç'),
                    value: secilenDers,
                    onChanged: (String? newValue) {
                      setState(() {
                        secilenDers = newValue!;
                        secilenUnite = null;
                      });
                    },
                    items: secilenSinif != null
                        ? dersler[secilenSinif]!
                            .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Ünite Seç'),
                    value: secilenUnite,
                    onChanged: (String? newValue) {
                      setState(() {
                        secilenUnite = newValue!;
                      });
                    },
                    items: secilenSinif != null && secilenDers != null
                        ? uniteler[secilenSinif]![secilenDers]!
                            .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Konu Seç'),
                    value: secilenKonu,
                    onChanged: (String? newValue) {
                      setState(() {
                        secilenKonu = newValue!;
                      });
                    },
                    items: secilenSinif != null &&
                            secilenDers != null &&
                            secilenUnite != null
                        ? konular[secilenSinif]![secilenDers]![secilenUnite]!
                            .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: Container(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      // Expanded eklendi
                      child: TextField(
                        controller: _notlarController,
                        decoration: InputDecoration(
                          labelText: 'Notlar',
                          hintText: 'Ek bilgi veya not girin (isteğe bağlı)',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        maxLines: null, // Satır sınırını kaldır
                        expands:
                            true, // TextField'ın dikey olarak genişlemesini sağla
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  if (secilenSinif != null &&
                      secilenDers != null &&
                      secilenUnite != null &&
                      secilenKonu != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DersIcerikSayfasi(
                          sinif: secilenSinif!,
                          ders: secilenDers!,
                          unite: secilenUnite!,
                          konu: secilenKonu!,
                          notlar: _notlarController.text,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Lütfen tüm alanları doldurun.'),
                      ),
                    );

                  }


                },
                child: Text('Devam'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

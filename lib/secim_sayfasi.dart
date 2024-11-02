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
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildDropdownCard(
                'Sınıf Seç',
                secilenSinif,
                siniflar,
                    (String? newValue) {
                  setState(() {
                    secilenSinif = newValue;
                    secilenDers = null;
                    secilenUnite = null;
                    secilenKonu = null;
                  });
                },
              ),
              SizedBox(height: 20),
              _buildDropdownCard(
                'Ders Seç',
                secilenDers,
                secilenSinif != null ? dersler[secilenSinif] : null,
                    (String? newValue) {
                  setState(() {
                    secilenDers = newValue;
                    secilenUnite = null;
                    secilenKonu = null;
                  });
                },
              ),
              SizedBox(height: 20),
              _buildDropdownCard(
                'Ünite Seç',
                secilenUnite,
                (secilenSinif != null && secilenDers != null)
                    ? uniteler[secilenSinif]![secilenDers]
                    : null,
                    (String? newValue) {
                  setState(() {
                    secilenUnite = newValue;
                    secilenKonu = null;
                  });
                },
              ),
              SizedBox(height: 20),
              _buildDropdownCard(
                'Konu Seç',
                secilenKonu,
                (secilenSinif != null &&
                    secilenDers != null &&
                    secilenUnite != null)
                    ? konular[secilenSinif]![secilenDers]![secilenUnite]
                    : null,
                    (String? newValue) {
                  setState(() {
                    secilenKonu = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              _buildNotesCard(),
              SizedBox(height: 30),
              _buildContinueButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownCard(
      String label,
      String? selectedValue,
      List<String>? items,
      ValueChanged<String?> onChanged,
      ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          value: selectedValue,
          onChanged: onChanged,
          items: items != null
              ? items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList()
              : null,
        ),
      ),
    );
  }

  Widget _buildNotesCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: _notlarController,
            decoration: InputDecoration(
              labelText: 'Notlar',
              hintText: 'Ek bilgi veya not girin (isteğe bağlı)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            textAlignVertical: TextAlignVertical.top, // hintText'i ve labelText'i yukarı hizalar
            maxLines: null,
            expands: true,
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.teal,
        padding: EdgeInsets.symmetric(vertical: 16.0),
        minimumSize: Size(double.infinity, 50),
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
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      child: Text(
        'Devam',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

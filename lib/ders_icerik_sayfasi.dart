import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:untitled/appBar.dart';

class DersIcerikSayfasi extends StatefulWidget {
  final String sinif;
  final String ders;
  final String konu;
  final String notlar;
  final String unite;

  DersIcerikSayfasi({
    required this.sinif,
    required this.ders,
    required this.konu,
    required this.notlar,
    required this.unite,
  });

  @override
  State<DersIcerikSayfasi> createState() => _DersIcerikSayfasiState();
}

class _DersIcerikSayfasiState extends State<DersIcerikSayfasi> {
  String generatedText = "";
  String generatedQuestion = "";
  String answerText = "";
  bool isLoading = false;
  bool isGeneratingQuestion = false;
  bool isGeneratingAnswer = false;

  final model = GenerativeModel(
    model: "gemini-pro",
    apiKey: "AIzaSyDMghJD1XPOuhMerghmJeY0nbe1rEtJEGo",
  );

  @override
  void initState() {
    super.initState();
    getKonuAnlatimi();
  }

  Future<void> getKonuAnlatimi() async {
    if (widget.sinif.isNotEmpty &&
        widget.ders.isNotEmpty &&
        widget.konu.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      final content = [
        Content.text(
          '${widget.sinif}, ${widget.ders} dersi ${widget.unite} ünitesi ${widget.konu} konusunu anlayamadım. Bu konuyu bana anlatır mısın? Ayrıca bana yazdıysam eğer bu yazdığıma odaklanmanı istiyorum= ${widget.notlar}',
        ),
      ];

      try {
        final response = await model.generateContent(content);
        print("API Yanıtı: ${response.text}");  // Yanıtı konsola yazdırın
        setState(() {
          generatedText = response.text ?? "Konu alınamadı.";
        });
      } catch (e) {
        print("API Hatası: $e");  // Hata durumunda hata mesajını yazdırın
        setState(() {
          generatedText = "Konu alınamadı: Hata oluştu.";
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> generateQuestion() async {
    setState(() {
      isGeneratingQuestion = true;
    });

    final questionContent = [
      Content.text(
        '${widget.sinif}, ${widget.ders} dersi ${widget.unite} ünitesi ${widget.konu} konusuna dair 5 seçenekli bir soru hazırlar mısın?',
      ),
    ];

    try {
      final response = await model.generateContent(questionContent);
      setState(() {
        generatedQuestion = response.text ?? "Soru üretilemedi.";
      });
    } catch (e) {
      print("API Soru Üretme Hatası: $e");  // Hata durumunda hata mesajını yazdırın
      setState(() {
        generatedQuestion = "Soru üretilemedi: Hata oluştu.";
      });
    } finally {
      setState(() {
        isGeneratingQuestion = false;
      });
    }
  }

  Future<void> generateAnswer() async {
    setState(() {
      isGeneratingAnswer = true;
    });

    final answerContent = [
      Content.text(
        '${widget.sinif}, ${widget.ders} dersi ${widget.unite} ünitesi ${widget.konu} konusuna dair verilen sorunun cevabını (Doğru cevap A seçeneğiydi ve şu yüzden) hazırlar mısın?',
      ),
    ];

    try {
      final response = await model.generateContent(answerContent);
      setState(() {
        answerText = response.text ?? "Cevap bulunamadı.";
      });
    } catch (e) {
      print("API Cevap Üretme Hatası: $e");  // Hata durumunda hata mesajını yazdırın
      setState(() {
        answerText = "Cevap bulunamadı: Hata oluştu.";
      });
    } finally {
      setState(() {
        isGeneratingAnswer = false;
      });
    }
  }

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
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Text(
                    generatedText,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20),
                  if (widget.notlar.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notlar:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.notlar,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  if (generatedQuestion.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Üretilen Soru:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          generatedQuestion,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                          ),
                          onPressed: isGeneratingAnswer ? null : generateAnswer,
                          child: isGeneratingAnswer
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('Cevabı Göster', style: TextStyle(color: Colors.white)),
                        ),
                        if (answerText.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              answerText,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: isGeneratingQuestion ? null : generateQuestion,
              child: isGeneratingQuestion
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Bu Konu Hakkında Soru Üret', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }
}

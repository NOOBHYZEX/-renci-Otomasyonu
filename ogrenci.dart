import 'package:flutter/material.dart';

void main() {
  runApp(OgrenciKayitUygulamasi());
}

class OgrenciKayitUygulamasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Öğrenci Kayıt Otomasyonu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OgrenciKayitEkrani(),
    );
  }
}

class Ogrenci {
  String ad;
  String soyad;
  String yasadigiSehir;
  String telefon;
  String eposta;
  String okul;
  String tcKimlik;
  String sosyalMedya;

  Ogrenci({
    required this.ad,
    required this.soyad,
    required this.yasadigiSehir,
    required this.telefon,
    required this.eposta,
    required this.okul,
    required this.tcKimlik,
    required this.sosyalMedya,
  });
}

class OgrenciKayitEkrani extends StatefulWidget {
  @override
  _OgrenciKayitEkraniState createState() => _OgrenciKayitEkraniState();
}

class _OgrenciKayitEkraniState extends State<OgrenciKayitEkrani> {
  final _formKey = GlobalKey<FormState>();
  final _adController = TextEditingController();
  final _soyadController = TextEditingController();
  final _yasadigiSehirController = TextEditingController();
  final _telefonController = TextEditingController();
  final _epostaController = TextEditingController();
  final _okulController = TextEditingController();
  final _tcKimlikController = TextEditingController();
  final _sosyalMedyaController = TextEditingController();

  List<Ogrenci> ogrenciler = [];
  Ogrenci? _guncellenenOgrenci;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_guncellenenOgrenci == null
            ? 'Öğrenci Kayıt Otomasyonu'
            : 'Öğrenci Güncelleme'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // TC Kimlik
                    TextFormField(
                      controller: _tcKimlikController,
                      decoration: InputDecoration(
                        labelText: 'TC Kimlik Numarası',
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 11,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'TC Kimlik numarasını giriniz';
                        } else if (value.length != 11) {
                          return 'TC Kimlik numarası 11 haneli olmalıdır';
                        }
                        return null;
                      },
                    ),
                    // Ad
                    TextFormField(
                      controller: _adController,
                      decoration: InputDecoration(labelText: 'Ad'),
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Adı giriniz';
                        }
                        return null;
                      },
                    ),
                    // Soyad
                    TextFormField(
                      controller: _soyadController,
                      decoration: InputDecoration(labelText: 'Soyad'),
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Soyadı giriniz';
                        }
                        return null;
                      },
                    ),
                    // Telefon Numarası (sadece 10 haneli)
                    TextFormField(
                      controller: _telefonController,
                      decoration:
                      InputDecoration(labelText: 'Telefon Numarası'),
                      keyboardType: TextInputType.phone,
                      maxLength: 10, // Sadece 10 haneli numara
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Telefon numarasını giriniz';
                        } else if (value.length != 10) {
                          return 'Telefon numarası 10 haneli olmalıdır';
                        }
                        return null;
                      },
                    ),
                    // Okul
                    TextFormField(
                      controller: _okulController,
                      decoration: InputDecoration(labelText: 'Okul'),
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Okul adını giriniz';
                        } else if (value.length < 10) {
                          return 'Okul adı en az 10 karakter olmalıdır';
                        }
                        return null;
                      },
                    ),
                    // Yaşadığı Şehir
                    TextFormField(
                      controller: _yasadigiSehirController,
                      decoration: InputDecoration(labelText: 'Yaşadığı Şehir'),
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Yaşadığı şehri giriniz';
                        }
                        return null;
                      },
                    ),
                    // E-posta
                    TextFormField(
                      controller: _epostaController,
                      decoration: InputDecoration(labelText: 'E-posta'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'E-posta adresini giriniz';
                        } else if (!value.contains('@gmail.com') &&
                            !value.contains('@hotmail.com') &&
                            !value.contains('@beu.edu.tr')) {
                          return 'Geçerli bir e-posta adresi giriniz (Gmail, Hotmail, BEU)';
                        }
                        return null;
                      },
                    ),
                    // Sosyal Medya Hesabı
                    TextFormField(
                      controller: _sosyalMedyaController,
                      decoration:
                      InputDecoration(labelText: 'Sosyal Medya Hesabı'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sosyal medya hesabı giriniz';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Ogrenci yeniOgrenci = Ogrenci(
                                ad: _adController.text,
                                soyad: _soyadController.text,
                                yasadigiSehir: _yasadigiSehirController.text,
                                telefon: _telefonController.text,
                                eposta: _epostaController.text,
                                okul: _okulController.text,
                                tcKimlik: _tcKimlikController.text,
                                sosyalMedya: _sosyalMedyaController.text,
                              );

                              setState(() {
                                if (_guncellenenOgrenci == null) {
                                  ogrenciler.add(yeniOgrenci);
                                } else {
                                  int index =
                                  ogrenciler.indexOf(_guncellenenOgrenci!);
                                  ogrenciler[index] = yeniOgrenci;
                                }
                                // Öğrencileri TC'ye göre sıralama
                                ogrenciler.sort(
                                        (a, b) => a.tcKimlik.compareTo(b.tcKimlik));
                              });

                              // Temizle
                              _adController.clear();
                              _soyadController.clear();
                              _yasadigiSehirController.clear();
                              _telefonController.clear();
                              _epostaController.clear();
                              _okulController.clear();
                              _tcKimlikController.clear();
                              _sosyalMedyaController.clear();
                              _guncellenenOgrenci =
                              null; // Güncellenen öğrenci sıfırlanır

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${yeniOgrenci.ad} ${yeniOgrenci.soyad} kaydedildi!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: Text(_guncellenenOgrenci == null
                              ? 'Kaydet'
                              : 'Güncelle'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OgrencilerListesi(
                                  ogrenciler: ogrenciler,
                                  onOgrenciSec: (ogrenci) {
                                    setState(() {
                                      _guncellenenOgrenci = ogrenci;
                                      _adController.text = ogrenci.ad;
                                      _soyadController.text = ogrenci.soyad;
                                      _yasadigiSehirController.text =
                                          ogrenci.yasadigiSehir;
                                      _telefonController.text = ogrenci.telefon;
                                      _epostaController.text = ogrenci.eposta;
                                      _okulController.text = ogrenci.okul;
                                      _tcKimlikController.text =
                                          ogrenci.tcKimlik;
                                      _sosyalMedyaController.text =
                                          ogrenci.sosyalMedya;
                                    });
                                  },
                                  onOgrenciSil: (ogrenci) {
                                    setState(() {
                                      ogrenciler.remove(ogrenci);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            '${ogrenci.ad} ${ogrenci.soyad} silindi!'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text('Öğrenci Listesi'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OgrencilerListesi extends StatelessWidget {
  final List<Ogrenci> ogrenciler;
  final Function(Ogrenci) onOgrenciSec;
  final Function(Ogrenci) onOgrenciSil;

  OgrencilerListesi({
    required this.ogrenciler,
    required this.onOgrenciSec,
    required this.onOgrenciSil,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Öğrenci Listesi'),
      ),
      body: ListView.builder(
        itemCount: ogrenciler.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${ogrenciler[index].ad} ${ogrenciler[index].soyad}'),
            subtitle: Text(
                'TC: ${ogrenciler[index].tcKimlik}\nTelefon: ${ogrenciler[index].telefon}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    onOgrenciSec(ogrenciler[index]);
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    onOgrenciSil(ogrenciler[index]);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            onTap: () {
              onOgrenciSec(ogrenciler[index]);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}

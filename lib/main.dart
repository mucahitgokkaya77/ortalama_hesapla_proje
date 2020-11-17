import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersAdi;
  int dersKredileri = 1;
  double dersHarfKelime = 4;
  static int sayac = 0;
  double ortalama = 0;
  List<Ders> tumDersler;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Not Ortalaması Hesapla"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      body: uygulamaGovdesi(),
    );
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              padding: EdgeInsets.all(10),
              //color: Colors.orange.shade200,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "DERS ADI",
                        hintText: "Lütfen ders adını giriniz",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.teal, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.teal, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.length > 0) {
                          return null;
                        } else {
                          return "Ders Adı Boş Olamaz";
                        }
                      },
                      onSaved: (kaydedilecekDeger) {
                        dersAdi = kaydedilecekDeger;
                        setState(() {
                          tumDersler.add(
                              Ders(dersAdi, dersHarfKelime, dersKredileri));
                          ortalama = 0;
                          ortalamaHesapla();
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              items: dersKredileriItems(),
                              value: dersKredileri,
                              onChanged: (secilenKredi) {
                                setState(() {
                                  dersKredileri = secilenKredi;
                                });
                              },
                            ),
                          ),
                          margin: EdgeInsets.only(top: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.teal, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                items: secilenHarfItems(),
                                value: dersHarfKelime,
                                onChanged: (secilenKredi) {
                                  setState(() {
                                    dersHarfKelime = secilenKredi;
                                  });
                                }),
                          ),
                          margin: EdgeInsets.only(top: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.teal, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 60,
                      color: Colors.teal.shade400,
                      child: Center(
                          child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: tumDersler.length == 0
                                  ? "Lütfen Ders Giriniz!"
                                  : "ORTALAMA: ",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400)),
                          TextSpan(
                              text: tumDersler.length == 0
                                  ? ""
                                  : "${ortalama.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500)),
                        ]),
                      )),
                    )
                  ],
                ),
              )),
          Expanded(
            child: Container(
              //color: Colors.purple.shade200,
              child: ListView.builder(
                itemBuilder: _listeElemanlariniOlustur,
                itemCount: tumDersler.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> dersKredileriItems() {
    List<DropdownMenuItem<int>> krediler = [];
    for (int i = 1; i <= 10; i++) {
      krediler.add(DropdownMenuItem<int>(
        value: i,
        child: Text("$i Kredi"),
      ));
    }
    return krediler;
  }

  secilenHarfItems() {
    List<DropdownMenuItem<double>> harfler = [];
    harfler.add(DropdownMenuItem(
      child: Text(
        " AA ",
        style: TextStyle(fontSize: 16),
      ),
      value: 4,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " BA ",
        style: TextStyle(fontSize: 16),
      ),
      value: 3.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " BB ",
        style: TextStyle(fontSize: 16),
      ),
      value: 3,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " CB ",
        style: TextStyle(fontSize: 16),
      ),
      value: 2.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " CC ",
        style: TextStyle(fontSize: 16),
      ),
      value: 2,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " DC ",
        style: TextStyle(fontSize: 16),
      ),
      value: 1.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " DD ",
        style: TextStyle(fontSize: 16),
      ),
      value: 1,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " FD ",
        style: TextStyle(fontSize: 16),
      ),
      value: 0.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " FF ",
        style: TextStyle(fontSize: 16),
      ),
      value: 0,
    ));

    return harfler;
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {
    sayac++;
    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          tumDersler.removeAt(index);
          ortalamaHesapla();
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.teal.shade200, width: 2)),
        margin: EdgeInsets.all(4),
        child: ListTile(
          leading: Icon(
            Icons.done,
            size: 28,
            color: Colors.teal,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 24,
            color: Colors.teal,
          ),
          title: Text(tumDersler[index].ad),
          subtitle: Text(tumDersler[index].kredi.toString() +
              " Kredili Dersin Harf Değeri:${tumDersler[index].harfDegeri.toString()}"),
        ),
      ),
    );
  }

  void ortalamaHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;
    for (var oAnkiDers in tumDersler) {
      var kredi = oAnkiDers.kredi;
      var harfDegeri = oAnkiDers.harfDegeri;
      toplamNot = toplamNot + (harfDegeri * kredi);
      toplamKredi = toplamKredi + kredi;
    }
    ortalama = toplamNot / toplamKredi;
  }
}

class Ders {
  String ad;
  int kredi;
  double harfDegeri;

  Ders(this.ad, this.harfDegeri, this.kredi);
}

import 'package:flutter/material.dart';
import 'package:twitter_mask/models/user_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

var exampleResponse = [
  "ABD vizesi aldım. Herkes kolay kolay alamıyor maalesef. Benim önümdeki sıra komple red yedi. Pasaport elinde dönüyorlar. Sadece önümden 1 kişi aldı, sevinç kıyamet hareketler falan. Vizeyi onaylayan ABD’li kadın gülüyor. Hem o adamdan hemde o adamı bu hale düşürenlerden utandım.",
  "RT @eraygorgulu: Sayıştay Başkanı, Belediyeler Birliğinin üç yıldır denetlenmemesine gerekçe olarak personel eksikliğini gösterdi.\n\nhttps:/…",
  "RT @OnderAlgedik: Antalya limanı önemli, hani şu kararlılara gidecek diye fırtına kopartılan Antalya limanı.\n\nAntalya vekilleri ne yapmış?…",
  "İkimiz de çenemizi kapatalım, togg konuşsun. 2023 sonuna kadar müddet sana volki. Araç yurt dışında 1 milyon adet satarsa ayaklarına kapanıp özür dileyeceğim. Affedene kadar parmak aralarını yalayacağım. Satmazsa aynını sen yapacaksın. Malum, çıkış tarihi 2022’ydi. 1 yıl da bendn",
  "TV5'de @gulaysekocak ve @muammerbilgic__ Ankara'nın efsane belediye başkanı Murat Karayalçın'ı ağırlıyor.\n\nİçiniz açılsın, izleyin https://t.co/2mkgUwclYz",
  "En büyük liman Mersin limanı.\n\nMersin vekilleri ne yapmış?\n\n4 vekil limanlar satılsın demiş,\n2 vekil karşı çıkmış,\n6 vekil oylamaya katılmamış.\n\n🚢Mersin limanına Mersin vekilleri sahip çıkmamış😥 https://t.co/dYQvmAUpIs",
  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
];

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: const Text("Homepage"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 7),
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ProfilePage');
                },
                icon: CircleAvatar(
                  backgroundImage: NetworkImage(UserModel.photoUrl.toString()),
                )),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 20,
                child: ListTile(
                  onTap: () {
                    debugPrint('side${index + 1}');
                  },
                  trailing: const Icon(Icons.save_alt_outlined),
                  title: Text(exampleResponse[index]),
                ),
              ),
            );
          },
          itemCount: exampleResponse.length,
        ),
      ),
      floatingActionButton: SizedBox(
        height: 100.0,
        width: 100.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/FilterPage');
            },
            child: const Text("Filter"),
          ),
        ),
      ),
    );
  }
}

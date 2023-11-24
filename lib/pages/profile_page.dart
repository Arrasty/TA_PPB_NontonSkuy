import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage>{
  final double coverHeight = 280;
  final double profileHeight = 144;
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children : <Widget>[
          buildTop(),
          buildContent(),
        ]
      )
    );
  }

  Widget buildTop(){
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
         Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage()
         ),
          Positioned(
            top: top,
            child: buildProfileImage(),
          ),
        ],
      );
  }

  Widget buildCoverImage() => Container(
    color: Colors.grey,
    child: Image(image: AssetImage('assets/aselole.jpg'),
    width: double.infinity,
    height: coverHeight,
    fit: BoxFit.cover,
    ),
  );

  Widget buildProfileImage() => CircleAvatar(
    radius: profileHeight /2,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: AssetImage('assets/patrick.jpeg'),
  );

  Widget buildContent() => Column(
    children: [
      const SizedBox(height: 8),
      Text(
        'Farah Gesty Amandari',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      const SizedBox(height: 8),
      Text(
        'Teknik Komputer',
        style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Divider(),
        const SizedBox(height: 16),
        buildAbout(),
        const SizedBox(height : 32),
    ],
  );
  Widget buildAbout() => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            'Halo! Saya Farah Gesty Amandari dari Teknik Komputer angkatan 2021. Project ini merupakan tugas akhir (TA) dari Praktikum PPB. Project ini dibuat menggunakan Flutter dan bahasa pemrograman Dart, dan juga menggunakan API dari https://api.themoviedb.org/3 untuk menyajikan data-data dari Movie yang saya butuhkan pada project ini. Project NontonSkuy adalah program yang dapat menampilkan berbagai informasi dari Movie seperti tanggal rilis, genre, rating, review dan trailer. Di project ini saya dapat melakukan penambahan Movie ke watch list, dan juga dapat melakukan pencarian berbagai Movie yang ada',
            style: TextStyle(fontSize: 18, height: 1.4, color: Colors.white),
          )
      ],
    ),
  );
}

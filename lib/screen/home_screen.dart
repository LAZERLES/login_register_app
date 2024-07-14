import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:login_register_app/screen/post_detail_screen.dart';
import 'package:login_register_app/service/auth_service.dart';
import 'package:login_register_app/service/page_service.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_register_app/service/post_service.dart';

import '../config/app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  String get id => "";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> banners = [];
  List<dynamic> pages = [];
  List<dynamic> post = [];
  Future<void> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse('$API_URL/api/banners'));
      final banners = jsonDecode(response.body);
      print(banners);
      setState(() {
        this.banners = banners;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchPages() async {
    try {
      List<dynamic> pages = await PageService.fetchPages();
      setState(() {
        this.pages = pages;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchPost() async {
    try {
      final post = await PostService.fetchPosts();
      setState(() {
        this.post = post;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    AuthService.checkLogin().then((loggedIn) {
      if (!loggedIn) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });

    fetchBanners();
    fetchPages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PostDetailScreen(
                          id: pages[index]['id'],
                        ),
                      ),
                    );
                  },
                  title: Text(pages[index]['title']),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: Swiper(
                autoplay: true,
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    '$API_URL/${banners[index]['imageUrl']}',
                  );
                },
              ),
            ),
            Text(
              'Post',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              textAlign: TextAlign.start,
            ),
            ListView.builder(
              itemCount: post.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PostDetailScreen(
                          id: post[index]['id'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

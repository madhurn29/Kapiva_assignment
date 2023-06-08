import 'dart:convert';
import 'dart:math';

import 'package:demo_app/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kapiva Assignment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Dishes> dishes = [];

  Future<void> _refresh() async {
    final randomIndex = Random().nextInt(dishes.length);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      dishes = [dishes[randomIndex], ...dishes];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Foodie App",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.pink,
          actions: [
            IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
                color: Colors.white),
          ],
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            color: Colors.white,
          ),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(dishes[index].image),
                          radius: 30,
                        ),
                        title: Text(dishes[index].title,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        subtitle: Text(
                          dishes[index].description,
                          maxLines: 1,
                        ),
                        trailing: const Icon(Icons.add),
                      );
                    },
                    itemCount: dishes.length,
                    separatorBuilder: (context, index) {
                      return const Divider(height: 20);
                    },
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

//---------function to make a get request----------//
  Future<List<Dishes>> getData() async {
    final response = await http.get(Uri.parse('https://kapiva.onrender.com/'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        dishes.add(Dishes.fromJson(index));
      }
      return dishes;
    } else {
      return dishes;
    }
  }
}

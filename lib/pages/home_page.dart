import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_faizuddin/pages/detail_page.dart';

import '../models/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 3));
    final jsonfile = await rootBundle.loadString('assets/files/catalog.json');
    final decodedfile = jsonDecode(jsonfile);
    final productList = decodedfile['products'];
    ModelMap.items =
        List.from(productList).map((e) => Item.fromMap(e)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('favourites'),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                if (ModelMap.items != null && ModelMap.items.isNotEmpty)
                  Expanded(child: Center(child: ModelList()))
                else
                  Expanded(
                      child: Center(
                    child: CircularProgressIndicator(),
                  )),
              ],
            ),
          ),
        ));
  }
}

class ModelList extends StatelessWidget {
  const ModelList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: ModelMap.items.length,
        itemBuilder: (context, index) {
          final model = ModelMap.items[index];
          return InkWell(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailPage(model: model);
                  })),
              child: ModelItem(model: model));
        });
  }
}

class ModelItem extends StatelessWidget {
  final Item model;

  const ModelItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.all(10),
              height: 130,
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(15)),
              child: Hero(
                  tag: Key(model.id.toString()),
                  child: Image.network(model.image))),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(model.desc),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${model.price}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.yellow),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              minimumSize: Size(80, 40)),
                          onPressed: () {},
                          child: Text('Buy'))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

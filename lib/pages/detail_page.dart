import 'package:flutter/material.dart';
import 'package:new_faizuddin/models/model.dart';

class DetailPage extends StatelessWidget {
  final Item model;

  const DetailPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Hero(
                tag: Key(model.id.toString()),
                child: Image.network(model.image))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                model.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Text(
              model.desc,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${model.price}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          minimumSize: Size(120, 60)),
                      onPressed: () => ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(
                              content: Text(
                                  '${model.name} not available at the moment'))),
                      child: Text(
                        'Buy',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

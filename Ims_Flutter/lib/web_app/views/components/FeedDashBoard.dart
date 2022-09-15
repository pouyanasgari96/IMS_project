// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/model/item.dart';
import 'package:ims/web_app/data/book_data.dart';
import 'package:ims/web_app/model/category.dart';
import 'package:ims/web_app/data/genre_data.dart';
import 'package:ims/web_app/views/CategoryPage.dart';
import 'package:ims/web_app/services/http_services.dart';
import 'package:ims/web_app/views/ItemPage.dart';
import 'package:ims/web_app/views/ListItemsCustomer.dart';

class FeedDashBoard extends StatefulWidget {
  const FeedDashBoard({Key? key}) : super(key: key);

  @override
  State<FeedDashBoard> createState() => _FeedDashBoardState();
}

class _FeedDashBoardState extends State<FeedDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      InkWell(
        onTap: () async {
          if (TheWebUser[0]['role'] == 'customers') {
            await Httpservices.List_Items(
                TheWebUser[0]['opr_id'].toString(), context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListItemsCustomer()));
          }
        },
        child: const Center(
          child: Text("All items",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey)),
        ),
      ),
      SizedBox(
          height: 250,
          child: ListView.separated(
              padding: const EdgeInsets.all(22),
              scrollDirection: Axis.horizontal,
              itemCount: allItems.length,
              separatorBuilder: (context, _) => const SizedBox(width: 15),
              itemBuilder: (context, index) =>
                  buildCardItem(item: allItems[index], context: context))),
      const Text("Search by category",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey)),
      SizedBox(
          height: 250,
          child: ListView.separated(
              padding: const EdgeInsets.all(22),
              scrollDirection: Axis.horizontal,
              itemCount: allCategory.length,
              separatorBuilder: (context, _) => const SizedBox(width: 15),
              itemBuilder: (context, index) => buildCardCategory(
                  item: allCategory[index], context: context)))
    ]);
  }
}

Widget buildCardItem({required Item item, context}) => SizedBox(
      width: 220,
      child: Column(children: [
        Expanded(
          child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                    child: Hero(
                      tag: item.id,
                      child: Ink.image(
                        image: NetworkImage(item.urlImage),
                        fit: BoxFit.fill,
                        child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 350),
                                    pageBuilder: (context, __, ___) =>
                                        ItemPage(item: item)))),
                      ),
                    ),
                  ))),
        ),
        const SizedBox(height: 4),
        Text(item.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(item.author,
            style: const TextStyle(fontSize: 20, color: Colors.grey))
      ]),
    );

Widget buildCardCategory({required Category item, context}) => SizedBox(
      width: 200,
      child: Column(children: [
        Expanded(
          child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                    child: Ink.image(
                      image: NetworkImage(item.urlImage),
                      //height: 150,
                      //width: 150,
                      fit: BoxFit.fill,
                      child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GenrePage(genre: item.name)))),
                    ),
                  ))),
        ),
        const SizedBox(height: 4),
        Text(item.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
      ]),
    );

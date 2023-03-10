import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ims/web_app/DataLists.dart';
import 'package:ims/web_app/model/item.dart';

class ItemPage extends StatefulWidget {
  final Item item;

  const ItemPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState(item: item);
}

class _ItemPageState extends State<ItemPage> {
  final Item item;
  _ItemPageState({required this.item});
  @override
  Widget build(BuildContext context) {
    // To get total height and width
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: item.color,
      appBar: AppBar(
        backgroundColor: item.color,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: (Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const Image(
              image: AssetImage("images/ims.jpg"),
              width: 45,
              height: 45,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          const Text("Item page")
        ])),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          const Divider(),
          SizedBox(
            height: size.height,
            child: Stack(children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: size.height * 0.3),
                padding: EdgeInsets.only(
                    top: size.height * 0.12, left: 30, right: 30),
                height: 530,
                width: size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 150),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(item.description,
                              style: const TextStyle(height: 1.5))),
                      const SizedBox(height: 50),
                      availableWithFav()
                    ]),
              ),
              Align(
                  alignment: Alignment.topCenter, child: topBody(context, size))
            ]),
          )
        ]),
      ),
    );
  }

  Container topBody(BuildContext context, Size size) {
    return Container(
      height: 500,
      width: size.width * 0.5,
      margin: const EdgeInsets.only(left: 100, right: 100),
      child: Row(children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          const SizedBox(height: 100),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Title : ".toUpperCase(),
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45)),
            TextSpan(
                text: item.title,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black.withOpacity(0.75),
                  fontWeight: FontWeight.bold,
                )),
          ])),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Author : ".toUpperCase(),
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45)),
            TextSpan(
                text: item.author,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black.withOpacity(0.75),
                  fontWeight: FontWeight.bold,
                )),
          ])),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Category : ".toUpperCase(),
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45)),
            TextSpan(
                text: item.category,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black.withOpacity(0.75),
                  fontWeight: FontWeight.bold,
                )),
          ])),
          const SizedBox(
            height: 10,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Location : ".toUpperCase(),
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45)),
            TextSpan(
                text: item.location,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black.withOpacity(0.75),
                  fontWeight: FontWeight.bold,
                )),
          ])),
          const SizedBox(height: 100),
          RichText(
              text: TextSpan(children: [
            const TextSpan(
                text: "Price\n",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 24)),
            TextSpan(
                text: "\$${item.price}",
                style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold))
          ]))
        ]),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(item.urlImage, width: 350, height: 350))
        )
      ])
    );
  }

  SizedBox availableWithFav() {
    return SizedBox(
      height: 140,
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Container(
                decoration: BoxDecoration(
                  gradient: item.available
                      ? const LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        )
                      : const LinearGradient(
                          colors: <Color>[
                            Color.fromARGB(255, 161, 18, 13),
                            Color.fromARGB(255, 210, 65, 25),
                            Color.fromARGB(255, 245, 117, 66),
                          ],
                        ),
                ),
              )),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: item.available
                    ? const Text("RESERVE IT")
                    : const Text("NOT AVAILABLE"),
                onPressed: () {
                  setState(() {
                    if (item.available && TheWebUser[0]['role'] != 'guest') {
                      EasyLoading.showSuccess("Item reserved");
                      item.available = !item.available;
                    } else {
                      EasyLoading.showError("Please login to reserve an intem");
                    }
                  });
                },
              )
            ],
          ),
        ),
        const SizedBox(width: 150),
        ClipRRect(
            child: Container(
                height: 50,
                width: 58,
                decoration: BoxDecoration(
                    color: item.favorite
                        ? Colors.red.withOpacity(0.85)
                        : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black)),
                child: IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                      setState(() {
                        if (TheWebUser[0]['role'] != 'guest'){
                          if (item.favorite) {
                            item.favorite = !item.favorite;
                            EasyLoading.showSuccess("Item removed from favorite");
                          } else {
                            item.favorite = !item.favorite;
                            EasyLoading.showSuccess("Item added to favorite");
                          }
                        } else {
                          EasyLoading.showError("Please login to add item to your favorites");
                        }
                        
                      });
                    })))
      ]),
    );
  }
}

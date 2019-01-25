import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bigdeals2/app_bloc.dart';
import 'package:bigdeals2/tabs/tabs.dart';

class ModelProductsItem extends StatelessWidget {
  AppBloc appBloc;
  ProductsItem product;
  ModelProductsItem({Key key, this.product, this.appBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetails(
                        product: product,
                        appBloc: appBloc,
                      )),
            );
          },
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment(-1.0, -1.0),
                children: <Widget>[
                  Image.network(
                    product.avatar_image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: double.infinity,
                    height: 35.0,
                    decoration:
                        BoxDecoration(color: Color.fromARGB(200, 247, 104, 79)),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.timer,
                          color: Colors.white,
                          size: 15.0,
                        ),
                        Container(
                          width: 10.0,
                        ),
                        Text(
                          'Time end: ' +
                              DateFormat.jm()
                                  .add_yMMMMd()
                                  .format(
                                      new DateTime.fromMicrosecondsSinceEpoch(
                                          product.time_end * 1000000))
                                  .toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(product.name,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(30.0),
                            child: MaterialButton(
                              color: Color.fromARGB(150, 7, 239, 204),
                              minWidth: 20.0,
                              height: 30.0,
                              highlightColor: Colors.grey,
                              child: Text(
                                'MUA NGAY',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                            product: product,
                                            appBloc: appBloc,
                                          )),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Container(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 5.0, right: 10.0, left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          product.price_deal.toString(),
                          style: TextStyle(
                              color: Color.fromARGB(150, 7, 239, 204),
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        Container(
                          width: 20.0,
                        ),
                        Text(
                          product.price.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.add_shopping_cart),
                        Text(
                          product.amount_sale.toString() +
                              '/' +
                              product.amount_target.toString(),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

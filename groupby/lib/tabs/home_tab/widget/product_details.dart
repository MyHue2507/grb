import 'package:flutter/material.dart';
import 'package:bigdeals2/tabs/tabs.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:bigdeals2/app_bloc.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ProductDetails extends StatefulWidget {
  AppBloc appBloc;
  ProductsItem product;
  CheckProduct checkProduct = CheckProduct();
  FetchProductDetail detail = FetchProductDetail() ;
  ProductDetails({Key key, this.product, this.appBloc}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ProductDetailsState();
  }
}

class ProductDetailsState extends State<ProductDetails> {
  final Store<AppStateCart> store = Store<AppStateCart>(
    appReducer,
    initialState: AppStateCart.initial(),
  );
  TextEditingController controller;
  @override
  void initState() {
   widget.detail.fetchProductDetail(widget.product.id).then((onValue){
     widget.product = onValue ;
   }) ;
   if(widget.product.image_list == null) 
      widget.product.image_list = List();
   widget.product.image_list?.add(widget.product.avatar_image);
   print(widget.product.image_list);
    super.initState();
    controller = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) => StoreConnector<AppStateCart, ViewModel>(
        converter: (Store<AppStateCart> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) => Scaffold(
              appBar: AppBar(
                backgroundColor: Color.fromARGB(150, 7, 239, 204),
                title: Text(widget.product.name),
              ),
              body: ListView(
                children: <Widget>[
                  Container(
                    height: 300.0,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
                    decoration: BoxDecoration(color: Colors.blueGrey[100]),
                    child: Carousel(
                    //  boxFit: BoxFit.cover,
                      images: widget.product.image_list
                          .map((list) => NetworkImage(list))
                          .toList(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text(widget.product.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0)),
                  ),
                  Container(
                    height: 50.0,
                    width: 30.0,
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: 'Số lượng mua',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.product.price_deal.toString(),
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.grade),
                            Text(
                              widget.product.amount_sale.toString() +
                                  '/' +
                                  widget.product.amount_target.toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        widget.product.price.toString(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            decoration: TextDecoration.lineThrough),
                      )),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: new HtmlView(data: widget.product.description),
                  ),
                ],
              ),
              bottomNavigationBar: Material(
                child: MaterialButton(
                  child: Text('ADD TO CART'),
                  height: 50.0,
                  minWidth: double.infinity,
                  color: Color.fromARGB(150, 7, 239, 204),
                  onPressed: () {
                    widget.checkProduct
                        .postCheckProduct(
                            widget.product.id.toString(),
                            widget.product.current_deal_id.toString(),
                            controller.text,
                            widget.appBloc.getAccessToken())
                        .then((value) {
                      showDialog(
                          context: context,
                          child: AddItemDialog(message: value));
                      if (value == 'success') {
                        widget.product.quantity = int.parse(controller.text);
                        viewModel.onAddItem(widget.product);
                      }
                    });
                  },
                ),
              ),
            ),
      );
}

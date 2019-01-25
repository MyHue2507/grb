import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:bigdeals2/tabs/tabs.dart';
import 'package:bigdeals2/app_bloc.dart';

class CartScreen extends StatelessWidget {
  AppBloc appBloc;
  ShipFee shipFee = ShipFee();
  Address address = Address();
  CartScreen({Key key, this.appBloc}) : super(key: key);
  final Store<AppStateCart> store = Store<AppStateCart>(
    appReducer,
    initialState: AppStateCart.initial(),
  );

  @override
  Widget build(BuildContext context) => StoreConnector<AppStateCart, ViewModel>(
      converter: (Store<AppStateCart> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Color.fromARGB(170, 0, 204, 204),
            title: Text('Giỏ Hàng'),
          ),
          bottomNavigationBar: viewModel.items?.length != 0
              ? MaterialButton(
                  child: Text(
                    'Đặt Hàng',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  height: 50.0,
                  minWidth: double.infinity,
                  color: Color.fromARGB(170, 0, 204, 204),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShipmentDetails(
                                  appBloc: appBloc,
                                  money: sum(viewModel.items),
                                  products: viewModel.items,
                                  address: address,
                                )));
                  },
                )
              : null,
          body: Stack(
            alignment: Alignment(1.0, 1.0),
            children: <Widget>[
              ListView(
                children: viewModel.items.map((product) {
                  return CartItem(product);
                }).toList(),
              ),
              viewModel.items?.length != 0
                  ? Container(
                      height: 50.0,
                      width: double.infinity,
                      child: Card(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Tổng cộng : '),
                          Text(
                            sum(viewModel.items).toString(),
                          ),
                        ],
                      )))
                  : Container(),
            ],
          )));
}

int sum(List<ProductsItem> items) {
  int money = 0;
  for (int i = 0; i < items?.length; i++) {
    items[i].amount_sale >= items[i].amount_target
        ? money += items[i].price_deal
        : money += items[i].price;
  }

  return money;
}

class ViewModel {
  final List<ProductsItem> items;
  final Function(ProductsItem) onAddItem;
  final Function(ProductsItem) onDeleteItem;
  final Function() removeAll;
  ViewModel(this.items, this.onAddItem, this.onDeleteItem,this.removeAll);

  factory ViewModel.create(Store<AppStateCart> store) {
    List<ProductsItem> items = store.state.product;
    return ViewModel(items, (ProductsItem product) {
      store.dispatch(AddItemAction(product));
    }, (ProductsItem product) {
      store.dispatch(RemoveItemAction(product));
    }, (){store.dispatch(RemoveAll());});
  }
}

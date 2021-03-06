import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:bigdeals2/tabs/tabs.dart';
import 'package:bigdeals2/app_bloc.dart';

class CartScreen extends StatefulWidget {
  AppBloc appBloc;
  CartScreen({Key key, this.appBloc}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CartScreenState();
  }
}

class CartScreenState extends State<CartScreen> {
  ShipFee shipFee = ShipFee();
  Address address = Address();
  String money;

  final Store<AppStateCart> store = Store<AppStateCart>(
    appReducer,
    initialState: AppStateCart.initial(),
  );

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppStateCart, ViewModel>(
        converter: (Store<AppStateCart> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          // setState(() {
            money = sum(viewModel.items).toString();
          // });
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Color.fromARGB(170, 0, 204, 204),
                title: Text('Giỏ Hàng', style: TextStyle(fontSize: 15)),
              ),
              bottomNavigationBar: Container(
                margin: EdgeInsets.all(5.0),
                child: viewModel.items?.length != 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Tổng tiền: ',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                money,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          MaterialButton(
                            elevation: 0,
                            child: Text(
                              'Đặt Hàng',
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            ),
                            height: 40.0,
                            // minWidth: double.infinity,
                            color: Color.fromARGB(170, 0, 204, 204),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShipmentDetails(
                                            appBloc: widget.appBloc,
                                            money: sum(viewModel.items),
                                            products: viewModel.items,
                                            address: address,
                                          )));
                            },
                          )
                        ],
                      )
                    : null,
              ),
              body: viewModel.items?.length != 0
                  ? ListView(
                      children: viewModel.items.map((product) {
                        return CartItem(product);
                      }).toList(),
                    )
                  : Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 150),
                        child: Text(
                          'Không có sản phẩm nào trong giỏ',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ));
        });
  }
}

int sum(List<ProductsItem> items) {
  int money = 0;
  for (int i = 0; i < items?.length; i++) {
    items[i].amount_sale + items[i].quantity >= items[i].amount_target
        ? money += items[i].price_deal * items[i].quantity
        : money += items[i].price * items[i].quantity;
  }

  return money;
}

class ViewModel {
  final List<ProductsItem> items;
  final Function(ProductsItem) onAddItem;
  final Function(ProductsItem) onDeleteItem;
  final Function() removeAll;
  ViewModel(this.items, this.onAddItem, this.onDeleteItem, this.removeAll);

  factory ViewModel.create(Store<AppStateCart> store) {
    List<ProductsItem> items = store.state.product;
    return ViewModel(items, (ProductsItem product) {
      store.dispatch(AddItemAction(product));
    }, (ProductsItem product) {
      store.dispatch(RemoveItemAction(product));
    }, () {
      store.dispatch(RemoveAll());
    });
  }
}

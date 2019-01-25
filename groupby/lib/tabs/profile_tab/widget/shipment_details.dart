import 'package:bigdeals2/tabs/tabs.dart';
import 'package:bigdeals2/app_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ShipmentDetails extends StatefulWidget {
  AppBloc appBloc;
  int money;
  ShipFee shipFee = ShipFee() ;
  CreatOrder creatOder = CreatOrder() ;
  GetAddress getAddress = GetAddress() ;
  List<ProductsItem> products = List();
  Address address = Address() ;
  ShipmentDetails(
      {Key key, this.appBloc, this.money, this.products,this.address})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ShipmentDetailsState();
  }
}

class ShipmentDetailsState extends State<ShipmentDetails> {
  final Store<AppStateCart> store = Store<AppStateCart>(
    appReducer,
    initialState: AppStateCart.initial(),
  );
  int ship;
  List<Address> list = List();
  _fetchAddress() async {
    var address = await widget.getAddress.getAddressUser(widget.appBloc.getAccessToken());
    setState(() {
      list.addAll(address);
      if(widget.address != null)
        widget.address = list[0];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadShip();
    _fetchAddress();
  }

  _loadShip() async {
    setState(() {
      widget.shipFee.fetchFee().then((onValue) => ship = onValue);
    });
  }

  @override
  Widget build(BuildContext context) => StoreConnector<AppStateCart, ViewModel>(
      converter: (Store<AppStateCart> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) => Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(150, 7, 239, 204),
              title: Text('Shipment Details'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Address for delivery'),
                          FlatButton(
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyAddressEdit(
                                          appBloc: widget.appBloc,money: widget.money,products: widget.products,
                                        )),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child:
                          list.length != 0 ? AddressItem(widget.address) : Container(),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Ship fee :'),
                            Text(ship.toString()),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 40.0,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Tổng cộng: '),
                            Text(widget.money.toString()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: MaterialButton(
              child: Text(
                'Đặt Hàng',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              height: 50.0,
              minWidth: double.infinity,
              color: Color.fromARGB(150, 7, 239, 204),
              onPressed: () {
                print(widget.address.receiver);
                print(widget.address.phone_number);
                widget.creatOder
                    .creatOrders(widget.address, widget.products,widget.appBloc.getAccessToken())
                    .then((onValue) {
                  showDialog(
                      context: context, child : AddItemDialog(message: onValue));
                  if (onValue == 'success') viewModel.removeAll();
                });
              },
            ),
          ));
}

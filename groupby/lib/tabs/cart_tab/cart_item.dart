import 'package:bigdeals2/tabs/tabs.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CartItem extends StatefulWidget {
  @override
  ProductsItem product;
  CartItem(this.product);
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CartItemState();
  }
}

class _CartItemState extends State<CartItem> {
  final Store<AppStateCart> store = Store<AppStateCart>(
    appReducer,
    initialState: AppStateCart.initial(),
  );
  @override
  Widget build(BuildContext context) => StoreConnector<AppStateCart, ViewModel>(
        converter: (Store<AppStateCart> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) =>
            // TODO: implement build
            Stack(
              alignment: Alignment(1.0, 1.0),
              children: <Widget>[
                Card(
                  child: InkWell(
                    onTap: null,
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Image.network(
                            widget.product.avatar_image,
                            fit: BoxFit.cover,
                            height: 100.0,
                            width: 100.0,
                          ),
                        ),
                        Container(
                          width: 20.0,
                        ),
                       Expanded(
                         child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                           Text(
                              widget.product.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.product.price_deal.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(150, 7, 239, 204),
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(widget.product.price.toString(),
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w800)),
                            Text('Số Lượng : ${widget.product.quantity}')
                          ],
                        ),
                       ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    viewModel.onDeleteItem(widget.product);
                  },
                )
              ],
            ),
      );
}

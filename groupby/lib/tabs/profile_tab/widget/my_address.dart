import 'package:bigdeals2/tabs/tabs.dart';
import 'package:bigdeals2/app_bloc.dart';

class MyAddress extends StatefulWidget {
  AppBloc appBloc;
  GetAddress getAddress = GetAddress() ;
  MyAddress({Key key, this.appBloc}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyAddressState();
  }
}

class MyAddressState extends State<MyAddress> {
  List<Address> list = List();
  _fetchAddress() async {
    try{
      var address = await widget.getAddress.getAddressUser(widget.appBloc.getAccessToken());
       setState(() {
      list.addAll(address);
    });
    }catch(e){
      print('object22222222222222222222222222222');
    }
      
   
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAddress();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(150, 7, 239, 204),
          title: Text('My Address'),
          actions: <Widget>[
            FlatButton(
              child: Text('Add new'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddAddress(
                            appBloc: widget.appBloc,
                          )),
                );
              },
            )
          ],
        ),
        body: ListView(
            children: list.map((address) {
          return Container(
            child: AddressItem(address),
          );
        }).toList()),
        );
  }
}

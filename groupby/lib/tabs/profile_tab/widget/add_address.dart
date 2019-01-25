import 'package:bigdeals2/tabs/tabs.dart';
import 'package:bigdeals2/app_bloc.dart';

class AddAddress extends StatefulWidget {
  ListAddress listAddress ;
  AppBloc appBloc;
  Add_Address add = Add_Address();
  AddAddress({Key key ,this.appBloc}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddAddressState();
  }
}

class AddAddressState extends State<AddAddress> {
  TextEditingController _receiver;
  TextEditingController _address;
  TextEditingController _phoneNumber;
  @override
  void initState() {
    super.initState();
    _receiver = new TextEditingController();
    _address = new TextEditingController();
    _phoneNumber = new TextEditingController();
  }
  @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      _receiver.dispose();
      _address.dispose();
      _phoneNumber.dispose();
    }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(150, 7, 239, 204),
        title: Text('Change Password'),
      ),
      body: Container(
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            TextField(
                controller: _receiver,
                decoration: InputDecoration(
                  hintText: 'Receiver',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                )),
            TextField(
              controller: _address,
              decoration: InputDecoration(
                hintText: 'Address',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              ),
            ),
            TextField(
              controller: _phoneNumber,
              decoration: InputDecoration(
                hintText: 'Phone Number',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 50.0),
              child: MaterialButton(
              height: 50.0,
              minWidth: 200.0,
              child: Text('Add', style: TextStyle(fontSize: 20.0)),
              color: Color.fromARGB(150, 7, 239, 204),
              onPressed: (() {
                widget.add.addAddress(_receiver.text, _address.text, _phoneNumber.text,widget.appBloc.getAccessToken()).then((mess){
                  showDialog(context: context,child: AddItemDialog(message: mess,));
                }) ;
              }),
            ),
            )
          ],
        ),
      ),
    );
  }
}

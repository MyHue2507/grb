import 'package:bigdeals2/tabs/tabs.dart';
import 'package:bigdeals2/app_bloc.dart';

class HomeScreen extends StatefulWidget {
  final AppBloc appBloc;
  HomeScreen({Key key, this.appBloc}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height
          child: AppBar(
            elevation: 0,
            backgroundColor: Color.fromARGB(170, 0, 204, 204),
            centerTitle: true,
              title: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  'GroupBuy',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
          flexibleSpace:  Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),color: Colors.white),
            margin: EdgeInsets.only(top: 65.0,left: 5.0,right: 5.0),
            height: 35.0,
                child: TextField(
                    obscureText: true,
                    decoration: (InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          size: 15.0,
                        ),
                        hintText: 'Tìm kiếm...',
                        hintStyle: TextStyle(fontSize: 15.0),
                        contentPadding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                        border: OutlineInputBorder()))),
              ),
          ),
      ),
        body: Center(child: ListItem(appBloc: widget.appBloc)));
  }
}

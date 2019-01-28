import 'package:bigdeals2/tabs/tabs.dart';
import 'package:bigdeals2/app_bloc.dart';
import 'package:bigdeals2/search/search_screen.dart';

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
    TextEditingController search = TextEditingController();
    _search(String text) {
      if (text != null && text != ' ' && text.length > 0)
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => SearchScreen(text: text, search: search)));
    }

//     return Scaffold(
//         appBar:
// PreferredSize(
//           preferredSize: Size.fromHeight(100.0), // here the desired height
//           child: AppBar(
//             elevation: 0,
//             backgroundColor: Color.fromARGB(170, 0, 204, 204),
//             centerTitle: true,
//             title: Column(
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.only(bottom: 20),
//                   child: Text(
//                     'GroupBuy',
//                     style: TextStyle(fontSize: 15.0),
//                   ),
//                 ),
//               ],
//             ),
//             flexibleSpace: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5.0),
//                   color: Colors.white),
//               margin: EdgeInsets.only(top: 65.0, left: 5.0, right: 5.0),
//               height: 35.0,
//               child: TextField(
//                   controller: search,
//                   // onTap: (){
//                   //   Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SearchScreen()));
//                   // },
//                   onSubmitted: _search,
//                   decoration: (InputDecoration(
//                     suffixIcon: Icon(
//                       Icons.search,
//                       size: 15.0,
//                     ),
//                     hintText: 'Tìm kiếm...',
//                     hintStyle: TextStyle(fontSize: 12.0),
//                     contentPadding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
//                     // border: OutlineInputBorder()
//                   ))),
//             ),
//           ),
//         ),
//         body: Center(child: ListItem(appBloc: widget.appBloc)));
    return Stack(
      children: <Widget>[
        ListItem(appBloc: widget.appBloc,),
        Container(
          height: 105,
          margin: EdgeInsets.all(0),
          child: Card(
            margin: EdgeInsets.all(0),
                    child: PreferredSize(
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
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white),
                  margin: EdgeInsets.only(top: 65.0, left: 5.0, right: 5.0,bottom: 5.0),
                  height: 35.0,
                  child: TextField(
                      controller: search,
                      // onTap: (){
                      //   Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SearchScreen()));
                      // },
                      onSubmitted: _search,
                      decoration: (InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          size: 15.0,
                        ),
                        hintText: 'Tìm kiếm...',
                        hintStyle: TextStyle(fontSize: 12.0),
                        contentPadding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                        // border: OutlineInputBorder()
                        // disabledBorder: UnderlineInputBorder()
                      ))),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

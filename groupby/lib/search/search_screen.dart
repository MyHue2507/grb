import 'package:flutter/material.dart';
import 'package:bigdeals2/tabs/tabs.dart';
import 'package:bigdeals2/app_bloc.dart';

class SearchScreen extends StatefulWidget {
  AppBloc appBloc ;
  FetchSearchResult fetchSearchResult = FetchSearchResult();
  SearchScreen({Key key,this.appBloc}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  bool loading = true ;
  TextEditingController _searchTextController;
  List<ProductsItem> searchResult = List();
  void _search(String key){
    loading = false ;
    searchResult.clear();
    _loadSearchResult(key) ;
  }
   _loadSearchResult(String key) async {
    var result = await widget.fetchSearchResult
        .fetchSearchResult( key);
    setState(() {
      searchResult.addAll(result);
      loading = true ;
    });
  }

  @override
  void initState() {
    super.initState();
    _searchTextController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(150, 7, 239, 204),
          title: Directionality(
              textDirection: Directionality.of(context),
              child: TextField(
                key: Key('SearchBarTextField'),
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle:
                        new TextStyle(color: Colors.grey, fontSize: 16.0),
                    border: null),
                onChanged: null,
                onSubmitted: _search,
                autofocus: true,
                controller: _searchTextController,
              )),
          actions: [
            new IconButton(
                icon: new Icon(Icons.clear, color: Colors.red),
                onPressed: () {
                  _searchTextController.clear();
                })
          ],
        ),
        body: loading ? Center(
          child: searchResult.length == 0
            ? Container()
            : ListView(children: searchResult.map((p) {
              return ModelProductsItem(product: p,appBloc: widget.appBloc,) ;
            }).toList(),
        )): Center(child: CircularProgressIndicator(),));
  }
}

import 'package:flutter/material.dart';
import 'package:bigdeals2/tabs/tabs.dart';
import 'package:bigdeals2/app_bloc.dart';

class SearchScreen extends StatefulWidget {
  TextEditingController search ;
  String text ;
  AppBloc appBloc ;
  FetchSearchResult fetchSearchResult = FetchSearchResult();
  SearchScreen({Key key,this.appBloc,this.text,this.search}) : super(key: key);
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
    _search(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: Color.fromARGB(150, 7, 239, 204),
    //       title: Directionality(
    //           textDirection: Directionality.of(context),
    //           child: TextField(
    //             key: Key('SearchBarTextField'),
    //             keyboardType: TextInputType.text,
    //             style: TextStyle(color: Colors.black, fontSize: 16.0),
    //             decoration: InputDecoration(
    //                 hintText: 'Search',
    //                 hintStyle:
    //                     new TextStyle(color: Colors.grey, fontSize: 16.0),
    //                 border: null),
    //             onChanged: null,
    //             onSubmitted: _search,
    //             autofocus: true,
    //             controller: _searchTextController,
    //           )),
    //       actions: [
    //         new IconButton(
    //             icon: new Icon(Icons.clear, color: Colors.red),
    //             onPressed: () {
    //               _searchTextController.clear();
    //             })
    //       ],
    //     ),
    //     body: loading ? Center(
    //       child: Container(
    //         margin: EdgeInsets.all(7.0),
    //         child: searchResult.length == 0
    //           ? Text("Không tìm thấy kết quả")
    //           : ListView(children: searchResult.map((p) {
    //             return ModelProductsItem(product: p,appBloc: widget.appBloc,) ;
    //           }).toList(),
    //     ),
    //       )): Center(child: CircularProgressIndicator(),));
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height
          child: AppBar(
            elevation: 0,
            backgroundColor: Color.fromARGB(170, 0, 204, 204),
            centerTitle: true,
            title: Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'Tìm kiếm sản phẩm',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white),
                margin: EdgeInsets.only(top: 65.0, left: 5.0, right: 5.0),
                height: 35.0,
                child: TextField(
                  controller: widget.search,
                  // onTap: (){
                  //   Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SearchScreen()));
                  // },
                  onSubmitted: _search,
                    decoration: (InputDecoration(
                      border: InputBorder.none,
                        suffixIcon: Icon(
            Icons.search,
            size: 15.0,
                        ),
                        hintText: 'Tìm kiếm...',
                        hintStyle: TextStyle(fontSize: 12.0),
                        contentPadding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                        // border: OutlineInputBorder()
                        ))),
              ),
          ),
        ),
        body: loading ? Center(
          child: Container(
            margin: EdgeInsets.all(7.0),
            child: searchResult.length == 0
              ? Text("Không tìm thấy kết quả")
              : ListView(children: searchResult.map((p) {
                return ModelProductsItem(product: p,appBloc: widget.appBloc,) ;
              }).toList(),
        ),
          )): Center(child: CircularProgressIndicator(),));

  }
}

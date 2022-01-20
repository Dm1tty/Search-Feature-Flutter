import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Admins"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){
      showSearch(context: context, delegate: DataSearch());
          }
          )
        ],
      ),
      drawer: Drawer(),
    );
  }
}


class DataSearch extends SearchDelegate<String>{
  final names = [
      "Dzmitry",
      "Hanna",
      "Victoria",
      "Alena",
      "Aleh",
      "Anastasia",
      "Lilia",
      "Shayla"];

  final recentNames = [
      "Dzmitry"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    //action for top bar
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (
          ) {
        query = "";
      })];

  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
      icon: AnimatedIcons.menu_arrow,
      progress: transitionAnimation,
    ),
    onPressed: () {
        close(context, "");
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // show results
    return Container(
      height: 100.0,
      width: 400.0,
      color: Colors.white,
      child: Center(
        child: Text(query.isEmpty?"":names.where((p)=> p.startsWith(query.toTitleCase())).first),
      ),
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // show when someone searches for something
    final suggestionList = query.isEmpty?names:names.where((p)=> p.startsWith(query.toTitleCase())).toList()  ;

    return ListView.builder(itemBuilder: (context, index)=>ListTile(
      onTap: (){
        showResults(context);
      },
      leading: Icon(Icons.account_box_rounded),
      title: RichText(text: TextSpan(
        text: suggestionList[index].substring(0,query.length),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        children: [TextSpan(
          text: suggestionList[index].substring(query.length),
          style: TextStyle(color: Colors.grey)
        )]
      ))
    ),
      itemCount: suggestionList.length,
    );
  }
  
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
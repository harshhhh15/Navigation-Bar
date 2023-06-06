import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  List<String> _data = [
    'Apple',
    'Banana',
    'Cherry',
    'Durian',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
    'Jackfruit',
    'Kiwi',
    'Lemon',
    'Mango',
    'Nectarine',
    'Orange',
    'Peach',
    'Quince',
    'Raspberry',
    'Strawberry',
    'Tangerine',
    'Ugli fruit',
    'Vanilla bean',
    'Watermelon',
    'Xigua',
    'Yellow watermelon',
    'Zucchini',
  ];

  List<String> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _filteredData = _data;
  }

  void _filterData(String query) {
    List<String> filteredData = [];
    if (query.isNotEmpty) {
      _data.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          filteredData.add(item);
        }
      });
    } else {
      filteredData = _data;
    }
    setState(() {
      _filteredData = filteredData;
      _searchText = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.search, color: Colors.white70),
          ),
          onChanged: _filterData,
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_filteredData[index]),
          );
        },
      ),
    );
  }
}

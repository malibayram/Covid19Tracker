import 'package:covid_19_tracker/services/cache_service.dart';
import 'package:covid_19_tracker/utilities/strings.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CountrySearchSelectPage extends StatefulWidget {
  final String selectedItem;

  const CountrySearchSelectPage({
    Key? key,
    required this.selectedItem,
  }) : super(key: key);

  @override
  _CountrySearchSelectPageState createState() =>
      _CountrySearchSelectPageState();
}

class _CountrySearchSelectPageState extends State<CountrySearchSelectPage> {
  String _filterWord = "";
  late String _selectedItem;
  late List items;

  @override
  void initState() {
    items = CacheService().getCountryList();

    _selectedItem = widget.selectedItem;

    if (_selectedItem.isNotEmpty) {
      items.sort((a, b) => _selectedItem == a ? -1 : a.compareTo(b));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        title: TextField(
          decoration: const InputDecoration(
            hintText: "Filter",
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          onChanged: (v) => setState(() => _filterWord = v),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Hive.box(Strings.settings).put('country', _selectedItem);
              Navigator.pop(context);
            },
            icon: const Text(
              "OK",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final item in items.where((element) =>
              element.toLowerCase().contains(_filterWord.toLowerCase())))
            Card(
              child: ListTile(
                onTap: () {
                  _selectedItem = item;

                  if (mounted) setState(() {});
                },
                title: Builder(
                  builder: (context) {
                    final parts =
                        item.toLowerCase().split(_filterWord.toLowerCase());

                    if (item.toLowerCase() == _filterWord.toLowerCase()) {
                      return Text(
                        _filterWord,
                        style: TextStyle(
                          background: Paint()..color = Colors.yellow,
                        ),
                      );
                    }

                    return Text.rich(
                      TextSpan(
                        children: [
                          for (final itemPart in parts)
                            TextSpan(
                              children: [
                                TextSpan(text: itemPart),
                                if (itemPart != parts.last)
                                  TextSpan(
                                    text: _filterWord,
                                    style: TextStyle(
                                      background: Paint()
                                        ..color = Colors.yellow,
                                    ),
                                  ),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                ),
                trailing: Icon(
                  Icons.check,
                  color: _selectedItem == item
                      ? Colors.green
                      : Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

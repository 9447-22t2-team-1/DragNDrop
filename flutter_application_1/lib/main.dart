// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Drag and Drop list';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: const Center(
          child: ResponsiveServicePage(),
          // child: RandomWords(),
        ),
      ),
    );
  }
}

class ResponsiveServicePage extends StatefulWidget {
  const ResponsiveServicePage({Key? key}) : super(key: key);

  @override
  State<ResponsiveServicePage> createState() => _ResponsiveServicePageState();
}

class _ResponsiveServicePageState extends State<ResponsiveServicePage> {
  int _count = 0;
  void _addNewService() {
    setState(() {
      _count = _count + 1;
      print(_count);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 30),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            _addNewService();
          },
          child: const Text('Enabled'),
        ),
        const Expanded(child: ReorderableList())
      ],
    );
  }
}

//Use stful to create new stateful widget
class ReorderableList extends StatefulWidget {
  const ReorderableList({Key? key}) : super(key: key);

  @override
  State<ReorderableList> createState() => _ReorderableListState();
}

class _ReorderableListState extends State<ReorderableList> {
  // int _count = 0;

  //Create a list of 5 default items that have values [1,2,3,4,5]
  final List<int> _items = List<int>.generate(5, (int index) => index);
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      children: <Widget>[
        for (int index = 0; index < _items.length; index += 1)
          ListTile(
            key: Key('$index'),
            tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
            title: Text('Item ${_items[index]}'),
          ),
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final int item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
          print(newIndex);
        });
      },
    );
  }
}


// class RandomWords extends StatefulWidget {
//   const RandomWords({super.key});

//   @override
//   State<RandomWords> createState() => _RandomWordsState();
// }

// class _RandomWordsState extends State<RandomWords> {
//   final _suggestions = <WordPair>[];
//   final _biggerFont = const TextStyle(fontSize: 18);
//   @override
//   Widget build(BuildContext context) {
//     // final wordpair = WordPair.random();
//     // return Text(wordpair.asPascalCase);
//     return ListView.builder(
//       padding: const EdgeInsets.all(16.0),
//       itemBuilder: /*1*/ (context, i) {
//         if (i.isOdd) return const Divider(); /*2*/

//         final index = i ~/ 2; /*3*/
//         if (index >= _suggestions.length) {
//           _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//         }
//         return ListTile(
//           title: Text(
//             _suggestions[index].asPascalCase,
//             style: _biggerFont,
//           ),
//         );
//       },
//     );
//   }
// }

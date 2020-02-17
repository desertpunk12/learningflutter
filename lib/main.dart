import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final suggestions = <WordPair>[];
    final favs = <int>[];


    final controller = PageController(
      initialPage: 0,
    );
    final p1 = RandomWords(suggestions,favs);
    final p2 = FavWords(suggestions,favs);
    final view = PageView(
      controller: controller,
      children: [
        p1,
        p2,
      ],
    );

    return MaterialApp(title: "Wingo Test", home: view //RandomWords(),
        );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions;
  final _favs;
  final _biggerFont = const TextStyle(fontSize: 16);

  RandomWordsState(this._suggestions, this._favs);

  Image _favButton(int index) {
    if (_favs.contains(index))
      return const Image(image: AssetImage('assets/images/like.png'));
    return const Image(image: AssetImage('assets/images/unlike.png'));
  }

  Widget _buildRow(WordPair pair, int index) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: IconButton(
        icon: _favButton(index),
        onPressed: () {
          setState(() {
            if (!_favs.contains(index)) {
              _favs.add(index);
              _favs.sort();
            }
            else
              _favs.remove(index);
          });
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index], index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup name Generator"),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: _buildSuggestions(),
      backgroundColor: Colors.greenAccent,
    );
  }
}

class FavWordsState extends State<FavWords>{
  final _suggestions;
  final _favs;


  FavWordsState(this._suggestions, this._favs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favs'),
      ),
      body: ListView.builder(
        itemCount:(_favs.length>0?_favs.length*2-1:0),
        itemBuilder: (context, i) {
          if(i.isOdd) return Divider();
          var index = i~/2;
          return ListTile(
              title: Text('${_suggestions[_favs[index]]}')
          );
        },
      ),
    );
  }

}


class FavWords extends StatefulWidget{
  final _suggestions;
  final _favs;


  FavWords(this._suggestions, this._favs);

  @override
  State<StatefulWidget> createState() => FavWordsState(_suggestions,_favs);

}

class RandomWords extends StatefulWidget {
  final _suggestions;
  final _favs;

  RandomWords(this._suggestions, this._favs);




  @override
  RandomWordsState createState() => RandomWordsState(_suggestions, _favs);
}

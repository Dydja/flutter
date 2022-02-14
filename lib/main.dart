import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'startup name generator',
      //modifions l'interface utilisateur à laide de thmes
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.black,
      )
      ),
      home: const RandomWords(),
    );
    /*Declarons une variable
    final wordPair = WordPair.random();*/
    /*return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );*/

    /*return MaterialApp(
      title: 'ODA Cagnotte',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Oda'),
        ),
        body:  const Center(
          child: RandomWords(), /*genere les mots aléatoirement le debut et le mot suivant en english*/
        ),
      ),
    );*/
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key?key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[]; /*On enregistre les data generer*/
  final _saved = <WordPair>{};     // permet d'enregistrer les favoris des utilisateurs
  final _biggerFont = const TextStyle(fontSize: 18); /*Une police de 18*/
  @override
  Widget build(BuildContext context) {
    /*final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);*/
    return Scaffold(
      appBar: AppBar(
          title: const Text('List etudiant'),
        // Add from here ...if user click on button ,new itineraire contenant les favoris saved est poussé vers le navigator affichant l'icone
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved, //permet d'afficher l'icon de liste menu pour changer de'itineraire
            tooltip: 'Saved Suggestions',
          ),
        ],
        // ... to here
    ),
    body: _buildSuggestions(), /*le corps de la liste*/
    );
  }
  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) {
          return const Divider(); /*2*/ /*Ajout d'un widget de separateur de haut avant chaque ligne du fichier*/
        }

        final index = i ~/ 2; /*3 divise l'elts pas deux et on retient les entiers*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4 si on atteint la limite genere moi 10 elts */
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }
  Widget _buildRow(WordPair pair) {
     // alreadySaved permet de savoir si 'une association
    final alreadySaved = _saved.contains(pair);
    // de mots n'a pas déjà été ajoutée aux favoris.
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(     // add des icones de coeur pour les favoris
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
        semanticLabel: alreadySaved ? 'Remove from saved' : 'Save', //dans le cas contraire retire le de lenregistrement
      ),
      onTap: () {      // NEW lines from here... l'evenement du click
        setState(() { //Sauvegarde l'information et une mise à jour de l'interface user grace au build dont itl fait appelle
          if (alreadySaved) { //s'il est enregistrer deja supprime le
            _saved.remove(pair);
          } else { //dans le cas contraire ajoute le
            _saved.add(pair);
          }
        });
      },   // on tap.
    );

  }
  void _pushSaved() { //permet d'acceder au navigator et ajouter la liste des elts
    //Navigator.push pousse la route vers la pile du navigateur

    Navigator.of(context).push(
      // Add lines from here...
      MaterialPageRoute<void>(//MaterialPageRouteet son générateur.
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty//a dividedvariable contient les lignes finales converties en liste par la fonction de commodité, toList()
              ? ListTile.divideTiles( //ajoute un espacement horizontal entre chaque fichier
            context: context,
            tiles: tiles,
          ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),//Affiche les nouveaux favoris suivie d'un separateur de ligne
          );
        },
      ), // ...to here.
    );
  }

}


/*class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/

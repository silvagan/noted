import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

void main() {
  runApp(MyApp());
  //windowManager.setAsFrameless();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 57, 159, 255)),
        ),
        home: HomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var notes = <String>[];
  final TextEditingController controller = TextEditingController();

  void addNote(String note){
    notes.add(note);
    notifyListeners();
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              Expanded(child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: NotesPage(),
              )),
            ],
          ),
        );
      }
    );
  }
}


class NotesPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    var icon = Icons.add;
    final children = <Widget>[];
    children.add(      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(onPressed: (){
              appState.addNote("");
            }, 
            icon: Icon(icon),
            label:Text('Add note')),
        ],
      ),);
      children.add(      SizedBox(height:10),);
    
    var l = appState.notes.length;
    
    for (var i = 0; i < l; i++){
      appState.controller.text = "aa";
      children.add(Row(
        mainAxisSize: MainAxisSize.min,
        children:[
          Expanded(flex: 5,
            child: EditableText(
              controller: appState.controller,
              focusNode: FocusNode(),
              style:TextStyle(color: Colors.black),
              cursorColor: Colors.red,
              backgroundCursorColor: Colors.black,
          ),),
          Expanded(flex: 1,
          child:Container(
            height: 50.0,
            width: 150.0,
            child: TextButton(
              child: Icon(Icons.edit),
              onPressed: ()           {
              appState.addNote("");
          },
            ),
          ),
          ),
        ],
      ),);
    }
        return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
      ),
    );
  }
}

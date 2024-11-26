import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:ui' as ui;

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
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 57, 159, 255)),
        ),
        home: HomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var notes = <String>[];
  final TextEditingController controller = TextEditingController();

  void addNote(String note) {
    notes.add(note);
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            Expanded(
                child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: NotesPage(),
            )),
          ],
        ),
      );
    });
  }
}

class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var icon = Icons.add;
    final children = <Widget>[];

    var l = appState.notes.length;

    for (var i = 0; i < l; i++) {
      appState.controller.text = "aa";
      children.add(Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(blurRadius: 1)],
                ),
                child: Row(mainAxisSize: MainAxisSize.max, children: [
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1),
                          boxShadow: [BoxShadow(blurRadius: 1)],
                        ),
                        child: Expanded(
                          flex: 5,
                          child: EditableText(
                            textAlign: TextAlign.center,
                            controller: appState.controller,
                            selectionHeightStyle: ui.BoxHeightStyle.strut,
                            focusNode: FocusNode(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                            cursorColor: Colors.red,
                            backgroundCursorColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 50.0,
                      width: 150.0,
                      child: TextButton(
                        child: Icon(Icons.edit),
                        onPressed: () {
                          appState.addNote("");
                        },
                      ),
                    ),
                  ),
                ])),
          )));
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            appState.addNote("");
          },
          icon: Icon(icon),
          label: Text('Add note')),
    );
  }
}

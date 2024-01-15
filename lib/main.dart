import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';


void main() {
  runApp(const RoboCopyGUIApp());
}

class RoboCopyGUIApp extends StatelessWidget {
  const RoboCopyGUIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoboCopy GUI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 100, 82, 86)),
        useMaterial3: true,
      ),
      home: const RoboCopyGUIAppHome(title: 'RoboCopy GUI Home'),
    );
  }       
}

class RoboCopyGUIAppHome extends StatefulWidget {

  const RoboCopyGUIAppHome({super.key, required this.title});

  final String title;

  @override
  State<RoboCopyGUIAppHome> createState() => RoboCopyGUIAppHomeState();
}

class RoboCopyGUIAppHomeState extends State<RoboCopyGUIAppHome> {
  List<String> sourceDirectories = List<String>.empty(growable: true);

  void addToSourceDirs(String path) {
    setState(() {
      sourceDirectories.add(path);
      for (String e in sourceDirectories) {
        log(e);
      }
    });
  }

  void pickDirectory() async {
    String? result = await FilePicker.platform.getDirectoryPath();

    // exit method if nothing selected
    if (result == null) return;

    addToSourceDirs(result);
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> selectedDirs = List<Widget>.empty(growable: true);
    selectedDirs.add(Text('You have selected the following directories: '));
    String _selectedDirsList = '';

    for (String dirs in sourceDirectories) {
      _selectedDirsList = _selectedDirsList + dirs + '\n';
    } 

    selectedDirs.add(Text(_selectedDirsList));
    log(_selectedDirsList);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: selectedDirs,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickDirectory,
        tooltip: 'Select a Directory',
        child: const Icon(Icons.add),
      ),
    );
  }
}

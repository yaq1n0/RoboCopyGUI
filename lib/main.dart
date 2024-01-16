import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

// enable verbose logging for debugging purposes 
bool verbose = true;

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 100, 82, 86)),
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
  // list of source directories to copy from
  List<String> srcDirs = List<String>.empty(growable: true);
  
  // list of destination directories to copy to 
  List<String> destDirs = List<String>.empty(growable: true);

  // String to store robocopy_file.txt
  String outputFileText = '';

  Future<void> addToSourceDirs() async {
    String? result = await FilePicker.platform.getDirectoryPath();
    
    // nothing selected, exit method
    if (result == null) return;

    setState(() {
      srcDirs.add(result);
    });

    if (verbose) log('$result added to destination directories');
  }

  Future<void> addToDestDirs() async {
    String? result = await FilePicker.platform.getDirectoryPath();

    // nothing selected, exit method
    if (result == null) return;

    setState(() {
      destDirs.add(result);
    });

    if (verbose) log('$result added to destination directories');
  }

  void readOutputFile() {
    //TODO: implement reading robocopy_output.txt to outputfileText
    String path = '';

    String long_newline = '';
    for (int i = 0; i < 10; i++) {
      long_newline = '${long_newline}newline';
    }
    for (int i = 0; i < 10; i++) {
      outputFileText = outputFileText + long_newline;
    }

    setState(() {});

    if (verbose) log('readOutputfile method called');
  }

  void runRoboCopy() {
    //TODO: implement actual shell interface code to run roboCopy
    
    if (verbose) log('runRoboCopy method called');
  }
  
  @override
  Widget build(BuildContext context) {
    String srcDirsList = '';
    String destDirsList = '';

    for (String dirs in srcDirs) {
      srcDirsList = '$srcDirsList$dirs\n';
    } 

    for (String dirs in destDirs) {
      destDirsList = '$destDirsList$dirs\n';
    } 

    Column subColumn1a = Column(
      // selected source directories
      children: [
        const Text('Selected Source Directories: '), 
        Text(srcDirsList),
      ],
    );

    Column subColumn1b = Column(
      // control buttons
      children: [
        ElevatedButton(
          // add to source dirs
          onPressed: addToSourceDirs, 
          child: const Text('Add Source'),
          ),
        ElevatedButton(
          // add to destination dirs
          onPressed: addToDestDirs, 
          child: const Text('Add Destination'),
        ),
        ElevatedButton(
          // run robocopy
          onPressed: runRoboCopy, 
          child: const Text('Run RoboCopy'),
          ),
        ElevatedButton(
          // refresh robocopy_log 
          onPressed: readOutputFile, 
          child: const Text('Refresh Log'),
        ),
      ],
    );

    Column subColumn1c = Column(
      // selected destination directories
      children: [
        const Text('Selected Destination Directories: '), 
        Text(destDirsList),
      ],
    );

    SizedBox outputBox = SizedBox(
      //TODO: might want to change this to relative to parent window size
      height: 400,
      width: 800, 
      child: Column(
        children: [
          const Text('Log File (robocopy_log.txt): '),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(outputFileText),
            )
          )
        ]
      ) 
    );

    Row firstRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [subColumn1a, subColumn1b, subColumn1c]
      );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          firstRow, 
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [outputBox],
          )
        ],
      ),
    );
  }
}

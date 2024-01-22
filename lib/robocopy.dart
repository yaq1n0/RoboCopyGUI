
import 'dart:developer';

import 'package:process_run/shell.dart';

// robocopy documentation:
// https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy

// robocopy shell command syntax
// robocopy <source> <destination> [<file>[ ...]] [<options>]
// since the program uses source and destination directories, 
//"<file>" list can be ignored

void copy(String source, String dest, [List<String>? args]) async{
  // if args are null, use default args
  args??= ['/mir', '/tee', '/w:5', '/unilog+:"robocopy_log.txt"'];
  
  
  // using copyInert to save on rewriting the parsing lol
  String command = copyInert(source, dest, args);

  log('robocopy.dart: $command');

  var shell = Shell();
  await shell.run(command);
}

String copyInert(String source, String dest, [List<String>? args]){
  String command = '';

  command = 'robocopy $source $dest';

  if (args != null) {
    for (String arg in args) {
      command = '$command $arg';
    }
  }

  log('robocopy.dart: $command');

  return command;
}

void copyTest([bool live = false]) {
  // call copy() with baked in parameters
  // set live to true to run robocopy, set to false to just output parsed input to log
  // by default, the function is not live, for safety
  // this function also contains syntax examples for the parameters
  // REMEMBER THAT WINDOWS BACKSLASH \ IS THE ESCAPE CHARACTER, USE \\ FOR \ IN FILE PATHS
  
  // example robocopy string translates to
  // mirror directory tree, wait 5 seconds between tries, write status to console and to log file "robocopy_log.txt" 

  if (live) {
    copy('"C:\\robo_testing"', '"C:\\robo_testing"', ['/mir', '/tee', '/w:5', '/unilog+:"robocopy_log.txt"']);
  } else {
    copyInert('"C:\\robo_testing"', '"C:\\robo_testing"', ['/mir', '/tee', '/w:5', '/unilog+:"robocopy_log.txt"']);
  }
}
  
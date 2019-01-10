# Lab 01 - Getting Familiar with the Terminal

## This is "Part 2", which is meant to be done on your own after a brief "lecture"

<hr>

Most of the following exercises are meant to help you become acquainted with basic commands for inspecting data files
* Determining what kind of file a given file is
* Being able to see contents of a file
* Introducing ways to filter the contents of a file by extracting certain lines that match a given search criterion
* Recognizing common patterns of the syntax used with UNIX-style commands
* Introducing ways to combine simple commands in powerful ways

<hr>

### 1. Determining what kind of file a file is
The command 
```
$ file [filename]
```
Will output (to the terminal window) the type of file given by the name that you specify.
**Try it with the files in the Lab01 folder.**
This can be very useful when you get data from others and aren't sure of the contents.  The `file` command enables you to see the format you are working with.  Here's what I see in my terminal when I use it:
```
$ file BirdList.txt 
BirdList.txt: UTF-8 Unicode text
$ file Lab01_part2.md 
Lab01_part2.md: ASCII text
$ 
```

Note that basic operations provided by command line tools tend to work best, in general, on plain text files. UTF-8 Unicode text and ASCII text (as shown above) are both plain text.

This is also a useful point to introduce the idea of "wildcards".  I could accomplish the two commands above with a single command:
```
$ file *
BirdList.txt:   UTF-8 Unicode text
Lab01_part2.md: ASCII text
```
In that example, "`*`" is a wildcard which means that the operation is applied to any file in the current directory.

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
$ file filename
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
In that example, "`*`" is a wildcard which means that the operation is applied to every file in the current directory.


### 2.  Being able to see the contents of a file

There are a number of basic things we might wonder about any data file, such as
* How many lines does it have?
* What is the structure?
* Does it have headers?

To answer these questions quickly, you might want tools that, say, count the number of lines, or tools that simply let you take a quick look at part or all of the file.

##### When `less` is more
As the saying goes, sometimes "less is more", and accordingly there is a command line tool called `less`.   It is used like this:
```
$ less filename
```
`less` is an *interactive* command line tool.  It opens a file and lets you browse it.  You can use the up and down arrow keys to move up or down a single line at a time.  You can also use the `b` and `f` keys to move back or forward by one page at a time.
Use the `q` key to exit from `less`.

**Try using `less` to inspect `BirdList.txt`**

##### Counting lines, and a digression about options and "`man`" pages
```
$ wc filename
```
`wc` will tell you the numbers of lines, words (separated by spaces), and characters in a plain-text file.  **Try using `wc` on `BirdList.txt`**

`wc` as used above has the familiar (partial) generic structure of many UNIX commands, namely:
```
$ command filename
```
`wc` also gives us a nice way to introduce another common part of UNIX command syntax, *options*:
```
$ command options filename
```
For example, suppose we only wanted to see the line count, and not any of the other information offered by `wc`.  As it turns out, `wc` has a built-in option for doing just that.
```
$ wc -l BirdList.txt
```
will show us the number of lines only.  Options in UNIX commans are also commonly referred to as *flags*. Hence, we could say that the last example uses the "`-l` flag", which someone would say verbally (if reading it outloud) as the "dash `l` flag" or "dash `l` option".


# Lab 01 - Getting Familiar with the Terminal

## This is "Part 2", which is meant to be done on your own after a brief "lecture"

## **REMEMBER**: There are NO stupid mistakes, only learning opportunities.

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
BirdList.txt:     UTF-8 Unicode text
Lab01_part2.md:   ASCII text, with very long lines
PredPreyData.csv: ASCII text
README.txt:       ASCII text
```
In that example, "`*`" is a wildcard which means that the operation is applied to every file in the current directory.

<hr>

### 2.  Being able to see the contents of a file

There are a number of basic things we might wonder about any data file, such as
* How many lines does it have?
* What is the structure?
* Does it have headers?

To answer these questions quickly, you might want tools that, say, count the number of lines, or tools that simply let you take a quick look at part or all of the file.

#### 2.a. When `less` is more
As the saying goes, sometimes "less is more", and accordingly there is a command line tool called `less`.   It is used like this:
```
$ less filename
```
`less` is an *interactive* command line tool.  It opens a file and lets you browse it.  You can use the up and down arrow keys to move up or down a single line at a time.  You can also use the `b` and `f` keys to move back or forward by one page at a time.
Use the `q` key to exit from `less`.

**Try using `less` to inspect `BirdList.txt`**

You can also see just the first few lines or last few lines with the commands `head` and `tail`, respectively, i.e., 
```
$ head BirdList.txt
````
and
```
$ tail BirdList.txt
```
Those commands will, by default, print the first 10 or last 10 lines of the file to the terminal window.

#### 2.b. Counting lines, and a digression about options and "`man`" pages
```
$ wc filename
```
`wc` will tell you the numbers of lines, words (separated by spaces), characters, and bytes in a plain-text file.  **Try using `wc` on `BirdList.txt`**

Now here's the digression...   `wc` as used above has the familiar (partial) generic structure of many UNIX commands, namely:
```
$ command filename
```
 `wc` also gives us a nice way to introduce another common part of UNIX command syntax, *options*:
```
$ command options filename
```
For example, suppose we only wanted to see the line count, and not any of the other information offered by `wc`.  As it turns out, `wc` has a built-in option for doing just that.  The command
```
$ wc -l BirdList.txt
```
will show us the number of lines only.  Options in UNIX commands are also commonly referred to as *flags* and are given with something that starts with one or two hyphens. Hence, we could say that the last example uses the "`-l` flag", which someone would say verbally (if reading it outloud) as the "dash `l` flag" or "dash `l` option".  **Try it yourself!**  Remember: a hyphen (i.e., a dash) immediately following the space after a command name always indicates an option (i.e., a flag).

But how would you know that `wc` has this option?  How would you know what options any command might accept (since they are all different)?  Luckily (but not in Windows git bash, sorry), there's a *man*ual built in.  (Windows users of git bash: you can get the man pages online at [http://man.he.net/](http://man.he.net/).)  The manuals for UNIX commands are in a form that people call "man pages", accessible like this: 
```
$ man wc
```
will show you a kind of barebones manual for the `wc` command, including the options available.  To exit the "man page", type the letter `q`.  To move up and down in the man page for a command, use the up and down arrow keys, `space bar` (to page forward), or `b` key (page back).  Navigation commands that work in `less` generally work in `man` and vice versa. Note that in the man page for `wc`, one finds the `-l` option as well as several others.  Try them out!

#### 2.c. Extracting lines from files that match a criterion.
There are many cases in which one might want to subset one's data.  Sometimes this would be best done as a step in the statistical analysis (e.g., while working in R).  But, there are many cases when one might want to create and/or explore subsets prior to analysis.  One of the simplest ways to do this is with pattern matching.  The tool known as `grep` is a way to search for "regular expressions".  For more technical info on what "regular expressions" are, see [this link](https://www.regular-expressions.info/).  We're going to keep it very simple for now...

For example, suppose you wanted to look at only the lines of our data file `BirdList.txt` that contain the word "Duck".  How would you do that if you didn't have a programming way?  Search manually, copy one-by-one, and paste?  Compare that to the following:
```
$ grep Duck BirdList.txt
```
That command will print to the screen all the lines of the file that contain "Duck".  Note that this is case-sensitive, like just about everything else in programming.  To prove that to yourself, contrast the output of that command with what you get from
```
$ grep duck BirdList.txt
```
Do you have a favorite bird?  A favorite family of birds?  Try "grepping" it!  Don't know birds?  No problem, try finding lines of the file that mention Sparrow or Robin or Goose.

<hr>

#### 3. Combining small tools for big results

The philosophy of UNIX command line tools is that each command/tool does one thing well.  When you want to do some multi-part, complex thing, you don't make a new tool that does it all; you combine small tools together in powerful ways.  Part of the beauty of the small tools is in the flexibility you acquire in creative combinations of them.

#### 3.a. "Redirection"
What if you wanted to keep a list of just the sparrows?  Printing it to the screen would only be temporary.  To keep it, you'd want to put it into a file.  That's where "redirection" comes in handy.  The following command
```
$ grep Sparrow BirdList.txt
```
would just print the sparrows to the screen.  We could copy and paste that into a file, but there's no need for that.  We can do it in a much more quick and elegant way.
```
$ grep Sparrow BirdList.txt > SparrowList.txt
```
In this example, the "greater than" sign (`>`) is called the "redirection operator".  It redirects the output of the command into the file of our choosing.  In this case, a new file will be created, named "SparrowList.txt", which would have the output rendered by the `grep` command.  **CAUTION**: The redirection action does NOT check to see if you already have a file of that name.  If you had an old "SparrowList.txt" and gave the last command, your old list would be gone forever.  That's fine if you were planning on an update to the data, but not fine if you wanted to keep the old file around.  Hence, you should always check (use `ls`) the contents of your directory prior to redirecting output to a file.

#### 3.b. Appending output: Redirection with concatenation
Using the `>>` operator works like `>` except that, rather than over-writing the destination file (if it already exists), it appends the output to the end of the file (if it already exists) or makes a new file only if the named file did not already exist.
For example:
```
$ grep Duck BirdList.txt > DucksAndGeese.txt
$ grep Goose BirdList.txt >> DucksAndGeese.txt
```
would make a single file, named "DucksAndGeese.txt", that would have the outputs of BOTH of those commands in it.  **Try those commands and verify the output by using one fo the above commands (e.g., `less`) to look at your newly created file.**

#### 3.c. Piping
Programmers can create amazingly powerful and elegant "one-liners" by combining multiple command line tools in a single line.  The idea is that the output of one command becomes the input to the next command.  The tool that makes this possible is called a "pipe".  It's typed as `|`, which is the vertical line symbol, found on most keyboards underneath the backspace or delete key near the upper right hand corner of the keyboard.  You can think of a pipe as being a tool for making a "pipeline."  For example, suppose we wanted to know how many lines of our file mention the word "Goose".
```
$ grep Goose BirdList.txt | wc -l
```
Note that the output of the first command, `grep`, is "piped" to the second command, `wc`.  Because that piped output becomes the input for the latter command, there is no file name supplied for the `wc` command.  In other words, instead of getting its usual kind of input (a file), `wc` gets its input "piped in" from the previous command.  There's no limit to the number of pipes you can have in a single line of commands, which creates nearly infinite flexibility for combining different commands, or even the same command multiple times.  For example, if you do 
```
$ grep Swallow BirdList.txt 
```
(try it), you'll get output that includes Swallows but also includes "Swallow-tailed" birds that aren't swallows at all!  Suppose you just wanted the actual Swallows?  Try the following instead:
```
$ grep Swallow BirdList.txt | grep -v Swallow-tail
```
Compare the output of that latter command with the former.  Based upon that, can you guess what the `-v` flag does with `grep`?  Check out the `man` page for `grep` if you aren't sure.

<hr>

#### 4. Open-ended problems

A. Try adding on to the last command (with one or more pipes) to (i) get output that does not have the line saying "Swallows  (Hirundinidae)", but rather ONLY has the species names, and (ii) get a count of the number of Swallow species listed in `BirdList.txt`.  You might try doing this with only the tools above.  You might additionally do a Google search for how `grep` for whole words or a word at the end of a line.

B. Play around with the commands above.  What are some questions you could ask about the data in `BirdList.txt`?  Can you answer those questions with the tools above? If not, do a google search like "how to [what you need] in UNIX terminal".  It may be easier to just search for "BASH command for [what you need]" or "how to [what you need] in BASH", since BASH is the shell you are most likely using in your terminal.  (FYI, You can see what shell you are using for sure with the command `echo $SHELL`.  The output of this command will be a file path to the shell being used.  For example, in Sam's terminal he sees as output `/bin/bash`.) 

C.  Do you have any plain text files on your computer?  Perhaps some `.txt` or `.csv` files?  Make a copy of one of them into your `compBioSandbox` and then use the commands above to explore it.  If you can't think of one, open an Excel spreadsheet and "`Save As...`" to a `CSV UTF-8 (Comma Delimited) (.csv)`.  If you're up for an adventure, try using the `cp` command to do the copying, but remember: be careful because there is no undoing it once you've done it!  So, don't try your first `cp` on something important unless you are very sure of what you're doing.  You can find a guide to `cp` at [this link](http://www.linfo.org/cp.html).

<hr>

#### 5.  If you have time (or on your own to just learn more) ... 

Working with the provided data file `PredPreyData.csv`.

* Open and read the README file in Lab01 to learn about the data file  `PredPreyData.csv`.
* Take a look at the provided data file `PredPreyData.csv` in the Lab01 directory.  Compare how this looks when you use `less` to look it compared to how it looks if you open it in Excel.  What do you notice about the differences in appearance?  Why might these differences matter?
* Note that by default, R has added a column, the first column, which R regards as "row names".  These exist for all data frames in R by default, and the `write.csv()` command, which was used to create the file, puts them into the data file by default.  There are options in `write.csv()` to prevent that behavior, but let's suppose it's too late for that.  Suppose you wanted to remove the first column easily on the UNIX command line?  Or suppose that in general you only wanted to work with certain columns of data from a `.csv` file?  If you do a Google search for that problem, you'll find lots of ways.  One of the simple ones is `cut`.  It works like this:
```
$ cut -f [columns you want] -d [delimiter between columns] filename
```
Note that this looks complicated, but it follows the same construction common to all UNIX commands: `commandname options filename`.  Having inspected `PredPreyData.csv`, we know it has four columns; we want the last three (i.e., columns 2 through 4).  We also know that it is comma-separated, i.e., the delimiter for this file is the comma.  Hence, to get rid of the column of "row names", we could do (but DON'T do this yet):
```
$ cut -f 2-4 -d , PredPreyData.csv
```
The reason NOT to do this yet is that, if you do, you'll get 1001 lines of data output to your terminal window.  That's not necessarily bad, but it might take your computer a while to do that.

Before we solve that problem, let's just digest the command, and turn it from BASH syntax and code into our own English version.  In the plainest English I can imagine, here's what we are asking the shell to do with that command if we "read" it from left to right: "Use the `cut` tool to keep columns 2-4 of the comma-delimited file named `PredPreyData.csv`".  But, we didn't tell BASH where to put the results, so it would just put them in the terminal window for us to see.  That's the default behavior.

Problems which involve applications of tools described previously in this lab:
* Which tool from above could you add on to the `cut` example above to get the output to go into a file instead of into the terminal window?
* How could you combine the `cut` example above with some other tools above to see only the last 10 lines of output?
* How could you, perhaps in multiple commands, make a new data file that had (i) only columns 2-4, (ii) the header row, and (iii) only the last 10 lines of data?  In other words, what commands could you issue to create a new `.csv` file with 11 lines of data total and three columns total, in which the top line should be the original headers, and the other 10 lines should be the last 10 lines of the original data?









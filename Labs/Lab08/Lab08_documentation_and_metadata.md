# Lab 08: Documentation and Metadata

### Goals for this lab:
* practice creating metadata files for your work
* practice using Markdown

### Exercises:

Remember way back in week #1 when we worked on software requirements for the class?  Well, now we are finally going to use the final piece: a markdown editor.

1. Complete the Markdown tutorial available at [http://www.markdowntutorial.com/](http://www.markdowntutorial.com/).  

2. Re-write the README for your class repo in markdown.  If you don't have a markdown editor installed, I suggest you try [StackEdit](https://stackedit.io/app#).  (Note: if you do use StackEdit, I do NOT suggest trying to "publish" or link to GitHub.  Instead, choose "Export to File" to save it to your local repo on your own computer.)  Your new README file should have at least one heading, and some good descriptive text about the contents of the repo.  Note that your new README file should be in the top level directory of your repo (do NOT put it in a "Lab08" sub-directory, for example).  Once you are happy with your new README file, use `git rm` to remove the old readme.  The difference in file names should be that the new one is named `README.md` and the old one should have been `README.txt`.    

3. Recall problem #7 from [Week 4's lab (on writing loops)](https://github.com/flaxmans/CompBio_on_git/blob/master/Labs/Lab04/Lab04_ForLoops.md).  That problem asked you to write code that could implement the discrete-time logistic growth model.  Starting with that code, please do the following:

    a. Create a new script in a directory for Lab08 that contains this code (it is fine to copy and paste from your own work)

    b. Turn the logistic growth model code into a function that takes `r` (the intrinsic growth rate), `K` (the carrying capacity), the total number of generations, and the initial population size as its arguments. 
    
    c. Add code to the function so that it produces a plot of the data it generates (i.e., it should plot abundance over time).  Note that the axes should be labeled appropriately.
    
    d. Following the function, write a line(s) of code that calls the function (you choose the parameter values).
    
    e. Write a line(s) of code that writes the data set to a file (also in your Lab08 directory).  The data file should have two columns: the first column should be "generations", and the second column should be "abundance".
    
    f. Make a new markdown document explaining the script.  This markdown document should also be in the directory for Lab08.  This markdown document will be the metadata file that explains the script, the model it contains, what it does, and the specific data that were written to the data file.  Use headings, bulleted lists, and other capabilities of markdown as you see fit.  Make the document look good, easily readable, and functional.
    
    
* BONUS 1: include a hyperlink in your markdown document from part 3f that points to the source file for Lab

* BONUS 2: save a plot from your model as an image.  Find a way to include that image in the rendered appearance of your markdown document from part 3f.  The image should be contextualized as example output of your model.


### Completing the exercises above:
Completing the above exercises and pushing your work to Github constitute Assignment 07.


# Week 2, Lab 2
## *Goals*: 
* Get acquainted with git
* Set up your account on GitHub.com
* Set up your user account on your machine
* Practice a couple of iterations of the `git add`, `git commit` cycle
* Push commits to GitHub
* Finish all of this and turn it all in (i.e., push everything) by Wednesday of week 3.

## *Steps for this lab*:

Before embarking, in your terminal, navigate (with `cd`) to your clone of Sam's github repo and once you are in that repo (i.e., once your working directory is `../CompBio_on_git/`), give the command `git pull` to get the most up-to-date version of Sam's repo.  I recommend doing this at least once per week since Sam is always tweaking and updating.

### I. You Need a Github.com Account
[Make an account on GitHub.com](https://github.com/join) if you have not done so already

<hr>

### II. Working in the Terminal to set up your git config file:
In your terminal, you need to configure your git user account with the following commands: 
 
	git config --global user.email "you@email.com"
	git config --global user.name "yourname"

**NOTE: the email and user name MUST match the email and user name you are using at GitHub.com**.  You will NOT have to do this again on your computer.  If you use a new computer (or a new virtual machine), you will have to do this.

<hr>

### III. Working in your terminal to set up a git repo for YOUR assignments and labs in this class
**NOTE:** This is not for the stuff Sam puts on Github, but rather the stuff YOU create.  Please make sure that this directory is NOT a child (subdirectory) of any other existing git repo.

1. In your terminal, navigate (using `cd`) to whatever directory you want to use to store things for this class that will go on Github
2. In your terminal, use the following command to make a new directory:

	`mkdir CompBioLabsAndHomework`

3. In your terminal, `cd CompBioLabsAndHomework` (i.e., cd into that new directory)
4. Are you sure you are in the new directory you just created? If yes, then initiate a new git repository.  Do you remember the command to initiate a new repository?
5. Working in your CompBioLabsAndHomework directory, make a new directory called "`Labs`" (no quotes, of course; note `mkdir` command above)
6. `cd` into `Labs`
7. make a new directory called "`Lab02`" (i.e., `Lab02` should be a sub-directory of `Labs`)
8. Put your plain-text cookie recipe in the `Lab02` directory
9. Check `git status`.  What do you see?
10. Add and commit all the files in this directory.  *Do you remember the steps for adding and committing?  Don't forget the commit message!*  
11. Edit your cookie recipe in some way.  Save, add, and commit.
12. Repeat the previous step a few times (so that you have a few commits)

**NOTES** about adding and committing related to your current working directory: 
+ Your current working directory has to be `CompBioLabsAndHomework` or one of its children to use git commands with this repo.
+ As long as your current working directory is `CompBioLabsAndHomework` or one of its children, the `git status` and `git commit` commands should work.  For `git add`, note that you will have to specify a proper path to the file if it is not in your current working directory.  For example if your current working directory were `../CompBioLabsAndHomework/Labs/Lab02/`, then you could simply do `git add CookieRecipe.txt` (assuming it's in that repo).  However, if your current working directory were `../CompBioLabsAndHomework/`, then to stage the same file for a commit you would have to do `git add Labs/Lab02/CookieRecipe.txt`.


<hr>

### IV. Set up a repo for this class on Github.com
1. Start a new project (i.e., a new repository).  Depending upon where you are, you might see a button to do this, or you might need to click on the "+" sign in the upper-right-hand corner of the github page.
2. Name the new repository CompBioLabsAndHomework
3. Do NOT initialize this repository with any files
4. Note the link it gives you under "Quick Setup".  It will look something like this: https://github.com/*yourusername*/CompBioLabsAndHomework.git .  You will probably want to copy this link from the browser page.  Github even provides a tiny clipboard icon button, right next to that link, that you can click to copy the link perfectly to your clipboard.
5. Leave your browser window open and on this page.

<hr>

### V. Linking your local .git repository to Github.com, and pushing your commits
1. Return to your terminal and make sure you are still in the local CompBioLabsAndHomework on your computer
2. Designate the "remote" (i.e., online) repo with  
	`git remote add origin your_repos_github_URL`,  
	where "`your_repos_github_URL`" should be replaced by the actual link you copied from "quick setup" noted above (in part IV.)
3. It's time to "push": the following command will push your local .git repo to the the address that you just designated as the remote:  
	`git push -u origin master`  
	Don't worry about the meaning of the "-u" flag for now.
	Note that you will likely be prompted to give a username and password; these need to be your github username and password.
4.  Go back to your browser and refresh.  The cookie recipe should be there now.
5.  LETTING SAM KNOW about your GitHub repository for this class.  Please take a moment right now to send Sam your GitHub repo's link by filling out [this form](https://docs.google.com/forms/d/e/1FAIpQLSfNiq_wvI-Dfi0C5t2kQF7-v3qBQSr-brgARnpJt9LfkD7Y5Q/viewform?usp=sf_link).



<hr>

### VI. Documentation
Best practices dictate that repositories have easy-to-read descriptions that help people know the purpose.  This is called a README file.
    
1. In your Terminal, navigate to CompBioLabsAndHomework. 
2. Make a text file there called README.txt
3. In that text file, write a description of what you think the repo will be.  Type nicely, with nice formatting, and complete, grammatically correct sentences.  Remember, you're sharing this with the world! :-) 
4. Save, add, commit, and push.
5. Go back to your browser window and refresh again.  How does the appearance of the online repo change?

<hr>

### VII. Examining the work you have done
In your terminal, use `git log` and `git diff HEAD~N filename` to review the changes you have made during your work in your local repo, where "`N`" is the number of commits ago to which you want to look back.  If you are feeling brave, try `git checkout HEAD~N filename` to look at previous versions of the cookie recipe.  However, **make sure you have indeed committed the most recent version BEFORE you try to `checkout` a previous version**.  NOTE: "`N`" in these examples is *not* what you literally type.  It represents an integer number of your choosing.

Also, if you indeed do a "checkout" operation, to get back to the most recently committed version of your repository, use
```
$ git checkout master
```

<hr>

### VIII. A shell script
Formalizing Lab01's work

Recall the [final task from last week's Lab](https://github.com/flaxmans/CompBio_on_git/blob/master/Labs/Lab01/Lab01_part2.md#5--if-you-have-time-or-on-your-own-to-just-learn-more-).  Note in particular the last three bullet points, which comprised a data-subsetting problem.  The task now is to write down in a plain text file a sequence of commands that would work to accomplish the final bullet point of last week's lab.  Before you begin, think about the task from start to finish.  I would suggest the following as steps: 
1. make a new directory for Lab01 (where should that directory be?)
2. copy the data file named `PredPreyData.csv` from your clone of Sam's repo into your own directory for Lab01
3. make a plain text file in your Lab01 directory called `Lab01finalProblem.sh`.  Note that the `.sh` file extension is used here to indicate that this will be written as a shell script, i.e., a sequence of commands that can be implemented directly by the shell (i.e., in your terminal)
3. Type a sequence of working commands in that file that when executed in the order you give them, accomplish the task given by the final bullet point of last week's lab.
4. If your script is correct, Sam should be able to run it without error.  Note that it will probably only be a few lines long.  There is nothing wrong with brevity and simplicity.
5. When you are done, save it, and then use git to add, commit, and push.


### *Finishing this lab*
Please complete all steps of this lab by Wednesday of week 3 of class.


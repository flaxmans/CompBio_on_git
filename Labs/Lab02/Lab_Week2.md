# Week 2, Lab 2
### *Goals*: 
* Get acquainted with git
* Set up your account on Github.com
* Set up your user account on your machine
* Practice a couple of iterations of the git add, git commit cycle
* Push a repository to Github

### *Steps for this lab*:


#####I. A Github.com account
Make an account on Gitbhub.com if you have not done so already

<hr>

#####II. Working in the Terminal to set up your git config file:
In your terminal, you need to configure your git user account with the following commands: 
 
	git config --global user.email "you@email.com"
	git config --global user.name "yourname"

**NOTE: the email and user name MUST match the email and user name you are using at Github.com**  You will NOT have to do this again on your computer.  If you use a new computer (or a new virtual machine), you will have to do this.

<hr>

#####III. Working in your terminal to set up a git repo for YOUR assignments and labs in this class
**NOTE:** This is not for the stuff I put on Github, but rather the stuff YOU create.  Please make sure that this directory is NOT a child (subdirectory) of any other existing git repo.

1. In your terminal, navigate (using `cd`) to whatever directory you want to use to store things for this class that will go on Github
2. In your terminal, use the following command to make a new directory:

	`mkdir CompBioLabsAndHomework`

3. In your terminal, `cd CompBioLabsAndHomework` (i.e., cd into that new directory)
4. Are you sure you are in the new directory you just created? If yes, then initiate a new git repository.  Do you remember the command to initiate a new repository?

4. Working in your CompBioLabsAndHomework directory, make a new directory called "Lab02"
6. cd into Lab02
7. Put your plain-text cookie recipe in this directory
8. Check `git status`.  What do you see?
9. Add and commit all the files in this directory.  You may have to cd up to the parent directory to do so.  Do you remember the steps for adding and committing?  Don't forget the commit message!  Also, if you are in the "Lab02" folder, you will most likely need to cd up 
10. Edit your cookie recipe in some way.  Save, add, and commit.
11. Repeat the previous step a few times (so that you have a few commits)

<hr>

#####IV. Set up a repo for this class on Github.com
1. Start a new project (i.e., a new repository).  Depending upon where you are, you might see a button to do this, or you might need to click on the "+" sign in the upper-right-hand corner of the github page.
2. Name the new repository CompBioLabsAndHomework
3. Do NOT initialize this repository with any files
4. Note the link it gives you under "Quick Setup".  It will look something like this: https://github.com/*yourusername*/CompBioLabsAndHomework.git .  You will probably want to copy this link from the browser page.  Github even provides a tiny clipboard icon button, right next to that link, that you can click to copy the link perfectly to your clipboard.
5. Leave your browser window open and on this page.

<hr>

#####V. Linking your local .git repository to Github.com, and pushing your commits
1. Return to your terminal and make sure you are still in the local CompBioLabsAndHomework on your computer
2. Designate the "remote" (i.e., online) repo with  
	`git remote add origin [url]`,  
	where [url] should be replaced by the link you copied from "quick setup" noted above (in part IV.)
3. It's time to "push": the following command will push your local .git repo to the the address that you just designated as the remote:  
	`git push -u origin master`  
	Don't worry about the meaning of the "-u" flag for now.
	Note that you will likely be prompted to give a username and password; these need to be your github username and password.
4.  Go back to your browser and refresh.  The cookie recipe should be there now.

<hr>

#####VI. Documentation
Best practices dictate that repositories have easy-to-read descriptions that help people know the purpose.  This is called a README file.
    
1. In your Terminal, navigate to CompBioLabsAndHomework. 
2. Make a text file there called README.txt
3. In that text file, write a description of what you think the repo will be
4. Save, add, commit, and push.
5. Go back to your browser window and refresh again.  How does the display change?


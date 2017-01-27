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
	git config --global user.name "myname"

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
9. Add and commit all the files in this directory.  Do you remember the steps?  Don't forget the commit message!
10. Edit your cookie recipe in some way.  Save, add, and commit.
11. Repeat the previous step a few times (so that you have a few commits)

<hr>



#####IV. Working on Github.com
1. Start a new project.  Depending upon where you are, you might see a button to do this, or you might have to click on the "+" sign in the upper-right-hand corner of the github page.
2. Name the new project "CompBioLabsAndHomework" (but do NOT include the quotes)
3. Do NOT initialize it with any files
4. Note the link it gives you under "Quick Setup".  It will look something like this: https://github.com/*yourusername*/CompBioLabsAndHomework.git .  You will probably want to copy this link from the browser page



# Software requirements and recommendations for EBIO 4420/5420 - Computational Biology

## For ALL, no matter what kind of computer and OS you have:
* Everyone will need a "text editor" for editing "plain text".  Chances are you already have at least a basic one on your computer, even if you have never used it.  You can edit plain text with a wide variety of software offerings (that's part of the beauty of plain text!).  For example, you can use RStudio if you wish.  On a Mac, you can also/alternatively use something like TextEdit.app (included with Mac OS),  TextWrangler (free download), or XCode (see below).  On a Windows machine, you can use something like Notepad, RStudio, or any of many other offerings.  I welcome suggestions from Windows users!   Likewise for Linux users.  If you want to feel like true "programmer", you can try out various command-line editors, such as vim, atom, or emacs.  If things like that are intimidating, don't worry; you won't have to use them unless you want to (at least, not yet...).

## For Mac Users only:
* Download and install XCode from the App Store.  Once XCode is installed, it is a good idea to install command line tools.  A decent guide for doing so is available at [http://railsapps.github.io/xcode-command-line-tools.html](http://railsapps.github.io/xcode-command-line-tools.html)
* Download and install Git from [https://sourceforge.net/projects/git-osx-installer/files/](https://sourceforge.net/projects/git-osx-installer/files/)
* Download and install R by following instructions at [https://cran.rstudio.com/](https://cran.rstudio.com/)
* Download and install RStudio by following instructions at [https://www.rstudio.com/products/rstudio/download3/](https://www.rstudio.com/products/rstudio/download3/)
* Download and install a Markdown editor.  I like Mou ([http://25.io/mou/](http://25.io/mou/)), but others are available. 


## For Windows Users only: 
Windows users will need to emulate a UNIX-style terminal.  There are several ways to do this.  If you have a preferred method, please use it.  If not, I suggest running VirtualBox, because that will give you a fully functional Linux operating system to use without actually having to change your Windows computer.  If you want to use VirtualBox, do the following exactly in the order given here:

1. Download (but do NOT try to open) a virtual installation CD of Ubuntu from [https://www.ubuntu.com/download/desktop](https://www.ubuntu.com/download/desktop)
2. Download and install VirtualBox from [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)
3. Run VirtualBox and use it to set up an Ubuntu virtual machine ("vm").  This will require using the download from Step 1.  A good set of directions is available at [http://www.psychocats.net/ubuntu/virtualbox](http://www.psychocats.net/ubuntu/virtualbox)
4. Once all of that is done, use VirtualBox to start your Ubuntu vm (this is the vm you created as part of step 3).
5. Follow the prompts within Ubuntu to create and set up your Ubuntu user account.
6. When all of that is done, *while still in your Ubuntu vm*, follow all the steps for Linux users below.
7. You will also need a Markdown editor.  I suggest trying Remarkable, which you can install on your Ubuntu virtual box (see below)

## For Linux Users and those using VirtualBox to run Ubuntu:
* Open a Terminal window and install Git by typing `sudo apt install git` at the command prompt
* Also using the Terminal, install R and RStudio by following the instructions at [https://www.r-bloggers.com/how-to-install-r-on-linux-ubuntu-16-04-xenial-xerus/](https://www.r-bloggers.com/how-to-install-r-on-linux-ubuntu-16-04-xenial-xerus/)
* You will also need a Markdown editor.  I suggest trying Remarkable if you don't have a preference.  Go to [https://remarkableapp.github.io/linux/download.html](https://remarkableapp.github.io/linux/download.html).  Click on the link for "Download .deb".  When it finishes downloading, in your terminal:
	1. `cd ~/Downloads`
	2. `sudo dpkg -i remarkable_1.87_all.deb`  
(assumes the version is 1.87)
	3. `sudo apt-get install -f`  
	
	Remarkable should now be available as an application




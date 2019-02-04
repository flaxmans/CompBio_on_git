# Syllabus and Course Policies for EBIO 4420/5420 Computational Biology

**STUDENTS:** Contents of this repository will change often during the semester.  Please check  back at least weekly ("pull" updates).

## Aims and Scope
This is a course for scientists who want to learn basic tools of modern computing.  Students with in-depth experience in computer science will probably NOT find sufficient challenge from this course.

#### What the course is:
This course's main learning goals are for students to: 

1. Discover and implement computational tools for making their own professional work efficient, reproducible, transparent, shareable, maintainable, and robust.
2. Learn and use tools of programming at a basic level, including but not limited to writing programs and scripts in R, using the git version control system, and using Github to share and publicly archive projects.
3. Learn and apply tools for handling data (filtering, manipulating, subsetting, concatenating, re-formatting)
4. Learn and apply tools for simulating biological systems to generate pseudo-data and test hypotheses, including difference-time models, stochastic models, and ordinary differential equations models.


#### What the course is not:
This course is intended to give you tools that should help you in other courses focused on topics like "genomics," "bioinformatics," and "statistics," but this is NOT a course that will teach you those subject areas.
______________________________

## Logistics and Contact Info

#### Course meeting times and locations: 
TTH, 2:00 - 2:50, EKLC M203
Fridays: noon - 1:50, RAMY N1B75

#### Office Hours: 
Thursdays from 12:30 - 1:30 p.m.

Office Location: Ramaley N211

#### Contact:
Email Sam: <samuel.flaxman@colorado.edu>

Office Phone: 303-492-7184
______________________________

## Week-by-Week Agenda  
(subject to change and frequent updating; note that accompanying PowerPoint files are available at a [Dropbox folder][dropboxlink])

###### Week 1: 
+ Topics
	+ Mutual expectations
	+ Implicit bias
	+ Logistics of course
	+ Pitfalls of computing: case in point: don't use Excel (see paper by Ziemann et al. 2016)
	+ UNIX Command Line  

+ Action Items required of YOU:
	+ **[Assignment 01](https://github.com/flaxmans/CompBio_on_git/blob/master/Assignments/01_Day1_SoftwareInstalls.md) announced on first day of class and due on 1/18!**
	+ **Please visit [this tutorial](http://linuxcommand.org/lc3_learning_the_shell.php)** and read through that page **AND items numbered 1-5 near the bottom of that page**.  

+ Lab week 1: Doing stuff with the UNIX command line
	
###### Week 2:
+ Git intro
+ Lab week 2: git
+ Action items: 
    + [Assignment02](https://github.com/flaxmans/CompBio_on_git/blob/master/Assignments/02_Week2_CookieRecipe.md)
    + [Send your GitHub repo's URL to Sam](https://goo.gl/forms/PhPGZPvE7fP3vW3R2)
+ Want to see live demonstrations of the key steps related to using `git` basics?  Sam made these screencasts for that purpose:
    + [Global user configuration settings](https://youtu.be/jPAB9BW1yXc), i.e., `git config ...`
    + [Initialize a new repo and link it to GitHub](https://youtu.be/8Ln6pjFrdvw), i.e., `git init` and `git remote add origin ...`
    + [Make a README, `add`, `commit`, and `push`](https://youtu.be/YwzEhb4Tf-g)

###### Week 3:
+ Follow up from lab: remaining uncertainties?
+ Best practices: git, files, comments, README
+ Intro to R and scripting with R
+ Lab week 3: some simple scripting (and of course using git with the script(s))
+ Action Items: [Assignment 03](https://github.com/flaxmans/CompBio_on_git/blob/master/Assignments/03_TasksForWeekThree.md) announced on Tuesday, due on Monday next week. 
+ For lab, please watch these three (short) YouTube videos if you are new to R, and follow along by doing everything the narrator does on your own computer:
    + [intro](https://youtu.be/TG77MVHfC8E)
    + [vectors pt 1](https://youtu.be/A2Sh7uBwQv0)
    + [vectors pt 2](https://youtu.be/lNZQnLu_AWM)
+ Hints and help: 
    + If you are experiencing conflicts with git, check out [this screencast](https://youtu.be/jIV_toWa5Zc).
    + Want to get ahead and prepare for lab?  If you are new to `R` (or feeling *R*usty), I **strongly** suggest checking out "`swirl`".  To do to so, follow the steps at [this link](https://swirlstats.com/students.html), and then do the first module of the first “course” it offers (“`1. R Programming`” --> “`1. Basic Building Blocks`”).
        + Note that everything to do with `swirl` is done WITHIN R/RStudio.
        + Obviously, if you want to do additional modules of `R Programming` within `swirl`, go for it!

###### Week 4
+ More R and Scripting
+ Best practices for writing scripts and handling data
+ Lab week 4: looping with `for` and array indexing
+ Action Items:
    + Assignment 4 (pushing Lab04)
    + Read the ["Best Practices" Guide](https://github.com/flaxmans/CompBio_on_git/blob/master/CourseDocuments/BestPractices.md)
 
###### More to come soon!

[dropboxlink]: https://www.dropbox.com/sh/dd7mpvmbdgyenoo/AAAgi560clFs7_H_XG69by60a?dl=0

_____________________________

## Grading policies 
This is a full, 3-credit course. You should expect to work as hard for these three credits as you do for any other advanced class.  Your final grade will be based upon a combination of (1) in-class participation, (2) formal assignments, (3) an independent project, (4) a take-home final examination, and (5) demonstrating enthusiasm and sincere effort for the material and the assignments.

1. In-class participation will constitute 22.5% of your overall grade.  It will be based partially on attendance (you can’t participate without being there, right?), but mostly upon your work with others and your presentations to the class. Presentations to the class that fall in the participation category are “reporting out” exercises where you share the results of group work, sometimes at the front of the room using your own computer and/or the document camera.  Participation will also include discussions in class and demonstrations of your reasoning and problem solving (on paper and/or on your computer).  For most class periods, I will grade your participation on a scale from 0 to 5, with the approximate meanings of each as follows:  <br>
0 = absent  <br>
1 = showed up but did not engage; very unprepared; very late  <br>
2 = late; engaged minimally; not fully prepared  <br>
3 = on time and paid attention, but didn't participate  <br>
4 = average preparation and participation  <br>
5 = made an excellent contribution to the day's class

2. Formal assignments and presentations will constitute 42.5% of your overall grade.  Assignments will include written homework problems, computer code, and written responses to readings and exercises.

3. An independent project will be announced just before or after spring break. This project will constitute 15% of your overall grade. The project will be built from a series of assignments during the semester.

4. A take-home final examination will be given out on the day of our final designated by the University. You will have 24 hours to complete it.  It will be open-book, but you must work alone.  This exam will constitute 15% of your final grade.

5. Enthusiasm. 5% of your grade will be based upon a subjective evaluation (by me) of your general enthusiasm and effort for participating in all aspects of the course.  This not only includes your attitude toward class participation, but also things like really cleaning up your code nicely, polishing the work you show/turn in, etc.

Please note that all grades will be posted on the Course's [Canvas site][CanvasSiteLink]

[CanvasSiteLink]: https://cuboulder.instructure.com/courses/25233
_____________________________

## Statements about General Policies and Expected Conduct of Students, Faculty, and Staff

#### Live the [Colorado Creed](http://www.colorado.edu/creed/)
From [http://www.colorado.edu/creed/](http://www.colorado.edu/creed/), accessed 1/2/17:  
"As a member of the Boulder community and the University of Colorado Boulder, I agree to:

* Act with honor, integrity and accountability in my interactions with students, faculty, staff and neighbors.
* Respect the rights of others and accept our differences.
* Contribute to the greater good of this community.

I will strive to uphold these principles in all aspects of my collegiate experience and beyond."

#### Diversity and Inclusion
Research in educational settings suggests that students in a course benefit from the presence of diversity in the viewpoints, identities, and experiences of students and instructors.  In order for all of us to benefit to the greatest extent possible, together we need to value and respect each other as individuals and as contributors.  For my part, I want you to know that my classroom and office are intended to be welcoming, safe spaces for all students, regardless of any dimension of your identity.  I am happy to address you by whatever preferred name and pronouns you wish to use.  I welcome your suggestions for how I can make myself and/or any of the course content more inclusive.  For your part, I expect you, at a bare minimum, to abide by all campus codes of conduct and to live the Colorado Creed.  I also encourage you to think of this classroom as a community, and to treat your fellow community members in ways that foster an atmosphere in which all of us feel comfortable talking and sharing with each other.  During discussions and collaborative activities, try to find ways to invite others to share their ideas and viewpoints, and look for ways to help others feel valued for their contributions.

#### Implicit biases
Research from the fields of psychology and sociology demonstrates that ALL of us, no matter what our identities, have implicit biases.  Having implicit biases doesn't mean that you are bigoted.  Rather, these biases are present in each of us, subconsciously, owing to stereotypes we have been *repeatedly* exposed to, over and over again in our lifetimes as human beings.  A very common implicit bias that is relevant to this class has to do with people's (often unconscious) assumptions about innate abilities in math and computer programming.  Many people hold an implicit bias that one gender is inherently better at math and computer programming than another.  Research shows that this implicit bias is *equally present in both men and women*.  The bad things about implicit bias are that it leads to (1) self-reinforcing perpetuation of stereotypes and the bias itself, and (2) underperformance in people who have an implicit bias against some part of their own identity.  The good thing is that it is fairly easy to overcome by simply explicitly acknowledging that the bias is there but is not justified.  

I do not believe that any of you are inherently "good" or "bad" at math or computers.  I believe we all need practice, and we all can contribute.  There is no evidence that people from a particular gender, race, culture, age group, or ethnicity are innately better than others at the things I will ask you to do in this class.  You can all do equally well, no matter your identity.

### Campus Policies that Apply to all Courses

#### For an accessible version of the statements required in every syllabus:
Please see the following link: [https://www.colorado.edu/academicaffairs/node/390/attachment](https://www.colorado.edu/academicaffairs/node/390/attachment)

#### Accommodation for Disabilities: 
If you qualify for accommodations because of a disability, please submit your accommodation letter from Disability Services to your faculty member in a timely manner so that your needs can be addressed.  Disability Services determines accommodations based on documented disabilities in the academic environment.  Information on requesting accommodations is located on the [Disability Services website](https://www.colorado.edu/disabilityservices/students). Contact Disability Services at 303-492-8671 or [dsinfo@colorado.edu](mailto:dsinfo@colorado.edu) for further assistance.  If you have a temporary medical condition or injury, see [Temporary Medical Conditions](https://www.colorado.edu/disabilityservices/students/temporary-medical-conditions) under the Students tab on the Disability Services website.

#### Classroom Behavior 
Students and faculty each have responsibility for maintaining an appropriate learning environment. Those who fail to adhere to such behavioral standards may be subject to discipline. Professional courtesy and sensitivity are especially important with respect to individuals and topics dealing with race, color, national origin, sex, pregnancy, age, disability, creed, religion, sexual orientation, gender identity, gender expression, veteran status, political affiliation or political philosophy.  Class rosters are provided to the instructor with the student's legal name. I will gladly honor your request to address you by an alternate name or gender pronoun. Please advise me of this preference early in the semester so that I may make appropriate changes to my records.  For more information, see the policies on [classroom behavior](https://www.colorado.edu/policies/student-classroom-and-course-related-behavior) and the [Student Code of Conduct](https://www.colorado.edu/sccr/).

#### Honor Code
All students enrolled in a University of Colorado Boulder course are responsible for knowing and adhering to the Honor Code. Violations of the policy may include: plagiarism, cheating, fabrication, lying, bribery, threat, unauthorized access to academic materials, clicker fraud, submitting the same or similar work in more than one course without permission from all course instructors involved, and aiding academic dishonesty. All incidents of academic misconduct will be reported to the Honor Code ([honor@colorado.edu](mailto:honor@colorado.edu); 303-492-5550). Students who are found responsible for violating the academic integrity policy will be subject to nonacademic sanctions from the Honor Code as well as academic sanctions from the faculty member. Additional information regarding the Honor Code academic integrity policy can be found at the [Honor Code Office website](https://www.colorado.edu/sccr/honor-code).

#### Sexual Misconduct, Discrimination, Harassment and/or Related Retaliation
The University of Colorado Boulder (CU Boulder) is committed to fostering a positive and welcoming learning, working, and living environment. CU Boulder will not tolerate acts of sexual misconduct (including sexual assault, exploitation, harassment, dating or domestic violence, and stalking), discrimination, and harassment by members of our community. Individuals who believe they have been subject to misconduct or retaliatory actions for reporting a concern should contact the Office of Institutional Equity and Compliance (OIEC) at 303-492-2127 or cureport@colorado.edu. Information about the OIEC, university policies, [anonymous reporting](https://cuboulder.qualtrics.com/jfe/form/SV_0PnqVK4kkIJIZnf), and the campus resources can be found on the [OIEC website](https://www.colorado.edu/oiec/). 
Please know that faculty and instructors have a responsibility to inform OIEC when made aware of incidents of sexual misconduct, discrimination, harassment and/or related retaliation, to ensure that individuals impacted receive information about options for reporting and support resources.

#### Religious Holidays
Campus policy regarding religious observances requires that faculty make every effort to deal reasonably and fairly with all students who, because of religious obligations, have conflicts with scheduled exams, assignments or required attendance.  In this class, I ask that you make me aware of any needs for accomodations and/or alternative arrangements as soon as possible.  The more advance notice you give me, the better the options I will have to offer you. 

See the [campus policy regarding religious observances](https://www.colorado.edu/policies/observance-religious-holidays-and-absences-classes-andor-exams) for full details.
 

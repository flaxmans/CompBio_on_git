# Examples of Real Data Files One Might Encounter that Do NOT import easily into R

## Questions:
+  What's wrong with each of them?
+  How would you explain a systematic way to fix each one? (each has different problems!)
+  How would we turn the answer in the last question into code?

## Explanations of files here:

### "EdgeList.txt"
This is a copy and paste of the "edge list" three-column format network data from week 6 & 7's exercises.  The data would ideally import into R as three columns with headers.  I copied it from the Microsoft Word doc and pasted it into a plain text file in TextEdit in MacOS.

### "moore.csv"
This is a real data file that was shared with Sam as part of a class on regression. The author said he copied and pasted it from a [Wikipedia page][mooresource] into a plain text file.  It SHOULD have 6 columns of data, which would be, in this order:
+ Processor
+ MOS transistor count
+ Date of introduction
+ Designer
+ MOS process (nm)
+ Area (mm2)

If you are curious, you can learn more about why these data are interesting by reading about "[Moore's law][mooreslaw]".

## Where might you begin?
Explore the files with tools in the shell and by opening them in any plain text editor.  Look for reasons that would explain RStudio's behavior (Sam will demo).




[mooresource]: https://en.wikipedia.org/wiki/Transistor_count
[mooreslaw]: https://en.wikipedia.org/wiki/Moore's_law

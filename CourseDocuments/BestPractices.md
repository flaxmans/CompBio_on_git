# Computational Biology
## Best Practices for this class and well beyond

<hr>

### Files and Directories
1. Names have no spaces
2. Names of directories have no punctuation (other than underscore or hyphen)
3. Data files, meta-data files, and source code are ASCII formatted (or possibly UTF-8)
4. File and directory names are descriptive
5. File and directory locations/paths are logical
6. Data files have headers
7. Headers in data files have NO spaces and NO punctuation
8. Data files are accompanied by meta-data file(s) in the same directory
9. Names of files DO include extension (e.g., .txt, .csv) but otherwise have no punctuation (other than underscore or hyphen)

### `git`
1. Only commit what you intend to commit
2. git repository directories that are pushed to GitHub do not contain any private or sensitive information
3. Commit messages are descriptive, informative, and accurate
4. Every repo has its own README
5. The README is accurate, descriptive, and gives the totally naive visitor enough info to understand what the repo is about
6. One git repo is NOT nested within another
7. Commit changes prior to any `checkout` operation

### Scripts in any language (e.g., R, BASH)
1. Are commented
2. Have variable names that are human readable and logical (e.g, "`time`" is a better name than "`t`", "`abundance`" is better than "`n`", "`concentration`" is better than "`x`", etc.)
3. Have proper indentation
4. Do not have lines that do nothing
5. Do not have variables that aren't used
6. Do not have "magic numbers"
7. Use looping and user-defined functions instead of copying and pasting/repeating the same code multiple times

# Dot Files

WIP Repo for dot files.

## fuz.sh

Note taking bash script based on [this article](https://medium.com/adorableio/simple-note-taking-with-fzf-and-vim-2a647a39cfa)

Stores all notes in centralized location ($NOTESDIRECTORY).  Allows for fuzzy searching filenames and file contents

### Requirements

 - ag
 - fzf
 - xargs 
 - $NOTESDIRECTORY env variable set to path of notes directory
 - $EDITOR set (i.e. `export EDITOR=/usr/bin/vim`)

### Installation

 - Either make executable and add to $PATH or include in $NOTESDIRECTORY and
   create function (**Note** not an alias, function needs to take an argument)

```
function notes() {
    cd $(eval echo "$NOTESDIRECTORY") && ./fuz.sh $1 && cd -
}
```

### Usage (using notes function)

**Create new note file**
```
[johnlenehan:~/Personal]$ notes new
Enter New Filename
> newnotefile.md
```
**Search all existing notes**
```
[johnlenehan:~/Personal]$ notes 
```

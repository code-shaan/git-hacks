# A Faster Git - Gerrit Flow

This project provides scripts for developers to install in order to quicken development cycles when working with Git - Gerrit

## Motivation for this project

### Push Conundrum
The command to push a patch-set(s) is - git push origin HEAD:refs/for/<remote_branch_name>
* Problems that arise due an incorrect command execution are:
* Patch-set(s) gets rejected by pushing to an invalid reference
* Patch-set(s) get accepted but pushed to a wrong branch (major hazard. . .)
* A developer may waste a lot of time figuring out the cause of failure or reverting unwanted patch-set(s)

### Pull Conundrum
The command to pull patch-set(s) is - git pull --rebase origin <remote_branch_name>
* Problems that arise due an incorrect command execution are:
* Patch-set(s) get accepted but pulled from a wrong branch (major hazard. . .)
* A developer may waste a lot of time figuring out the cause of failure or reverting unwanted patch-set(s)

### Reviewer Buddy
The current norm to add a reviewer is either:
* Remember the exact email address of the reviewer and add him through the command line (headache if its multiple reviewers. . .)
* Navigate all the way to Gerrit UI, search for the review and add the reviewer(s)


## A better way to GIT it done

### Solutions
Some of the problems that this new way solves are:
* Don't have to remember which references to push to
* Don't have to remember where to pull latest patch-set(s) from
* Easier and very efficient way to add reviewers without having to leave the command line interface
* You can add a reviewer by either using their initials or their first name
* The .gitreviewers file is configured to lookup reviewers based on your input


## Installation
* For installation on a Linux machine, follow instructions in:
-> src/install-linux/

* For installtion on a Macintosh machine, follow instructions in:
-> src/install-mac/


## A few helpful pointers
```

* When in doubt about a command, Run < command_name > -l or < command_name > -x

* Remote branch tracking is an important part of this entire automation process.

* If your branches have been "checked-out" the old way, set up "upstream" remote tracking for them to be compatible

* Checkout the branch that needs to be converted: git checkout <branch_name>

* Use git branch --set-upstream-to=origin/<branch_name> to set remote tracking with its corresponding remote

```

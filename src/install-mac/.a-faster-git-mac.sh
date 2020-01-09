#!/usr/bin/env bash


####################################################################################
#                                                                                  #
#               Utility functions for auto completion of git commands              #
#                                                                                  #
####################################################################################


###########################################################
# NAME:         git-status - Show the working tree status #
# CMD:          gs                                        #
# OPTS:         -l | -x | -p                              #
###########################################################
func_git_status() {

OPTIND=1
CMD_GIT="git status "
CMD_OPTS=""
INP_OPTS=""
CMD_EXE=1

list_opts()
{
printf "This function \"gs\" (name: git-status) accepts the following options:
list options\t-l
example usage\t-x
pretty\t\t-p\n\n"; 1>&2;
}

help_message()
{
printf "Run gs -l to list options\n"; 1>&2;
printf "Run gs -x to list examples\n\n"; 1>&2;
}

example_usage()
{
printf "Example:
Shows the working tree status\t\tgs
Lists the options supported\t\tgs -l
Shows the status in pretty format\tgs -p\n\n"; 1>&2;
}

declare -A git_status_array

while getopts "lxp" git_status_var;
  do
    git_status_array[$git_status_var]=$OPTARG
    INP_OPTS+="$git_status_var"
  done

opts_error=$(echo $INP_OPTS | grep -c "?")

if [ $opts_error -eq 1 ]; then
  help_message; CMD_EXE=0;
else
  if [ $OPTIND -eq 1 ]; then
    if [ -z "$1" ]; then
      $CMD_GIT; CMD_EXE=0;
    else
      printf "bash: illegal option -- $1\n"
      help_message; CMD_EXE=0;
    fi
  else
    for each_option in "${!git_status_array[@]}";
      do
        case "${each_option}" in
          l)
            list_opts; CMD_EXE=0 ;;
          x)
            example_usage; CMD_EXE=0 ;;
          p)
            CMD_OPTS+="-sb " ;;
        esac
      done
  fi
fi

if [ $CMD_EXE -eq 1 ]; then
  $CMD_GIT $CMD_OPTS
fi
}
alias gs=func_git_status




#################################################################
# NAME:         git-log - Show commit logs                      #
# CMD:          gl                                              #
# OPTS:         -l | -x | -a | -b | -c | -d | -g | -n | -s | -u #
#################################################################
func_git_log() {

OPTIND=1
CMD_GIT="git log "
CMD_OPTS=""
INP_OPTS=""
CMD_EXE=1

list_opts()
{
printf "This function \"gl\" (name: git-log) accepts the following options:
list options\t-l
example usage\t-x
author\t\t-a <pattern>
before\t\t-b <date>
committer\t-c <pattern>
decorate\t-d <short|full|auto|no>

grep\t\t-g <pattern>
number\t\t-n <number>
since\t\t-s <date>
until\t\t-u <date>\n\n"; 1>&2;
}

help_message()
{
printf "Run gl -l to list options\n"; 1>&2;
printf "Run gl -x to list examples\n\n"; 1>&2;
}

example_usage()
{
printf "Example:
Shows the git log\t\t\tgl
Shows the top 3 commits in log\t\tgl -n 3
Shows the commits in log since date\tgl -s 01/15/2016\n\n"; 1>&2;
}

declare -A git_log_array

while getopts "lxa:b:c:d:g:n:s:u:" git_log_var
  do
    git_log_array[$git_log_var]=$OPTARG
    INP_OPTS+="$git_log_var"
  done

opts_error=$(echo $INP_OPTS | grep -c "?")

if [ $opts_error -eq 1 ]; then
  help_message; CMD_EXE=0;
else
  if [ $OPTIND -eq 1 ]; then
    if [ -z "$1" ]; then
      $CMD_GIT; CMD_EXE=0;
    else
      printf "bash: illegal option -- $1\n"
      help_message; CMD_EXE=0;
    fi
  else
    for each_option in "${!git_log_array[@]}";
      do
        case "${each_option}" in
          l)
            list_opts; CMD_EXE=0 ;;
          x)
            example_usage; CMD_EXE=0 ;;
          a)
            CMD_OPTS+="--author=${git_log_array[a]} " ;;
          b)
            CMD_OPTS+="--before=${git_log_array[b]} " ;;
          c)
            CMD_OPTS+="--committer=${git_log_array[c]} " ;;
          d)
            CMD_OPTS+="--decorate=${git_log_array[d]} " ;;
g)
            CMD_OPTS+="--grep=${git_log_array[g]} " ;;
          n)
            CMD_OPTS+="-n ${git_log_array[n]} " ;;
          s)
            CMD_OPTS+="--since=${git_log_array[s]} " ;;
          u)
            CMD_OPTS+="--until=${git_log_array[u]} " ;;
        esac
      done
   fi
fi

if [ $CMD_EXE -eq 1 ]; then
  $CMD_GIT $CMD_OPTS
fi
}
alias gl=func_git_log

##############################################################################
# NAME: 	git-checkout - Switch branches or restore working tree files #
# CMD:		gco				  			     #
# OPTS:		-l | -x | -b | -q					     #
##############################################################################
func_git_checkout() {

OPTIND=1
CMD_GIT="git checkout "
CMD_OPTS=""
INP_OPTS=""
CMD_EXE=1

list_opts()
{
printf "This function \"gco\" (name: git-checkout) accepts the following options:
list options\t-l
example usage\t-x
new branch\t-b <new_branch_name>
quiet\t\t-q\n\n"; 1>&2;
}

help_message()
{
printf "Run gco -l to list options\n"; 1>&2;
printf "Run gco -x to list examples\n\n"; 1>&2;
}

example_usage()
{
printf "Example:
Lists the options supported\t\t\tgco -l
Checks out given branch\t\t\t\tgco smp-7.0
Creates and checks out new given branch\t\tgco -b smp-1234_7.0\n\n"; 1>&2;
}

declare -A git_checkout_array

while getopts "lxb:q" git_checkout_var
  do
    git_checkout_array[$git_checkout_var]=$OPTARG
    INP_OPTS+="$git_checkout_var"
  done
	
opts_error=$(echo $INP_OPTS | grep -c "?")

if [ $opts_error -eq 1 ]; then
  help_message; CMD_EXE=0;
else
  if [ $OPTIND -eq 1 ]; then
    if [ -z "$1" ]; then
      printf "bash: illegal option -- branch name missing\n" 
        help_message; CMD_EXE=0;
    else
	$CMD_GIT $1; CMD_EXE=0;
    fi
  else
    for each_option in "${!git_checkout_array[@]}";
      do
	case "${each_option}" in
	  l)
	    list_opts; CMD_EXE=0 ;;
	  x)
	    example_usage; CMD_EXE=0 ;;
	  b)
	    CMD_OPTS+="-b ${git_checkout_array[b]} " ;;
	  q)
	    CMD_OPTS+="-q " ;;
	esac
      done
  fi
fi

if [ $CMD_EXE -eq 1 ]; then
  branch=$(gs | sed -n 's/^.*'\''\([^'\'']*\)'\''.*$/\1/p');
  $CMD_GIT $CMD_OPTS
  git branch --set-upstream-to=$branch
fi
}
alias gco=func_git_checkout

##########################################################################
# NAME: 	git-branch - List, create, or delete branches		 #
# CMD:		gb				  			 #
# OPTS:		-l | -x | -a | -d | -D | -q | -r | -u | -v	  	 #
##########################################################################
func_git_branch() {

OPTIND=1
CMD_GIT="git branch "
CMD_OPTS=""
INP_OPTS=""
CMD_EXE=1

list_opts()
{
printf "This function \"gb\" (name: git-branch) accepts the following options:
list options\t-l
example usage\t-x
display all\t-a
delete branch\t-d <local_branch_name>
force delete\t-D <local_branch_name>
quiet\t\t-q
display remote\t-r
set upstream\t-u <remote_branch_name>
display local\t-v\n\n"; 1>&2;
}

help_message()
{
printf "Run gb -l to list options\n"; 1>&2;
printf "Run gb -x to list examples\n\n"; 1>&2;
}

example_usage()
{
printf "Example:
Lists the options supported\tgb -l
Lists all local branches\tgb -v
Deletes given branch\t\tgb -d smp-1234_7.0\n\n"; 1>&2;
}

declare -A git_branch_array

while getopts "lxad:D:qru:v" git_branch_var
  do
    git_branch_array[$git_branch_var]=$OPTARG
    INP_OPTS+="$git_branch_var"
  done
	
opts_error=$(echo $INP_OPTS | grep -c "?")

if [ $opts_error -eq 1 ]; then
  help_message; CMD_EXE=0;
else
  if [ $OPTIND -eq 1 ]; then
    if [ -z "$1" ]; then
      $CMD_GIT; CMD_EXE=0;
    else
      printf "bash: illegal option -- $1\n"
      help_message; CMD_EXE=0;
    fi
  else
    for each_option in "${!git_branch_array[@]}";
      do
        case "${each_option}" in
	  l)
	    list_opts; CMD_EXE=0 ;;
	  x)
	    example_usage; CMD_EXE=0 ;;
	  a)
	    CMD_OPTS+="-a " ;;
 	  d)
	    CMD_OPTS+="-d ${git_branch_array[d]} " ;;
	  D)
	    CMD_OPTS+="-D ${git_branch_array[D]} " ;;
	  q)
	    CMD_OPTS+="-q " ;;
	  r)
	    CMD_OPTS+="-r " ;;
	  u)
	    CMD_OPTS+="-u --set-upstream-to=origin/${git_branch_array[u]} " ;;
	  v)
	    CMD_OPTS+="-v " ;;
	esac
      done
  fi
fi

if [ $CMD_EXE -eq 1 ]; then
  $CMD_GIT $CMD_OPTS
fi
}
alias gb=func_git_branch

###############################################################################
# NAME: 	git-fetch - Download objects and refs from another repository #
# CMD:		gf				  			      #
# OPTS:		-l | -x | -a | -q | -v				  	      #
###############################################################################
func_git_fetch() {

OPTIND=1
CMD_GIT="git fetch "
CMD_OPTS=""
INP_OPTS=""
CMD_EXE=1

list_opts()
{
printf "This function \"gf\" (name: git-fetch) accepts the following options:
list options\t-l
example usage\t-x
fetch all\t-a
quiet\t\t-q
verbose\t\t-v\n\n"; 1>&2;
}

help_message()
{
printf "Run gf -l to list options\n"; 1>&2;
printf "Run gf -x to list examples\n\n"; 1>&2;
}

example_usage()
{
printf "Example:
Fetches objects for current branch\tgf 
Fetches objects for all branches\tgf -a
Verbose output for fetch\t\tgf -v\n\n"; 1>&2;
}

declare -A git_fetch_array

while getopts "lxaqv" git_fetch_var
  do
    git_fetch_array[$git_fetch_var]=$OPTARG
    INP_OPTS+="$git_fetch_var"
  done
	
opts_error=$(echo $INP_OPTS | grep -c "?")

if [ $opts_error -eq 1 ]; then
  help_message; CMD_EXE=0;
else
  if [ $OPTIND -eq 1 ]; then
    if [ -z "$1" ]; then
      $CMD_GIT; CMD_EXE=0;
    else
      printf "bash: illegal option -- $1\n" 
      help_message; CMD_EXE=0;
    fi
  else
    for each_option in "${!git_fetch_array[@]}";
      do
	case "${each_option}" in
	  l)
	    list_opts; CMD_EXE=0 ;;
	  x)
	    example_usage; CMD_EXE=0 ;;
	  a)
	    CMD_OPTS+="-a " ;;
	  q)
	    CMD_OPTS+="-q " ;;
	  v)
	    CMD_OPTS+="-v " ;;	
	esac
      done
  fi
fi

if [ $CMD_EXE -eq 1 ]; then
  $CMD_GIT $CMD_OPTS
fi
}
alias gf=func_git_fetch




###############################################################################################
# NAME: 	git-pull - Fetch from and integrate with another repository or a local branch #
# CMD:		gpl				  					      #
# OPTS:		-l | -x | -q | -r | -v				  		  	      #
###############################################################################################
func_git_pull() {

OPTIND=1
CMD_GIT="git pull "
CMD_OPTS=""
INP_OPTS=""
CMD_EXE=1

list_opts()
{
printf "This function \"gpl\" (name: git-pull) accepts the following options:
list options\t-l
example usage\t-x
quiet\t\t-q
rebase\t\t-r
verbose\t\t-v\n\n"; 1>&2;
}

help_message()
{
printf "Run gpl -l to list options\n"; 1>&2;
printf "Run gpl -x to list examples\n\n"; 1>&2;
}

example_usage()
{
printf "Example:
Does a git-pull with merge\tgpl
Does a git-pull with rebase\tgpl -r 
Verbose output for git-pull\tgpl -v\n\n"
}

declare -A git_pull_array

while getopts "lxqrv" git_pull_var
do
  git_pull_array[$git_pull_var]=$OPTARG
  INP_OPTS+="$git_pull_var"
done
	
opts_error=$(echo $INP_OPTS | grep -c "?")

if [ $opts_error -eq 1 ]; then
  help_message; CMD_EXE=0;
else
  if [ $OPTIND -eq 1 ]; then
    if [ -z "$1" ]; then
      printf "Running \"git-pull\" with merge option. . .\n"
      printf "Press \'y\' (continue) or \'n\' (abort)\n"
      read continue_merge
      if [[ $continue_merge == "y" ]]; then
        $CMD_GIT; CMD_EXE=0;
      else
 	help_message; CMD_EXE=0;
      fi
    else
      printf "bash: illegal option -- $1\n" 
      help_message; CMD_EXE=0;
    fi
  else
    for each_option in "${!git_pull_array[@]}";
      do
	case "${each_option}" in
	  l)
	    list_opts; CMD_EXE=0 ;;
	  x)
	    example_usage; CMD_EXE=0 ;;
	  q)
	    CMD_OPTS+="-q " ;;
	  r)
	    branch=$(gs | sed -n 's/^.*'\''\([^'\'']*\)'\''.*$/\1/p');
	    CMD_OPTS+="--rebase origin $branch " ;;
	  v)
	    CMD_OPTS+="-v " ;;	
	esac
      done
  fi
fi

if [ $CMD_EXE -eq 1 ]; then
  $CMD_GIT $CMD_OPTS
fi
}
alias gpl=func_git_pull




###########################################################################################
# NAME: 	git-clean - Remove untracked files from the working tree		  #
# CMD:		gcl				  					  #
# OPTS:		-l | -x | -d | -f | -i | -n | -q	  		  		  #
###########################################################################################
func_git_clean() {

OPTIND=1
CMD_GIT="git clean "
CMD_OPTS=""
INP_OPTS=""
CMD_EXE=1

list_opts()
{
printf "This function \"gcl\" (name: git-clean) accepts the following options:
list options\t-l
example usage\t-x
directories\t-d
force\t\t-f
interactive\t-i
dry run\t\t-n
quiet\t\t-q\n\n"; 1>&2;
}

help_message()
{
printf "Run gcl -l to list options\n"; 1>&2;
printf "Run gcl -x to list examples\n\n"; 1>&2;
}

example_usage()
{
printf "Example:
Clean files and directories\t\t\tgcl -f -d 
Does a git-clean dry run\t\t\tgcl -n
Does a git-clean with interactive editor\tgcl -i\n\n"
}

declare -A git_clean_array

while getopts "lxdfinq" git_clean_var
do
  git_clean_array[$git_clean_var]=$OPTARG
  INP_OPTS+="$git_clean_var"
done
	
opts_error=$(echo $INP_OPTS | grep -c "?")

if [ $opts_error -eq 1 ]; then
  help_message; CMD_EXE=0;
else
  if [ $OPTIND -eq 1 ]; then
    if [ -z "$1" ]; then
      $CMD_GIT; CMD_EXE=0;
    else
      printf "bash: illegal option -- $1\n" 
      help_message; CMD_EXE=0;
    fi
  else
    for each_option in "${!git_clean_array[@]}";
    do
      case "${each_option}" in
        l)
	  list_opts; CMD_EXE=0 ;;
	x)
	  example_usage; CMD_EXE=0 ;;
	d)
	  CMD_OPTS+="-d -f " ;;
	f)
	  CMD_OPTS+="-f " ;;
	i)
	  CMD_OPTS+="-i " ;;
	n)
	  CMD_OPTS+="--dry-run " ;;
	q)
	  CMD_OPTS+="-q " ;;				
      esac
    done
  fi
fi

if [ $CMD_EXE -eq 1 ]; then
  $CMD_GIT $CMD_OPTS
fi
}
alias gcl=func_git_clean




###########################################################################################
# NAME: 	git-reset - Reset current HEAD to the specified state			  #
# CMD:		gr				  					  #
# OPTS:		-l | -x | -c | -m | -q				  		  	  #
###########################################################################################
func_git_reset() {

OPTIND=1
CMD_GIT="git reset "
CMD_OPTS=""
INP_OPTS=""
CMD_EXE=1

list_opts()
{
printf "This function \"gr\" (name: git-reset) accepts the following options:
list options\t-l
example usage\t-x
revert commits\t-c <integer>
mode\t\t-m <soft|hard>
quiet\t\t-q\n\n"; 1>&2;
}

help_message()
{
printf "Run gr -l to list options\n"; 1>&2;
printf "Run gr -x to list examples\n\n"; 1>&2;
}

example_usage()
{
printf "Example:
Does a hard git-reset of top 2 commits\tgr -m hard -c 2 
Lists the options supported\t\tgr -l\n\n"
}

declare -A git_reset_array

while getopts "lxc:m:q" git_reset_var
do
  git_reset_array[$git_reset_var]=$OPTARG
  INP_OPTS+="$git_reset_var"
  done
	
opts_error=$(echo $INP_OPTS | grep -c "?")

if [ $opts_error -eq 1 ]; then
  help_message; CMD_EXE=0;
else
  if [ $OPTIND -eq 1 ]; then
    if [ -z "$1" ]; then
      $CMD_GIT; CMD_EXE=0;
    else
      printf "bash: illegal option -- $1\n" 
      help_message; CMD_EXE=0;
    fi
  else
    for each_option in "${!git_reset_array[@]}";
    do
      case "${each_option}" in
	l)
	  list_opts; CMD_EXE=0 ;;
	x)
	  example_usage; CMD_EXE=0 ;;
	c)
	  CMD_OPTS+="HEAD~${git_reset_array[c]} ";;
	m)
	  CMD_OPTS+="--${git_reset_array[m]} " ;;
	q)
	  CMD_OPTS+="-q " ;;				
      esac
    done
  fi
fi

if [ $CMD_EXE -eq 1 ]; then
  $CMD_GIT $CMD_OPTS
fi
}
alias gr=func_git_reset




###########################################################################################
# NAME: 	git-add - Add file contents to the index				  #
# CMD:		ga				  				 	  #
# OPTS:		-l | -x | -e | -n | -v				  		  	  #
###########################################################################################
func_git_add() {

OPTIND=1
CMD_GIT="git add "
CMD_OPTS=""
INP_OPTS=""
CMD_EXE=1

list_opts()
{
printf "This function \"ga\" (name: git-add) accepts the following options:
list options\t-l
example usage\t-x
edit\t\t-e file
dry-run\t\t-n file
verbose\t\t-v file\n\n"; 1>&2;
}

help_message()
{
printf "Run ga -l to list options\n"; 1>&2;
printf "Run ga -x to list examples\n\n"; 1>&2;
}

example_usage()
{
printf "Example:
Does a recursive git-add on all files\tga . 
Lists the options supported\t\tga -l
Does a git-add with editor\t\tga -e pom.xml\n\n"
}

declare -A git_add_array

while getopts "lxe:n:v:" git_add_var
do
  git_add_array[$git_add_var]=$OPTARG
  INP_OPTS+="$git_add_var"
done
	
opts_error=$(echo $INP_OPTS | grep -c "?")

if [ $opts_error -eq 1 ]; then
  help_message; CMD_EXE=0;
else
  if [ $OPTIND -eq 1 ]; then
    if [ -z "$1" ]; then
      printf "bash: illegal option -- missing . or filename(s)\n" 
      help_message; CMD_EXE=0;
    else
      $CMD_GIT $1; CMD_EXE=0;
    fi
  else
    for each_option in "${!git_add_array[@]}";
      do
	case "${each_option}" in
	  l)
	    list_opts; CMD_EXE=0 ;;
	  x)
	    example_usage; CMD_EXE=0 ;;
	  e)
	    CMD_OPTS+="-e ${git_add_array[e]} ";;
	  n)
	    CMD_OPTS+="-n ${git_add_array[n]} " ;;
	  v)
	    CMD_OPTS+="-v ${git_add_array[v]} " ;;
	esac
      done
  fi
fi

if [ $CMD_EXE -eq 1 ]; then
  $CMD_GIT $CMD_OPTS
fi
}
alias ga=func_git_add




###########################################################################################
# NAME: 	git-push - Update remote refs along with associated objects		  #
# CMD:		gps				  					  #
# OPTS:		-l | -x | -b | -c | -e | -n | -q | -r | -v 			  	  #
###########################################################################################
func_git_push() {

OPTIND=1
CMD_GIT="git push origin "
CMD_OPTS=""
INP_OPTS=""
CMD_EXE=1

CMD_CMT=""
CMD_LOC=""
CMD_REF=":refs/for/"
CMD_REV=""

list_opts()
{
printf "This function \"gps\" (name: git-push) accepts the following options:
list options\t-l
example usage\t-x
remote branch\t-b <remote_branch>
commit hash\t-c <commit_hash>
existing review\t-e <review_id>
dry run\t\t-n
quiet\t\t-q
reviewer\t-r <reviewer initial or first_name>
verbose\t\t-v\n\n"; 1>&2;
}

help_message()
{
printf "Run gps -l to list options\n"; 1>&2;
printf "Run gps -x to list examples\n\n"; 1>&2;
}

example_usage()
{
CMD_LOC=$(gs | sed -n 's/^.*'\''\([^'\'']*\)'\''.*$/\1/p');
printf "Example:
Pushes to git push origin HEAD:/refs/for/$CMD_LOC\t\t\tgps 
Pushes to git push origin HEAD:/refs/for/$CMD_LOC\nand add reviewer whose initials are \"ss\"\t\t\tgps -r ss
Does a git-push dry run\t\t\t\t\t\tgps -n
Push to an existing review\t\t\t\t gps -e 12345\n\n"

}

declare -A git_push_array

while getopts "lxb:c:e:nqr:v" git_push_var
  do
    git_push_array[$git_push_var]=$OPTARG
    INP_OPTS+="$git_push_var"
  done
	
opts_error=$(echo $INP_OPTS | grep -c "?")

if [ $opts_error -eq 1 ]; then
  help_message; CMD_EXE=0;
else
  if [ $OPTIND -eq 1 ]; then
    if [ -z "$1" ]; then
      CMD_CMT="HEAD";
      CMD_LOC=$(gs | sed -n 's/^.*'\''\([^'\'']*\)'\''.*$/\1/p');
      $CMD_GIT $CMD_CMT$CMD_REF$CMD_LOC;
      CMD_EXE=0;
    else
      $CMD_GIT $1; CMD_EXE=0;
    fi
  else
    for each_option in "${!git_push_array[@]}";
      do
        case "${each_option}" in
	  l)
	    list_opts; CMD_EXE=0 ;;
	  x)
	    example_usage; CMD_EXE=0 ;;
	  b)
	    CMD_LOC="${git_push_array[b]} " ;;
	  c)
	    CMD_CMT="${git_push_array[c]} " ;;
          e)
            CMD_REF=":refs/changes/"
            CMD_LOC="${git_push_array[e]} " ;;
	  n)
	    CMD_OPTS+="-n ";;
	  q)
	    CMD_OPTS+="-q ";;
	  r)
	    reviewer="${git_push_array[r]}";        
	    for each_reviewer in $(echo $reviewer | tr "," "\n");
	      do
                if [ ${#each_reviewer} = 2 ]; then
	 	  reviewer_email=$(grep -o "^$each_reviewer.*" ~/.gitreviewers | cut -f2 -d=);
		  CMD_REV+="r=$reviewer_email,";
                else
		  reviewer_email=$(grep -o "#$each_reviewer.*" ~/.gitreviewers | cut -f2 -d=);
                  CMD_REV+="r=$reviewer_email,";
                fi                    
	      done ;;
	esac
      done
  fi
fi

if [ -z $CMD_CMT ]; then
  CMD_CMT="HEAD";
fi

if [ -z $CMD_LOC ]; then
  CMD_LOC=$(gs | sed -n 's/^.*'\''\([^'\'']*\)'\''.*$/\1/p');
fi

if [ $CMD_EXE -eq 1 ]; then
  printf "If this looks correct. . .\n"
  
  if [ -z $CMD_REV ]; then
    echo $CMD_GIT $CMD_CMT$CMD_REF$CMD_LOC
  else
    echo $CMD_GIT $CMD_CMT$CMD_REF$CMD_LOC%$CMD_REV | sed 's/.\{1\}$//'
  fi
	
  printf "Press \'y\' to (continue) or \'n\' to (abort)\n"
  read continue_push

  if [[ $continue_push == "y" ]]; then
    if [ -z $CMD_REV ]; then
      $CMD_GIT $CMD_CMT$CMD_REF$CMD_LOC
    else
      $CMD_GIT $CMD_CMT$CMD_REF$CMD_LOC%$CMD_REV | sed 's/.\{1\}$//'
    fi
  else
    printf "Please edit the command and run manually\n\n"; CMD_EXE=0;
  fi
fi
}
alias gps=func_git_push




###########################################################################################
# NAME: 	git-commit - Record changes to the repository				  #
# CMD:		gcm				  					  #
# OPTS:		-l | -x | -a | -m | -p | -q | -v	  		  		  #
###########################################################################################
func_git_commit() {

OPTIND=1
CMD_GIT="git commit "
CMD_OPTS=""
INP_OPTS=""
CMD_EXE=1

list_opts()
{
printf "This function \"gcm\" (name: git-commit) accepts the following options:
list options\t-l
example usage\t-x
ammend\t\t-a
commit message\t-m <commit_message>
commit patch\t-p
quiet\t\t-q
verbose\t\t-v\n\n"; 1>&2;
}

help_message()
{
printf "Run gcm -l to list options\n"; 1>&2;
printf "Run gcm -x to list examples\n\n"; 1>&2;
}

example_usage()
{
printf "Example:
Does a git-commit for a patch-set\tgcm -p 
Does a git-commit with a message\tgcm -m \"SMP-1234: Test Commit Message\""
}

declare -A git_commit_array

while getopts "lxam:pqv" git_commit_var
do
  git_commit_array[$git_commit_var]=$OPTARG
  INP_OPTS+="$git_commit_var"
done
	
opts_error=$(echo $INP_OPTS | grep -c "?")

if [ $opts_error -eq 1 ]; then
  help_message; CMD_EXE=0;
else
  if [ $OPTIND -eq 1 ]; then
    if [ -z "$1" ]; then
      printf "bash: illegal option -- missing commit message\n" 
      help_message; CMD_EXE=0;
    else
      help_message; CMD_EXE=0;
    fi
  else
    for each_option in "${!git_commit_array[@]}";
      do
        case "${each_option}" in
	  l)
	    list_opts; CMD_EXE=0 ;;
	  x)
	    example_usage; CMD_EXE=0 ;;
	  a)
	    CMD_OPTS+="--amend ";;
	  m)
	    CMD_OPTS+="-m \"${git_commit_array[m]}\" " ;;
	  p)
	    CMD_OPTS+="-p " ;;
	  q)
	    CMD_OPTS+="-q ";;
	  v)
	    CMD_OPTS+="-v ";;
	esac
      done
  fi
fi

if [ $CMD_EXE -eq 1 ]; then
  $CMD_GIT $CMD_OPTS
fi
}
alias gcm=func_git_commit




###########################################################################################
# NAME: 	git-rebase - Reapply commits on top of another base tip			  #
# CMD:		grb				  					  #
# OPTS:		-l | -x | -a | -c | -i | -q | -v	  		  		  #
###########################################################################################
func_git_rebase() {

OPTIND=1
CMD_GIT="git rebase "
CMD_OPTS=""
INP_OPTS=""
CMD_EXE=1

list_opts()
{
printf "This function \"grb\" (name: git-rebase) accepts the following options:
list options\t-l
example usage\t-x
abort\t\t-a
continue\t-c
interactive\t-i <number_of_commits>
quiet\t\t-q
verbose\t\t-v\n\n"; 1>&2;
}

help_message()
{
printf "Run grb -l to list options\n"; 1>&2;
printf "Run grb -x to list examples\n\n"; 1>&2;
}

example_usage()
{
printf "Example:
Does a git-rebase with interactive editor for top 3 commits\tgrb -i 3 
Does a git-rebase with the continue option\t\t\tgrb -c"
}

declare -A git_rebase_array

while getopts "lxaci:qv" git_rebase_var
do
  git_rebase_array[$git_rebase_var]=$OPTARG
  INP_OPTS+="$git_rebase_var"
done
	
opts_error=$(echo $INP_OPTS | grep -c "?")

if [ $opts_error -eq 1 ]; then
  help_message; CMD_EXE=0;
else
  if [ $OPTIND -eq 1 ]; then
    if [ -z "$1" ]; then
      printf "bash: illegal option -- missing arguments\n" 
      help_message; CMD_EXE=0;
    else
      help_message; CMD_EXE=0;
  fi
  else
    for each_option in "${!git_rebase_array[@]}";
      do
        case "${each_option}" in
	  l)
	    list_opts; CMD_EXE=0 ;;
	  x)
	    example_usage; CMD_EXE=0 ;;
	  a)
	    CMD_OPTS+="--abort " ;;
	  c)
	    CMD_OPTS+="--continue " ;;
	  i)
	    CMD_OPTS+="-i HEAD~${git_rebase_array[m]} " ;;
	  q)
	    CMD_OPTS+="-q " ;;
	  v)
	    CMD_OPTS+="-v " ;;
	esac
      done
  fi
fi

if [ $CMD_EXE -eq 1 ]; then
  $CMD_GIT $CMD_OPTS
fi
}
alias grb=func_git_rebase




source ~/.git-completion.sh
export PS1='\h:\w\[\033[32m\]$(__git_ps1) \[\033[0m\]$ '




















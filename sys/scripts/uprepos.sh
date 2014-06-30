#!/bin/sh

# Update at once all local copies of Git and Subversion repositories
# found under a specific directory.
#
# tripu, 2014.

SELF=`basename $0`

case "$#" in

    0)
	cat << EOF
$SELF: missing operand
Try '$SELF --help' for more information.
EOF
	exit 6
	;;

    1)
	if [ $1 = "-h" ] || [ $1 = "--help" ]; then
	    cat << EOF
Usage: $SELF OPTION
   or: $SELF DIRECTORY
Update at once all Git/Subversion repos under DIRECTORY.

  -h, --help  display this help and exit
EOF
	    exit 1
	fi
	;;

    *)
	cat << EOF
$SELF: too many operands
Try '$SELF --help' for more information.
EOF
	exit 5
	;;

esac

if [ ! -e $1 ]; then
    cat << EOF
$SELF: '$1' does not exist
EOF
    exit 4
elif [ ! -d $1 ]; then
    cat << EOF
$SELF: '$1' is not a directory
EOF
    exit 3
elif [ ! -r $1 ]; then
    cat << EOF
$SELF: cannot list '$1'
EOF
    exit 2
else
    echo Updating all Git/Subversion repos under \'$1\'...
    for i in `ls $1`; do
	echo $i:
	if [ -d $1/$i ]; then
	    cd $1/$i > /dev/null
	    if [ -e .svn ] && [ -d .svn ]; then
		(svn up
		    svn st | sort) | sed '/^$/d' | sed 's/^/  /g'
	    elif [ -e .git ] && [ -d .git ]; then
		(git pull
		    git status) | sed '/^$/d' | sed 's/^/  /g'
	    fi
	    cd - > /dev/null
	fi
    done
fi

# EOF


#!/bin/sh

# Update at once all local copies of Git and Subversion repositories found under a specific directory.
#
# Run with '--help' for help.
#
# Error codes:
#   1 invoked
#   2 cannot read/list directory.
#   3 file is not a directory.
#   4 file does not exist.
#   5 invoked with too many operands.
#   6 invoked without any parameters.
#
# tripu, 2014.

SELF=`basename $0`

# Process parameters:
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
   or: $SELF DIRECTORY [LIST]
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

# Handle various errors:
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
  # Everything seems OK — update:
  BASE=`realpath $1`
  echo Updating all Git/Subversion repos under “$BASE”…
  if [ -e $BASE/palimpsest/personal/docs/repos.txt -a -f $BASE/palimpsest/personal/docs/repos.txt -a -w $BASE/palimpsest/personal/docs/repos.txt ]; then
    LIST=$BASE/palimpsest/personal/docs/repos.txt
    while IFS= read -r REPO; do
      NAME=`echo $REPO | cut -d' ' -f1`
      if [ ! -d $1/$NAME ] && [ ! $NAME = "#" ]; then
        TYPE=`echo $REPO | cut -d' ' -f2`
        URL=`echo $REPO | cut -d' ' -f3`
        mkdir $1/$NAME
        # cd $1/$NAME
      fi
    done < $LIST
  fi
  for i in `ls $1`; do
    if [ -d $1/$i ]; then
      cd $1/$i > /dev/null
      if [ -e .git ] && [ -d .git ]; then
        # Git:
        echo “$i” \(Git\):
        (git pull; git status) | sed '/^$/d' | sed 's/^/  /g'
        if [ -n "${LIST-}" ]; then
          echo "$i git `git config --get remote.origin.url` git pull; git status" >> $LIST
        fi
      elif [ -e .svn ] && [ -d .svn ]; then
        # Subversion:
        echo “$i” \(Subversion\):
        (svn up; svn st | sort -k1,1) | sed '/^$/d' | sed 's/^/  /g'
        if [ -n "${LIST-}" ]; then
          echo "$i svn `svn info | grep '^Repository\ Root:\ ' | cut -d' ' -f3-` svn up; svn st | sort -k1,1" >> $LIST
        fi
      elif [ -e CVS ] && [ -d CVS ]; then
        # CVS:
        echo “$i” \(CVS\):
        echo '  Not yet!'
        # (cvs co WWW) | sed '/^$/d' | sed 's/^/  /g'
        # if [ -n "${LIST-}" ]; then
          # echo "$i cvs `svn info | grep '^Repository\ Root:\ ' | cut -d' ' -f3-` svn up; svn st | sort -k1,1" >> $LIST
        # fi
      else
        echo “$i”: =================== EMPTY ===================
      fi
      cd - > /dev/null
    fi
  done
  if [ -n "${LIST-}" ]; then
    sort -f $LIST | uniq -i > /tmp/$SELF-$$.txt
    mv /tmp/$SELF-$$.txt $LIST
  fi
fi

# EOF


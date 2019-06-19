# http://pnijjar.freeshell.org/2014/screentitles/
# The \w sets the current working folder.
# The rest of the SCREENTITLE line is a magic escape sequence
# that somehow sets the title for the screen.

# Set the screen title
case $TERM in
    screen*)
        # This is the escape sequence ESC k ESC \
        SCREENTITLE='\[\ek\w\e\\\]'
        ;;
    *)
        SCREENTITLE=''
        ;;
esac
PS1="${SCREENTITLE}${PS1}"

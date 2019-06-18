screen() {
    case "$*" in
	    -S*)
		    echo "### This is a wrapper for GNU screen which has been source in .bashrc ###"
		    echo "### Hieu Tran ###"
		    echo "Do you want to make new screen session with dynamic title?"
            select dyna_title in "Yes" "No"; do 
                case $dyna_title in
                    Yes)
                       break
                        ;;
                    No)
                        break
                        ;;
                esac
            done
		    echo "Is this screen for remote work?"
            select remote_scr in "Yes" "No"; do
                case $remote_scr in
                    Yes) 
                        (   export dyna_title 
                            command screen "$@" -c ~/.screenrc_remote ) #use command here to prevent self-calling this function recursively
                        break
                        ;;
                    No)
                        (   export dyna_title 
                            command screen "$@" )
                        break
                        ;;
                esac
            done
            ;;
        *) command screen "$@" ;;
    esac
}

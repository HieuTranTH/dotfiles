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
            export dyna_title

            echo "Is this screen for working?"
            select remote_scr in "Yes" "No"; do
                case $remote_scr in
                    Yes)
                        # Hostname partner specific ###########################
                        if [ $( hostname ) = "partner" ]; then
                            while true
                            do
                                read -p "What is the customer's device user name? " MYDEV
                                if [ ! -d /home/customers/$MYDEV ]; then
                                    echo "Customer's device user name not found. These are similar :"
                                    for i in /home/customers/*$MYDEV*; do
                                        basename $i
                                    done
                                else
                                    break
                                fi
                            done
                            export MYDEV
                            if [ ! -d /home/customers/$MYDEV/hieu ]; then
                                make_customer_folder
                            fi
                        fi
                        # End of Hostname partner specific ####################

                        command screen "$@" -c "~/.screenrc_extra/screenrc_$(hostname)" #use "command" here to prevent self-calling this function recursively
                        break
                        ;;
                    No)
                        command screen "$@"
                        break
                        ;;
                esac
            done
            ;;
        *) command screen "$@" ;;
    esac
}

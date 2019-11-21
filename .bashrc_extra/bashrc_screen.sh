screen() {
    case "$*" in
        -S*)
            echo "### This is a wrapper for GNU screen which has been source in .bashrc ###"
            echo "### Hieu Tran ###"

            # Check if SSH agent is running to make sure it will be forwarded inside screen session
            ssh-add -l | grep -q "$HOME/.ssh/id_rsa\|hieu@tuxera.com" || echo -e "\n############## WARNING ##############\nMake sure SSH agent is running with an identity first"

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
                        if [ $( hostname -s ) = "partner" ]; then
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

                        # Hostname raspberrypi specific ###########################
                        if [ $( hostname -s ) = "raspberrypi" ]; then
                            cd ~/hieu/spinfs
                        fi
                        # End of Hostname raspberrypi specific ####################

                        command screen "$@" -c "~/.screenrc_extra/screenrc_$( hostname -s )" #use "command" here to prevent self-calling this function recursively
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

screen -X caption always '%{wR}%=FULL_SCREEN%='
screen -X layout title
screen -X layout new tmp_full
screen -X select $WINDOW

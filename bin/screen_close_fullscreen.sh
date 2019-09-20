screen -X caption splitonly "%?%F%{+u W.}%:%?%=%3n %t%="
screen -X layout remove tmp_full
screen -X layout select
screen -X lastmsg

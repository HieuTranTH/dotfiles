screen -X layout remove tmp_full
screen -X caption splitonly '%?%F%{.y}%:%?%3 %t'
screen -X layout select
screen -X lastmsg

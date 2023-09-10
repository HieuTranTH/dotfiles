function box() {
    title="| $1 |"
    edge=$( echo "$title" | sed 's/./*/g' )
    echo "$edge"
    echo -e "$title"
    echo "$edge"
}

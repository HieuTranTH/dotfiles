function rednotebook() {
    echo "### Wrapper to check existing rednotebook ###"
    pgrep rednotebook && echo "Rednotebook is running" && kill $(pgrep rednotebook)
    command rednotebook
}

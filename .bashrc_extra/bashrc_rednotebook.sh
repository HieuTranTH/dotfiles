function rednotebook() {
    echo "### Wrapper to check existing rednotebook ###"
    pgrep rednotebook && echo "Rednotebook was previously running. Killing now to restart." && kill $(pgrep rednotebook)
    command rednotebook
}

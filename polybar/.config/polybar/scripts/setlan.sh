if setxkbmap -query | grep layout | grep us
then
    setxkbmap se
else
    setxkbmap us
fi

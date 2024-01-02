
if [ $# -eq 0 ]
then
    while [ 1 ]
    do
        id=`pactl list short sinks | grep RUNNING | awk '{print $1}'`
        volume=`pactl get-sink-volume $id | awk '{print substr($5, 1, length($5)-1)}'`

        if [ ! -z $id ]
        then
            if [ `pactl get-sink-mute $id | awk '{print $2}'` = 'yes' ]
            then
                echo 'mute'
            else
                echo $volume
            fi
        fi
        sleep 0.1
    done
else
    id=`pactl list short sinks | grep RUNNING | awk '{print $1}'`
    if [ ! -z $id ]
    then
        if [ "$1" = 'mute' ]
        then
            if [ `pactl get-sink-mute $id | awk '{print $2}'` = 'no' ]
            then
                pactl set-sink-mute $id yes
            else
                pactl set-sink-mute $id no
            fi
        fi
    fi

    volume=`pactl get-sink-volume $id | awk '{print substr($5, 1, length($5)-1)}'`
    newvol=$(expr $volume + $1)
    pactl set-sink-volume $id $newvol%
fi




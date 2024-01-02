# works for me hehe
sinkid=`pactl list short sinks | grep RUNNING -1 | grep -e 'SUSPENDED' -e 'IDLE' | awk '{print $1}'`
$HOME/.config/polybar/scripts/audiodev.sh $sinkid

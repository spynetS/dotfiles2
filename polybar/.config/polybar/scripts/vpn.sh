if mullvad status | grep -q "Disconnected"
    then
        mullvad connect
else
    mullvad disconnect
fi




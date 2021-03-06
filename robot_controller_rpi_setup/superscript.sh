if [[ $env == "test" ]]; then
    sudo python /home/pi/Ramudroid/robot_controller_rpi_setup/test/testrun.py
elif [[ $env == "prod" ]]; then
    sudo env FLASK_ENV=development FLASK_APP=/home/pi/Ramudroid/webservices_rpi_arduino_comm/main.py flask run -h 0.0.0.0 --cert=adhoc
    service uv4l_raspicam stop
    export OPENSSL_CONF=/etc/ssl/
    uv4l --external-driver --device-name=video0 \
        --server-option '--use-ssl=yes' \
        --server-option '--ssl-private-key-file=/home/pi/selfsign.key' \
        --server-option '--ssl-certificate-file=/home/pi/selfsign.crt' \
        --verbosity=7 \
        --server-option '--enable-webrtc-video=yes' \
        --server-option '--enable-webrtc-audio=no' \
        --server-option '--webrtc-receive-video=yes' \
        --server-option '--webrtc-renderer-fullscreen=yes' \
        --server-option '--webrtc-receive-datachannels=yes' \
        --server-option '--webrtc-receive-audio=yes' \
        --auto-video_nr \
        --server-option '--enable-control-panel' \
        --server-option '--enable-builtin-ui'
else
    exit 0
fi
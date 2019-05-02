#/bin/sh
echo "~~~~~~~~~ Services ~~~~~~~~~"
service -e
echo "~~~~~~~~~ Running Processes ~~~~~~~~~"
ps auxww
echo "~~~~~~~~~ Listening Sockets ~~~~~~~~~"
sockstat -l
echo "~~~~~~~~~ Plugin Config ~~~~~~~~~"
cat /root/plugin_config

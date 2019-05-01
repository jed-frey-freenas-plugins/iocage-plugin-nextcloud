#/bin/sh
echo "~~~~~~~~~ Services ~~~~~~~~~"
service -e
echo "~~~~~~~~~ Running Processes ~~~~~~~~~"
ps auxww
echo "~~~~~~~~~ Listening Sockets ~~~~~~~~~"
sockstat -l

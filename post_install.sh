#!/bin/sh
#!/bin/sh
# To disable any post_install scripts, change suffix from .sh

for SCRIPT in  `ls /post_install/*.sh`
do                                     # for SCRIPT {
echo "~~~~~~~~~~ ${SCRIPT} ~~~~~~~~~~" # Echo Das Script
sh -c "${SCRIPT}"                      # Run das script.
echo "Result: $?"
done                                   # }

exit 0

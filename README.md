# iocage-plugin-nextcloud

Artifacts for NextCloud iocage plugin.

Improvements over iXsystems Nextcloud plugin:

- SSL (self-signed) enabled and enforced. 
- NextCloud installed with admin account "nextcloud_admin" and randomly generated password. 
- MySQL listening on socket only.
- Redis for caching. (Must be manually enabled).
- mdns

# Installation

    fetch https://raw.githubusercontent.com/jed-frey-freenas-plugins/iocage-plugin-nextcloud/11.2-RELEASE/nextcloud.json
    iocage fetch --plugin-file --accept --name nextcloud.json ip4_addr="none"

Password for Nextcloud should be printed to the terminal.


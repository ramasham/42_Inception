#!/bin/sh

# Create necessary directories
mkdir -p /etc/vsftpd
mkdir -p /var/www/html

# Check if config already exists, if not create it
if [ ! -f "/etc/vsftpd/vsftpd.conf" ]; then
    # Move config file to correct location
    cp /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf
    echo "Configured vsftpd with custom config"
fi

# Check if user exists before creating
if ! id -u "$FTP_USR" &>/dev/null; then
    # Add the FTP user
    adduser "$FTP_USR" --disabled-password --gecos ""
    echo "$FTP_USR:$FTP_PWD" | chpasswd
    echo "Created FTP user: $FTP_USR"
fi

# Set ownership of the web directory
chown -R "$FTP_USR":"$FTP_USR" /var/www/html
echo "Set $FTP_USR as owner of /var/www/html"

# Create or update user list
echo "$FTP_USR" > /etc/vsftpd.userlist
echo "Added $FTP_USR to vsftpd.userlist"

echo "FTP server starting on port 21..."
exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
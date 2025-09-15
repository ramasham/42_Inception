FROM debian:bullseye

#install vsftpd
#vsftpd is a software that runs an FTP server

#FTP = rules for file transfer
#vsftpd = program that implements those rules
RUN apt update && apt upgrade -y && apt install -y vsftpd

COPY conf/vsftpd.conf /tmp/vsftpd.conf
COPY tools/configure.sh /tmp/configure.sh

ENTRYPOINT ["sh", "/tmp/configure.sh"]
CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]

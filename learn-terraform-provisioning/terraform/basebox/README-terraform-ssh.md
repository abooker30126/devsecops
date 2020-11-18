
tonybooker@iMac27-Pro:$ ssh -o IdentitiesOnly=yes terraform@$(echo "aws_instance.web.public_ip" | terraform console) -i tf-packer
Welcome to Ubuntu 16.04.7 LTS (GNU/Linux 4.4.0-1113-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

0 packages can be updated.
0 updates are security updates.

New release '18.04.5 LTS' available.
Run 'do-release-upgrade' to upgrade to it.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

terraform@ip-10-1-0-27:~$

#!/bin/bash

echo "First Name: "
read firstname
echo "Last Name: "
read lastname
echo "Password"
read password

username=$(echo $firstname | tr [:upper:] [:lower:] | cut -c 1)$(echo ${lastname##*( )} | tr [:upper:] [:lower:])
newuid=$[$(ldapsearch -b "dc=lab,dc=pl" -x -LLL uidNumber | grep "uidNumber" | cut -d" " -f2 | sort -n -r | head -1) + 1]

file=${username}_${newuid}.ldif

cat > $file <<EOF
dn: cn=$username, dc=lab, dc=pl
cn: $username
gidNumber: 100
objectClass: top
objectClass: person
objectClass: posixAccount
objectClass: simpleSecurityObject
sn: $lastname
uid: $username
uidNumber: $newuid
homeDirectory: /home/$username
userpassword: $password
EOF

ldapadd -x -W -D "cn=admin,dc=lab,dc=pl" -f $file

if [ "$?" = "0" ]
then
    echo "ldap user created, creating home dir /home/$username..."
    sudo mkdir /home/$username
    sudo chmod 700 /home/$username
    sudo chown $newuid:100 /home/$username
    echo "Done"
else
    echo "ldapadd returned non-zero code, aborting..."
fi
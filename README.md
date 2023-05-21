# Arch-Linux-Installation-Script
Arch Linux Installtation Script with LVM on Luks with TPM2 and TPM PIN 


# Steps to Install Arch

- Run the first script (Uncomment deleting luks header and creating a new volume)
``` 
./InstallPt1.sh
```
- Run the second script as arch-chroot /mnt

```
./InstallPt2.sh
```

- Run the recommend.sh once you have rebooted after the previous script

```
./recommend.sh
```

- Run the applications.sh to install recommended applications

```
./applications.sh
```



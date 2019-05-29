fullpath=$(pwd)
name='KiesMondzorg'
ostype='Debian_64'

vboxmanage createvm --name $name --basefolder $fullpath/KiesMondzorg --ostype $ostype --default --register
vboxmanage storagectl $name --name mainHDD --controller IntelAhci --add sata --bootable on --portcount 1
vboxmanage storageattach $name --storagectl mainHDD --port 1 --type hdd --medium $fullpath/KiesMondzorgVDI.vdi

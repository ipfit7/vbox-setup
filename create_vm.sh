# TODO: Implement params here
fullpath=$(pwd)
name='KiesMondzorg'
ostype='Debian_64'

#TODO: ask for path to install the VM at.
#This part creates the VM, storage controller for the VM and attaches the VDI created by create_vdi.sh
echo "Creating VM with name " $name " at " $fullpath "..."
vboxmanage createvm --name $name --basefolder $fullpath/KiesMondzorg --ostype $ostype --default --register
echo "Creating storage controller for the new VM..."
vboxmanage storagectl $name --name mainHDD --controller IntelAhci --add sata --bootable on --portcount 1
echo "Attaching previously generated storage medium to the VM..."
vboxmanage storageattach $name --storagectl mainHDD --port 1 --type hdd --medium $fullpath/KiesMondzorgVDI.vdi

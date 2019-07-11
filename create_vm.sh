BASE_PATH=$(pwd)
VM_NAME="KiesMondzorg"

while getopts p:n:s: option
do
    case "${option}" in
    p) BASE_PATH=${OPTARG};;
    n) VM_NAME=${OPTARG};;
    esac
done;

FULL_PATH=$BASE_PATH/$VM_NAME
OS_TYPE='Debian_64'

VBOX_PATH=$FULL_PATH/$VM_NAME".vbox"

if [ -f $VBOX_PATH ]; then
    echo "VM Already exists. Aborting..."
    echo "Path checked: "$VBOX_PATH
    exit 1
fi

#This part creates the VM, storage controller for the VM and attaches the VDI created by create_vdi.sh
echo "Creating VM with name " $VM_NAME " at " $BASE_PATH "..."
vboxmanage createvm --name $VM_NAME --basefolder $BASE_PATH --ostype $OS_TYPE --default --register

echo "Creating storage controller for the new VM..."
vboxmanage storagectl $VM_NAME --name mainHDD --controller IntelAhci --add sata --bootable on --portcount 1

echo "Attaching previously generated storage medium to the VM..."
vboxmanage storageattach $VM_NAME --storagectl mainHDD --port 1 --type hdd --medium $BASE_PATH/$VM_NAME/$VM_NAME"VDI.vdi"

# Set some custom branding
mkdir -p $BASE_PATH/$VM_NAME/branding
cp ./res/kies-vm-icon.png $BASE_PATH/$VM_NAME/branding/kies-vm-icon.png
cp ./res/logo.bmp $BASE_PATH/$VM_NAME/branding/logo.bmp

VBoxManage modifyvm $VM_NAME --iconfile $BASE_PATH/$VM_NAME/branding/kies-vm-icon.png

BASE_PATH=$(pwd)
VM_NAME="KiesMondzorg"
VDI_SIZE=20480

while getopts p:n:s: option
do
    case "${option}" in
    p) BASE_PATH=${OPTARG};;
    n) VM_NAME=${OPTARG};;
    s) VDI_SIZE=${OPTARG};;
    esac
done;

mkdir -p BASE_PATH/$VM_NAME

DISK_NAME=$VM_NAME"VDI.vdi"
FULL_PATH=$BASE_PATH/$VM_NAME/$DISK_NAME

echo "Creating virtual hard disk"

# Remove existing VDI 
# Add check if exists, and ask user wether it should be deleted
# This only deletes the VDI if it's in the same path, with the same name
# Other HDDs with the same name may still be registered.
# TODO: Ask user if we should delete the disk 

# Check if there's previous VDI's on this path
if vboxmanage list hdds | grep $FULL_PATH --quiet; then
    echo "Deleting existing VDI..."
    # Try and delete them (it's probably us anyways)
    if VBoxManage closemedium disk $FULL_PATH --delete  > /dev/null 2>&1; then
        echo "Deleted VDI";
    else
        echo "Failed deleting VDI. Please detach it from any VM and try again."
        exit 1;
    fi;
fi


# Create the new VDI
VBoxManage createmedium disk --filename $FULL_PATH --size $VDI_SIZE --format VDI --variant Standard

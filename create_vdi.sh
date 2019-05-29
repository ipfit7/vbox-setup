# TODO: Implement params here
diskName="KiesMondzorgVDI.vdi"
fullPath=$(pwd)/$diskName
sizeMB=20480

echo "Creating virtual hard disk"

# Remove existing VDI 
# Add check if exists, and ask user wether it should be deleted
# This only deletes the VDI if it's in the same path, with the same name
# Other HDDs with the same name may still be registered.
# TODO: Ask user if we should delete the disk 

# Check if there's previous VDI's on this path
if vboxmanage list hdds | grep $fullPath --quiet; then
    echo "Deleting existing VDI..."
    # Try and delete them (it's probably us anyways)
    if VBoxManage closemedium disk $fullPath --delete  > /dev/null 2>&1; then
        echo "Deleted VDI";
    else
        echo "Failed deleting VDI. Please detach it from any VM and try again."
        exit 1;
    fi;
fi


# Create the new VDI
VBoxManage createmedium disk --filename $diskName --size $sizeMB --format VDI --variant Standard

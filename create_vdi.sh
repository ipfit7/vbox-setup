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
# TODO: Return the UUID
VBoxManage closemedium disk $fullPath --delete

# Create the new VDI
VBoxManage createmedium disk --filename $diskName --size $sizeMB --format VDI --variant Standard

BASE_PATH=$(pwd)
VM_NAME="KiesMondzorg"

while getopts p:n:s: option
do
    case "${option}" in
    p) BASE_PATH=${OPTARG};;
    n) VM_NAME=${OPTARG};;
    esac
done;

# Download debian iso if it isn't found in the current directory.
if [ ! -f debian.iso ]; then
    echo "Debian ISO not found... Downloading..."
    curl --output debian.iso -L https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.9.0-amd64-netinst.iso
fi

# Configure the unattended installer
vboxmanage unattended install $VM_NAME --iso=debian.iso --script-template=./unattended/preseed.cfg --post-install-template=./unattended/post_install.sh --install-additions --hostname=kiesmondzorg.local --start-vm=headless

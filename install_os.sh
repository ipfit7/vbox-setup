fullpath=$(pwd)
name='KiesMondzorg'

# Download debian iso if it isn't found in the current directory.
if [ ! -f $fullpath/debian.iso ]; then
    echo "Debian ISO not found... Downloading..."
    curl --output debian.iso -L https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.9.0-amd64-netinst.iso
fi

# Configure the unattended installer
vboxmanage unattended install $name --iso=$fullpath/debian.iso --script-template=$fullpath/unattended/preseed.cfg --post-install-template=$fullpath/unattended/post_install.sh --install-additions --hostname=kiesmondzorg.local --start-vm=headless

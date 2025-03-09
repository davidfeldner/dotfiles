echo "Removing Image"
rm nixos.qcow2

echo "Building new image"
nix build path:.#empty

echo "Copying image"
mkdir -p ~/vms
cp ./result/nixos.qcow2 ~/vms

echo "Fixing permissions"
chmod 666 ~/vms/nixos.qcow2

echo "Removing Original image"
rm -rf ./result

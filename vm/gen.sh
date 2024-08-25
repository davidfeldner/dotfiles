echo "Removing Image"
rm nixos.qcow2

echo "Building new image"
nix build .#empty

echo "Copying image"
mkdir -p ~/vms
cp ./result/nixos.qcow2 ~/vms

echo "Fixing permissions"
chmod 666 nixos.qcow2

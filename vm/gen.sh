echo "Removing Image"
rm nixos.qcow2

echo "Building new image"
nix build .#empty

echo "Copying image"
cp ./result/nixos.qcow2 .

echo "Fixing permissions"
chmod 666 nixos.qcow2

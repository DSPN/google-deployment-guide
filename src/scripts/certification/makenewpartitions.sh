echo "n
p
2
20971520
2795503615
w
"| sudo fdisk /dev/sda
sudo partprobe
sudo mkfs.ext4 /dev/sda2
mkdir data
sudo mount /dev/sda2 data
sudo chown cassandra:cassandra data/

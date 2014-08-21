echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
sudo apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | \
       sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | \
       sudo debconf-set-selections
sudo dpkg --configure -a
sudo apt-get install oracle-java7-installer  -y

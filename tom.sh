#!/bin/bash

TOMCAT_VERSION=$1

if [ -z "$TOMCAT_VERSION" ]; then
  echo "Usage: $0 <TOMCAT_VERSION>"
  echo "Example: $0 10.1.26"
  exit 1
fi

# Determine the OS type
OS=$(cat /etc/os-release | grep '^ID=' | cut -d '=' -f 2 | tr -d '"')

# Function to install Tomcat on Ubuntu
install_tomcat_ubuntu() {
   
     echo "Installing Tomcat on Ubuntu..."



#For security purposes, Tomcat should run under a separate, unprivileged user
sudo useradd -m -d /opt/tomcat -U -s /bin/false tomcat


#update the package manager
sudo apt update

#install the JDK
sudo apt install -y default-jdk

#check the version of the available Java installation
java -version

#go to tmp dir.
cd /tmp

#The wget command downloads resources from the Internet.
TOMCAT_MAJOR_VERSION=$(echo $TOMCAT_VERSION | cut -d. -f1)
wget https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -P /tmp

# Create necessary directories
sudo mkdir -p /opt/tomcat/latest

# Extract the archive
sudo tar xf /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/tomcat/latest --strip-components=1


#now grant tomcat ownership over the extracted installation
sudo chown -R tomcat:tomcat /opt/tomcat/latest
sudo chmod -R u+x /opt/tomcat/latest/bin


#confgurng dmin user
sudo bash -c 'cat <<EOF > /opt/tomcat/latest/conf/tomcat-users.xml
<tomcat-users>
    <role rolename="manager-gui"/>
    <user username="manager" password="19@priyanshu" roles="manager-gui"/>
    <role rolename="admin-gui"/>
    <user username="admin" password="19@priyanshu" roles="manager-gui,admin-gui"/>
</tomcat-users>
EOF'

#creating a systed service
sudo update-java-alternatives -l


  # Create systemd service file
  # Create systemd service file
sudo bash -c 'cat <<EOF > /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/default-java
Environment=CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat/latest
Environment=CATALINA_BASE=/opt/tomcat/latest
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF'




#Reload the systemd daemon so that it becomes aware of the new service:
sudo systemctl daemon-reload

#start the Tomcat service
sudo systemctl start tomcat

echo "tomcat install in ubuntu successfully"



#look at its status to confirm that it started successfully
sudo systemctl status tomcat
}


# Function to install Tomcat on Red Hat (RHEL/CentOS)
install_tomcat_rhel() {
  echo "Installing Tomcat on Red Hat..."

  #For security purposes, Tomcat should run under a separate, unprivileged user
sudo useradd -m -d /opt/tomcat -U -s /bin/false tomcat


#update the package manager
sudo apt update

#install the JDK
sudo yum install -y java-1.8.0-openjdk wget

#check the version of the available Java installation
java -version

#go to tmp dir.
cd /tmp

#The wget command downloads resources from the Internet.
TOMCAT_MAJOR_VERSION=$(echo $TOMCAT_VERSION | cut -d. -f1)
wget https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -P /tmp


#extract the archive
sudo tar xf /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/tomcat


#now grant tomcat ownership over the extracted installation
sudo chown -R tomcat:tomcat /opt/tomcat/
sudo chmod -R u+x /opt/tomcat/bin


#confgurng dmin user
sudo bash -c 'cat <<EOF > /opt/tomcat/conf/tomcat-users.xml

<role rolename="manager-gui" />
<user username="manager" password="19@priyanshu" roles="manager-gui" />
<role rolename="admin-gui" />
<user username="admin" password="19@priyanshu" roles="manager-gui,admin-gui" />
EOF'

#creating a systed service
sudo update-java-alternatives -l


  # Create systemd service file
  sudo bash -c 'cat <<EOF > /etc/systemd/system/tomcat.service
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/default-java
Environment=CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat/latest
Environment=CATALINA_BASE=/opt/tomcat/latest
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF'



#Reload the systemd daemon so that it becomes aware of the new service:
sudo systemctl daemon-reload

#start the Tomcat service
sudo systemctl start tomcat

echo "tomcat install in ubuntu successfully"



#look at its status to confirm that it started successfully
sudo systemctl status tomcat
}

# Install Tomcat based on OS type
case "$OS" in
  ubuntu)
    install_tomcat_ubuntu
    ;;
  rhel|centos)
    install_tomcat_rhel
    ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac

echo "Tomcat installation completed."


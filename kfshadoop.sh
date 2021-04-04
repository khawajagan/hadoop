#!/bin/bash
myDL="========================="
myM00="Completed! "
myM01="Step 01"
myM02="Step 02"
myM03="Step 03"
myM04="Step 04"
myM05="Step 05"
myM06="Hadoop"
myM07="Linux"
myM08="Installing"
myM09="Configuring"
myM10="..."
myM11="huser"
myM12="sapFNl8dBglDQ"
myM13=$(ls h*) # "hadoop-3.2.2.tar.gz"
myM14=$(pwd)
myM15=$myM14/$myM13
myM16=$(echo $myM13 | rev | cut -c8- | rev) 
myM17="bashrc"
myM18="hadoop-env.sh"
myM19="core-site.xml"
myM20="hdfs-site.xml"
myM21="mapred-site-xml"
myM22="yarn-site.xml"
mySL="-------------------------"

myMsg()
{
	echo $1
}


mywork01 ()
{
	sudo apt update
	myMsg $myDL
}
myWork01 ()
{
	myX=$(ls /home/$1/hadoop/)
	myY=$(which $2)
	myZ=$(readlink -f $myY)
	myMsg "$myM09 $myM17"
	myMsg $mySL
	sudo -H -u $1 bash -c 'echo $myM08 $myX'
	sudo -H -u $1 bash -c 'echo "#Hadoop Related Options" >> $HOME/.bashrc '
	sudo -H -u $1 bash -c 'echo "export HADOOP_HOME=\$HOME/hadoop/$(ls $HOME/hadoop/)" >> $HOME/.bashrc '
	sudo -H -u $1 bash -c 'echo "export HADOOP_INSTALL=\$HADOOP_HOME" >> $HOME/.bashrc '
	sudo -H -u $1 bash -c 'echo "export HADOOP_MAPRED_HOME=\$HADOOP_HOME" >> $HOME/.bashrc '
	sudo -H -u $1 bash -c 'echo "export HADOOP_COMMON_HOME=\$HADOOP_HOME" >> $HOME/.bashrc '
	sudo -H -u $1 bash -c 'echo "export HADOOP_HDFS_HOME=\$HADOOP_HOME" >> $HOME/.bashrc '
	sudo -H -u $1 bash -c 'echo "export YARN_HOME=\$HADOOP_HOME" >> $HOME/.bashrc '
	sudo -H -u $1 bash -c 'echo "export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native" >> $HOME/.bashrc '
	sudo -H -u $1 bash -c 'echo "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin" >> $HOME/.bashrc '
	sudo -H -u $1 bash -c 'echo "export HADOOP_OPTS=\"-Djava.library.path=\$HADOOP_HOME/lib/native\"" >> $HOME/.bashrc '
	sudo -H -u $1 bash -c 'echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> $HOME/.bashrc '
	myMsg $myDL
}
mywork02 ()
{
	myMsg "$myM09 $1 $myM10"
	myMsg $mySL
	sudo apt install $1 -y
	myMsg $myDL
}
myWork02 ()
{
	myMsg "$myM09 $myM18"
	myMsg $mySL
	sudo echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> $2/etc/hadoop/hadoop-env.sh 
	myMsg "$myM09 $myM19"
	myMsg $mySL
	sudo mkdir -p /home/$1/hadoop/tmpdata
	sudo echo "<configuration>" > $2/etc/hadoop/core-site.xml
	sudo echo "<property> " >> $2/etc/hadoop/core-site.xml
	sudo echo "  <name>hadoop.tmp.dir</name>" >> $2/etc/hadoop/core-site.xml
	sudo echo "  <value>/home/$1/hadoop/tmpdata</value>" >> $2/etc/hadoop/core-site.xml
	sudo echo "</property>" >> $2/etc/hadoop/core-site.xml
	sudo echo "<property>" >> $2/etc/hadoop/core-site.xml
	sudo echo "  <name>fs.default.name</name>" >> $2/etc/hadoop/core-site.xml
	sudo echo "  <value>hdfs://127.0.0.1:9000</value>" >> $2/etc/hadoop/core-site.xml
	sudo echo "</property>" >> $2/etc/hadoop/core-site.xml
	sudo echo "</configuration>" >> $2/etc/hadoop/core-site.xml
	myMsg $myDL
}
mywork03 ()
{
	sudo useradd -m -p $1 -s /bin/bash $2
	sudo usermod -aG sudo $2
	sudo -H -u $2 bash -c 'echo "I am $USER, with uid $UID and home $HOME"' 
	sudo -H -u $2 bash -c 'ssh-keygen -t rsa -P "" -f $HOME/.ssh/id_rsa'
	sudo -H -u $2 bash -c 'cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys'
	sudo -H -u $2 bash -c 'chmod 0600 $HOME/.ssh/authorized_keys'
	myMsg $myDL
}
myWork03 ()
{
	sudo mkdir -p /home/$1/hadoop/dfsdata/namenode
	sudo mkdir -p /home/$1/hadoop/dfsdata/datanode
	myMsg "$myM09 $myM20"
	myMsg $mySL
	sudo echo "<configuration>" > $2/etc/hadoop/hdfs-site.xml
	sudo echo "<property>" >> $2/etc/hadoop/hdfs-site.xml
	sudo echo "  <name>dfs.data.dir</name>" >> $2/etc/hadoop/hdfs-site.xml
	sudo echo "  <value>/home/$1/hadoop/dfsdata/namenode</value>" >> $2/etc/hadoop/hdfs-site.xml
	sudo echo "</property>" >> $2/etc/hadoop/hdfs-site.xml
	sudo echo "<property>" >> $2/etc/hadoop/hdfs-site.xml
	sudo echo "  <name>dfs.data.dir</name>" >> $2/etc/hadoop/hdfs-site.xml
	sudo echo "  <value>/home/$1/hadoop/dfsdata/datanode</value>" >> $2/etc/hadoop/hdfs-site.xml
	sudo echo "</property>" >> $2/etc/hadoop/hdfs-site.xml
	sudo echo "<property>" >> $2/etc/hadoop/hdfs-site.xml
	sudo echo "  <name>dfs.replication</name>" >> $2/etc/hadoop/hdfs-site.xml
	sudo echo "  <value>1</value>" >> $2/etc/hadoop/hdfs-site.xml
	sudo echo "</property>" >> $2/etc/hadoop/hdfs-site.xml
	sudo echo "</configuration>" >> $2/etc/hadoop/hdfs-site.xml
	myMsg $myDL
}
mywork04 ()
{
	chmod 777 $myM14/$myM13
	sudo -H -u $2 bash -c 'rm -R $HOME/hadoop'
	sudo -H -u $2 bash -c 'mkdir $HOME/hadoop'
	sudo -H -u $2 bash -c 'chmod 777 -R $HOME/hadoop' 
	sudo cp -v $myM14/$myM13 /home/$2/hadoop/$myM13
	sudo -H -u $2 bash -c 'tar -zxf $HOME/hadoop/* -C $HOME/hadoop'
	sudo -H -u $2 bash -c 'rm -f $HOME/hadoop/*.tar.gz'
	myMsg $myDL
}

myWork04 ()
{
	myMsg "$myM09 $myM21"
	myMsg $mySL
	echo "<configuration> " > $2/etc/hadoop/mapred-site.xml
	echo "<property> " >> $2/etc/hadoop/mapred-site.xml
	echo "  <name>mapreduce.framework.name</name> " >> $2/etc/hadoop/mapred-site.xml
	echo "  <value>yarn</value> " >> $2/etc/hadoop/mapred-site.xml
	echo "</property> " >> $2/etc/hadoop/mapred-site.xml
	echo "</configuration>" >> $2/etc/hadoop/mapred-site.xml
	myMsg "$myM09 $myM22"
	myMsg $mySL
	echo "<configuration>" > $2/etc/hadoop/yarn-site.xml
	echo "<property>" >> $2/etc/hadoop/yarn-site.xml
	echo "  <name>yarn.nodemanager.aux-services</name>" >> $2/etc/hadoop/yarn-site.xml
	echo "  <value>mapreduce_shuffle</value>" >> $2/etc/hadoop/yarn-site.xml
	echo "</property>" >> $2/etc/hadoop/yarn-site.xml
	echo "<property>" >> $2/etc/hadoop/yarn-site.xml
	echo "  <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>" >> $2/etc/hadoop/yarn-site.xml
	echo "  <value>org.apache.hadoop.mapred.ShuffleHandler</value>" >> $2/etc/hadoop/yarn-site.xml
	echo "</property>" >> $2/etc/hadoop/yarn-site.xml
	echo "<property>" >> $2/etc/hadoop/yarn-site.xml
	echo "  <name>yarn.resourcemanager.hostname</name>" >> $2/etc/hadoop/yarn-site.xml
	echo "  <value>127.0.0.1</value>" >> $2/etc/hadoop/yarn-site.xml
	echo "</property>" >> $2/etc/hadoop/yarn-site.xml
	echo "<property>" >> $2/etc/hadoop/yarn-site.xml
	echo "  <name>yarn.acl.enable</name>" >> $2/etc/hadoop/yarn-site.xml
	echo "  <value>0</value>" >> $2/etc/hadoop/yarn-site.xml
	echo "</property>" >> $2/etc/hadoop/yarn-site.xml
	echo "<property>" >> $2/etc/hadoop/yarn-site.xml
	echo "  <name>yarn.nodemanager.env-whitelist</name>  " >> $2/etc/hadoop/yarn-site.xml 
	echo "  <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PERPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>" >> $2/etc/hadoop/yarn-site.xml
	echo "</property>" >> $2/etc/hadoop/yarn-site.xml
	echo "</configuration>" >> $2/etc/hadoop/yarn-site.xml
	myMsg $myDL
}
myWork99 ()
{
	sudo chown -R $1:$1 /home/$1/hadoop
	sudo -H -u $1 bash -c "$2/bin/hdfs namenode -format"
	sudo -H -u $1 bash -c "$2/sbin/start-dfs.sh"
	sudo -H -u $1 bash -c "$2/sbin/start-yarn.sh"
	myMsg $mySL
	echo "Please Login With Following User"
	myMsg $mySL
	echo "UserName : $1  Password : $1"
	myMsg $mySL
	echo "and run the following commands"
	myMsg $mySL
	echo "hdfs namenode -format"
	echo "$2/sbin/start-dfs.sh"
	echo "$2/sbin/start-yarn.sh"
	echo "jps"
	#/usr/bin/firefox --new-window http://localhost:9870
	#/usr/bin/firefox --new-window http://localhost:9864
	#/usr/bin/firefox --new-window http://localhost:8088
	myMsg $myDL
}
mywork00 ()
{
	myMsg $myDL
	myMsg "$myM08 $myM06 in $myM07"
	myMsg $myDL
	mywork01
	myMsg "$myM01 $myM00 $myM10"
	myMsg $myDL
	mywork02 openssh-server
	mywork02 openssh-client
	mywork02 openjdk-8-jdk
	myMsg "$myM02 $myM00 $myM10"
	myMsg $myDL
	mywork03 $myM12 $myM11
	myMsg "$myM03 $myM00 $myM10"
	myMsg $myDL
	mywork04 $myM11 $myM11
	myMsg "$myM04 $myM00 $myM10"
	myMsg $myDL
}

myWork00 ()
{
	myMsg "$myM09 $myM06 in $myM07"
	myMsg $myDL
	myWork01 $myM11 javac $myM16
	myMsg "$myM01 $myM00 $myM10"
	myMsg $myDL
	myWork02 $myM11 /home/$myM11/hadoop/$myM16
	myMsg "$myM02 $myM00 $myM10"
	myMsg $myDL
	myWork03 $myM11 /home/$myM11/hadoop/$myM16
	myMsg "$myM03 $myM00 $myM10"
	myMsg $myDL
	myWork04 $myM11 /home/$myM11/hadoop/$myM16
	myMsg "$myM04 $myM00 $myM10"
	myMsg $myDL
	myWork99 $myM11 /home/$myM11/hadoop/$myM16
	myMsg "$myM05 $myM00 $myM10"
	myMsg $myDL
}

mywork00
myWork00

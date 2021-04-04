# hadoop

This project provides a simple way to install hadoop on linux machine in a single node mode for testing.

In order to use this project, please follow the following steps.

1 - Download hadoop installer from https://hadoop.apache.com

2 - In the folder where hadoop tar.gz file is availabale, open the TERMINAL.

3 - Issue the following command to download this project's shells script

    wget https://github.com/khawajagan/hadoop/blob/main/kfshadoop.sh
    
4 - Now you must have only two files in the directoy i.e. kfshadoop.sh and apache hadoop tar.gz file.

5 - Issue the following command to make the shell script executeable.

    chmod 777 kfshadoop.sh
    
6 - Issue the following command to run the shell script.

    sudo ./kfshadoop.sh
    
7 - Script will automatically install hadoop in your linux machine and create a new user with following credentials.

    User Name : huser        Password  : huser

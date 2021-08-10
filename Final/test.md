Cloudera CM Server Install

1. training ���� ���� UID(8800) �� �н����� ����
sudo useradd -u 8800 training
sudo passwd training

2. skcc �׷� ����
sudo groupadd skcc

3. skcc �׷쿡 training ���� �Ҵ�
sudo usermod -G skcc -a training

4. hostname ����
sudo hostnamectl set-hostname cm.bdai.com

5. /etc/hosts ���Ͽ� ���� dns �߰�
172.31.57.173 cm.bdai.com cm
172.31.60.108 m1.bdai.com m1
172.31.53.162 d1.bdai.com d1
172.31.52.225 d2.bdai.com d2
172.31.55.233 d3.bdai.com d3

6. openjdk 1.8 ��ġ
sudo yum install -y java-1.8.0-openjdk-devel 

7. wget ��ġ
sudo yum install -y wget

8. mysql connector ��ġ �� ��������
sudo wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.47.tar.gz ~/
tar zxvf mysql-connector-java-5.1.47.tar.gz

9. java lib ���� ���� �� mysql connector ���� �̵�
sudo mkdir -p /usr/share/java/
sudo cp ~/mysql-connector-java-5.1.47/mysql-connector-java-5.1.47-bin.jar /usr/share/java/mysql-connector-java.jar 

10. cloudera-manager.repo yum repo ���� �ٿ�ε� �� yum ��ο� ���� 
sudo wget http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/cloudera-manager.repo -P /etc/yum.repos.d/ 
sudo rpm --import http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/RPM-GPG-KEY-cloudera 

11. cloudera-manager.repo ���� baseurl �ۺ� �ּҸ� intensive�� repo url�� ����
sudo vi /etc/yum.repos.d/cloudera-manager.repo
baseurl=http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/
gpgkey =http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/RPM-GPG-KEY-cloudera 

12. cloudera-manager daemon, server, agent ��ġ
sudo yum install -y cloudera-manager-daemons cloudera-manager-server 
sudo yum install -y cloudera-manager-agent

13. mariadb ��ġ �� ���� ���/����
sudo yum install -y mariadb-server 
sudo systemctl enable mariadb
sudo systemctl start mariadb
sudo /usr/bin/mysql_secure_installation 
 
14. cm �� �ʿ��� databse, dbuser ���� sql
CREATE DATABASE scm DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
GRANT ALL ON scm.* TO 'scm-user'@'%' IDENTIFIED BY 'somepassword'; 
CREATE DATABASE amon DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
GRANT ALL ON amon.* TO 'amon-user'@'%' IDENTIFIED BY 'somepassword'; 
CREATE DATABASE rman DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
GRANT ALL ON rman.* TO 'rman-user'@'%' IDENTIFIED BY 'somepassword';
CREATE DATABASE hue DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
GRANT ALL ON hue.* TO 'hue-user'@'%' IDENTIFIED BY 'somepassword'; 
CREATE DATABASE metastore DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
GRANT ALL ON metastore.* TO 'metastore-user'@'%' IDENTIFIED BY 'somepassword'; 
CREATE DATABASE sentry DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
GRANT ALL ON sentry.* TO 'sentry-user'@'%' IDENTIFIED BY 'somepassword';
CREATE DATABASE oozie DEFAULT CHARACTER SET utf8 DEFAULT COLLATE
utf8_general_ci;
GRANT ALL ON oozie.* TO 'oozie-user'@'%' IDENTIFIED BY 'somepassword';
GRANT ALL ON test.* TO 'eduuser'@'%' IDENTIFIED BY 'letmein';
FLUSH PRIVILEGES;
SHOW DATABASES;
EXIT;

15. scm databases ���� ��ũ��Ʈ ���� 
sudo /usr/share/cmf/schema/scm_prepare_database.sh mysql scm scm-user somepassword
sudo rm /etc/cloudera-scm-server/db.mgmt.properties

16. cloudera-scm-server ����
sudo systemctl start cloudera-scm-server

17. ui ����

18. intensive parcel repo �ּҷ� ����

19. hadoop eco ��ġ hdfs yarn hive sqoop


===========================================================
Cloudera SCM Agent ���� ��ġ (m1, d1, d2, d3)
1. hostname ����
sudo hostnamectl set-hostname m1.bdai.com

2. host���Ͽ� dns �߰�
sudo vi /etc/hosts
172.31.57.173 cm.bdai.com cm
172.31.60.108 m1.bdai.com m1
172.31.53.162 d1.bdai.com d1
172.31.52.225 d2.bdai.com d2
172.31.55.233 d3.bdai.com d3

3. openjdk 1.8 ��ġ
sudo yum install -y java-1.8.0-openjdk-devel 

4. wget ��ġ
sudo yum install -y wget

5. mysql connector ��ġ �� ��������
sudo wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.47.tar.gz ~/
tar zxvf mysql-connector-java-5.1.47.tar.gz

6. java lib ���� ���� �� mysql connector ���� �̵�
sudo mkdir -p /usr/share/java/
sudo cp ~/mysql-connector-java-5.1.47/mysql-connector-java-5.1.47-bin.jar /usr/share/java/mysql-connector-java.jar 

7. cloudera-manager.repo yum repo ���� �ٿ�ε� �� yum ��ο� ����
sudo wget http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/cloudera-manager.repo -P /etc/yum.repos.d/ 
sudo rpm --import http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/RPM-GPG-KEY-cloudera 

8. cloudera-manager.repo ���� baseurl �ۺ� �ּҸ� intensive�� repo url�� ����
sudo vi /etc/yum.repos.d/cloudera-manager.repo
baseurl=http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/
gpgkey =http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/RPM-GPG-KEY-cloudera 

9. cloudera-manager agent ��ġ
sudo yum install -y cloudera-manager-agent

10. cloudera-managet-agent cm master ���� cm������ ����
sudo vi /etc/cloudera-scm-agent/config.ini
server_host=cm

11. cloudera-scm-agent ����
sudo systemctl start cloudera-scm-agent






Cloudera CM Server Install

1. training 유저 생성 UID(8800) 및 패스워드 설정
sudo useradd -u 8800 training
sudo passwd training

2. skcc 그룹 생성
sudo groupadd skcc

3. skcc 그룹에 training 유저 할당
sudo usermod -G skcc -a training

4. hostname 설정
sudo hostnamectl set-hostname cm.bdai.com

5. /etc/hosts 파일에 서버 dns 추가
172.31.57.173 cm.bdai.com cm
172.31.60.108 m1.bdai.com m1
172.31.53.162 d1.bdai.com d1
172.31.52.225 d2.bdai.com d2
172.31.55.233 d3.bdai.com d3

6. openjdk 1.8 설치
sudo yum install -y java-1.8.0-openjdk-devel 

7. wget 설치
sudo yum install -y wget

8. mysql connector 설치 및 압축해제
sudo wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.47.tar.gz ~/
tar zxvf mysql-connector-java-5.1.47.tar.gz

9. java lib 폴더 생성 후 mysql connector 파일 이동
sudo mkdir -p /usr/share/java/
sudo cp ~/mysql-connector-java-5.1.47/mysql-connector-java-5.1.47-bin.jar /usr/share/java/mysql-connector-java.jar 

10. cloudera-manager.repo yum repo 파일 다운로드 후 yum 경로에 저장 
sudo wget http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/cloudera-manager.repo -P /etc/yum.repos.d/ 
sudo rpm --import http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/RPM-GPG-KEY-cloudera 

11. cloudera-manager.repo 파일 baseurl 퍼블릭 주소를 intensive용 repo url로 수정
sudo vi /etc/yum.repos.d/cloudera-manager.repo
baseurl=http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/
gpgkey =http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/RPM-GPG-KEY-cloudera 

12. cloudera-manager daemon, server, agent 설치
sudo yum install -y cloudera-manager-daemons cloudera-manager-server 
sudo yum install -y cloudera-manager-agent

13. mariadb 설치 및 서비스 등록/시작
sudo yum install -y mariadb-server 
sudo systemctl enable mariadb
sudo systemctl start mariadb
sudo /usr/bin/mysql_secure_installation 
 
14. cm 에 필요한 databse, dbuser 생성 sql
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

15. scm databases 설정 스크립트 실행 
sudo /usr/share/cmf/schema/scm_prepare_database.sh mysql scm scm-user somepassword
sudo rm /etc/cloudera-scm-server/db.mgmt.properties

16. cloudera-scm-server 실행
sudo systemctl start cloudera-scm-server

17. ui 접속

18. intensive parcel repo 주소로 수정

19. hadoop eco 설치 hdfs yarn hive sqoop


===========================================================
Cloudera SCM Agent 서버 설치 (m1, d1, d2, d3)
1. hostname 설정
sudo hostnamectl set-hostname m1.bdai.com

2. host파일에 dns 추가
sudo vi /etc/hosts
172.31.57.173 cm.bdai.com cm
172.31.60.108 m1.bdai.com m1
172.31.53.162 d1.bdai.com d1
172.31.52.225 d2.bdai.com d2
172.31.55.233 d3.bdai.com d3

3. openjdk 1.8 설치
sudo yum install -y java-1.8.0-openjdk-devel 

4. wget 설치
sudo yum install -y wget

5. mysql connector 설치 및 압축해제
sudo wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.47.tar.gz ~/
tar zxvf mysql-connector-java-5.1.47.tar.gz

6. java lib 폴더 생성 후 mysql connector 파일 이동
sudo mkdir -p /usr/share/java/
sudo cp ~/mysql-connector-java-5.1.47/mysql-connector-java-5.1.47-bin.jar /usr/share/java/mysql-connector-java.jar 

7. cloudera-manager.repo yum repo 파일 다운로드 후 yum 경로에 저장
sudo wget http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/cloudera-manager.repo -P /etc/yum.repos.d/ 
sudo rpm --import http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/RPM-GPG-KEY-cloudera 

8. cloudera-manager.repo 파일 baseurl 퍼블릭 주소를 intensive용 repo url로 수정
sudo vi /etc/yum.repos.d/cloudera-manager.repo
baseurl=http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/
gpgkey =http://ec2-3-35-165-150.ap-northeast-2.compute.amazonaws.com:8060/cloudera-repos/cdh5/5.16.2/RPM-GPG-KEY-cloudera 

9. cloudera-manager agent 설치
sudo yum install -y cloudera-manager-agent

10. cloudera-managet-agent cm master 서버 cm서버로 설정
sudo vi /etc/cloudera-scm-agent/config.ini
server_host=cm

11. cloudera-scm-agent 실행
sudo systemctl start cloudera-scm-agent






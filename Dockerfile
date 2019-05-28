FROM tomcat:7
# Take the war and copy to webapps of tomcatserver
COPY /target/myweb.war /usr/local/tomcat/webapps/
COPY /root/manager.xml /usr/local/tomcat/conf/Catalina/localhost
COPY /root/tomcat-users.xml /usr/local/tomcat/conf

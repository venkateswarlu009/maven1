FROM tomcat:7
# Take the war and copy to webapps of tomcatserver
COPY /target/myweb.war /usr/local/tomcat/webapps/
#COPY /target/manager.xml /usr/local/tomcat/conf/
COPY /target/tomcat-users.xml /usr/local/tomcat/conf

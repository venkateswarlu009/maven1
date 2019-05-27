FROM tomcat:8
# Take the war and copy to webapps of tomcatserver
COPY myweb.war /usr/local/tomcat/webapps/
COPY manager.xml /usr/local/tomcat/conf/Catalina/localhost
COPY tomcat-users.xml /usr/local/tomcat/conf         

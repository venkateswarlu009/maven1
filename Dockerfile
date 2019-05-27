FROM tomcat:8
# Take the war and copy to webapps of tomcatserver
COPY myweb1.war /usr/local/tomcat/webapps/

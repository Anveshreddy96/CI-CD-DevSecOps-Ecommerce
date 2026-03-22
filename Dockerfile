FROM tomcat:9
COPY target/myweb-8.7.3.war /usr/local/tomcat/webapps/

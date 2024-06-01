FROM tomcat:latest

# remove orginal default web content of Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy my web app into Tomcat's default webapp dir
COPY ./IgsUI /usr/local/tomcat/webapps/ROOT

# Expose on 8080
EXPOSE 8080

# auto start Tomcat
CMD ["catalina.sh", "run"]
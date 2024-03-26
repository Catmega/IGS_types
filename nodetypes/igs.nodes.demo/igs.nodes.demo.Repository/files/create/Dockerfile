
FROM openjdk:8-jdk

# set working dir as /app
WORKDIR /app

# copy my igs repository application jar file to the working dir
COPY Artifacts/igsRepository.jar app.jar

EXPOSE 8080

# run
ENTRYPOINT ["java", "-jar", "app.jar"]

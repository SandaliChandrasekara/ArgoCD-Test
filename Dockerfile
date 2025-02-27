# Stage 1: Build Stage
FROM openjdk:17-jdk-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven wrapper files and project files into the container
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

# Build the application using Maven
RUN ./mvnw clean install -DskipTests

# Stage 2: Runtime Stage
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the build stage into the runtime image
COPY --from=build /app/target/spring-petclinic-3.3.0-SNAPSHOT.jar app.jar

# Expose the port that the application will run on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
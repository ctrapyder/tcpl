
# Use an official Maven image to build the application
FROM maven:3.8.4-jdk-11-slim AS builder

# Set working directory
WORKDIR /app

# Copy the pom.xml and the source code
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Use an openjdk base image to run the application
FROM openjdk:11-jre-slim

# Set working directory for the final image
WORKDIR /app

# Copy the jar from the builder image
COPY --from=builder /app/target/docker-demo-1.0-SNAPSHOT.jar app.jar

# Expose the application port (if needed)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

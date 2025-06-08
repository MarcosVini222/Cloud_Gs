# Stage 1: Build the application
FROM gradle:jdk21 AS builder
WORKDIR /app
COPY . /app
RUN gradle build -x test

# Stage 2: Create the runtime image
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
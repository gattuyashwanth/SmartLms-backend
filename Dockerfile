# Multi-stage Dockerfile for Spring Boot 3 + Java 21 (SmartLMS Backend)

# ── Stage 1: Build JAR ──
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copy pom.xml and cache Maven dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B || true

# Copy source code and build executable jar
COPY src ./src
RUN mvn clean package -DskipTests -B

# ── Stage 2: Minimal Runtime ──
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Create upload directories for attachments and submissions
RUN mkdir -p uploads/chat uploads/submissions

# Copy built JAR from builder stage
COPY --from=build /app/target/*.jar app.jar

# Render assigns dynamic port via $PORT
ENV PORT=8008
EXPOSE 8008

# Start the Spring Boot application
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar"]

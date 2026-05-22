# ── Build Stage ──────────────────────────────────────────────────────────────
FROM maven:3.9-eclipse-temurin-11 AS builder

WORKDIR /build

# Cache dependency layer separately from source
COPY pom.xml .
RUN mvn dependency:go-offline -B -q

COPY src/ ./src/
RUN mvn clean package -DskipTests -B -q

# ── Runtime Stage ─────────────────────────────────────────────────────────────
FROM tomcat:9.0-jdk11-openjdk-slim

LABEL maintainer="IoTBay Team <iotbay@example.com>"

# Remove default Tomcat webapps (security hardening)
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/host-manager \
           /usr/local/tomcat/webapps/manager

# Deploy WAR as ROOT (serves at /)
COPY --from=builder /build/target/iot-bay.war \
     /usr/local/tomcat/webapps/ROOT.war

# SQLite data directory — mount a named volume here for persistence
RUN mkdir -p /opt/iotbay/data
VOLUME ["/opt/iotbay/data"]

# Environment variables (override at runtime)
ENV IOTBAY_DB_PATH=/opt/iotbay/data/iotbay.db
ENV APP_ENV=production
ENV IOTBAY_JWT_SECRET=""

EXPOSE 8080

CMD ["catalina.sh", "run"]

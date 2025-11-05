# -------- Builder Stage --------
FROM maven:3.9.9-eclipse-temurin-17-alpine AS builder

WORKDIR /app

# Copiar solo pom.xml y .mvn primero para cachear dependencias
COPY pom.xml . 
COPY .mvn .mvn
RUN mvn dependency:go-offline

# Copiar código fuente y compilar
COPY src src
RUN mvn clean package -DskipTests

# Crear runtime mínimo con jlink
RUN $JAVA_HOME/bin/jlink \
    --add-modules java.base,java.logging,java.sql,java.naming,java.management,java.instrument,java.security.jgss,java.desktop,java.rmi,jdk.unsupported,java.security.sasl \
    --strip-debug \
    --no-man-pages \
    --no-header-files \
    --compress=2 \
    --output /opt/jre-minimal

# -------- Runtime Stage --------
FROM alpine:3.20

WORKDIR /app

# Copiar runtime mínimo generado
COPY --from=builder /opt/jre-minimal /opt/jre-minimal
ENV PATH="/opt/jre-minimal/bin:$PATH"

# Copiar el JAR compilado
COPY --from=builder /app/target/api-spring-boot-mongo.jar app.jar


# Comando para ejecutar la app
CMD ["java", "-jar", "app.jar"]

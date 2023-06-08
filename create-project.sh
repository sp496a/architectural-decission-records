#!/usr/bin/env bash

mkdir microservices
cd microservices

spring init \
--boot-version=3.1.0 \
--build=gradle \
--type=gradle-project \
--java-version=11 \
--packaging=jar \
--name=product-service \
--package-name=com.sample.microservices.core.product \
--groupId=com.sample.microservices.core.product \
--dependencies=actuator,webflux \
--version=1.0.0-SNAPSHOT \
product-service

spring init \
--boot-version=3.1.0 \
--build=gradle \
--java-version=11 \
--type=gradle-project \
--packaging=jar \
--name=review-service \
--package-name=com.sample.microservices.core.review \
--groupId=com.sample.microservices.core.review \
--dependencies=actuator,webflux \
--version=1.0.0-SNAPSHOT \
review-service

spring init \
--boot-version=3.1.0 \
--build=gradle \
--type=gradle-project \
--java-version=11 \
--packaging=jar \
--name=recommendation-service \
--package-name=com.sample.microservices.core.recommendation \
--groupId=com.sample.microservices.core.recommendation \
--dependencies=actuator,webflux \
--version=1.0.0-SNAPSHOT \
recommendation-service

spring init \
--boot-version=3.1.0 \
--build=gradle \
--type=gradle-project \
--java-version=11 \
--packaging=jar \
--name=product-composite-service \
--package-name=com.sample.microservices.composite.product \
--groupId=com.sample.microservices.composite.product \
--dependencies=actuator,webflux \
--version=1.0.0-SNAPSHOT \
product-composite-service

cd ..

# Create a settings.gradle 

cat <<EOF > settings.gradle
include ':microservices:product-service'
include ':microservices:review-service'
include ':microservices:recommendation-service'
include ':microservices:product-composite-service'
EOF

# Now copy the gradle executables generated from one of the service
cp -r microservices/product-service/gradle .
cp microservices/product-service/gradlew .
cp microservices/product-service/gradlew.bat .
cp microservices/product-service/.gitignore .

# No longer required the gradle executable

find microservices -depth -name "gradle" -exec rm -rfv "{}" \; 
find microservices -depth -name "gradlew*" -exec rm -fv "{}" \; 

# Now we can build the project 
./gradlew build


# Create API directory which is a Library

mkdir api
cd api

cat <<EOF > build.gradle
plugins {
    id 'io.spring.dependency-management' version '1.0.11.RELEASE'
    id 'java'
}

group = 'com.sample.microservices.api'
version = '1.0.0-SNAPSHOT'
sourceCompatibility = 17

repositories {
    mavenCentral()
}

ext {
    springBootVersion = '3.1.0'
}

dependencies {
    implementation platform("org.springframework.boot:spring-boot-dependencies:${springBootVersion}")

    implementation 'org.springframework.boot:spring-boot-starter-webflux'
    implementation 'org.springdoc:springdoc-openapi-common:1.5.9'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}

test {
    useJUnitPlatform()
}
EOF

cd ..

# Create API directory which is a Library

mkdir util
cd util

cat <<EOF > build.gradle
plugins {
    id 'io.spring.dependency-management' version '1.0.11.RELEASE'
    id 'java'
}

group = 'com.sample.microservices.api'
version = '1.0.0-SNAPSHOT'
sourceCompatibility = 17

repositories {
    mavenCentral()
}

ext {
    springBootVersion = '3.1.0'
}

dependencies {
    implementation platform("org.springframework.boot:spring-boot-dependencies:${springBootVersion}")

    implementation 'org.springframework.boot:spring-boot-starter-webflux'
    implementation 'org.springdoc:springdoc-openapi-common:1.5.9'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}

test {
    useJUnitPlatform()
}
EOF

cd ..

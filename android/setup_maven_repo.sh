#!/bin/bash

# Remove existing Maven repository structure if it exists
rm -rf libs/com

# Create Maven repository structure for InsideMobileAndroid
mkdir -p libs/com/example/powerfront/InsideMobileAndroid/1.3.3
cp libs/InsideMobileAndroid-1.3.3.aar libs/com/example/powerfront/InsideMobileAndroid/1.3.3/InsideMobileAndroid-1.3.3.aar

# Create POM file for InsideMobileAndroid
cat > libs/com/example/powerfront/InsideMobileAndroid/1.3.3/InsideMobileAndroid-1.3.3.pom << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd" xmlns="http://maven.apache.org/POM/4.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.example.powerfront</groupId>
  <artifactId>InsideMobileAndroid</artifactId>
  <version>1.3.3</version>
  <packaging>aar</packaging>
  <dependencies>
    <dependency>
      <groupId>androidx.appcompat</groupId>
      <artifactId>appcompat</artifactId>
      <version>1.6.1</version>
      <scope>compile</scope>
    </dependency>
    <dependency>
      <groupId>androidx.core</groupId>
      <artifactId>core-ktx</artifactId>
      <version>1.12.0</version>
      <scope>compile</scope>
    </dependency>
    <dependency>
      <groupId>org.jetbrains.kotlin</groupId>
      <artifactId>kotlin-stdlib</artifactId>
      <version>1.8.22</version>
      <scope>compile</scope>
    </dependency>
  </dependencies>
</project>
EOF
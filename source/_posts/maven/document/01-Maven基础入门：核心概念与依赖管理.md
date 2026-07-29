---
title: Maven基础入门：核心概念与依赖管理
date: 2024-11-08T00:00:00+08:00
tags:
    - maven
    - 教程
    - 构建工具
    - 依赖管理
categories: maven
cover: /images/cover_maven.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: "Maven 基础入门教程，涵盖核心概念（POM、坐标）、依赖管理（Scope、传递、冲突解决）、仓库管理（本地/远程仓库）、常用命令与参数。"
---

## 一、Maven 简介

### 1.1 什么是 Maven

Maven 是 Apache 软件基金会组织维护的一款**自动化构建工具**，专注于 Java 项目的项目管理和构建自动化。

**Maven 的核心功能：**
- **项目构建**：自动化编译、测试、打包、部署
- **依赖管理**：自动下载和管理项目依赖
- **项目信息管理**：统一管理项目配置、版本信息
- **多模块管理**：支持大型项目的模块化开发

### 1.2 Maven vs 传统构建方式

| 对比项 | 传统方式 | Maven 方式 |
|--------|---------|-----------|
| 依赖管理 | 手动下载 jar 包放入 lib | 自动从仓库下载 |
| 构建流程 | 手动执行编译、打包命令 | 一键执行 `mvn package` |
| 项目结构 | 不统一 | 标准化目录结构 |
| 版本管理 | 手动维护 | 统一在 pom.xml 管理 |
| 团队协作 | 配置差异大 | 统一构建配置 |

### 1.3 Maven 安装与配置

```bash
# 1. 下载 Maven
# https://maven.apache.org/download.cgi

# 2. 解压到指定目录
# Windows: D:\apache-maven-3.9.6
# Linux/Mac: /usr/local/apache-maven-3.9.6

# 3. 配置环境变量
# MAVEN_HOME = D:\apache-maven-3.9.6
# Path 添加 %MAVEN_HOME%\bin

# 4. 验证安装
mvn -v
# Apache Maven 3.9.6
# Maven home: D:\apache-maven-3.9.6
# Java version: 17.0.1
```

---

## 二、核心概念

### 2.1 POM（Project Object Model）

POM 是 Maven 项目的基本工作单元，是一个 XML 文件（`pom.xml`），包含了项目的基本信息和配置。

**pom.xml 基本结构：**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    
    <!-- POM 版本 -->
    <modelVersion>4.0.0</modelVersion>
    
    <!-- 项目坐标（GAV） -->
    <groupId>com.example</groupId>
    <artifactId>my-project</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>
    
    <!-- 项目基本信息 -->
    <name>My Project</name>
    <description>项目描述</description>
    <url>https://www.example.com</url>
    
    <!-- 属性配置 -->
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
    
    <!-- 依赖管理 -->
    <dependencies>
        <!-- 依赖列表 -->
    </dependencies>
    
    <!-- 构建配置 -->
    <build>
        <plugins>
            <!-- 插件列表 -->
        </plugins>
    </build>
</project>
```

### 2.2 Maven 坐标（GAV）

Maven 坐标唯一标识一个项目或依赖，由三部分组成：

| 坐标元素 | 说明 | 示例 |
|---------|------|------|
| **groupId** | 组织/公司标识（反向域名） | `com.example`、`org.springframework` |
| **artifactId** | 项目名称 | `my-project`、`spring-core` |
| **version** | 版本号 | `1.0.0`、`5.3.20` |

```xml
<!-- 完整坐标示例 -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
    <version>3.2.0</version>
</dependency>
```

**版本号命名规范：**

| 版本类型 | 说明 | 示例 |
|---------|------|------|
| **正式版（Release）** | 稳定版本，可用于生产环境 | `1.0.0`、`2.3.5` |
| **快照版（SNAPSHOT）** | 开发版本，不稳定，频繁更新 | `1.0.0-SNAPSHOT` |
| **里程碑版** | 测试版本 | `1.0.0-alpha`、`1.0.0-beta`、`1.0.0-RC1` |

### 2.3 标准目录结构

```
my-project/
├── pom.xml                    # Maven 配置文件
├── src/
│   ├── main/                  # 主代码目录
│   │   ├── java/              # Java 源代码
│   │   │   └── com/example/   # 包结构
│   │   └── resources/         # 资源文件
│   │       ├── application.yml
│   │       └── static/
│   └── test/                  # 测试代码目录
│       ├── java/              # 测试源代码
│       └── resources/         # 测试资源文件
└── target/                    # 构建输出目录
    ├── classes/               # 编译后的 class 文件
    └── my-project-1.0.0.jar   # 打包后的 jar 文件
```

---

## 三、依赖管理

### 3.1 依赖配置

在 `pom.xml` 中使用 `<dependencies>` 声明项目依赖：

```xml
<dependencies>
    <!-- 单个依赖 -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
        <version>3.2.0</version>
    </dependency>
    
    <!-- 带作用域的依赖 -->
    <dependency>
        <groupId>org.junit.jupiter</groupId>
        <artifactId>junit-jupiter</artifactId>
        <version>5.10.0</version>
        <scope>test</scope>
    </dependency>
    
    <!-- 可选依赖 -->
    <dependency>
        <groupId>com.example</groupId>
        <artifactId>optional-lib</artifactId>
        <version>1.0.0</version>
        <optional>true</optional>
    </dependency>
    
    <!-- 排除依赖 -->
    <dependency>
        <groupId>com.example</groupId>
        <artifactId>some-lib</artifactId>
        <version>1.0.0</version>
        <exclusions>
            <exclusion>
                <groupId>org.slf4j</groupId>
                <artifactId>slf4j-log4j12</artifactId>
            </exclusion>
        </exclusions>
    </dependency>
</dependencies>
```

### 3.2 依赖作用域（Scope）

| Scope | 说明 | 编译时 | 测试时 | 运行时 | 打包时 | 示例 |
|-------|------|--------|--------|--------|--------|------|
| **compile** | 默认作用域 | ✅ | ✅ | ✅ | ✅ | `spring-core` |
| **test** | 仅测试使用 | ❌ | ✅ | ❌ | ❌ | `junit` |
| **provided** | 运行时由容器提供 | ✅ | ✅ | ❌ | ❌ | `servlet-api` |
| **runtime** | 运行时依赖 | ❌ | ✅ | ✅ | ✅ | `mysql-connector-java` |
| **system** | 本地 jar 文件 | ✅ | ✅ | ❌ | ❌ | 本地工具 jar |
| **import** | 导入 BOM 依赖管理 | - | - | - | - | Spring Boot BOM |

```xml
<!-- compile（默认） -->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-core</artifactId>
    <version>6.1.0</version>
    <scope>compile</scope>
</dependency>

<!-- test：仅测试时使用 -->
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter</artifactId>
    <version>5.10.0</version>
    <scope>test</scope>
</dependency>

<!-- provided：运行时由容器提供 -->
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>javax.servlet-api</artifactId>
    <version>4.0.1</version>
    <scope>provided</scope>
</dependency>

<!-- runtime：运行时需要 -->
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.33</version>
    <scope>runtime</scope>
</dependency>

<!-- system：本地 jar -->
<dependency>
    <groupId>com.example</groupId>
    <artifactId>local-lib</artifactId>
    <version>1.0.0</version>
    <scope>system</scope>
    <systemPath>${project.basedir}/lib/local-lib.jar</systemPath>
</dependency>
```

### 3.3 依赖传递

依赖具有传递性：A 依赖 B，B 依赖 C → A 自动依赖 C。

```
项目 A
  └── 依赖 B (spring-boot-starter-web)
        ├── 依赖 C (spring-web)
        ├── 依赖 D (spring-context)
        └── 依赖 E (tomcat-embed)
        
A 自动获得 C、D、E 的依赖
```

**依赖传递规则：**

| 直接依赖 | 传递依赖 | 结果 |
|---------|---------|------|
| compile | compile | compile |
| compile | test | 不传递 |
| compile | provided | 不传递 |
| test | compile | 不传递 |
| test | test | 不传递 |
| provided | compile | 不传递 |

### 3.4 依赖冲突解决

**冲突场景：**
```
项目 A
  ├── 依赖 B (version 1.0)
  │     └── 依赖 D (version 1.0)
  └── 依赖 C (version 2.0)
        └── 依赖 D (version 2.0)
        
问题：D 的版本冲突（1.0 vs 2.0）
```

**解决原则：**

1. **最短路径优先（Nearest Definition）**
   - A → B → D(1.0)：路径长度 2
   - A → C → D(2.0)：路径长度 2
   - 路径相同，继续按声明顺序

2. **最先声明优先（First Declaration）**
   - 路径相同时，先声明的依赖优先
   - B 在 C 前面声明，则 D(1.0) 优先

**显式解决冲突：**

```xml
<!-- 方式1：显式声明需要的版本 -->
<dependency>
    <groupId>com.example</groupId>
    <artifactId>common-lib</artifactId>
    <version>2.0.0</version>  <!-- 显式指定版本 -->
</dependency>

<!-- 方式2：排除不需要的版本 -->
<dependency>
    <groupId>com.example</groupId>
    <artifactId>module-a</artifactId>
    <version>1.0.0</version>
    <exclusions>
        <exclusion>
            <groupId>com.example</groupId>
            <artifactId>common-lib</artifactId>
        </exclusion>
    </exclusions>
</dependency>
```

**查看依赖树：**

```bash
# 查看完整依赖树
mvn dependency:tree

# 查看特定依赖
mvn dependency:tree -Dincludes=groupId:artifactId

# 查看冲突依赖
mvn dependency:tree -Dverbose
```

### 3.5 统一版本管理

#### 使用 `<dependencyManagement>`

```xml
<!-- 父 POM -->
<dependencyManagement>
    <dependencies>
        <!-- 统一定义版本 -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-dependencies</artifactId>
            <version>3.2.0</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
        
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>8.0.33</version>
        </dependency>
    </dependencies>
</dependencyManagement>

<!-- 子模块（无需指定版本） -->
<dependencies>
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <!-- 版本由父 POM 管理 -->
    </dependency>
</dependencies>
```

#### 使用 BOM（Bill of Materials）

```xml
<!-- 导入 Spring Boot BOM -->
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-dependencies</artifactId>
            <version>3.2.0</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>

<!-- 使用 BOM 管理的依赖（无需指定版本） -->
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
        <!-- 版本由 BOM 管理 -->
    </dependency>
    
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <!-- 版本由 BOM 管理 -->
    </dependency>
</dependencies>
```

---

## 四、仓库管理

### 4.1 仓库类型

```
┌─────────────────────────────────────────────┐
│              Maven 仓库体系                    │
├─────────────────────────────────────────────┤
│                                             │
│    ┌─────────────┐                          │
│    │  本地仓库    │  ~/.m2/repository        │
│    │ (Local)     │                          │
│    └──────┬──────┘                          │
│           │ 找不到                           │
│           ↓                                  │
│    ┌─────────────┐      ┌─────────────┐     │
│    │  私有仓库    │─────→│  中央仓库    │     │
│    │ (Nexus)     │      │ (Central)   │     │
│    └─────────────┘      └─────────────┘     │
│                                             │
└─────────────────────────────────────────────┘
```

| 仓库类型 | 说明 | 默认位置 |
|---------|------|---------|
| **本地仓库** | 本地缓存的依赖 | `~/.m2/repository`（Windows：`C:\Users\用户名\.m2\repository`） |
| **中央仓库** | Maven 官方仓库 | https://repo.maven.apache.org/maven2/ |
| **私有仓库** | 企业内部仓库 | Nexus、Artifactory |
| **镜像仓库** | 中央仓库的镜像 | 阿里云镜像、华为云镜像 |

### 4.2 配置镜像仓库

修改 `~/.m2/settings.xml` 或 `MAVEN_HOME/conf/settings.xml`：

```xml
<settings>
    <mirrors>
        <!-- 阿里云镜像 -->
        <mirror>
            <id>aliyun</id>
            <name>Aliyun Maven Mirror</name>
            <url>https://maven.aliyun.com/repository/public</url>
            <mirrorOf>central</mirrorOf>
        </mirror>
        
        <!-- 华为云镜像 -->
        <mirror>
            <id>huawei</id>
            <name>Huawei Maven Mirror</name>
            <url>https://repo.huaweicloud.com/repository/maven/</url>
            <mirrorOf>central</mirrorOf>
        </mirror>
    </mirrors>
</settings>
```

### 4.3 配置私有仓库

```xml
<settings>
    <servers>
        <server>
            <id>my-nexus</id>
            <username>admin</username>
            <password>admin123</password>
        </server>
    </servers>
    
    <mirrors>
        <mirror>
            <id>my-nexus</id>
            <name>My Nexus Repository</name>
            <url>http://192.168.1.100:8081/repository/maven-public/</url>
            <mirrorOf>*</mirrorOf>
        </mirror>
    </mirrors>
    
    <profiles>
        <profile>
            <id>nexus</id>
            <repositories>
                <repository>
                    <id>my-nexus</id>
                    <url>http://192.168.1.100:8081/repository/maven-public/</url>
                    <releases>
                        <enabled>true</enabled>
                    </releases>
                    <snapshots>
                        <enabled>true</enabled>
                    </snapshots>
                </repository>
            </repositories>
        </profile>
    </profiles>
    
    <activeProfiles>
        <activeProfile>nexus</activeProfile>
    </activeProfiles>
</settings>
```

### 4.4 依赖查找顺序

```
1. 本地仓库查找
   └─ 找到：直接使用
   └─ 未找到：继续查找
   
2. 远程仓库查找（按 settings.xml 配置顺序）
   └─ 镜像仓库
   └─ 私有仓库
   └─ 中央仓库
   
3. 下载到本地仓库
   └─ 存储路径：groupId/artifactId/version/
```

### 4.5 依赖更新策略

```xml
<repository>
    <id>my-repo</id>
    <url>http://example.com/maven2/</url>
    <releases>
        <enabled>true</enabled>
        <updatePolicy>daily</updatePolicy>  <!-- 更新策略 -->
    </releases>
    <snapshots>
        <enabled>true</enabled>
        <updatePolicy>always</updatePolicy>
    </snapshots>
</repository>
```

| updatePolicy | 说明 |
|-------------|------|
| `always` | 每次构建都检查更新 |
| `daily` | 每天检查一次更新（默认） |
| `interval:X` | 每隔 X 分钟检查更新 |
| `never` | 从不检查更新 |

---

## 五、常用命令与参数

### 5.1 基础命令

| 命令 | 作用 | 说明 |
|------|------|------|
| `mvn clean` | 清理 target 目录 | 删除构建输出 |
| `mvn compile` | 编译源代码 | 生成 class 文件 |
| `mvn test` | 运行单元测试 | 执行 src/test/java 下的测试 |
| `mvn package` | 打包（JAR/WAR） | 生成 jar/war 文件到 target |
| `mvn install` | 安装到本地仓库 | 其他项目可引用 |
| `mvn deploy` | 部署到远程仓库 | 发布到私有仓库 |
| `mvn site` | 生成项目站点文档 | 生成 HTML 文档 |

```bash
# 清理并编译
mvn clean compile

# 清理并打包（跳过测试）
mvn clean package -DskipTests

# 清理并安装
mvn clean install

# 完整构建流程
mvn clean deploy
```

### 5.2 常用参数

| 参数 | 说明 | 示例 |
|------|------|------|
| `-DskipTests` | 跳过测试 | `mvn package -DskipTests` |
| `-Dmaven.test.skip=true` | 跳过测试编译和执行 | `mvn package -Dmaven.test.skip=true` |
| `-P profileName` | 激活指定 Profile | `mvn package -P prod` |
| `-e` | 显示详细错误信息 | `mvn clean install -e` |
| `-X` | 显示调试日志 | `mvn clean install -X` |
| `-o` | 离线模式（仅使用本地仓库） | `mvn clean install -o` |
| `-U` | 强制更新 SNAPSHOT 依赖 | `mvn clean install -U` |
| `-Dprop=value` | 设置系统属性 | `mvn package -Denv=prod` |

### 5.3 常用组合命令

```bash
# 清理、编译、跳过测试、打包
mvn clean package -DskipTests

# 清理、编译、打包、安装到本地仓库
mvn clean install -DskipTests

# 激活多个 Profile 打包
mvn clean package -P dev,prod

# 强制更新依赖并打包
mvn clean package -U

# 离线模式打包（不访问远程仓库）
mvn clean package -o

# 查看依赖树
mvn dependency:tree

# 查看有效 POM 配置
mvn help:effective-pom

# 查看所有可执行的 goal
mvn help:describe -Dcmd=compile
```

---

> 💡 **小结**：本章介绍了 Maven 的基础概念，包括 POM 项目对象模型、坐标系统（GAV）、标准目录结构。重点讲解了依赖管理的核心内容：依赖配置、作用域、传递性、冲突解决和统一版本管理。最后介绍了仓库体系（本地/远程/镜像）和常用命令参数。掌握这些基础知识，可以应对日常 Maven 项目开发需求。
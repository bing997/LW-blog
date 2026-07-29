---
title: Maven进阶实战：生命周期、插件与多模块管理
date: 2024-11-09T00:00:00+08:00
tags:
    - maven
    - 教程
    - 构建工具
    - 多模块
    - Profile
categories: maven
cover: /images/cover_maven.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: "Maven 进阶实战教程，涵盖生命周期与插件、多模块项目管理、构建配置（Profile、资源过滤）、高级技巧与最佳实践。"
---

## 一、生命周期与插件

### 1.1 三套生命周期

Maven 有三套相互独立的生命周期：**clean**、**default**、**site**。

```
┌─────────────────────────────────────────────┐
│           Maven 三套生命周期                   │
├─────────────────────────────────────────────┤
│                                             │
│  Clean Lifecycle（清理生命周期）              │
│  pre-clean → clean → post-clean             │
│                                             │
│  Default Lifecycle（构建生命周期）            │
│  validate → compile → test → package        │
│  → verify → install → deploy                │
│                                             │
│  Site Lifecycle（站点生命周期）               │
│  pre-site → site → post-site → site-deploy  │
│                                             │
└─────────────────────────────────────────────┘
```

### 1.2 Clean 生命周期

| 阶段 | 说明 |
|------|------|
| `pre-clean` | 清理前的准备工作 |
| `clean` | 清理 target 目录 |
| `post-clean` | 清理后的收尾工作 |

```bash
# 执行 clean 阶段
mvn clean
```

### 1.3 Default 生命周期（核心）

| 阶段 | 说明 |
|------|------|
| `validate` | 验证项目结构是否正确 |
| `initialize` | 初始化构建状态 |
| `generate-sources` | 生成源代码 |
| `process-resources` | 处理资源文件（复制到 target） |
| `compile` | 编译源代码 |
| `process-classes` | 处理编译后的文件 |
| `generate-test-sources` | 生成测试源代码 |
| `process-test-resources` | 处理测试资源文件 |
| `test-compile` | 编译测试代码 |
| `test` | 运行单元测试 |
| `prepare-package` | 打包前的准备工作 |
| `package` | 打包（JAR/WAR） |
| `verify` | 验证打包结果 |
| `install` | 安装到本地仓库 |
| `deploy` | 部署到远程仓库 |

```bash
# 执行特定阶段
mvn compile      # 编译
mvn test         # 测试
mvn package      # 打包
mvn install      # 安装
mvn deploy       # 部署

# 组合执行
mvn clean package  # 清理 + 打包
```

### 1.4 Site 生命周期

| 阶段 | 说明 |
|------|------|
| `pre-site` | 生成站点前的准备工作 |
| `site` | 生成项目站点文档 |
| `post-site` | 生成站点后的收尾工作 |
| `site-deploy` | 发布站点到服务器 |

```bash
# 生成站点文档
mvn site
```

### 1.5 插件（Plugins）

Maven 的核心功能通过插件实现，插件绑定到生命周期的各个阶段。

**常用插件：**

| 插件 | 说明 | 绑定阶段 |
|------|------|---------|
| `maven-compiler-plugin` | 编译 Java 源代码 | compile |
| `maven-surefire-plugin` | 执行单元测试 | test |
| `maven-jar-plugin` | 打包 JAR | package |
| `maven-war-plugin` | 打包 WAR | package |
| `maven-install-plugin` | 安装到本地仓库 | install |
| `maven-deploy-plugin` | 部署到远程仓库 | deploy |
| `maven-clean-plugin` | 清理 target | clean |
| `maven-resources-plugin` | 处理资源文件 | process-resources |
| `maven-shade-plugin` | 打包可执行 JAR（包含依赖） | package |
| `maven-assembly-plugin` | 自定义打包 | package |

**插件配置示例：**

```xml
<build>
    <plugins>
        <!-- 编译插件：指定 JDK 版本 -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.11.0</version>
            <configuration>
                <source>17</source>
                <target>17</target>
                <encoding>UTF-8</encoding>
            </configuration>
        </plugin>
        
        <!-- 测试插件：跳过测试失败 -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-surefire-plugin</artifactId>
            <version>3.1.2</version>
            <configuration>
                <testFailureIgnore>true</testFailureIgnore>
            </configuration>
        </plugin>
        
        <!-- 打包插件：指定主类 -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-jar-plugin</artifactId>
            <version>3.3.0</version>
            <configuration>
                <archive>
                    <manifest>
                        <mainClass>com.example.Application</mainClass>
                        <addClasspath>true</addClasspath>
                    </manifest>
                </archive>
            </configuration>
        </plugin>
        
        <!-- Shade 插件：打包可执行 JAR -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-shade-plugin</artifactId>
            <version>3.5.0</version>
            <executions>
                <execution>
                    <phase>package</phase>
                    <goals>
                        <goal>shade</goal>
                    </goals>
                    <configuration>
                        <transformers>
                            <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                <mainClass>com.example.Application</mainClass>
                            </transformer>
                        </transformers>
                    </configuration>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```

---

## 二、多模块项目

### 2.1 多模块项目结构

```
my-project/
├── pom.xml                 # 父 POM
├── common/                 # 公共模块
│   └── pom.xml
├── api/                    # API 模块
│   └── pom.xml
├── service/                # 服务模块
│   └── pom.xml
└── web/                    # Web 模块
    └── pom.xml
```

### 2.2 聚合与继承

**聚合（Aggregation）**：将多个模块聚合到一起构建。

**继承（Inheritance）**：子模块继承父模块的配置。

```
聚合：父 POM 通过 <modules> 聚合子模块
继承：子 POM 通过 <parent> 继承父 POM

父 POM
├── modules（聚合）
│     ├── common
│     ├── api
│     ├── service
│     └── web
└── 配置（继承）
      ├── dependencyManagement
      ├── pluginManagement
      └── properties
```

### 2.3 父 POM 配置

```xml
<!-- 父 POM：my-project/pom.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    
    <modelVersion>4.0.0</modelVersion>
    
    <groupId>com.example</groupId>
    <artifactId>my-project</artifactId>
    <version>1.0.0</version>
    <packaging>pom</packaging>  <!-- 父 POM 的 packaging 必须是 pom -->
    
    <name>My Project</name>
    <description>多模块项目父 POM</description>
    
    <!-- 聚合子模块 -->
    <modules>
        <module>common</module>
        <module>api</module>
        <module>service</module>
        <module>web</module>
    </modules>
    
    <!-- 统一属性 -->
    <properties>
        <java.version>17</java.version>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <spring.boot.version>3.2.0</spring.boot.version>
    </properties>
    
    <!-- 统一依赖版本管理 -->
    <dependencyManagement>
        <dependencies>
            <!-- Spring Boot BOM -->
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-dependencies</artifactId>
                <version>${spring.boot.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            
            <!-- 内部模块依赖 -->
            <dependency>
                <groupId>com.example</groupId>
                <artifactId>common</artifactId>
                <version>${project.version}</version>
            </dependency>
            
            <dependency>
                <groupId>com.example</groupId>
                <artifactId>api</artifactId>
                <version>${project.version}</version>
            </dependency>
        </dependencies>
    </dependencyManagement>
    
    <!-- 统一插件管理 -->
    <build>
        <pluginManagement>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <version>3.11.0</version>
                    <configuration>
                        <source>${java.version}</source>
                        <target>${java.version}</target>
                    </configuration>
                </plugin>
            </plugins>
        </pluginManagement>
    </build>
</project>
```

### 2.4 子模块 POM 配置

```xml
<!-- 子模块：service/pom.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    
    <modelVersion>4.0.0</modelVersion>
    
    <!-- 继承父 POM -->
    <parent>
        <groupId>com.example</groupId>
        <artifactId>my-project</artifactId>
        <version>1.0.0</version>
    </parent>
    
    <artifactId>service</artifactId>
    <packaging>jar</packaging>
    
    <name>Service Module</name>
    <description>服务模块</description>
    
    <!-- 依赖（版本由父 POM 管理） -->
    <dependencies>
        <!-- 内部模块依赖 -->
        <dependency>
            <groupId>com.example</groupId>
            <artifactId>common</artifactId>
        </dependency>
        
        <!-- 第三方依赖（版本由父 POM 的 BOM 管理） -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <scope>provided</scope>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <!-- 使用父 POM 管理的插件 -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

### 2.5 模块间依赖

```
依赖关系：

web（Web 层）
 └── service（服务层）
       └── api（API 层）
             └── common（公共层）

web 依赖 service
service 依赖 api
api 依赖 common
```

```xml
<!-- web/pom.xml -->
<dependencies>
    <dependency>
        <groupId>com.example</groupId>
        <artifactId>service</artifactId>
    </dependency>
</dependencies>

<!-- service/pom.xml -->
<dependencies>
    <dependency>
        <groupId>com.example</groupId>
        <artifactId>api</artifactId>
    </dependency>
</dependencies>

<!-- api/pom.xml -->
<dependencies>
    <dependency>
        <groupId>com.example</groupId>
        <artifactId>common</artifactId>
    </dependency>
</dependencies>
```

### 2.6 多模块构建命令

```bash
# 在父项目根目录执行，构建所有模块
mvn clean install

# 只构建指定模块
mvn clean install -pl api,service

# 构建指定模块及其依赖模块
mvn clean install -pl web -am

# 构建指定模块及其依赖它的模块
mvn clean install -pl common -amd

# 参数说明：
# -pl, --projects       构建指定模块（逗号分隔）
# -am, --also-make      同时构建依赖模块
# -amd, --also-make-dependents  同时构建依赖它的模块
```

---

## 三、构建配置

### 3.1 资源配置

**资源文件过滤**：在资源文件中使用占位符，构建时替换为实际值。

```xml
<build>
    <!-- 资源文件配置 -->
    <resources>
        <resource>
            <directory>src/main/resources</directory>
            <filtering>true</filtering>  <!-- 启用过滤 -->
            <includes>
                <include>**/*.properties</include>
                <include>**/*.yml</include>
                <include>**/*.xml</include>
            </includes>
        </resource>
    </resources>
    
    <!-- 测试资源文件配置 -->
    <testResources>
        <testResource>
            <directory>src/test/resources</directory>
            <filtering>true</filtering>
        </testResource>
    </testResources>
</build>
```

**资源文件中使用占位符：**

```properties
# application.properties
app.name=${project.name}
app.version=${project.version}
app.encoding=${project.build.sourceEncoding}
build.time=${maven.build.timestamp}
```

**构建后自动替换：**

```properties
# target/classes/application.properties
app.name=My Project
app.version=1.0.0
app.encoding=UTF-8
build.time=2024-11-09T10:30:00Z
```

### 3.2 Profile 多环境配置

使用 `<profiles>` 定义不同环境的配置。

```xml
<profiles>
    <!-- 开发环境 -->
    <profile>
        <id>dev</id>
        <properties>
            <env>dev</env>
            <db.url>jdbc:mysql://localhost:3306/dev_db</db.url>
            <db.username>dev_user</db.username>
            <db.password>dev_pass</db.password>
        </properties>
        <activation>
            <activeByDefault>true</activeByDefault>  <!-- 默认激活 -->
        </activation>
    </profile>
    
    <!-- 测试环境 -->
    <profile>
        <id>test</id>
        <properties>
            <env>test</env>
            <db.url>jdbc:mysql://test.example.com:3306/test_db</db.url>
            <db.username>test_user</db.username>
            <db.password>test_pass</db.password>
        </properties>
    </profile>
    
    <!-- 生产环境 -->
    <profile>
        <id>prod</id>
        <properties>
            <env>prod</env>
            <db.url>jdbc:mysql://prod.example.com:3306/prod_db</db.url>
            <db.username>prod_user</db.username>
            <db.password>prod_pass</db.password>
        </properties>
    </profile>
</profiles>
```

**application.properties 使用环境变量：**

```properties
# 使用 Profile 中定义的属性
spring.profiles.active=${env}
spring.datasource.url=${db.url}
spring.datasource.username=${db.username}
spring.datasource.password=${db.password}
```

**激活 Profile 的方式：**

```bash
# 方式1：命令行激活
mvn clean package -P test

# 方式2：激活多个 Profile
mvn clean package -P dev,prod

# 方式3：settings.xml 中激活
# <activeProfiles>
#     <activeProfile>dev</activeProfile>
# </activeProfiles>

# 方式4：自动激活（通过 <activation> 配置）
<activation>
    <activeByDefault>true</activeByDefault>
</activation>
```

### 3.3 Profile 配置不同环境的资源文件

```
src/main/resources/
├── application.yml          # 公共配置
├── application-dev.yml      # 开发环境配置
├── application-test.yml     # 测试环境配置
└── application-prod.yml     # 生产环境配置
```

```xml
<profiles>
    <profile>
        <id>dev</id>
        <build>
            <resources>
                <resource>
                    <directory>src/main/resources</directory>
                    <excludes>
                        <exclude>application-prod.yml</exclude>
                    </excludes>
                </resource>
            </resources>
        </build>
    </profile>
    
    <profile>
        <id>prod</id>
        <build>
            <resources>
                <resource>
                    <directory>src/main/resources</directory>
                    <excludes>
                        <exclude>application-dev.yml</exclude>
                    </excludes>
                </resource>
            </resources>
        </build>
    </profile>
</profiles>
```

---

## 四、高级技巧

### 4.1 自定义 Maven Archetype

**创建 Archetype 模板项目：**

```bash
# 创建 Archetype 模板
mvn archetype:create-from-project

# 安装到本地仓库
cd target/generated-sources/archetype
mvn install
```

**使用自定义 Archetype：**

```bash
mvn archetype:generate \
  -DarchetypeGroupId=com.example \
  -DarchetypeArtifactId=my-archetype \
  -DarchetypeVersion=1.0.0 \
  -DgroupId=com.example \
  -DartifactId=my-new-project \
  -Dversion=1.0.0
```

### 4.2 自定义 Maven 插件

```java
package com.example.maven.plugin;

import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugins.annotations.Mojo;
import org.apache.maven.plugins.annotations.Parameter;

@Mojo(name = "hello")
public class HelloMojo extends AbstractMojo {
    
    @Parameter(property = "name", defaultValue = "Maven")
    private String name;
    
    public void execute() throws MojoExecutionException {
        getLog().info("Hello, " + name + "!");
    }
}
```

```xml
<!-- pom.xml -->
<packaging>maven-plugin</packaging>

<dependencies>
    <dependency>
        <groupId>org.apache.maven</groupId>
        <artifactId>maven-plugin-api</artifactId>
        <version>3.9.5</version>
    </dependency>
    <dependency>
        <groupId>org.apache.maven.plugin-tools</groupId>
        <artifactId>maven-plugin-annotations</artifactId>
        <version>3.13.0</version>
        <scope>provided</scope>
    </dependency>
</dependencies>
```

**使用自定义插件：**

```xml
<build>
    <plugins>
        <plugin>
            <groupId>com.example</groupId>
            <artifactId>hello-maven-plugin</artifactId>
            <version>1.0.0</version>
            <configuration>
                <name>World</name>
            </configuration>
            <executions>
                <execution>
                    <phase>compile</phase>
                    <goals>
                        <goal>hello</goal>
                    </goals>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```

### 4.3 Maven Wrapper

Maven Wrapper 允许在没有安装 Maven 的机器上构建项目。

```bash
# 安装 Maven Wrapper
mvn wrapper:wrapper

# 生成的文件
.mvn/wrapper/
├── maven-wrapper.jar
├── maven-wrapper.properties
└── MavenWrapperDownloader.java
mvnw      # Linux/Mac 脚本
mvnw.cmd  # Windows 脚本
```

**使用 Maven Wrapper 构建：**

```bash
# Linux/Mac
./mvnw clean package

# Windows
mvnw.cmd clean package
```

### 4.4 常见问题与解决方案

**问题1：依赖下载失败**

```bash
# 清除本地仓库缓存
mvn dependency:purge-local-repository

# 强制更新 SNAPSHOT
mvn clean install -U

# 手动删除本地仓库的依赖目录
rm -rf ~/.m2/repository/org/example
```

**问题2：版本冲突**

```bash
# 查看依赖树
mvn dependency:tree

# 查看冲突
mvn dependency:tree -Dverbose

# 使用 <exclusions> 排除冲突依赖
```

**问题3：构建速度慢**

```xml
<!-- 增加 Maven 内存 -->
<!-- MAVEN_OPTS=-Xmx2048m -->

<!-- 并行构建 -->
<!-- mvn -T 4 clean install -->

<!-- 跳过测试 -->
<!-- mvn clean install -DskipTests -->
```

**问题4：编译报错**

```xml
<!-- 检查 JDK 版本 -->
<properties>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
</properties>

<!-- 检查编码 -->
<properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
</properties>
```

---

## 五、最佳实践

### 5.1 项目结构规范

```
project/
├── pom.xml
├── README.md
├── .gitignore
├── docs/                    # 项目文档
├── scripts/                 # 构建脚本
├── src/
│   ├── main/
│   │   ├── java/
│   │   └── resources/
│   └── test/
│       ├── java/
│       └── resources/
└── target/
```

### 5.2 版本管理规范

```
主版本.次版本.修订版

主版本：重大变更，不兼容的 API 修改
次版本：新增功能，向下兼容
修订版：Bug 修复，向下兼容

示例：
1.0.0   初始版本
1.0.1   Bug 修复
1.1.0   新增功能
2.0.0   重大版本更新
```

### 5.3 settings.xml 最佳配置

```xml
<settings>
    <!-- 本地仓库路径 -->
    <localRepository>D:/maven/repository</localRepository>
    
    <!-- 镜像配置 -->
    <mirrors>
        <mirror>
            <id>aliyun</id>
            <url>https://maven.aliyun.com/repository/public</url>
            <mirrorOf>central</mirrorOf>
        </mirror>
    </mirrors>
    
    <!-- 服务器认证 -->
    <servers>
        <server>
            <id>my-nexus</id>
            <username>${env.NEXUS_USER}</username>
            <password>${env.NEXUS_PASSWORD}</password>
        </server>
    </servers>
    
    <!-- Profile 配置 -->
    <profiles>
        <profile>
            <id>my-profile</id>
            <properties>
                <maven.compiler.source>17</maven.compiler.source>
                <maven.compiler.target>17</maven.compiler.target>
            </properties>
        </profile>
    </profiles>
    
    <activeProfiles>
        <activeProfile>my-profile</activeProfile>
    </activeProfiles>
</settings>
```

---

> 💡 **小结**：本章深入讲解了 Maven 的生命周期机制（Clean、Default、Site 三套生命周期）、常用插件配置与自定义、多模块项目的聚合与继承、Profile 多环境配置、资源文件过滤等高级特性。掌握这些内容，可以应对企业级项目的复杂构建需求，实现标准化、自动化的项目构建流程。
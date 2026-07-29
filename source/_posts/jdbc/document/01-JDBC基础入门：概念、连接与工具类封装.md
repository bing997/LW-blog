---
title: JDBC基础入门：概念、连接与工具类封装
date: 2024-11-10T00:00:00+08:00
tags:
    - jdbc
    - 教程
    - java
    - 数据库
categories: jdbc
cover: /images/cover_jdbc.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: "JDBC 基础入门教程，涵盖数据持久化概念、JDBC 规范架构、程序编写步骤、获取数据库连接、工具类封装、try-with-resources 语法。"
---

## 一、数据持久化

### 1.1 什么是数据持久化

**持久化（Persistence）**：把数据保存到可掉电式存储设备中以供之后使用。

大多数情况下，特别是企业级应用，数据持久化意味着将内存中的数据保存到硬盘上加以"固化"，而持久化的实现过程大多通过各种关系数据库来完成。

```
┌──────────────┐     持久化      ┌──────────────┐
│   内存数据    │  ──────────→   │   硬盘/数据库  │
│  (临时存储)   │                │  (永久存储)   │
└──────────────┘                └──────────────┘
```

持久化的主要应用是将内存中的数据存储在关系型数据库中，当然也可以存储在磁盘文件、XML 数据文件中。

### 1.2 Java 中的数据存储技术

在 Java 中，数据库存取技术可分为如下几类：

| 技术 | 说明 |
|------|------|
| **JDBC** | 直接访问数据库（基石） |
| **JDO** | Java Data Object 技术 |
| **O/R 工具** | dbutils、Hibernate、MyBatis、Spring JPA 等 |

**JDBC 是 Java 访问数据库的基石**，JDO、Hibernate、MyBatis 等只是更好地封装了 JDBC。

---

## 二、JDBC 介绍

### 2.1 什么是 JDBC

JDBC（Java Database Connectivity）是一个独立于特定数据库管理系统、通用的 SQL 数据库存取和操作的公共接口（一组 API），定义了用来访问数据库的标准 Java 类库（`java.sql`、`javax.sql`）。

**JDBC 的核心目标：**
- 为访问不同的数据库提供一种**统一的途径**
- 为开发者屏蔽一些细节问题
- 使 Java 程序员使用 JDBC 可以连接任何提供了 JDBC 驱动程序的数据库系统
- 程序员无需对特定的数据库系统的特点有过多的了解，大大简化和加快开发过程

### 2.2 没有 JDBC vs 有 JDBC

**没有 JDBC 时：**

```
Java 程序 ──→ MySQL 驱动 API（MySQL 特有）
            ──→ Oracle 驱动 API（Oracle 特有）
            ──→ SQL Server 驱动 API（SQL Server 特有）

问题：每切换一种数据库，代码几乎要全部重写
```

**有 JDBC 后：**

```
Java 程序 ──→ JDBC API（统一接口）
                  │
        ┌─────────┼─────────┐
        ↓         ↓         ↓
    MySQL 驱动  Oracle 驱动  SQL Server 驱动

优势：Java 程序只需面向 JDBC 接口编程，切换数据库只需更换驱动
```

### 2.3 JDBC 规范整体架构

JDBC 是 Sun 公司提供的一套用于数据库操作的接口，Java 程序员只需要面向这套接口编程即可。

不同的数据库厂商，需要针对这套接口提供不同实现。不同的实现的集合，即为不同数据库的驱动。

```
┌─────────────────────────────────────┐
│         Java 应用程序                │
├─────────────────────────────────────┤
│         JDBC API（java.sql）         │
│    Connection | Statement | ResultSet │
├─────────────────────────────────────┤
│         JDBC 驱动管理器               │
├──────┬──────┬──────┬───────────────┤
│MySQL │Oracle│SQLSV │ ...           │
│ 驱动  │ 驱动  │ 驱动  │               │
├──────┼──────┼──────┼───────────────┤
│MySQL │Oracle│SQLSV │ ...           │
│数据库 │数据库 │数据库 │               │
└──────┴──────┴──────┴───────────────┘
```

> **面向接口编程**：查看 API 会发现 `java.sql` 中有很多接口，JDBC 就是定义了这些接口规范。

---

## 三、JDBC 程序编写步骤

### 3.1 六大步骤

```
1. 加载数据库驱动     Class.forName()
       ↓
2. 建立数据库连接     DriverManager.getConnection()
       ↓
3. 创建 Statement 对象  conn.createStatement()
       ↓
4. 执行 SQL 语句      executeQuery() / executeUpdate()
       ↓
5. 处理查询结果       ResultSet
       ↓
6. 关闭资源          close()
```

### 3.2 代码示例

```java
import java.sql.*;

public class JdbcDemo {
    public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            // 1. 加载数据库驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // 2. 建立数据库连接
            String url = "jdbc:mysql://localhost:3306/qiufenfen_db?useSSL=false&serverTimezone=UTC";
            String user = "root";
            String password = "123456";
            conn = DriverManager.getConnection(url, user, password);
            
            // 3. 创建 Statement 对象
            stmt = conn.createStatement();
            
            // 4. 执行 SQL 语句
            String sql = "SELECT id, name, salary FROM emp";
            rs = stmt.executeQuery(sql);
            
            // 5. 处理查询结果
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                double salary = rs.getDouble("salary");
                System.out.println("id=" + id + ", name=" + name + ", salary=" + salary);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 6. 关闭资源（逆序关闭）
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (stmt != null) {
                try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
}
```

---

## 四、try-with-resources 语法

### 4.1 简介

`try-with-resources` 语句是 Java 7+ 支持的**自动资源管理机制**，所有实现了 `java.lang.AutoCloseable` 接口的资源类，放入 try 语句的 `()` 括号中，都可以实现资源的自动关闭。

### 4.2 作用

- 确保资源（如 `conn`、`statement`、`resultSet`）在代码块执行后**自动关闭**
- 即使发生异常也能释放资源
- **无需手动调用 `close()`**

### 4.3 语法示例

```java
// Java 7+ 传统写法
try (
    Connection conn = DriverManager.getConnection(url, user, password);
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM emp")
) {
    while (rs.next()) {
        System.out.println(rs.getString("name"));
    }
} catch (SQLException e) {
    e.printStackTrace();
}
// 资源自动关闭，无需 finally 块

// Java 9+ 改进写法（支持外部变量）
Connection conn = DriverManager.getConnection(url, user, password);
try (conn) {
    // 使用 conn
} catch (SQLException e) {
    e.printStackTrace();
}
// conn 自动关闭
```

### 4.4 要求

资源必须实现 `AutoCloseable` 接口（或 `Closeable` 接口），如 `Connection`、`Statement`、`ResultSet` 等都已实现。

---

## 五、获取数据库连接

### 5.1 加载与注册 JDBC 驱动

```java
// 加载驱动 ✓（推荐）
Class.forName("com.mysql.cj.jdbc.Driver");

// 注册驱动 ✗（不推荐）
// Driver 接口的驱动类都包含静态代码块，会自动调用 DriverManager.registerDriver()
// 因此无需显式注册
// DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
```

**加载驱动的原理：**

```java
// com.mysql.cj.jdbc.Driver 源码中的静态代码块
static {
    try {
        DriverManager.registerDriver(new Driver());
    } catch (SQLException e) {
        throw new RuntimeException("Can't register driver!");
    }
}
```

### 5.2 JDBC URL

JDBC URL 用于标识一个被注册的驱动程序，驱动程序管理器通过这个 URL 选择正确的驱动程序。

```
jdbc:mysql://主机地址:端口号/数据库名?参数列表

示例：
jdbc:mysql://localhost:3306/qiufenfen_db
jdbc:mysql://localhost:3306/qiufenfen_db?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8
jdbc:mysql://192.168.1.100:3306/test_db
```

**常用参数：**

| 参数 | 说明 | 示例 |
|------|------|------|
| `useSSL` | 是否使用 SSL | `useSSL=false` |
| `serverTimezone` | 服务器时区 | `serverTimezone=Asia/Shanghai` |
| `characterEncoding` | 字符编码 | `characterEncoding=UTF-8` |
| `useUnicode` | 是否使用 Unicode | `useUnicode=true` |
| `rewriteBatchedStatements` | 批处理优化 | `rewriteBatchedStatements=true` |

### 5.3 获取连接

```java
String url = "jdbc:mysql://localhost:3306/qiufenfen_db?useSSL=false&serverTimezone=UTC";
String user = "root";
String password = "123456";

Connection conn = DriverManager.getConnection(url, user, password);
```

---

## 六、连接工具类封装

### 6.1 使用配置文件的好处

- **代码和数据分离**：修改配置信息直接改配置文件，不需要深入代码
- **省去重新编译**：修改配置信息后无需重新编译

### 6.2 创建配置文件

在 `src/main/resources` 目录下创建 `jdbc.properties`：

```properties
# MySQL 驱动类名
driverClassName=com.mysql.cj.jdbc.Driver

# 数据库连接 URL
url=jdbc:mysql://localhost:3306/qiufenfen_db?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8

# 用户名
username=root

# 密码
password=123456
```

### 6.3 封装 DBUtil 工具类

```java
package com.qiufenfen.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

/**
 * JDBC 数据库连接工具类
 */
public class DBUtil {

    private static String driverClassName;
    private static String url;
    private static String username;
    private static String password;

    // 静态代码块：类加载时读取配置文件
    static {
        // 读取配置文件
        Properties props = new Properties();
        // 通过类加载器读取 resources 目录下的配置文件
        InputStream is = DBUtil.class.getClassLoader()
                .getResourceAsStream("jdbc.properties");
        try {
            props.load(is);
        } catch (IOException e) {
            e.printStackTrace();
        }

        driverClassName = props.getProperty("driverClassName");
        url = props.getProperty("url");
        username = props.getProperty("username");
        password = props.getProperty("password");

        // 加载驱动
        try {
            Class.forName(driverClassName);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    /**
     * 获取连接对象
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }

    /**
     * 关闭资源（逆序关闭）
     */
    public static void closeResource(ResultSet rs, Statement ps, Connection conn) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 关闭资源（Statement + Connection）
     */
    public static void closeResource(Statement ps, Connection conn) {
        closeResource(null, ps, conn);
    }
}
```

### 6.4 使用工具类完成查询

```java
package com.qiufenfen;

import com.qiufenfen.util.DBUtil;
import java.sql.*;

public class QueryDemo {
    public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // 1. 获取连接
            conn = DBUtil.getConnection();

            // 2. 创建 Statement
            stmt = conn.createStatement();

            // 3. 执行查询
            String sql = "SELECT id, name, salary FROM emp";
            rs = stmt.executeQuery(sql);

            // 4. 处理结果
            System.out.println("ID\t姓名\t薪资");
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                double salary = rs.getDouble("salary");
                System.out.println(id + "\t" + name + "\t" + salary);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 5. 关闭资源
            DBUtil.closeResource(rs, stmt, conn);
        }
    }
}
```

---

## 七、Java 与 SQL 数据类型映射表

| Java 数据类型 | SQL 数据类型 | 备注 |
|-------------|------------|------|
| `int` | `INT` | 标准整数类型 |
| `long` | `BIGINT` | 较大的整数类型 |
| `boolean` | `BIT` | 布尔类型 |
| `float` | `FLOAT` | 单精度浮点类型 |
| `double` | `DOUBLE` | 双精度浮点类型 |
| `String` | `VARCHAR(n)` / `TEXT` | 可变长度字符串 |
| `byte[]` | `BINARY(n)` / `VARBINARY(n)` | 二进制数据 |
| `java.math.BigDecimal` | `DECIMAL(p,s)` | 精确小数类型 |
| `java.sql.Date` | `DATE` | 日期类型（年月日） |
| `java.sql.Date` / `java.util.Date` | `DATETIME` | 日期时间类型 |
| `java.sql.Time` | `TIME` | 时间类型（时分秒） |
| `java.sql.Timestamp` | `TIMESTAMP` | 时间戳类型 |

---

> 💡 **小结**：本章介绍了 JDBC 的基础概念，包括数据持久化、JDBC 规范架构、程序编写六步骤。重点讲解了如何获取数据库连接（加载驱动、JDBC URL）以及将连接代码封装为工具类 DBUtil。最后介绍了 try-with-resources 自动资源管理语法和 Java 与 SQL 数据类型映射关系。掌握这些基础知识，就可以使用 JDBC 进行数据库操作了。
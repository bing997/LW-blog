---
title: JDBC进阶：事务管理与数据库连接池
date: 2024-11-12T00:00:00+08:00
tags:
    - jdbc
    - 教程
    - java
    - 事务
    - 数据库连接池
    - Druid
    - ThreadLocal
categories: jdbc
cover: /images/cover_jdbc.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: "JDBC 进阶教程，涵盖 JDBC 事务管理（ACID、setAutoCommit、commit、rollback）、银行转账案例、数据库连接池（Druid、HikariCP）、ThreadLocal 线程隔离。"
---

## 一、JDBC 事务处理

### 1.1 事务基础

**数据一旦提交，就不可回滚。**

**数据什么时候意味着提交？**
- 当一个连接对象被创建时，默认情况下是**自动提交事务**：每次执行一个 SQL 语句时，如果执行成功，就会向数据库自动提交，而不能回滚
- **关闭数据库连接**，数据就会自动的提交。如果多个操作每个使用自己单独的连接，则无法保证事务

**核心原则：同一个事务的多个操作必须在同一个 Connection 对象下执行。**

### 1.2 JDBC 事务 API

| 方法 | 说明 |
|------|------|
| `conn.setAutoCommit(false)` | 取消自动提交，开启事务 |
| `conn.commit()` | 提交事务 |
| `conn.rollback()` | 回滚事务 |
| `conn.setSavepoint()` | 设置保存点 |
| `conn.rollback(Savepoint)` | 回滚到指定保存点 |

```
开启事务
setAutoCommit(false)
       │
       ├── SQL 1 执行成功
       ├── SQL 2 执行成功
       ├── SQL 3 执行失败 ✗
       │
       ├── 有异常 → rollback()  回滚所有操作
       │
       └── 全部成功 → commit()  提交事务
```

### 1.3 事务代码模板

```java
Connection conn = null;
try {
    conn = DBUtil.getConnection();
    
    // 1. 开启事务（取消自动提交）
    conn.setAutoCommit(false);
    
    // 2. 执行多条 SQL
    // ... SQL 操作 1
    // ... SQL 操作 2
    // ... SQL 操作 3
    
    // 3. 全部成功，提交事务
    conn.commit();
} catch (Exception e) {
    // 4. 出现异常，回滚事务
    if (conn != null) {
        try {
            conn.rollback();
        } catch (SQLException e1) {
            e1.printStackTrace();
        }
    }
    e.printStackTrace();
} finally {
    // 5. 恢复自动提交状态（连接池场景下尤为重要）
    if (conn != null) {
        try {
            conn.setAutoCommit(true);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    DBUtil.closeResource(null, null, conn);
}
```

> **注意**：若 Connection 没有被关闭，还可能被重复使用（如连接池场景），则需要恢复其自动提交状态 `setAutoCommit(true)`。执行 `close()` 方法前，建议恢复自动提交状态。

---

## 二、事务案例：银行转账

### 2.1 创建数据库表

```sql
-- 在 qiufenfen_db 数据库中创建 account 表
CREATE TABLE account (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    balance DECIMAL(10, 2) DEFAULT 0.00
);

INSERT INTO account (name, balance) VALUES ('A', 1000);
INSERT INTO account (name, balance) VALUES ('B', 1000);
```

### 2.2 实体类

```java
package com.qiufenfen.entity;

import lombok.Data;

@Data
public class Account {
    private Integer id;
    private String name;
    private Double balance;
}
```

### 2.3 DAO 层

```java
// AccountDAO 接口
public interface AccountDAO {
    // 根据姓名查询账户
    Account findByName(Connection conn, String name) throws SQLException;
    // 更新账户余额
    void updateBalance(Connection conn, String name, double balance) throws SQLException;
}

// AccountDAO 实现类
public class AccountDAOImpl implements AccountDAO {
    
    @Override
    public Account findByName(Connection conn, String name) throws SQLException {
        String sql = "SELECT id, name, balance FROM account WHERE name = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, name);
        ResultSet rs = ps.executeQuery();
        
        Account account = null;
        if (rs.next()) {
            account = new Account();
            account.setId(rs.getInt("id"));
            account.setName(rs.getString("name"));
            account.setBalance(rs.getDouble("balance"));
        }
        // 注意：不在这里关闭 conn，事务需要同一个连接
        ps.close();
        rs.close();
        return account;
    }
    
    @Override
    public void updateBalance(Connection conn, String name, double balance) throws SQLException {
        String sql = "UPDATE account SET balance = ? WHERE name = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setDouble(1, balance);
        ps.setString(2, name);
        ps.executeUpdate();
        ps.close();
    }
}
```

### 2.4 Service 层（事务控制核心）

```java
// AccountService 接口
public interface AccountService {
    /**
     * 转账
     * @param fromName 转出账户
     * @param toName   转入账户
     * @param amount   转账金额
     */
    void transfer(String fromName, String toName, double amount);
}

// AccountServiceImpl 实现类（事务控制的重难点）
public class AccountServiceImpl implements AccountService {
    
    private AccountDAO accountDAO = new AccountDAOImpl();
    
    @Override
    public void transfer(String fromName, String toName, double amount) {
        Connection conn = null;
        try {
            // 1. 获取连接
            conn = DBUtil.getConnection();
            
            // 2. 开启事务
            conn.setAutoCommit(false);
            
            // 3. 查询转出账户
            Account fromAccount = accountDAO.findByName(conn, fromName);
            if (fromAccount == null) {
                throw new RuntimeException("转出账户不存在");
            }
            if (fromAccount.getBalance() < amount) {
                throw new RuntimeException("余额不足");
            }
            
            // 4. 查询转入账户
            Account toAccount = accountDAO.findByName(conn, toName);
            if (toAccount == null) {
                throw new RuntimeException("转入账户不存在");
            }
            
            // 5. 扣减转出账户余额
            accountDAO.updateBalance(conn, fromName, fromAccount.getBalance() - amount);
            
            // 模拟异常（测试事务回滚）
            // int i = 1 / 0;
            
            // 6. 增加转入账户余额
            accountDAO.updateBalance(conn, toName, toAccount.getBalance() + amount);
            
            // 7. 提交事务
            conn.commit();
            System.out.println("转账成功！");
            
        } catch (Exception e) {
            // 8. 回滚事务
            if (conn != null) {
                try {
                    conn.rollback();
                    System.out.println("转账失败，已回滚");
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            // 9. 恢复自动提交
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            DBUtil.closeResource(null, null, conn);
        }
    }
}
```

### 2.5 测试

```java
@Test
public void testTransfer() {
    AccountService service = new AccountServiceImpl();
    // A 向 B 转账 100
    service.transfer("A", "B", 100);
}
```

**关键点：** 事务必须使用同一个连接对象（Connection）才能保证 ACID 特性。DAO 层的方法接收外部传入的 Connection，而不是自己创建。

---

## 三、数据库连接池

### 3.1 传统模式的弊端

```
传统模式：
1. 在主程序中建立数据库连接
2. 进行 SQL 操作
3. 断开数据库连接

问题：
- 每次建立连接都要验证用户名和密码（0.05s~1s），消耗大量资源和时间
- 连接资源没有得到很好的重复利用
- 频繁连接操作将占用大量系统资源，可能导致服务器崩溃
- 每次连接使用完必须断开，否则会导致内存泄漏
- 无法控制创建的连接对象数，可能导致内存泄漏、服务器崩溃
```

### 3.2 连接池技术

**基本思想：** 为数据库连接建立一个"缓冲池"。预先在缓冲池中放入一定数量的连接，需要时从"缓冲池"中取出一个，使用完毕后再放回去。

```
┌─────────────────────────────────────────────┐
│              数据库连接池                     │
│                                             │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐        │
│  │连接1│ │连接2│ │连接3│ │连接4│ │连接5│        │
│  └────┘ └────┘ └────┘ └────┘ └────┘        │
│                                             │
│  最小连接数: 2    最大连接数: 10              │
├─────────────────────────────────────────────┤
│  应用程序                                    │
│  1. 请求连接 → 从池中获取                     │
│  2. 使用连接 → 执行 SQL                       │
│  3. 归还连接 → 放回池中（不是物理关闭）        │
└─────────────────────────────────────────────┘
```

### 3.3 工作原理

连接池的工作原理由三部分组成：

1. **连接池的建立**：系统初始化时，连接池根据配置建立，并在池中创建几个连接对象
2. **连接池的管理**：
   - 客户请求连接时，查看是否有空闲连接 → 有则分配，无则检查是否达到最大连接数
   - 未达到最大 → 创建新连接；已达到 → 等待，超时则抛异常
   - 客户释放连接时，连接归还到池中供其他客户使用
3. **连接池的关闭**：应用程序退出时，关闭所有连接，释放资源

### 3.4 连接池的优点

- 避免数据库连接频繁创建和销毁，**节省系统开销**
- 提高数据库访问速度，**加快响应**
- 有效控制连接数量，**防止资源耗尽**

### 3.5 常用连接池

| 连接池 | 说明 |
|-------|------|
| **DBCP** | Apache 提供，Tomcat 自带，速度较快但有 BUG |
| **C3P0** | 开源组织提供，速度较慢，稳定性还可以，Hibernate 推荐 |
| **Druid** | 阿里巴巴提供，集 DBCP、C3P0、Proxool 优点于一身，**自带日志监控** |
| **HikariCP** | 号称业界跑得最快的连接池，**Spring Boot 2.0+ 默认** |

> `DataSource` 通常被称为数据源，包含连接池和连接池管理两部分。DataSource 用来取代 DriverManager 获取 Connection。

**特别注意：**
- 数据源无需创建多个，整个应用只需要一个数据源
- `conn.close()` 并没有关闭物理连接，只是把连接释放归还给连接池

---

## 四、Druid 连接池

### 4.1 添加依赖

```xml
<!-- Druid 连接池 -->
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>druid</artifactId>
    <version>1.2.20</version>
</dependency>
```

### 4.2 配置文件 druid.properties

```properties
# 初始化连接数量
initialSize=5

# 最大连接数量
maxActive=20

# 最小空闲连接数
minIdle=5

# 获取连接时最大等待时间（毫秒）
maxWait=3000

# 间隔多久检查一次空闲连接
timeBetweenEvictionRunsMillis=60000

# 连接空闲的最小时间
minEvictableIdleTimeMillis=300000

# 验证连接是否有效的 SQL
validationQuery=SELECT 1

# 获取连接时是否检查有效性
testWhileIdle=true
testOnBorrow=false
testOnReturn=false

# 是否缓存 PreparedStatement
poolPreparedStatements=true
maxOpenPreparedStatements=20

# 数据库连接信息
driverClassName=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://localhost:3306/qiufenfen_db?useSSL=false&serverTimezone=UTC
username=root
password=123456
```

### 4.3 Druid 工具类封装

```java
package com.qiufenfen.util;

import com.alibaba.druid.pool.DruidDataSourceFactory;
import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

/**
 * Druid 连接池工具类
 */
public class DruidUtil {

    private static DataSource dataSource;

    static {
        try {
            // 读取配置文件
            Properties props = new Properties();
            InputStream is = DruidUtil.class.getClassLoader()
                    .getResourceAsStream("druid.properties");
            props.load(is);

            // 创建数据源
            dataSource = DruidDataSourceFactory.createDataSource(props);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 获取数据源
     */
    public static DataSource getDataSource() {
        return dataSource;
    }

    /**
     * 获取连接
     */
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    /**
     * 关闭资源
     */
    public static void closeResource(ResultSet rs, Statement ps, Connection conn) {
        if (rs != null) {
            try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (ps != null) {
            try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (conn != null) {
            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            // conn.close() 不是关闭物理连接，而是归还到连接池
        }
    }
}
```

### 4.4 Druid 配置参数详解

| 参数 | 说明 | 推荐 |
|------|------|------|
| `initialSize` | 初始化连接数。第一次 getConnection 时创建，非应用启动时 | 5 |
| `maxActive` | 最大连接数 | 20 |
| `minIdle` | 最小空闲连接数 | 5 |
| `maxWait` | 获取连接的超时等待时间（毫秒），0 表示无限等待 | 1200（内网） |
| `validationQuery` | 验证连接是否有效的 SQL（SELECT 1） | SELECT 1 |
| `testWhileIdle` | 是否检查空闲连接有效性 | true |
| `testOnBorrow` | 获取连接时是否检查有效性 | false |
| `testOnReturn` | 归还连接时是否检查有效性 | false |
| `timeBetweenEvictionRunsMillis` | 检查空闲连接的间隔（毫秒） | 60000 |
| `minEvictableIdleTimeMillis` | 连接可空闲的最小时间 | 300000 |
| `poolPreparedStatements` | 是否缓存 PreparedStatement | true |

**maxWait 配置不当的案例：**

```
maxWait=0（不设等待超时）
→ 突发大流量涌入，连接池耗尽
→ 所有请求无限等待
→ 等待队列越排越长
→ 接口大量超时，打满线程
→ 服务不可用

推荐配置：maxWait=1200（内网网络状况好时）
```

---

## 五、HikariCP 连接池

### 5.1 添加依赖

```xml
<!-- HikariCP 连接池 -->
<dependency>
    <groupId>com.zaxxer</groupId>
    <artifactId>HikariCP</artifactId>
    <version>5.1.0</version>
</dependency>
```

### 5.2 配置与使用

```java
package com.qiufenfen.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import javax.sql.DataSource;
import java.sql.*;

public class HikariUtil {

    private static HikariDataSource dataSource;

    static {
        HikariConfig config = new HikariConfig();
        
        // 数据库连接信息
        config.setJdbcUrl("jdbc:mysql://localhost:3306/qiufenfen_db?useSSL=false&serverTimezone=UTC");
        config.setUsername("root");
        config.setPassword("123456");
        
        // 连接池参数
        config.setMaximumPoolSize(20);       // 最大连接数
        config.setMinimumIdle(5);             // 最小空闲连接数
        config.setConnectionTimeout(3000);    // 连接超时（毫秒）
        config.setIdleTimeout(600000);        // 空闲连接超时（毫秒）
        config.setMaxLifetime(1800000);       // 连接最大生命周期（毫秒）
        
        dataSource = new HikariDataSource(config);
    }

    public static DataSource getDataSource() {
        return dataSource;
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    public static void closeResource(ResultSet rs, Statement ps, Connection conn) {
        if (rs != null) {
            try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (ps != null) {
            try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (conn != null) {
            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
```

### 5.3 HikariCP 配置参数

| 参数 | 说明 |
|------|------|
| `jdbcUrl` | 数据库连接 URL |
| `username` | 用户名 |
| `password` | 密码 |
| `maximumPoolSize` | 连接池最大连接数 |
| `minimumIdle` | 最小空闲连接数 |
| `connectionTimeout` | 连接超时时间（毫秒） |
| `idleTimeout` | 空闲连接超时时间（毫秒） |
| `maxLifetime` | 连接最大生命周期（毫秒） |

---

## 六、ThreadLocal

### 6.1 简介

`ThreadLocal` 是 Java 提供的线程本地存储类，为每个使用该变量的线程提供**独立的变量副本**。

**主要用途：**
- **线程隔离**：在多线程环境下，某些数据不应该被多个线程共享，使用 ThreadLocal 避免数据在多线程共享
- **线程内共享**：在单个线程内部隐式共享数据

### 6.2 ThreadLocal 案例

```java
public class ThreadLocalDemo {
    
    private static ThreadLocal<Integer> threadLocal = new ThreadLocal<>();

    public static void main(String[] args) {
        // 线程 t1
        Thread t1 = new Thread(() -> {
            threadLocal.set(100);
            System.out.println("t1: " + threadLocal.get());  // 100
            threadLocal.remove();
        });

        // 线程 t2
        Thread t2 = new Thread(() -> {
            threadLocal.set(200);
            System.out.println("t2: " + threadLocal.get());  // 200
            threadLocal.remove();
        });

        t1.start();
        t2.start();
    }
}
// 输出：t1: 100  t2: 200（互不影响）
```

### 6.3 ThreadLocal 在 JDBC 中的应用

**场景：** 同一个线程的不同方法获取同一个 Connection（用于事务控制）。

```java
package com.qiufenfen.util;

import java.sql.*;

public class ConnectionUtil {

    private static ThreadLocal<Connection> threadLocal = new ThreadLocal<>();

    /**
     * 获取连接（同一线程获取同一个 Connection）
     */
    public static Connection getConnection() throws SQLException {
        Connection conn = threadLocal.get();
        if (conn == null || conn.isClosed()) {
            conn = DruidUtil.getConnection();  // 从连接池获取
            threadLocal.set(conn);  // 绑定到当前线程
        }
        return conn;
    }

    /**
     * 关闭连接（从当前线程移除并归还到连接池）
     */
    public static void closeConnection() {
        Connection conn = threadLocal.get();
        if (conn != null) {
            try {
                conn.close();  // 归还到连接池
            } catch (SQLException e) {
                e.printStackTrace();
            }
            threadLocal.remove();  // 从当前线程移除
        }
    }
}
```

**ThreadLocal 保证同一个线程在 DAO 层和 Service 层使用的是同一个 Connection，从而保证事务的 ACID 特性。**

---

## 七、连接池关键问题分析

### 7.1 并发问题

使用 `synchronized` 确保线程同步：

```java
public synchronized Connection getConnection() {
    // 确保多线程环境下安全获取连接
}
```

### 7.2 事务处理

Connection 本身提供事务支持：

```java
conn.setAutoCommit(false);
// SQL 操作
conn.commit();  // 或 conn.rollback();
```

**每个事务独占一个连接**，可以大大降低事务管理的复杂性。

### 7.3 连接池分配与释放

```
请求连接时：
  1. 检查空闲池是否有空闲连接
     有 → 分配建立时间最长的连接（先检查是否有效）
     无 → 检查是否达到最大连接数
          未达到 → 新建连接
          已达到 → 等待（timeout），超时返回 null

释放连接时：
  归还到空闲池，供其他请求使用
```

### 7.4 连接池配置建议

- **最小连接数**：开发时设小（启动快），生产时设大（响应快）
- **最大连接数**：根据系统访问量反复测试找到最佳点
- **动态策略**：每隔一定时间检查连接数，小于最小连接数时补充

---

> 💡 **小结**：本章深入讲解了 JDBC 事务管理和数据库连接池。事务部分包括 setAutoCommit、commit、rollback 的使用，通过银行转账案例展示了事务控制的完整流程。连接池部分介绍了 Druid 和 HikariCP 两种主流连接池的配置与封装，以及连接池工作原理和参数调优。最后讲解了 ThreadLocal 在 JDBC 事务中的应用，确保同一线程使用同一连接。
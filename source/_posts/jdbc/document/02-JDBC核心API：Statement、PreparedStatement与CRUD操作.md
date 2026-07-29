---
title: JDBC核心API：Statement、PreparedStatement与CRUD操作
date: 2024-11-11T00:00:00+08:00
tags:
    - jdbc
    - 教程
    - java
    - 数据库
    - PreparedStatement
    - CRUD
categories: jdbc
cover: /images/cover_jdbc.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: "JDBC 核心 API 教程，涵盖三种执行 SQL 对象（Statement、PreparedStatement、CallableStatement）、CRUD 操作、获取自增主键、分页查询、批量操作等。"
---

## 一、执行 SQL 语句的三种接口

数据库连接被用于向数据库服务器发送命令和 SQL 语句，并接受数据库服务器返回的结果。一个数据库连接就是一个 Socket 连接。

在 `java.sql` 包中有 3 个接口分别定义了对数据库的调用的不同方式：

| 接口 | 说明 | 特点 |
|------|------|------|
| **Statement** | 用于执行静态 SQL 语句 | 不预编译，存在 SQL 注入风险 |
| **PreparedStatement** | SQL 语句被预编译并存储 | **推荐使用**，可防止 SQL 注入，效率高 |
| **CallableStatement** | 用于执行 SQL 存储过程 | 调用数据库存储过程 |

```
┌─────────────────────────────────────────────┐
│            Statement                        │
│  executeQuery("SELECT * FROM emp")          │
│  executeUpdate("INSERT INTO ...")           │
├─────────────────────────────────────────────┤
│          PreparedStatement                  │
│  SQL 预编译，使用 ? 占位符                    │
│  executeQuery()  无参方法                    │
│  安全性高，可重复执行                         │
├─────────────────────────────────────────────┤
│         CallableStatement                   │
│  调用存储过程                                │
│  {call procedure_name(?, ?, ?)}             │
└─────────────────────────────────────────────┘
```

### 1.1 创建 Statement 对象

```java
Connection conn = DBUtil.getConnection();
Statement stmt = conn.createStatement();
```

### 1.2 创建 PreparedStatement 对象

```java
Connection conn = DBUtil.getConnection();
String sql = "SELECT * FROM emp WHERE id = ?";
PreparedStatement ps = conn.prepareStatement(sql);
ps.setInt(1, 10);  // 设置参数
```

### 1.3 创建 CallableStatement 对象

```java
Connection conn = DBUtil.getConnection();
String sql = "{call update_salary(?, ?, ?)}";
CallableStatement cs = conn.prepareCall(sql);
cs.setInt(1, 19);  // 输入参数
cs.registerOutParameter(2, Types.DECIMAL);  // 输出参数
cs.registerOutParameter(3, Types.DECIMAL);  // 输出参数
```

---

## 二、Statement 详解

### 2.1 常用方法

| 方法 | 说明 |
|------|------|
| `executeQuery(String sql)` | 执行 SELECT 查询，返回 ResultSet |
| `executeUpdate(String sql)` | 执行 INSERT/UPDATE/DELETE，返回影响行数 |
| `execute(String sql)` | 执行任意 SQL，返回 boolean |
| `addBatch(String sql)` | 添加批处理 SQL |
| `executeBatch()` | 执行批处理 |
| `clearBatch()` | 清空批处理 |

### 2.2 Statement 执行 CRUD

```java
// 查询（Read）
String sql = "SELECT * FROM emp";
ResultSet rs = stmt.executeQuery(sql);

// 插入（Create）
String sql = "INSERT INTO emp(name, salary) VALUES('张三', 8000)";
int rows = stmt.executeUpdate(sql);
System.out.println("插入了 " + rows + " 行");

// 更新（Update）
String sql = "UPDATE emp SET salary = 9000 WHERE id = 1";
int rows = stmt.executeUpdate(sql);

// 删除（Delete）
String sql = "DELETE FROM emp WHERE id = 1";
int rows = stmt.executeUpdate(sql);
```

### 2.3 Statement 的缺点

- **SQL 注入风险**：用户输入的内容可能被拼接到 SQL 中
- **性能低**：每次执行都需要编译 SQL
- **不可重复使用**：每次需要传入完整 SQL

```java
// SQL 注入示例（危险！）
String name = "admin' OR '1'='1";
String sql = "SELECT * FROM user WHERE name = '" + name + "' AND password = '123'";
// 实际执行的 SQL：SELECT * FROM user WHERE name = 'admin' OR '1'='1' AND password = '123'
// '1'='1' 永远为真，导致绕过验证
```

---

## 三、PreparedStatement 详解

### 3.1 为什么使用 PreparedStatement

| 特性 | Statement | PreparedStatement |
|------|-----------|-------------------|
| SQL 注入 | ❌ 存在风险 | ✅ 可防止 |
| 预编译 | ❌ 每次编译 | ✅ 预编译一次 |
| 性能 | 低 | 高（可重复执行） |
| 参数设置 | 字符串拼接 | `?` 占位符 |
| 适用场景 | 静态 SQL | 动态参数 SQL |

**预编译的优点：**

- **A. 可反复执行**：预编译 SQL 可以被 PreparedStatement 反复执行
- **B. 性能高**：预编译 SQL 只被数据库解析一次，后续只需传递参数
- **C. 安全性好**：可以抵御 SQL 注入攻击
- **D. 占位符**：可以替代表达式中的数据值（不能替代表名、列名）

### 3.2 PreparedStatement 常用方法

| 方法 | 说明 |
|------|------|
| `setInt(int index, int value)` | 设置 int 参数 |
| `setString(int index, String value)` | 设置 String 参数 |
| `setDouble(int index, double value)` | 设置 double 参数 |
| `setDate(int index, Date value)` | 设置 Date 参数 |
| `setObject(int index, Object value)` | 设置 Object 参数 |
| `executeQuery()` | 执行查询（无参） |
| `executeUpdate()` | 执行更新（无参） |
| `clearParameters()` | 清除参数 |

### 3.3 PreparedStatement 执行 CRUD

```java
// ============================================
// 查询（Read）
// ============================================
String sql = "SELECT id, name, salary FROM emp WHERE salary > ?";
PreparedStatement ps = conn.prepareStatement(sql);
ps.setDouble(1, 5000);  // 设置参数：薪资大于 5000
ResultSet rs = ps.executeQuery();
while (rs.next()) {
    System.out.println(rs.getInt("id") + " " + rs.getString("name"));
}

// ============================================
// 插入（Create）
// ============================================
String sql = "INSERT INTO emp(name, salary, dept_id) VALUES(?, ?, ?)";
PreparedStatement ps = conn.prepareStatement(sql);
ps.setString(1, "李四");
ps.setDouble(2, 8000);
ps.setInt(3, 1);
int rows = ps.executeUpdate();
System.out.println("插入了 " + rows + " 行");

// ============================================
// 更新（Update）
// ============================================
String sql = "UPDATE emp SET salary = ? WHERE id = ?";
PreparedStatement ps = conn.prepareStatement(sql);
ps.setDouble(1, 10000);
ps.setInt(2, 1);
int rows = ps.executeUpdate();

// ============================================
// 删除（Delete）
// ============================================
String sql = "DELETE FROM emp WHERE id = ?";
PreparedStatement ps = conn.prepareStatement(sql);
ps.setInt(1, 1);
int rows = ps.executeUpdate();
```

---

## 四、获取自增主键

### 4.1 应用场景

在实际开发中经常需要同时向多张表中插入数据，表和表之间存在关联关系。某张表的主键列是自动生成的，如何在插入数据时同时获取自动生成的主键？

### 4.2 Connection 接口

```java
// 创建 PreparedStatement 时指定是否返回自增主键
PreparedStatement ps = conn.prepareStatement(
    sql, 
    Statement.RETURN_GENERATED_KEYS   // 返回自增键
    // Statement.NO_GENERATED_KEYS    // 不返回自增键
);
```

### 4.3 Statement 接口

```java
// 执行后获取自增主键
ResultSet rs = ps.getGeneratedKeys();
if (rs.next()) {
    int id = rs.getInt(1);  // 获取自增主键值
}
```

### 4.4 完整示例

```java
/**
 * DAO 接口：添加数据并返回自增主键
 */
public interface IEmpDAO {
    Integer insertReturnKey(Emp emp);
}

/**
 * DAO 实现类
 */
public class EmpDAOImpl implements IEmpDAO {
    
    @Override
    public Integer insertReturnKey(Emp emp) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Integer id = null;
        
        try {
            conn = DBUtil.getConnection();
            String sql = "INSERT INTO emp(name, salary, dept_id) VALUES(?, ?, ?)";
            
            // 创建 PreparedStatement，指定返回自增主键
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, emp.getName());
            ps.setDouble(2, emp.getSalary());
            ps.setInt(3, emp.getDeptId());
            
            // 执行插入
            ps.executeUpdate();
            
            // 获取自增主键
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                id = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResource(rs, ps, conn);
        }
        return id;
    }
}

// 测试
@Test
public void testInsertReturnKey() {
    Emp emp = new Emp();
    emp.setName("王五");
    emp.setSalary(8500);
    emp.setDeptId(1);
    
    EmpDAOImpl dao = new EmpDAOImpl();
    Integer id = dao.insertReturnKey(emp);
    System.out.println("新增员工的 ID：" + id);
}
```

---

## 五、批量操作

### 5.1 批处理 API

| 方法 | 说明 |
|------|------|
| `addBatch()` | 将参数添加到批处理 |
| `executeBatch()` | 执行批处理，返回每条 SQL 影响的行数 |
| `clearBatch()` | 清空批处理中的参数 |

### 5.2 批量插入示例

```java
package com.rd;

import com.rd.util.DBUtil;
import java.sql.*;
import java.util.Arrays;

/**
 * 批处理示例
 */
public class BatchExample {
    public static void main(String[] args) throws SQLException {
        // 1. 获取连接对象
        Connection conn = DBUtil.getConnection();
        
        // 2. 手动提交事务
        conn.setAutoCommit(false);
        
        // 3. 创建 PreparedStatement 对象
        String sql = "insert into tb_goods_temp(name) values(?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        // 4. 给问号赋值（批量传参）
        for (int i = 0; i < 100; i++) {
            ps.setString(1, "商品" + (i + 1));
            
            // 5. 添加到批处理
            ps.addBatch();
        }
        
        // 6. 执行批处理
        int[] arr = ps.executeBatch();
        System.out.println(Arrays.toString(arr));
        
        // 7. 手动提交事务
        conn.commit();
        
        // 8. 关闭连接
        DBUtil.closeResource(null, ps, conn);
    }
}
```

### 5.3 批处理优化技巧

```java
// 分批处理（避免内存溢出）
int batchSize = 500;
for (int i = 0; i < 10000; i++) {
    ps.setString(1, "商品" + (i + 1));
    ps.addBatch();
    
    // 每 batchSize 条执行一次
    if ((i + 1) % batchSize == 0) {
        ps.executeBatch();
        ps.clearBatch();
    }
}
// 执行剩余的
ps.executeBatch();
ps.clearBatch();
```

**JDBC URL 中添加批处理优化参数：**

```properties
url=jdbc:mysql://localhost:3306/db?rewriteBatchedStatements=true
```

---

## 六、分页查询

### 6.1 分页 SQL

```sql
SELECT * FROM 表名 LIMIT (pageNum - 1) * pageSize, pageSize
```

### 6.2 分页工具类

```java
package com.qiufenfen.util;

import java.util.List;

/**
 * 自封装分页工具类
 * SELECT * FROM 表名 LIMIT (pageNum-1)*pageSize, pageSize
 */
public class PageUtil<E> {
    private int pageNum;          // 当前页
    private int pageSize;         // 每页大小
    private long totalRecords;    // 总记录数
    private int totalPages;       // 总页数（计算属性）
    private int offset;           // 偏移量（计算属性）
    private boolean hasPrevious;  // 是否有上一页
    private boolean hasNext;      // 是否有下一页
    private List<E> data;         // 页面上显示的数据

    // 客户端只需告诉查询第几页、每页多少条
    public PageUtil(int pageNum, int pageSize) {
        if (pageNum < 1) {
            throw new IllegalArgumentException("页码必须大于0!");
        }
        if (pageSize < 1) {
            throw new IllegalArgumentException("每页数量必须大于0!");
        }
        this.pageNum = pageNum;
        this.pageSize = pageSize;
    }

    // 计算属性：总页数
    public int getTotalPages() {
        if (totalRecords <= 0) return 0;
        return (int) Math.ceil((double) totalRecords / pageSize);
    }

    // 计算属性：偏移量
    public int getOffset() {
        return (pageNum - 1) * pageSize;
    }

    // 计算属性：是否有上一页
    public boolean isHasPrevious() {
        return pageNum > 1;
    }

    // 计算属性：是否有下一页
    public boolean isHasNext() {
        return pageNum < getTotalPages();
    }

    // getter / setter ...
    public int getPageNum() { return pageNum; }
    public int getPageSize() { return pageSize; }
    public long getTotalRecords() { return totalRecords; }
    public void setTotalRecords(long totalRecords) { this.totalRecords = totalRecords; }
    public List<E> getData() { return data; }
    public void setData(List<E> data) { this.data = data; }
}
```

### 6.3 分页查询实现

```java
/**
 * 分页查询员工
 */
public PageUtil<Emp> findByPage(int pageNum, int pageSize) {
    PageUtil<Emp> page = new PageUtil<>(pageNum, pageSize);
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    List<Emp> list = new ArrayList<>();
    
    try {
        conn = DBUtil.getConnection();
        
        // 1. 查询总记录数
        String countSql = "SELECT COUNT(*) FROM emp";
        ps = conn.prepareStatement(countSql);
        rs = ps.executeQuery();
        if (rs.next()) {
            page.setTotalRecords(rs.getLong(1));
        }
        
        // 2. 查询当前页数据
        String sql = "SELECT * FROM emp LIMIT ?, ?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, page.getOffset());
        ps.setInt(2, page.getPageSize());
        rs = ps.executeQuery();
        
        while (rs.next()) {
            Emp emp = new Emp();
            emp.setId(rs.getInt("id"));
            emp.setName(rs.getString("name"));
            emp.setSalary(rs.getDouble("salary"));
            list.add(emp);
        }
        page.setData(list);
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        DBUtil.closeResource(rs, ps, conn);
    }
    return page;
}
```

---

## 七、CallableStatement 调用存储过程

### 7.1 创建函数和存储过程

```sql
-- 创建函数
CREATE FUNCTION calculate_bonus(p_emp_id INT) 
RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE emp_sal INT;
    DECLARE emp_bonus DECIMAL(10,2);
    
    SELECT salary INTO emp_sal FROM emp WHERE id = p_emp_id;
    
    IF emp_sal IS NULL THEN 
        RETURN 0.0;
    END IF;
    
    SET emp_bonus = emp_sal * 0.1;
    RETURN emp_bonus;
END;

-- 调用函数
SELECT calculate_bonus(19);


-- 创建存储过程
CREATE PROCEDURE update_salary(
    IN emp_id INT,                      -- 输入参数
    OUT old_salary DECIMAL(10,2),       -- 输出参数
    OUT new_salary DECIMAL(10,2)        -- 输出参数
)
BEGIN
    SELECT salary INTO old_salary FROM emp WHERE id = emp_id;
    UPDATE emp SET salary = salary * 1.1 WHERE id = emp_id;
    SELECT salary INTO new_salary FROM emp WHERE id = emp_id;
END;

-- 调用存储过程
CALL update_salary(19, @x, @y);
SELECT @x, @y;
```

### 7.2 JDBC 调用函数

```java
// 调用函数（通过 SELECT 语句）
String sql = "SELECT calculate_bonus(?)";
PreparedStatement ps = conn.prepareStatement(sql);
ps.setInt(1, 19);
ResultSet rs = ps.executeQuery();
if (rs.next()) {
    double bonus = rs.getDouble(1);
    System.out.println("奖金：" + bonus);
}
```

### 7.3 JDBC 调用存储过程

```java
// 调用存储过程
String sql = "{call update_salary(?, ?, ?)}";
CallableStatement cs = conn.prepareCall(sql);

// 设置输入参数
cs.setInt(1, 19);

// 注册输出参数
cs.registerOutParameter(2, Types.DECIMAL);
cs.registerOutParameter(3, Types.DECIMAL);

// 执行
cs.execute();

// 获取输出参数
double oldSalary = cs.getDouble(2);
double newSalary = cs.getDouble(3);
System.out.println("旧薪资：" + oldSalary + "，新薪资：" + newSalary);
```

---

## 八、ResultSet 与 ResultSetMetaData

### 8.1 ResultSet 结果集

`ResultSet` 是 SELECT 查询返回的结果集。

```java
ResultSet rs = ps.executeQuery();

while (rs.next()) {  // 判断是否有下一行数据
    // 通过列名获取
    int deptno = rs.getInt("deptno");
    String dname = rs.getString("dname");
    String loc = rs.getString("loc");
    
    // 通过列的索引获取（从 1 开始）
    int id = rs.getInt(1);
    String name = rs.getString(2);
}
```

**常用 getXXX 方法：**

| 方法 | 说明 |
|------|------|
| `getInt(String columnLabel)` | 按列名获取 int |
| `getInt(int columnIndex)` | 按列索引获取 int |
| `getString(String columnLabel)` | 按列名获取 String |
| `getDouble(String columnLabel)` | 按列名获取 double |
| `getDate(String columnLabel)` | 按列名获取 Date |
| `getObject(String columnLabel)` | 按列名获取 Object |

### 8.2 ResultSetMetaData 元数据

`ResultSetMetaData` 可获取结果集的元信息（列数、列名、列类型等）。

```java
ResultSet rs = ps.executeQuery();
ResultSetMetaData metaData = rs.getMetaData();

// 获取列数
int columnCount = metaData.getColumnCount();

// 遍历列信息
for (int i = 1; i <= columnCount; i++) {
    String columnName = metaData.getColumnName(i);       // 列名
    String columnLabel = metaData.getColumnLabel(i);     // 列别名
    String columnTypeName = metaData.getColumnTypeName(i); // 列类型名
    int columnType = metaData.getColumnType(i);          // 列类型常量
    int precision = metaData.getPrecision(i);            // 精度
    int scale = metaData.getScale(i);                    // 小数位数
    boolean isNullable = metaData.isNullable(i) == ResultSetMetaData.columnNullable; // 是否可为空
    
    System.out.println("列名：" + columnName + 
                       "，类型：" + columnTypeName + 
                       "，精度：" + precision);
}
```

### 8.3 通用查询方法

```java
/**
 * 通用查询：将 ResultSet 转换为 List<Map>
 */
public List<Map<String, Object>> query(String sql, Object... params) {
    List<Map<String, Object>> list = new ArrayList<>();
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        conn = DBUtil.getConnection();
        ps = conn.prepareStatement(sql);
        
        // 设置参数
        for (int i = 0; i < params.length; i++) {
            ps.setObject(i + 1, params[i]);
        }
        
        rs = ps.executeQuery();
        ResultSetMetaData metaData = rs.getMetaData();
        int columnCount = metaData.getColumnCount();
        
        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            for (int i = 1; i <= columnCount; i++) {
                String columnName = metaData.getColumnLabel(i);
                Object value = rs.getObject(i);
                row.put(columnName, value);
            }
            list.add(row);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        DBUtil.closeResource(rs, ps, conn);
    }
    return list;
}
```

---

## 九、JDBC 面试题

### 9.1 Statement 和 PreparedStatement 的区别

| 对比项 | Statement | PreparedStatement |
|--------|-----------|-------------------|
| SQL 注入 | 有风险 | 可防止 |
| 预编译 | 不预编译 | 预编译，可重复执行 |
| 性能 | 每次都编译 | 编译一次，多次执行 |
| 参数传递 | 字符串拼接 | `?` 占位符 + setXXX |
| 安全性 | 低 | 高 |

### 9.2 PreparedStatement 为什么能防止 SQL 注入

- PreparedStatement 使用**预编译**机制，SQL 语句结构在创建时已固定
- `?` 占位符只允许传递**数据值**，传递的内容不会被当作 SQL 语法解析
- 即使输入中包含 `' OR '1'='1` 等注入内容，也只会被当作普通字符串处理

### 9.3 PreparedStatement 的预编译过程

```
1. 创建 PreparedStatement 时，SQL 语句被传递给数据库解析
2. 数据库解析 SQL 结构（语法检查、权限检查、优化执行计划）
3. 后续执行时，只传递占位符参数
4. 批量插入 1000 条记录时，SQL 只被解析一次
5. 其余只需接受参数并执行，速度大为提高
```

---

> 💡 **小结**：本章深入讲解了 JDBC 的三种执行 SQL 对象。Statement 适用于静态 SQL，PreparedStatement 是最常用的方式（安全、高效），CallableStatement 用于调用存储过程。重点掌握了 PreparedStatement 的 CRUD 操作、获取自增主键、批量操作、分页查询。最后介绍了 ResultSet 结果集处理和 ResultSetMetaData 元数据的使用。
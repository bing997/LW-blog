---
title: MySQL存储引擎与索引优化
date: 2024-11-04T00:00:00+08:00
tags:
    - mysql
    - 教程
    - SQL
    - 索引
    - 存储引擎
categories: mysql
cover: /images/cover_mysql.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: "MySQL 存储引擎详解与索引优化指南，涵盖体系结构、InnoDB/MyISAM对比、索引数据结构、索引设计与优化原则、阿里巴巴索引规约。"
---

## 一、MySQL 体系结构

MySQL 整体分为四层架构：

```
┌─────────────────────────────────────────────┐
│              连接层（Connection Layer）        │
│  - 客户端连接处理                             │
│  - 授权认证                                  │
│  - 安全方案                                  │
├─────────────────────────────────────────────┤
│              服务层（Service Layer）           │
│  - SQL 接口                                  │
│  - 缓存查询                                  │
│  - SQL 分析与优化                            │
│  - 内置函数执行                              │
│  - 存储过程、存储函数                         │
├─────────────────────────────────────────────┤
│              引擎层（Storage Engine Layer）    │
│  - 数据存储与提取                            │
│  - 不同引擎不同功能                           │
│  - 通过 API 与服务器通信                      │
├─────────────────────────────────────────────┤
│              存储层（Storage Layer）           │
│  - 文件系统存储                              │
│  - 与存储引擎交互                            │
└─────────────────────────────────────────────┘
```

### 各层说明

| 层级 | 功能 | 核心组件 |
|------|------|---------|
| **连接层** | 处理客户端连接、授权认证、权限验证 | 连接池、认证模块 |
| **服务层** | SQL解析、优化、执行，跨引擎功能实现 | 解析器、优化器、执行器、缓存 |
| **引擎层** | 数据的存储和提取，不同引擎功能各异 | InnoDB、MyISAM、Memory 等 |
| **存储层** | 数据持久化到文件系统 | 数据文件、日志文件 |

---

## 二、存储引擎

### 2.1 常见存储引擎对比

MySQL 支持多种存储引擎，常用的有：

| 特性 | InnoDB | MyISAM | MEMORY | NDB |
|------|--------|--------|--------|-----|
| **事务支持** | 支持 | 不支持 | 不支持 | 支持 |
| **行级锁** | 支持 | 不支持（表锁） | 表锁 | 行级锁 |
| **外键** | 支持 | 不支持 | 不支持 | 支持（有限） |
| **崩溃恢复** | 支持（Redo Log） | 不支持 | 不支持 | 支持 |
| **全文索引** | 5.6+支持 | 支持 | 不支持 | 不支持 |
| **数据缓存** | 缓冲池 | 索引缓存 | 内存存储 | 内存存储 |
| **适用场景** | 高并发、事务型应用 | 读多写少、日志分析 | 临时表、缓存 | 分布式集群 |

### 2.2 InnoDB 存储引擎（推荐）

**特点：**
- 支持事务（ACID）
- 支持行级锁，并发性能好
- 支持外键约束
- 支持崩溃恢复（Redo Log + Undo Log）
- 使用聚簇索引，数据与主键索引存储在一起

```sql
-- 查看当前默认存储引擎
SHOW VARIABLES LIKE 'default_storage_engine';

-- 查看表的存储引擎
SHOW TABLE STATUS LIKE 'tb_customer';

-- 创建表时指定存储引擎
CREATE TABLE tb_order (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    total_amount DECIMAL(10,2),
    create_time DATETIME DEFAULT NOW()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 修改表的存储引擎
ALTER TABLE tb_order ENGINE=InnoDB;
```

### 2.3 MyISAM 存储引擎

**特点：**
- 不支持事务
- 表级锁，并发写入性能差
- 查询速度快，适合读多写少场景
- 支持全文索引
- 数据文件（.MYD）和索引文件（.MYI）分开存储

```sql
-- MyISAM 适用场景：日志表、统计表
CREATE TABLE tb_log (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    log_level VARCHAR(10),
    message TEXT,
    create_time DATETIME
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
```

### 2.4 存储引擎选择建议

| 场景 | 推荐引擎 | 原因 |
|------|---------|------|
| 电商订单、金融交易 | **InnoDB** | 需要事务支持 |
| 用户系统、权限管理 | **InnoDB** | 需要外键约束 |
| 日志记录、访问统计 | MyISAM / InnoDB | 读多写少，或需要事务 |
| 临时数据、会话缓存 | MEMORY | 内存存储，速度快 |
| 分布式数据库集群 | NDB | MySQL Cluster |

---

## 三、索引概述

### 3.1 索引的作用

索引是帮助 MySQL **高效获取数据**的**数据结构**。

**优点：**
- 通过索引列对数据进行排序，降低数据库的排序成本
- 大幅降低数据检索的 I/O 成本
- 加速表与表之间的连接（JOIN）
- 加速 GROUP BY 和 ORDER BY 操作

**缺点：**
- 索引提高了查询效率，但降低了 INSERT、DELETE、UPDATE 的效率
- 索引需要占用额外的存储空间
- 过多的索引会增加优化器选择索引的时间

```sql
-- 查看表的索引
SHOW INDEX FROM tb_customer;

-- 查看查询是否使用索引
EXPLAIN SELECT * FROM tb_customer WHERE name = '张三';
```

### 3.2 索引的数据结构

MySQL 索引主要使用 **B+Tree** 数据结构：

```
B+Tree 索引结构示意：

                    [10, 20, 30]
                   /    |     \
            [5,8,9] [15,18] [25,28] [35,40]
             / | \   / | \   / | \   / | \
           叶子节点（包含全部数据指针/数据）
           
特点：
1. 所有数据都存储在叶子节点
2. 叶子节点之间通过指针连接（双向链表）
3. 非叶子节点只存储索引键值，用于导航
4. 查找效率稳定：O(log n)
5. 支持范围查询和排序
```

**为什么用 B+Tree 而不是 B-Tree 或 Hash？**

| 数据结构 | 特点 | 适用场景 |
|---------|------|---------|
| **B-Tree** | 所有节点都存数据，查询效率不稳定 | 文件系统 |
| **B+Tree** | 只有叶子节点存数据，查询效率稳定，支持范围查询 | **MySQL 默认** |
| **Hash** | 等值查询 O(1)，不支持范围查询 | Memory 引擎 |
| **R-Tree** | 空间数据索引 | 地理信息数据 |

---

## 四、索引类型

### 4.1 按数据结构分类

| 索引类型 | 说明 | 适用场景 |
|---------|------|---------|
| **B+Tree 索引** | 默认索引类型，支持全值匹配、范围查询 | 绝大多数场景 |
| **Hash 索引** | 等值查询极快，不支持范围查询 | Memory 引擎 |
| **Full-Text 索引** | 全文检索 | 大文本字段搜索 |
| **R-Tree 索引** | 空间索引 | 地理坐标数据 |

### 4.2 按功能分类

| 索引类型 | 关键字 | 特点 | 数量限制 |
|---------|--------|------|---------|
| **主键索引** | PRIMARY KEY | 唯一标识每行记录，非空且唯一 | 1个 |
| **唯一索引** | UNIQUE | 索引列值必须唯一，允许NULL | 多个 |
| **普通索引** | INDEX | 无限制，仅加速查询 | 多个 |
| **组合索引** | INDEX(a,b,c) | 多列联合索引，遵循最左前缀 | 多个 |
| **全文索引** | FULLTEXT | 针对文本内容的关键词检索 | 多个 |

### 4.3 按存储方式分类

| 索引类型 | 说明 | 存储 |
|---------|------|------|
| **聚簇索引** | 数据与索引存储在一起 | 叶子节点存数据行 |
| **非聚簇索引** | 数据与索引分开存储 | 叶子节点存主键值 |

**InnoDB 的聚簇索引：**
- 主键索引就是聚簇索引，叶子节点存储完整数据行
- 二级索引（非主键索引）的叶子节点存储主键值
- 查询二级索引时，可能需要回表查询（根据主键值再去聚簇索引查数据）

```sql
-- 聚簇索引示意
-- 主键索引 B+Tree
-- 叶子节点: [id=1] -> 完整数据行 {id:1, name:'张三', age:25...}
-- 叶子节点: [id=2] -> 完整数据行 {id:2, name:'李四', age:30...}

-- 二级索引（如 name 索引）
-- 叶子节点: ['张三'] -> id=1
-- 叶子节点: ['李四'] -> id=2
-- 需要回表：根据 id=1 再去主键索引查完整数据
```

---

## 五、索引的创建与管理

### 5.1 创建索引

```sql
-- 方式1：CREATE INDEX
CREATE INDEX idx_name ON tb_customer(name);

-- 方式2：ALTER TABLE ADD INDEX
ALTER TABLE tb_customer ADD INDEX idx_name(name);

-- 创建唯一索引
CREATE UNIQUE INDEX idx_tel ON tb_customer(tel);
ALTER TABLE tb_customer ADD UNIQUE INDEX idx_tel(tel);

-- 创建组合索引
ALTER TABLE tb_customer ADD INDEX idx_name_age(name, age);

-- 创建前缀索引（长文本字段）
ALTER TABLE tb_customer ADD INDEX idx_address(address(20));

-- 创建主键索引
ALTER TABLE tb_customer ADD PRIMARY KEY(id);
```

### 5.2 查看与删除索引

```sql
-- 查看表的所有索引
SHOW INDEX FROM tb_customer;

-- 查看索引大小
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    ROUND(SUM(DATA_LENGTH)/1024/1024, 2) AS '索引大小(MB)'
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = '数据库名'
GROUP BY TABLE_NAME, INDEX_NAME;

-- 删除索引
DROP INDEX idx_name ON tb_customer;
ALTER TABLE tb_customer DROP INDEX idx_name;

-- 删除主键索引
ALTER TABLE tb_customer DROP PRIMARY KEY;
```

### 5.3 索引创建示例

```sql
-- 创建员工表并建立合理索引
CREATE TABLE tb_employee (
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT COMMENT '员工编号',
    name VARCHAR(20) NOT NULL COMMENT '姓名',
    department_id INT NOT NULL COMMENT '部门ID',
    position VARCHAR(20) COMMENT '职位',
    salary DECIMAL(10,2) COMMENT '工资',
    email VARCHAR(50) COMMENT '邮箱',
    phone CHAR(11) COMMENT '手机号',
    hire_date DATE COMMENT '入职日期',
    status TINYINT DEFAULT 1 COMMENT '状态:1在职 0离职',
    
    -- 索引定义
    INDEX idx_department(department_id),           -- 部门查询
    INDEX idx_name(name),                          -- 姓名查询
    INDEX idx_salary(salary),                      -- 工资范围查询
    INDEX idx_hire_date(hire_date),                -- 入职日期范围
    UNIQUE INDEX idx_email(email),                 -- 邮箱唯一
    UNIQUE INDEX idx_phone(phone),                 -- 手机号唯一
    INDEX idx_dept_salary(department_id, salary)   -- 组合索引：部门+工资
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='员工表';
```

---

## 六、索引设计原则

### 6.1 核心设计原则

| 设计原则 | 场景案例 | 实现方法 | 注意事项 |
|---------|---------|---------|---------|
| **选择区分度高的列** | 用户表手机号唯一性达95%+ | `ALTER TABLE users ADD UNIQUE INDEX idx_mobile(mobile)` | 避免在低区分度字段（如性别）建索引 |
| **联合索引遵循最左前缀** | 高频查询 `WHERE age>20 AND city='北京'` | `ALTER TABLE users ADD INDEX idx_age_city(age, city)` | 若单独查询city需调整索引顺序 |
| **避免索引列参与计算** | 按年份过滤订单 | 优化为 `WHERE create_time BETWEEN '2023-01-01' AND '2023-12-31'` | 使用函数或计算会导致索引失效 |
| **覆盖索引减少回表** | 查询用户姓名 | 建立覆盖索引 `(id, name)` | 避免 `SELECT *` |
| **外键字段必建索引** | 订单表关联用户 | `ALTER TABLE orders ADD INDEX idx_user_id(user_id)` | 防止关联查询时全表扫描 |
| **前缀索引优化长文本** | 文章内容字段 | `ALTER TABLE articles ADD INDEX idx_content(content(20))` | 需平衡索引长度与查询效率 |
| **控制单表索引数量** | 用户表已有5个索引 | 通过慢查询日志分析必要性，删除冗余索引 | 索引过多影响写性能，建议不超过5个 |
| **业务逻辑驱动设计** | 商品按价格排序 | `ALTER TABLE products ADD INDEX idx_price(price)` | 排序+过滤时优先满足过滤字段 |

### 6.2 最左前缀法则

如果索引了多列（联合索引），查询必须**从索引的最左列开始，并且不跳过索引中的列**。

```sql
-- 创建联合索引 (a, b, c)
ALTER TABLE tb_test ADD INDEX idx_abc(a, b, c);

-- ✅ 完全使用索引
WHERE a = 1 AND b = 2 AND c = 3
WHERE a = 1 AND b = 2
WHERE a = 1

-- ⚠️ 部分使用索引（只用到 a）
WHERE a = 1 AND c = 3

-- ❌ 索引失效（没用到最左列 a）
WHERE b = 2 AND c = 3
WHERE b = 2

-- ⚠️ 范围查询后索引失效
WHERE a = 1 AND b > 2 AND c = 3  -- 只用到了 a, b
```

**最左前缀法则图解：**

```
联合索引 idx_abc(a, b, c) 的 B+Tree 结构：

        [a=1, b=2, c=3]
       /       |       \
   [a=1]     [a=2]     [a=3]
   / | \     / | \     / | \
[b=1][b=2][b=3] ...

查询条件必须从最左列 a 开始匹配，
否则无法利用索引树的有序性
```

### 6.3 索引失效的常见场景

| 索引失效场景 | 示例 | 原理分析 |
|-----------|------|---------|
| 对索引列进行运算/函数操作 | `WHERE YEAR(create_time) = 2023` | 运算破坏索引的有序性 |
| 隐式类型转换 | `WHERE varchar_col = 100` | MySQL 需类型转换，破坏索引匹配 |
| LIKE 左模糊匹配 | `WHERE name LIKE '%张三'` | B+树按最左字符排序，前导通配符无法利用索引 |
| OR 连接非索引条件 | `WHERE id=1 OR age>20`（age无索引） | 优化器判定全表扫描成本更低 |
| 违反最左前缀原则 | 索引(a,b,c)，查询 `WHERE b=2` | 缺失最左列无法缩小扫描范围 |
| 使用否定条件 | `WHERE status != 'active'` | NOT、<> 需要扫描大部分数据 |
| 数据分布倾斜 | 索引列95%的值相同 | 区分度过低，优化器选择全表扫描 |
| JOIN 字段类型不匹配 | `ON t1.int_col = t2.varchar_col` | 类型转换导致无法使用索引 |

```sql
-- ❌ 索引失效示例
SELECT * FROM employees WHERE YEAR(hire_date) = 2023;  -- 函数操作
SELECT * FROM employees WHERE salary * 12 > 100000;     -- 索引列计算
SELECT * FROM employees WHERE name LIKE '%张%';          -- 左模糊

-- ✅ 优化后
SELECT * FROM employees 
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';  -- 范围查询
SELECT * FROM employees WHERE salary > 8333.33;          -- 反向计算
SELECT * FROM employees WHERE name LIKE '张%';           -- 右模糊
```

---

## 七、阿里巴巴索引规约

### 7.1 强制规约

1. **【强制】** 业务上具有唯一特性的字段，即使是多个字段的组合，也必须建成唯一索引。
   > 说明：不要以为唯一索引影响了 insert 速度，这个速度损耗可以忽略，但提高查找速度是明显的；另外，即使在应用层做了非常完善的校验控制，只要没有唯一索引，根据墨菲定律，必然有脏数据产生。

2. **【强制】** 超过三个表禁止 JOIN。需要 JOIN 的字段，数据类型必须绝对一致；多表关联查询时，保证被关联的字段需要有索引。
   > 说明：即使双表 JOIN 也要注意表索引、SQL 性能。

3. **【强制】** 在 VARCHAR 字段上建立索引时，必须指定索引长度，没必要对全字段建立索引，根据实际文本区分度决定索引长度即可。
   > 说明：索引的长度与区分度是一对矛盾体，一般对字符串类型数据，长度为 20 的索引，区分度会高达 90%以上，可以使用 `count(distinct left(列名, 索引长度))/count(*)` 的区分度来确定。

4. **【强制】** 页面搜索严禁左模糊或者全模糊，如果需要请走搜索引擎来解决。
   > 说明：索引文件具有 B-Tree 的最左前缀匹配特性，如果左边的值未确定，那么无法使用此索引。

### 7.2 推荐规约

5. **【推荐】** 如果有 ORDER BY 的场景，请注意利用索引的有序性。ORDER BY 最后的字段是组合索引的一部分，并且放在索引组合顺序的最后，避免出现 file_sort 的情况。
   - 正例：`WHERE a=? AND b=? ORDER BY c;` 索引：`a_b_c`
   - 反例：`WHERE a>10 ORDER BY b;` 索引 `a_b` 无法排序。

6. **【推荐】** 利用覆盖索引来进行查询操作，避免回表。
   > 说明：能够建立索引的种类分为主键索引、唯一索引、普通索引三种，而覆盖索引只是一种查询效果，用 explain 的结果，extra 列会出现：`using index`。

7. **【推荐】** 利用延迟关联或者子查询优化超多分页场景。
   - 正例：先快速定位需要获取的 id 段，然后再关联：
   ```sql
   SELECT a.* FROM 表1 a, 
   (SELECT id FROM 表1 WHERE 条件 LIMIT 100000, 20) b 
   WHERE a.id = b.id;
   ```

8. **【推荐】** SQL 性能优化的目标：至少要达到 range 级别，要求是 ref 级别，如果可以是 consts 最好。
   - `consts`：单表中最多只有一个匹配行（主键或者唯一索引）
   - `ref`：使用普通索引
   - `range`：对索引进行范围检索
   - `index`：索引物理文件全扫描，速度非常慢

9. **【推荐】** 建组合索引的时候，区分度最高的在最左边。
   - 正例：如果 `WHERE a=? AND b=?`，a 列的几乎接近于唯一值，那么只需要单建 `idx_a` 索引即可。
   - 说明：存在非等号和等号混合时，把等号条件的列前置。如 `WHERE c>? AND d=?`，即使 c 的区分度更高，也必须把 d 放在索引的最前列，即索引 `idx_d_c`。

10. **【推荐】** 防止因字段类型不同造成的隐式转换，导致索引失效。

### 7.3 参考规约

11. **【参考】** 创建索引时避免有如下极端误解：
    - 宁滥勿缺：认为一个查询就需要建一个索引
    - 宁缺勿滥：认为索引会消耗空间、严重拖慢记录的更新以及行的新增速度
    - 抵制唯一索引：认为业务的唯一性一律需要在应用层通过"先查后插"方式解决

---

## 八、索引优化实战

### 8.1 使用 EXPLAIN 分析查询

```sql
-- 查看查询执行计划
EXPLAIN SELECT * FROM tb_employee WHERE name = '张三';

-- 重点关注字段：
-- id: 查询标识符
-- select_type: 查询类型（SIMPLE, PRIMARY, SUBQUERY...）
-- table: 访问的表
-- type: 访问类型（system > const > eq_ref > ref > range > index > ALL）
-- possible_keys: 可能使用的索引
-- key: 实际使用的索引
-- key_len: 使用的索引长度
-- rows: 扫描的行数（越少越好）
-- Extra: 额外信息（Using index, Using where, Using filesort...）
```

**type 访问类型（性能从好到差）：**

| type | 说明 | 示例 |
|------|------|------|
| system | 表只有一行 | 系统表 |
| const | 主键或唯一索引等值查询 | `WHERE id = 1` |
| eq_ref | JOIN 时主键或唯一索引关联 | `t1 JOIN t2 ON t1.id = t2.id` |
| ref | 普通索引等值查询 | `WHERE name = '张三'` |
| range | 索引范围查询 | `WHERE id BETWEEN 1 AND 100` |
| index | 索引全扫描 | `SELECT id FROM table` |
| ALL | 全表扫描 | 无索引或索引失效 |

### 8.2 索引优化案例

```sql
-- 案例1：覆盖索引优化
-- 原查询（回表）
EXPLAIN SELECT * FROM tb_employee WHERE department_id = 1;

-- 优化：只查询索引列（覆盖索引）
EXPLAIN SELECT id, department_id FROM tb_employee WHERE department_id = 1;
-- Extra: Using index（无需回表）

-- 案例2：最左前缀优化
-- 原查询（索引失效）
EXPLAIN SELECT * FROM tb_employee 
WHERE salary > 5000 AND department_id = 1;
-- 索引 idx_dept_salary(department_id, salary) 无法完全使用

-- 优化：调整WHERE条件顺序
EXPLAIN SELECT * FROM tb_employee 
WHERE department_id = 1 AND salary > 5000;
-- type: range, key: idx_dept_salary

-- 案例3：分页优化
-- 原查询（深分页性能差）
SELECT * FROM tb_employee ORDER BY id LIMIT 100000, 10;

-- 优化：延迟关联
SELECT e.* FROM tb_employee e
INNER JOIN (
    SELECT id FROM tb_employee ORDER BY id LIMIT 100000, 10
) t ON e.id = t.id;

-- 案例4：ORDER BY 优化
-- 原查询（Using filesort）
EXPLAIN SELECT * FROM tb_employee 
WHERE department_id = 1 ORDER BY salary;

-- 优化：创建包含排序字段的联合索引
ALTER TABLE tb_employee ADD INDEX idx_dept_salary(department_id, salary);
-- 再次 EXPLAIN，Extra 不再出现 Using filesort
```

---

> 💡 **小结**：本章详细介绍了 MySQL 的存储引擎（InnoDB/MyISAM 对比）和索引优化知识。存储引擎选择 InnoDB 作为默认引擎；索引设计需遵循最左前缀法则、选择区分度高的列、避免索引失效场景；同时参考阿里巴巴索引规约，合理使用 EXPLAIN 分析并优化查询性能。

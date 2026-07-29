---
title: MySQL数据库操作实战
date: 2024-11-02T00:00:00+08:00
tags:
    - mysql
    - 教程
    - SQL
categories: mysql
cover: /images/cover_mysql.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: "MySQL 数据库操作实战教程，涵盖标识符命名规范、SQL语句、数据类型、数据库与表的操作，每个知识点配有完整的SQL代码示例。"
---

## 一、标识符命名规范

### 1.1 基本规则

MySQL 标识符（数据库名、表名、字段名等）的命名遵循以下规则：

| 规则 | 说明 | 示例 |
|------|------|------|
| **不区分大小写** | MySQL 在 Windows 上不区分大小写，Linux 区分 | `show databases;` = `SHOW DATABASES;` |
| **不能包含空格** | 标识符中间不能有空格 | ❌ `student info` → ✅ `student_info` |
| **不能使用关键字** | 避免使用 MySQL 保留关键字 | ❌ `order` → ✅ `` `order` `` |
| **可以使用反引号** | 用 `` ` `` 包裹的标识符可包含特殊字符 | `` `order` ``、`` `user-name` `` |
| **建议小写+下划线** | 统一命名风格 | `user_info`、`create_time` |

### 1.2 关键字与反引号的使用

```sql
-- 错误：order 是 MySQL 关键字
create table order (...);  -- ❌ 报错

-- 正确：使用反引号包裹
create table `order` (...);  -- ✅ 正确

-- 建议：避免使用关键字作为标识符
create table `orders` (...);  -- ✅ 更好的做法
```

### 1.3 别名命名规范

```sql
-- AS 可以省略
select id as "编号", `name` as "姓名" from t_stu;

-- 省略 AS 和引号（别名无空格时）
select id 编号, `name` 姓名 from t_stu;

-- 错误：别名包含空格时必须加引号
select id as 编 号 from t_stu;  -- ❌ 报错

-- 正确：别名包含空格时加双引号
select id as "编 号" from t_stu;  -- ✅ 正确
```

### 1.4 命名规范总结

| 对象 | 规范 | 示例 |
|------|------|------|
| 数据库名 | 小写，下划线分隔 | `as2506_db`、`my_shop` |
| 表名 | 小写，下划线分隔，复数形式 | `user_infos`、`order_items` |
| 字段名 | 小写，下划线分隔 | `create_time`、`update_time` |
| 索引名 | `idx_` + 字段名 | `idx_name`、`idx_create_time` |
| 主键名 | 统一用 `id` | `id` |
| 外键名 | `fk_` + 表名 + `_id` | `fk_user_id` |

---

## 二、操作数据库

### 2.1 创建数据库

```sql
-- 基本语法
CREATE DATABASE 数据库名;

-- 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS as2506_db;

-- 创建数据库并指定字符集
CREATE DATABASE as2506_db CHARACTER SET 'utf8mb4';

-- 创建数据库并指定字符集和排序规则（推荐）
CREATE DATABASE as2506_db
  CHARACTER SET 'utf8mb4'
  COLLATE 'utf8mb4_general_ci';
```

**常用字符集和排序规则：**

| 字符集 | 排序规则 | 说明 |
|--------|---------|------|
| utf8mb4 | utf8mb4_general_ci | 不区分大小写（推荐） |
| utf8mb4 | utf8mb4_unicode_ci | 基于 Unicode 排序 |
| utf8mb4 | utf8mb4_bin | 二进制比较，区分大小写 |

### 2.2 查看数据库

```sql
-- 查看所有数据库
SHOW DATABASES;

-- 查看当前使用的数据库
SELECT DATABASE();

-- 查看数据库创建语句
SHOW CREATE DATABASE as2506_db;

-- 查看数据库的字符集
SHOW VARIABLES LIKE 'character_set_database';
```

### 2.3 使用数据库

```sql
-- 切换数据库
USE as2506_db;

-- 查看当前数据库中的所有表
SHOW TABLES;
```

### 2.4 修改数据库

```sql
-- 修改数据库字符集
ALTER DATABASE as2506_db CHARACTER SET utf8mb4;
```

### 2.5 删除数据库

```sql
-- 删除数据库（危险操作！）
DROP DATABASE as2506_db;

-- 安全删除：如果存在才删除
DROP DATABASE IF EXISTS as2506_db;
```

> ⚠️ **警告**：删除数据库会删除其中的所有表和数据，操作前请务必备份！

---

## 三、MySQL 数据类型详解

### 3.1 整数类型

| 类型 | 大小 | 有符号范围 | 无符号范围 | 用途 |
|------|------|-----------|-----------|------|
| TINYINT | 1 字节 | -128 ~ 127 | 0 ~ 255 | 小整数值，如状态(0/1) |
| SMALLINT | 2 字节 | -32768 ~ 32767 | 0 ~ 65535 | 较小整数 |
| MEDIUMINT | 3 字节 | -8388608 ~ 8388607 | 0 ~ 16777215 | 中等整数 |
| **INT** | 4 字节 | -2^31 ~ 2^31-1 | 0 ~ 2^32-1 | 常用整数 |
| **BIGINT** | 8 字节 | -2^63 ~ 2^63-1 | 0 ~ 2^64-1 | 大整数，如主键 |

```sql
-- 无符号整数：只能存储正数，范围更大
CREATE TABLE example (
    id INT UNSIGNED PRIMARY KEY,        -- 0 ~ 4294967295
    age TINYINT UNSIGNED,               -- 0 ~ 255
    count BIGINT UNSIGNED               -- 0 ~ 18446744073709551615
);
```

### 3.2 浮点与定点类型

| 类型 | 大小 | 说明 | 用途 |
|------|------|------|------|
| FLOAT | 4 字节 | 单精度浮点数 | 科学计算 |
| DOUBLE | 8 字节 | 双精度浮点数 | 高精度计算 |
| **DECIMAL(M,D)** | M+2 字节 | 定点数，精确值 | **金额、财务数据** |

```sql
-- DECIMAL(M, D)：M 是总位数，D 是小数位数
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    price DECIMAL(10, 2),       -- 总共10位，小数2位，如 99999999.99
    weight DECIMAL(5, 3)        -- 总共5位，小数3位，如 99.999
);
```

> 💡 **建议**：金额字段务必使用 DECIMAL，避免浮点数精度问题。

### 3.3 字符串类型

| 类型 | 大小 | 说明 | 用途 |
|------|------|------|------|
| CHAR(n) | n 字节 | 定长字符串 | 固定长度，如手机号、身份证号 |
| **VARCHAR(n)** | 实际长度+1 | 变长字符串 | 常用，如姓名、地址 |
| TINYTEXT | 255 字节 | 短文本 | 简短描述 |
| TEXT | 64KB | 文本 | 文章内容 |
| MEDIUMTEXT | 16MB | 中等文本 | 长文章 |
| LONGTEXT | 4GB | 长文本 | 超大文本 |

```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,      -- 姓名，变长
    phone CHAR(11),                 -- 手机号，定长
    email VARCHAR(50),              -- 邮箱，变长
    bio TEXT,                       -- 个人简介，长文本
    avatar_url VARCHAR(255)         -- 头像URL
);
```

**CHAR vs VARCHAR 对比：**

| 特性 | CHAR | VARCHAR |
|------|------|---------|
| 存储方式 | 固定长度 | 变长 |
| 性能 | 查询更快 | 查询稍慢 |
| 空间 | 可能浪费空间 | 节省空间 |
| 适用场景 | 固定长度数据 | 长度变化大的数据 |

### 3.4 日期时间类型

| 类型 | 大小 | 格式 | 范围 | 用途 |
|------|------|------|------|------|
| **DATE** | 3 字节 | YYYY-MM-DD | 1000-01-01 ~ 9999-12-31 | 日期 |
| TIME | 3 字节 | HH:MM:SS | -838:59:59 ~ 838:59:59 | 时间 |
| YEAR | 1 字节 | YYYY | 1901 ~ 2155 | 年份 |
| **DATETIME** | 8 字节 | YYYY-MM-DD HH:MM:SS | 1000-01-01 ~ 9999-12-31 | 日期时间 |
| **TIMESTAMP** | 4 字节 | YYYY-MM-DD HH:MM:SS | 1970-01-01 ~ 2038-01-19 | 时间戳 |

```sql
CREATE TABLE events (
    id INT PRIMARY KEY,
    event_date DATE,                        -- 日期
    start_time TIME,                        -- 时间
    created_at DATETIME DEFAULT NOW(),      -- 创建时间
    updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()  -- 自动更新时间
);
```

**DATETIME vs TIMESTAMP 对比：**

| 特性 | DATETIME | TIMESTAMP |
|------|----------|-----------|
| 范围 | 更大 | 较小（到2038年） |
| 时区 | 不转换 | 自动转换时区 |
| 空间 | 8 字节 | 4 字节 |
| 自动更新 | 不支持 | 支持 `ON UPDATE` |

### 3.5 枚举与集合类型

```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(20),
    -- 枚举：只能取列出的值之一
    gender ENUM('男', '女') DEFAULT '男',
    -- 集合：可以取多个值
    hobbies SET('读书', '运动', '音乐', '编程') DEFAULT '读书'
);

-- 插入数据
INSERT INTO users (name, gender, hobbies) VALUES
('张三', '男', '读书,编程'),
('李四', '女', '运动,音乐');
```

### 3.6 JSON 类型（MySQL 5.7+）

```sql
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    -- JSON 类型存储复杂数据
    attributes JSON
);

-- 插入 JSON 数据
INSERT INTO products (id, name, attributes) VALUES
(1, 'iPhone 15', '{"color": "black", "storage": "256GB", "screen": "6.1\""}');

-- 查询 JSON 字段
SELECT name, JSON_EXTRACT(attributes, '$.color') AS color
FROM products;

-- 更新 JSON 字段
UPDATE products
SET attributes = JSON_SET(attributes, '$.price', 5999)
WHERE id = 1;
```

### 3.7 数据类型选择建议

| 场景 | 推荐类型 | 说明 |
|------|---------|------|
| 主键 ID | BIGINT UNSIGNED AUTO_INCREMENT | 避免溢出 |
| 状态/开关 | TINYINT(1) | 0 和 1 |
| 年龄 | TINYINT UNSIGNED | 0-255 |
| 金额/价格 | DECIMAL(10,2) | 精确计算 |
| 手机号 | CHAR(11) | 固定长度 |
| 邮箱 | VARCHAR(50) | 长度变化 |
| 姓名 | VARCHAR(20) | 一般长度 |
| 地址 | VARCHAR(100) | 较长文本 |
| 文章内容 | TEXT | 长文本 |
| 创建时间 | DATETIME / TIMESTAMP | 带日期和时间 |
| 性别 | ENUM('男','女') 或 TINYINT | 枚举或数字 |

---

## 四、操作表

### 4.1 创建表

```sql
-- 基本语法
CREATE TABLE [IF NOT EXISTS] 表名 (
    字段名 数据类型 [约束] [注释],
    字段名 数据类型 [约束] [注释],
    ...
    [表级约束]
) [表选项];
```

#### 完整示例：创建顾客表

```sql
CREATE TABLE IF NOT EXISTS tb_customer (
    -- 主键：顾客编号
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT COMMENT '顾客编号',

    -- 姓名：非空
    name VARCHAR(20) NOT NULL COMMENT '顾客姓名',

    -- 生日：允许为空
    birthday DATE COMMENT '顾客生日',

    -- 性别：枚举类型，默认男
    sex ENUM('男', '女') DEFAULT '男' COMMENT '顾客性别',

    -- 手机号：唯一且非空
    tel CHAR(11) UNIQUE NOT NULL COMMENT '手机号码',

    -- 收货地址
    address VARCHAR(100) COMMENT '收货地址',

    -- VIP状态：默认0（否）
    is_vip TINYINT UNSIGNED DEFAULT 0 COMMENT 'VIP: 1是 0否',

    -- 备注
    remark VARCHAR(100) COMMENT '备注信息',

    -- 创建时间
    create_time DATETIME DEFAULT NOW() COMMENT '创建时间',

    -- 修改时间：自动更新
    update_time DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='顾客信息表';
```

#### 表选项说明

| 选项 | 说明 | 常用值 |
|------|------|--------|
| ENGINE | 存储引擎 | InnoDB（推荐）、MyISAM |
| CHARSET | 字符集 | utf8mb4 |
| COLLATE | 排序规则 | utf8mb4_general_ci |
| COMMENT | 表注释 | 描述表用途 |
| AUTO_INCREMENT | 自增起始值 | 1 |

### 4.2 查看表结构

```sql
-- 查看表结构
DESC tb_customer;
DESCRIBE tb_customer;

-- 查看创建表的SQL语句
SHOW CREATE TABLE tb_customer;

-- 查看表中所有列的详细信息
SHOW COLUMNS FROM tb_customer;

-- 查看当前数据库中所有表
SHOW TABLES;
```

### 4.3 修改表结构

```sql
-- 添加列
ALTER TABLE tb_customer ADD COLUMN email VARCHAR(50) COMMENT '邮箱';

-- 添加列到指定位置
ALTER TABLE tb_customer ADD COLUMN nickname VARCHAR(20) COMMENT '昵称' AFTER name;

-- 修改列类型
ALTER TABLE tb_customer MODIFY COLUMN remark VARCHAR(200) COMMENT '备注信息';

-- 修改列名和类型
ALTER TABLE tb_customer CHANGE COLUMN remark notes VARCHAR(200) COMMENT '备注';

-- 删除列
ALTER TABLE tb_customer DROP COLUMN notes;

-- 添加主键
ALTER TABLE tb_customer ADD PRIMARY KEY (id);

-- 删除主键
ALTER TABLE tb_customer DROP PRIMARY KEY;

-- 添加唯一约束
ALTER TABLE tb_customer ADD UNIQUE INDEX uk_email (email);

-- 删除唯一约束
ALTER TABLE tb_customer DROP INDEX uk_email;

-- 添加外键
ALTER TABLE tb_order ADD CONSTRAINT fk_customer_id
    FOREIGN KEY (customer_id) REFERENCES tb_customer(id);

-- 删除外键
ALTER TABLE tb_order DROP FOREIGN KEY fk_customer_id;

-- 修改表名
ALTER TABLE tb_customer RENAME TO tb_customers;
RENAME TABLE tb_customers TO tb_customer;

-- 修改表字符集
ALTER TABLE tb_customer CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

### 4.4 删除表

```sql
-- 删除表（删除表结构和数据）
DROP TABLE tb_customer;

-- 安全删除：如果存在才删除
DROP TABLE IF EXISTS tb_customer;

-- 截断表：删除所有数据，保留表结构，重置自增ID
TRUNCATE TABLE tb_customer;
```

> ⚠️ **DROP vs TRUNCATE vs DELETE 对比：**
>
> | 操作 | 删除内容 | 自增ID | 回滚 | 速度 |
> |------|---------|--------|------|------|
> | DROP | 表结构+数据 | - | 不可 | 最快 |
> | TRUNCATE | 全部数据 | 重置 | 不可 | 快 |
> | DELETE | 指定数据 | 不重置 | 可以 | 慢 |

### 4.5 复制表

```sql
-- 方式1：复制表结构（不复制数据）
CREATE TABLE tb_customer_backup LIKE tb_customer;

-- 方式2：复制表结构和数据
CREATE TABLE tb_customer_backup AS SELECT * FROM tb_customer;

-- 方式3：只复制部分列和数据
CREATE TABLE tb_customer_simple AS
SELECT id, name, tel FROM tb_customer WHERE is_vip = 1;
```

---

## 五、数据操作：增删改查（CRUD）

### 5.1 插入数据（INSERT）

```sql
-- 插入单条数据
INSERT INTO tb_customer (name, birthday, sex, tel, address)
VALUES ('张三', '1990-05-20', '男', '13800138000', '北京市');

-- 插入多条数据
INSERT INTO tb_customer (name, birthday, sex, tel, address)
VALUES
    ('李四', '1992-08-15', '女', '13800138001', '上海市'),
    ('王五', '1988-03-10', '男', '13800138002', '广州市'),
    ('赵六', '1995-11-25', '女', '13800138003', '深圳市');

-- 插入时忽略重复（tel 有唯一约束）
INSERT IGNORE INTO tb_customer (name, tel)
VALUES ('张三', '13800138000');  -- 如果 tel 已存在则忽略

-- 存在则更新，不存在则插入
INSERT INTO tb_customer (id, name, tel)
VALUES (1, '张三', '13800138000')
ON DUPLICATE KEY UPDATE name = '张三', update_time = NOW();

-- 从其他表插入数据
INSERT INTO tb_customer_backup (name, tel)
SELECT name, tel FROM tb_customer WHERE is_vip = 1;
```

### 5.2 查询数据（SELECT）

```sql
-- 查询所有列
SELECT * FROM tb_customer;

-- 查询指定列
SELECT id, name, tel FROM tb_customer;

-- 查询并起别名
SELECT id AS "编号", name AS "姓名", tel AS "手机号" FROM tb_customer;

-- 查询并去重
SELECT DISTINCT sex FROM tb_customer;

-- 带条件的查询
SELECT * FROM tb_customer WHERE is_vip = 1;
SELECT * FROM tb_customer WHERE age > 18 AND sex = '女';
SELECT * FROM tb_customer WHERE name LIKE '张%';  -- 模糊查询
SELECT * FROM tb_customer WHERE id IN (1, 2, 3);
SELECT * FROM tb_customer WHERE birthday BETWEEN '1990-01-01' AND '1995-12-31';

-- 排序
SELECT * FROM tb_customer ORDER BY create_time DESC;  -- 降序
SELECT * FROM tb_customer ORDER BY name ASC, id DESC; -- 多字段排序

-- 分页查询
SELECT * FROM tb_customer LIMIT 10;           -- 前10条
SELECT * FROM tb_customer LIMIT 0, 10;        -- 第1页，每页10条
SELECT * FROM tb_customer LIMIT 10 OFFSET 20; -- 跳过20条，取10条

-- 聚合查询
SELECT COUNT(*) FROM tb_customer;                    -- 总记录数
SELECT COUNT(*) FROM tb_customer WHERE is_vip = 1;   -- VIP人数
SELECT AVG(age) FROM tb_customer;                    -- 平均年龄
SELECT MAX(birthday), MIN(birthday) FROM tb_customer; -- 最大/最小生日
SELECT sex, COUNT(*) FROM tb_customer GROUP BY sex;  -- 按性别分组统计

-- 分组过滤
SELECT sex, COUNT(*) AS count FROM tb_customer
GROUP BY sex HAVING count > 5;

-- 连接查询
-- 内连接
SELECT c.name, o.order_no, o.amount
FROM tb_customer c
INNER JOIN tb_order o ON c.id = o.customer_id;

-- 左连接
SELECT c.name, o.order_no
FROM tb_customer c
LEFT JOIN tb_order o ON c.id = o.customer_id;
```

### 5.3 更新数据（UPDATE）

```sql
-- 更新单列
UPDATE tb_customer SET is_vip = 1 WHERE id = 1;

-- 更新多列
UPDATE tb_customer
SET name = '张三丰', address = '北京市海淀区', update_time = NOW()
WHERE id = 1;

-- 批量更新
UPDATE tb_customer SET is_vip = 1 WHERE create_time < '2024-01-01';

-- 使用子查询更新
UPDATE tb_customer SET remark = 'VIP客户'
WHERE id IN (SELECT customer_id FROM tb_order WHERE amount > 10000);

-- 更新并限制数量
UPDATE tb_customer SET remark = '新用户' WHERE is_vip = 0 LIMIT 100;
```

> ⚠️ **警告**：UPDATE 语句必须加 WHERE 条件，否则将更新所有记录！

### 5.4 删除数据（DELETE）

```sql
-- 删除指定记录
DELETE FROM tb_customer WHERE id = 1;

-- 删除多条记录
DELETE FROM tb_customer WHERE is_vip = 0 AND create_time < '2023-01-01';

-- 删除所有记录（保留表结构）
DELETE FROM tb_customer;

-- 删除并限制数量
DELETE FROM tb_customer WHERE is_vip = 0 LIMIT 100;

-- 清空表（更快，不可回滚）
TRUNCATE TABLE tb_customer;
```

> ⚠️ **警告**：DELETE 语句必须加 WHERE 条件，否则将删除所有记录！

---

## 六、约束详解

### 6.1 主键约束（PRIMARY KEY）

```sql
-- 单列主键
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20)
);

-- 多列联合主键
CREATE TABLE scores (
    student_id INT,
    course_id INT,
    score DECIMAL(5,2),
    PRIMARY KEY (student_id, course_id)
);

-- 表级约束定义主键
CREATE TABLE users (
    id INT AUTO_INCREMENT,
    name VARCHAR(20),
    PRIMARY KEY (id)
);
```

### 6.2 外键约束（FOREIGN KEY）

```sql
-- 创建主表
CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

-- 创建从表，添加外键
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(id)
        ON DELETE SET NULL      -- 主表删除时，从表设为NULL
        ON UPDATE CASCADE       -- 主表更新时，从表同步更新
);

-- 外键操作选项
-- ON DELETE CASCADE    : 级联删除
-- ON DELETE SET NULL   : 设为 NULL
-- ON DELETE RESTRICT   : 限制删除（有从表数据时不能删）
-- ON DELETE NO ACTION  : 同 RESTRICT
```

### 6.3 唯一约束（UNIQUE）

```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    username VARCHAR(20) UNIQUE,       -- 列级约束
    email VARCHAR(50),
    UNIQUE KEY uk_email (email)        -- 表级约束
);
```

### 6.4 非空约束（NOT NULL）

```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,         -- 不能为空
    age INT,                           -- 可以为空
    email VARCHAR(50) NOT NULL DEFAULT 'noemail@example.com'  -- 非空且有默认值
);
```

### 6.5 默认值约束（DEFAULT）

```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(20),
    status TINYINT DEFAULT 1,              -- 默认启用
    create_time DATETIME DEFAULT NOW(),    -- 默认当前时间
    is_deleted TINYINT DEFAULT 0           -- 默认未删除（逻辑删除）
);
```

### 6.6 检查约束（CHECK，MySQL 8.0.16+）

```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(20),
    age INT CHECK (age >= 0 AND age <= 150),           -- 年龄在0-150之间
    email VARCHAR(50),
    status TINYINT CHECK (status IN (0, 1, 2))         -- 状态只能是0/1/2
);
```

---

## 七、索引

### 7.1 创建索引

```sql
-- 创建表时添加索引
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(20),
    email VARCHAR(50),
    INDEX idx_name (name),              -- 普通索引
    UNIQUE INDEX uk_email (email),      -- 唯一索引
    INDEX idx_name_email (name, email)  -- 联合索引
);

-- 创建表后添加索引
CREATE INDEX idx_name ON users(name);
CREATE UNIQUE INDEX uk_phone ON users(phone);
CREATE INDEX idx_name_age ON users(name, age);

-- 查看索引
SHOW INDEX FROM users;

-- 删除索引
DROP INDEX idx_name ON users;
ALTER TABLE users DROP INDEX idx_name;
```

### 7.2 索引类型

| 索引类型 | 说明 | 适用场景 |
|---------|------|---------|
| PRIMARY KEY | 主键索引 | 主键列 |
| UNIQUE | 唯一索引 | 需要唯一的列 |
| INDEX | 普通索引 | 经常查询的列 |
| FULLTEXT | 全文索引 | 文本搜索 |
| SPATIAL | 空间索引 | 地理数据 |

### 7.3 索引优化建议

| 建议 | 说明 |
|------|------|
| 为 WHERE 条件列添加索引 | 提高查询速度 |
| 为 JOIN 关联列添加索引 | 提高连接效率 |
| 为 ORDER BY 列添加索引 | 避免文件排序 |
| 避免过多索引 | 索引会增加写操作开销 |
| 联合索引注意最左前缀 | `(a,b,c)` 只能用于 `a`、`a,b`、`a,b,c` |

---

## 八、实战案例：电商系统数据库设计

### 8.1 完整的建表脚本

```sql
-- 创建数据库
CREATE DATABASE IF NOT EXISTS shop_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE shop_db;

-- 用户表
CREATE TABLE users (
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
    username VARCHAR(20) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(100) NOT NULL COMMENT '密码',
    email VARCHAR(50) UNIQUE COMMENT '邮箱',
    phone CHAR(11) UNIQUE COMMENT '手机号',
    avatar VARCHAR(255) COMMENT '头像URL',
    status TINYINT UNSIGNED DEFAULT 1 COMMENT '状态: 1正常 0禁用',
    create_time DATETIME DEFAULT NOW() COMMENT '创建时间',
    update_time DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT '更新时间',
    INDEX idx_username (username),
    INDEX idx_phone (phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 商品分类表
CREATE TABLE categories (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT COMMENT '分类ID',
    name VARCHAR(50) NOT NULL COMMENT '分类名称',
    parent_id INT UNSIGNED DEFAULT 0 COMMENT '父分类ID',
    sort_order INT DEFAULT 0 COMMENT '排序',
    create_time DATETIME DEFAULT NOW(),
    INDEX idx_parent_id (parent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';

-- 商品表
CREATE TABLE products (
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT COMMENT '商品ID',
    name VARCHAR(100) NOT NULL COMMENT '商品名称',
    category_id INT UNSIGNED COMMENT '分类ID',
    price DECIMAL(10, 2) NOT NULL COMMENT '售价',
    stock INT UNSIGNED DEFAULT 0 COMMENT '库存',
    description TEXT COMMENT '商品描述',
    status TINYINT UNSIGNED DEFAULT 1 COMMENT '状态: 1上架 0下架',
    create_time DATETIME DEFAULT NOW(),
    update_time DATETIME DEFAULT NOW() ON UPDATE NOW(),
    FOREIGN KEY (category_id) REFERENCES categories(id),
    INDEX idx_category_id (category_id),
    INDEX idx_price (price),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- 订单表
CREATE TABLE orders (
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT COMMENT '订单ID',
    order_no VARCHAR(32) NOT NULL UNIQUE COMMENT '订单编号',
    user_id BIGINT UNSIGNED NOT NULL COMMENT '用户ID',
    total_amount DECIMAL(10, 2) NOT NULL COMMENT '订单总金额',
    status TINYINT UNSIGNED DEFAULT 0 COMMENT '状态: 0待支付 1已支付 2已发货 3已完成 4已取消',
    address VARCHAR(200) COMMENT '收货地址',
    create_time DATETIME DEFAULT NOW(),
    pay_time DATETIME COMMENT '支付时间',
    FOREIGN KEY (user_id) REFERENCES users(id),
    INDEX idx_user_id (user_id),
    INDEX idx_order_no (order_no),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- 订单详情表
CREATE TABLE order_items (
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT UNSIGNED NOT NULL COMMENT '订单ID',
    product_id BIGINT UNSIGNED NOT NULL COMMENT '商品ID',
    product_name VARCHAR(100) COMMENT '商品名称（快照）',
    price DECIMAL(10, 2) NOT NULL COMMENT '单价',
    quantity INT UNSIGNED NOT NULL COMMENT '数量',
    subtotal DECIMAL(10, 2) NOT NULL COMMENT '小计',
    FOREIGN KEY (order_id) REFERENCES orders(id),
    INDEX idx_order_id (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单详情表';
```

### 8.2 常用查询练习

```sql
-- 1. 查询所有上架商品，按价格升序
SELECT * FROM products WHERE status = 1 ORDER BY price ASC;

-- 2. 查询每个分类的商品数量
SELECT c.name, COUNT(p.id) AS product_count
FROM categories c
LEFT JOIN products p ON c.id = p.category_id
GROUP BY c.id;

-- 3. 查询用户的订单统计
SELECT u.username, COUNT(o.id) AS order_count, SUM(o.total_amount) AS total_amount
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id;

-- 4. 查询热销商品 TOP 10
SELECT p.id, p.name, SUM(oi.quantity) AS total_sold
FROM products p
INNER JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.id
ORDER BY total_sold DESC
LIMIT 10;

-- 5. 查询待支付超过24小时的订单
SELECT * FROM orders
WHERE status = 0 AND create_time < DATE_SUB(NOW(), INTERVAL 24 HOUR);
```

---

## 九、常用函数速查

### 9.1 字符串函数

| 函数 | 说明 | 示例 |
|------|------|------|
| `CONCAT(s1,s2,...)` | 字符串拼接 | `CONCAT('Hello', ' ', 'World')` → `Hello World` |
| `LENGTH(str)` | 字符串长度（字节） | `LENGTH('张三')` → 6 |
| `CHAR_LENGTH(str)` | 字符串长度（字符） | `CHAR_LENGTH('张三')` → 2 |
| `SUBSTRING(str,pos,len)` | 截取子串 | `SUBSTRING('Hello', 1, 3)` → `Hel` |
| `REPLACE(str,from,to)` | 替换字符串 | `REPLACE('Hello', 'l', 'x')` → `Hexxo` |
| `UPPER(str)` / `LOWER(str)` | 大小写转换 | `UPPER('hello')` → `HELLO` |
| `TRIM(str)` | 去除两端空格 | `TRIM('  hello  ')` → `hello` |

### 9.2 数值函数

| 函数 | 说明 | 示例 |
|------|------|------|
| `ABS(x)` | 绝对值 | `ABS(-10)` → 10 |
| `ROUND(x,d)` | 四舍五入 | `ROUND(3.14159, 2)` → 3.14 |
| `CEIL(x)` / `FLOOR(x)` | 向上/向下取整 | `CEIL(3.2)` → 4 |
| `MOD(x,y)` | 取余 | `MOD(10, 3)` → 1 |
| `RAND()` | 随机数 | `RAND()` → 0.123456 |

### 9.3 日期函数

| 函数 | 说明 | 示例 |
|------|------|------|
| `NOW()` | 当前日期时间 | `2024-11-02 14:30:00` |
| `CURDATE()` | 当前日期 | `2024-11-02` |
| `CURTIME()` | 当前时间 | `14:30:00` |
| `YEAR(date)` / `MONTH(date)` / `DAY(date)` | 提取年月日 | `YEAR('2024-11-02')` → 2024 |
| `DATE_ADD(date, INTERVAL n unit)` | 日期加减 | `DATE_ADD(NOW(), INTERVAL 7 DAY)` |
| `DATEDIFF(date1, date2)` | 日期差（天） | `DATEDIFF('2024-11-02', '2024-11-01')` → 1 |
| `DATE_FORMAT(date, format)` | 格式化日期 | `DATE_FORMAT(NOW(), '%Y-%m-%d')` |

### 9.4 聚合函数

| 函数 | 说明 |
|------|------|
| `COUNT(*)` | 统计记录数 |
| `COUNT(DISTINCT col)` | 统计不重复值数量 |
| `SUM(col)` | 求和 |
| `AVG(col)` | 平均值 |
| `MAX(col)` / `MIN(col)` | 最大/最小值 |
| `GROUP_CONCAT(col)` | 分组拼接字符串 |

---

> 💡 **小结**：本章详细介绍了 MySQL 的标识符命名规范、数据库操作、数据类型、表操作以及 CRUD 增删改查。掌握这些基础操作后，可以进行日常的数据库开发工作。建议结合实际项目进行练习，加深理解。

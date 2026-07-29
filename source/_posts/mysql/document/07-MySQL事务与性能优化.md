---
title: MySQL事务与性能优化
date: 2024-11-07T00:00:00+08:00
tags:
    - mysql
    - 教程
    - SQL
    - 事务
    - 性能优化
    - EXPLAIN
    - 数据库备份
categories: mysql
cover: /images/cover_mysql.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: "MySQL 事务与性能优化教程，涵盖事务ACID特性、四种隔离级别、并发问题、慢查询日志配置、EXPLAIN详解、慢SQL优化方法、数据库备份与恢复。"
---

## 一、事务（Transaction）

### 1.1 什么是事务

事务是一组**不可分割的 SQL 操作序列**，这些操作要么全部成功执行，要么全部不执行。事务是数据库管理系统执行过程中的一个逻辑单位。

**生活中的事务例子：**
- 银行转账：A 账户扣款 100 元，B 账户增加 100 元，这两个操作必须同时成功或同时失败
- 电商下单：创建订单、扣减库存、扣款，三个操作必须一起完成

### 1.2 事务的 ACID 特性

| 特性 | 英文 | 说明 | 示例 |
|------|------|------|------|
| **原子性** | Atomicity | 事务是不可分割的最小单位，要么全部成功，要么全部回滚 | 转账时扣款失败，则收款也不执行 |
| **一致性** | Consistency | 事务执行前后，数据库从一个一致状态变为另一个一致状态 | 转账前后，两人账户总额不变 |
| **隔离性** | Isolation | 多个事务并发执行时，互不干扰 | 事务 A 的修改在提交前，事务 B 看不到 |
| **持久性** | Durability | 事务一旦提交，对数据库的修改永久保存 | 转账成功后，即使系统崩溃，数据也不丢失 |

```
┌─────────────────────────────────────────────┐
│                 ACID 特性                     │
├─────────────────────────────────────────────┤
│  ┌─────────┐                                │
│  │ 原子性 A │  要么全做，要么全不做            │
│  └────┬────┘                                │
│       ↓                                     │
│  ┌─────────┐                                │
│  │ 一致性 C │  数据总是合法的、完整的           │
│  └────┬────┘                                │
│       ↓                                     │
│  ┌─────────┐                                │
│  │ 隔离性 I │  事务之间互不干扰                │
│  └────┬────┘                                │
│       ↓                                     │
│  ┌─────────┐                                │
│  │ 持久性 D │  提交后数据永久保存              │
│  └─────────┘                                │
└─────────────────────────────────────────────┘
```

### 1.3 事务控制语句

```sql
-- 开启事务
START TRANSACTION;
-- 或
BEGIN;

-- 执行 SQL 操作
INSERT INTO tb_account (user_id, balance) VALUES (1, 1000);
UPDATE tb_account SET balance = balance - 100 WHERE user_id = 1;
UPDATE tb_account SET balance = balance + 100 WHERE user_id = 2;

-- 提交事务（所有操作永久生效）
COMMIT;

-- 回滚事务（撤销所有操作）
ROLLBACK;

-- 设置保存点
SAVEPOINT sp1;

-- 回滚到保存点
ROLLBACK TO sp1;

-- 释放保存点
RELEASE SAVEPOINT sp1;
```

**自动提交模式：**

```sql
-- 查看自动提交状态
SHOW VARIABLES LIKE 'autocommit';

-- 关闭自动提交（需要手动 COMMIT）
SET autocommit = 0;

-- 开启自动提交（每条 SQL 自动作为一个事务）
SET autocommit = 1;
```

### 1.4 事务的隔离级别

多个事务并发执行时，可能出现以下问题：

| 并发问题 | 说明 | 影响 |
|---------|------|------|
| **脏读（Dirty Read）** | 一个事务读取了另一个事务未提交的数据 | 可能读到最终被回滚的"脏数据" |
| **不可重复读（Non-repeatable Read）** | 同一事务内多次读取同一数据，结果不同 | 数据被其他事务修改并提交 |
| **幻读（Phantom Read）** | 同一事务内多次查询，结果集行数不同 | 其他事务插入或删除了符合条件的记录 |
| **丢失修改（Lost Update）** | 两个事务同时修改同一数据，后提交的事务覆盖前者 | 数据更新丢失 |
| **死锁（Deadlock）** | 两个事务相互等待对方释放资源 | 事务无法继续执行 |

**四种隔离级别：**

| 隔离级别 | 脏读 | 不可重复读 | 幻读 | 说明 |
|---------|------|-----------|------|------|
| **READ UNCOMMITTED** | 允许 | 允许 | 允许 | 性能最好，安全性最差 |
| **READ COMMITTED** | 禁止 | 允许 | 允许 | Oracle 默认 |
| **REPEATABLE READ** | 禁止 | 禁止 | 允许 | **MySQL 默认** |
| **SERIALIZABLE** | 禁止 | 禁止 | 禁止 | 性能最差，安全性最高 |

```sql
-- 查看当前隔离级别
SELECT @@transaction_isolation;

-- 设置隔离级别（会话级）
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- 设置隔离级别（全局级）
SET GLOBAL TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

**各隔离级别详解：**

```sql
-- ============================================
-- READ UNCOMMITTED（读未提交）
-- ============================================
-- 事务 A 修改但未提交
BEGIN;
UPDATE tb_account SET balance = balance - 100 WHERE id = 1;
-- 不提交

-- 事务 B 可以读到未提交的数据（脏读）
BEGIN;
SELECT balance FROM tb_account WHERE id = 1;  -- 读到修改后的值
COMMIT;

-- ============================================
-- READ COMMITTED（读已提交）
-- ============================================
-- 事务 A 修改并提交
BEGIN;
UPDATE tb_account SET balance = balance - 100 WHERE id = 1;
COMMIT;

-- 事务 B 只能读到已提交的数据
BEGIN;
SELECT balance FROM tb_account WHERE id = 1;  -- 读到修改后的值
-- 事务 A 又修改并提交
-- 事务 B 再次查询
SELECT balance FROM tb_account WHERE id = 1;  -- 值又变了（不可重复读）
COMMIT;

-- ============================================
-- REPEATABLE READ（可重复读）- MySQL 默认
-- ============================================
-- 事务 B 开启后，读取的数据在事务结束前保持一致
BEGIN;
SELECT balance FROM tb_account WHERE id = 1;  -- 值为 1000
-- 事务 A 修改并提交
-- 事务 B 再次查询
SELECT balance FROM tb_account WHERE id = 1;  -- 仍为 1000（可重复读）
COMMIT;

-- ============================================
-- SERIALIZABLE（串行化）
-- ============================================
-- 所有事务串行执行，完全避免并发问题
BEGIN;
SELECT balance FROM tb_account WHERE id = 1;
-- 其他事务必须等待当前事务结束才能执行
COMMIT;
```

### 1.5 死锁

**死锁产生条件：**
1. 互斥条件：资源不能被共享
2. 请求与保持：持有资源同时请求新资源
3. 不剥夺条件：资源只能由持有者释放
4. 循环等待：形成等待环路

```sql
-- 死锁示例
-- 事务 A
BEGIN;
UPDATE tb_account SET balance = 900 WHERE id = 1;  -- 持有 id=1 的锁
-- ... 同时
UPDATE tb_account SET balance = 1100 WHERE id = 2;  -- 请求 id=2 的锁（被事务 B 持有）
-- 死锁！

-- 事务 B
BEGIN;
UPDATE tb_account SET balance = 1100 WHERE id = 2;  -- 持有 id=2 的锁
-- ... 同时
UPDATE tb_account SET balance = 900 WHERE id = 1;   -- 请求 id=1 的锁（被事务 A 持有）
-- 死锁！
```

**避免死锁的方法：**
- 按固定顺序访问资源
- 尽量缩短事务长度
- 使用低隔离级别
- 设置锁等待超时

```sql
-- 查看死锁日志
SHOW ENGINE INNODB STATUS;

-- 设置锁等待超时（秒）
SET innodb_lock_wait_timeout = 50;
```

### 1.6 事务实战：银行转账

```sql
-- 银行转账完整事务
DELIMITER //

CREATE PROCEDURE transfer(
    IN from_account BIGINT,
    IN to_account BIGINT,
    IN amount DECIMAL(10,2),
    OUT result VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET result = '转账失败，已回滚';
    END;
    
    START TRANSACTION;
    
    -- 检查转出账户余额
    DECLARE from_balance DECIMAL(10,2);
    SELECT balance INTO from_balance 
    FROM tb_account WHERE id = from_account FOR UPDATE;
    
    IF from_balance < amount THEN
        SET result = '余额不足';
        ROLLBACK;
    ELSE
        -- 转出账户扣款
        UPDATE tb_account 
        SET balance = balance - amount 
        WHERE id = from_account;
        
        -- 转入账户加款
        UPDATE tb_account 
        SET balance = balance + amount 
        WHERE id = to_account;
        
        -- 记录转账日志
        INSERT INTO tb_transfer_log (from_id, to_id, amount, transfer_time)
        VALUES (from_account, to_account, amount, NOW());
        
        COMMIT;
        SET result = '转账成功';
    END IF;
END //

DELIMITER ;
```

---

## 二、SQL 性能优化

### 2.1 慢查询日志

慢查询日志用于记录执行时间超过阈值的 SQL 语句，是性能优化的重要工具。

```sql
-- 查看慢查询日志配置
SHOW VARIABLES LIKE 'slow_query%';
SHOW VARIABLES LIKE 'long_query_time';

-- 开启慢查询日志
SET GLOBAL slow_query_log = 'ON';

-- 设置慢查询时间阈值（秒）
SET GLOBAL long_query_time = 2;

-- 查看慢查询日志文件位置
SHOW VARIABLES LIKE 'slow_query_log_file';
```

**my.cnf / my.ini 配置：**

```ini
[mysqld]
# 开启慢查询日志
slow_query_log = 1

# 慢查询日志文件路径
slow_query_log_file = /var/log/mysql/slow.log

# 慢查询时间阈值（秒）
long_query_time = 2

# 记录未使用索引的查询
log_queries_not_using_indexes = 1
```

**分析慢查询日志：**

```sql
-- 使用 mysqldumpslow 工具分析
-- mysqldumpslow -s t -t 10 /var/log/mysql/slow.log

-- 使用 pt-query-digest 工具分析（Percona Toolkit）
-- pt-query-digest /var/log/mysql/slow.log
```

### 2.2 EXPLAIN 详解

EXPLAIN 是分析 SQL 执行计划的核心工具。

```sql
-- 基本用法
EXPLAIN SELECT * FROM tb_user WHERE id = 1;

-- 查看更详细的信息（MySQL 8.0+）
EXPLAIN ANALYZE SELECT * FROM tb_user WHERE id = 1;

-- 查看格式化输出
EXPLAIN FORMAT=JSON SELECT * FROM tb_user WHERE id = 1;
```

**EXPLAIN 输出字段详解：**

| 字段 | 说明 |
|------|------|
| **id** | 查询序列号，id 相同从上到下执行，id 不同数值大的先执行 |
| **select_type** | 查询类型：SIMPLE（简单查询）、PRIMARY（最外层查询）、SUBQUERY（子查询）、DERIVED（派生表）等 |
| **table** | 当前行操作的表名 |
| **partitions** | 匹配的分区（未分区则为 NULL） |
| **type** | 访问类型，性能关键指标 |
| **possible_keys** | 可能使用的索引 |
| **key** | 实际使用的索引 |
| **key_len** | 索引使用的字节数（越短越好） |
| **ref** | 索引匹配的列或常量 |
| **rows** | 预估扫描的行数（越小越好） |
| **filtered** | 查询条件过滤后剩余行的百分比 |
| **Extra** | 额外信息 |

**type 访问类型（性能从优到差）：**

| type | 说明 | 示例 |
|------|------|------|
| **system** | 表只有一行 | `SELECT * FROM dual` |
| **const** | 主键或唯一索引等值查询 | `WHERE id = 1` |
| **eq_ref** | JOIN 时主键或唯一索引关联 | `t1 JOIN t2 ON t1.id = t2.id` |
| **ref** | 普通索引等值查询 | `WHERE name = '张三'` |
| **range** | 索引范围查询 | `WHERE id BETWEEN 1 AND 100` |
| **index** | 索引全扫描 | `SELECT id FROM table`（覆盖索引） |
| **ALL** | 全表扫描 | `SELECT * FROM table` |

**Extra 常见值：**

| Extra 值 | 说明 | 建议 |
|---------|------|------|
| **Using index** | 使用覆盖索引，无需回表 | 优秀 |
| **Using where** | 使用 WHERE 过滤 | 正常 |
| **Using filesort** | 需要额外排序 | 优化：为排序字段加索引 |
| **Using temporary** | 使用临时表 | 优化：简化 GROUP BY / ORDER BY |
| **Using join buffer** | 使用连接缓存 | 大数据量 JOIN 时正常 |
| **Impossible WHERE** | WHERE 条件永远为假 | 检查条件逻辑 |
| **Select tables optimized away** | 优化器确定最多返回一行 | 优秀 |

### 2.3 EXPLAIN 实战分析

```sql
-- 创建测试表
CREATE TABLE user_info (
    id BIGINT(20) NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '',
    age INT(11) DEFAULT NULL,
    PRIMARY KEY (id),
    KEY name_index (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO user_info (name, age) VALUES 
('xys', 20), ('a', 21), ('b', 23), ('c', 50), ('d', 15),
('e', 20), ('f', 21), ('g', 23), ('h', 50), ('i', 15);

CREATE TABLE order_info (
    id BIGINT(20) NOT NULL AUTO_INCREMENT,
    user_id BIGINT(20) DEFAULT NULL,
    product_name VARCHAR(50) NOT NULL DEFAULT '',
    productor VARCHAR(30) DEFAULT NULL,
    PRIMARY KEY (id),
    KEY user_product_detail_index (user_id, product_name, productor)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO order_info (user_id, product_name, productor) VALUES 
(1, 'p1', 'WHH'), (1, 'p2', 'WL'), (1, 'p1', 'DX'),
(2, 'p1', 'WHH'), (2, 'p5', 'WL'), (3, 'p3', 'MA'),
(4, 'p1', 'WHH'), (6, 'p1', 'WHH');
```

```sql
-- 案例1：主键等值查询（type = const）
EXPLAIN SELECT * FROM user_info WHERE id = 1;
-- +----+-------------+-----------+-------+---------------+---------+---------+-------+------+-------+
-- | id | select_type | table     | type  | possible_keys | key     | key_len | ref   | rows | Extra |
-- +----+-------------+-----------+-------+---------------+---------+---------+-------+------+-------+
-- |  1 | SIMPLE      | user_info | const | PRIMARY       | PRIMARY | 8       | const |    1 |       |
-- +----+-------------+-----------+-------+---------------+---------+---------+-------+------+-------+

-- 案例2：普通索引查询（type = ref）
EXPLAIN SELECT * FROM user_info WHERE name = 'xys';
-- type = ref，使用 name_index

-- 案例3：范围查询（type = range）
EXPLAIN SELECT * FROM user_info WHERE id BETWEEN 1 AND 5;
-- type = range，使用 PRIMARY

-- 案例4：全表扫描（type = ALL）
EXPLAIN SELECT * FROM user_info WHERE age = 20;
-- type = ALL，age 没有索引，全表扫描

-- 案例5：覆盖索引（Extra = Using index）
EXPLAIN SELECT id, name FROM user_info WHERE name = 'xys';
-- 只查询索引列，无需回表

-- 案例6：多表 JOIN
EXPLAIN SELECT u.*, o.product_name 
FROM user_info u 
LEFT JOIN order_info o ON u.id = o.user_id 
WHERE u.name = 'xys';
-- 分析 JOIN 的执行计划

-- 案例7：索引失效（隐式转换）
EXPLAIN SELECT * FROM order_info WHERE user_id = '1';
-- user_id 是 BIGINT，传入字符串会导致隐式转换，索引失效
```

### 2.4 慢 SQL 优化方法

#### 优化步骤

```
1. 开启慢查询日志，定位慢 SQL
2. 使用 EXPLAIN 分析执行计划
3. 检查索引使用情况
4. 优化 SQL 语句
5. 优化表结构
6. 优化数据库配置
```

#### 常见优化方法

**1. 添加或优化索引**

```sql
-- 原查询（全表扫描）
SELECT * FROM tb_order WHERE user_id = 100 AND status = '已完成';
-- EXPLAIN: type = ALL, rows = 100000

-- 优化：创建联合索引
ALTER TABLE tb_order ADD INDEX idx_user_status(user_id, status);
-- EXPLAIN: type = ref, rows = 10
```

**2. 避免 SELECT ***

```sql
-- ❌ 不推荐
SELECT * FROM tb_user WHERE id = 1;

-- ✅ 推荐（覆盖索引）
SELECT id, name, phone FROM tb_user WHERE id = 1;
```

**3. 优化分页查询**

```sql
-- ❌ 深分页性能差
SELECT * FROM tb_order ORDER BY id LIMIT 100000, 10;

-- ✅ 优化1：使用 WHERE 条件
SELECT * FROM tb_order 
WHERE id > 100000 
ORDER BY id LIMIT 10;

-- ✅ 优化2：延迟关联
SELECT o.* FROM tb_order o
INNER JOIN (
    SELECT id FROM tb_order ORDER BY id LIMIT 100000, 10
) t ON o.id = t.id;
```

**4. 优化 ORDER BY**

```sql
-- ❌ Using filesort
SELECT * FROM tb_order WHERE user_id = 1 ORDER BY create_time;

-- ✅ 创建联合索引
ALTER TABLE tb_order ADD INDEX idx_user_time(user_id, create_time);
```

**5. 优化子查询**

```sql
-- ❌ 子查询（效率低）
SELECT * FROM tb_order 
WHERE user_id IN (SELECT id FROM tb_user WHERE status = 1);

-- ✅ 改写为 JOIN
SELECT o.* FROM tb_order o
INNER JOIN tb_user u ON o.user_id = u.id
WHERE u.status = 1;
```

**6. 优化批量插入**

```sql
-- ❌ 逐条插入
INSERT INTO tb_log (level, message) VALUES ('INFO', 'msg1');
INSERT INTO tb_log (level, message) VALUES ('INFO', 'msg2');

-- ✅ 批量插入
INSERT INTO tb_log (level, message) VALUES 
('INFO', 'msg1'), ('INFO', 'msg2'), ('INFO', 'msg3');
```

**7. 优化大数据量删除**

```sql
-- ❌ 一次性删除大量数据（锁表时间长）
DELETE FROM tb_log WHERE create_time < '2023-01-01';

-- ✅ 分批删除
DELETE FROM tb_log 
WHERE create_time < '2023-01-01' 
LIMIT 1000;
-- 循环执行直到删除完毕
```

### 2.5 性能优化检查清单

- [ ] 是否为 WHERE、JOIN、ORDER BY 字段建立索引
- [ ] 是否避免 SELECT *，只查询需要的字段
- [ ] 是否避免在索引列上使用函数或运算
- [ ] 是否避免 LIKE '%xxx' 左模糊查询
- [ ] 是否避免隐式类型转换
- [ ] 是否优化深分页查询
- [ ] 是否避免大事务长时间运行
- [ ] 是否定期 ANALYZE TABLE 更新统计信息
- [ ] 是否定期清理无用数据

---

## 三、数据库备份与恢复

### 3.1 备份方式

| 备份方式 | 说明 | 优点 | 缺点 |
|---------|------|------|------|
| **物理备份** | 直接复制数据文件 | 速度快，恢复快 | 需要停机或锁表 |
| **逻辑备份** | 导出 SQL 语句 | 灵活，可跨版本 | 速度慢，恢复慢 |
| **全量备份** | 备份全部数据 | 恢复简单 | 占用空间大，耗时长 |
| **增量备份** | 只备份变化的数据 | 节省空间和时间 | 恢复复杂 |

### 3.2 使用 mysqldump 逻辑备份

```bash
# 备份单个数据库
mysqldump -u root -p shop_db > shop_db_backup.sql

# 备份多个数据库
mysqldump -u root -p --databases shop_db user_db > multi_db_backup.sql

# 备份所有数据库
mysqldump -u root -p --all-databases > all_db_backup.sql

# 备份指定表
mysqldump -u root -p shop_db tb_user tb_order > tables_backup.sql

# 只备份表结构（不备份数据）
mysqldump -u root -p --no-data shop_db > schema_backup.sql

# 只备份数据（不备份表结构）
mysqldump -u root -p --no-create-info shop_db > data_backup.sql

# 带条件的备份
mysqldump -u root -p shop_db tb_log --where="create_time > '2024-01-01'" > log_backup.sql

# 压缩备份
mysqldump -u root -p shop_db | gzip > shop_db_backup.sql.gz
```

**mysqldump 常用参数：**

| 参数 | 说明 |
|------|------|
| `-u` | 用户名 |
| `-p` | 密码（会提示输入） |
| `-h` | 主机地址 |
| `-P` | 端口号 |
| `--single-transaction` | 对 InnoDB 表进行一致性备份（不锁表） |
| `--lock-all-tables` | 锁定所有表 |
| `--quick` | 逐行读取，大表不缓存到内存 |
| `--extended-insert` | 使用多行 INSERT，加快导入速度 |
| `--routines` | 备份存储过程和函数 |
| `--triggers` | 备份触发器 |
| `--events` | 备份事件 |

### 3.3 数据恢复

```bash
# 恢复整个数据库
mysql -u root -p shop_db < shop_db_backup.sql

# 恢复前创建数据库
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS shop_db;"
mysql -u root -p shop_db < shop_db_backup.sql

# 从压缩文件恢复
gunzip < shop_db_backup.sql.gz | mysql -u root -p shop_db

# 恢复指定表
mysql -u root -p shop_db < tables_backup.sql
```

### 3.4 使用物理备份（XtraBackup）

```bash
# 安装 Percona XtraBackup
# 全量备份
xtrabackup --backup --target-dir=/backup/full

# 准备备份
xtrabackup --prepare --target-dir=/backup/full

# 恢复备份
xtrabackup --copy-back --target-dir=/backup/full
```

### 3.5 备份策略建议

```
┌─────────────────────────────────────────────┐
│              备份策略示例                     │
├─────────────────────────────────────────────┤
│  每天凌晨 2:00  全量备份（mysqldump）        │
│  每 6 小时     增量备份（binlog）            │
│  实时          主从复制                      │
├─────────────────────────────────────────────┤
│  备份保留 30 天，定期清理过期备份             │
│  定期测试恢复流程                            │
│  备份文件异地存储                            │
└─────────────────────────────────────────────┘
```

---

> 💡 **小结**：本章系统介绍了 MySQL 事务与性能优化。事务部分涵盖 ACID 特性、四种隔离级别、并发问题（脏读、不可重复读、幻读）及死锁处理。性能优化部分包括慢查询日志配置、EXPLAIN 执行计划分析、慢 SQL 优化方法（索引优化、分页优化、子查询优化等）。最后介绍了数据库备份与恢复的常用方法（mysqldump、XtraBackup）。

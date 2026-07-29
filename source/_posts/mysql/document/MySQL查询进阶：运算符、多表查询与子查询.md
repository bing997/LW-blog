---
title: MySQL查询进阶：运算符、多表查询与子查询
date: 2024-11-03T00:00:00+08:00
tags:
    - mysql
    - 教程
    - SQL
    - 查询
categories: mysql
cover: /images/cover_mysql.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: "MySQL 查询进阶教程，涵盖 SELECT 完整语法、运算符详解、多表连接查询、子查询与嵌套查询，配有大量实战案例。"
---

## 一、SELECT 完整语法

### 1.1 基本 SELECT 语句

```sql
SELECT DISTINCT 查询列
FROM 查询目标表
WHERE 查询条件
GROUP BY 分组依据
HAVING 分组条件
ORDER BY 列名1 ASC|DESC, 列名2 ASC|DESC
LIMIT 开始位置, 返回条数;
```

### 1.2 SELECT 执行顺序

```sql
(7) SELECT
(8) DISTINCT 查询列
(1) FROM 表名
(3) JOIN 表名 ON 连接条件
(2) WHERE 查询条件
(4) GROUP BY 分组依据
(5) HAVING 分组条件
(6) ORDER BY 排序字段
(9) LIMIT 分页限制
```

**执行顺序详解：**

| 顺序 | 子句 | 说明 |
|------|------|------|
| 1 | FROM | 确定数据源表 |
| 2 | WHERE | 过滤数据行 |
| 3 | GROUP BY | 分组 |
| 4 | HAVING | 过滤分组 |
| 5 | SELECT | 选择列 |
| 6 | DISTINCT | 去重 |
| 7 | ORDER BY | 排序 |
| 8 | LIMIT | 限制结果 |

### 1.3 基础查询示例

```sql
-- 查询所有列
SELECT * FROM employees;

-- 查询指定列
SELECT id, name, salary FROM employees;

-- 查询并起别名
SELECT id AS '编号', name AS '姓名', salary AS '工资' FROM employees;

-- 查询并去重
SELECT DISTINCT department FROM employees;

-- 查询并计算
SELECT name, salary, salary * 12 AS '年薪' FROM employees;
```

---

## 二、运算符详解

### 2.1 算术运算符

| 运算符 | 说明 | 示例 |
|--------|------|------|
| `+` | 加法 | `100 + 2` → 102 |
| `-` | 减法 | `100 - 2` → 98 |
| `*` | 乘法 | `100 * 2` → 200 |
| `/` | 除法（保留小数） | `100 / 3` → 33.3333 |
| `DIV` | 整除（取整数部分） | `100 DIV 3` → 33 |
| `%` / `MOD` | 取余 | `100 % 3` → 1 |

**算术运算示例：**

```sql
-- 基本运算
SELECT 100, 100 * 1, 100 * 1.0, 100 / 1.0, 100 / 2, 100 + 2 * 5 / 2;

-- 结果：
-- 100, 100, 100.0, 100.0000, 50.0000, 105.0000

-- 整除与取余
SELECT 100 DIV 3, 100 % 3;
-- 结果：33, 1

-- 除数为0时返回NULL
SELECT 100 / 0, 100 DIV 0;
-- 结果：NULL, NULL

-- 实际应用：计算年薪
SELECT name, salary, salary * 12 AS annual_salary
FROM employees;

-- 计算奖金（基本工资的10%）
SELECT name, salary, salary * 0.1 AS bonus
FROM employees;
```

**注意事项：**

| 情况 | 结果 | 说明 |
|------|------|------|
| `100 / 0` | NULL | 除数为0返回NULL |
| `100 DIV 0` | NULL | 整除除数为0返回NULL |
| `100 * 1` | 100 | 整数运算 |
| `100 * 1.0` | 100.0 | 浮点数运算 |
| `100 / 3` | 33.3333 | 除法保留小数 |
| `100 DIV 3` | 33 | 整除取整数部分 |

### 2.2 比较运算符

| 运算符 | 说明 | 示例 |
|--------|------|------|
| `=` | 等于 | `salary = 5000` |
| `!=` / `<>` | 不等于 | `salary != 5000` |
| `>` | 大于 | `salary > 5000` |
| `<` | 小于 | `salary < 5000` |
| `>=` | 大于等于 | `salary >= 5000` |
| `<=` | 小于等于 | `salary <= 5000` |
| `BETWEEN...AND` | 在范围内 | `salary BETWEEN 3000 AND 5000` |
| `IN` | 在列表中 | `id IN (1, 2, 3)` |
| `IS NULL` | 为空 | `email IS NULL` |
| `IS NOT NULL` | 不为空 | `email IS NOT NULL` |
| `LIKE` | 模糊匹配 | `name LIKE '张%'` |
| `REGEXP` / `RLIKE` | 正则匹配 | `name REGEXP '^张'` |

**比较运算示例：**

```sql
-- 等于查询
SELECT * FROM employees WHERE department = '技术部';

-- 不等于查询
SELECT * FROM employees WHERE department != '技术部';
SELECT * FROM employees WHERE department <> '技术部';

-- 范围查询
SELECT * FROM employees WHERE salary BETWEEN 5000 AND 10000;

-- 列表查询
SELECT * FROM employees WHERE department IN ('技术部', '销售部', '财务部');

-- NULL值查询
SELECT * FROM employees WHERE manager_id IS NULL;  -- 查询没有上级的员工
SELECT * FROM employees WHERE email IS NOT NULL;   -- 查询有邮箱的员工

-- 模糊查询
SELECT * FROM employees WHERE name LIKE '张%';     -- 以"张"开头
SELECT * FROM employees WHERE name LIKE '%张%';    -- 包含"张"
SELECT * FROM employees WHERE name LIKE '_张%';    -- 第二个字是"张"
SELECT * FROM employees WHERE name LIKE '张_';     -- 两个字，第一个是"张"
```

### 2.3 逻辑运算符

| 运算符 | 说明 | 示例 |
|--------|------|------|
| `AND` / `&&` | 逻辑与 | `salary > 5000 AND department = '技术部'` |
| `OR` / `||` | 逻辑或 | `salary > 10000 OR department = '经理'` |
| `NOT` / `!` | 逻辑非 | `NOT (salary > 5000)` |
| `XOR` | 逻辑异或 | `salary > 5000 XOR department = '技术部'` |

**逻辑运算示例：**

```sql
-- AND：同时满足多个条件
SELECT * FROM employees
WHERE salary > 5000 AND department = '技术部';

-- OR：满足任一条件
SELECT * FROM employees
WHERE salary > 10000 OR position = '经理';

-- NOT：取反
SELECT * FROM employees
WHERE NOT (department = '技术部');

-- 组合使用（注意优先级）
SELECT * FROM employees
WHERE (salary > 5000 OR department = '技术部') AND age > 25;

-- XOR：异或（只能满足一个条件）
SELECT * FROM employees
WHERE salary > 5000 XOR department = '经理';
```

### 2.4 位运算符

| 运算符 | 说明 | 示例 |
|--------|------|------|
| `&` | 按位与 | `5 & 3` → 1 |
| `|` | 按位或 | `5 | 3` → 7 |
| `^` | 按位异或 | `5 ^ 3` → 6 |
| `~` | 按位取反 | `~5` → -6 |
| `<<` | 左移 | `5 << 1` → 10 |
| `>>` | 右移 | `5 >> 1` → 2 |

**位运算示例：**

```sql
-- 按位与：权限判断
SELECT 5 & 3;  -- 0101 & 0011 = 0001 → 1

-- 按位或：权限合并
SELECT 5 | 3;  -- 0101 | 0011 = 0111 → 7

-- 左移：乘以2的n次方
SELECT 5 << 1;  -- 5 * 2 = 10

-- 右移：除以2的n次方
SELECT 5 >> 1;  -- 5 / 2 = 2

-- 实际应用：权限系统
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(20),
    permissions TINYINT COMMENT '权限位：读(1),写(2),删(4),执行(8)'
);

-- 插入数据：读+写权限
INSERT INTO users (id, name, permissions) VALUES (1, '张三', 3);  -- 1+2

-- 查询有写权限的用户
SELECT * FROM users WHERE permissions & 2 = 2;
```

---

## 三、WHERE 条件查询

### 3.1 基本条件

```sql
-- 单条件查询
SELECT * FROM employees WHERE salary > 5000;

-- 多条件AND
SELECT * FROM employees
WHERE salary > 5000 AND department = '技术部';

-- 多条件OR
SELECT * FROM employees
WHERE department = '技术部' OR department = '产品部';

-- 组合条件（使用括号）
SELECT * FROM employees
WHERE (department = '技术部' OR department = '产品部')
  AND salary > 5000;
```

### 3.2 范围查询

```sql
-- BETWEEN...AND：包含边界值
SELECT * FROM employees WHERE salary BETWEEN 5000 AND 10000;

-- 等价于
SELECT * FROM employees WHERE salary >= 5000 AND salary <= 10000;

-- NOT BETWEEN
SELECT * FROM employees WHERE salary NOT BETWEEN 5000 AND 10000;
```

### 3.3 列表查询

```sql
-- IN：在列表中
SELECT * FROM employees WHERE department IN ('技术部', '销售部', '财务部');

-- 等价于
SELECT * FROM employees
WHERE department = '技术部'
   OR department = '销售部'
   OR department = '财务部';

-- NOT IN：不在列表中
SELECT * FROM employees WHERE department NOT IN ('技术部', '销售部');
```

### 3.4 NULL值处理

```sql
-- IS NULL：查询空值
SELECT * FROM employees WHERE manager_id IS NULL;

-- IS NOT NULL：查询非空值
SELECT * FROM employees WHERE email IS NOT NULL;

-- 错误写法（不推荐）
SELECT * FROM employees WHERE manager_id = NULL;  -- 永远不会返回结果

-- 使用 IFNULL 处理 NULL
SELECT name, IFNULL(bonus, 0) AS bonus FROM employees;
```

### 3.5 模糊查询

```sql
-- LIKE 通配符：
-- %：匹配0个或多个字符
-- _：匹配单个字符

-- 以"张"开头
SELECT * FROM employees WHERE name LIKE '张%';

-- 以"张"结尾
SELECT * FROM employees WHERE name LIKE '%张';

-- 包含"张"
SELECT * FROM employees WHERE name LIKE '%张%';

-- 第二个字是"张"
SELECT * FROM employees WHERE name LIKE '_张%';

-- 名字是两个字，第一个是"张"
SELECT * FROM employees WHERE name LIKE '张_';

-- 名字是三个字，第一个是"张"
SELECT * FROM employees WHERE name LIKE '张__';

-- 使用正则表达式
SELECT * FROM employees WHERE name REGEXP '^张';      -- 以"张"开头
SELECT * FROM employees WHERE name REGEXP '张$';      -- 以"张"结尾
SELECT * FROM employees WHERE name REGEXP '^[0-9]';   -- 以数字开头
```

---

## 四、多表查询

### 4.1 连接查询分类

```
┌─────────────────────────────────────────────┐
│              多表查询（JOIN）                 │
├─────────────────────────────────────────────┤
│  ┌─────────────────────────────────────┐    │
│  │ 内连接（INNER JOIN）                  │    │
│  │ 只返回两个表中匹配的记录              │    │
│  └─────────────────────────────────────┘    │
│  ┌─────────────────────────────────────┐    │
│  │ 外连接（OUTER JOIN）                  │    │
│  │ ├─ 左连接（LEFT JOIN）               │    │
│  │ ├─ 右连接（RIGHT JOIN）              │    │
│  │ └─ 全连接（FULL JOIN）               │    │
│  └─────────────────────────────────────┘    │
│  ┌─────────────────────────────────────┐    │
│  │ 自连接（SELF JOIN）                   │    │
│  │ 表与自身连接                          │    │
│  └─────────────────────────────────────┘    │
│  ┌─────────────────────────────────────┐    │
│  │ 交叉连接（CROSS JOIN）                │    │
│  │ 返回笛卡尔积                          │    │
│  └─────────────────────────────────────┘    │
└─────────────────────────────────────────────┘
```

### 4.2 内连接（INNER JOIN）

**只返回两个表中匹配的记录。**

```sql
-- 隐式内连接（WHERE）
SELECT e.name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.id;

-- 显式内连接（INNER JOIN）- 推荐
SELECT e.name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;

-- 内连接可以省略INNER
SELECT e.name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id;

-- 多表内连接
SELECT e.name, d.department_name, p.project_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
INNER JOIN employee_projects ep ON e.id = ep.employee_id
INNER JOIN projects p ON ep.project_id = p.id;

-- 使用USING（当连接字段名相同时）
SELECT e.name, d.department_name
FROM employees e
INNER JOIN departments d USING(department_id);
```

**Venn图示：**

```
    表A          表B
  ┌─────┐     ┌─────┐
  │  ┌──┼─────┼──┐  │
  │  │██│     │██│  │  ← 内连接结果（交集）
  │  └──┼─────┼──┘  │
  └─────┘     └─────┘
```

### 4.3 左连接（LEFT JOIN）

**返回左表所有记录，右表没有匹配则返回NULL。**

```sql
-- 左连接：查询所有员工及其部门（包括没有部门的员工）
SELECT e.name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;

-- 左连接 + WHERE过滤：只显示左表中在右表没有匹配的记录
SELECT e.name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id
WHERE d.id IS NULL;  -- 找出没有部门的员工
```

**Venn图示：**

```
    表A          表B
  ┌─────┐     ┌─────┐
  │█████├─────┼──┐  │
  │█████│     │██│  │  ← 左连接结果（左表全部）
  │█████├─────┼──┘  │
  └─────┘     └─────┘
```

### 4.4 右连接（RIGHT JOIN）

**返回右表所有记录，左表没有匹配则返回NULL。**

```sql
-- 右连接：查询所有部门及其员工（包括没有员工的部门）
SELECT e.name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;

-- 右连接可以改写为左连接（推荐）
SELECT e.name, d.department_name
FROM departments d
LEFT JOIN employees e ON e.department_id = d.id;
```

### 4.5 全连接（FULL JOIN）

**返回两个表所有记录，没有匹配则返回NULL。**

```sql
-- MySQL不支持FULL JOIN，使用UNION模拟
SELECT e.name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id

UNION

SELECT e.name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;

-- 或者使用UNION ALL（包含重复）
SELECT e.name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id

UNION ALL

SELECT e.name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;
```

**Venn图示：**

```
    表A          表B
  ┌─────┐     ┌─────┐
  │█████├─────┼█████│
  │█████│     │█████│  ← 全连接结果（并集）
  │█████├─────┼█████│
  └─────┘     └─────┘
```

### 4.6 自连接

**表与自身连接，用于层级数据查询。**

```sql
-- 员工与上级的自连接
SELECT 
    e.name AS employee_name,
    m.name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;

-- 分类与父分类的自连接
SELECT 
    c.name AS category_name,
    p.name AS parent_name
FROM categories c
LEFT JOIN categories p ON c.parent_id = p.id;

-- 查找同一部门中工资比自己高的同事
SELECT e1.name, e1.salary, e2.name AS colleague_name, e2.salary AS colleague_salary
FROM employees e1
INNER JOIN employees e2 ON e1.department_id = e2.department_id
WHERE e1.salary < e2.salary;
```

### 4.7 交叉连接（CROSS JOIN）

**返回笛卡尔积（两个表所有组合）。**

```sql
-- 显式交叉连接
SELECT e.name, d.department_name
FROM employees e
CROSS JOIN departments d;

-- 隐式交叉连接（不推荐）
SELECT e.name, d.department_name
FROM employees e, departments d;

-- 实际应用：生成所有组合
-- 例如：每个学生与每门课程的组合
SELECT s.name AS student, c.name AS course
FROM students s
CROSS JOIN courses c;
```

### 4.8 连接查询对比表

| 连接类型 | 关键字 | 结果 | 说明 |
|---------|--------|------|------|
| **内连接** | INNER JOIN | 交集 | 只返回匹配记录 |
| **左连接** | LEFT JOIN | 左表全部 + 匹配右表 | 左表为主 |
| **右连接** | RIGHT JOIN | 右表全部 + 匹配左表 | 右表为主 |
| **全连接** | FULL JOIN | 并集 | MySQL用UNION模拟 |
| **自连接** | SELF JOIN | 自身连接 | 层级数据查询 |
| **交叉连接** | CROSS JOIN | 笛卡尔积 | 所有组合 |

### 4.9 实战案例：电商系统多表查询

```sql
-- 数据库表结构
-- users（用户表）: id, name, email
-- orders（订单表）: id, user_id, order_no, total_amount, status
-- order_items（订单详情）: id, order_id, product_id, quantity, price
-- products（商品表）: id, name, price, category_id

-- 1. 查询用户及其订单（左连接）
SELECT u.name, o.order_no, o.total_amount
FROM users u
LEFT JOIN orders o ON u.id = o.user_id;

-- 2. 查询订单及用户信息（内连接）
SELECT o.order_no, u.name, u.email, o.total_amount
FROM orders o
INNER JOIN users u ON o.user_id = u.id;

-- 3. 查询订单详情（三表连接）
SELECT o.order_no, u.name, p.name AS product_name, oi.quantity, oi.price
FROM orders o
INNER JOIN users u ON o.user_id = u.id
INNER JOIN order_items oi ON o.id = oi.order_id
INNER JOIN products p ON oi.product_id = p.id;

-- 4. 查询没有下单的用户
SELECT u.name, u.email
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE o.id IS NULL;

-- 5. 查询每个用户的订单数量和总金额
SELECT 
    u.name,
    COUNT(o.id) AS order_count,
    COALESCE(SUM(o.total_amount), 0) AS total_amount
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id;

-- 6. 查询热销商品TOP 10
SELECT 
    p.name,
    SUM(oi.quantity) AS total_sold,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM products p
INNER JOIN order_items oi ON p.id = oi.product_id
INNER JOIN orders o ON oi.order_id = o.id
WHERE o.status IN ('已支付', '已完成')
GROUP BY p.id
ORDER BY total_sold DESC
LIMIT 10;
```

---

## 五、子查询与嵌套查询

### 5.1 子查询概述

**子查询**是嵌套在另一个查询中的查询，可以出现在SELECT、FROM、WHERE、HAVING等子句中。

```sql
-- 子查询的基本结构
SELECT columns
FROM table
WHERE column operator (SELECT column FROM table WHERE condition);
```

### 5.2 子查询分类

根据子查询返回结果的不同，分为三种情况：

| 子查询结果 | 比较方式 | 使用运算符 |
|-----------|---------|-----------|
| **单列单个值** | 直接比较 | `=`、`>`、`<`、`>=`、`<=`、`!=` |
| **单列多个值** | 列表比较 | `IN`、`NOT IN` |
| **单列多个值** | 批量比较 | `ANY`、`SOME`、`ALL` + 比较符 |

### 5.3 子查询返回单个值

**使用比较运算符直接比较。**

```sql
-- 查询工资高于平均工资的员工
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 查询工资最高的员工
SELECT name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

-- 查询与"张三"同部门的员工
SELECT name, department_id
FROM employees
WHERE department_id = (SELECT department_id FROM employees WHERE name = '张三');

-- 查询部门人数最多的部门
SELECT department_id, COUNT(*) AS emp_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) = (
    SELECT MAX(emp_count)
    FROM (
        SELECT COUNT(*) AS emp_count
        FROM employees
        GROUP BY department_id
    ) AS t
);
```

### 5.4 子查询返回多个值（IN / NOT IN）

**使用IN或NOT IN进行比较。**

```sql
-- 查询技术部和产品部的员工
SELECT name, department_id
FROM employees
WHERE department_id IN (
    SELECT id FROM departments
    WHERE name IN ('技术部', '产品部')
);

-- 查询有订单的用户
SELECT * FROM users
WHERE id IN (SELECT DISTINCT user_id FROM orders);

-- 查询没有订单的用户
SELECT * FROM users
WHERE id NOT IN (SELECT DISTINCT user_id FROM orders WHERE user_id IS NOT NULL);

-- 查询购买了"iPhone 15"的用户
SELECT * FROM users
WHERE id IN (
    SELECT DISTINCT o.user_id
    FROM orders o
    INNER JOIN order_items oi ON o.id = oi.order_id
    INNER JOIN products p ON oi.product_id = p.id
    WHERE p.name = 'iPhone 15'
);
```

### 5.5 子查询与 ANY、SOME、ALL

**ANY/SOME/ALL 与比较运算符配合使用。**

| 运算符 | 说明 |
|--------|------|
| `> ANY` | 大于最小值 |
| `> ALL` | 大于最大值 |
| `< ANY` | 小于最大值 |
| `< ALL` | 小于最小值 |
| `= ANY` | 等同于 IN |
| `= ALL` | 等于所有值（通常无意义） |

```sql
-- 查询工资高于任意一个部门平均工资的员工
SELECT name, salary
FROM employees
WHERE salary > ANY (
    SELECT AVG(salary)
    FROM employees
    GROUP BY department_id
);

-- 等价于：大于最小平均值
SELECT name, salary
FROM employees
WHERE salary > (
    SELECT MIN(avg_sal)
    FROM (
        SELECT AVG(salary) AS avg_sal
        FROM employees
        GROUP BY department_id
    ) AS t
);

-- 查询工资高于所有部门平均工资的员工
SELECT name, salary
FROM employees
WHERE salary > ALL (
    SELECT AVG(salary)
    FROM employees
    GROUP BY department_id
);

-- 等价于：大于最大平均值
SELECT name, salary
FROM employees
WHERE salary > (
    SELECT MAX(avg_sal)
    FROM (
        SELECT AVG(salary) AS avg_sal
        FROM employees
        GROUP BY department_id
    ) AS t
);

-- = ANY 等同于 IN
SELECT name FROM employees
WHERE department_id = ANY (SELECT id FROM departments WHERE name LIKE '%部');

-- 等价于
SELECT name FROM employees
WHERE department_id IN (SELECT id FROM departments WHERE name LIKE '%部');
```

### 5.6 EXISTS 和 NOT EXISTS

**EXISTS：判断子查询是否返回结果。**

```sql
-- 查询有下属的员工（是经理）
SELECT e.id, e.name
FROM employees e
WHERE EXISTS (
    SELECT 1 FROM employees e2
    WHERE e2.manager_id = e.id
);

-- 查询没有下属的员工（普通员工）
SELECT e.id, e.name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1 FROM employees e2
    WHERE e2.manager_id = e.id
);

-- 查询有订单的用户
SELECT * FROM users u
WHERE EXISTS (
    SELECT 1 FROM orders o
    WHERE o.user_id = u.id
);

-- EXISTS vs IN 性能对比
-- EXISTS：适合子查询结果集较大，外层查询结果集较小
-- IN：适合子查询结果集较小，外层查询结果集较大
```

### 5.7 相关子查询与非相关子查询

| 类型 | 说明 | 特点 |
|------|------|------|
| **非相关子查询** | 子查询不依赖外层查询 | 先执行子查询，只执行一次 |
| **相关子查询** | 子查询依赖外层查询 | 每行都执行子查询，效率较低 |

```sql
-- 非相关子查询：子查询独立执行
SELECT name FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 相关子查询：子查询引用外层表的字段
SELECT e1.name, e1.salary, e1.department_id
FROM employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id  -- 引用外层表
);
-- 相关子查询：对每个员工，计算其所在部门的平均工资，再比较

-- 相关子查询改写为JOIN（性能更好）
SELECT e1.name, e1.salary, e1.department_id
FROM employees e1
INNER JOIN (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) e2 ON e1.department_id = e2.department_id
WHERE e1.salary > e2.avg_salary;
```

### 5.8 子查询在SELECT子句中

```sql
-- 查询员工信息及其部门平均工资
SELECT 
    e.name,
    e.salary,
    e.department_id,
    (SELECT AVG(e2.salary)
     FROM employees e2
     WHERE e2.department_id = e.department_id) AS dept_avg_salary
FROM employees e;

-- 查询每个部门的员工数（使用子查询）
SELECT 
    d.name,
    (SELECT COUNT(*)
     FROM employees e
     WHERE e.department_id = d.id) AS emp_count
FROM departments d;
```

### 5.9 子查询在FROM子句中（派生表）

```sql
-- 查询平均工资大于5000的部门
SELECT t.department_id, t.avg_salary
FROM (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) t
WHERE t.avg_salary > 5000;

-- 配合WITH子句（MySQL 8.0+，公共表表达式CTE）
WITH dept_avg AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT e.name, e.salary, d.avg_salary
FROM employees e
INNER JOIN dept_avg d ON e.department_id = d.department_id
WHERE e.salary > d.avg_salary;
```

---

## 六、GROUP BY 分组查询

### 6.1 基本分组

```sql
-- 按部门分组，统计每个部门的员工数
SELECT department_id, COUNT(*) AS emp_count
FROM employees
GROUP BY department_id;

-- 按部门分组，统计平均工资
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

-- 多字段分组
SELECT department_id, position, COUNT(*) AS emp_count, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id, position;
```

### 6.2 HAVING 分组过滤

```sql
-- HAVING：过滤分组后的结果
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 5000;

-- WHERE + GROUP BY + HAVING
SELECT department_id, COUNT(*) AS emp_count
FROM employees
WHERE salary > 3000  -- 先过滤行
GROUP BY department_id
HAVING COUNT(*) > 5;  -- 再过滤分组

-- 多条件过滤
SELECT department_id, AVG(salary) AS avg_salary, COUNT(*) AS emp_count
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 5000 AND COUNT(*) > 3;
```

### 6.3 WHERE vs HAVING

| 子句 | 作用 | 过滤对象 |
|------|------|---------|
| WHERE | 过滤数据行 | 原始记录 |
| HAVING | 过滤分组 | 分组结果 |

```sql
-- WHERE：先过滤再分组
SELECT department_id, COUNT(*) AS emp_count
FROM employees
WHERE salary > 5000  -- 过滤工资>5000的员工
GROUP BY department_id;

-- HAVING：先分组再过滤
SELECT department_id, COUNT(*) AS emp_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5;  -- 过滤员工数>5的部门

-- 组合使用
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
WHERE status = 'active'       -- WHERE：过滤在职员工
GROUP BY department_id
HAVING AVG(salary) > 5000;    -- HAVING：过滤平均工资>5000的部门
```

### 6.4 GROUP BY + WITH ROLLUP

```sql
-- WITH ROLLUP：在结果中添加汇总行
SELECT 
    department_id,
    COUNT(*) AS emp_count,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id WITH ROLLUP;

-- 结果示例：
-- department_id | emp_count | avg_salary
-- 1             | 10        | 6500
-- 2             | 8         | 5500
-- NULL          | 18        | 6000      ← 汇总行
```

---

## 七、ORDER BY 排序

### 7.1 基本排序

```sql
-- 升序（默认）
SELECT * FROM employees ORDER BY salary ASC;

-- 降序
SELECT * FROM employees ORDER BY salary DESC;

-- 多字段排序（先按部门升序，再按工资降序）
SELECT * FROM employees
ORDER BY department_id ASC, salary DESC;
```

### 7.2 自定义排序

```sql
-- 使用FIELD函数自定义排序顺序
SELECT * FROM employees
ORDER BY FIELD(position, '经理', '主管', '员工');

-- 使用CASE WHEN自定义排序
SELECT * FROM employees
ORDER BY
    CASE status
        WHEN 'active' THEN 1
        WHEN 'pending' THEN 2
        WHEN 'inactive' THEN 3
        ELSE 4
    END;

-- 按汉字拼音排序
SELECT * FROM employees
ORDER BY CONVERT(name USING gbk);
```

### 7.3 NULL值排序

```sql
-- NULL值在升序时排在前面，降序时排在后面
-- 使用IS NULL自定义NULL值位置

-- NULL值排在最后（升序）
SELECT * FROM employees
ORDER BY bonus IS NULL, bonus ASC;

-- NULL值排在最前（降序）
SELECT * FROM employees
ORDER BY bonus IS NOT NULL DESC, bonus DESC;
```

---

## 八、LIMIT 分页

### 8.1 基本分页

```sql
-- LIMIT n：返回前n条记录
SELECT * FROM employees LIMIT 10;

-- LIMIT offset, count：从offset位置开始，返回count条记录
SELECT * FROM employees LIMIT 0, 10;   -- 第1页，每页10条
SELECT * FROM employees LIMIT 10, 10;  -- 第2页
SELECT * FROM employees LIMIT 20, 10;  -- 第3页

-- LIMIT count OFFSET offset（推荐写法）
SELECT * FROM employees LIMIT 10 OFFSET 0;   -- 第1页
SELECT * FROM employees LIMIT 10 OFFSET 10;  -- 第2页
SELECT * FROM employees LIMIT 10 OFFSET 20;  -- 第3页
```

### 8.2 分页查询公式

```sql
-- 第 page 页，每页 size 条记录
-- OFFSET = (page - 1) * size

-- Java代码示例：
int page = 2;  // 第2页
int size = 10; // 每页10条
int offset = (page - 1) * size;  // offset = 10

-- SQL:
SELECT * FROM employees
ORDER BY id
LIMIT size OFFSET offset;
-- LIMIT 10 OFFSET 10;
```

### 8.3 分页优化

```sql
-- 普通分页（偏移量大时性能差）
SELECT * FROM employees ORDER BY id LIMIT 100000, 10;

-- 优化1：使用WHERE条件过滤
SELECT * FROM employees
WHERE id > 100000
ORDER BY id
LIMIT 10;

-- 优化2：使用JOIN（覆盖索引）
SELECT e.*
FROM employees e
INNER JOIN (
    SELECT id FROM employees ORDER BY id LIMIT 100000, 10
) t ON e.id = t.id;
```

---

## 九、实战案例：复杂查询

### 9.1 案例一：销售排行榜

```sql
-- 查询销售额TOP 10的用户
SELECT 
    u.id,
    u.name,
    COUNT(o.id) AS order_count,
    SUM(o.total_amount) AS total_amount
FROM users u
INNER JOIN orders o ON u.id = o.user_id
WHERE o.status = '已完成'
GROUP BY u.id
ORDER BY total_amount DESC
LIMIT 10;
```

### 9.2 案例二：部门薪资统计

```sql
-- 查询各部门薪资统计（平均工资、最高工资、最低工资、员工数）
SELECT 
    d.name AS department_name,
    COUNT(e.id) AS emp_count,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    MAX(e.salary) AS max_salary,
    MIN(e.salary) AS min_salary,
    SUM(e.salary) AS total_salary
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.id
ORDER BY avg_salary DESC;
```

### 9.3 案例三：同期对比分析

```sql
-- 查询商品本月销量与上月销量的对比
WITH this_month AS (
    SELECT product_id, SUM(quantity) AS qty
    FROM order_items
    WHERE create_time >= DATE_FORMAT(NOW(), '%Y-%m-01')
      AND create_time < DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-01'), INTERVAL 1 MONTH)
    GROUP BY product_id
),
last_month AS (
    SELECT product_id, SUM(quantity) AS qty
    FROM order_items
    WHERE create_time >= DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 1 MONTH), '%Y-%m-01')
      AND create_time < DATE_FORMAT(NOW(), '%Y-%m-01')
    GROUP BY product_id
)
SELECT 
    p.name AS product_name,
    COALESCE(t.qty, 0) AS this_month_qty,
    COALESCE(l.qty, 0) AS last_month_qty,
    CASE 
        WHEN COALESCE(l.qty, 0) = 0 THEN 'NEW'
        ELSE CONCAT(ROUND((COALESCE(t.qty, 0) - l.qty) / l.qty * 100, 2), '%')
    END AS growth_rate
FROM products p
LEFT JOIN this_month t ON p.id = t.product_id
LEFT JOIN last_month l ON p.id = l.product_id
WHERE COALESCE(t.qty, 0) > 0 OR COALESCE(l.qty, 0) > 0;
```

---

> 💡 **小结**：本章详细介绍了 MySQL 的查询进阶知识，包括 SELECT 完整语法、各类运算符、WHERE 条件查询、多表连接查询、子查询与嵌套查询、GROUP BY 分组、ORDER BY 排序和 LIMIT 分页。掌握这些查询技巧后，可以应对绝大多数的数据库查询需求。
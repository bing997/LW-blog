-- ============================================================
-- 博客文档案例统一数据库脚本
-- 数据库名: blog_demo_db
-- 说明: 整合MySQL和JDBC博客文档中所有案例代码所需的数据库表结构和数据
-- 
-- 表名映射速查（博客文档中的表名 -> 本脚本中的表/视图）：
--   emp / tb_employee     -> employees 物理表 / 同名可更新视图
--   dept / tb_department  -> departments 物理表 / 同名视图
--   tb_account            -> account 物理表 / 同名视图
--   tb_order              -> orders 物理表 / 同名视图
--   tb_product            -> products 物理表 / 同名视图
--   tb_category           -> categories 物理表 / 同名视图
--   tb_order_item         -> order_items 物理表 / 同名视图
--   users / user          -> users / user 物理表
--   tb_customer           -> tb_customer 物理表
--   tb_clazz / tb_class   -> tb_clazz / tb_class 物理表
--   tb_stu / tb_student   -> tb_stu / tb_student 物理表
--   tb_course / courses   -> tb_course / courses 物理表
--   tb_score              -> tb_score 物理表
--   tb_student_course     -> tb_student_course 物理表
--   student_basic         -> student_basic 物理表
--   student_profile       -> student_profile 物理表
--   tb_user / tb_idcard   -> tb_user / tb_idcard 物理表
--   tb_log                -> tb_log 物理表
--   tb_transfer_log       -> tb_transfer_log 物理表
--   tb_address            -> tb_address 物理表
--   tb_cart               -> tb_cart 物理表
--   tb_review             -> tb_review 物理表
--   tb_goods_temp         -> tb_goods_temp 物理表
--   user_info / order_info-> user_info / order_info 物理表
-- ============================================================

DROP DATABASE IF EXISTS blog_demo_db;
CREATE DATABASE blog_demo_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE blog_demo_db;

-- ============================================================
-- 一、部门与员工相关表（覆盖MySQL查询进阶、JDBC关联关系、索引优化、基础篇等）
-- ============================================================

-- 部门表（合并 departments + dept）
CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '部门ID',
    name VARCHAR(50) NOT NULL COMMENT '部门名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

INSERT INTO departments (name) VALUES
('技术部'), ('销售部'), ('财务部'), ('人事部'), ('产品部');

-- 员工表（综合版：合并 employees + emp + tb_employee）
-- 字段涵盖：查询进阶、JDBC CRUD、基础篇自关联、索引优化等所有案例需求
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '员工ID',
    name VARCHAR(50) NOT NULL COMMENT '姓名',
    salary DECIMAL(10, 2) COMMENT '工资',
    department_id INT COMMENT '部门ID（用于JOIN查询）',
    dept_id INT COMMENT '部门ID（用于JDBC示例）',
    manager_id INT COMMENT '上级ID（自关联）',
    position VARCHAR(30) COMMENT '职位',
    email VARCHAR(50) COMMENT '邮箱',
    age INT COMMENT '年龄',
    hire_date DATE COMMENT '入职日期',
    status TINYINT DEFAULT 1 COMMENT '状态:1在职 0离职',
    bonus DECIMAL(10, 2) COMMENT '奖金',
    department VARCHAR(50) COMMENT '部门名称（用于查询进阶示例）',
    
    FOREIGN KEY (department_id) REFERENCES departments(id),
    FOREIGN KEY (dept_id) REFERENCES departments(id),
    FOREIGN KEY (manager_id) REFERENCES employees(id),
    
    INDEX idx_department(department_id),
    INDEX idx_dept_id(dept_id),
    INDEX idx_name(name),
    INDEX idx_salary(salary),
    INDEX idx_hire_date(hire_date),
    UNIQUE INDEX idx_email(email),
    INDEX idx_dept_salary(department_id, salary)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='员工表';

INSERT INTO employees (name, salary, department_id, dept_id, manager_id, position, email, age, hire_date, status, bonus, department) VALUES
('王总', 50000, NULL, NULL, NULL, 'CEO', 'wang@company.com', 45, '2018-01-10', 1, 5000, '管理层'),
('张经理', 25000, 1, 1, 1, '技术总监', 'zhang@company.com', 38, '2019-03-15', 1, 3000, '技术部'),
('李经理', 22000, 3, 3, 1, '产品总监', 'li@company.com', 35, '2019-06-20', 1, 2500, '产品部'),
('王经理', 20000, 2, 2, 1, '销售总监', 'wangjl@company.com', 36, '2019-02-10', 1, 2800, '销售部'),
('赵经理', 18000, 4, 4, 1, '人事总监', 'zhao@company.com', 34, '2020-01-05', 1, 2000, '人事部'),
('小刘', 12000, 1, 1, 2, 'Java工程师', 'liu@company.com', 28, '2021-05-10', 1, 1200, '技术部'),
('小陈', 11000, 1, 1, 2, '前端工程师', 'chen@company.com', 26, '2021-08-15', 1, 1000, '技术部'),
('小张', 10000, 2, 2, 4, '销售代表', 'zhangxs@company.com', 25, '2022-03-01', 1, 800, '销售部'),
('小李', 9000, 2, 2, 4, '销售助理', 'lixs@company.com', 24, '2022-06-10', 1, 600, '销售部'),
('小赵', 8000, 4, 4, 5, 'HR专员', 'zhaohr@company.com', 23, '2023-01-15', 1, 500, '人事部'),
('孙八', 15000, 1, 1, 2, '架构师', 'sun@company.com', 32, '2020-09-01', 1, 2000, '技术部'),
('周九', 13000, 3, 3, 3, '产品经理', 'zhou@company.com', 29, '2021-02-20', 1, 1500, '产品部'),
('吴十', 9500, 2, 2, 4, '客户经理', 'wu@company.com', 27, '2021-11-11', 1, 900, '销售部'),
('郑十一', 8500, 4, 4, 5, '招聘专员', 'zheng@company.com', 24, '2022-09-01', 1, 700, '人事部'),
('钱七', 16000, 1, 1, 2, '高级Java工程师', 'qian@company.com', 30, '2020-05-15', 1, 1800, '技术部');

-- ============================================================
-- 二、顾客表（MySQL数据库操作实战）
-- ============================================================

CREATE TABLE tb_customer (
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT COMMENT '顾客编号',
    name VARCHAR(20) NOT NULL COMMENT '顾客姓名',
    birthday DATE COMMENT '顾客生日',
    sex ENUM('男', '女') DEFAULT '男' COMMENT '顾客性别',
    tel CHAR(11) UNIQUE NOT NULL COMMENT '手机号码',
    address VARCHAR(100) COMMENT '收货地址',
    is_vip TINYINT UNSIGNED DEFAULT 0 COMMENT 'VIP: 1是 0否',
    remark VARCHAR(100) COMMENT '备注信息',
    create_time DATETIME DEFAULT NOW() COMMENT '创建时间',
    update_time DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='顾客信息表';

INSERT INTO tb_customer (name, birthday, sex, tel, address, is_vip) VALUES
('张三', '1990-05-20', '男', '13800138000', '北京市朝阳区', 1),
('李四', '1995-08-15', '女', '13800138001', '上海市浦东新区', 0),
('王五', '1988-12-01', '男', '13800138002', '广州市天河区', 1),
('赵六', '1992-03-10', '女', '13800138003', '深圳市南山区', 0),
('孙七', '1998-07-22', '男', '13800138004', '杭州市西湖区', 0);

-- ============================================================
-- 三、电商系统表（MySQL数据库操作实战 + 数据库设计）
-- ============================================================

-- 用户表（合并 电商users + 权限管理users + 位运算users）
CREATE TABLE users (
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
    username VARCHAR(20) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(100) NOT NULL COMMENT '密码',
    email VARCHAR(50) UNIQUE COMMENT '邮箱',
    phone CHAR(11) UNIQUE COMMENT '手机号',
    avatar VARCHAR(255) COMMENT '头像URL',
    permissions TINYINT DEFAULT 7 COMMENT '权限位：读(1),写(2),删(4)',
    status TINYINT UNSIGNED DEFAULT 1 COMMENT '状态: 1正常 0禁用',
    create_time DATETIME DEFAULT NOW() COMMENT '创建时间',
    update_time DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT '更新时间',
    INDEX idx_username (username),
    INDEX idx_phone (phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

INSERT INTO users (username, password, email, phone, status, permissions) VALUES
('admin', 'admin123', 'admin@shop.com', '13900000001', 1, 7),
('zhangsan', 'zs123456', 'zhangsan@shop.com', '13900000002', 1, 3),
('lisi', 'ls123456', 'lisi@shop.com', '13900000003', 1, 1),
('wangwu', 'ww123456', 'wangwu@shop.com', '13900000004', 1, 3),
('zhaoliu', 'zl123456', NULL, '13900000005', 0, 1);

-- 商品分类表
CREATE TABLE categories (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT COMMENT '分类ID',
    name VARCHAR(50) NOT NULL COMMENT '分类名称',
    parent_id INT UNSIGNED DEFAULT 0 COMMENT '父分类ID',
    sort_order INT DEFAULT 0 COMMENT '排序',
    create_time DATETIME DEFAULT NOW(),
    INDEX idx_parent_id (parent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';

INSERT INTO categories (name, parent_id, sort_order) VALUES
('电子产品', 0, 1),
('手机', 1, 1),
('电脑', 1, 2),
('服装', 0, 2),
('男装', 4, 1),
('女装', 4, 2),
('食品', 0, 3),
('零食', 7, 1),
('生鲜', 7, 2);

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

INSERT INTO products (name, category_id, price, stock, description, status) VALUES
('iPhone 15 Pro', 2, 7999.00, 100, '苹果最新旗舰手机', 1),
('MacBook Pro 16', 3, 19999.00, 50, '苹果专业笔记本', 1),
('华为Mate 60', 2, 5999.00, 200, '华为旗舰手机', 1),
('小米14', 2, 3999.00, 300, '小米旗舰手机', 1),
('男士T恤', 5, 99.00, 500, '纯棉舒适T恤', 1),
('女士连衣裙', 6, 299.00, 200, '优雅气质连衣裙', 1),
('巧克力', 8, 59.00, 1000, '进口黑巧克力', 1),
('苹果', 9, 9.90, 500, '新鲜红富士苹果', 1),
('iPad Pro', 3, 6999.00, 80, '苹果平板', 1),
('男士牛仔裤', 5, 199.00, 300, '修身牛仔裤', 1);

-- 订单表（合并 orders + tb_order）
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

INSERT INTO orders (order_no, user_id, total_amount, status, address, create_time, pay_time) VALUES
('ORDER202401010001', 1, 7999.00, 3, '北京市朝阳区', '2024-01-01 10:00:00', '2024-01-01 10:05:00'),
('ORDER202401010002', 2, 19999.00, 2, '上海市浦东新区', '2024-01-02 14:30:00', '2024-01-02 14:35:00'),
('ORDER202401020001', 1, 5999.00, 1, '北京市朝阳区', '2024-01-03 09:00:00', '2024-01-03 09:10:00'),
('ORDER202401030001', 3, 398.00, 0, '广州市天河区', '2024-01-04 16:00:00', NULL),
('ORDER202401040001', 2, 3999.00, 3, '上海市浦东新区', '2024-01-05 11:00:00', '2024-01-05 11:05:00'),
('ORDER202401050001', 4, 59.00, 4, '深圳市南山区', '2024-01-06 08:00:00', NULL),
('ORDER202401060001', 1, 6999.00, 2, '北京市朝阳区', '2024-01-07 15:00:00', '2024-01-07 15:10:00'),
('ORDER202401070001', 3, 199.00, 3, '广州市天河区', '2024-01-08 13:00:00', '2024-01-08 13:05:00');

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

INSERT INTO order_items (order_id, product_id, product_name, price, quantity, subtotal) VALUES
(1, 1, 'iPhone 15 Pro', 7999.00, 1, 7999.00),
(2, 2, 'MacBook Pro 16', 19999.00, 1, 19999.00),
(3, 3, '华为Mate 60', 5999.00, 1, 5999.00),
(4, 5, '男士T恤', 99.00, 2, 198.00),
(4, 6, '女士连衣裙', 299.00, 1, 299.00),
(5, 4, '小米14', 3999.00, 1, 3999.00),
(6, 7, '巧克力', 59.00, 1, 59.00),
(7, 9, 'iPad Pro', 6999.00, 1, 6999.00),
(8, 10, '男士牛仔裤', 199.00, 1, 199.00);

-- ============================================================
-- 四、日志表（存储引擎/性能优化示例）
-- ============================================================

CREATE TABLE tb_log (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    log_level VARCHAR(10) COMMENT '日志级别',
    message TEXT COMMENT '日志内容',
    create_time DATETIME DEFAULT NOW()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='日志表';

INSERT INTO tb_log (log_level, message, create_time) VALUES
('INFO', '系统启动成功', '2024-01-01 00:00:00'),
('INFO', '用户登录', '2024-01-01 08:30:00'),
('WARN', '数据库连接池达到阈值', '2024-01-01 12:00:00'),
('ERROR', '订单处理异常', '2024-01-01 14:00:00'),
('INFO', '定时任务执行完成', '2024-01-01 23:00:00');

-- ============================================================
-- 五、账户与转账表（MySQL事务 + JDBC事务）
-- ============================================================

-- 账户表（合并 account + tb_account）
CREATE TABLE account (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '账户ID',
    user_id BIGINT COMMENT '用户ID',
    name VARCHAR(20) NOT NULL COMMENT '账户名称',
    balance DECIMAL(10, 2) DEFAULT 0.00 COMMENT '余额'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='账户表';

INSERT INTO account (user_id, name, balance) VALUES
(1, 'A', 1000.00),
(2, 'B', 1000.00),
(3, 'C', 5000.00),
(4, 'D', 3000.00),
(NULL, '张三', 8000.00),
(NULL, '李四', 5000.00);

-- 转账日志表
CREATE TABLE tb_transfer_log (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    from_id INT NOT NULL COMMENT '转出账户ID',
    to_id INT NOT NULL COMMENT '转入账户ID',
    amount DECIMAL(10, 2) NOT NULL COMMENT '转账金额',
    transfer_time DATETIME DEFAULT NOW() COMMENT '转账时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='转账日志表';

-- ============================================================
-- 六、学生管理系统表（JDBC实战 + MySQL基础篇）
-- ============================================================

-- 班级表（合并 classes + tb_clazz）
CREATE TABLE tb_clazz (
    clazzId INT PRIMARY KEY AUTO_INCREMENT COMMENT '班级ID',
    clazzName VARCHAR(30) NOT NULL COMMENT '班级名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='班级表';

INSERT INTO tb_clazz (clazzName) VALUES
('Java一班'), ('Java二班'), ('Python一班'), ('前端一班');

-- 学生表（合并 students + tb_stu）
CREATE TABLE tb_stu (
    stuNo VARCHAR(10) PRIMARY KEY COMMENT '学号',
    stuName VARCHAR(20) NOT NULL COMMENT '姓名',
    stuInDate DATE COMMENT '入学时间',
    stuBirth DATE COMMENT '生日',
    stuSex CHAR(2) DEFAULT '男' COMMENT '性别',
    clazz_id INT COMMENT '班级ID（外键）',
    FOREIGN KEY (clazz_id) REFERENCES tb_clazz(clazzId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生表';

INSERT INTO tb_stu (stuNo, stuName, stuInDate, stuBirth, stuSex, clazz_id) VALUES
('0509301-01', '张三', '2022-09-01', '1999-09-09', '男', 1),
('0509301-02', '李四', '2022-09-01', '2000-01-09', '女', 1),
('0509301-03', '王五', '2022-09-01', '2001-02-02', '男', 1),
('0509301-04', '赵六', '2022-09-01', '1998-08-09', '男', 1),
('0509302-01', 'jack', '2022-09-01', '1999-09-09', '男', 2),
('0509302-02', 'tom', '2022-09-01', '2000-01-09', '女', 2),
('0509302-03', 'rose', '2022-09-01', '2001-02-02', '男', 2),
('0509302-04', 'lili', '2022-09-01', '1998-08-09', '男', 2),
('0509303-01', 'jdbc', '2022-09-01', '1999-09-09', '男', 3),
('0509303-02', 'mysql', '2022-09-01', '2000-01-09', '女', 3),
('0509304-01', 'vue', '2022-09-01', '2000-05-10', '男', 4),
('0509304-02', 'react', '2022-09-01', '2001-08-20', '女', 4);

-- ============================================================
-- 七、学生选课表（MySQL基础篇多对多）
-- ============================================================

-- 课程表
CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '课程ID',
    name VARCHAR(50) NOT NULL COMMENT '课程名',
    credit INT COMMENT '学分'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程表';

INSERT INTO courses (name, credit) VALUES
('高等数学', 4),
('大学英语', 3),
('计算机基础', 2),
('数据结构', 4),
('操作系统', 3);

-- 选课中间表
CREATE TABLE student_courses (
    student_id INT COMMENT '学生ID',
    course_id INT COMMENT '课程ID',
    score DECIMAL(5, 2) COMMENT '成绩',
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES tb_stu(stuNo),  -- 注意：这里使用stuNo作为主键，可能需要调整
    FOREIGN KEY (course_id) REFERENCES courses(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='选课中间表';

-- 注意：student_courses 的外键需要调整，因为tb_stu的主键是stuNo(VARCHAR)
-- 为了统一，我们使用单独的学生信息表来支持多对多关系

-- 学生信息表（用于多对多关系，使用INT主键）
CREATE TABLE students_info (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    age INT,
    gender CHAR(1) DEFAULT '男'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生信息表（用于多对多示例）';

INSERT INTO students_info (name, age, gender) VALUES
('张三', 20, '男'),
('李四', 21, '女'),
('王五', 22, '男');

-- 重新创建选课中间表（使用students_info的id）
DROP TABLE IF EXISTS student_courses;
CREATE TABLE student_courses (
    student_id INT COMMENT '学生ID',
    course_id INT COMMENT '课程ID',
    score DECIMAL(5, 2) COMMENT '成绩',
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students_info(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='选课中间表';

INSERT INTO student_courses (student_id, course_id, score) VALUES
(1, 1, 85.5),
(1, 2, 90.0),
(2, 1, 78.0),
(2, 3, 92.5),
(3, 2, 88.0),
(3, 4, 95.0);

-- ============================================================
-- 八、学生档案表（MySQL基础篇一对一）
-- ============================================================

CREATE TABLE student_basic (
    no INT PRIMARY KEY COMMENT '学号',
    name VARCHAR(20) NOT NULL COMMENT '姓名',
    age INT COMMENT '年龄',
    sex CHAR(1) DEFAULT '男' COMMENT '性别',
    major VARCHAR(20) COMMENT '专业',
    tel CHAR(11) UNIQUE NOT NULL COMMENT '手机号码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生基本信息表';

INSERT INTO student_basic (no, name, age, sex, major, tel) VALUES
(1001, '张三', 20, '男', '计算机科学', '13800000001'),
(1002, '李四', 21, '女', '软件工程', '13800000002'),
(1003, '王五', 22, '男', '网络工程', '13800000003');

CREATE TABLE student_profile (
    no INT PRIMARY KEY COMMENT '学号（主键+外键）',
    id_card CHAR(18) UNIQUE COMMENT '身份证号',
    email VARCHAR(50) UNIQUE COMMENT '邮箱',
    address VARCHAR(100) COMMENT '家庭地址',
    native_place VARCHAR(20) COMMENT '籍贯',
    contact_person VARCHAR(20) COMMENT '紧急联系人',
    FOREIGN KEY (no) REFERENCES student_basic(no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生档案信息表';

INSERT INTO student_profile (no, id_card, email, address, native_place, contact_person) VALUES
(1001, '110101199909091234', 'zhangsan@edu.com', '北京市海淀区', '北京', '张大'),
(1002, '310101200001011234', 'lisi@edu.com', '上海市浦东新区', '上海', '李二'),
(1003, '440101200102021234', 'wangwu@edu.com', '广州市天河区', '广州', '王三');

-- ============================================================
-- 九、EXPLAIN测试表（MySQL事务与性能优化）
-- ============================================================

CREATE TABLE user_info (
    id BIGINT(20) NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL DEFAULT '',
    age INT(11) DEFAULT NULL,
    PRIMARY KEY (id),
    KEY name_index (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息表（EXPLAIN测试）';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单信息表（EXPLAIN测试）';

INSERT INTO order_info (user_id, product_name, productor) VALUES
(1, 'p1', 'WHH'), (1, 'p2', 'WL'), (1, 'p1', 'DX'),
(2, 'p1', 'WHH'), (2, 'p5', 'WL'), (3, 'p3', 'MA'),
(4, 'p1', 'WHH'), (6, 'p1', 'WHH');

-- ============================================================
-- 十、商品临时表（JDBC批处理测试）
-- ============================================================

CREATE TABLE tb_goods_temp (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '商品ID',
    name VARCHAR(100) NOT NULL COMMENT '商品名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品临时表（批处理测试）';

-- ============================================================
-- 十一、数据库设计篇补充表
-- ============================================================

-- 收货地址表
CREATE TABLE tb_address (
    address_id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '地址ID',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    receiver_name VARCHAR(20) COMMENT '收件人',
    receiver_phone VARCHAR(20) COMMENT '收件人手机',
    province VARCHAR(20) COMMENT '省',
    city VARCHAR(20) COMMENT '市',
    district VARCHAR(20) COMMENT '区',
    detail_address VARCHAR(200) COMMENT '详细地址',
    is_default TINYINT DEFAULT 0 COMMENT '是否默认:1是 0否',
    INDEX idx_user_id(user_id),
    FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='收货地址表';

INSERT INTO tb_address (user_id, receiver_name, receiver_phone, province, city, district, detail_address, is_default) VALUES
(1, '张三', '13900000001', '北京市', '北京市', '朝阳区', '建国路88号', 1),
(2, '李四', '13900000002', '上海市', '上海市', '浦东新区', '陆家嘴环路1000号', 1),
(3, '王五', '13900000003', '广东省', '广州市', '天河区', '天河路123号', 1);

-- 购物车表
CREATE TABLE tb_cart (
    cart_id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '购物车ID',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    product_id BIGINT NOT NULL COMMENT '商品ID',
    quantity INT DEFAULT 1 COMMENT '数量',
    add_time DATETIME DEFAULT NOW() COMMENT '加入时间',
    UNIQUE INDEX idx_user_product(user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车表';

INSERT INTO tb_cart (user_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(3, 4, 1);

-- 评论表
CREATE TABLE tb_review (
    review_id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '评论ID',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    product_id BIGINT NOT NULL COMMENT '商品ID',
    order_id BIGINT COMMENT '订单ID',
    rating TINYINT COMMENT '评分:1-5',
    content TEXT COMMENT '评论内容',
    images VARCHAR(500) COMMENT '评论图片',
    create_time DATETIME DEFAULT NOW() COMMENT '评论时间',
    INDEX idx_product_id(product_id),
    INDEX idx_user_id(user_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评论表';

INSERT INTO tb_review (user_id, product_id, order_id, rating, content, create_time) VALUES
(1, 1, 1, 5, '手机非常好用，拍照效果很棒！', '2024-01-10 10:00:00'),
(2, 2, 2, 5, 'MacBook性能强劲，非常满意！', '2024-01-12 14:00:00'),
(1, 3, 3, 4, '华为手机信号很好，支持国产！', '2024-01-15 09:00:00'),
(3, 5, 4, 4, 'T恤质量不错，穿着舒适。', '2024-01-20 16:00:00');

-- ============================================================
-- 十二、视图示例数据准备（MySQL高级特性：视图与DCL）
-- ============================================================

-- 创建视图（需要在表创建之后）
CREATE VIEW vw_employee_department AS
SELECT e.id, e.name, e.salary, d.name AS department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;

CREATE VIEW vw_high_salary_employee AS
SELECT id, name, salary, department
FROM employees
WHERE salary > 15000;

CREATE VIEW vw_order_detail AS
SELECT 
    o.order_no,
    u.username,
    o.total_amount,
    o.status,
    o.create_time
FROM orders o
INNER JOIN users u ON o.user_id = u.id;

CREATE VIEW vw_product_category AS
SELECT 
    p.id AS product_id,
    p.name AS product_name,
    c.name AS category_name,
    p.price,
    p.stock
FROM products p
INNER JOIN categories c ON p.category_id = c.id;

-- ============================================================
-- 十三、博客文档兼容视图（基于核心表创建，确保案例SQL可直接运行）
-- ============================================================

-- JDBC emp/dept 兼容视图
CREATE VIEW emp AS SELECT id, name, salary, dept_id FROM employees;
CREATE VIEW dept AS SELECT id, name FROM departments;

-- MySQL高级特性：视图与DCL 兼容视图
CREATE VIEW tb_employee AS 
SELECT id, name, department_id, position, salary, status, hire_date, email, age, department 
FROM employees;

CREATE VIEW tb_department AS 
SELECT id, id AS dept_id, name, name AS dept_name, '总部' AS location FROM departments;

-- MySQL事务与性能优化/数据库设计兼容视图
CREATE VIEW tb_account AS SELECT id, user_id, name, balance FROM account;

CREATE VIEW tb_order AS 
SELECT id, order_no, user_id, user_id AS customer_id, total_amount, total_amount AS amount, 
    status, address, create_time, pay_time FROM orders;

CREATE VIEW tb_product AS 
SELECT id AS product_id, name AS product_name, category_id, price, stock, 
    description, status, create_time, update_time FROM products;

CREATE VIEW tb_category AS 
SELECT id AS category_id, name AS category_name, parent_id, sort_order, create_time 
FROM categories;

CREATE VIEW tb_order_item AS 
SELECT id AS order_item_id, order_id, product_id, product_name, price, quantity, subtotal 
FROM order_items;

-- 视图与DCL篇示例视图
CREATE VIEW v_employee_basic AS
SELECT id, name, department_id, position, salary FROM tb_employee WHERE status = 1;

CREATE VIEW v_employee_detail AS
SELECT e.id, e.name, e.position, e.salary, d.dept_name AS department_name, d.location
FROM tb_employee e INNER JOIN tb_department d ON e.department_id = d.id;

CREATE VIEW v_employee_salary AS
SELECT id, name, salary, salary * 12 AS annual_salary, salary * 0.1 AS bonus, salary * 1.1 AS total_income
FROM tb_employee WHERE status = 1;

CREATE VIEW v_department_stats AS
SELECT d.id AS department_id, d.dept_name AS department_name, COUNT(e.id) AS employee_count,
    ROUND(AVG(e.salary), 2) AS avg_salary, MAX(e.salary) AS max_salary, MIN(e.salary) AS min_salary
FROM tb_department d LEFT JOIN tb_employee e ON d.id = e.department_id
GROUP BY d.id, d.dept_name;

CREATE VIEW v_employee_public AS
SELECT id, name, department_id, position, hire_date FROM tb_employee;

CREATE VIEW v_monthly_report AS
SELECT DATE_FORMAT(o.create_time, '%Y-%m') AS month, COUNT(*) AS order_count,
    SUM(o.total_amount) AS total_amount, COUNT(DISTINCT o.user_id) AS unique_users
FROM orders o WHERE o.status = 3 GROUP BY DATE_FORMAT(o.create_time, '%Y-%m');

CREATE VIEW v_employee_dept AS SELECT * FROM tb_employee WHERE department_id = 1;
CREATE VIEW v_employee_hr AS SELECT * FROM tb_employee;

-- ============================================================
-- 十四、存储过程和函数（JDBC CallableStatement + MySQL事务）
-- ============================================================

DELIMITER //

-- 计算奖金函数
CREATE FUNCTION calculate_bonus(p_emp_id INT) 
RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE emp_sal DECIMAL(10,2);
    DECLARE emp_bonus DECIMAL(10,2);
    
    SELECT salary INTO emp_sal FROM employees WHERE id = p_emp_id;
    
    IF emp_sal IS NULL THEN 
        RETURN 0.0;
    END IF;
    
    SET emp_bonus = emp_sal * 0.1;
    RETURN emp_bonus;
END //

-- 更新薪资存储过程
CREATE PROCEDURE update_salary(
    IN emp_id INT,
    OUT old_salary DECIMAL(10,2),
    OUT new_salary DECIMAL(10,2)
)
BEGIN
    SELECT salary INTO old_salary FROM employees WHERE id = emp_id;
    UPDATE employees SET salary = salary * 1.1 WHERE id = emp_id;
    SELECT salary INTO new_salary FROM employees WHERE id = emp_id;
END //

-- 银行转账存储过程
CREATE PROCEDURE transfer(
    IN from_account INT,
    IN to_account INT,
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
    
    DECLARE from_balance DECIMAL(10,2);
    SELECT balance INTO from_balance 
    FROM account WHERE id = from_account FOR UPDATE;
    
    IF from_balance < amount THEN
        SET result = '余额不足';
        ROLLBACK;
    ELSE
        UPDATE account SET balance = balance - amount WHERE id = from_account;
        UPDATE account SET balance = balance + amount WHERE id = to_account;
        INSERT INTO tb_transfer_log (from_id, to_id, amount, transfer_time)
        VALUES (from_account, to_account, amount, NOW());
        COMMIT;
        SET result = '转账成功';
    END IF;
END //

DELIMITER ;

-- ============================================================
-- 十五、JDBC与数据库设计篇独立示例表
-- ============================================================

-- JDBC SQL注入示例用表
CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
    name VARCHAR(50) COMMENT '用户名',
    password VARCHAR(100) COMMENT '密码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表（JDBC SQL注入示例）';

INSERT INTO user (name, password) VALUES 
('admin', '123'),
('zhangsan', '123'),
('lisi', '123');

-- 数据库设计：1NF反例
CREATE TABLE tb_user_bad (
    id INT PRIMARY KEY,
    name VARCHAR(20),
    contact VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='1NF反例表';

INSERT INTO tb_user_bad VALUES (1, '张三', '13800138000, zhangsan@qq.com');

-- 数据库设计：2NF/3NF/M:N 综合示例（学生管理系统）
CREATE TABLE tb_class (
    class_id VARCHAR(10) PRIMARY KEY,
    class_name VARCHAR(20) NOT NULL,
    head_teacher VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='班级表（3NF示例）';

INSERT INTO tb_class VALUES ('B01', '一班', '王老师'), ('B02', '二班', '李老师');

CREATE TABLE tb_student (
    student_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    class_id VARCHAR(10),
    major VARCHAR(50),
    FOREIGN KEY (class_id) REFERENCES tb_class(class_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生表（2NF/3NF/M:N综合）';

INSERT INTO tb_student VALUES 
('001', '张三', 'B01', '计算机科学'),
('002', '李四', 'B01', '软件工程'),
('003', '王五', 'B02', '网络工程');

CREATE TABLE tb_course (
    course_id VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    credit INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程表（2NF/M:N综合）';

INSERT INTO tb_course VALUES 
('C01', '数学', 4),
('C02', '英语', 3),
('C03', '计算机基础', 2);

CREATE TABLE tb_score (
    student_id VARCHAR(10),
    course_id VARCHAR(10),
    score DECIMAL(5,2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES tb_student(student_id),
    FOREIGN KEY (course_id) REFERENCES tb_course(course_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='成绩表（2NF示例）';

INSERT INTO tb_score VALUES 
('001', 'C01', 90),
('001', 'C02', 85),
('002', 'C01', 88);

CREATE TABLE tb_student_course (
    student_id VARCHAR(10),
    course_id VARCHAR(10),
    score DECIMAL(5,2),
    select_time DATETIME DEFAULT NOW(),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES tb_student(student_id),
    FOREIGN KEY (course_id) REFERENCES tb_course(course_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='选课中间表（M:N示例）';

INSERT INTO tb_student_course (student_id, course_id, score) VALUES 
('001', 'C01', 90),
('001', 'C02', 85),
('002', 'C01', 88),
('003', 'C03', 92);

-- 数据库设计：一对一示例
CREATE TABLE tb_user (
    user_id BIGINT PRIMARY KEY,
    name VARCHAR(20),
    phone VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表（一对一示例）';

INSERT INTO tb_user VALUES (1, '张三', '13800000001'), (2, '李四', '13800000002');

CREATE TABLE tb_idcard (
    card_id BIGINT PRIMARY KEY,
    user_id BIGINT UNIQUE,
    card_number VARCHAR(18),
    issue_date DATE,
    FOREIGN KEY (user_id) REFERENCES tb_user(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='身份证表（一对一示例）';

INSERT INTO tb_idcard VALUES 
(1, 1, '110101199909091234', '2018-01-01'),
(2, 2, '310101200001011234', '2019-06-01');

-- ============================================================
-- 脚本执行完成
-- ============================================================
SELECT '数据库 blog_demo_db 初始化完成！' AS message;
SELECT CONCAT('共创建 ', (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'blog_demo_db'), ' 张表') AS info;

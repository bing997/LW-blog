---
title: JDBC实战：关联关系配置与项目案例
date: 2024-11-13T00:00:00+08:00
tags:
    - jdbc
    - 教程
    - java
    - 实战
    - DAO模式
categories: jdbc
cover: /images/cover_jdbc.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: "JDBC 实战教程，涵盖表关联关系配置（单向/双向）、DAO 模式完整实现、员工管理案例、学生管理系统项目实战。"
---

## 一、表关联关系配置

### 1.1 需求分析

**需求：** 查询员工信息并且把员工对应的部门信息一并查询出来。

部门和员工是 **1 对 N** 的关系（N-1：多个员工对应同一个部门）。

```
┌──────────┐       ┌──────────┐
│  dept    │  1:N  │   emp    │
│ 部门表    │──────→│  员工表   │
│          │       │          │
│ id       │       │ id       │
│ name     │       │ name     │
│          │       │ dept_id  │ ── 外键关联 dept.id
└──────────┘       └──────────┘
```

### 1.2 创建实体类

```java
// ==================== 部门实体类 ====================
package com.qiufenfen.entity;

import lombok.Data;

@Data
public class Dept {
    private Integer id;
    private String name;
    // 双向关联时才需要：
    // private List<Emp> empList;
}

// ==================== 员工实体类 ====================
package com.qiufenfen.entity;

import lombok.Data;

@Data
public class Emp {
    private Integer id;
    private String name;
    private Double salary;
    private Integer deptId;
    
    // 关联部门（N 的一方配置对 1 的一方的引用）
    private Dept dept;
}
```

### 1.3 单向关联 vs 双向关联

**单向关联（推荐）✓**

在 N 的一方（Emp 类）配置对部门的引用。

```java
// Emp 类中配置
private Dept dept;  // 员工关联的部门

// Dept 类中不配置员工集合
```

**优点：**
- 符合业务访问习惯：通常从员工查找部门，而非从部门遍历所有员工
- 避免数据冗余
- 查询效率高

**双向关联**

在 Dept 类中配置员工集合，同时在 Emp 类中配置部门引用。

```java
// Emp 类中配置
private Dept dept;

// Dept 类中配置
private List<Emp> empList;  // 部门下的所有员工
```

**缺点：**
- 容易导致循环引用
- 查询部门时可能不需要加载所有员工，浪费资源

### 1.4 数据库表结构

```sql
-- 部门表
CREATE TABLE dept (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

-- 员工表
CREATE TABLE emp (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES dept(id)
);
```

---

## 二、DAO 模式实现

### 2.1 DAO 模式介绍

DAO（Data Access Object）数据访问对象，将数据库访问操作封装在 DAO 层，实现业务逻辑与数据访问的分离。

```
┌─────────────┐
│  Service 层  │  业务逻辑
├─────────────┤
│   DAO 层     │  数据访问（CRUD）
├─────────────┤
│  Database    │  数据库
└─────────────┘
```

### 2.2 EmpDAO 接口

```java
package com.qiufenfen.dao;

import com.qiufenfen.entity.Emp;
import java.util.List;

public interface EmpDAO {
    
    // 查询所有员工（带部门信息）
    List<Emp> findAll();
    
    // 根据 ID 查询员工（带部门信息）
    Emp findById(Integer id);
    
    // 添加员工
    int insert(Emp emp);
    
    // 更新员工
    int update(Emp emp);
    
    // 删除员工
    int deleteById(Integer id);
}
```

### 2.3 EmpDAO 实现类

```java
package com.qiufenfen.dao.impl;

import com.qiufenfen.dao.EmpDAO;
import com.qiufenfen.entity.Dept;
import com.qiufenfen.entity.Emp;
import com.qiufenfen.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmpDAOImpl implements EmpDAO {

    // ============================================
    // 方式1：两条 SQL 语句查询
    // ============================================
    @Override
    public Emp findById(Integer id) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Emp emp = null;

        try {
            conn = DBUtil.getConnection();

            // 第一步：查询员工信息
            String sql = "SELECT id, name, salary, dept_id FROM emp WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                emp = new Emp();
                emp.setId(rs.getInt("id"));
                emp.setName(rs.getString("name"));
                emp.setSalary(rs.getDouble("salary"));
                emp.setDeptId(rs.getInt("dept_id"));

                // 第二步：查询部门信息
                Integer deptId = rs.getInt("dept_id");
                if (deptId != null) {
                    ps.close();
                    String deptSql = "SELECT id, name FROM dept WHERE id = ?";
                    ps = conn.prepareStatement(deptSql);
                    ps.setInt(1, deptId);
                    ResultSet deptRs = ps.executeQuery();

                    if (deptRs.next()) {
                        Dept dept = new Dept();
                        dept.setId(deptRs.getInt("id"));
                        dept.setName(deptRs.getString("name"));
                        emp.setDept(dept);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResource(rs, ps, conn);
        }
        return emp;
    }

    // ============================================
    // 方式2：等值连接（推荐，一条 SQL）
    // ============================================
    @Override
    public List<Emp> findAll() {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Emp> list = new ArrayList<>();

        try {
            conn = DBUtil.getConnection();

            // 等值连接查询（一条 SQL 搞定）
            String sql = "SELECT e.id AS emp_id, e.name AS emp_name, e.salary, " +
                         "d.id AS dept_id, d.name AS dept_name " +
                         "FROM emp e " +
                         "INNER JOIN dept d ON e.dept_id = d.id";

            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Emp emp = new Emp();
                emp.setId(rs.getInt("emp_id"));
                emp.setName(rs.getString("emp_name"));
                emp.setSalary(rs.getDouble("salary"));

                // 封装部门信息
                Dept dept = new Dept();
                dept.setId(rs.getInt("dept_id"));
                dept.setName(rs.getString("dept_name"));
                emp.setDept(dept);

                list.add(emp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResource(rs, ps, conn);
        }
        return list;
    }

    @Override
    public int insert(Emp emp) {
        Connection conn = null;
        PreparedStatement ps = null;
        int rows = 0;

        try {
            conn = DBUtil.getConnection();
            String sql = "INSERT INTO emp(name, salary, dept_id) VALUES(?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, emp.getName());
            ps.setDouble(2, emp.getSalary());
            ps.setInt(3, emp.getDeptId());
            rows = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResource(null, ps, conn);
        }
        return rows;
    }

    @Override
    public int update(Emp emp) {
        Connection conn = null;
        PreparedStatement ps = null;
        int rows = 0;

        try {
            conn = DBUtil.getConnection();
            String sql = "UPDATE emp SET name = ?, salary = ?, dept_id = ? WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, emp.getName());
            ps.setDouble(2, emp.getSalary());
            ps.setInt(3, emp.getDeptId());
            ps.setInt(4, emp.getId());
            rows = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResource(null, ps, conn);
        }
        return rows;
    }

    @Override
    public int deleteById(Integer id) {
        Connection conn = null;
        PreparedStatement ps = null;
        int rows = 0;

        try {
            conn = DBUtil.getConnection();
            String sql = "DELETE FROM emp WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rows = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResource(null, ps, conn);
        }
        return rows;
    }
}
```

### 2.4 单元测试

```java
package com.qiufenfen.test;

import com.qiufenfen.dao.EmpDAO;
import com.qiufenfen.dao.impl.EmpDAOImpl;
import com.qiufenfen.entity.Emp;
import org.junit.jupiter.api.Test;
import java.util.List;

public class EmpDAOTest {

    private EmpDAO empDAO = new EmpDAOImpl();

    @Test
    public void testFindById() {
        Emp emp = empDAO.findById(1);
        if (emp != null) {
            System.out.println("员工：" + emp.getName() + 
                "，薪资：" + emp.getSalary() + 
                "，部门：" + emp.getDept().getName());
        }
    }

    @Test
    public void testFindAll() {
        List<Emp> list = empDAO.findAll();
        for (Emp emp : list) {
            System.out.println("员工：" + emp.getName() + 
                "，部门：" + emp.getDept().getName());
        }
    }

    @Test
    public void testInsert() {
        Emp emp = new Emp();
        emp.setName("赵六");
        emp.setSalary(8500);
        emp.setDeptId(1);
        int rows = empDAO.insert(emp);
        System.out.println("插入了 " + rows + " 行");
    }

    @Test
    public void testUpdate() {
        Emp emp = new Emp();
        emp.setId(1);
        emp.setName("张三（已更新）");
        emp.setSalary(10000);
        emp.setDeptId(2);
        int rows = empDAO.update(emp);
        System.out.println("更新了 " + rows + " 行");
    }

    @Test
    public void testDelete() {
        int rows = empDAO.deleteById(10);
        System.out.println("删除了 " + rows + " 行");
    }
}
```

---

## 三、项目实战：学生管理系统

### 3.1 数据库设计

```sql
-- 创建数据库
CREATE DATABASE IF NOT EXISTS student_db
    CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE student_db;

-- ============================
-- 班级表（1 方）
-- ============================
CREATE TABLE tb_clazz (
    clazzId INT PRIMARY KEY AUTO_INCREMENT,
    clazzName VARCHAR(30) NOT NULL COMMENT '班级名称'
);

INSERT INTO tb_clazz (clazzName) VALUES ('Java一班'), ('Java二班'), ('Python一班');

-- ============================
-- 学生表（N 方）
-- ============================
CREATE TABLE tb_stu (
    stuNo VARCHAR(10) PRIMARY KEY COMMENT '学号',
    stuName VARCHAR(20) NOT NULL COMMENT '姓名',
    stuInDate DATE COMMENT '入学时间',
    stuBirth DATE COMMENT '生日',
    stuSex CHAR(2) DEFAULT '男' COMMENT '性别',
    clazz_id INT COMMENT '班级ID（外键）'
);

-- 建立外键关联
ALTER TABLE tb_stu ADD CONSTRAINT fk_stu_clazz
    FOREIGN KEY (clazz_id) REFERENCES tb_clazz(clazzId);

-- ============================
-- 插入学生数据
-- ============================
INSERT INTO tb_stu VALUES
('0509301-01', '张三', '2022-09-01', '1999-09-09', '男', 1),
('0509301-02', '李四', '2022-09-01', '2000-01-09', '女', 1),
('0509301-03', '王五', '2022-09-01', '2001-02-02', '男', 1),
('0509301-04', '赵六', '2022-09-01', '1998-08-09', '男', 1),
('0509302-01', 'jack', '2022-09-01', '1999-09-09', '男', 2),
('0509302-02', 'tom', '2022-09-01', '2000-01-09', '女', 2),
('0509302-03', 'rose', '2022-09-01', '2001-02-02', '男', 2),
('0509302-04', 'lili', '2022-09-01', '1998-08-09', '男', 2),
('0509303-01', 'jdbc', '2022-09-01', '1999-09-09', '男', 3),
('0509303-02', 'mysql', '2022-09-01', '2000-01-09', '女', 3);
```

### 3.2 项目结构

```
student-system/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/qiufenfen/
│   │   │       ├── entity/
│   │   │       │   ├── Clazz.java
│   │   │       │   └── Student.java
│   │   │       ├── dao/
│   │   │       │   ├── ClazzDAO.java
│   │   │       │   ├── StudentDAO.java
│   │   │       │   └── impl/
│   │   │       │       ├── ClazzDAOImpl.java
│   │   │       │       └── StudentDAOImpl.java
│   │   │       ├── service/
│   │   │       │   ├── StudentService.java
│   │   │       │   └── impl/
│   │   │       │       └── StudentServiceImpl.java
│   │   │       ├── util/
│   │   │       │   ├── DBUtil.java
│   │   │       │   └── PageUtil.java
│   │   │       └── Main.java
│   │   └── resources/
│   │       └── jdbc.properties
│   └── test/
│       └── java/
│           └── com/qiufenfen/test/
│               └── StudentDAOTest.java
└── pom.xml
```

### 3.3 实体类

```java
// ==================== Clazz.java ====================
package com.qiufenfen.entity;

import lombok.Data;

@Data
public class Clazz {
    private Integer clazzId;
    private String clazzName;
}

// ==================== Student.java ====================
package com.qiufenfen.entity;

import lombok.Data;
import java.util.Date;

@Data
public class Student {
    private String stuNo;      // 学号（主键）
    private String stuName;    // 姓名
    private Date stuInDate;    // 入学时间
    private Date stuBirth;     // 生日
    private String stuSex;     // 性别
    private Integer clazzId;   // 班级ID
    
    // 关联班级（单向关联）
    private Clazz clazz;
}
```

### 3.4 StudentDAO 接口与实现

```java
// ==================== StudentDAO 接口 ====================
package com.qiufenfen.dao;

import com.qiufenfen.entity.Student;
import com.qiufenfen.util.PageUtil;
import java.util.List;

public interface StudentDAO {
    // 分页查询学生（带班级信息）
    PageUtil<Student> findByPage(int pageNum, int pageSize);
    
    // 根据学号查询学生
    Student findByStuNo(String stuNo);
    
    // 添加学生
    int insert(Student stu);
    
    // 更新学生
    int update(Student stu);
    
    // 删除学生
    int deleteByStuNo(String stuNo);
    
    // 查询总记录数
    long count();
}

// ==================== StudentDAOImpl 实现类 ====================
package com.qiufenfen.dao.impl;

import com.qiufenfen.dao.StudentDAO;
import com.qiufenfen.entity.Clazz;
import com.qiufenfen.entity.Student;
import com.qiufenfen.util.DBUtil;
import com.qiufenfen.util.PageUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAOImpl implements StudentDAO {

    @Override
    public PageUtil<Student> findByPage(int pageNum, int pageSize) {
        PageUtil<Student> page = new PageUtil<>(pageNum, pageSize);
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Student> list = new ArrayList<>();

        try {
            conn = DBUtil.getConnection();

            // 1. 查询总记录数
            String countSql = "SELECT COUNT(*) FROM tb_stu";
            ps = conn.prepareStatement(countSql);
            rs = ps.executeQuery();
            if (rs.next()) {
                page.setTotalRecords(rs.getLong(1));
            }

            // 2. 查询当前页数据（等值连接带班级信息）
            String sql = "SELECT s.*, c.clazzName " +
                         "FROM tb_stu s " +
                         "INNER JOIN tb_clazz c ON s.clazz_id = c.clazzId " +
                         "LIMIT ?, ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, page.getOffset());
            ps.setInt(2, page.getPageSize());
            rs = ps.executeQuery();

            while (rs.next()) {
                Student stu = new Student();
                stu.setStuNo(rs.getString("stuNo"));
                stu.setStuName(rs.getString("stuName"));
                stu.setStuInDate(rs.getDate("stuInDate"));
                stu.setStuBirth(rs.getDate("stuBirth"));
                stu.setStuSex(rs.getString("stuSex"));
                stu.setClazzId(rs.getInt("clazz_id"));

                // 封装班级信息
                Clazz clazz = new Clazz();
                clazz.setClazzId(rs.getInt("clazz_id"));
                clazz.setClazzName(rs.getString("clazzName"));
                stu.setClazz(clazz);

                list.add(stu);
            }
            page.setData(list);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResource(rs, ps, conn);
        }
        return page;
    }

    @Override
    public Student findByStuNo(String stuNo) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Student stu = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT s.*, c.clazzName " +
                         "FROM tb_stu s " +
                         "INNER JOIN tb_clazz c ON s.clazz_id = c.clazzId " +
                         "WHERE s.stuNo = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, stuNo);
            rs = ps.executeQuery();

            if (rs.next()) {
                stu = new Student();
                stu.setStuNo(rs.getString("stuNo"));
                stu.setStuName(rs.getString("stuName"));
                stu.setStuInDate(rs.getDate("stuInDate"));
                stu.setStuBirth(rs.getDate("stuBirth"));
                stu.setStuSex(rs.getString("stuSex"));
                stu.setClazzId(rs.getInt("clazz_id"));

                Clazz clazz = new Clazz();
                clazz.setClazzId(rs.getInt("clazz_id"));
                clazz.setClazzName(rs.getString("clazzName"));
                stu.setClazz(clazz);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResource(rs, ps, conn);
        }
        return stu;
    }

    @Override
    public int insert(Student stu) {
        Connection conn = null;
        PreparedStatement ps = null;
        int rows = 0;

        try {
            conn = DBUtil.getConnection();
            String sql = "INSERT INTO tb_stu(stuNo, stuName, stuInDate, stuBirth, stuSex, clazz_id) " +
                         "VALUES(?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, stu.getStuNo());
            ps.setString(2, stu.getStuName());
            ps.setDate(3, new java.sql.Date(stu.getStuInDate().getTime()));
            ps.setDate(4, new java.sql.Date(stu.getStuBirth().getTime()));
            ps.setString(5, stu.getStuSex());
            ps.setInt(6, stu.getClazzId());
            rows = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResource(null, ps, conn);
        }
        return rows;
    }

    @Override
    public int update(Student stu) {
        Connection conn = null;
        PreparedStatement ps = null;
        int rows = 0;

        try {
            conn = DBUtil.getConnection();
            String sql = "UPDATE tb_stu SET stuName=?, stuInDate=?, stuBirth=?, stuSex=?, clazz_id=? " +
                         "WHERE stuNo=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, stu.getStuName());
            ps.setDate(2, new java.sql.Date(stu.getStuInDate().getTime()));
            ps.setDate(3, new java.sql.Date(stu.getStuBirth().getTime()));
            ps.setString(4, stu.getStuSex());
            ps.setInt(5, stu.getClazzId());
            ps.setString(6, stu.getStuNo());
            rows = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResource(null, ps, conn);
        }
        return rows;
    }

    @Override
    public int deleteByStuNo(String stuNo) {
        Connection conn = null;
        PreparedStatement ps = null;
        int rows = 0;

        try {
            conn = DBUtil.getConnection();
            String sql = "DELETE FROM tb_stu WHERE stuNo = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, stuNo);
            rows = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResource(null, ps, conn);
        }
        return rows;
    }

    @Override
    public long count() {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        long count = 0;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM tb_stu";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getLong(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResource(rs, ps, conn);
        }
        return count;
    }
}
```

### 3.5 Service 层

```java
// ==================== StudentService 接口 ====================
package com.qiufenfen.service;

import com.qiufenfen.entity.Student;
import com.qiufenfen.util.PageUtil;

public interface StudentService {
    PageUtil<Student> findByPage(int pageNum, int pageSize);
    Student findByStuNo(String stuNo);
    boolean addStudent(Student stu);
    boolean updateStudent(Student stu);
    boolean deleteStudent(String stuNo);
}

// ==================== StudentServiceImpl 实现类 ====================
package com.qiufenfen.service.impl;

import com.qiufenfen.dao.StudentDAO;
import com.qiufenfen.dao.impl.StudentDAOImpl;
import com.qiufenfen.entity.Student;
import com.qiufenfen.service.StudentService;
import com.qiufenfen.util.PageUtil;

public class StudentServiceImpl implements StudentService {

    private StudentDAO studentDAO = new StudentDAOImpl();

    @Override
    public PageUtil<Student> findByPage(int pageNum, int pageSize) {
        return studentDAO.findByPage(pageNum, pageSize);
    }

    @Override
    public Student findByStuNo(String stuNo) {
        return studentDAO.findByStuNo(stuNo);
    }

    @Override
    public boolean addStudent(Student stu) {
        // 业务校验：学号不能重复
        Student existing = studentDAO.findByStuNo(stu.getStuNo());
        if (existing != null) {
            throw new RuntimeException("学号已存在");
        }
        return studentDAO.insert(stu) > 0;
    }

    @Override
    public boolean updateStudent(Student stu) {
        return studentDAO.update(stu) > 0;
    }

    @Override
    public boolean deleteStudent(String stuNo) {
        return studentDAO.deleteByStuNo(stuNo) > 0;
    }
}
```

### 3.6 控制台主程序

```java
package com.qiufenfen;

import com.qiufenfen.entity.Clazz;
import com.qiufenfen.entity.Student;
import com.qiufenfen.service.StudentService;
import com.qiufenfen.service.impl.StudentServiceImpl;
import com.qiufenfen.util.PageUtil;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Scanner;

public class Main {
    
    private static StudentService studentService = new StudentServiceImpl();
    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        while (true) {
            System.out.println("\n========== 学生管理系统 ==========");
            System.out.println("1. 分页查询学生");
            System.out.println("2. 根据学号查询学生");
            System.out.println("3. 添加学生");
            System.out.println("4. 修改学生");
            System.out.println("5. 删除学生");
            System.out.println("0. 退出");
            System.out.print("请选择：");
            
            int choice = scanner.nextInt();
            scanner.nextLine();  // 消耗换行符

            switch (choice) {
                case 1:
                    queryByPage();
                    break;
                case 2:
                    queryByStuNo();
                    break;
                case 3:
                    addStudent();
                    break;
                case 4:
                    updateStudent();
                    break;
                case 5:
                    deleteStudent();
                    break;
                case 0:
                    System.out.println("再见！");
                    System.exit(0);
                default:
                    System.out.println("无效选项！");
            }
        }
    }

    // 分页查询
    private static void queryByPage() {
        System.out.print("请输入页码：");
        int pageNum = scanner.nextInt();
        System.out.print("请输入每页条数：");
        int pageSize = scanner.nextInt();

        PageUtil<Student> page = studentService.findByPage(pageNum, pageSize);
        List<Student> list = page.getData();

        System.out.println("共 " + page.getTotalRecords() + " 条记录，" +
                         "共 " + page.getTotalPages() + " 页，" +
                         "当前第 " + page.getPageNum() + " 页");
        System.out.println("学号\t\t姓名\t性别\t班级");
        for (Student stu : list) {
            System.out.println(stu.getStuNo() + "\t" +
                             stu.getStuName() + "\t" +
                             stu.getStuSex() + "\t" +
                             stu.getClazz().getClazzName());
        }
    }

    // 根据学号查询
    private static void queryByStuNo() {
        System.out.print("请输入学号：");
        String stuNo = scanner.nextLine();

        Student stu = studentService.findByStuNo(stuNo);
        if (stu != null) {
            System.out.println("学号：" + stu.getStuNo());
            System.out.println("姓名：" + stu.getStuName());
            System.out.println("性别：" + stu.getStuSex());
            System.out.println("班级：" + stu.getClazz().getClazzName());
        } else {
            System.out.println("未找到学生！");
        }
    }

    // 添加学生
    private static void addStudent() {
        try {
            Student stu = new Student();
            System.out.print("学号：");
            stu.setStuNo(scanner.nextLine());
            System.out.print("姓名：");
            stu.setStuName(scanner.nextLine());
            System.out.print("性别：");
            stu.setStuSex(scanner.nextLine());
            System.out.print("入学时间（yyyy-MM-dd）：");
            stu.setStuInDate(new SimpleDateFormat("yyyy-MM-dd").parse(scanner.nextLine()));
            System.out.print("生日（yyyy-MM-dd）：");
            stu.setStuBirth(new SimpleDateFormat("yyyy-MM-dd").parse(scanner.nextLine()));
            System.out.print("班级ID：");
            stu.setClazzId(scanner.nextInt());
            scanner.nextLine();

            if (studentService.addStudent(stu)) {
                System.out.println("添加成功！");
            } else {
                System.out.println("添加失败！");
            }
        } catch (Exception e) {
            System.out.println("输入格式错误：" + e.getMessage());
        }
    }

    // 修改学生
    private static void updateStudent() {
        System.out.print("请输入要修改的学号：");
        String stuNo = scanner.nextLine();

        Student stu = studentService.findByStuNo(stuNo);
        if (stu == null) {
            System.out.println("未找到学生！");
            return;
        }

        System.out.print("姓名（" + stu.getStuName() + "）：");
        String name = scanner.nextLine();
        if (!name.isEmpty()) stu.setStuName(name);

        System.out.print("性别（" + stu.getStuSex() + "）：");
        String sex = scanner.nextLine();
        if (!sex.isEmpty()) stu.setStuSex(sex);

        if (studentService.updateStudent(stu)) {
            System.out.println("修改成功！");
        } else {
            System.out.println("修改失败！");
        }
    }

    // 删除学生
    private static void deleteStudent() {
        System.out.print("请输入要删除的学号：");
        String stuNo = scanner.nextLine();

        if (studentService.deleteStudent(stuNo)) {
            System.out.println("删除成功！");
        } else {
            System.out.println("删除失败！");
        }
    }
}
```

---

> 💡 **小结**：本章通过两个实战案例巩固 JDBC 知识。首先讲解了表关联关系配置（单向关联 vs 双向关联），推荐在 N 的一方配置单向关联。然后通过 DAO 模式实现了员工管理的完整 CRUD，对比了两种查询方式（两条 SQL vs 等值连接）。最后通过学生管理系统项目，展示了从数据库设计、实体类、DAO 层、Service 层到控制台主程序的完整开发流程。
---
title: 01-Node.js环境搭建与ES6基础
date: 2024-09-21T00:00:00+08:00
tags:
    - nodejs
    - 教程
    - 环境搭建
categories: node.js
cover: /images/cover13.png
sticky: false
description: "详细讲解 Node.js 开发环境搭建、nvm 版本管理、VS Code 配置，以及 ES6+ 核心语法（let/const、箭头函数、解构赋值、模板字符串、扩展运算符、Promise、async/await）和 Node.js 基础语法，最后通过实战练习巩固所学知识。"
---

# 01-Node.js 环境搭建与 ES6 基础

Node.js 是目前最流行的 JavaScript 服务端运行时环境。本章将从零基础开始，带你完成 Node.js 开发环境的搭建，系统学习 ES6+ 核心语法，并掌握 Node.js 的基础语法特性，为后续章节的学习打下坚实基础。

---

## 一、Node.js 环境搭建

在开始学习 Node.js 之前，我们需要先搭建好开发环境。本章节将详细介绍 Node.js 的下载安装、nvm 版本管理工具的使用、VS Code 编辑器的配置，以及如何编写并运行第一个 Node.js 程序。

### 1.1 Node.js 下载与安装

#### Node.js 版本说明

Node.js 官方提供了两种主要版本：

| 版本类型 | 特点 | 适用场景 |
|---------|------|---------|
| LTS（长期支持版） | 稳定可靠，维护周期长 | 生产环境、项目开发（推荐） |
| Current（当前版本） | 包含最新特性，更新频繁 | 体验新特性、学习研究 |

> **选择建议**：新手或项目开发优先选择 LTS 版本，截至 2024 年 9 月，推荐使用 **Node.js 20.x LTS** 版本。

#### Windows 系统安装步骤

1. **访问官网**：打开 Node.js 官方网站 [https://nodejs.org/zh-cn](https://nodejs.org/zh-cn)，点击左侧的 **LTS 版本**下载链接。

2. **运行安装程序**：下载完成后，双击 `.msi` 安装包，按照向导提示逐步安装：
   - 同意许可协议
   - 选择安装路径（默认即可）
   - 勾选 **"Add to PATH"**（默认已勾选，非常重要）
   - 点击"安装"按钮完成安装

3. **验证安装**：打开命令提示符（按 `Win + R`，输入 `cmd` 回车），执行以下命令：

```bash
node -v
```

如果显示版本号（如 `v20.11.0`），说明 Node.js 安装成功。

同时验证 npm（Node.js 包管理器）是否也已安装：

```bash
npm -v
```

npm 会随 Node.js 一起安装，用于管理项目依赖包。

#### macOS 系统安装步骤

macOS 用户推荐使用 Homebrew 安装 Node.js：

```bash
# 如果没有安装 Homebrew，先执行：
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 使用 Homebrew 安装 Node.js
brew install node

# 验证安装
node -v
npm -v
```

#### Linux 系统安装步骤

以 Ubuntu/Debian 为例：

```bash
# 使用 NodeSource 仓库安装
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# 验证安装
node -v
npm -v
```

> **注意**：不建议直接使用 `apt install nodejs` 安装，因为默认软件源中的 Node.js 版本通常较旧。

### 1.2 nvm 版本管理工具

在实际开发中，我们可能需要在不同项目中使用不同版本的 Node.js。nvm（Node Version Manager）就是专门用于管理 Node.js 多版本的工具。

#### 为什么需要 nvm

不同项目可能依赖不同版本的 Node.js。例如，一个旧项目可能需要 Node.js 14.x，而新项目使用 Node.js 20.x。频繁卸载重装 Node.js 不仅麻烦，还容易出问题。nvm 可以让我们在同一台机器上安装多个 Node.js 版本，并随时切换。

#### 安装 nvm

**Windows 系统**：

Windows 用户推荐使用 nvm-windows，从 GitHub 下载安装包：

- 访问 [nvm-windows releases](https://github.com/coreybutler/nvm-windows/releases)
- 下载 `nvm-setup.exe` 并安装
- 安装完成后打开新的命令行窗口验证

```bash
nvm version
```

**macOS / Linux 系统**：

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# 重新加载配置文件
source ~/.bashrc  # 或 source ~/.zshrc（zsh 用户）

# 验证安装
nvm --version
```

#### nvm 常用命令

```bash
# 查看所有可安装的 Node.js 版本
nvm ls-remote

# 安装指定版本
nvm install 20.11.0

# 安装最新 LTS 版本
nvm install --lts

# 查看本地已安装的所有版本
nvm ls

# 切换到指定版本
nvm use 20.11.0

# 设置默认版本
nvm alias default 20.11.0

# 卸载指定版本
nvm uninstall 20.11.0
```

#### 使用 nvm 切换版本示例

```bash
# 假设本地已安装 18.x 和 20.x 两个版本
nvm ls
# 输出：
#    v18.19.0
#  * v20.11.0   (Currently using 64-bit executable)

# 切换到 Node.js 18
nvm use 18.19.0
# Now using node v18.19.0 (64-bit)

# 验证当前版本
node -v
# v18.19.0

# 切换回 20.x
nvm use 20
# Now using node v20.11.0 (64-bit)
```

### 1.3 VS Code 开发环境配置

VS Code（Visual Studio Code）是目前最流行的免费代码编辑器，拥有丰富的扩展生态，非常适合 Node.js 开发。

#### 安装 VS Code

1. 访问官网 [https://code.visualstudio.com/](https://code.visualstudio.com/) 下载安装
2. 按照安装向导完成安装

#### 必装扩展插件

打开 VS Code 后，点击左侧扩展图标（或按 `Ctrl+Shift+X`），搜索并安装以下扩展：

| 扩展名 | 功能说明 | 推荐理由 |
|--------|---------|---------|
| ESLint | JavaScript/TypeScript 代码规范检查 | 保持代码风格统一，快速发现潜在问题 |
| Prettier - Code formatter | 代码格式化工具 | 自动格式化代码，团队协作必备 |
| REST Client | 在编辑器内直接发送 HTTP 请求 | 调试 API 接口非常方便 |
| GitLens | 增强 Git 功能 | 查看代码历史、行级 blame 信息 |
| Path Intellisense | 路径自动补全 | 减少路径输入错误 |
| Node.js Exec | 一键运行/调试 Node.js 代码 | 快速运行当前文件 |

#### 配置代码编辑器

在 VS Code 中按 `Ctrl + ,` 打开设置，搜索并配置以下选项：

```json
{
  // 设置默认缩进为 2 个空格
  "editor.tabSize": 2,
  // 保存时自动格式化
  "editor.formatOnSave": true,
  // 启用 ESLint 自动修复
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit"
  },
  // 设置默认文件编码
  "files.encoding": "utf8",
  // 终端默认使用 PowerShell
  "terminal.integrated.defaultProfile.windows": "PowerShell"
}
```

#### 在 VS Code 中运行 Node.js

1. **打开项目文件夹**：点击"文件" → "打开文件夹"，选择你的项目目录
2. **创建 JS 文件**：在资源管理器中右键新建文件，命名为 `app.js`
3. **编写代码**：在编辑器中输入 JavaScript 代码
4. **运行程序**：
   - 方法一：使用快捷键 `F5` 启动调试
   - 方法二：在 VS Code 终端（`Ctrl + ``）中执行 `node app.js`
   - 方法三：安装 "Code Runner" 扩展后，右上角会出现运行按钮

### 1.4 第一个 Node.js 程序

#### 创建项目目录

```bash
# 创建项目目录
mkdir my-first-node-app

# 进入目录
cd my-first-node-app
```

#### 初始化项目

```bash
npm init -y
```

这个命令会创建一个 `package.json` 文件，它是 Node.js 项目的配置文件，记录了项目名称、版本、依赖等信息。

#### 编写第一个程序

在项目目录下创建 `app.js` 文件，编写以下代码：

```javascript
// app.js - 我的第一个 Node.js 程序

// 使用模板字符串输出欢迎信息
const greeting = 'Hello, Node.js!';
console.log(greeting);

// 计算 1 到 10 的和
let sum = 0;
for (let i = 1; i <= 10; i++) {
  sum += i;
}
console.log('1 到 10 的和是：', sum);

// 使用数组方法
const numbers = [1, 2, 3, 4, 5];
const doubled = numbers.map(n => n * 2);
console.log('原数组：', numbers);
console.log('翻倍后：', doubled);

// 读取系统信息（使用 Node.js 内置的 os 模块）
const os = require('os');
console.log('当前系统：', os.platform());
console.log('CPU 架构：', os.arch());
console.log('系统内存：', (os.totalmem() / 1024 / 1024 / 1024).toFixed(2), 'GB');
```

#### 运行程序

```bash
node app.js
```

预期输出结果：

```
Hello, Node.js!
1 到 10 的和是： 55
原数组： [ 1, 2, 3, 4, 5 ]
翻倍后： [ 2, 4, 6, 8, 10 ]
当前系统： win32
CPU 架构： x64
系统内存： 16.00 GB
```

#### 代码解析

| 代码行 | 说明 |
|--------|------|
| `const greeting = 'Hello, Node.js!'` | 使用 `const` 声明常量，这是 ES6 的新特性 |
| `for (let i = 1; i <= 10; i++)` | 使用 `let` 声明循环变量，具有块级作用域 |
| `numbers.map(n => n * 2)` | 使用箭头函数作为回调，简洁直观 |
| `const os = require('os')` | 使用 `require()` 引入 Node.js 内置模块 |
| `os.platform()` | 获取操作系统平台信息 |

---

## 二、ES6+ 核心语法

ES6（即 ECMAScript 2015）是 JavaScript 语言的一次重大更新，引入了许多新特性。此后，ECMAScript 每年都在发布新版本（ES2016、ES2017...），这些新特性被统称为 ES6+。掌握这些语法特性是学习 Node.js 的前提。

### 2.1 let 与 const

#### 从 var 到 let/const

在 ES6 之前，JavaScript 使用 `var` 关键字声明变量。`var` 声明的变量存在**变量提升**和**无块级作用域**等问题。ES6 引入了 `let` 和 `const` 来解决这些问题。

#### let 关键字

`let` 用于声明变量，它的特点：

- **块级作用域**：只在声明它的代码块内有效
- **无变量提升**：必须先声明后使用
- **暂时性死区**：在声明之前不能访问该变量

```javascript
// 块级作用域示例
if (true) {
  let a = 10;
  console.log(a); // 10
}
// console.log(a); // ReferenceError: a is not defined

// 无变量提升
// console.log(b); // ReferenceError
let b = 20;

// 暂时性死区
var num = 100;
if (true) {
  // console.log(num); // ReferenceError
  let num = 200;
}
```

#### const 关键字

`const` 用于声明常量（值不可变的变量），它的特点：

- 具有 `let` 的所有特性（块级作用域、无变量提升、暂时性死区）
- 声明时必须赋值
- 赋值后不能重新赋值（对于基本类型，值不可变；对于引用类型，引用不可变）

```javascript
// 声明时必须赋值
// const PI; // SyntaxError
const PI = 3.14159;

// 不能重新赋值
// PI = 3; // TypeError

// 对于对象，引用不可变，但属性可以修改
const user = { name: '张三', age: 20 };
user.age = 21; // 可以修改属性
// user = {}; // TypeError: 不能重新赋值

// 对于数组，可以修改内容
const colors = ['red', 'green'];
colors.push('blue'); // 可以添加元素
// colors = ['yellow']; // TypeError: 不能重新赋值
```

#### var、let、const 的区别

| 特性 | var | let | const |
|------|-----|-----|-------|
| 作用域 | 函数作用域 | 块级作用域 | 块级作用域 |
| 变量提升 | ✅ 有 | ❌ 无 | ❌ 无 |
| 暂时性死区 | ❌ 无 | ✅ 有 | ✅ 有 |
| 重复声明 | ✅ 可以 | ❌ 不可以 | ❌ 不可以 |
| 值是否可变 | ✅ 可以 | ✅ 可以 | ❌ 不可以 |

> **最佳实践**：在实际开发中，优先使用 `const`，只有当确定需要重新赋值时才使用 `let`，尽量避免使用 `var`。

### 2.2 箭头函数

箭头函数是 ES6 中新增的函数定义方式，用于简化函数的语法。

#### 基本语法

```javascript
// 传统函数定义
function add(a, b) {
  return a + b;
}

// 箭头函数
const addArrow = (a, b) => {
  return a + b;
};

// 调用方式相同
console.log(add(1, 2));       // 3
console.log(addArrow(1, 2));  // 3
```

#### 简写形式

当函数体只有一条表达式时，可以省略 `{}` 和 `return`：

```javascript
// 省略大括号和 return
const multiply = (a, b) => a * b;
console.log(multiply(3, 4)); // 12

// 只有一个参数时，可省略参数括号
const square = x => x * x;
console.log(square(5)); // 25

// 无参数时，使用空括号
const getTime = () => Date.now();
console.log(getTime());
```

#### 箭头函数的 this 指向

箭头函数没有自己的 `this`，它会捕获**定义时所在作用域的 `this`**。这是它与传统函数最大的区别：

```javascript
const obj = {
  name: '张三',
  sayHello: function() {
    console.log('传统函数 this.name:', this.name);
    return function() {
      console.log('内部函数 this.name:', this.name);
    };
  },
  sayArrow: function() {
    console.log('箭头函数 this.name:', this.name);
    return () => {
      console.log('箭头函数 this.name:', this.name);
    };
  }
};

const traditional = obj.sayHello();
traditional(); // this.name 为 undefined（在 Node.js 中）

const arrow = obj.sayArrow();
arrow(); // this.name 为 '张三'（箭头函数捕获了外层的 this）
```

> **注意**：箭头函数不能作为构造函数，也没有 `arguments` 对象。在需要使用 `this` 或 `arguments` 的场景下，应当使用普通函数。

### 2.3 解构赋值

解构赋值是一种从数组或对象中提取值并赋给变量的简洁语法。

#### 数组解构

```javascript
// 基本解构
let [a, b, c] = [1, 2, 3];
console.log(a, b, c); // 1 2 3

// 变量数量不一致时，多余的值会被忽略
let [x, y] = [1, 2, 3, 4];
console.log(x, y); // 1 2

// 使用剩余参数接收剩余的值
let [first, ...rest] = [1, 2, 3, 4, 5];
console.log(first); // 1
console.log(rest);  // [2, 3, 4, 5]

// 默认值
let [name = '默认值', age = 18] = ['张三'];
console.log(name, age); // 张三 18

// 交换变量值（不需要临时变量）
let m = 10, n = 20;
[m, n] = [n, m];
console.log(m, n); // 20 10
```

#### 对象解构

```javascript
const person = { name: '李四', age: 25, gender: '男' };

// 基本解构（变量名必须与属性名相同）
let { name, age } = person;
console.log(name, age); // 李四 25

// 使用自定义变量名
let { name: userName, age: userAge } = person;
console.log(userName, userAge); // 李四 25

// 默认值
let { name: n = '匿名', job = '未知' } = person;
console.log(n, job); // 李四 未知

// 嵌套解构
const user = {
  info: { name: '王五', age: 30 },
  scores: [95, 87, 92]
};
let { info: { name: uname }, scores: [math, ...otherScores] } = user;
console.log(uname);           // 王五
console.log(math);            // 95
console.log(otherScores);     // [87, 92]

// 函数参数中使用解构
function greet({ name, age }) {
  return `你好，${name}！你今年 ${age} 岁。`;
}
console.log(greet(person)); // 你好，李四！你今年 25 岁。
```

### 2.4 模板字符串

模板字符串使用反引号（`` ` ``）定义，支持多行文本和变量嵌入。

#### 基本用法

```javascript
// 普通字符串
let str1 = 'Hello\nWorld';

// 模板字符串（支持换行）
let str2 = `Hello
World`;
console.log(str2);
// Hello
// World

// 嵌入变量（使用 ${}）
let name = '赵六';
let age = 28;
let message = `姓名：${name}，年龄：${age}`;
console.log(message); // 姓名：赵六，年龄：28
```

#### 模板字符串的高级应用

```javascript
// 在模板字符串中调用函数
function getAge(birthYear) {
  return new Date().getFullYear() - birthYear;
}
let info = `我今年 ${getAge(1996)} 岁了。`;
console.log(info); // 我今年 28 岁了。

// 复杂表达式
let price = 100;
let discount = 0.8;
let total = `原价 ${price} 元，打折后 ${price * discount} 元。`;
console.log(total); // 原价 100 元，打折后 80 元。

// 生成 HTML 模板
const users = [
  { name: '张三', email: 'zhangsan@example.com' },
  { name: '李四', email: 'lisi@example.com' }
];

const html = `
  <ul>
    ${users.map(u => `<li>${u.name} - ${u.email}</li>`).join('\n    ')}
  </ul>
`;
console.log(html);
// <ul>
//     <li>张三 - zhangsan@example.com</li>
//     <li>李四 - lisi@example.com</li>
// </ul>
```

### 2.5 扩展运算符

扩展运算符用三个点（`...`）表示，可以将数组或对象"展开"。

#### 数组扩展运算符

```javascript
// 将数组展开为参数序列
const numbers = [1, 2, 3];
console.log(...numbers); // 1 2 3

// 用于函数参数
function sum(a, b, c) {
  return a + b + c;
}
console.log(sum(...numbers)); // 6

// 数组合并
const arr1 = [1, 2, 3];
const arr2 = [4, 5, 6];
const merged = [...arr1, ...arr2];
console.log(merged); // [1, 2, 3, 4, 5, 6]

// 数组复制（浅拷贝）
const original = [1, 2, 3];
const copy = [...original];
console.log(copy); // [1, 2, 3]
console.log(copy === original); // false

// 将伪数组转换为真正的数组
function toArray() {
  return [...arguments];
}
console.log(toArray(1, 2, 3)); // [1, 2, 3]
```

#### 对象扩展运算符

```javascript
// 对象合并
const obj1 = { a: 1, b: 2 };
const obj2 = { c: 3, d: 4 };
const mergedObj = { ...obj1, ...obj2 };
console.log(mergedObj); // { a: 1, b: 2, c: 3, d: 4 }

// 对象复制（浅拷贝）
const originalObj = { name: '张三', info: { age: 20 } };
const copyObj = { ...originalObj };
console.log(copyObj); // { name: '张三', info: { age: 20 } }

// 覆盖已有属性
const defaults = { color: 'red', size: 'medium', weight: 5 };
const userConfig = { color: 'blue', size: 'large' };
const finalConfig = { ...defaults, ...userConfig };
console.log(finalConfig); // { color: 'blue', size: 'large', weight: 5 }

// 删除某些属性
const { weight, ...rest } = defaults;
console.log(rest); // { color: 'red', size: 'medium' }
```

### 2.6 Promise

Promise 是异步编程的一种解决方案，用于处理异步操作的回调嵌套问题。

#### Promise 基础概念

Promise 有三种状态：

| 状态 | 说明 |
|------|------|
| pending | 进行中，初始状态 |
| fulfilled | 已成功 |
| rejected | 已失败 |

```javascript
// 创建一个 Promise
const promise = new Promise((resolve, reject) => {
  // 模拟异步操作（如网络请求）
  setTimeout(() => {
    const success = true;
    if (success) {
      resolve('操作成功！');
    } else {
      reject(new Error('操作失败！'));
    }
  }, 1000);
});

// 使用 Promise
promise
  .then(result => {
    console.log('成功:', result);
  })
  .catch(error => {
    console.log('失败:', error.message);
  });
```

#### Promise 链式调用

```javascript
// 模拟多步异步操作
function step1() {
  return new Promise((resolve) => {
    setTimeout(() => resolve('步骤1完成'), 500);
  });
}

function step2(result) {
  return new Promise((resolve) => {
    setTimeout(() => resolve(result + ' → 步骤2完成'), 500);
  });
}

function step3(result) {
  return new Promise((resolve) => {
    setTimeout(() => resolve(result + ' → 步骤3完成'), 500);
  });
}

// 链式调用
step1()
  .then(step2)
  .then(step3)
  .then(finalResult => {
    console.log('最终结果:', finalResult);
  })
  .catch(error => {
    console.log('出错了:', error.message);
  });
```

#### Promise 静态方法

```javascript
// Promise.all：所有 Promise 都成功才返回
const p1 = Promise.resolve(1);
const p2 = Promise.resolve(2);
const p3 = Promise.resolve(3);

Promise.all([p1, p2, p3])
  .then(results => {
    console.log('所有结果:', results); // [1, 2, 3]
  });

// Promise.race：谁先完成就返回谁
const slow = new Promise(resolve => setTimeout(() => resolve('慢'), 2000));
const fast = new Promise(resolve => setTimeout(() => resolve('快'), 500));

Promise.race([slow, fast])
  .then(result => {
    console.log('最先完成:', result); // '快'
  });

// Promise.resolve / Promise.reject：快速创建 Promise
const resolved = Promise.resolve('立即成功');
const rejected = Promise.reject(new Error('立即失败'));
```

### 2.7 async/await

`async/await` 是 ES2017 引入的语法，它让异步代码看起来像同步代码，极大地提高了代码的可读性。

#### 基本用法

```javascript
// async 函数返回一个 Promise
async function fetchData() {
  // await 等待一个 Promise 解决
  const result = await new Promise((resolve) => {
    setTimeout(() => resolve('数据获取成功'), 1000);
  });
  return result;
}

// 调用 async 函数
fetchData().then(data => {
  console.log(data); // 数据获取成功
});
```

#### 错误处理

```javascript
async function fetchUser(userId) {
  try {
    const response = await new Promise((resolve, reject) => {
      setTimeout(() => {
        if (userId > 0) {
          resolve({ id: userId, name: '张三' });
        } else {
          reject(new Error('无效的用户 ID'));
        }
      }, 500);
    });
    return response;
  } catch (error) {
    console.log('捕获错误:', error.message);
    return null;
  }
}

fetchUser(1).then(user => console.log(user));
fetchUser(-1).then(user => console.log(user));
```

#### 并行执行

```javascript
async function loadAllData() {
  try {
    // 使用 Promise.all 并行执行多个异步操作
    const [users, products, orders] = await Promise.all([
      new Promise(resolve => setTimeout(() => resolve('用户列表'), 500)),
      new Promise(resolve => setTimeout(() => resolve('商品列表'), 800)),
      new Promise(resolve => setTimeout(() => resolve('订单列表'), 600))
    ]);

    console.log('用户:', users);
    console.log('商品:', products);
    console.log('订单:', orders);
  } catch (error) {
    console.log('加载失败:', error.message);
  }
}

loadAllData();
```

#### 实战对比：回调 vs Promise vs async/await

```javascript
// 回调方式（容易形成回调地狱）
function getDataCallback(callback) {
  setTimeout(() => {
    callback(null, '数据');
  }, 500);
}

getDataCallback((err, data) => {
  if (err) throw err;
  console.log('回调:', data);
});

// Promise 方式（链式调用）
function getDataPromise() {
  return new Promise((resolve) => {
    setTimeout(() => resolve('数据'), 500);
  });
}

getDataPromise().then(data => console.log('Promise:', data));

// async/await 方式（最接近同步写法）
async function getDataAsync() {
  const data = await getDataPromise();
  console.log('async/await:', data);
}

getDataAsync();
```

> **最佳实践**：在现代 Node.js 开发中，优先使用 `async/await` 处理异步操作，代码更加清晰易读。同时配合 `try/catch` 进行错误处理。

---

## 三、Node.js 基础语法

Node.js 在 ECMAScript 的基础上，提供了一些特有的全局对象和 API。本章节将介绍 Node.js 中最重要的基础语法特性。

### 3.1 全局对象 global 与 globalThis

#### global 对象

在浏览器中，全局变量挂载在 `window` 对象上；在 Node.js 中，全局变量挂载在 `global` 对象上。

```javascript
// 在浏览器中
// window.console.log('hello');

// 在 Node.js 中
global.console.log('hello');

// setTimeout 也是 global 的方法
global.setTimeout(() => {
  console.log('延迟执行');
}, 1000);
```

**注意**：在 Node.js 中，使用 `var`/`let`/`const` 声明的变量**不会**挂载到 `global` 上，这与浏览器的行为不同：

```javascript
// 在 Node.js 模块中
var a = 1;
let b = 2;
const c = 3;

console.log(global.a); // undefined
console.log(global.b); // undefined
console.log(global.c); // undefined
```

这是因为 Node.js 默认每个文件都是一个模块，模块内声明的变量是私有的，不会污染全局作用域。

#### globalThis 对象

ES2020 引入了 `globalThis`，它在任何环境中都指向全局对象：

```javascript
// 在 Node.js 中
console.log(globalThis === global); // true

// 在浏览器中
// console.log(globalThis === window); // true

// 因此，可以使用 globalThis 编写跨环境代码
globalThis.myGlobalVariable = '这是全局变量';
console.log(globalThis.myGlobalVariable); // 这是全局变量
```

#### global 对象的常用属性和方法

| 属性/方法 | 说明 |
|----------|------|
| `global.console` | 控制台对象，用于输出信息 |
| `global.process` | 进程对象，获取进程信息 |
| `global.setTimeout()` | 设置定时器 |
| `global.setInterval()` | 设置间隔定时器 |
| `global.clearTimeout()` | 清除定时器 |
| `global.Buffer` | 二进制数据处理类 |

### 3.2 __dirname 与 __filename

Node.js 提供了两个特殊的变量：`__dirname` 和 `__filename`，它们在每个模块内都有定义。

#### __dirname

`__dirname` 表示**当前模块文件所在目录的绝对路径**：

```javascript
// 假设当前文件路径为：
// C:\Projects\my-app\src\utils\helper.js

console.log(__dirname);
// 输出：C:\Projects\my-app\src\utils
```

#### __filename

`__filename` 表示**当前模块文件的绝对路径**（包含文件名）：

```javascript
// 假设当前文件路径为：
// C:\Projects\my-app\src\utils\helper.js

console.log(__filename);
// 输出：C:\Projects\my-app\src\utils\helper.js

console.log(__dirname);
// 输出：C:\Projects\my-app\src\utils
```

#### 实际应用场景

```javascript
const path = require('path');
const fs = require('fs');

// 场景1：读取当前目录下的配置文件
const configPath = path.join(__dirname, 'config.json');
console.log('配置文件路径:', configPath);

// 场景2：构建相对于项目根目录的路径
// 假设当前文件在 src/utils/ 下，项目根目录为 ../..
const projectRoot = path.resolve(__dirname, '../..');
const dataFilePath = path.join(projectRoot, 'data', 'users.json');
console.log('数据文件路径:', dataFilePath);

// 场景3：引入同目录下的模块
// const helper = require(path.join(__dirname, 'helper.js'));
```

> **注意**：`__dirname` 和 `__filename` 仅在 CommonJS 模块中可用。在 ES Modules（`import`/`export`）中，需要通过 `import.meta.url` 来获取类似信息。

### 3.3 process 对象

`process` 对象是 Node.js 中一个非常重要的全局对象，提供了与当前进程相关的信息和操作方法。

#### process.argv

`process.argv` 是一个数组，包含命令行参数：

```javascript
// 保存为 args.js
console.log('process.argv:', process.argv);
console.log('参数数量:', process.argv.length);
console.log('第一个参数（Node路径）:', process.argv[0]);
console.log('第二个参数（脚本路径）:', process.argv[1]);
console.log('第三个及以后（用户参数）:', process.argv.slice(2));
```

运行结果：

```bash
node args.js hello world 42
```

```
process.argv: [
  'C:\\Program Files\\nodejs\\node.exe',
  'C:\\Projects\\my-app\\args.js',
  'hello',
  'world',
  '42'
]
参数数量: 5
第一个参数（Node路径）: C:\Program Files\nodejs\node.exe
第二个参数（脚本路径）: C:\Projects\my-app\args.js
第三个及以后（用户参数）: [ 'hello', 'world', '42' ]
```

#### process.env

`process.env` 返回一个包含所有环境变量的对象：

```javascript
// 获取环境变量
console.log('HOME 目录:', process.env.HOME);
console.log('PATH:', process.env.PATH);

// 设置自定义环境变量（仅在当前进程有效）
process.env.NODE_ENV = 'development';
console.log('当前环境:', process.env.NODE_ENV);

// 读取自定义环境变量
// 先在命令行设置：
// Windows: set MY_VAR=hello
// macOS/Linux: export MY_VAR=hello
console.log('MY_VAR:', process.env.MY_VAR);
```

#### process 常用方法

```javascript
// 退出进程（0 表示成功，非 0 表示错误）
// process.exit(0);

// 监听进程退出事件
process.on('exit', (code) => {
  console.log('进程退出，退出码:', code);
});

// 监听未捕获的异常
process.on('uncaughtException', (err) => {
  console.log('未捕获的异常:', err.message);
  process.exit(1);
});

// 获取当前工作目录
console.log('当前目录:', process.cwd());

// 切换工作目录
// process.chdir('/new/directory');

// 获取进程 PID
console.log('进程 PID:', process.pid);

// 获取 Node.js 版本
console.log('Node.js 版本:', process.version);

// 获取 CPU 架构
console.log('CPU 架构:', process.arch);

// 获取操作系统平台
console.log('操作系统:', process.platform);
```

#### process.stdin/stdout/stderr

`process` 提供了标准输入、输出和错误流：

```javascript
// 从标准输入读取数据
process.stdin.setEncoding('utf8');

process.stdin.on('data', (data) => {
  const input = data.toString().trim();
  console.log('你输入了:', input);

  // 回显输入
  process.stdout.write('回显: ' + input + '\n');

  // 如果输入 'quit'，退出进程
  if (input === 'quit') {
    process.exit(0);
  }
});

console.log('请输入内容（输入 quit 退出）：');
process.stdout.write('> ');
```

运行效果：

```
请输入内容（输入 quit 退出）：
> Hello Node.js
你输入了: Hello Node.js
回显: Hello Node.js
> quit
进程退出，退出码: 0
```

---

## 四、实战练习：温度转换器 CLI 工具

本章节将综合运用前面所学的知识，创建一个实用的命令行工具——温度转换器。该工具支持摄氏度、华氏度、开尔文之间的相互转换。

### 4.1 项目目标

- 接收命令行输入的温度值和单位
- 实现摄氏度（°C）、华氏度（°F）、开尔文（K）之间的相互转换
- 支持交互式输入模式和命令行参数模式
- 输出格式化的转换结果

### 4.2 创建项目

```bash
# 创建项目目录并初始化
mkdir temperature-converter
cd temperature-converter
npm init -y
```

### 4.3 编写代码

创建 `index.js` 文件：

```javascript
#!/usr/bin/env node

const readline = require('readline');

const UNITS = {
  CELSIUS: 'C',
  FAHRENHEIT: 'F',
  KELVIN: 'K'
};

const UNIT_NAMES = {
  C: '摄氏度 (°C)',
  F: '华氏度 (°F)',
  K: '开尔文 (K)'
};

function convertTemperature(value, fromUnit, toUnit) {
  value = Number(value);
  if (isNaN(value)) {
    throw new Error('温度值必须是数字');
  }

  fromUnit = fromUnit.toUpperCase();
  toUnit = toUnit.toUpperCase();

  if (![UNITS.CELSIUS, UNITS.FAHRENHEIT, UNITS.KELVIN].includes(fromUnit)) {
    throw new Error(`不支持的源温度单位: ${fromUnit}，支持的单位: C, F, K`);
  }
  if (![UNITS.CELSIUS, UNITS.FAHRENHEIT, UNITS.KELVIN].includes(toUnit)) {
    throw new Error(`不支持的目标温度单位: ${toUnit}，支持的单位: C, F, K`);
  }

  if (fromUnit === toUnit) {
    return { value, unit: toUnit };
  }

  let celsius;
  switch (fromUnit) {
    case UNITS.CELSIUS:
      celsius = value;
      break;
    case UNITS.FAHRENHEIT:
      celsius = (value - 32) * 5 / 9;
      break;
    case UNITS.KELVIN:
      celsius = value - 273.15;
      break;
  }

  let result;
  switch (toUnit) {
    case UNITS.CELSIUS:
      result = celsius;
      break;
    case UNITS.FAHRENHEIT:
      result = celsius * 9 / 5 + 32;
      break;
    case UNITS.KELVIN:
      result = celsius + 273.15;
      break;
  }

  return {
    value: Math.round(result * 100) / 100,
    unit: toUnit
  };
}

function printResult(fromValue, fromUnit, result) {
  console.log('\n========================================');
  console.log('  温度转换结果');
  console.log('========================================');
  console.log(`  源温度: ${fromValue} ${UNIT_NAMES[fromUnit.toUpperCase()]}`);
  console.log(`  目标温度: ${result.value} ${UNIT_NAMES[result.unit]}`);
  console.log('========================================\n');
}

function parseArgs(args) {
  const argsStr = args.join(' ');

  if (argsStr.includes('--help') || argsStr.includes('-h')) {
    console.log(`
温度转换器 - 命令行使用方法：

  node index.js <温度值> <源单位> <目标单位>

参数说明：
  温度值    - 要转换的数值（如 100）
  源单位    - 原始温度单位（C=摄氏度, F=华氏度, K=开尔文）
  目标单位  - 目标温度单位（C=摄氏度, F=华氏度, K=开尔文）

示例：
  node index.js 100 C F    # 100 摄氏度转华氏度
  node index.js 32 F C     # 32 华氏度转摄氏度
  node index.js 0 K C      # 0 开尔文转摄氏度

交互式模式：
  node index.js             # 不带参数启动交互式模式
    `);
    process.exit(0);
  }

  if (args.length === 3) {
    const [value, from, to] = args;
    return { value, fromUnit: from, toUnit: to };
  }

  return null;
}

function runInteractive() {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  console.log('\n🌡️  温度转换器（交互式模式）');
  console.log('输入 help 查看帮助，输入 quit 退出\n');

  function askValue() {
    rl.question('请输入温度值: ', (value) => {
      if (value.toLowerCase() === 'quit') {
        rl.close();
        return;
      }
      if (value.toLowerCase() === 'help') {
        console.log('支持的单位: C=摄氏度, F=华氏度, K=开尔文');
        askValue();
        return;
      }

      askUnit('请输入源单位 (C/F/K): ', (fromUnit) => {
        askUnit('请输入目标单位 (C/F/K): ', (toUnit) => {
          try {
            const result = convertTemperature(value, fromUnit, toUnit);
            printResult(value, fromUnit, result);
          } catch (err) {
            console.log('❌ 错误:', err.message);
          }
          askValue();
        });
      });
    });
  }

  function askUnit(prompt, callback) {
    rl.question(prompt, (unit) => {
      if (unit.toLowerCase() === 'quit') {
        rl.close();
        return;
      }
      callback(unit);
    });
  }

  askValue();
}

function main() {
  const args = process.argv.slice(2);
  const parsed = parseArgs(args);

  if (parsed) {
    try {
      const result = convertTemperature(parsed.value, parsed.fromUnit, parsed.toUnit);
      printResult(parsed.value, parsed.fromUnit, result);
    } catch (err) {
      console.log('❌ 错误:', err.message);
      console.log('使用 --help 查看帮助信息');
      process.exit(1);
    }
  } else {
    runInteractive();
  }
}

main();
```

### 4.4 添加 npm 脚本（可选）

编辑 `package.json`，在 `scripts` 部分添加快捷命令：

```json
{
  "scripts": {
    "start": "node index.js",
    "convert": "node index.js"
  }
}
```

### 4.5 运行测试

#### 命令行参数模式

```bash
# 摄氏度转华氏度（100°C = 212°F）
node index.js 100 C F

# 华氏度转摄氏度（32°F = 0°C）
node index.js 32 F C

# 摄氏度转开尔文（0°C = 273.15K）
node index.js 0 C K

# 查看帮助
node index.js --help
```

#### 交互式模式

```bash
# 直接启动，进入交互式模式
node index.js
```

预期交互效果：

```
🌡️  温度转换器（交互式模式）
输入 help 查看帮助，输入 quit 退出

请输入温度值: 100
请输入源单位 (C/F/K): C
请输入目标单位 (C/F/K): F

========================================
  温度转换结果
========================================
  源温度: 100 摄氏度 (°C)
  目标温度: 212 华氏度 (°F)
========================================
```

### 4.6 代码知识点总结

| 知识点 | 代码位置 | 说明 |
|--------|---------|------|
| `require()` | 第 3 行 | 引入 Node.js 内置的 `readline` 模块 |
| `const`/`let` | 全局 | 使用 `const` 声明常量，`let` 声明变量 |
| 箭头函数 | 多处 | 简化函数定义，如 `printResult`、`parseArgs` |
| 解构赋值 | 第 139 行 | `const [value, from, to] = args` |
| 模板字符串 | 第 112-125 行 | 帮助信息中使用模板字符串 |
| 扩展运算符 | 第 101 行 | `args.join(' ')` 处理命令行参数 |
| Promise/async | 第 162-195 行 | `readline` 基于事件回调，体现异步编程思想 |
| `process.argv` | 第 99、205 行 | 获取命令行参数 |
| `process.exit()` | 多处 | 控制进程退出 |
| `readline` 模块 | 第 158-201 行 | 实现交互式命令行输入 |
| `__dirname`/`__filename` | 未使用 | 可作为练习，尝试用它们构建配置文件路径 |

### 4.7 扩展练习

在完成基础功能后，可以尝试以下扩展：

1. **添加历史记录功能**：将每次转换记录保存到本地 `history.json` 文件中
2. **支持更多单位**：添加兰氏度（Rankine）等温度单位
3. **批量转换**：支持一次输入多个温度值进行批量转换
4. **添加颜色输出**：使用 `chalk` 包实现彩色终端输出
5. **错误处理增强**：对非法输入提供更友好的错误提示
6. **添加单元测试**：使用 `Jest` 或 `Mocha` 为核心转换函数编写测试用例

---

## 本章小结

本章系统学习了 Node.js 的基础知识，内容涵盖四个部分：

### 一、Node.js 环境搭建
- 学会了从官网下载安装 Node.js，验证安装是否成功
- 掌握了使用 nvm 管理 Node.js 多版本的方法
- 了解了 VS Code 的配置和常用扩展插件
- 完成了第一个 Node.js 程序的编写与运行

### 二、ES6+ 核心语法
- **let/const**：使用块级作用域的变量声明替代 var
- **箭头函数**：简化函数定义，理解 this 指向规则
- **解构赋值**：从数组和对象中高效提取数据
- **模板字符串**：使用反引号和 `${}` 嵌入变量
- **扩展运算符**：使用 `...` 展开数组和对象
- **Promise/async-await**：掌握异步编程的核心方法

### 三、Node.js 基础语法
- **global/globalThis**：理解 Node.js 的全局对象体系
- **__dirname/__filename**：获取当前模块的路径信息
- **process 对象**：掌握命令行参数、环境变量、进程控制等常用操作

### 四、实战练习
- 综合运用所学知识，完成了一个温度转换器 CLI 工具
- 支持命令行参数和交互式两种使用模式
- 涵盖了 readline 模块、文件操作、错误处理等实际开发场景

完成本章学习后，你已经具备了 Node.js 开发的基础能力。下一章将深入学习 Node.js 的模块化开发，包括 CommonJS、ES Modules、npm 包管理等核心内容。
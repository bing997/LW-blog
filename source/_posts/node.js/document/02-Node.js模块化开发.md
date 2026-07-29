---
title: 02-Node.js模块化开发
date: 2024-09-22T00:00:00+08:00
tags:
  - nodejs
  - 教程
  - 模块化
categories:
  - node.js
cover: /images/cover13.png
sticky: false
description: Node.js模块化开发——深入理解CommonJS与ES Modules模块系统，掌握npm包管理工具，实战打造数学工具包
---

## 一、模块化概述

### 为什么需要模块化

在软件开发中，**模块化**是指将一个复杂的应用程序拆分成多个独立的、可复用的代码块（模块），每个模块负责完成一个特定的功能。

#### 没有模块化的问题

在没有模块化之前，JavaScript 代码通常全部写在一个文件中，随着项目规模增大，会面临以下问题：

- **全局变量污染**：所有变量都定义在全局作用域中，容易命名冲突
- **代码复用困难**：不同功能的代码耦合在一起，难以复用
- **维护性差**：代码量增大后，难以定位和修改问题
- **依赖管理混乱**：模块之间的依赖关系不清晰

```javascript
// 没有模块化时的代码（演示问题）
var userCount = 10;
var userCount = 20; // 无意中覆盖了之前的值

function getUserInfo() {
  // 这个函数可能与其他函数的变量产生冲突
  var userCount = 5;
  return { name: '张三', count: userCount };
}
```

#### 模块化的好处

- **职责分离**：每个模块只负责一个功能，降低代码耦合度
- **代码复用**：编写一次，多处引用
- **便于维护**：修改某个模块不会影响其他模块
- **团队协作**：多人可以同时开发不同模块
- **按需加载**：只加载需要的模块，减少资源浪费

### 模块化的演进历史

JavaScript 模块化经历了从无到有、从简单到规范的演进过程：

#### 阶段一：文件划分

最初，开发者将代码拆分到不同 `<script>` 标签的 JS 文件中，通过全局变量实现通信。这种方式虽然简单，但依赖关系完全由文件加载顺序决定，容易出错。

```html
<script src="js/config.js"></script>
<script src="js/utils.js"></script>
<script src="js/main.js"></script>
```

#### 阶段二：IIFE（立即执行函数）

通过 IIFE 将代码封装在独立的函数作用域中，避免全局变量污染，并通过一个统一的命名空间对象暴露接口。

```javascript
// 命名空间模式
var MyApp = MyApp || {};

MyApp.Utils = (function () {
  function formatDate(date) {
    // ...
  }
  return { formatDate: formatDate };
})();

MyApp.Config = (function () {
  var version = '1.0.0';
  return { version: version };
})();
```

#### 阶段三：AMD / CMD

随着前端工程化的发展，出现了两种异步模块规范：

- **AMD（Asynchronous Module Definition）**：由 RequireJS 推广，采用**依赖前置**的方式，适合浏览器端异步加载。
- **CMD（Common Module Definition）**：由 SeaJS 推广，采用**依赖就近**的方式，更符合 CommonJS 的写法。

```javascript
// AMD 规范
define(['moduleA', 'moduleB'], function (moduleA, moduleB) {
  return {
    doSomething: function () {
      moduleA.method();
    }
  };
});

// CMD 规范
define(function (require, exports, module) {
  var moduleA = require('moduleA');
  module.exports = {
    doSomething: function () {
      moduleA.method();
    }
  };
});
```

#### 阶段四：CommonJS 与 ES Modules

- **CommonJS**：Node.js 采用的模块规范，适用于服务端，采用**同步加载**方式。
- **ES Modules（ESM）**：ES6 官方标准的模块规范，适用于浏览器和 Node.js，采用**静态分析**和**异步加载**方式。

### Node.js 模块系统设计

Node.js 的模块系统具有以下核心设计理念：

#### 1. 模块封装

Node.js 中每个文件都是一个独立的模块，拥有自己的作用域。文件中的变量、函数、类等不会污染全局作用域。

```javascript
// math.js
const PI = 3.14159; // 这是模块私有的，不会暴露到外部

function add(a, b) {
  return a + b;
}

module.exports = { add: add };
```

#### 2. 模块缓存

Node.js 会缓存已加载的模块，无论通过 `require` 引用多少次，同一个模块只会被加载和执行一次。

```javascript
// counter.js
let count = 0;
count++;
console.log('模块被加载，当前 count:', count);

module.exports = { count: count };
```

```javascript
// app.js
const counter1 = require('./counter'); // 输出：模块被加载，当前 count: 1
const counter2 = require('./counter'); // 无输出，直接从缓存获取

console.log(counter1.count); // 1
console.log(counter2.count); // 1
console.log(counter1 === counter2); // true，同一对象引用
```

#### 3. 模块查找优先级

Node.js 按照以下顺序查找模块：

1. **核心模块**：如 `fs`、`path`、`http` 等 Node.js 内置模块
2. **文件路径模块**：以 `./`、`../` 或 `/` 开头的路径
3. **node_modules 模块**：从当前目录向上逐级查找 `node_modules` 目录

---

## 二、CommonJS 模块系统

CommonJS 是 Node.js 最初采用的模块规范，也是 Node.js 生态中最主流的模块系统。

### require 函数

`require()` 是 CommonJS 中用于加载模块的函数，它接收一个模块标识符作为参数，返回该模块导出的内容。

#### 加载核心模块

```javascript
const fs = require('fs');
const path = require('path');

// 使用 fs 读取文件
fs.readFile('example.txt', 'utf8', (err, data) => {
  if (err) throw err;
  console.log(data);
});
```

#### 加载文件模块

```javascript
// 加载同目录下的文件（可省略 .js 扩展名）
const math = require('./math');
const utils = require('../utils/helpers.js');
const config = require('./config.json');

console.log(math.add(1, 2));
```

#### 加载目录模块

当 `require` 传入一个目录路径时，Node.js 会查找该目录下的 `index.js` 文件，或根据 `package.json` 中的 `main` 字段确定入口文件。

```javascript
// 目录结构
// my-module/
//   ├── index.js
//   └── package.json

const myModule = require('./my-module');
```

### exports 对象

`exports` 是 CommonJS 模块中用于导出成员的对象。它是 `module.exports` 的一个**引用**（别名）。

#### 使用 exports 导出

```javascript
// logger.js
exports.info = function (message) {
  console.log('[INFO]', message);
};

exports.error = function (message) {
  console.error('[ERROR]', message);
};
```

```javascript
// app.js
const logger = require('./logger');

logger.info('服务器启动成功');
logger.error('数据库连接失败');
```

### module.exports 对象

`module.exports` 是模块真正的导出对象。`require()` 返回的就是 `module.exports` 的值。

#### 使用 module.exports 导出

```javascript
// calculator.js
function add(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

function multiply(a, b) {
  return a * b;
}

// 导出多个方法
module.exports = {
  add,
  subtract,
  multiply
};
```

```javascript
// app.js
const calculator = require('./calculator');

console.log(calculator.add(10, 5));      // 15
console.log(calculator.subtract(10, 5));  // 5
console.log(calculator.multiply(10, 5));  // 50
```

#### 导出单个类或函数

当模块只导出一个类或函数时，直接赋值给 `module.exports` 是最佳实践。

```javascript
// Person.js
class Person {
  constructor(name, age) {
    this.name = name;
    this.age = age;
  }

  greet() {
    return `你好，我是${this.name}，今年${this.age}岁。`;
  }
}

module.exports = Person;
```

```javascript
// app.js
const Person = require('./Person');

const p = new Person('小明', 25);
console.log(p.greet()); // 你好，我是小明，今年25岁。
```

### exports 与 module.exports 的区别

这是 CommonJS 中最容易混淆的概念。

#### 核心关系

在每个模块文件内部，Node.js 隐式执行以下操作：

```javascript
// Node.js 内部自动生成的代码（概念上）
var module = { exports: {} };
var exports = module.exports;

// 你的代码写在这里

return module.exports;
```

- `module.exports` 是真正的导出对象
- `exports` 是 `module.exports` 的引用（指向同一个对象）
- `require()` 返回的是 `module.exports`

#### 为什么 exports 和 module.exports 会有区别

```javascript
// 示例一：使用 exports 添加属性（正确）
exports.foo = function () {
  console.log('foo');
};
// 此时 module.exports.foo 也存在，因为它们指向同一对象
```

```javascript
// 示例二：直接赋值 exports（错误）
exports = { bar: function () {} };
// 这会断开 exports 与 module.exports 的引用关系
// module.exports 仍然指向原来的空对象 {}
```

```javascript
// 示例三：正确的直接赋值方式
module.exports = { bar: function () {} };
// 这样 require 才能拿到正确的对象
```

#### 实战对比

```javascript
// 错误示例：只使用 exports 赋值
// bad-module.js
exports = {
  name: '我不会被导出'
};
```

```javascript
// app.js
const bad = require('./bad-module');
console.log(bad); // {}，空对象！因为 exports 已断开与 module.exports 的引用
```

```javascript
// 正确示例：使用 module.exports 赋值
// good-module.js
module.exports = {
  name: '我会被正确导出'
};
```

```javascript
// app.js
const good = require('./good-module');
console.log(good); // { name: '我会被正确导出' }
```

> **最佳实践**：当需要导出单个对象、类或函数时，使用 `module.exports = ...`；当需要在原有对象上追加属性时，使用 `exports.xxx = ...`。但为了避免混淆，建议统一使用 `module.exports` 并在最后一次性赋值。

### 模块加载规则

#### 路径形式

| 路径形式 | 示例 | 查找规则 |
|---------|------|---------|
| 核心模块 | `require('fs')` | 直接从 Node.js 内置模块加载 |
| 相对路径 | `require('./utils')` | 从当前文件所在目录开始查找 |
| 绝对路径 | `require('/home/user/app')` | 从根目录开始查找 |
| 模块名 | `require('express')` | 从 node_modules 中查找 |

#### 文件扩展名解析

`require()` 可以省略文件扩展名，Node.js 会按以下顺序尝试：

1. 精确匹配文件名（如 `require('./math')` 先尝试 `math`）
2. 添加 `.js` 扩展名
3. 添加 `.json` 扩展名
4. 添加 `.node` 扩展名（C++ 原生模块）

```javascript
// 以下写法效果相同
const math1 = require('./math.js');
const math2 = require('./math');
```

#### 目录模块解析

当 `require()` 传入目录路径时：

1. 查找目录下的 `package.json`，读取 `main` 字段作为入口文件
2. 如果没有 `package.json` 或 `main` 字段，查找目录下的 `index.js`
3. 如果没有 `index.js`，查找 `index.json`
4. 如果都找不到，抛出错误

```javascript
// my-lib/package.json
{
  "name": "my-lib",
  "main": "src/main.js"
}

// 此时 require('./my-lib') 会加载 ./my-lib/src/main.js
```

#### 模块加载流程图

```
require('moduleName')
    │
    ├── 是核心模块？ ──→ 直接加载并返回
    │
    ├── 路径以 ./ 或 ../ 或 / 开头？
    │       │
    │       ├── 是文件？ ──→ 按 .js → .json → .node 顺序尝试
    │       │
    │       └── 是目录？ ──→ 查找 package.json (main) → index.js → index.json
    │
    └── 模块名？ ──→ 从当前目录向上逐级查找 node_modules
                │
                ├── 找到目录？ ──→ 按目录模块解析规则加载
                │
                └── 未找到？ ──→ 抛出 MODULE_NOT_FOUND 错误
```

---

## 三、ES Modules

ES Modules（ESM）是 ES6 引入的官方标准模块系统，它与 CommonJS 有显著区别。

### import / export 基础

ES Modules 使用 `export` 导出成员，使用 `import` 导入成员。

#### 命名导出

每个需要导出的成员都需要显式使用 `export` 关键字标记。

```javascript
// math.js
export function add(a, b) {
  return a + b;
}

export function subtract(a, b) {
  return a - b;
}

export const PI = 3.14159;
```

```javascript
// app.js
import { add, subtract, PI } from './math.js';

console.log(add(5, 3));      // 8
console.log(subtract(5, 3));  // 2
console.log(PI);              // 3.14159
```

#### 批量导出

```javascript
// math.js
function add(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

const PI = 3.14159;

// 使用 export { } 批量导出
export { add, subtract, PI };
```

### default 导出

每个模块可以有一个 `default` 导出，这是最常用的导出方式。

#### 导出 default

```javascript
// User.js
class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;
  }

  introduce() {
    return `我是${this.name}，邮箱：${this.email}`;
  }
}

export default User;
```

#### 导入 default

导入 default 成员时不需要花括号，可以自定义名称。

```javascript
// app.js
import User from './User.js';

const user = new User('张三', 'zhangsan@example.com');
console.log(user.introduce());
```

#### 同时使用命名导出和 default 导出

一个模块可以同时包含命名导出和 default 导出。

```javascript
// constants.js
export const VERSION = '2.0.0';
export const CONFIG = { port: 3000 };

export default function init() {
  console.log('初始化完成');
}
```

```javascript
// app.js
import init, { VERSION, CONFIG } from './constants.js';

console.log(VERSION);  // 2.0.0
console.log(CONFIG);   // { port: 3000 }
init();                // 初始化完成
```

### 重命名导出

#### 导出时重命名

```javascript
// math.js
function add(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

export { add as sum, subtract as difference };
```

```javascript
// app.js
import { sum, difference } from './math.js';

console.log(sum(10, 5));        // 15
console.log(difference(10, 5));  // 5
```

#### 导入时重命名

```javascript
// app.js
import { add as addition, subtract as sub } from './math.js';

console.log(addition(10, 5)); // 15
console.log(sub(10, 5));      // 5
```

#### 重导出（转发导出）

可以在一个模块中重新导出另一个模块的成员，实现模块的聚合。

```javascript
// math-utils.js
export { add, subtract } from './math.js';
export { formatNumber, parseNumber } from './formatter.js';
```

```javascript
// app.js
import { add, formatNumber } from './math-utils.js';
```

### 动态 import

`import()` 是一个异步操作，返回一个 Promise，可以在运行时动态加载模块。

#### 基本用法

```javascript
// app.js
const button = document.querySelector('#load-btn');

button.addEventListener('click', async () => {
  // 动态导入，按需加载
  const module = await import('./heavy-module.js');
  module.doSomething();
});
```

#### 条件加载

```javascript
// 根据环境动态选择模块
const locale = navigator.language;
let messages;

if (locale.startsWith('zh')) {
  messages = await import('./i18n/zh.js');
} else {
  messages = await import('./i18n/en.js');
}
```

#### 与静态 import 的区别

| 特性 | 静态 import | 动态 import() |
|------|------------|--------------|
| 加载时机 | 编译时（静态分析） | 运行时 |
| 语法位置 | 模块顶层 | 任何位置 |
| 返回值 | 直接获取模块内容 | Promise |
| 适用场景 | 常规依赖 | 按需加载、条件加载 |

### package.json 中 type 字段

Node.js 中默认使用 CommonJS，要使用 ES Modules 需要将 `package.json` 中的 `type` 字段设置为 `"module"`。

#### 启用 ES Modules

```json
{
  "name": "my-esm-project",
  "version": "1.0.0",
  "type": "module",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  }
}
```

#### type 字段的可选值

| 值 | 说明 |
|----|------|
| `"commonjs"`（默认） | 所有 `.js` 文件按 CommonJS 处理 |
| `"module"` | 所有 `.js` 文件按 ES Modules 处理 |
| 不设置 | 等同于 `"commonjs"` |

#### 混合使用两种模块

在实际项目中，可能需要同时使用 CommonJS 和 ES Modules。

**方法一：使用 `.mjs` 扩展名**

`.mjs` 文件始终按 ES Modules 处理，`.cjs` 文件始终按 CommonJS 处理。

```javascript
// math.mjs —— ES Modules 格式
export function add(a, b) {
  return a + b;
}
```

```javascript
// app.cjs —— CommonJS 格式
const math = require('./math.mjs'); // 不行！CommonJS 不能 require ESM

// 使用动态 import 加载
async function main() {
  const math = await import('./math.mjs');
  console.log(math.add(1, 2));
}
main();
```

**方法二：在 ESM 中使用 CommonJS**

```javascript
// app.mjs
import { createRequire } from 'module';
const require = createRequire(import.meta.url);

// 现在可以用 require 加载 CommonJS 模块
const express = require('express');
```

#### import.meta

`import.meta` 是一个特殊的对象，包含当前模块的元信息。

```javascript
// 获取当前模块的 URL
console.log(import.meta.url);

// 使用 import.meta.url 获取当前文件目录（模拟 __dirname）
import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
```

> **注意**：ES Modules 中没有 `__dirname`、`__filename`、`require` 等 CommonJS 特有变量，需要通过上述方式自行获取。

---

## 四、npm 包管理

npm（Node Package Manager）是 Node.js 的官方包管理工具，用于安装、管理和分享 Node.js 包。

### npm 常用命令

#### 初始化项目

```bash
npm init
```

交互式地创建 `package.json` 文件，按提示输入项目信息。如果想跳过交互，可以使用 `-y` 参数：

```bash
npm init -y
```

#### 安装依赖

```bash
# 安装生产依赖（运行时需要的包）
npm install express
npm install express --save     # 旧版本写法，已默认生效

# 安装开发依赖（仅开发时需要的包）
npm install jest --save-dev
npm install jest -D             # 简写形式

# 全局安装
npm install nodemon -g
npm install nodemon --global   # 完整写法

# 安装指定版本
npm install express@4.18.2

# 安装所有依赖（根据 package.json）
npm install
```

#### 卸载依赖

```bash
npm uninstall express
npm uninstall express --save-dev   # 从开发依赖中移除
```

#### 更新依赖

```bash
# 更新所有依赖到最新版本（根据语义化版本规则）
npm update

# 更新指定包
npm update express

# 更新全局包
npm update -g
```

#### 查看依赖

```bash
# 查看当前项目的依赖树
npm list

# 查看全局安装的包
npm list -g

# 查看某个包的详细信息
npm view express
npm view express versions    # 查看所有版本
```

#### 运行脚本

```bash
# 运行 package.json 中 scripts 定义的脚本
npm run dev
npm run build
npm run test

# npm run 可以省略（仅限 prefixed 脚本）
npm test        # 等同 npm run test
npm start       # 等同 npm run start
npm stop        # 等同 npm run stop
```

#### 其他常用命令

```bash
# 检查过期的依赖
npm outdated

# 运行安全审计
npm audit

# 修复安全漏洞
npm audit fix

# 登录 npm 账号（用于发布包）
npm login

# 发布包到 npm
npm publish

# 搜索包
npm search mongoose
```

### package.json 详解

`package.json` 是 Node.js 项目的核心配置文件，包含项目的元信息和依赖声明。

#### 常用字段说明

```json
{
  "name": "my-awesome-project",
  "version": "1.0.0",
  "description": "一个很棒的 Node.js 项目",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js",
    "build": "webpack --mode production",
    "test": "jest"
  },
  "keywords": ["nodejs", "express", "api"],
  "author": "张三",
  "license": "MIT",
  "engines": {
    "node": ">=18.0.0"
  },
  "dependencies": {
    "express": "^4.18.2",
    "lodash": "^4.17.21"
  },
  "devDependencies": {
    "jest": "^29.7.0",
    "nodemon": "^3.0.2"
  }
}
```

| 字段 | 说明 |
|------|------|
| `name` | 包名，必须全局唯一（发布到 npm 时） |
| `version` | 当前版本号，遵循语义化版本规范 |
| `description` | 项目描述，帮助他人了解项目用途 |
| `main` | 模块的入口文件 |
| `scripts` | 自定义脚本命令 |
| `keywords` | 搜索关键词 |
| `author` | 作者信息 |
| `license` | 开源协议 |
| `engines` | 支持的 Node.js 版本 |
| `dependencies` | 生产环境依赖 |
| `devDependencies` | 开发环境依赖 |

### 语义化版本

npm 使用**语义化版本（Semantic Versioning）**规范来管理包的版本号。

#### 版本号格式

```
主版本号.次版本号.修订号
MAJOR.MINOR.PATCH
```

- **MAJOR**：不兼容的 API 变更（如 1.0.0 → 2.0.0）
- **MINOR**：向后兼容的功能性新增（如 1.0.0 → 1.1.0）
- **PATCH**：向后兼容的问题修复（如 1.0.0 → 1.0.1）

#### npm 中的版本符号

在 `package.json` 中，依赖版本号可以使用以下符号：

| 符号 | 示例 | 含义 |
|------|------|------|
| 无 | `1.2.3` | 精确版本，只使用 1.2.3 |
| `^` | `^1.2.3` | 兼容版本，允许 1.x.x 的最新版 |
| `~` | `~1.2.3` | 近似版本，允许 1.2.x 的最新版 |
| `>=` | `>=1.2.3` | 大于或等于指定版本 |
| `<=` | `<=1.2.3` | 小于或等于指定版本 |
| `>` | `>1.2.3` | 大于指定版本 |
| `*` | `*` | 任意版本 |
| `-` | `1.2.0 - 1.5.0` | 版本范围 |

```json
{
  "dependencies": {
    "express": "^4.18.2",
    "lodash": "~4.17.21",
    "axios": ">=1.0.0",
    "dayjs": "1.11.1"
  }
}
```

> **最佳实践**：使用 `^` 符号可以自动获取向后兼容的更新，是最常用的版本锁定方式。对于生产环境，建议使用 `npm shrinkwrap` 或 `package-lock.json` 锁定实际版本。

### 依赖管理

#### 依赖类型

| 类型 | 说明 | 安装命令 |
|------|------|---------|
| `dependencies` | 生产环境必需的依赖 | `npm install <pkg>` |
| `devDependencies` | 开发时需要的依赖 | `npm install <pkg> -D` |
| `peerDependencies` | 宿主环境必须提供的依赖 | 手动添加 |
| `optionalDependencies` | 可选依赖，安装失败不影响 | `npm install <pkg> -O` |

#### package-lock.json

`package-lock.json` 是 npm 自动生成的文件，用于**锁定依赖的精确版本**，确保团队成员和 CI/CD 环境安装到完全相同的依赖版本。

```json
{
  "name": "my-project",
  "version": "1.0.0",
  "lockfileVersion": 3,
  "requires": true,
  "packages": {
    "node_modules/express": {
      "version": "4.18.2",
      "resolved": "https://registry.npmjs.org/express/-/express-4.18.2.tgz",
      "integrity": "sha512-fakehash..."
    }
  }
}
```

> **重要**：`package-lock.json` 应该提交到版本控制系统（如 Git），以便团队中每个人使用相同的依赖版本。

#### node_modules 目录

`node_modules` 目录存放所有安装的依赖包。它由 npm 自动管理，**不应手动编辑**。

```bash
# 删除 node_modules 并重新安装（解决依赖问题的常用方法）
rm -rf node_modules
npm install
```

### npx 使用

`npx` 是 npm 5.2+ 自带的命令，用于**临时安装并执行** npm 包，无需全局安装。

#### 基本用法

```bash
# 临时执行一个包（不会全局安装）
npx create-react-app my-app

# 执行项目中已安装的包（无需写 node_modules/.bin/xxx）
npx webpack --mode production
npx jest

# 执行特定版本的包
npx node@14 -e "console.log(process.version)"
```

#### 与 npm 的区别

| 场景 | npm | npx |
|------|-----|-----|
| 执行已安装的包 | 需要 `./node_modules/.bin/xxx` | 直接 `npx xxx` |
| 临时使用某个 CLI | 需要先 `npm install -g` | 直接 `npx xxx` |
| 指定版本执行 | 需要安装特定版本 | `npx pkg@version` |

#### 实用场景

```bash
# 创建 Vue 项目（无需全局安装 @vue/cli）
npx @vue/cli create my-vue-app

# 使用 cowsay 生成ASCII艺术（临时使用）
npx cowsay "Hello Node.js!"

# 运行不同版本的 Node.js
npx node@12 -e "console.log(process.version)"
npx node@18 -e "console.log(process.version)"
```

---

## 五、实战练习

### 创建一个数学工具包并发布到 npm 本地

在这个实战练习中，我们将创建一个功能完整的数学工具包，并将其发布到本地 npm  registry。

#### 步骤一：初始化项目

```bash
# 创建项目目录
mkdir math-utils
cd math-utils

# 初始化 package.json
npm init -y
```

修改生成的 `package.json`：

```json
{
  "name": "math-utils",
  "version": "1.0.0",
  "description": "一个实用的数学工具包，提供常用数学运算函数",
  "main": "index.js",
  "scripts": {
    "test": "node test.js"
  },
  "keywords": ["math", "utils", "math-utils"],
  "author": "你的名字",
  "license": "MIT"
}
```

#### 步骤二：编写模块代码

创建项目目录结构：

```
math-utils/
├── src/
│   ├── arithmetic.js    # 算术运算
│   ├── geometry.js      # 几何运算
│   └── statistics.js    # 统计运算
├── index.js             # 主入口
├── test.js              # 测试文件
└── package.json
```

##### arithmetic.js —— 算术运算模块

```javascript
// src/arithmetic.js

function add(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

function multiply(a, b) {
  return a * b;
}

function divide(a, b) {
  if (b === 0) {
    throw new Error('除数不能为零');
  }
  return a / b;
}

function power(base, exponent) {
  return Math.pow(base, exponent);
}

function sqrt(number) {
  if (number < 0) {
    throw new Error('不能对负数开方');
  }
  return Math.sqrt(number);
}

function mod(a, b) {
  if (b === 0) {
    throw new Error('除数不能为零');
  }
  return a % b;
}

function abs(number) {
  return Math.abs(number);
}

module.exports = { add, subtract, multiply, divide, power, sqrt, mod, abs };
```

##### geometry.js —— 几何运算模块

```javascript
// src/geometry.js

function circleArea(radius) {
  return Math.PI * radius * radius;
}

function circleCircumference(radius) {
  return 2 * Math.PI * radius;
}

function rectangleArea(width, height) {
  return width * height;
}

function rectanglePerimeter(width, height) {
  return 2 * (width + height);
}

function triangleArea(base, height) {
  return 0.5 * base * height;
}

function trianglePerimeter(a, b, c) {
  return a + b + c;
}

// 海伦公式计算三角形面积
function triangleAreaHeron(a, b, c) {
  const s = (a + b + c) / 2;
  return Math.sqrt(s * (s - a) * (s - b) * (s - c));
}

function sphereVolume(radius) {
  return (4 / 3) * Math.PI * Math.pow(radius, 3);
}

function sphereSurface(radius) {
  return 4 * Math.PI * radius * radius;
}

function cylinderVolume(radius, height) {
  return Math.PI * radius * radius * height;
}

function cylinderSurface(radius, height) {
  return 2 * Math.PI * radius * (radius + height);
}

module.exports = {
  circleArea,
  circleCircumference,
  rectangleArea,
  rectanglePerimeter,
  triangleArea,
  trianglePerimeter,
  triangleAreaHeron,
  sphereVolume,
  sphereSurface,
  cylinderVolume,
  cylinderSurface
};
```

##### statistics.js —— 统计运算模块

```javascript
// src/statistics.js

function mean(numbers) {
  if (!Array.isArray(numbers) || numbers.length === 0) {
    throw new Error('请传入非空数组');
  }
  const sum = numbers.reduce((acc, val) => acc + val, 0);
  return sum / numbers.length;
}

function median(numbers) {
  if (!Array.isArray(numbers) || numbers.length === 0) {
    throw new Error('请传入非空数组');
  }
  const sorted = [...numbers].sort((a, b) => a - b);
  const mid = Math.floor(sorted.length / 2);
  return sorted.length % 2 !== 0 ? sorted[mid] : (sorted[mid - 1] + sorted[mid]) / 2;
}

function mode(numbers) {
  if (!Array.isArray(numbers) || numbers.length === 0) {
    throw new Error('请传入非空数组');
  }
  const frequency = {};
  numbers.forEach(num => {
    frequency[num] = (frequency[num] || 0) + 1;
  });
  const maxFreq = Math.max(...Object.values(frequency));
  return Object.keys(frequency)
    .filter(key => frequency[key] === maxFreq)
    .map(Number);
}

function variance(numbers) {
  if (!Array.isArray(numbers) || numbers.length === 0) {
    throw new Error('请传入非空数组');
  }
  const avg = mean(numbers);
  const squaredDiffs = numbers.map(num => Math.pow(num - avg, 2));
  return squaredDiffs.reduce((acc, val) => acc + val, 0) / numbers.length;
}

function standardDeviation(numbers) {
  return Math.sqrt(variance(numbers));
}

function max(numbers) {
  if (!Array.isArray(numbers) || numbers.length === 0) {
    throw new Error('请传入非空数组');
  }
  return Math.max(...numbers);
}

function min(numbers) {
  if (!Array.isArray(numbers) || numbers.length === 0) {
    throw new Error('请传入非空数组');
  }
  return Math.min(...numbers);
}

function sum(numbers) {
  if (!Array.isArray(numbers) || numbers.length === 0) {
    throw new Error('请传入非空数组');
  }
  return numbers.reduce((acc, val) => acc + val, 0);
}

function product(numbers) {
  if (!Array.isArray(numbers) || numbers.length === 0) {
    throw new Error('请传入非空数组');
  }
  return numbers.reduce((acc, val) => acc * val, 1);
}

module.exports = { mean, median, mode, variance, standardDeviation, max, min, sum, product };
```

##### index.js —— 主入口文件

```javascript
// index.js

const arithmetic = require('./src/arithmetic');
const geometry = require('./src/geometry');
const statistics = require('./src/statistics');

module.exports = {
  arithmetic,
  geometry,
  statistics
};
```

##### test.js —— 测试文件

```javascript
// test.js

const mathUtils = require('./index');

let passed = 0;
let failed = 0;

function assert(condition, message) {
  if (condition) {
    passed++;
    console.log(`  ✓ ${message}`);
  } else {
    failed++;
    console.error(`  ✗ ${message}`);
  }
}

console.log('测试 arithmetic 模块:');
assert(mathUtils.arithmetic.add(2, 3) === 5, 'add(2, 3) === 5');
assert(mathUtils.arithmetic.subtract(10, 4) === 6, 'subtract(10, 4) === 6');
assert(mathUtils.arithmetic.multiply(3, 5) === 15, 'multiply(3, 5) === 15');
assert(mathUtils.arithmetic.divide(10, 2) === 5, 'divide(10, 2) === 5');
assert(mathUtils.arithmetic.power(2, 3) === 8, 'power(2, 3) === 8');
assert(mathUtils.arithmetic.sqrt(16) === 4, 'sqrt(16) === 4');
assert(mathUtils.arithmetic.mod(10, 3) === 1, 'mod(10, 3) === 1');
assert(mathUtils.arithmetic.abs(-5) === 5, 'abs(-5) === 5');

console.log('\n测试 geometry 模块:');
assert(Math.abs(mathUtils.geometry.circleArea(1) - Math.PI) < 0.0001, 'circleArea(1) === π');
assert(mathUtils.geometry.rectangleArea(4, 5) === 20, 'rectangleArea(4, 5) === 20');
assert(mathUtils.geometry.rectanglePerimeter(4, 5) === 18, 'rectanglePerimeter(4, 5) === 18');
assert(mathUtils.geometry.triangleArea(4, 6) === 12, 'triangleArea(4, 6) === 12');
assert(mathUtils.geometry.triangleAreaHeron(3, 4, 5) === 6, 'triangleAreaHeron(3, 4, 5) === 6');

console.log('\n测试 statistics 模块:');
assert(mathUtils.statistics.mean([1, 2, 3, 4, 5]) === 3, 'mean([1,2,3,4,5]) === 3');
assert(mathUtils.statistics.median([1, 3, 5, 7, 9]) === 5, 'median([1,3,5,7,9]) === 5');
assert(mathUtils.statistics.median([1, 2, 3, 4]) === 2.5, 'median([1,2,3,4]) === 2.5');
assert(mathUtils.statistics.sum([1, 2, 3, 4, 5]) === 15, 'sum([1,2,3,4,5]) === 15');
assert(mathUtils.statistics.max([1, 5, 3, 9, 2]) === 9, 'max([1,5,3,9,2]) === 9');
assert(mathUtils.statistics.min([1, 5, 3, 9, 2]) === 1, 'min([1,5,3,9,2]) === 1');
assert(mathUtils.statistics.product([1, 2, 3, 4]) === 24, 'product([1,2,3,4]) === 24');

console.log(`\n结果: ${passed} 通过, ${failed} 失败`);
```

#### 步骤三：运行测试

```bash
npm test
```

预期输出：

```
测试 arithmetic 模块:
  ✓ add(2, 3) === 5
  ✓ subtract(10, 4) === 6
  ✓ multiply(3, 5) === 15
  ✓ divide(10, 2) === 5
  ✓ power(2, 3) === 8
  ✓ sqrt(16) === 4
  ✓ mod(10, 3) === 1
  ✓ abs(-5) === 5

测试 geometry 模块:
  ✓ circleArea(1) === π
  ✓ rectangleArea(4, 5) === 20
  ✓ rectanglePerimeter(4, 5) === 18
  ✓ triangleArea(4, 6) === 12
  ✓ triangleAreaHeron(3, 4, 5) === 6

测试 statistics 模块:
  ✓ mean([1,2,3,4,5]) === 3
  ✓ median([1,3,5,7,9]) === 5
  ✓ median([1,2,3,4]) === 2.5
  ✓ sum([1,2,3,4,5]) === 15
  ✓ max([1,5,3,9,2]) === 9
  ✓ min([1,5,3,9,2]) === 1
  ✓ product([1,2,3,4]) === 24

结果: 26 通过, 0 失败
```

#### 步骤四：本地发布 npm 包

##### 方法一：使用本地 npm registry（Verdaccio）

[Verdaccio](https://verdaccio.org/) 是一个轻量级的本地 npm registry，非常适合本地开发和测试。

```bash
# 全局安装 Verdaccio
npm install -g verdaccio

# 启动 Verdaccio
verdaccio
```

Verdaccio 默认运行在 `http://localhost:4873`。在浏览器中打开该地址完成注册。

```bash
# 添加本地 registry 用户
npm adduser --registry http://localhost:4873

# 发布包到本地 registry
npm publish --registry http://localhost:4873
```

##### 方法二：使用 npm pack

`npm pack` 命令可以将包打包成 `.tgz` 文件，供本地安装测试。

```bash
# 打包
npm pack
# 会生成 math-utils-1.0.0.tgz 文件

# 在其他项目中本地安装
npm install /path/to/math-utils-1.0.0.tgz
```

##### 方法三：使用 npm link

`npm link` 可以将本地包链接到全局，然后在其他项目中使用。

```bash
# 在 math-utils 目录中执行
npm link

# 在另一个项目中执行
npm link math-utils

# 现在可以在另一个项目中使用
const mathUtils = require('math-utils');
console.log(mathUtils.arithmetic.add(1, 2)); // 3
```

#### 步骤五：使用发布的包

创建一个新项目来测试我们的数学工具包：

```bash
mkdir test-project
cd test-project
npm init -y

# 安装 math-utils（根据你选择的发布方式）
# 如果使用 npm link：
npm link math-utils

# 如果使用 .tgz 文件：
npm install ../math-utils/math-utils-1.0.0.tgz
```

创建 `app.js`：

```javascript
// app.js
const mathUtils = require('math-utils');

// 使用算术运算
console.log('=== 算术运算 ===');
console.log('2 + 3 =', mathUtils.arithmetic.add(2, 3));
console.log('10 - 4 =', mathUtils.arithmetic.subtract(10, 4));
console.log('5 × 6 =', mathUtils.arithmetic.multiply(5, 6));
console.log('10 ÷ 2 =', mathUtils.arithmetic.divide(10, 2));

// 使用几何运算
console.log('\n=== 几何运算 ===');
console.log('半径为1的圆面积 =', mathUtils.geometry.circleArea(1));
console.log('长4宽5的矩形周长 =', mathUtils.geometry.rectanglePerimeter(4, 5));
console.log('3-4-5三角形面积 =', mathUtils.geometry.triangleAreaHeron(3, 4, 5));

// 使用统计运算
console.log('\n=== 统计运算 ===');
const data = [12, 7, 3, 14, 6, 11, 9, 8, 5, 10];
console.log('数据集:', data);
console.log('平均值:', mathUtils.statistics.mean(data));
console.log('中位数:', mathUtils.statistics.median(data));
console.log('最大值:', mathUtils.statistics.max(data));
console.log('最小值:', mathUtils.statistics.min(data));
console.log('标准差:', mathUtils.statistics.standardDeviation(data));
```

运行结果：

```bash
node app.js
```

```
=== 算术运算 ===
2 + 3 = 5
10 - 4 = 6
5 × 6 = 30
10 ÷ 2 = 5

=== 几何运算 ===
半径为1的圆面积 = 3.141592653589793
长4宽5的矩形周长 = 18
3-4-5三角形面积 = 6

=== 统计运算 ===
数据集: [12, 7, 3, 14, 6, 11, 9, 8, 5, 10]
平均值: 8.5
中位数: 8.5
最大值: 14
最小值: 3
标准差: 3.398528886936173
```

#### 进阶：添加 README.md

为你的包创建一个规范的 `README.md` 文件，这是发布到 npm 的必备要素：

```markdown
# math-utils

一个实用的数学工具包，提供常用数学运算函数。

## 安装

```bash
npm install math-utils
```

## 使用方法

### 算术运算

```javascript
const mathUtils = require('math-utils');

mathUtils.arithmetic.add(2, 3);      // 5
mathUtils.arithmetic.subtract(10, 4); // 6
mathUtils.arithmetic.multiply(5, 6);  // 30
mathUtils.arithmetic.divide(10, 2);   // 5
```

### 几何运算

```javascript
mathUtils.geometry.circleArea(1);              // 圆面积
mathUtils.geometry.rectangleArea(4, 5);        // 矩形面积
mathUtils.geometry.triangleAreaHeron(3, 4, 5); // 三角形面积（海伦公式）
```

### 统计运算

```javascript
mathUtils.statistics.mean([1, 2, 3, 4, 5]);           // 平均值
mathUtils.statistics.median([1, 2, 3, 4, 5]);          // 中位数
mathUtils.statistics.standardDeviation([1, 2, 3, 4, 5]); // 标准差
```

## API

### arithmetic 模块

| 方法 | 描述 |
|------|------|
| `add(a, b)` | 加法 |
| `subtract(a, b)` | 减法 |
| `multiply(a, b)` | 乘法 |
| `divide(a, b)` | 除法（除数不能为零） |
| `power(base, exponent)` | 幂运算 |
| `sqrt(number)` | 开方（不能对负数开方） |
| `mod(a, b)` | 取模 |
| `abs(number)` | 绝对值 |

## 许可证

MIT
```

---

## 本章小结

### 知识点回顾

| 知识点 | 核心内容 |
|--------|---------|
| 模块化概述 | 模块化的必要性、演进历史（文件→IIFE→AMD/CMD→CommonJS/ESM）、Node.js 模块系统设计 |
| CommonJS | `require`、`exports`、`module.exports` 的使用与区别，模块加载规则 |
| ES Modules | `import`/`export`、`default` 导出、重命名、动态 `import()`、`type: "module"` |
| npm 包管理 | 常用命令、`package.json` 字段、语义化版本、`package-lock.json`、npx |
| 实战练习 | 创建完整数学工具包、编写测试、本地发布与使用 |

### 学习建议

1. **动手实践**：模块化是 Node.js 开发的基础，务必动手完成实战练习
2. **理解两种模块系统**：掌握 CommonJS 和 ES Modules 的区别，知道何时使用哪种
3. **善用 npm**：熟练掌握 npm 命令，这是 Node.js 开发者的日常工具
4. **阅读优秀源码**：通过阅读 npm 上优秀包的源码，学习模块化的最佳实践

### 常见面试题

1. `exports` 和 `module.exports` 的区别是什么？
2. CommonJS 和 ES Modules 的主要区别有哪些？
3. Node.js 中 `require` 的加载顺序是怎样的？
4. 什么是语义化版本？`^` 和 `~` 有什么区别？
5. `package-lock.json` 的作用是什么？
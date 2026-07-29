---
title: 06-Express框架实战
date: 2024-09-26T00:00:00+08:00
tags:
    - nodejs
    - 教程
    - Express
categories: node.js
cover: /images/cover13.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: "Express 框架深度实战教程，从路由系统到中间件机制，从错误处理到 RESTful API 设计，帮助开发者快速构建企业级 Web 应用。"
---

## 一、Express 简介

### 1.1 框架特点

Express 是 Node.js 平台上最流行、最成熟的 Web 应用框架，具有以下特点：

| 特点 | 说明 |
|------|------|
| 轻量级 | 核心功能简洁，无冗余设计 |
| 中间件架构 | 强大的中间件生态，灵活扩展 |
| 路由系统 | 清晰的路由定义，支持 RESTful 设计 |
| 模板引擎 | 支持多种模板引擎（EJS、Pug、Nunjucks 等） |
| 生态丰富 | npm 上有大量 Express 中间件和插件 |
| 文档完善 | 官方文档详尽，社区活跃 |

### 1.2 安装 Express

```bash
# 创建项目目录
mkdir my-express-app
cd my-express-app

# 初始化 package.json
npm init -y

# 安装 Express
npm install express
```

### 1.3 Hello World 示例

```javascript
// app.js
const express = require('express');
const app = express();
const PORT = 3000;

// 定义路由
app.get('/', (req, res) => {
  res.send('Hello, Express!');
});

// 启动服务器
app.listen(PORT, () => {
  console.log(`Server is running at http://localhost:${PORT}`);
});
```

运行：

```bash
node app.js
# 访问 http://localhost:3000
```

### 1.4 Express Generator 脚手架

Express 提供了官方脚手架工具快速生成项目结构：

```bash
# 安装脚手架
npm install -g express-generator

# 创建项目
express myapp --view=ejs

# 安装依赖
cd myapp
npm install

# 启动项目
npm start
```

生成的项目结构：

```
myapp/
├── bin/
│   └── www              # 启动脚本
├── public/              # 静态资源
│   ├── images/
│   ├── javascripts/
│   └── stylesheets/
├── routes/              # 路由文件
│   ├── index.js
│   └── users.js
├── views/               # 模板文件
│   ├── index.ejs
│   └── error.ejs
├── app.js               # 应用入口
└── package.json
```

## 二、路由系统

### 2.1 路由方法

Express 支持所有 HTTP 请求方法：

```javascript
// app.js
const express = require('express');
const app = express();

// GET 请求
app.get('/users', (req, res) => {
  res.json({ method: 'GET', message: '获取用户列表' });
});

// POST 请求
app.post('/users', (req, res) => {
  res.json({ method: 'POST', message: '创建用户' });
});

// PUT 请求（完整更新）
app.put('/users/:id', (req, res) => {
  res.json({ method: 'PUT', message: `更新用户 ${req.params.id}` });
});

// PATCH 请求（部分更新）
app.patch('/users/:id', (req, res) => {
  res.json({ method: 'PATCH', message: `部分更新用户 ${req.params.id}` });
});

// DELETE 请求
app.delete('/users/:id', (req, res) => {
  res.json({ method: 'DELETE', message: `删除用户 ${req.params.id}` });
});

// 匹配所有 HTTP 方法
app.all('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

app.listen(3000);
```

### 2.2 路由参数

#### 路径参数（Route Params）

```javascript
// 单个参数
app.get('/users/:id', (req, res) => {
  console.log(req.params); // { id: '123' }
  res.json({ userId: req.params.id });
});

// 多个参数
app.get('/posts/:postId/comments/:commentId', (req, res) => {
  console.log(req.params); // { postId: '1', commentId: '2' }
  res.json(req.params);
});

// 可选参数（使用正则）
app.get('/books/:id?', (req, res) => {
  if (req.params.id) {
    res.json({ bookId: req.params.id });
  } else {
    res.json({ books: [] });
  }
});
```

#### 查询参数（Query String）

```javascript
// GET /search?keyword=nodejs&page=1&limit=10
app.get('/search', (req, res) => {
  console.log(req.query);
  // { keyword: 'nodejs', page: '1', limit: '10' }

  const { keyword, page = 1, limit = 10 } = req.query;
  res.json({
    keyword,
    page: parseInt(page),
    limit: parseInt(limit),
    results: []
  });
});
```

### 2.3 路由模块化

使用 `express.Router` 实现路由模块化：

```javascript
// routes/users.js
const express = require('express');
const router = express.Router();

// 用户列表
router.get('/', (req, res) => {
  res.json({ users: [] });
});

// 创建用户
router.post('/', (req, res) => {
  res.json({ message: '用户创建成功' });
});

// 获取单个用户
router.get('/:id', (req, res) => {
  res.json({ userId: req.params.id });
});

// 更新用户
router.put('/:id', (req, res) => {
  res.json({ message: `用户 ${req.params.id} 更新成功` });
});

// 删除用户
router.delete('/:id', (req, res) => {
  res.json({ message: `用户 ${req.params.id} 删除成功` });
});

module.exports = router;
```

```javascript
// app.js
const express = require('express');
const usersRouter = require('./routes/users');

const app = express();

// 挂载路由
app.use('/users', usersRouter);

app.listen(3000);
```

## 三、中间件

### 3.1 中间件概念

中间件（Middleware）是 Express 的核心机制，它是一个函数，可以访问请求对象（`req`）、响应对象（`res`）和 `next` 函数。

```
请求 ──▶ 中间件1 ──▶ 中间件2 ──▶ ... ──▶ 路由处理 ──▶ 响应
              │
              ▼
            next()
```

### 3.2 应用级中间件

```javascript
const express = require('express');
const app = express();

// 记录请求日志
app.use((req, res, next) => {
  const start = Date.now();
  console.log(`${req.method} ${req.url} - ${new Date().toISOString()}`);

  // 调用 next() 继续执行下一个中间件
  next();

  const duration = Date.now() - start;
  console.log(`请求耗时: ${duration}ms`);
});

// 只对特定路径生效
app.use('/api', (req, res, next) => {
  console.log('API 请求拦截');
  next();
});

app.get('/', (req, res) => {
  res.send('Home Page');
});

app.get('/api/data', (req, res) => {
  res.json({ data: 'api data' });
});

app.listen(3000);
```

### 3.3 路由级中间件

```javascript
// 只对特定路由生效的中间件
const checkAuth = (req, res, next) => {
  const token = req.headers['authorization'];
  if (!token) {
    return res.status(401).json({ error: '未提供认证令牌' });
  }
  // 验证 token...
  req.userId = 'user123'; // 将用户信息挂载到 req
  next();
};

// 应用到单个路由
app.get('/profile', checkAuth, (req, res) => {
  res.json({ userId: req.userId, name: '张三' });
});

// 应用到路由组
app.get('/settings', checkAuth, (req, res) => {
  res.json({ userId: req.userId, theme: 'dark' });
});
```

### 3.4 错误处理中间件

```javascript
// 错误处理中间件（必须注册在所有路由之后）
app.use((err, req, res, next) => {
  console.error('错误:', err.message);

  // 区分不同类型的错误
  if (err.name === 'ValidationError') {
    return res.status(400).json({ error: '参数验证失败', details: err.message });
  }

  if (err.name === 'UnauthorizedError') {
    return res.status(401).json({ error: '认证失败' });
  }

  // 未知错误
  res.status(500).json({ error: '服务器内部错误' });
});
```

### 3.5 常用中间件

#### morgan（日志记录）

```bash
npm install morgan
```

```javascript
const morgan = require('morgan');

// 开发环境：彩色输出
app.use(morgan('dev'));

// 生产环境：标准 Apache 日志格式
// app.use(morgan('combined'));
```

#### body-parser（请求体解析）

```bash
npm install body-parser
```

```javascript
const bodyParser = require('body-parser');

// 解析 JSON 格式请求体
app.use(bodyParser.json());

// 解析 URL 编码请求体
app.use(bodyParser.urlencoded({ extended: true }));

// 解析文本格式
app.use(bodyParser.text());
```

#### cookie-parser

```bash
npm install cookie-parser
```

```javascript
const cookieParser = require('cookie-parser');

app.use(cookieParser());

app.get('/set-cookie', (req, res) => {
  res.cookie('token', 'abc123', {
    httpOnly: true,
    maxAge: 3600000 // 1小时
  });
  res.send('Cookie 已设置');
});

app.get('/get-cookie', (req, res) => {
  console.log(req.cookies);
  res.json(req.cookies);
});
```

### 3.6 自定义中间件

```javascript
// 身份验证中间件
const authMiddleware = (req, res, next) => {
  const token = req.headers['authorization']?.replace('Bearer ', '');

  if (!token) {
    return res.status(401).json({ error: '请提供认证令牌' });
  }

  try {
    // 验证 token（这里使用简单示例，实际应使用 jwt.verify）
    const decoded = Buffer.from(token, 'base64').toString();
    req.user = { id: decoded };
    next();
  } catch (error) {
    return res.status(401).json({ error: '令牌无效' });
  }
};

// 请求限流中间件
const rateLimit = (maxRequests, windowMs) => {
  const requests = new Map();

  return (req, res, next) => {
    const ip = req.ip;
    const now = Date.now();

    if (!requests.has(ip)) {
      requests.set(ip, []);
    }

    const userRequests = requests.get(ip);
    const recentRequests = userRequests.filter(time => now - time < windowMs);

    if (recentRequests.length >= maxRequests) {
      return res.status(429).json({ error: '请求过于频繁，请稍后再试' });
    }

    recentRequests.push(now);
    requests.set(ip, recentRequests);
    next();
  };
};

// 使用自定义中间件
app.use(rateLimit(100, 60000)); // 每分钟最多100次请求
app.use('/api/private', authMiddleware);
```

## 四、请求与响应

### 4.1 req 对象常用属性和方法

```javascript
app.get('/request-info', (req, res) => {
  const info = {
    method: req.method,           // 请求方法
    url: req.url,                 // 请求路径
    originalUrl: req.originalUrl, // 原始请求路径
    protocol: req.protocol,       // 协议（http/https）
    hostname: req.hostname,       // 主机名
    ip: req.ip,                   // 客户端 IP
    headers: req.headers,         // 请求头
    query: req.query,             // 查询参数
    params: req.params,           // 路径参数
    body: req.body,               // 请求体（需配合 body-parser）
    cookies: req.cookies,         // Cookies（需配合 cookie-parser）
    session: req.session          // Session（需配合 express-session）
  };

  res.json(info);
});
```

### 4.2 res 对象常用方法

```javascript
// 发送文本
app.get('/text', (req, res) => {
  res.send('Hello World');
});

// 发送 JSON
app.get('/json', (req, res) => {
  res.json({ name: '张三', age: 25 });
});

// 发送 HTML
app.get('/html', (req, res) => {
  res.send('<h1>Hello HTML</h1>');
});

// 发送文件
app.get('/file', (req, res) => {
  res.sendFile('/path/to/file.pdf');
});

// 设置状态码
app.get('/status', (req, res) => {
  res.status(201).json({ message: 'Created' });
});

// 设置响应头
app.get('/headers', (req, res) => {
  res.set('X-Custom-Header', 'value');
  res.json({ message: 'Headers set' });
});

// 重定向
app.get('/redirect', (req, res) => {
  res.redirect('https://example.com');
});

// 下载文件
app.get('/download', (req, res) => {
  res.download('/path/to/file.pdf', 'report.pdf');
});
```

### 4.3 静态文件服务

```javascript
const express = require('express');
const path = require('path');
const app = express();

// 托管静态文件
app.use(express.static('public'));

// 指定虚拟路径前缀
app.use('/static', express.static(path.join(__dirname, 'public')));

// 访问：
// http://localhost:3000/images/logo.png
// http://localhost:3000/static/images/logo.png
```

## 五、错误处理

### 5.1 404 处理

```javascript
// 404 处理（放在所有路由之后）
app.use((req, res) => {
  res.status(404).json({
    error: 'Not Found',
    path: req.path
  });
});
```

### 5.2 全局错误处理

```javascript
// 同步错误自动捕获
app.get('/sync-error', (req, res) => {
  throw new Error('同步错误示例');
});

// 异步错误需要手动传递给 next
app.get('/async-error', async (req, res, next) => {
  try {
    const data = await someAsyncOperation();
    res.json(data);
  } catch (error) {
    next(error);
  }
});

// Express 5.0 支持异步错误自动捕获
// app.get('/async-error', async (req, res) => {
//   const data = await someAsyncOperation(); // 如果报错会自动传递给错误处理中间件
//   res.json(data);
// });

// 全局错误处理中间件
app.use((err, req, res, next) => {
  console.error('全局错误:', err);

  // 根据错误类型返回不同状态码
  const statusCode = err.statusCode || 500;

  res.status(statusCode).json({
    error: err.message,
    stack: process.env.NODE_ENV === 'development' ? err.stack : undefined
  });
});
```

### 5.3 自定义错误类

```javascript
// errors/AppError.js
class AppError extends Error {
  constructor(message, statusCode) {
    super(message);
    this.statusCode = statusCode;
    this.status = `${statusCode}`.startsWith('4') ? 'fail' : 'error';
    this.isOperational = true;

    Error.captureStackTrace(this, this.constructor);
  }
}

class NotFoundError extends AppError {
  constructor(message = '资源不存在') {
    super(message, 404);
  }
}

class ValidationError extends AppError {
  constructor(message = '参数验证失败') {
    super(message, 400);
  }
}

class UnauthorizedError extends AppError {
  constructor(message = '认证失败') {
    super(message, 401);
  }
}

module.exports = { AppError, NotFoundError, ValidationError, UnauthorizedError };
```

使用自定义错误：

```javascript
const { NotFoundError, ValidationError } = require('./errors/AppError');

app.get('/users/:id', (req, res, next) => {
  const user = findUserById(req.params.id);

  if (!user) {
    return next(new NotFoundError(`用户 ${req.params.id} 不存在`));
  }

  res.json(user);
});

app.post('/users', (req, res, next) => {
  if (!req.body.name) {
    return next(new ValidationError('用户名不能为空'));
  }

  // 创建用户...
  res.status(201).json({ message: '创建成功' });
});
```

## 六、实战练习

### 6.1 RESTful API 服务实现

#### 项目结构

```
restful-api/
├── config/
│   └── db.js
├── controllers/
│   └── userController.js
├── middleware/
│   └── errorHandler.js
├── models/
│   └── User.js
├── routes/
│   └── users.js
├── app.js
└── package.json
```

#### app.js

```javascript
const express = require('express');
const morgan = require('morgan');
const bodyParser = require('body-parser');

const usersRouter = require('./routes/users');
const errorHandler = require('./middleware/errorHandler');

const app = express();

// 中间件
app.use(morgan('dev'));
app.use(bodyParser.json());

// 路由
app.use('/api/users', usersRouter);

// 404 处理
app.use((req, res, next) => {
  const error = new Error(`Not Found - ${req.originalUrl}`);
  error.statusCode = 404;
  next(error);
});

// 错误处理
app.use(errorHandler);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

#### models/User.js

```javascript
// 简单的内存数据存储（实际项目应使用数据库）
let users = [
  { id: 1, name: '张三', email: 'zhangsan@example.com', age: 25 },
  { id: 2, name: '李四', email: 'lisi@example.com', age: 30 },
  { id: 3, name: '王五', email: 'wangwu@example.com', age: 28 }
];

let nextId = 4;

module.exports = {
  findAll: () => [...users],
  findById: (id) => users.find(u => u.id === parseInt(id)),
  create: (userData) => {
    const newUser = { id: nextId++, ...userData };
    users.push(newUser);
    return newUser;
  },
  update: (id, userData) => {
    const index = users.findIndex(u => u.id === parseInt(id));
    if (index === -1) return null;
    users[index] = { ...users[index], ...userData };
    return users[index];
  },
  delete: (id) => {
    const index = users.findIndex(u => u.id === parseInt(id));
    if (index === -1) return false;
    users.splice(index, 1);
    return true;
  }
};
```

#### controllers/userController.js

```javascript
const User = require('../models/User');
const { NotFoundError, ValidationError } = require('../errors/AppError');

// 获取用户列表
exports.getUsers = (req, res) => {
  const { page = 1, limit = 10, name } = req.query;

  let users = User.findAll();

  // 按名称筛选
  if (name) {
    users = users.filter(u => u.name.includes(name));
  }

  // 分页
  const start = (parseInt(page) - 1) * parseInt(limit);
  const end = start + parseInt(limit);
  const paginatedUsers = users.slice(start, end);

  res.json({
    data: paginatedUsers,
    meta: {
      total: users.length,
      page: parseInt(page),
      limit: parseInt(limit),
      totalPages: Math.ceil(users.length / parseInt(limit))
    }
  });
};

// 获取单个用户
exports.getUser = (req, res, next) => {
  const user = User.findById(req.params.id);

  if (!user) {
    return next(new NotFoundError(`用户 ${req.params.id} 不存在`));
  }

  res.json(user);
};

// 创建用户
exports.createUser = (req, res, next) => {
  const { name, email, age } = req.body;

  // 验证必填字段
  if (!name || !email) {
    return next(new ValidationError('姓名和邮箱为必填项'));
  }

  // 验证邮箱格式
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(email)) {
    return next(new ValidationError('邮箱格式不正确'));
  }

  const newUser = User.create({ name, email, age });
  res.status(201).json(newUser);
};

// 更新用户
exports.updateUser = (req, res, next) => {
  const { name, email, age } = req.body;

  const updatedUser = User.update(req.params.id, { name, email, age });

  if (!updatedUser) {
    return next(new NotFoundError(`用户 ${req.params.id} 不存在`));
  }

  res.json(updatedUser);
};

// 删除用户
exports.deleteUser = (req, res, next) => {
  const deleted = User.delete(req.params.id);

  if (!deleted) {
    return next(new NotFoundError(`用户 ${req.params.id} 不存在`));
  }

  res.status(204).send();
};
```

#### routes/users.js

```javascript
const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// GET /api/users - 获取用户列表
router.get('/', userController.getUsers);

// GET /api/users/:id - 获取单个用户
router.get('/:id', userController.getUser);

// POST /api/users - 创建用户
router.post('/', userController.createUser);

// PUT /api/users/:id - 更新用户
router.put('/:id', userController.updateUser);

// DELETE /api/users/:id - 删除用户
router.delete('/:id', userController.deleteUser);

module.exports = router;
```

#### middleware/errorHandler.js

```javascript
module.exports = (err, req, res, next) => {
  console.error('错误详情:', err);

  const statusCode = err.statusCode || 500;
  const message = err.isOperational ? err.message : '服务器内部错误';

  res.status(statusCode).json({
    status: 'error',
    statusCode,
    message,
    ...(process.env.NODE_ENV === 'development' && { stack: err.stack })
  });
};
```

### 6.2 API 测试

使用 curl 或 Postman 测试：

```bash
# 获取用户列表
curl http://localhost:3000/api/users

# 分页查询
curl "http://localhost:3000/api/users?page=1&limit=2"

# 获取单个用户
curl http://localhost:3000/api/users/1

# 创建用户
curl -X POST http://localhost:3000/api/users \
  -H "Content-Type: application/json" \
  -d '{"name":"赵六","email":"zhaoliu@example.com","age":35}'

# 更新用户
curl -X PUT http://localhost:3000/api/users/1 \
  -H "Content-Type: application/json" \
  -d '{"name":"张三（已更新）","age":26}'

# 删除用户
curl -X DELETE http://localhost:3000/api/users/1
```

---

> 💡 **小结**：Express 框架以其简洁的设计和强大的中间件生态成为 Node.js Web 开发的首选。掌握路由系统、中间件机制和错误处理后，你可以快速构建任何规模的 Web 应用。
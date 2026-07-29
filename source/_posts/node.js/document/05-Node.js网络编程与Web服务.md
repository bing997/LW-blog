---
title: 05-Node.js网络编程与Web服务
date: 2024-09-25T00:00:00+08:00
tags:
  - nodejs
  - 教程
  - 网络编程
categories:
  - node.js
cover: /images/cover13.png
sticky: false
description: Node.js网络编程与Web服务详解，涵盖HTTP协议、http模块、静态文件服务、net模块与TCP编程、WebSocket实时通信及实战练习。
---

## Node.js 网络编程与 Web 服务

Node.js 作为一款服务端 JavaScript 运行时，网络编程是其最核心的应用领域之一。本章将从 HTTP 协议基础讲起，逐步介绍 Node.js 中用于构建 Web 服务的 `http` 模块、静态文件服务实现、底层 `net` 模块的 TCP 编程，以及基于 WebSocket 的实时通信，最后通过实战练习巩固所学知识。

### 一、HTTP 协议基础

HTTP（HyperText Transfer Protocol，超文本传输协议）是 Web 应用中最基础的协议，它定义了客户端与服务器之间通信的格式和规则。在学习 Node.js 的 `http` 模块之前，我们需要先了解 HTTP 协议的核心概念。

#### 1.1 请求与响应

HTTP 通信采用经典的 **请求-响应（Request-Response）** 模式：

- **客户端（Client）**：发起请求的一方，通常是浏览器或移动端应用
- **服务器（Server）**：接收请求并返回响应的一方

一次完整的 HTTP 交互包含两个核心部分：

**请求（Request）** 由三部分组成：

- **请求行**：包含请求方法、请求 URL 和 HTTP 协议版本
- **请求头（Request Header）**：附加信息，如 `Content-Type`、`User-Agent`、`Cookie` 等
- **请求体（Request Body）**：可选，通常用于 POST/PUT 请求传递数据

```http
POST /api/login HTTP/1.1
Host: example.com
Content-Type: application/json
User-Agent: Mozilla/5.0

{"username":"admin","password":"123456"}
```

**响应（Response）** 同样由三部分组成：

- **状态行**：包含 HTTP 协议版本、状态码和状态描述
- **响应头（Response Header）**：附加信息，如 `Content-Type`、`Set-Cookie`、`Cache-Control` 等
- **响应体（Response Body）**：实际返回的数据内容

```http
HTTP/1.1 200 OK
Content-Type: application/json
Set-Cookie: session=abc123; HttpOnly

{"code":0,"message":"登录成功"}
```

#### 1.2 HTTP 状态码

状态码用于描述服务器对请求的处理结果，共分为五类：

| 状态码范围 | 类别 | 说明 | 常见状态码 |
|-----------|------|------|-----------|
| 100-199 | 信息响应 | 表示请求已收到，继续处理 | 100 Continue |
| 200-299 | 成功响应 | 表示请求已成功处理 | 200 OK、201 Created、204 No Content |
| 300-399 | 重定向 | 表示需要客户端进一步操作 | 301 Moved Permanently、302 Found、304 Not Modified |
| 400-499 | 客户端错误 | 表示客户端请求有误 | 400 Bad Request、401 Unauthorized、403 Forbidden、404 Not Found、405 Method Not Allowed |
| 500-599 | 服务端错误 | 表示服务器处理请求时出错 | 500 Internal Server Error、502 Bad Gateway、503 Service Unavailable、504 Gateway Timeout |

> **常见状态码说明：**
>
> - **200 OK**：请求成功处理
> - **301/302**：永久/临时重定向，浏览器会自动跳转到新地址
> - **304 Not Modified**：协商缓存命中，直接使用本地缓存
> - **400 Bad Request**：请求参数错误
> - **401 Unauthorized**：未认证或认证失败（未登录）
> - **403 Forbidden**：服务器拒绝访问（权限不足）
> - **404 Not Found**：请求的资源不存在
> - **500 Internal Server Error**：服务器内部错误
> - **502 Bad Gateway**：网关从上游收到无效响应
> - **503 Service Unavailable**：服务暂时不可用

#### 1.3 HTTP 请求方法

HTTP/1.1 定义了多种请求方法，每种方法具有不同的语义：

| 方法 | 描述 | 幂等性 | 是否有请求体 |
|------|------|--------|-------------|
| GET | 获取资源 | 幂等 | 否 |
| POST | 创建资源 | 非幂等 | 是 |
| PUT | 全量更新资源 | 幂等 | 是 |
| PATCH | 部分更新资源 | 非幂等 | 是 |
| DELETE | 删除资源 | 幂等 | 可选 |
| HEAD | 获取响应头（无响应体） | 幂等 | 否 |
| OPTIONS | 查询支持的 HTTP 方法 | 幂等 | 否 |

> **RESTful API 设计建议：**
> - 使用名词而非动词命名 URL，如 `/users` 而非 `/getUsers`
> - 使用复数形式，如 `/users` 而非 `/user`
> - 通过不同的 HTTP 方法区分操作：`GET` 查询、`POST` 新增、`PUT` 修改、`DELETE` 删除
> - 通过 URL 路径表达层级关系，如 `/users/:id/orders`

#### 1.4 HTTP Header

Header 是 HTTP 请求和响应中的元数据部分，用于传递附加信息。

**常用请求头：**

| Header | 作用 | 示例 |
|--------|------|------|
| `Host` | 指定请求的主机名 | `Host: example.com` |
| `User-Agent` | 客户端信息 | `User-Agent: Mozilla/5.0` |
| `Accept` | 客户端能接收的内容类型 | `Accept: application/json` |
| `Content-Type` | 请求体的数据格式 | `Content-Type: application/json` |
| `Cookie` | 携带 Cookie 信息 | `Cookie: session=abc123` |
| `Authorization` | 认证凭证 | `Authorization: Bearer token123` |
| `Referer` | 来源页面 | `Referer: https://example.com/home` |
| `Origin` | 请求来源（CORS 用） | `Origin: https://example.com` |

**常用响应头：**

| Header | 作用 | 示例 |
|--------|------|------|
| `Content-Type` | 响应体的数据格式 | `Content-Type: text/html; charset=utf-8` |
| `Set-Cookie` | 设置 Cookie | `Set-Cookie: session=abc123; HttpOnly` |
| `Cache-Control` | 缓存策略 | `Cache-Control: max-age=3600` |
| `Location` | 重定向目标 | `Location: /new-url` |
| `Access-Control-Allow-Origin` | CORS 允许的源 | `Access-Control-Allow-Origin: *` |
| `Content-Disposition` | 下载文件信息 | `Content-Disposition: attachment; filename="file.zip"` |
| `Etag` | 资源标识（缓存用） | `ETag: "abc123"` |
| `Last-Modified` | 资源最后修改时间 | `Last-Modified: Mon, 25 Sep 2024 10:00:00 GMT` |

#### 1.5 Cookie 与 Session

Cookie 和 Session 是两种常见的会话跟踪机制，用于在无状态的 HTTP 协议上维护客户端与服务器之间的状态。

**Cookie：**

Cookie 是由服务器通过 `Set-Cookie` 响应头设置，存储在客户端浏览器中的一小段数据。浏览器在后续请求中会自动通过 `Cookie` 请求头将其发送回服务器。

```http
// 服务器设置 Cookie
HTTP/1.1 200 OK
Set-Cookie: user_id=123; Path=/; Domain=example.com; Max-Age=3600; HttpOnly; Secure

// 后续请求自动携带 Cookie
GET /profile HTTP/1.1
Cookie: user_id=123
```

**Cookie 的常用属性：**

- `Expires` / `Max-Age`：过期时间
- `Path`：Cookie 生效的路径
- `Domain`：Cookie 生效的域名
- `HttpOnly`：禁止 JavaScript 访问（防范 XSS）
- `Secure`：只在 HTTPS 连接中发送
- `SameSite`：跨站请求限制（`Strict`、`Lax`、`None`）

**Session：**

Session 是另一种会话跟踪机制，由服务器端保存会话状态。通常的做法是：

1. 客户端首次请求时，服务器创建 Session 对象并生成唯一的 Session ID
2. 服务器通过 `Set-Cookie` 将 Session ID 返回给客户端
3. 客户端后续请求携带 Cookie（包含 Session ID）
4. 服务器根据 Session ID 查找对应的 Session 数据

```
┌──────────┐    第一次请求（无 Cookie）    ┌──────────┐
│  客户端   │ ──────────────────────────→  │  服务器   │
│          │                            │          │
│          │  ←────────────────────────── │          │
│          │  Set-Cookie: JSESSIONID=abc  │  创建 Session 并存储数据
└──────────┘                            └──────────┘

┌──────────┐    后续请求（携带 Cookie）    ┌──────────┐
│  客户端   │ ──────────────────────────→  │  服务器   │
│          │  Cookie: JSESSIONID=abc     │  查找 Session 并获取数据
│          │                            │          │
│          │  ←────────────────────────── │          │
│          │  返回带用户信息的响应         │          │
└──────────┘                            └──────────┘
```

**Cookie vs Session 对比：**

| 对比项 | Cookie | Session |
|--------|--------|---------|
| 存储位置 | 客户端浏览器 | 服务器端 |
| 安全性 | 相对不安全，可被篡改 | 相对安全，数据在服务端 |
| 存储容量 | 单个 Cookie 最大 4KB | 服务器内存/磁盘，容量大 |
| 跨域支持 | 可通过 Domain 设置 | 需额外处理（Redis 共享） |
| 生命周期 | 可设置过期时间 | 通常由服务器控制 |

> **安全建议：** 敏感信息（如用户身份认证状态）应使用 Session 存储，不要直接存储在 Cookie 中。如果必须使用 Cookie 存储 Token，应结合 `HttpOnly` 和 `Secure` 属性，并使用 HTTPS 传输。

---

### 二、http 模块

Node.js 的 `http` 模块是构建 Web 服务的核心，它封装了 HTTP 协议的解析和处理逻辑。

#### 2.1 创建 HTTP 服务器

使用 `http.createServer()` 方法可以快速创建一个 HTTP 服务器。

```javascript
const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain; charset=utf-8' });
  res.end('Hello, Node.js!');
});

const PORT = 3000;
server.listen(PORT, () => {
  console.log(`服务器已启动: http://localhost:${PORT}`);
});
```

运行上述代码，然后在浏览器中访问 `http://localhost:3000`，将看到 "Hello, Node.js!" 的输出。

> **注意：** `createServer` 的回调函数有两个参数：
> - `req`（IncomingMessage）：客户端请求对象，包含请求的所有信息
> - `res`（ServerResponse）：服务器响应对象，用于构建和发送响应

#### 2.2 处理请求与响应

#### 获取请求信息

`req` 对象包含了客户端请求的所有信息：

```javascript
const http = require('http');

const server = http.createServer((req, res) => {
  // 请求方法
  console.log('请求方法:', req.method);

  // 请求 URL
  console.log('请求 URL:', req.url);

  // HTTP 协议版本
  console.log('HTTP 版本:', req.httpVersion);

  // 请求头
  console.log('请求头:', req.headers);

  // 客户端 IP
  console.log('客户端 IP:', req.socket.remoteAddress);

  res.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8' });
  res.end(JSON.stringify({ method: req.method, url: req.url }));
});

server.listen(3000);
```

#### 获取请求体

对于 POST/PUT 请求，请求体数据需要通过事件监听来获取：

```javascript
const http = require('http');

const server = http.createServer((req, res) => {
  let body = '';

  // 监听 data 事件，分块接收请求体
  req.on('data', (chunk) => {
    body += chunk.toString();
  });

  // 监听 end 事件，请求体接收完成
  req.on('end', () => {
    console.log('请求体:', body);

    res.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8' });
    res.end(JSON.stringify({ received: body }));
  });
});

server.listen(3000);
```

> **提示：** 在实际项目中，通常会使用 `body-parser`、`multer` 等中间件来处理更复杂的请求体解析（如 `application/json`、`multipart/form-data` 等）。

#### 发送响应

`res` 对象提供了多种方法来构建响应：

```javascript
const http = require('http');

const server = http.createServer((req, res) => {
  // 1. 设置响应状态码
  res.statusCode = 200;

  // 2. 设置响应头
  res.setHeader('Content-Type', 'text/plain; charset=utf-8');
  res.setHeader('X-Custom-Header', 'custom-value');

  // 或者使用 writeHead 一次性设置
  // res.writeHead(200, { 'Content-Type': 'text/plain; charset=utf-8' });

  // 3. 写入响应体（可多次调用）
  res.write('第一行内容\n');
  res.write('第二行内容\n');

  // 4. 结束响应（必须调用）
  res.end('响应结束');
});

server.listen(3000);
```

#### 2.3 路由分发

通过判断 `req.url` 和 `req.method`，可以实现简单的路由分发：

```javascript
const http = require('http');

const server = http.createServer((req, res) => {
  // 设置通用响应头
  res.setHeader('Content-Type', 'text/html; charset=utf-8');

  // 获取路径和查询参数
  const url = new URL(req.url, `http://${req.headers.host}`);
  const pathname = url.pathname;

  // 路由匹配
  if (req.method === 'GET' && pathname === '/') {
    res.writeHead(200);
    res.end('<h1>首页</h1>');
  } else if (req.method === 'GET' && pathname === '/about') {
    res.writeHead(200);
    res.end('<h1>关于我们</h1>');
  } else if (req.method === 'GET' && pathname === '/api/user') {
    res.setHeader('Content-Type', 'application/json; charset=utf-8');
    res.writeHead(200);
    res.end(JSON.stringify({ id: 1, name: '张三' }));
  } else if (req.method === 'POST' && pathname === '/api/login') {
    let body = '';
    req.on('data', (chunk) => { body += chunk; });
    req.on('end', () => {
      const { username, password } = JSON.parse(body);
      if (username === 'admin' && password === '123456') {
        res.writeHead(200);
        res.end(JSON.stringify({ code: 0, message: '登录成功' }));
      } else {
        res.writeHead(401);
        res.end(JSON.stringify({ code: 1, message: '用户名或密码错误' }));
      }
    });
  } else {
    res.writeHead(404);
    res.end('<h1>404 - 页面未找到</h1>');
  }
});

server.listen(3000, () => {
  console.log('服务器已启动: http://localhost:3000');
});
```

#### 2.4 获取请求参数

#### URL 查询参数（GET）

使用 `URL` 类或 `url` 模块来解析查询参数：

```javascript
const http = require('http');

const server = http.createServer((req, res) => {
  const url = new URL(req.url, `http://${req.headers.host}`);

  // 获取查询参数
  const name = url.searchParams.get('name');
  const age = url.searchParams.get('age');

  console.log('name:', name);
  console.log('age:', age);

  res.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8' });
  res.end(JSON.stringify({ name, age }));
});

server.listen(3000);
```

访问 `http://localhost:3000/?name=张三&age=25` 即可获取参数。

#### 路由参数（动态路由）

通过手动解析路径来实现动态路由：

```javascript
const http = require('http');

const server = http.createServer((req, res) => {
  const url = new URL(req.url, `http://${req.headers.host}`);
  const pathname = url.pathname;

  // 匹配 /api/users/:id
  const match = pathname.match(/^\/api\/users\/(\d+)$/);

  if (match) {
    const userId = match[1];
    res.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8' });
    res.end(JSON.stringify({ id: userId, name: `用户${userId}` }));
  } else {
    res.writeHead(404, { 'Content-Type': 'application/json; charset=utf-8' });
    res.end(JSON.stringify({ error: 'Not Found' }));
  }
});

server.listen(3000);
```

#### 2.5 返回 HTML 与 JSON

#### 返回 HTML 页面

```javascript
const http = require('http');
const fs = require('fs');
const path = require('path');

const server = http.createServer((req, res) => {
  // 方式一：直接返回 HTML 字符串
  if (req.url === '/') {
    const html = `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="UTF-8">
        <title>Node.js 服务器</title>
      </head>
      <body>
        <h1>欢迎使用 Node.js</h1>
        <p>这是一个动态生成的页面</p>
        <p>当前时间：${new Date().toLocaleString()}</p>
      </body>
      </html>
    `;
    res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
    res.end(html);
  }
});

server.listen(3000);
```

#### 返回 JSON 数据

```javascript
const http = require('http');

const server = http.createServer((req, res) => {
  // 设置 CORS 头，允许跨域访问
  res.writeHead(200, {
    'Content-Type': 'application/json; charset=utf-8',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization'
  });

  const data = {
    code: 0,
    message: 'success',
    data: {
      users: [
        { id: 1, name: '张三', email: 'zhangsan@example.com' },
        { id: 2, name: '李四', email: 'lisi@example.com' },
        { id: 3, name: '王五', email: 'wangwu@example.com' }
      ],
      total: 3
    }
  };

  res.end(JSON.stringify(data));
});

server.listen(3000);
```

#### CORS 跨域处理

当浏览器从不同源（协议+域名+端口）请求 API 时会触发跨域限制。以下是一个完整的 CORS 处理方案：

```javascript
const http = require('http');

const server = http.createServer((req, res) => {
  // 设置 CORS 响应头
  res.setHeader('Access-Control-Allow-Origin', 'http://localhost:8080');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  res.setHeader('Access-Control-Allow-Credentials', 'true');
  res.setHeader('Access-Control-Max-Age', '86400');

  // 处理预检请求（OPTIONS）
  if (req.method === 'OPTIONS') {
    res.writeHead(204);
    res.end();
    return;
  }

  // 处理正常请求
  res.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8' });
  res.end(JSON.stringify({ message: '跨域请求成功' }));
});

server.listen(3000);
```

---

### 三、静态文件服务

静态文件服务是 Web 服务器的基本功能，用于向客户端提供 HTML、CSS、JavaScript、图片等静态资源。

#### 3.1 读取静态文件

使用 `fs` 模块读取文件内容并返回给客户端：

```javascript
const http = require('http');
const fs = require('fs');
const path = require('path');

const PUBLIC_DIR = path.join(__dirname, 'public');

const server = http.createServer((req, res) => {
  // 确定文件路径
  let filePath = path.join(PUBLIC_DIR, req.url === '/' ? 'index.html' : req.url);

  // 防止路径穿越攻击
  if (!filePath.startsWith(PUBLIC_DIR)) {
    res.writeHead(403);
    res.end('Forbidden');
    return;
  }

  // 读取并返回文件
  fs.readFile(filePath, (err, data) => {
    if (err) {
      if (err.code === 'ENOENT') {
        res.writeHead(404);
        res.end('File Not Found');
      } else {
        res.writeHead(500);
        res.end('Server Error');
      }
      return;
    }

    res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
    res.end(data);
  });
});

server.listen(3000);
```

#### 3.2 MIME 类型

MIME（Multipurpose Internet Mail Extensions）类型告诉浏览器响应数据的类型。正确设置 MIME 类型对于文件正常显示至关重要。

```javascript
// 常见 MIME 类型映射
const mimeTypes = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.txt': 'text/plain; charset=utf-8',
  '.xml': 'application/xml; charset=utf-8',
  '.pdf': 'application/pdf',
  '.zip': 'application/zip',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
  '.ttf': 'font/ttf',
  '.mp3': 'audio/mpeg',
  '.mp4': 'video/mp4'
};
```

**改进版静态文件服务（支持 MIME 类型）：**

```javascript
const http = require('http');
const fs = require('fs');
const path = require('path');

const PUBLIC_DIR = path.join(__dirname, 'public');

const mimeTypes = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.txt': 'text/plain; charset=utf-8',
  '.pdf': 'application/pdf',
  '.zip': 'application/zip',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2'
};

const server = http.createServer((req, res) => {
  let filePath = path.join(PUBLIC_DIR, req.url === '/' ? 'index.html' : req.url);

  if (!filePath.startsWith(PUBLIC_DIR)) {
    res.writeHead(403);
    res.end('Forbidden');
    return;
  }

  const ext = path.extname(filePath).toLowerCase();
  const contentType = mimeTypes[ext] || 'application/octet-stream';

  fs.readFile(filePath, (err, data) => {
    if (err) {
      res.writeHead(404);
      res.end('Not Found');
      return;
    }
    res.writeHead(200, { 'Content-Type': contentType });
    res.end(data);
  });
});

server.listen(3000);
```

#### 3.3 缓存控制

合理使用缓存可以显著提升性能，减少网络传输。HTTP 缓存主要分为两类：**协商缓存** 和 **强缓存**。

**强缓存（由服务端控制）：**

```javascript
// 设置强缓存
res.writeHead(200, {
  'Content-Type': contentType,
  'Cache-Control': 'public, max-age=3600'  // 缓存 1 小时
});
```

**`Cache-Control` 常用指令：**

| 指令 | 说明 |
|------|------|
| `max-age=3600` | 缓存有效期为 3600 秒 |
| `no-cache` | 需要协商缓存，每次都要验证 |
| `no-store` | 完全不缓存 |
| `public` | 允许所有缓存（包括 CDN）存储 |
| `private` | 仅浏览器缓存，CDN 不可缓存 |

**协商缓存（需要浏览器和服务器配合）：**

```javascript
const http = require('http');
const fs = require('fs');
const path = require('path');

const PUBLIC_DIR = path.join(__dirname, 'public');

const server = http.createServer((req, res) => {
  let filePath = path.join(PUBLIC_DIR, req.url === '/' ? 'index.html' : req.url);

  fs.stat(filePath, (err, stats) => {
    if (err) {
      res.writeHead(404);
      res.end('Not Found');
      return;
    }

    const etag = `"${stats.size}-${stats.mtime.getTime()}"`;
    const lastModified = stats.mtime.toUTCString();

    // 检查协商缓存
    const ifNoneMatch = req.headers['if-none-match'];
    const ifModifiedSince = req.headers['if-modified-since'];

    // ETag 匹配
    if (ifNoneMatch === etag) {
      res.writeHead(304);
      res.end();
      return;
    }

    // Last-Modified 匹配
    if (ifModifiedSince && new Date(ifModifiedSince) >= stats.mtime) {
      res.writeHead(304);
      res.end();
      return;
    }

    // 返回文件并设置缓存头
    fs.readFile(filePath, (err, data) => {
      if (err) {
        res.writeHead(500);
        res.end('Server Error');
        return;
      }

      res.writeHead(200, {
        'Content-Type': 'application/octet-stream',
        'Cache-Control': 'public, max-age=3600',
        'ETag': etag,
        'Last-Modified': lastModified
      });
      res.end(data);
    });
  });
});

server.listen(3000);
```

#### 3.4 Range 请求

Range 请求支持客户端请求文件的部分内容，常用于视频播放、断点续传等场景。

```javascript
const http = require('http');
const fs = require('fs');
const path = require('path');

const PUBLIC_DIR = path.join(__dirname, 'public');

const server = http.createServer((req, res) => {
  let filePath = path.join(PUBLIC_DIR, req.url === '/' ? 'index.html' : req.url);

  fs.stat(filePath, (err, stats) => {
    if (err) {
      res.writeHead(404);
      res.end('Not Found');
      return;
    }

    const fileSize = stats.size;
    const range = req.headers['range'];

    if (range) {
      // 解析 Range 头：bytes=start-end
      const matches = /bytes=(\d*)-(\d*)/.exec(range);
      let start = 0;
      let end = fileSize - 1;

      if (matches[1]) start = parseInt(matches[1]);
      if (matches[2]) end = parseInt(matches[2]);

      if (matches[1] === '' && matches[2]) {
        // bytes=-500：请求最后 500 字节
        start = fileSize - end;
        end = fileSize - 1;
      }

      if (start >= fileSize || end >= fileSize) {
        res.writeHead(416);
        res.setHeader('Content-Range', `bytes */${fileSize}`);
        res.end();
        return;
      }

      const contentLength = end - start + 1;

      res.writeHead(206, {
        'Content-Type': 'application/octet-stream',
        'Content-Range': `bytes ${start}-${end}/${fileSize}`,
        'Content-Length': contentLength,
        'Accept-Ranges': 'bytes'
      });

      // 使用流返回部分内容
      const stream = fs.createReadStream(filePath, { start, end });
      stream.pipe(res);
    } else {
      // 完整文件响应
      res.writeHead(200, {
        'Content-Type': 'application/octet-stream',
        'Content-Length': fileSize,
        'Accept-Ranges': 'bytes'
      });

      const stream = fs.createReadStream(filePath);
      stream.pipe(res);
    }
  });
});

server.listen(3000);
```

#### 3.5 实现简易静态服务器

综合以上功能，我们来实现一个功能完整的静态文件服务器：

```javascript
const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

const PORT = process.env.PORT || 3000;
const ROOT_DIR = path.resolve(process.argv[2] || __dirname);

const mimeTypes = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.txt': 'text/plain; charset=utf-8',
  '.pdf': 'application/pdf',
  '.zip': 'application/zip',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
  '.ttf': 'font/ttf',
  '.mp3': 'audio/mpeg',
  '.mp4': 'video/mp4'
};

function getFilePath(urlPath) {
  const decodedPath = decodeURIComponent(urlPath);
  let filePath = path.join(ROOT_DIR, decodedPath);

  // 防止路径穿越
  if (!filePath.startsWith(ROOT_DIR)) {
    return null;
  }

  // 默认首页
  if (fs.existsSync(filePath) && fs.statSync(filePath).isDirectory()) {
    filePath = path.join(filePath, 'index.html');
  }

  return filePath;
}

const server = http.createServer((req, res) => {
  const parsedUrl = url.parse(req.url);
  const filePath = getFilePath(parsedUrl.pathname);

  if (!filePath) {
    res.writeHead(403);
    res.end('Forbidden');
    return;
  }

  fs.stat(filePath, (err, stats) => {
    if (err || !stats.isFile()) {
      res.writeHead(404, { 'Content-Type': 'text/plain; charset=utf-8' });
      res.end('404 Not Found');
      return;
    }

    const ext = path.extname(filePath).toLowerCase();
    const contentType = mimeTypes[ext] || 'application/octet-stream';
    const fileSize = stats.size;

    // 协商缓存
    const etag = `"${stats.size}-${stats.mtime.getTime()}"`;
    const lastModified = stats.mtime.toUTCString();

    if (req.headers['if-none-match'] === etag) {
      res.writeHead(304);
      res.end();
      return;
    }

    if (req.headers['if-modified-since'] &&
        new Date(req.headers['if-modified-since']) >= stats.mtime) {
      res.writeHead(304);
      res.end();
      return;
    }

    // Range 请求支持
    const range = req.headers['range'];
    if (range) {
      const matches = /bytes=(\d*)-(\d*)/.exec(range);
      let start = 0;
      let end = fileSize - 1;

      if (matches[1]) {
        start = parseInt(matches[1]);
      }
      if (matches[2]) {
        end = parseInt(matches[2]);
      }
      if (!matches[1] && matches[2]) {
        start = fileSize - parseInt(matches[2]);
      }

      if (start >= fileSize) {
        res.writeHead(416);
        res.setHeader('Content-Range', `bytes */${fileSize}`);
        res.end();
        return;
      }

      end = Math.min(end, fileSize - 1);
      const contentLength = end - start + 1;

      res.writeHead(206, {
        'Content-Type': contentType,
        'Content-Range': `bytes ${start}-${end}/${fileSize}`,
        'Content-Length': contentLength,
        'Accept-Ranges': 'bytes',
        'Cache-Control': 'public, max-age=3600',
        'ETag': etag,
        'Last-Modified': lastModified
      });

      fs.createReadStream(filePath, { start, end }).pipe(res);
    } else {
      res.writeHead(200, {
        'Content-Type': contentType,
        'Content-Length': fileSize,
        'Accept-Ranges': 'bytes',
        'Cache-Control': 'public, max-age=3600',
        'ETag': etag,
        'Last-Modified': lastModified
      });

      fs.createReadStream(filePath).pipe(res);
    }
  });
});

server.listen(PORT, () => {
  console.log(`静态服务器已启动: http://localhost:${PORT}`);
  console.log(`根目录: ${ROOT_DIR}`);
});
```

运行方式：`node static-server.js [目录路径]`

---

### 四、net 模块与 TCP 编程

`net` 模块是 Node.js 中底层的网络编程模块，提供了 TCP 服务器和客户端的实现。它是 `http`、`https` 等模块的基础。

#### 4.1 TCP 协议简介

TCP（Transmission Control Protocol，传输控制协议）是一种面向连接的、可靠的、基于字节流的传输层协议。

**TCP 协议特点：**

- **面向连接**：通信双方需要先建立连接，再进行数据传输
- **可靠性**：通过确认、重传、超时等机制保证数据可靠传输
- **有序性**：保证数据按发送顺序到达
- **流量控制**：防止发送方过快导致接收方溢出
- **拥塞控制**：防止网络过载

#### 4.2 创建 TCP 服务器

使用 `net.createServer()` 创建 TCP 服务器：

```javascript
const net = require('net');

const server = net.createServer((socket) => {
  console.log('客户端已连接:', socket.remoteAddress, socket.remotePort);

  // 接收客户端数据
  socket.on('data', (data) => {
    console.log('收到数据:', data.toString());
    socket.write(`服务器回复: ${data}`);
  });

  // 客户端断开连接
  socket.on('close', () => {
    console.log('客户端已断开连接');
  });

  // 错误处理
  socket.on('error', (err) => {
    console.error('Socket 错误:', err.message);
  });
});

const PORT = 8080;
server.listen(PORT, () => {
  console.log(`TCP 服务器已启动: ${PORT}`);
});
```

#### 4.3 创建 TCP 客户端

使用 `net.createConnection()` 创建 TCP 客户端：

```javascript
const net = require('net');

const client = net.createConnection({ port: 8080, host: 'localhost' }, () => {
  console.log('已连接到服务器');
  client.write('Hello, TCP Server!');
});

// 接收服务器数据
client.on('data', (data) => {
  console.log('收到服务器回复:', data.toString());
  client.end();
});

// 连接关闭
client.on('close', () => {
  console.log('连接已关闭');
});

// 错误处理
client.on('error', (err) => {
  console.error('客户端错误:', err.message);
});
```

#### 4.4 TCP 三次握手

TCP 建立连接需要经过三次握手，这是一个重要的网络概念：

```
客户端                                服务器
  │                                    │
  │──── SYN ─────────────────────────→│
  │   (seq=100)                        │ 接收 SYN
  │                                    │
  │←──── SYN + ACK ──────────────────│
  │        (seq=200, ack=101)          │
  │                                    │
  │──── ACK ─────────────────────────→│
  │   (ack=201)                        │ 连接建立
  │                                    │
  │════════ 数据传输阶段 ══════════════│
```

在 Node.js 中，当调用 `server.listen()` 时，服务器开始监听并准备接受客户端的 SYN 请求；当客户端调用 `net.createConnection()` 时，会自动完成三次握手过程。

#### 4.5 粘包问题

TCP 是面向字节流的协议，没有消息边界的概念。发送方发送的多次数据可能被接收方一次接收，这就是所谓的"粘包"问题。

**粘包产生的原因：**

- 发送方在短时间内连续发送小数据，TCP 会将它们合并发送
- 接收方在一次 `data` 事件中可能收到多个数据包的内容

**粘包解决方案：**

**方案一：固定长度协议**

每个消息固定长度，不足部分填充：

```javascript
const net = require('net');

const MESSAGE_LENGTH = 10;

function encode(msg) {
  const buf = Buffer.alloc(MESSAGE_LENGTH);
  const msgBuf = Buffer.from(msg, 'utf8');
  msgBuf.copy(buf);
  return buf;
}

function decode(buf) {
  return buf.toString('utf8').replace(/\0+$/, '');
}

// 服务器
const server = net.createServer((socket) => {
  let buffer = Buffer.alloc(0);

  socket.on('data', (data) => {
    buffer = Buffer.concat([buffer, data]);

    while (buffer.length >= MESSAGE_LENGTH) {
      const msg = decode(buffer.slice(0, MESSAGE_LENGTH));
      console.log('收到消息:', msg);
      buffer = buffer.slice(MESSAGE_LENGTH);
    }
  });
});

server.listen(8080);

// 客户端
const client = net.createConnection({ port: 8080 }, () => {
  client.write(encode('Hello'));
  client.write(encode('World'));
});
```

**方案二：分隔符协议**

使用特殊字符（如 `\n`）作为消息分隔符：

```javascript
const net = require('net');

// 服务器
const server = net.createServer((socket) => {
  let buffer = '';

  socket.on('data', (data) => {
    buffer += data.toString();

    let index;
    while ((index = buffer.indexOf('\n')) !== -1) {
      const msg = buffer.slice(0, index);
      console.log('收到消息:', msg);
      buffer = buffer.slice(index + 1);
    }
  });
});

server.listen(8080);

// 客户端
const client = net.createConnection({ port: 8080 }, () => {
  client.write('第一条消息\n');
  client.write('第二条消息\n');
});
```

**方案三：长度前缀协议（推荐）**

在消息前添加固定长度的字节表示消息体长度：

```javascript
const net = require('net');

// 编码：4字节长度 + 消息体
function encode(msg) {
  const msgBuf = Buffer.from(msg, 'utf8');
  const header = Buffer.alloc(4);
  header.writeUInt32BE(msgBuf.length, 0);
  return Buffer.concat([header, msgBuf]);
}

// 服务器
const server = net.createServer((socket) => {
  let buffer = Buffer.alloc(0);

  socket.on('data', (data) => {
    buffer = Buffer.concat([buffer, data]);

    while (buffer.length >= 4) {
      const msgLength = buffer.readUInt32BE(0);

      if (buffer.length >= 4 + msgLength) {
        const msg = buffer.slice(4, 4 + msgLength).toString('utf8');
        console.log('收到消息:', msg);
        socket.write(encode(`回复: ${msg}`));
        buffer = buffer.slice(4 + msgLength);
      } else {
        break;
      }
    }
  });
});

server.listen(8080, () => {
  console.log('TCP 服务器已启动: 8080');
});

// 客户端
const client = net.createConnection({ port: 8080 }, () => {
  client.write(encode('Hello, TCP!'));
  client.write(encode('This is a test message'));
});

let clientBuffer = Buffer.alloc(0);
client.on('data', (data) => {
  clientBuffer = Buffer.concat([clientBuffer, data]);

  while (clientBuffer.length >= 4) {
    const msgLength = clientBuffer.readUInt32BE(0);
    if (clientBuffer.length >= 4 + msgLength) {
      const msg = clientBuffer.slice(4, 4 + msgLength).toString('utf8');
      console.log('收到回复:', msg);
      clientBuffer = clientBuffer.slice(4 + msgLength);
    } else {
      break;
    }
  }
});
```

> **方案对比：**
>
> - **固定长度**：实现简单，但浪费带宽，不适合变长消息
> - **分隔符**：实现简单，适合文本协议，但分隔符可能出现在消息内容中
> - **长度前缀**：最常用和可靠的方案，广泛应用于各种协议中

---

### 五、WebSocket 实时通信

HTTP 协议是无状态的请求-响应模式，不支持服务器主动向客户端推送数据。WebSocket 的出现弥补了这一不足，实现了真正的全双工实时通信。

#### 5.1 WebSocket 协议基础

WebSocket 是一种在单个 TCP 连接上进行全双工通信的网络协议。

**WebSocket 连接建立过程：**

```
客户端                                    服务器
  │                                        │
  │──── HTTP Upgrade 请求 ───────────────→│
  │  Connection: Upgrade                    │
  │  Upgrade: websocket                     │
  │  Sec-WebSocket-Key: dGhlIHNhbXBsZ...   │
  │                                        │
  │←──── HTTP 101 Switching Protocols ─────│
  │  Upgrade: websocket                     │
  │  Sec-WebSocket-Accept: s3pPLMBiTxaQ... │
  │                                        │
  │════════ 全双工通信通道建立 ════════════│
```

**WebSocket vs HTTP 对比：**

| 对比项 | HTTP | WebSocket |
|--------|------|-----------|
| 通信模式 | 请求-响应 | 全双工 |
| 连接方式 | 短连接/长连接 | 持久连接 |
| 服务器推送 | 不支持（需轮询/SSE） | 原生支持 |
| 协议开销 | 每次请求都有 Header | 连接建立后开销极小 |
| 适用场景 | 普通 Web 请求 | 实时聊天、在线游戏、数据推送 |

#### 5.2 使用 ws 库

`ws` 是 Node.js 中最流行的 WebSocket 实现库。

**安装：**

```bash
npm install ws
```

#### 5.3 实现 WebSocket 服务器

```javascript
const WebSocket = require('ws');

const wss = new WebSocket.Server({ port: 8080 });

console.log('WebSocket 服务器已启动: ws://localhost:8080');

wss.on('connection', (ws, req) => {
  const clientIp = req.socket.remoteAddress;
  console.log(`新客户端连接: ${clientIp}`);

  // 发送欢迎消息
  ws.send(JSON.stringify({
    type: 'system',
    message: '欢迎连接到 WebSocket 服务器',
    timestamp: Date.now()
  }));

  // 处理客户端消息
  ws.on('message', (message) => {
    console.log(`收到消息: ${message}`);
    ws.send(JSON.stringify({
      type: 'echo',
      message: `服务器收到: ${message}`,
      timestamp: Date.now()
    }));
  });

  // 处理客户端断开
  ws.on('close', () => {
    console.log(`客户端断开: ${clientIp}`);
  });

  // 处理错误
  ws.on('error', (err) => {
    console.error('WebSocket 错误:', err.message);
  });
});

// 定时向所有客户端广播
setInterval(() => {
  const time = new Date().toLocaleTimeString();
  wss.clients.forEach((client) => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify({
        type: 'broadcast',
        message: `当前时间: ${time}`,
        timestamp: Date.now()
      }));
    }
  });
}, 5000);
```

**使用浏览器原生 WebSocket API 连接：**

```javascript
// 浏览器端代码
const ws = new WebSocket('ws://localhost:8080');

ws.onopen = () => {
  console.log('连接已建立');
  ws.send('Hello, WebSocket!');
};

ws.onmessage = (event) => {
  const data = JSON.parse(event.data);
  console.log('收到消息:', data);
};

ws.onclose = () => {
  console.log('连接已关闭');
};

ws.onerror = (err) => {
  console.error('连接错误:', err);
};
```

#### 5.4 实现聊天服务器

下面实现一个功能完善的聊天室服务器，支持广播、私信、用户管理等功能：

```javascript
const WebSocket = require('ws');

const wss = new WebSocket.Server({ port: 8080 });

// 存储在线用户：key -> { ws, nickname, id }
const clients = new Map();
let userIdCounter = 0;

function broadcast(message, excludeWs = null) {
  const data = JSON.stringify(message);
  wss.clients.forEach((client) => {
    if (client.readyState === WebSocket.OPEN && client !== excludeWs) {
      client.send(data);
    }
  });
}

function getOnlineUsers() {
  const users = [];
  clients.forEach((client, id) => {
    users.push({ id, nickname: client.nickname });
  });
  return users;
}

wss.on('connection', (ws) => {
  const userId = ++userIdCounter;
  clients.set(userId, { ws, nickname: `用户${userId}` });

  // 通知新用户
  ws.send(JSON.stringify({
    type: 'system',
    code: 0,
    data: {
      userId,
      nickname: `用户${userId}`,
      message: '连接成功，请设置昵称',
      onlineUsers: getOnlineUsers()
    }
  }));

  // 广播新用户上线
  broadcast({
    type: 'system',
    data: {
      message: `${userId}号用户上线了`,
      onlineUsers: getOnlineUsers()
    }
  }, ws);

  ws.on('message', (rawMessage) => {
    let message;
    try {
      message = JSON.parse(rawMessage);
    } catch {
      ws.send(JSON.stringify({
        type: 'error',
        data: { message: '消息格式错误，请使用 JSON 格式' }
      }));
      return;
    }

    const client = clients.get(userId);
    if (!client) return;

    switch (message.type) {
      case 'setNickname':
        // 设置昵称
        client.nickname = message.nickname || `用户${userId}`;
        broadcast({
          type: 'system',
          data: {
            message: `用户${userId}设置昵称为: ${client.nickname}`,
            onlineUsers: getOnlineUsers()
          }
        });
        break;

      case 'chat':
        // 广播聊天消息
        broadcast({
          type: 'chat',
          data: {
            from: client.nickname,
            content: message.content,
            timestamp: Date.now()
          }
        });
        break;

      case 'private': {
        // 私信
        const targetClient = clients.get(message.targetId);
        if (targetClient && targetClient.ws.readyState === WebSocket.OPEN) {
          targetClient.ws.send(JSON.stringify({
            type: 'private',
            data: {
              from: client.nickname,
              content: message.content,
              timestamp: Date.now()
            }
          }));
          // 通知发送者
          ws.send(JSON.stringify({
            type: 'private',
            data: {
              from: client.nickname,
              content: message.content,
              to: targetClient.nickname,
              timestamp: Date.now()
            }
          }));
        } else {
          ws.send(JSON.stringify({
            type: 'error',
            data: { message: '目标用户不在线' }
          }));
        }
        break;
      }

      case 'online':
        // 查询在线用户
        ws.send(JSON.stringify({
          type: 'online',
          data: { users: getOnlineUsers() }
        }));
        break;

      default:
        ws.send(JSON.stringify({
          type: 'error',
          data: { message: `未知消息类型: ${message.type}` }
        }));
    }
  });

  ws.on('close', () => {
    clients.delete(userId);
    broadcast({
      type: 'system',
      data: {
        message: `${userId}号用户(${getNickname(userId)})下线了`,
        onlineUsers: getOnlineUsers()
      }
    });
  });

  ws.on('error', () => {
    clients.delete(userId);
  });
});

function getNickname(userId) {
  const client = clients.get(userId);
  return client ? client.nickname : '未知';
}

console.log('聊天服务器已启动: ws://localhost:8080');
```

**对应的客户端 HTML 页面：**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>Node.js 聊天室</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Microsoft YaHei', sans-serif; background: #f5f5f5; }
    .container { max-width: 800px; margin: 20px auto; background: #fff; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    .header { background: #4CAF50; color: #fff; padding: 15px; border-radius: 8px 8px 0 0; }
    .header h1 { font-size: 20px; }
    .chat-area { height: 400px; overflow-y: auto; padding: 15px; }
    .message { margin-bottom: 10px; padding: 8px 12px; border-radius: 15px; max-width: 70%; }
    .message.system { background: #e0e0e0; text-align: center; margin: 10px auto; }
    .message.chat { background: #d4edda; }
    .message.private { background: #fff3cd; }
    .message .meta { font-size: 12px; color: #888; }
    .message .content { margin-top: 4px; }
    .input-area { display: flex; padding: 15px; border-top: 1px solid #eee; }
    .input-area input { flex: 1; padding: 10px; border: 1px solid #ddd; border-radius: 4px; }
    .input-area button { margin-left: 10px; padding: 10px 20px; background: #4CAF50; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
    .input-area button:hover { background: #45a049; }
    .user-list { width: 200px; padding: 10px; border-left: 1px solid #eee; }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>Node.js 聊天室</h1>
      <input type="text" id="nickname" placeholder="输入昵称" style="margin-top:10px;padding:5px;border-radius:4px;border:none;">
      <button onclick="setNickname()" style="margin-top:10px;padding:5px 10px;background:#fff;color:#4CAF50;border:none;border-radius:4px;cursor:pointer;">设置</button>
    </div>
    <div class="chat-area" id="chatArea"></div>
    <div class="input-area">
      <input type="text" id="messageInput" placeholder="输入消息..." onkeypress="if(event.key==='Enter')sendMessage()">
      <button onclick="sendMessage()">发送</button>
    </div>
  </div>

  <script>
    const ws = new WebSocket('ws://localhost:8080');
    let myUserId = null;
    let myNickname = '';

    ws.onmessage = (event) => {
      const msg = JSON.parse(event.data);
      const chatArea = document.getElementById('chatArea');

      switch (msg.type) {
        case 'system':
          if (msg.data.userId) {
            myUserId = msg.data.userId;
          }
          chatArea.innerHTML += `<div class="message system">${msg.data.message}</div>`;
          break;
        case 'chat':
          chatArea.innerHTML += `<div class="message chat">
            <div class="meta">${msg.data.from} - ${new Date(msg.data.timestamp).toLocaleTimeString()}</div>
            <div class="content">${msg.data.content}</div>
          </div>`;
          break;
        case 'private':
          chatArea.innerHTML += `<div class="message private">
            <div class="meta">[私信] ${msg.data.from} - ${new Date(msg.data.timestamp).toLocaleTimeString()}</div>
            <div class="content">${msg.data.content}</div>
          </div>`;
          break;
        case 'error':
          alert(msg.data.message);
          break;
      }

      chatArea.scrollTop = chatArea.scrollHeight;
    };

    function setNickname() {
      const nickname = document.getElementById('nickname').value;
      if (!nickname) return;
      myNickname = nickname;
      ws.send(JSON.stringify({ type: 'setNickname', nickname }));
    }

    function sendMessage() {
      const input = document.getElementById('messageInput');
      const content = input.value.trim();
      if (!content) return;
      ws.send(JSON.stringify({ type: 'chat', content }));
      input.value = '';
    }
  </script>
</body>
</html>
```

#### 5.5 广播与私信

上面的聊天室已经实现了广播与私信功能，这里做一个总结：

**广播（Broadcast）：** 向所有连接的客户端发送消息。

```javascript
// 向所有客户端广播
function broadcast(message) {
  const data = JSON.stringify(message);
  wss.clients.forEach((client) => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(data);
    }
  });
}
```

**私信（Private Message）：** 只向指定的客户端发送消息。

```javascript
// 向指定用户发送私信
function sendPrivateMessage(targetUserId, message) {
  const targetClient = clients.get(targetUserId);
  if (targetClient && targetClient.ws.readyState === WebSocket.OPEN) {
    targetClient.ws.send(JSON.stringify(message));
  }
}
```

**心跳检测：** 为了及时发现断开的客户端，需要实现心跳机制：

```javascript
const HEARTBEAT_INTERVAL = 30000; // 30 秒

wss.on('connection', (ws) => {
  ws.isAlive = true;

  ws.on('pong', () => {
    ws.isAlive = true;
  });
});

// 定时心跳检测
const interval = setInterval(() => {
  wss.clients.forEach((ws) => {
    if (ws.isAlive === false) {
      console.log('心跳检测失败，关闭连接');
      return ws.terminate();
    }

    ws.isAlive = false;
    ws.ping();
  });
}, HEARTBEAT_INTERVAL);

wss.on('close', () => {
  clearInterval(interval);
});
```

---

### 六、实战练习

#### 实战一：实现简易静态文件服务器

**需求：** 实现一个支持 MIME 类型、缓存控制、目录列表的静态文件服务器。

**实现代码：**

```javascript
const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = process.env.PORT || 3000;
const ROOT_DIR = path.resolve(process.argv[2] || __dirname);

const mimeTypes = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.txt': 'text/plain; charset=utf-8'
};

function listDirectory(dirPath) {
  return new Promise((resolve, reject) => {
    fs.readdir(dirPath, (err, files) => {
      if (err) return reject(err);

      const fileList = [];
      files.forEach((file) => {
        const filePath = path.join(dirPath, file);
        try {
          const stats = fs.statSync(filePath);
          fileList.push({
            name: file,
            isDirectory: stats.isDirectory(),
            size: stats.isDirectory() ? '' : stats.size,
            url: '/' + path.relative(ROOT_DIR, filePath).replace(/\\/g, '/')
          });
        } catch {}
      });
      resolve(fileList);
    });
  });
}

function generateDirectoryPage(dirPath, fileList) {
  const relativePath = '/' + path.relative(ROOT_DIR, dirPath).replace(/\\/g, '/');

  let html = `<!DOCTYPE html><html><head><meta charset="UTF-8">`;
  html += `<title>目录列表 - ${relativePath}</title>`;
  html += `<style>`;
  html += `body{font-family:sans-serif;margin:40px auto;max-width:800px;}`;
  html += `h1{color:#333;}ul{list-style:none;padding:0;}`;
  html += `li{padding:10px;border-bottom:1px solid #eee;display:flex;justify-content:space-between;}`;
  html += `a{color:#4CAF50;text-decoration:none;}`;
  html += `a:hover{text-decoration:underline;}`;
  html += `.size{color:#999;font-size:0.9em;}`;
  html += `</style></head><body>`;
  html += `<h1>📁 ${relativePath || '/'}</h1>`;
  html += `<ul>`;
  html += `<li><a href="${path.dirname(relativePath) || '/'}">⬅ 返回上级目录</a><span class="size"></span></li>`;

  fileList.forEach((file) => {
    const icon = file.isDirectory ? '📁' : '📄';
    const sizeStr = file.size ? `${(file.size / 1024).toFixed(2)} KB` : '';
    html += `<li><a href="${file.url}">${icon} ${file.name}</a><span class="size">${sizeStr}</span></li>`;
  });

  html += `</ul></body></html>`;
  return html;
}

const server = http.createServer(async (req, res) => {
  const urlPath = decodeURIComponent(req.url.split('?')[0]);
  let filePath = path.join(ROOT_DIR, urlPath);

  if (!filePath.startsWith(ROOT_DIR)) {
    res.writeHead(403, { 'Content-Type': 'text/plain; charset=utf-8' });
    res.end('403 Forbidden');
    return;
  }

  fs.stat(filePath, async (err, stats) => {
    if (err) {
      res.writeHead(404, { 'Content-Type': 'text/plain; charset=utf-8' });
      res.end('404 Not Found');
      return;
    }

    if (stats.isDirectory()) {
      // 目录：显示文件列表或默认首页
      const indexPath = path.join(filePath, 'index.html');
      try {
        fs.accessSync(indexPath);
        const html = fs.readFileSync(indexPath);
        res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
        res.end(html);
      } catch {
        // 没有 index.html，显示目录列表
        try {
          const fileList = await listDirectory(filePath);
          const html = generateDirectoryPage(filePath, fileList);
          res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
          res.end(html);
        } catch {
          res.writeHead(500);
          res.end('500 Internal Server Error');
        }
      }
    } else {
      // 文件：直接返回
      const ext = path.extname(filePath).toLowerCase();
      const contentType = mimeTypes[ext] || 'application/octet-stream';

      // 协商缓存
      const etag = `"${stats.size}-${stats.mtime.getTime()}"`;
      if (req.headers['if-none-match'] === etag) {
        res.writeHead(304);
        res.end();
        return;
      }

      res.writeHead(200, {
        'Content-Type': contentType,
        'Content-Length': stats.size,
        'Cache-Control': 'public, max-age=3600',
        'ETag': etag
      });

      fs.createReadStream(filePath).pipe(res);
    }
  });
});

server.listen(PORT, () => {
  console.log(`静态文件服务器已启动: http://localhost:${PORT}`);
  console.log(`根目录: ${ROOT_DIR}`);
});
```

**运行方式：**

```bash
# 启动默认目录
node static-server.js

# 指定目录
node static-server.js /path/to/your/directory

# 指定端口
PORT=8080 node static-server.js
```

**功能特性：**

- ✅ 支持 MIME 类型识别
- ✅ 支持协商缓存（ETag）
- ✅ 支持强缓存（Cache-Control）
- ✅ 支持目录列表
- ✅ 支持默认首页（index.html）
- ✅ 防止路径穿越攻击
- ✅ 使用流处理大文件

#### 实战二：实现一个聊天室

**需求：** 实现一个支持多房间、昵称、在线人数统计的 WebSocket 聊天室。

**服务端实现：**

```javascript
const WebSocket = require('ws');

const wss = new WebSocket.Server({ port: 8080 });

const rooms = new Map();
const clients = new Map();
let clientIdCounter = 0;

function getOrCreateRoom(roomId) {
  if (!rooms.has(roomId)) {
    rooms.set(roomId, new Set());
  }
  return rooms.get(roomId);
}

function broadcastToRoom(roomId, message, excludeWs = null) {
  const room = rooms.get(roomId);
  if (!room) return;
  const data = JSON.stringify(message);
  room.forEach((client) => {
    if (client !== excludeWs && client.readyState === WebSocket.OPEN) {
      client.send(data);
    }
  });
}

function getRoomUsers(roomId) {
  const room = rooms.get(roomId);
  if (!room) return [];
  const users = [];
  room.forEach((ws) => {
    const client = clients.get(ws.clientId);
    if (client) {
      users.push({ id: client.id, nickname: client.nickname });
    }
  });
  return users;
}

wss.on('connection', (ws) => {
  const clientId = ++clientIdCounter;
  ws.clientId = clientId;
  clients.set(clientId, { ws, nickname: `用户${clientId}`, roomId: null });

  ws.send(JSON.stringify({
    type: 'system',
    data: { message: '连接成功', userId: clientId }
  }));

  ws.on('message', (rawMessage) => {
    let message;
    try {
      message = JSON.parse(rawMessage);
    } catch {
      ws.send(JSON.stringify({ type: 'error', data: { message: '消息格式错误' } }));
      return;
    }

    const client = clients.get(clientId);
    if (!client) return;

    switch (message.type) {
      case 'setNickname':
        client.nickname = message.nickname || client.nickname;
        ws.send(JSON.stringify({
          type: 'system',
          data: { message: `昵称已更新为: ${client.nickname}` }
        }));
        break;

      case 'joinRoom': {
        const roomId = message.roomId;
        if (client.roomId) {
          const oldRoom = rooms.get(client.roomId);
          if (oldRoom) oldRoom.delete(ws);
        }
        client.roomId = roomId;
        getOrCreateRoom(roomId).add(ws);
        broadcastToRoom(roomId, {
          type: 'system',
          data: {
            message: `${client.nickname} 加入了房间`,
            users: getRoomUsers(roomId)
          }
        });
        break;
      }

      case 'leaveRoom': {
        if (client.roomId) {
          const room = rooms.get(client.roomId);
          if (room) room.delete(ws);
          broadcastToRoom(client.roomId, {
            type: 'system',
            data: {
              message: `${client.nickname} 离开了房间`,
              users: getRoomUsers(client.roomId)
            }
          });
          client.roomId = null;
        }
        break;
      }

      case 'chat':
        if (client.roomId) {
          broadcastToRoom(client.roomId, {
            type: 'chat',
            data: {
              from: client.nickname,
              content: message.content,
              timestamp: Date.now()
            }
          });
        } else {
          ws.send(JSON.stringify({
            type: 'error',
            data: { message: '请先加入一个房间' }
          }));
        }
        break;

      case 'online':
        ws.send(JSON.stringify({
          type: 'online',
          data: { users: client.roomId ? getRoomUsers(client.roomId) : [] }
        }));
        break;

      default:
        ws.send(JSON.stringify({
          type: 'error',
          data: { message: `未知消息类型: ${message.type}` }
        }));
    }
  });

  ws.on('close', () => {
    const client = clients.get(clientId);
    if (client && client.roomId) {
      const room = rooms.get(client.roomId);
      if (room) room.delete(ws);
      broadcastToRoom(client.roomId, {
        type: 'system',
        data: {
          message: `${client.nickname} 离开了房间`,
          users: getRoomUsers(client.roomId)
        }
      });
    }
    clients.delete(clientId);
  });
});

console.log('多房间聊天室已启动: ws://localhost:8080');
```

**客户端 HTML 页面：**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>Node.js 多房间聊天室</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Microsoft YaHei', sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; padding: 20px; }
    .container { max-width: 900px; margin: 0 auto; background: #fff; border-radius: 12px; box-shadow: 0 10px 40px rgba(0,0,0,0.2); overflow: hidden; }
    .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: #fff; padding: 20px 30px; }
    .header h1 { font-size: 22px; margin-bottom: 15px; }
    .header .controls { display: flex; gap: 10px; flex-wrap: wrap; }
    .header input, .header select { padding: 8px 12px; border: none; border-radius: 6px; font-size: 14px; }
    .header button { padding: 8px 16px; background: rgba(255,255,255,0.2); color: #fff; border: 1px solid rgba(255,255,255,0.4); border-radius: 6px; cursor: pointer; font-size: 14px; transition: all 0.3s; }
    .header button:hover { background: rgba(255,255,255,0.3); }
    .main { display: flex; height: 500px; }
    .chat-area { flex: 1; padding: 20px; overflow-y: auto; background: #f9f9fb; }
    .sidebar { width: 200px; background: #f0f0f5; padding: 15px; border-left: 1px solid #e0e0e0; }
    .sidebar h3 { font-size: 14px; color: #666; margin-bottom: 10px; padding-bottom: 8px; border-bottom: 2px solid #667eea; }
    .sidebar ul { list-style: none; }
    .sidebar li { padding: 6px 10px; margin: 4px 0; background: #fff; border-radius: 4px; font-size: 13px; }
    .message { margin-bottom: 12px; padding: 10px 14px; border-radius: 12px; max-width: 80%; word-wrap: break-word; }
    .message.system { background: #e8e8ef; text-align: center; margin: 12px auto; max-width: 90%; font-size: 13px; color: #666; }
    .message.chat { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: #fff; margin-left: auto; }
    .message.chat.other { background: #fff; color: #333; border: 1px solid #e0e0e0; margin-right: auto; }
    .message .meta { font-size: 11px; opacity: 0.8; margin-bottom: 4px; }
    .input-area { display: flex; padding: 15px 20px; background: #fff; border-top: 1px solid #eee; }
    .input-area input { flex: 1; padding: 12px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 14px; outline: none; transition: border-color 0.3s; }
    .input-area input:focus { border-color: #667eea; }
    .input-area button { margin-left: 10px; padding: 12px 24px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: #fff; border: none; border-radius: 8px; cursor: pointer; font-size: 14px; font-weight: bold; }
    .input-area button:hover { transform: translateY(-1px); box-shadow: 0 4px 12px rgba(102,126,234,0.4); }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>💬 Node.js 多房间聊天室</h1>
      <div class="controls">
        <input type="text" id="nickname" placeholder="输入昵称" style="width:120px;">
        <select id="roomSelect">
          <option value="room1">房间 1</option>
          <option value="room2">房间 2</option>
          <option value="room3">房间 3</option>
        </select>
        <button onclick="joinRoom()">加入房间</button>
        <button onclick="leaveRoom()">离开房间</button>
      </div>
    </div>
    <div class="main">
      <div class="chat-area" id="chatArea"></div>
      <div class="sidebar">
        <h3>在线用户</h3>
        <ul id="userList"><li style="color:#999">暂无数据</li></ul>
      </div>
    </div>
    <div class="input-area">
      <input type="text" id="messageInput" placeholder="输入消息，按 Enter 发送..." onkeypress="if(event.key==='Enter')sendMessage()">
      <button onclick="sendMessage()">发送</button>
    </div>
  </div>

  <script>
    const ws = new WebSocket('ws://localhost:8080');
    let myUserId = null;
    let myNickname = '';

    ws.onmessage = (event) => {
      const msg = JSON.parse(event.data);
      const chatArea = document.getElementById('chatArea');

      switch (msg.type) {
        case 'system':
          if (msg.data.userId) myUserId = msg.data.userId;
          chatArea.innerHTML += `<div class="message system">${msg.data.message}</div>`;
          break;
        case 'chat':
          const isMine = msg.data.from === myNickname;
          chatArea.innerHTML += `<div class="message chat ${isMine ? '' : 'other'}">
            <div class="meta">${msg.data.from} · ${new Date(msg.data.timestamp).toLocaleTimeString()}</div>
            <div>${msg.data.content}</div>
          </div>`;
          break;
        case 'online':
          const userList = document.getElementById('userList');
          if (msg.data.users && msg.data.users.length > 0) {
            userList.innerHTML = msg.data.users.map(u => `<li>👤 ${u.nickname}</li>`).join('');
          } else {
            userList.innerHTML = '<li style="color:#999">暂无用户</li>';
          }
          break;
        case 'error':
          alert(msg.data.message);
          break;
      }
      chatArea.scrollTop = chatArea.scrollHeight;
    };

    function joinRoom() {
      const nickname = document.getElementById('nickname').value.trim();
      if (nickname) {
        myNickname = nickname;
        ws.send(JSON.stringify({ type: 'setNickname', nickname }));
      }
      const roomId = document.getElementById('roomSelect').value;
      ws.send(JSON.stringify({ type: 'joinRoom', roomId }));
    }

    function leaveRoom() {
      ws.send(JSON.stringify({ type: 'leaveRoom' }));
    }

    function sendMessage() {
      const input = document.getElementById('messageInput');
      const content = input.value.trim();
      if (!content) return;
      ws.send(JSON.stringify({ type: 'chat', content }));
      input.value = '';
    }
  </script>
</body>
</html>
```

**运行方式：**

```bash
# 安装依赖
npm install ws

# 启动服务端
node chat-room-server.js

# 用浏览器打开客户端页面
# 访问 http://localhost:8080 查看 WebSocket 连接
# 或直接打开 chat-client.html 文件
```

**功能特性：**

- ✅ 多房间支持，用户可加入/离开任意房间
- ✅ 昵称设置与在线用户列表
- ✅ 实时消息广播
- ✅ 房间隔离（不同房间消息互不影响）
- ✅ 用户加入/离开房间提示

### 本章小结

本章详细介绍了 Node.js 网络编程与 Web 服务的核心知识：

1. **HTTP 协议基础**：理解了请求/响应模型、状态码、请求方法、Header 和 Cookie/Session 的概念
2. **http 模块**：学习了如何创建 HTTP 服务器、处理请求响应、实现路由分发、获取请求参数、返回 HTML/JSON、处理 CORS 跨域
3. **静态文件服务**：掌握了读取静态文件、MIME 类型映射、缓存控制（强缓存与协商缓存）、Range 请求的实现
4. **net 模块与 TCP 编程**：了解了 TCP 协议、创建 TCP 服务器/客户端、三次握手流程、粘包问题及解决方案
5. **WebSocket 实时通信**：学习了 WebSocket 协议、使用 `ws` 库、实现广播与私信、心跳检测机制
6. **实战练习**：通过实现简易静态文件服务器和多房间聊天室，综合运用了本章所学知识

通过本章的学习，你已经具备了使用 Node.js 构建 Web 服务和实时通信应用的能力。在实际项目中，可以进一步学习 Express、Koa 等框架来简化开发流程。
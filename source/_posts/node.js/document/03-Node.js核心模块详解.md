---
title: 03-Node.js核心模块详解
date: 2024-09-23T00:00:00+08:00
tags:
  - nodejs
  - 教程
  - 核心模块
categories:
  - node.js
cover: /images/cover13.png
sticky: false
description: Node.js 核心模块详解，涵盖文件系统、路径、操作系统、URL、事件、流等常用模块的使用方法与实战练习。
---

## Node.js 核心模块详解

Node.js 提供了丰富的内置核心模块，这些模块是开发 Node.js 应用的基础。本章将详细介绍最常用的核心模块，包括文件系统、路径处理、操作系统、URL 处理、事件驱动和流操作等。

### 一、文件系统模块 fs

`fs` 模块是 Node.js 中最重要的核心模块之一，用于与操作系统的文件系统进行交互。它提供了同步和异步两种 API 风格。

#### 1.1 读取文件 readFile / readFileSync

`readFile` 是异步读取文件，`readFileSync` 是同步读取文件。

```javascript
const fs = require('fs');
const path = require('path');

// 异步读取文件
fs.readFile(path.join(__dirname, 'test.txt'), 'utf8', (err, data) => {
  if (err) {
    console.error('读取文件失败:', err);
    return;
  }
  console.log('异步读取结果:', data);
});

// 同步读取文件（会阻塞主线程）
try {
  const data = fs.readFileSync(path.join(__dirname, 'test.txt'), 'utf8');
  console.log('同步读取结果:', data);
} catch (err) {
  console.error('读取文件失败:', err);
}
```

> **注意：** 在实际开发中，建议优先使用异步 API，避免阻塞主线程。只有在确定不会造成性能问题的场景下才使用同步 API。

#### 1.2 写入文件 writeFile / writeFileSync

```javascript
const fs = require('fs');
const path = require('path');

const content = '这是一段写入文件的内容';

// 异步写入文件
fs.writeFile(path.join(__dirname, 'output.txt'), content, 'utf8', (err) => {
  if (err) {
    console.error('写入文件失败:', err);
    return;
  }
  console.log('异步写入成功');
});

// 同步写入文件
try {
  fs.writeFileSync(path.join(__dirname, 'output-sync.txt'), content, 'utf8');
  console.log('同步写入成功');
} catch (err) {
  console.error('写入文件失败:', err);
}
```

`writeFile` 会覆盖文件内容。如果需要在文件末尾追加内容，可以使用 `appendFile` 或 `appendFileSync`：

```javascript
fs.appendFile(path.join(__dirname, 'output.txt'), '\n追加的内容', 'utf8', (err) => {
  if (err) throw err;
  console.log('追加写入成功');
});
```

#### 1.3 创建和删除目录 mkdir / rmdir

```javascript
const fs = require('fs');
const path = require('path');

// 创建单层目录
fs.mkdir(path.join(__dirname, 'new-dir'), (err) => {
  if (err) throw err;
  console.log('目录创建成功');
});

// 递归创建多级目录（Node.js 10.12+）
fs.mkdir(path.join(__dirname, 'a', 'b', 'c'), { recursive: true }, (err) => {
  if (err) throw err;
  console.log('多级目录创建成功');
});

// 删除目录（只能删除空目录）
fs.rmdir(path.join(__dirname, 'new-dir'), (err) => {
  if (err) throw err;
  console.log('目录删除成功');
});

// 递归删除目录（Node.js 14.14+）
fs.rm(path.join(__dirname, 'a'), { recursive: true }, (err) => {
  if (err) throw err;
  console.log('多级目录删除成功');
});
```

#### 1.4 读取目录 readdir

```javascript
const fs = require('fs');
const path = require('path');

// 读取目录下的所有文件和子目录
fs.readdir(__dirname, (err, files) => {
  if (err) throw err;
  console.log('目录内容:', files);
});

// 使用 withFileTypes 选项获取更详细的信息
fs.readdir(__dirname, { withFileTypes: true }, (err, dirents) => {
  if (err) throw err;
  dirents.forEach(dirent => {
    if (dirent.isFile()) {
      console.log(`文件: ${dirent.name}`);
    } else if (dirent.isDirectory()) {
      console.log(`目录: ${dirent.name}/`);
    }
  });
});
```

#### 1.5 流式文件操作 createReadStream / createWriteStream

当处理大文件时，`readFile` 和 `writeFile` 会将整个文件加载到内存中，可能导致内存溢出。此时应使用流（Stream）来处理。

```javascript
const fs = require('fs');
const path = require('path');

// 创建读取流
const readStream = fs.createReadStream(path.join(__dirname, 'large-file.txt'), {
  encoding: 'utf8',
  highWaterMark: 64 * 1024 // 每次读取 64KB
});

// 创建写入流
const writeStream = fs.createWriteStream(path.join(__dirname, 'copy-file.txt'));

// 通过 pipe 实现文件复制
readStream.pipe(writeStream);

readStream.on('data', (chunk) => {
  console.log(`读取了 ${chunk.length} 字节的数据`);
});

readStream.on('end', () => {
  console.log('文件读取完成');
});

readStream.on('error', (err) => {
  console.error('读取错误:', err);
});

writeStream.on('finish', () => {
  console.log('文件写入完成');
});
```

#### 1.6 文件监听 watch / watchFile

`watch` 用于监听文件或目录的变化，当文件发生改变时触发回调。

```javascript
const fs = require('fs');
const path = require('path');

// 监听文件变化
fs.watch(path.join(__dirname, 'test.txt'), (eventType, filename) => {
  console.log(`事件类型: ${eventType}`);
  console.log('变化的文件:', filename);
  // eventType: 'rename' | 'change'
});

// 监听整个目录
fs.watch(__dirname, { recursive: true }, (eventType, filename) => {
  if (filename) {
    console.log(`目录变化 - 事件: ${eventType}, 文件: ${filename}`);
  }
});

// 使用 watchFile（基于轮询实现，性能较差）
fs.watchFile(path.join(__dirname, 'test.txt'), { interval: 1000 }, (curr, prev) => {
  console.log(`文件修改时间: ${new Date(curr.mtime)}`);
  console.log(`之前的修改时间: ${new Date(prev.mtime)}`);
});

// 停止监听
fs.unwatchFile(path.join(__dirname, 'test.txt'));
```

> **提示：** `fs.watch` 在不同操作系统上的行为可能不一致。生产环境建议使用 `chokidar` 等第三方库，它对跨平台兼容性做了更好的封装。

---

### 二、路径模块 path

`path` 模块提供了处理文件路径的工具函数，不同操作系统的路径分隔符不同（Windows 用 `\`，Linux/Mac 用 `/`），`path` 模块可以帮我们正确处理路径。

#### 2.1 path.join() - 拼接路径

`path.join()` 会将多个路径片段拼接成一个完整的路径，并自动处理路径分隔符。

```javascript
const path = require('path');

// 基本拼接
console.log(path.join('/usr', 'local', 'bin'));
// 输出: /usr/local/bin (Linux) 或 \usr\local\bin (Windows)

// 自动处理 ../ 和 ./
console.log(path.join('/usr/local', '../bin', 'tool'));
// 输出: /usr/bin/tool

// 处理空字符串
console.log(path.join('', '/usr', 'local'));
// 输出: /usr/local
```

#### 2.2 path.resolve() - 解析绝对路径

`path.resolve()` 会将路径解析为绝对路径，它会从右向左依次处理路径片段，直到构造出一个绝对路径。

```javascript
const path = require('path');

// 基于当前工作目录解析
console.log(path.resolve('test.txt'));
// 输出: /Users/user/project/test.txt

// 多个参数的解析规则：从右向左，直到遇到绝对路径
console.log(path.resolve('/foo', 'bar', 'baz'));
// 输出: /foo/bar/baz

console.log(path.resolve('/foo', '/bar', 'baz'));
// 输出: /bar/baz（遇到 /bar 是绝对路径，前面的被忽略）

// 结合 __dirname 使用
console.log(path.resolve(__dirname, 'public', 'index.html'));
// 输出: 当前脚本目录下的 public/index.html 绝对路径
```

#### 2.3 path.basename() - 获取文件名

`basename()` 返回路径的最后一部分，即文件名。

```javascript
const path = require('path');

console.log(path.basename('/home/user/file.txt'));
// 输出: file.txt

console.log(path.basename('/home/user/file.txt', '.txt'));
// 输出: file（去掉指定的扩展名）

console.log(path.basename('/home/user/'));
// 输出: user（末尾的斜杠会被忽略）
```

#### 2.4 path.dirname() - 获取目录名

`dirname()` 返回路径的目录部分。

```javascript
const path = require('path');

console.log(path.dirname('/home/user/file.txt'));
// 输出: /home/user

console.log(path.dirname('/home/user'));
// 输出: /home

console.log(path.dirname('/'));
// 输出: /
```

#### 2.5 path.extname() - 获取文件扩展名

`extname()` 返回文件的扩展名（包含点号），如果没有扩展名则返回空字符串。

```javascript
const path = require('path');

console.log(path.extname('file.txt'));
// 输出: .txt

console.log(path.extname('file.tar.gz'));
// 输出: .gz（只返回最后一个扩展名）

console.log(path.extname('file'));
// 输出: （空字符串）
```

#### 2.6 path.parse() / path.format() - 路径对象与字符串互转

`parse()` 将路径字符串解析为对象，`format()` 将路径对象转换为字符串。

```javascript
const path = require('path');

// parse: 路径字符串 -> 对象
const pathObj = path.parse('/home/user/dir/file.txt');
console.log(pathObj);
// 输出:
// {
//   root: '/',
//   dir: '/home/user/dir',
//   base: 'file.txt',
//   ext: '.txt',
//   name: 'file'
// }

// format: 对象 -> 路径字符串
const newPath = path.format({
  root: '/',
  dir: '/home/user/dir',
  base: 'file.txt',
  ext: '.txt',
  name: 'file'
});
console.log(newPath);
// 输出: /home/user/dir/file.txt
```

#### 2.7 __dirname 和 __filename

`__dirname` 表示当前模块文件所在目录的绝对路径，`__filename` 表示当前模块文件的绝对路径。

```javascript
// 当前脚本路径: /Users/user/project/app.js

console.log(__dirname);
// 输出: /Users/user/project

console.log(__filename);
// 输出: /Users/user/project/app.js

// 实际应用：构建相对于当前文件的路径
const configPath = path.join(__dirname, 'config', 'config.json');
console.log(configPath);
// 输出: /Users/user/project/config/config.json
```

> **注意：** `__dirname` 和 `__filename` 不是全局变量，它们只在模块内有效。如果想获取当前执行文件的路径，可以使用 `process.argv[1]` 或 `require.main.filename`。

---

### 三、操作系统模块 os

`os` 模块提供与操作系统相关的信息，包括 CPU、内存、网络接口、系统目录等。

```javascript
const os = require('os');
```

#### 3.1 os.platform() - 操作系统平台

```javascript
console.log(os.platform());
// 可能的值: 'darwin' (Mac), 'win32' (Windows), 'linux' (Linux)
```

#### 3.2 os.cpus() - CPU 信息

返回一个对象数组，每个对象包含一个 CPU 核心的信息。

```javascript
const cpus = os.cpus();

console.log(`CPU 核心数: ${cpus.length}`);
console.log(`CPU 型号: ${cpus[0].model}`);
console.log(`CPU 速度: ${cpus[0].speed} MHz`);

// 计算 CPU 使用率
cpus.forEach((cpu, index) => {
  const times = cpu.times;
  const total = times.user + times.nice + times.sys + times.idle + times.irq;
  const usage = ((times.user + times.sys) / total * 100).toFixed(2);
  console.log(`CPU 核心 ${index} 使用率: ${usage}%`);
});
```

#### 3.3 os.totalmem() / os.freemem() - 内存信息

```javascript
console.log(`总内存: ${(os.totalmem() / 1024 / 1024 / 1024).toFixed(2)} GB`);
console.log(`空闲内存: ${(os.freemem() / 1024 / 1024 / 1024).toFixed(2)} GB`);
console.log(`已用内存: ${((os.totalmem() - os.freemem()) / 1024 / 1024 / 1024).toFixed(2)} GB`);
console.log(`内存使用率: ${((os.totalmem() - os.freemem()) / os.totalmem() * 100).toFixed(2)}%`);
```

#### 3.4 os.hostname() - 主机名

```javascript
console.log(`主机名: ${os.hostname()}`);
```

#### 3.5 os.tmpdir() - 临时目录

返回操作系统的默认临时文件目录。

```javascript
console.log(`临时目录: ${os.tmpdir()}`);
// Windows: C:\Users\用户名\AppData\Local\Temp
// Linux/Mac: /tmp
```

实际应用中常用于存储临时文件：

```javascript
const fs = require('fs');
const tempFile = path.join(os.tmpdir(), `temp-${Date.now()}.txt`);
fs.writeFileSync(tempFile, '临时数据');
console.log(`临时文件已创建: ${tempFile}`);
```

#### 3.6 os.networkInterfaces() - 网络接口

返回网络接口信息的对象，包括 IP 地址、MAC 地址等。

```javascript
const interfaces = os.networkInterfaces();

Object.keys(interfaces).forEach(name => {
  console.log(`\n接口: ${name}`);
  interfaces[name].forEach(iface => {
    console.log(`  - 类型: ${iface.family}`);   // IPv4 或 IPv6
    console.log(`    地址: ${iface.address}`);
    console.log(`    子网掩码: ${iface.netmask}`);
    console.log(`    MAC: ${iface.mac}`);
    console.log(`    内部: ${iface.internal}`);
  });
});

// 获取本机 IPv4 地址
function getLocalIP() {
  const interfaces = os.networkInterfaces();
  for (const name of Object.keys(interfaces)) {
    for (const iface of interfaces[name]) {
      if (iface.family === 'IPv4' && !iface.internal) {
        return iface.address;
      }
    }
  }
  return '127.0.0.1';
}

console.log(`本机 IP: ${getLocalIP()}`);
```

---

### 四、URL 模块 url

`url` 模块用于解析和处理 URL 字符串。

#### 4.1 URL 类（WHATWG 标准）

Node.js 推荐使用 WHATWG 标准的 `URL` 类，它与浏览器的 `URL` API 保持一致。

```javascript
const { URL } = require('url');

const url = new URL('https://user:pass@example.com:8080/path/to/page?query=value#section');

console.log('href:', url.href);
console.log('protocol:', url.protocol);      // https:
console.log('hostname:', url.hostname);      // example.com
console.log('port:', url.port);              // 8080
console.log('pathname:', url.pathname);      // /path/to/page
console.log('search:', url.search);          // ?query=value
console.log('hash:', url.hash);              // #section
console.log('origin:', url.origin);          // https://example.com:8080
console.log('username:', url.username);      // user
console.log('password:', url.password);      // pass

// searchParams 操作查询参数
console.log('query value:', url.searchParams.get('query'));  // value
url.searchParams.set('query', 'newvalue');
url.searchParams.append('foo', 'bar');
console.log('更新后的 URL:', url.href);
```

#### 4.2 url.parse()（旧版 API）

`url.parse()` 是旧版 API，用于将 URL 字符串解析为对象。新代码建议使用 `URL` 类。

```javascript
const url = require('url');

const parsed = url.parse('https://example.com:8080/path?query=1&name=test#section', true);

console.log(parsed);
// 输出:
// {
//   protocol: 'https:',
//   slashes: true,
//   auth: null,
//   host: 'example.com:8080',
//   port: '8080',
//   hostname: 'example.com',
//   hash: '#section',
//   search: '?query=1&name=test',
//   query: { query: '1', name: 'test' },  // 当第二个参数为 true 时
//   pathname: '/path',
//   path: '/path?query=1&name=test',
//   href: 'https://example.com:8080/path?query=1&name=test#section'
// }
```

#### 4.3 url.format() - 构造 URL

将 URL 对象格式化为 URL 字符串。

```javascript
const url = require('url');

// 使用 url.format
const urlString = url.format({
  protocol: 'https',
  hostname: 'example.com',
  port: 443,
  pathname: '/api/users',
  query: { page: '1', limit: '10' },
  hash: 'list'
});
console.log(urlString);
// 输出: https://example.com:443/api/users?page=1&limit=10#list

// 使用 URL 类构造
const newUrl = new URL('https://example.com');
newUrl.pathname = '/api/users';
newUrl.searchParams.set('page', '1');
newUrl.searchParams.set('limit', '10');
console.log(newUrl.toString());
// 输出: https://example.com/api/users?page=1&limit=10
```

#### 4.4 url.resolve() - URL 拼接

用于将相对 URL 拼接成绝对 URL，类似于浏览器中 `<a>` 标签的解析行为。

```javascript
const url = require('url');

console.log(url.resolve('https://example.com/', 'api/users'));
// 输出: https://example.com/api/users

console.log(url.resolve('https://example.com/api/', 'users'));
// 输出: https://example.com/api/users

console.log(url.resolve('https://example.com/api/users', 'list'));
// 输出: https://example.com/api/list

console.log(url.resolve('https://example.com/api/users', '/list'));
// 输出: https://example.com/list

console.log(url.resolve('https://example.com/api/users', '../login'));
// 输出: https://example.com/api/login
```

#### 4.5 querystring 处理

`querystring` 模块用于解析和格式化 URL 查询字符串。

```javascript
const querystring = require('querystring');

// 解析查询字符串
const query = querystring.parse('name=Tom&age=25&hobby=code&hobby=music');
console.log(query);
// 输出: { name: 'Tom', age: '25', hobby: ['code', 'music'] }

// 序列化对象为查询字符串
const str = querystring.stringify({ name: 'Tom', age: '25', city: 'Beijing' });
console.log(str);
// 输出: name=Tom&age=25&city=Beijing

// 自定义分隔符
const str2 = querystring.stringify({ foo: 'bar', baz: 'qux' }, ';', '=');
console.log(str2);
// 输出: foo=bar;baz=qux

// URL 编码/解码
console.log(querystring.escape('hello world 你好'));
// 输出: hello%20world%20%E4%BD%A0%E5%A5%BD

console.log(querystring.unescape('hello%20world'));
// 输出: hello world
```

> **提示：** `querystring` 模块是旧版 API。对于新的项目，推荐使用 `URLSearchParams`（可通过 `new URL('http://example.com').searchParams` 访问），它提供了更现代的 API。

---

### 五、事件模块 events

Node.js 的事件系统基于 `events` 模块实现，许多核心模块都继承自 `EventEmitter` 类。

#### 5.1 EventEmitter 基础

```javascript
const EventEmitter = require('events');

// 创建自定义事件发射器
class MyEmitter extends EventEmitter {}

const myEmitter = new MyEmitter();
```

#### 5.2 on() / emit() - 监听与触发事件

```javascript
const EventEmitter = require('events');

const emitter = new EventEmitter();

// 注册事件监听器
emitter.on('greet', (name) => {
  console.log(`你好, ${name}!`);
});

// 注册多个监听器
emitter.on('greet', (name) => {
  console.log(`欢迎 ${name} 来到 Node.js 世界!`);
});

// 触发事件
emitter.emit('greet', '小明');
// 输出:
// 你好, 小明!
// 欢迎 小明 来到 Node.js 世界!

// 带多个参数的事件
emitter.on('data', (id, type, payload) => {
  console.log(`数据: id=${id}, type=${type}`, payload);
});

emitter.emit('data', 1, 'json', { name: 'test', value: 123 });
```

#### 5.3 once() - 一次性监听器

`once()` 注册的监听器只会被触发一次，之后自动移除。

```javascript
const EventEmitter = require('events');

const emitter = new EventEmitter();

emitter.once('start', () => {
  console.log('服务启动（只触发一次）');
});

emitter.emit('start');
emitter.emit('start'); // 不会再触发

// 实际应用：确保初始化逻辑只执行一次
let initialized = false;
emitter.once('init', () => {
  initialized = true;
  console.log('初始化完成');
});

function doInit() {
  if (!initialized) {
    emitter.emit('init');
  }
}

doInit(); // 触发 init
doInit(); // 不再触发
```

#### 5.4 removeListener() / off() - 移除监听器

```javascript
const EventEmitter = require('events');

const emitter = new EventEmitter();

function handleConnection(params) {
  console.log('新的连接:', params);
}

// 添加监听器
emitter.on('connection', handleConnection);

// 触发事件
emitter.emit('connection', { id: 1, ip: '192.168.1.1' });

// 移除特定监听器
emitter.removeListener('connection', handleConnection);
// 或使用别名 off()
// emitter.off('connection', handleConnection);

// 再次触发，不会执行
emitter.emit('connection', { id: 2, ip: '192.168.1.2' });

// 移除某个事件的所有监听器
emitter.removeAllListeners('connection');

// 移除所有事件的所有监听器
emitter.removeAllListeners();
```

#### 5.5 事件继承与实战

通过继承 `EventEmitter`，可以创建具有事件驱动能力的自定义类。

```javascript
const EventEmitter = require('events');

class TaskManager extends EventEmitter {
  constructor() {
    super();
    this.tasks = [];
  }

  addTask(name) {
    const task = { id: Date.now(), name, status: 'pending' };
    this.tasks.push(task);
    this.emit('add', task);
    return task;
  }

  completeTask(id) {
    const task = this.tasks.find(t => t.id === id);
    if (task) {
      task.status = 'completed';
      this.emit('complete', task);
      this.emit('change', this.tasks);
    }
  }

  getTasks() {
    return this.tasks;
  }
}

// 使用 TaskManager
const manager = new TaskManager();

manager.on('add', (task) => {
  console.log(`任务已添加: ${task.name} (ID: ${task.id})`);
});

manager.on('complete', (task) => {
  console.log(`任务已完成: ${task.name}`);
});

manager.on('change', (tasks) => {
  console.log(`当前任务数: ${tasks.length}`);
});

manager.addTask('学习 Node.js');
manager.addTask('完成项目部署');
manager.completeTask(manager.getTasks()[0].id);
```

---

### 六、流模块 stream

流（Stream）是 Node.js 中处理流式数据的抽象接口。流可以高效地处理大数据集或逐步处理数据，而不需要一次性将全部数据加载到内存中。

#### 6.1 流的四种类型

- **可读流（Readable）**：数据从源头被读取，如 `fs.createReadStream`、`http.IncomingMessage`
- **可写流（Writable）**：数据被写入目的地，如 `fs.createWriteStream`、`http.ServerResponse`
- **双工流（Duplex）**：既可读又可写，如 `net.Socket`
- **转换流（Transform）**：在读写过程中对数据进行转换，如 `zlib.createGzip`

#### 6.2 可读流 Readable

```javascript
const fs = require('fs');

const readStream = fs.createReadStream('./large-file.txt', {
  encoding: 'utf8',
  highWaterMark: 64 * 1024
});

// 事件监听
readStream.on('open', () => {
  console.log('文件已打开');
});

readStream.on('data', (chunk) => {
  console.log(`读取数据块，大小: ${chunk.length} 字节`);
  // 可以在这里处理每个数据块
});

readStream.on('end', () => {
  console.log('读取完成');
});

readStream.on('error', (err) => {
  console.error('读取错误:', err);
});

// 使用 readable 事件手动读取
readStream.on('readable', () => {
  let chunk;
  while ((chunk = readStream.read()) !== null) {
    console.log('手动读取:', chunk);
  }
});
```

#### 6.3 可写流 Writable

```javascript
const fs = require('fs');

const writeStream = fs.createWriteStream('./output.txt');

// 写入数据
writeStream.write('第一段数据\n');
writeStream.write('第二段数据\n');
writeStream.write('第三段数据\n');

// 标记写入结束
writeStream.end('最后一段数据');

// 事件监听
writeStream.on('finish', () => {
  console.log('所有数据已写入完成');
});

writeStream.on('error', (err) => {
  console.error('写入错误:', err);
});

// 处理背压（Backpressure）问题
function writeData(data) {
  return new Promise((resolve, reject) => {
    const canWrite = writeStream.write(data);
    if (canWrite) {
      resolve();
    } else {
      writeStream.once('drain', resolve);
      writeStream.once('error', reject);
    }
  });
}
```

#### 6.4 pipe 管道

`pipe()` 是流最重要的功能之一，它可以将可读流的数据自动传递给可写流，自动处理背压和错误。

```javascript
const fs = require('fs');
const zlib = require('zlib');

// 基础文件复制
const readStream = fs.createReadStream('./source.txt');
const writeStream = fs.createWriteStream('./dest.txt');
readStream.pipe(writeStream);

// 压缩并复制
const gzip = zlib.createGzip();
const source = fs.createReadStream('./large-file.txt');
const compressed = fs.createWriteStream('./large-file.txt.gz');

source
  .pipe(gzip)        // 压缩
  .pipe(compressed); // 写入压缩文件

// 带错误处理的管道
const readable = fs.createReadStream('./input.txt');
const writable = fs.createWriteStream('./output.txt');

readable.on('error', (err) => console.error('读取错误:', err));
writable.on('error', (err) => console.error('写入错误:', err));

readable.pipe(writable);

// 链式管道处理
const input = fs.createReadStream('./data.csv');
const transform = new Transform({
  transform(chunk, encoding, callback) {
    const result = chunk.toString().toUpperCase();
    callback(null, result);
  }
});
const output = fs.createWriteStream('./data-upper.csv');

input
  .pipe(transform)
  .pipe(output);
```

#### 6.5 Stream 实战：实现自定义转换流

```javascript
const { Transform } = require('stream');
const fs = require('fs');

// 创建一个自定义的转换流：将内容转换为大写
const upperTransform = new Transform({
  transform(chunk, encoding, callback) {
    const upper = chunk.toString().toUpperCase();
    callback(null, upper);
  }
});

// 创建一个自定义的转换流：添加行号
const lineNumberTransform = new Transform({
  transform(chunk, encoding, callback) {
    const lines = chunk.toString().split('\n');
    const numbered = lines.map((line, index) => `${index + 1}: ${line}`).join('\n');
    callback(null, numbered);
  }
});

// 使用转换流处理文件
fs.createReadStream('./input.txt')
  .pipe(upperTransform)
  .pipe(lineNumberTransform)
  .pipe(fs.createWriteStream('./output-numbered.txt'))
  .on('finish', () => {
    console.log('处理完成');
  });
```

---

### 七、实战练习：创建文件批量重命名工具

现在我们将综合运用所学知识，创建一个实用的文件批量重命名工具。

#### 7.1 需求分析

- 读取指定目录下的所有文件
- 根据规则批量重命名文件
- 支持预览和实际执行两种模式
- 支持递归处理子目录
- 提供清晰的进度反馈

#### 7.2 实现代码

```javascript
#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

class BatchRenamer {
  constructor(options = {}) {
    this.directory = options.directory || process.cwd();
    this.pattern = options.pattern || /^(.+?)(\.\w+)?$/;
    this.replacePattern = options.replacePattern || null;
    this.recursive = options.recursive || false;
    this.preview = options.preview !== false;
    this.prefix = options.prefix || '';
    this.suffix = options.suffix || '';
    this.changes = [];
  }

  scanFiles(dir) {
    let files = [];
    const entries = fs.readdirSync(dir, { withFileTypes: true });

    for (const entry of entries) {
      const fullPath = path.join(dir, entry.name);
      if (entry.isDirectory() && this.recursive) {
        files = files.concat(this.scanFiles(fullPath));
      } else if (entry.isFile()) {
        files.push(fullPath);
      }
    }

    return files;
  }

  generateNewName(filePath) {
    const dir = path.dirname(filePath);
    const ext = path.extname(filePath);
    const baseName = path.basename(filePath, ext);

    let newBase = baseName;

    // 应用自定义替换规则
    if (this.replacePattern) {
      newBase = newBase.replace(this.replacePattern.search, this.replacePattern.replace);
    }

    // 添加前缀和后缀
    newBase = this.prefix + newBase + this.suffix;

    return path.join(dir, newBase + ext);
  }

  run() {
    console.log(`扫描目录: ${this.directory}`);
    console.log(`模式: ${this.preview ? '预览模式（不实际执行）' : '执行模式'}`);
    console.log(`递归: ${this.recursive ? '是' : '否'}`);
    console.log('---');

    const files = this.scanFiles(this.directory);
    console.log(`找到 ${files.length} 个文件`);
    console.log('---');

    let successCount = 0;
    let failCount = 0;

    for (const filePath of files) {
      const newPath = this.generateNewName(filePath);

      if (newPath === filePath) {
        continue;
      }

      this.changes.push({ from: filePath, to: newPath });

      if (this.preview) {
        console.log(`[预览] ${path.basename(filePath)} -> ${path.basename(newPath)}`);
        successCount++;
      } else {
        try {
          fs.renameSync(filePath, newPath);
          console.log(`[成功] ${path.basename(filePath)} -> ${path.basename(newPath)}`);
          successCount++;
        } catch (err) {
          console.log(`[失败] ${path.basename(filePath)}: ${err.message}`);
          failCount++;
        }
      }
    }

    console.log('---');
    console.log(`完成! 成功: ${successCount}, 失败: ${failCount}`);
    return this.changes;
  }

  undo() {
    if (this.preview) {
      console.log('预览模式无需撤销');
      return;
    }

    let undoCount = 0;
    for (const change of this.changes.reverse()) {
      try {
        fs.renameSync(change.to, change.from);
        undoCount++;
      } catch (err) {
        console.log(`撤销失败: ${err.message}`);
      }
    }
    console.log(`已撤销 ${undoCount} 个重命名操作`);
  }
}

// 使用示例
if (require.main === module) {
  const renamer = new BatchRenamer({
    directory: process.argv[2] || './test-files',
    pattern: /^(.+?)(\.\w+)?$/,
    replacePattern: {
      search: /\s+/g,
      replace: '_'
    },
    recursive: true,
    preview: true,    // 先预览
    prefix: '',
    suffix: ''
  });

  // 预览完成后，确认执行
  const readline = require('readline');
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  renamer.run();

  rl.question('确认执行以上重命名操作？(y/n): ', (answer) => {
    if (answer.toLowerCase() === 'y') {
      renamer.preview = false;
      renamer.run();
    } else {
      console.log('已取消');
    }
    rl.close();
  });
}

module.exports = BatchRenamer;
```

#### 7.3 使用方法

```javascript
// 创建测试目录
const fs = require('fs');
const path = require('path');

const testDir = './test-files';
if (!fs.existsSync(testDir)) {
  fs.mkdirSync(testDir, { recursive: true });
}

// 创建一些测试文件
const files = [
  'Document 1.pdf',
  'Document 2.pdf',
  'My Photo 2024.jpg',
  'Project Report v2.docx',
  '备份 文件 名称.txt'
];

files.forEach((name, index) => {
  fs.writeFileSync(path.join(testDir, name), `测试文件 ${index + 1}`);
});

console.log('测试文件已创建');
```

#### 7.4 进阶改造建议

1. **支持正则匹配和替换**：允许用户通过命令行传入正则表达式
2. **添加文件过滤**：只处理特定扩展名的文件
3. **生成日志**：将所有操作记录到日志文件
4. **支持日期批量重命名**：`IMG_001.jpg` → `20240923_001.jpg`
5. **冲突检测**：处理文件名冲突的情况（自动添加序号）
6. **GUI 界面**：使用 Electron 或 Web 技术构建图形界面

```javascript
// 进阶示例：添加日期前缀
const datedRenamer = new BatchRenamer({
  directory: './test-files',
  replacePattern: {
    search: /^/,
    replace: new Date().toISOString().split('T')[0] + '_'
  },
  recursive: false,
  preview: true
});

datedRenamer.run();
```

---

## 本章小结

| 模块 | 主要功能 | 常用 API |
|------|----------|----------|
| **fs** | 文件系统操作 | `readFile`, `writeFile`, `mkdir`, `readdir`, `createReadStream`, `watch` |
| **path** | 路径处理 | `join`, `resolve`, `basename`, `dirname`, `extname`, `parse` |
| **os** | 操作系统信息 | `platform`, `cpus`, `totalmem`, `freemem`, `hostname`, `tmpdir` |
| **url** | URL 处理 | `URL`, `parse`, `format`, `resolve`, `searchParams` |
| **events** | 事件驱动 | `EventEmitter`, `on`, `emit`, `once`, `removeListener` |
| **stream** | 流式数据处理 | `Readable`, `Writable`, `Transform`, `pipe` |

### 学习建议

1. **多动手实践**：每个模块都要编写示例代码进行测试
2. **阅读官方文档**：[Node.js 官方文档](https://nodejs.org/zh-cn/docs)
3. **理解异步模型**：重点理解回调、Promise 和 async/await 在文件操作中的应用
4. **学习第三方库**：了解 `fs-extra`、`chokidar`、`glob` 等常用工具库
5. **关注性能**：大文件处理使用流，避免同步操作阻塞主线程
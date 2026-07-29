---
title: 04-Node.js异步编程与事件循环
date: 2024-09-24T00:00:00+08:00
tags:
  - nodejs
  - 教程
  - 异步编程
categories:
  - node.js
cover: /images/cover13.png
sticky: false
description: Node.js异步编程与事件循环详解，深入理解同步阻塞、异步非阻塞、事件循环机制、Promise、async/await、定时器及实战应用
---

## [](#Node-js异步编程与事件循环)Node.js 异步编程与事件循环

Node.js 最大的特点就是**异步**和**事件驱动**。本章将从同步与异步的基本概念出发，逐步深入探讨 Node.js 的事件循环机制、回调地狱问题、Promise 对象、async/await 语法糖，以及定时器的执行顺序，最后通过实战练习巩固所学知识。

### [](#一同步与异步)一、同步与异步

在学习 Node.js 异步编程之前，我们需要先理解同步和异步的概念，以及为什么 Node.js 要采用异步模型。

#### [](#同步阻塞)同步阻塞

**同步阻塞**指的是程序在执行某个操作时，必须等待该操作完成后才能继续执行后续代码。如果该操作涉及 I/O 读写（如文件读取、网络请求），CPU 会处于等待状态，造成资源浪费。

```javascript
const fs = require('fs');

// 同步读取文件
const data = fs.readFileSync('input.txt', 'utf-8');
console.log(data);
console.log('程序继续执行');
```

在上面的代码中，`readFileSync` 会阻塞后续代码的执行，直到文件读取完成。如果文件很大，这个过程可能会很长。

#### [](#异步非阻塞)异步非阻塞

**异步非阻塞**则允许程序在等待某个操作完成的同时继续执行后续代码。当操作完成后，通过回调函数或其他机制通知程序进行后续处理。

```javascript
const fs = require('fs');

// 异步读取文件
fs.readFile('input.txt', 'utf-8', (err, data) => {
  if (err) throw err;
  console.log(data);
});

console.log('程序继续执行');
```

使用 `readFile` 方法时，程序不会阻塞，会继续执行后面的 `console.log`，等文件读取完成后再执行回调函数。

#### [](#为什么需要异步)为什么需要异步

JavaScript 是**单线程**语言，这意味着在同一时刻只能执行一段代码。如果使用同步阻塞的方式进行 I/O 操作：

- 一个耗时的 I/O 操作会阻塞整个线程，导致其他任务无法执行
- 在 Web 应用中，用户请求需要排队等待，严重影响性能
- CPU 大部分时间都在等待 I/O 操作完成，而不是在处理业务逻辑

Node.js 的异步模型正是为了解决这个问题而设计的，它让单线程的 JavaScript 也能高效处理高并发请求。

#### [](#Node-js异步模型优势)Node.js 异步模型优势

Node.js 的异步模型带来了以下优势：

- **高并发处理能力**：单线程配合事件循环，可以同时处理大量并发请求
- **低资源消耗**：不需要为每个请求创建独立的线程，节省内存和 CPU 资源
- **非阻塞 I/O**：文件操作、网络请求等 I/O 操作不会阻塞主线程
- **实时响应**：适合构建实时应用，如聊天室、在线协作工具等

### [](#二事件循环机制)二、事件循环机制

事件循环是 Node.js 异步编程的核心机制，理解事件循环的工作原理是掌握 Node.js 的关键。

#### [](#V8引擎与libuv)V8 引擎与 libuv

Node.js 的运行时环境主要由两部分组成：

- **V8 引擎**：负责执行 JavaScript 代码，是 Google Chrome 浏览器使用的 JavaScript 引擎
- **libuv**：一个跨平台的异步 I/O 库，为 Node.js 提供事件循环机制和异步操作能力

```
┌─────────────────────────────────────┐
│           Node.js 运行时            │
├─────────────────────────────────────┤
│  V8 引擎  │  libuv  │  内置模块  │  ...  │
└─────────────────────────────────────┘
```

V8 引擎负责解析和执行 JavaScript 代码，而 libuv 则负责处理 I/O 操作、定时器和事件回调。

#### [](#事件循环的六个阶段)事件循环的六个阶段

Node.js 的事件循环分为六个阶段，每个阶段都有特定的任务队列：

```
   ┌──────────────────────────────────┐
   │           timers 阶段              │
   │  执行 setTimeout / setInterval    │
   └──────────────┬───────────────────┘
                  │
   ┌──────────────▼───────────────────┐
   │         pending callbacks 阶段     │
   │  执行系统级错误回调                │
   └──────────────┬───────────────────┘
                  │
   ┌──────────────▼───────────────────┐
   │          idle, prepare 阶段        │
   │  内部使用，可忽略                  │
   └──────────────┬───────────────────┘
                  │
   ┌──────────────▼───────────────────┐
   │           poll 阶段                │
   │  等待新的 I/O 事件                 │
   │  执行 I/O 相关的回调函数           │
   └──────────────┬───────────────────┘
                  │
   ┌──────────────▼───────────────────┐
   │           check 阶段               │
   │  执行 setImmediate 回调           │
   └──────────────┬───────────────────┘
                  │
   ┌──────────────▼───────────────────┐
   │         close callbacks 阶段        │
   │  执行 socket.close 回调           │
   └──────────────────────────────────┘
```

各阶段说明：

| 阶段 | 说明 |
| --- | --- |
| **timers** | 执行 `setTimeout` 和 `setInterval` 设置的定时器回调 |
| **pending callbacks** | 执行系统级别的错误回调，如 TCP 连接错误 |
| **idle, prepare** | 事件循环内部使用的阶段，一般无需关注 |
| **poll** | 等待新的 I/O 事件，执行与 I/O 相关的回调函数。是事件循环的核心阶段 |
| **check** | 执行 `setImmediate` 设置的回调函数 |
| **close callbacks** | 执行 `socket.close` 事件的回调函数 |

#### [](#宏任务与微任务)宏任务与微任务

在事件循环中，任务分为两类：**宏任务（Macro-task）** 和 **微任务（Micro-task）**。

**宏任务**：

- 整体的 `script` 代码（主线程执行的代码）
- `setTimeout` / `setInterval` 回调
- I/O 回调
- `setImmediate` 回调

**微任务**：

- `process.nextTick` 回调
- Promise 的 `then` / `catch` / `finally` 回调
- `Object.observe`（已废弃）

执行规则：

1. 执行一个宏任务
2. 清空当前所有微任务
3. 执行下一个宏任务
4. 清空所有微任务
5. 依此循环，直到程序结束

#### [](#执行顺序图解)执行顺序图解

下面通过一个示例来说明事件循环的执行顺序：

```javascript
console.log('1. 主线程开始执行');

setTimeout(() => {
  console.log('2. setTimeout 回调');
}, 0);

Promise.resolve()
  .then(() => {
    console.log('3. Promise.then 微任务');
  })
  .then(() => {
    console.log('4. Promise.then 链式微任务');
  });

process.nextTick(() => {
  console.log('5. nextTick 微任务');
});

console.log('6. 主线程结束执行');
```

执行结果：

```
1. 主线程开始执行
6. 主线程结束执行
5. nextTick 微任务
3. Promise.then 微任务
4. Promise.then 链式微任务
2. setTimeout 回调
```

执行顺序分析：

```
第1步：执行主线程代码（宏任务）
  → 输出：1. 主线程开始执行
  → 遇到 setTimeout，注册到 timers 阶段
  → 遇到 Promise.then，注册微任务
  → 遇到 process.nextTick，注册微任务
  → 输出：6. 主线程结束执行

第2步：清空微任务队列
  → 先执行 process.nextTick：输出 5. nextTick 微任务
  → 执行第一个 Promise.then：输出 3. Promise.then 微任务
  → 执行第二个 Promise.then：输出 4. Promise.then 链式微任务

第3步：进入 timers 阶段
  → 执行 setTimeout 回调：输出 2. setTimeout 回调
```

> **注意**：`process.nextTick` 的优先级高于 Promise 微任务，它会在当前宏任务执行完后、所有其他微任务之前执行。

### [](#三回调地狱)三、回调地狱

#### [](#回调函数)回调函数

**回调函数**是指作为参数传递给另一个函数，在外部函数完成某些操作后被调用的函数。这是 JavaScript 实现异步编程的基础方式。

```javascript
function fetchData(callback) {
  setTimeout(() => {
    const data = { name: 'Node.js', version: '20.x' };
    callback(null, data);
  }, 1000);
}

fetchData((err, data) => {
  if (err) {
    console.error('获取数据失败:', err);
    return;
  }
  console.log('获取的数据:', data);
});
```

#### [](#回调地狱问题)回调地狱问题

当多个异步操作需要按顺序执行时，回调函数会形成嵌套，导致代码可读性差、难以维护，这就是**回调地狱（Callback Hell）**。

```javascript
// 读取用户信息 → 查询用户订单 → 获取订单详情 → 更新订单状态
getUser(userId, (err, user) => {
  if (err) throw err;
  getOrders(user.id, (err, orders) => {
    if (err) throw err;
    getOrderDetail(orders[0].id, (err, orderDetail) => {
      if (err) throw err;
      updateOrderStatus(orderDetail.id, 'paid', (err, result) => {
        if (err) throw err;
        console.log('订单更新成功:', result);
      });
    });
  });
});
```

回调地狱的问题：

- **代码嵌套过深**：形成"回调金字塔"，可读性极差
- **错误处理困难**：每一层回调都需要单独的错误处理
- **逻辑流程不清晰**：很难看出代码的执行顺序
- **难以维护和测试**：修改任何一步都需要改动多层嵌套的代码

#### [](#错误处理)错误处理

在回调函数中，通常采用 **Error-First Callback** 模式进行错误处理：

```javascript
fs.readFile('file.txt', 'utf-8', (err, data) => {
  if (err) {
    // 错误处理
    console.error('读取文件失败:', err.message);
    return;
  }
  // 正常处理
  console.log('文件内容:', data);
});
```

Error-First Callback 模式的规则：

- 回调函数的第一个参数固定为错误对象（`err`）
- 如果操作成功，`err` 为 `null` 或 `undefined`
- 如果操作失败，`err` 为 `Error` 对象，包含错误信息
- 其他参数为操作成功后返回的数据

### [](#四Promise)四、Promise

Promise 是 ES6 引入的异步编程解决方案，它可以将回调地狱的嵌套写法改为链式调用，使异步代码更加清晰易读。

#### [](#Promise状态)Promise 状态

Promise 对象有三种状态：

| 状态 | 说明 |
| --- | --- |
| **Pending（进行中）** | 初始状态，既不是成功，也不是失败 |
| **Fulfilled（已成功）** | 操作成功完成 |
| **Rejected（已失败）** | 操作失败 |

状态流转规则：

```
Pending ──→ Fulfilled（成功）
Pending ──→ Rejected（失败）
```

Promise 的状态只能从 Pending 变为 Fulfilled 或 Rejected，且状态一旦改变就不可逆。

#### [](#创建Promise)创建 Promise

使用 `new Promise()` 构造函数创建 Promise 对象：

```javascript
const promise = new Promise((resolve, reject) => {
  // 异步操作
  setTimeout(() => {
    const success = true;
    if (success) {
      resolve({ id: 1, name: 'Node.js' });
    } else {
      reject(new Error('操作失败'));
    }
  }, 1000);
});
```

`new Promise()` 接收一个执行器函数，该函数有两个参数：

- `resolve`：将 Promise 状态变为 Fulfilled，并传递成功结果
- `reject`：将 Promise 状态变为 Rejected，并传递失败原因

#### [](#链式调用)链式调用

Promise 通过 `.then()` 方法实现链式调用，避免回调地狱：

```javascript
function getUser(userId) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve({ id: userId, name: '张三' });
    }, 500);
  });
}

function getOrders(userId) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve([{ id: 101, userId }, { id: 102, userId }]);
    }, 500);
  });
}

function getOrderDetail(orderId) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve({ id: orderId, product: '笔记本电脑', price: 5999 });
    }, 500);
  });
}

// 链式调用
getUser(1)
  .then(user => {
    console.log('获取用户:', user);
    return getOrders(user.id);
  })
  .then(orders => {
    console.log('获取订单:', orders);
    return getOrderDetail(orders[0].id);
  })
  .then(orderDetail => {
    console.log('订单详情:', orderDetail);
  })
  .catch(err => {
    console.error('发生错误:', err.message);
  });
```

#### [](#Promise.all)Promise.all

`Promise.all` 用于并发执行多个 Promise，只有所有 Promise 都成功时才返回结果，只要有一个失败就立即返回失败：

```javascript
const promise1 = Promise.resolve(3);
const promise2 = 42;
const promise3 = new Promise((resolve, reject) => {
  setTimeout(resolve, 100, 'hello');
});

Promise.all([promise1, promise2, promise3])
  .then(results => {
    console.log('所有请求成功:', results); // [3, 42, 'hello']
  })
  .catch(err => {
    console.error('请求失败:', err);
  });
```

应用场景：需要同时获取多个接口的数据，等所有数据都返回后再进行处理。

#### [](#Promise.race)Promise.race

`Promise.race` 用于竞速执行多个 Promise，只要有一个 Promise 率先改变状态，就返回该 Promise 的结果：

```javascript
const fastPromise = new Promise((resolve) => {
  setTimeout(resolve, 100, '快速响应');
});

const slowPromise = new Promise((resolve) => {
  setTimeout(resolve, 1000, '慢速响应');
});

Promise.race([fastPromise, slowPromise])
  .then(result => {
    console.log('最先完成的:', result); // '快速响应'
  });
```

应用场景：设置请求超时，如果请求在指定时间内没有返回，则使用缓存数据或显示错误提示。

```javascript
function fetchWithTimeout(url, timeout = 5000) {
  const fetchPromise = fetch(url).then(res => res.json());
  const timeoutPromise = new Promise((_, reject) => {
    setTimeout(() => reject(new Error('请求超时')), timeout);
  });
  return Promise.race([fetchPromise, timeoutPromise]);
}
```

#### [](#Promise.allSettled)Promise.allSettled

`Promise.allSettled` 等待所有 Promise 都完成（无论成功或失败），返回每个 Promise 的结果和状态：

```javascript
const promise1 = Promise.resolve('成功');
const promise2 = Promise.reject('失败');
const promise3 = new Promise((resolve) => {
  setTimeout(resolve, 100, '延迟成功');
});

Promise.allSettled([promise1, promise2, promise3])
  .then(results => {
    results.forEach((result, index) => {
      console.log(`Promise ${index + 1}:`, result.status, result.value || result.reason);
    });
    // Promise 1: fulfilled 成功
    // Promise 2: rejected 失败
    // Promise 3: fulfilled 延迟成功
  });
```

应用场景：需要获取所有请求的结果，不关心单个请求是否成功（如批量处理、批量通知等）。

#### [](#Promise.any)Promise.any

`Promise.any` 只要有一个 Promise 成功就返回成功结果，所有 Promise 都失败才返回失败：

```javascript
const promise1 = Promise.reject('错误1');
const promise2 = Promise.reject('错误2');
const promise3 = Promise.resolve('成功');

Promise.any([promise1, promise2, promise3])
  .then(result => {
    console.log('第一个成功的:', result); // '成功'
  });

// 全部失败时
Promise.any([Promise.reject('错误1'), Promise.reject('错误2')])
  .catch(err => {
    console.log('所有请求都失败:', err.errors); // AggregateError
  });
```

应用场景：从多个数据源获取数据，只要有一个成功即可。

#### [](#Promise错误处理)Promise 错误处理

Promise 提供了两种错误处理方式：

**方式一：catch 方法**

```javascript
somePromise
  .then(result => {
    // 处理成功
  })
  .catch(err => {
    // 处理错误
  });
```

**方式二：then 的第二个参数**

```javascript
somePromise.then(
  result => {
    // 处理成功
  },
  err => {
    // 处理错误
  }
);
```

**推荐使用 `catch` 方法**，因为它可以捕获链中任意位置发生的错误，而 `then` 的第二个参数只能捕获前一个 Promise 的错误。

```javascript
getUser(1)
  .then(user => {
    return getOrders(user.id);
  })
  .then(orders => {
    throw new Error('订单处理失败');
  })
  .catch(err => {
    // 可以捕获链中任意环节的错误
    console.error('错误:', err.message);
  });
```

### [](#五asyncawait)五、async/await

`async/await` 是 ES2017 引入的语法糖，它让异步代码的写法更像同步代码，极大地提高了代码的可读性和可维护性。

#### [](#async函数)async 函数

`async` 关键字用于声明一个异步函数，该函数返回一个 Promise 对象：

```javascript
async function fetchData() {
  return 'Hello, async!';
}

// 等价于
function fetchData() {
  return Promise.resolve('Hello, async!');
}

fetchData().then(result => {
  console.log(result); // 'Hello, async!'
});
```

`async` 函数内部的 `return` 值会被自动包装成 Promise.resolve，抛出的错误会被包装成 Promise.reject。

#### [](#await关键字)await 关键字

`await` 关键字只能在 `async` 函数内部使用，用于等待一个 Promise 的结果：

```javascript
async function getUserData() {
  try {
    const user = await getUser(1);
    const orders = await getOrders(user.id);
    const orderDetail = await getOrderDetail(orders[0].id);
    console.log('订单详情:', orderDetail);
  } catch (err) {
    console.error('获取数据失败:', err.message);
  }
}
```

对比之前的 Promise 链式调用，`async/await` 的代码更加简洁清晰，逻辑流程一目了然。

#### [](#错误处理trycatch)错误处理 try/catch

在 `async/await` 中，使用 `try/catch` 块进行错误处理：

```javascript
async function fetchUserOrder(userId) {
  try {
    const user = await getUser(userId);
    const orders = await getOrders(user.id);
    return orders;
  } catch (err) {
    if (err.message.includes('用户不存在')) {
      console.log('用户不存在，创建新用户');
    } else {
      console.error('未知错误:', err.message);
    }
    throw err; // 继续向上抛出错误
  }
}
```

如果不使用 `try/catch`，需要在调用时添加 `.catch()` 来处理错误：

```javascript
fetchUserOrder(1)
  .then(orders => console.log(orders))
  .catch(err => console.error(err));
```

#### [](#并行执行Promise)并行执行 Promise

使用 `await` 按顺序执行多个 Promise 时，如果这些操作互不相关，可以使用 `Promise.all` 并行执行，提高效率：

```javascript
// 串行执行：总耗时 = 500 + 500 = 1000ms
async function fetchDataSerial() {
  const user = await getUser(1);
  const products = await getProducts();
  return { user, products };
}

// 并行执行：总耗时 = max(500, 500) = 500ms
async function fetchDataParallel() {
  const [user, products] = await Promise.all([
    getUser(1),
    getProducts()
  ]);
  return { user, products };
}
```

#### [](#注意事项)注意事项

**1. 不要忘记在 async 函数中使用 try/catch**

```javascript
async function riskyOperation() {
  try {
    const result = await doSomething();
    return result;
  } catch (err) {
    // 处理错误
    return defaultValue;
  }
}
```

**2. 避免在循环中串行执行独立的 Promise**

```javascript
// 不推荐：串行执行
async function processItems(items) {
  for (const item of items) {
    await processItem(item);
  }
}

// 推荐：并行执行
async function processItems(items) {
  await Promise.all(items.map(item => processItem(item)));
}
```

**3. 理解 await 的暂停语义**

`await` 会暂停当前 `async` 函数的执行，直到等待的 Promise 变为 Fulfilled 或 Rejected 状态。但它不会阻塞主线程，事件循环可以继续处理其他任务。

### [](#六定时器)六、定时器

Node.js 提供了多种定时器机制，它们在事件循环中的执行顺序各有不同。

#### [](#setTimeout与setInterval)setTimeout 与 setInterval

`setTimeout` 和 `setInterval` 是最常用的定时器，它们在事件循环的 **timers 阶段**执行。

```javascript
// 延时执行
setTimeout(() => {
  console.log('2秒后执行');
}, 2000);

// 定时重复执行
setInterval(() => {
  console.log('每1秒执行一次');
}, 1000);
```

`setTimeout(fn, 0)` 虽然设置为 0 毫秒，但实际执行时会受事件循环的影响，需要等当前宏任务和所有微任务执行完后才会在 timers 阶段执行。

#### [](#setImmediate)setImmediate

`setImmediate` 用于在当前事件循环轮询结束后、下一轮事件循环开始前立即执行回调。它在 **check 阶段**执行。

```javascript
setImmediate(() => {
  console.log('setImmediate 回调执行');
});
```

`setImmediate` 与 `setTimeout(fn, 0)` 的区别：

- `setImmediate` 在当前事件循环的 check 阶段执行
- `setTimeout(fn, 0)` 在当前事件循环的 timers 阶段执行
- 在同一个 I/O 回调内部，`setImmediate` 的回调总是先于 `setTimeout` 执行

```javascript
const fs = require('fs');

fs.readFile(__filename, () => {
  setTimeout(() => {
    console.log('setTimeout');
  }, 0);
  setImmediate(() => {
    console.log('setImmediate');
  });
});

// 输出结果：
// setImmediate
// setTimeout
```

#### [](#process.nextTick)process.nextTick

`process.nextTick` 用于在当前宏任务执行完后、进入下一个事件循环阶段之前立即执行回调。它的优先级**高于所有定时器和微任务**。

```javascript
console.log('开始');

process.nextTick(() => {
  console.log('nextTick 回调');
});

console.log('结束');

// 输出结果：
// 开始
// 结束
// nextTick 回调
```

`process.nextTick` 的特点：

- 在当前操作完成后立即执行，不需要等待事件循环的下一轮
- 适合在执行完一个回调后，立即开始另一个需要尽快执行的操作
- 可以用来在不阻塞事件循环的情况下递归执行计算

#### [](#执行顺序对比)执行顺序对比

下面通过一个综合示例来对比各种定时器的执行顺序：

```javascript
console.log('1. 主线程开始');

setTimeout(() => {
  console.log('2. setTimeout 回调');
}, 0);

setImmediate(() => {
  console.log('3. setImmediate 回调');
});

Promise.resolve().then(() => {
  console.log('4. Promise.then 微任务');
});

process.nextTick(() => {
  console.log('5. nextTick 回调');
});

console.log('6. 主线程结束');
```

执行结果：

```
1. 主线程开始
6. 主线程结束
5. nextTick 回调
4. Promise.then 微任务
2. setTimeout 回调
3. setImmediate 回调
```

执行顺序总结：

```
主线程代码 → process.nextTick → Promise 微任务 → setTimeout → setImmediate
```

> **注意**：在不同 Node.js 版本中，`setTimeout` 和 `setImmediate` 的执行顺序可能会有所不同。但根据官方文档，在同一个 I/O 回调中，`setImmediate` 总是先于 `setTimeout` 执行。

### [](#七实战练习)七、实战练习

#### [](#实现一个异步任务队列)实现一个异步任务队列

在实际开发中，我们经常需要控制异步任务的并发执行数量。下面实现一个异步任务队列，可以限制同时执行的任务数量。

```javascript
class AsyncTaskQueue {
  constructor(concurrency = 3) {
    this.concurrency = concurrency;
    this.queue = [];
    this.running = 0;
  }

  add(task) {
    return new Promise((resolve, reject) => {
      this.queue.push({
        task,
        resolve,
        reject
      });
      this.run();
    });
  }

  run() {
    while (this.running < this.concurrency && this.queue.length > 0) {
      const { task, resolve, reject } = this.queue.shift();
      this.running++;
      Promise.resolve()
        .then(task)
        .then(resolve)
        .catch(reject)
        .finally(() => {
          this.running--;
          this.run();
        });
    }
  }
}

// 使用示例
const queue = new AsyncTaskQueue(2); // 最多同时执行 2 个任务

function createTask(name, delay) {
  return () => new Promise(resolve => {
    console.log(`[开始] ${name}`);
    setTimeout(() => {
      console.log(`[完成] ${name}`);
      resolve(name);
    }, delay);
  });
}

// 添加多个任务
queue.add(createTask('任务1', 1000));
queue.add(createTask('任务2', 500));
queue.add(createTask('任务3', 300));
queue.add(createTask('任务4', 800));
queue.add(createTask('任务5', 200));
```

输出结果：

```
[开始] 任务1
[开始] 任务2
[完成] 任务2
[开始] 任务3
[完成] 任务3
[开始] 任务4
[完成] 任务1
[开始] 任务5
[完成] 任务5
[完成] 任务4
```

从输出可以看到，同一时刻最多只有 2 个任务在执行。

#### [](#对比不同异步方案的代码可读性)对比不同异步方案的代码可读性

下面用三种方式实现同一个业务场景，对比它们的代码可读性。

**业务场景**：获取用户信息 → 获取用户文章列表 → 获取第一篇文章的评论 → 发送通知

**方式一：回调函数**

```javascript
function notifyUser(userId, callback) {
  getUser(userId, (err, user) => {
    if (err) return callback(err);
    getPosts(user.id, (err, posts) => {
      if (err) return callback(err);
      getComments(posts[0].id, (err, comments) => {
        if (err) return callback(err);
        sendNotification(user, comments, (err, result) => {
          if (err) return callback(err);
          callback(null, result);
        });
      });
    });
  });
}
```

**方式二：Promise 链式调用**

```javascript
function notifyUser(userId) {
  return getUser(userId)
    .then(user => getPosts(user.id).then(posts => ({ user, posts })))
    .then(({ user, posts }) => getComments(posts[0].id)
      .then(comments => ({ user, comments })))
    .then(({ user, comments }) => sendNotification(user, comments))
    .catch(err => {
      console.error('通知失败:', err);
      throw err;
    });
}
```

**方式三：async/await**

```javascript
async function notifyUser(userId) {
  try {
    const user = await getUser(userId);
    const posts = await getPosts(user.id);
    const comments = await getComments(posts[0].id);
    const result = await sendNotification(user, comments);
    return result;
  } catch (err) {
    console.error('通知失败:', err);
    throw err;
  }
}
```

**三种方式对比**：

| 对比项 | 回调函数 | Promise 链式 | async/await |
| --- | --- | --- | --- |
| 可读性 | 差（嵌套过深） | 中（链式嵌套） | 好（像同步代码） |
| 错误处理 | 每层都要处理 | 统一 catch | try/catch |
| 代码量 | 多 | 中 | 少 |
| 维护性 | 差 | 中 | 好 |

通过对比可以看出，`async/await` 是目前 Node.js 异步编程的最佳实践，它在保持异步性能的同时，提供了最清晰的代码结构。

---

### [](#本章小结)本章小结

本章详细介绍了 Node.js 异步编程和事件循环的核心知识：

1. **同步与异步**：理解了同步阻塞和异步非阻塞的区别，以及 Node.js 采用异步模型的原因
2. **事件循环机制**：掌握了事件循环的六个阶段、宏任务与微任务的概念以及执行顺序
3. **回调地狱**：了解了回调地狱的问题，并学习了 Error-First Callback 的错误处理模式
4. **Promise**：深入学习了 Promise 的状态、创建方式、链式调用和 `all`/`race`/`allSettled`/`any` 等方法
5. **async/await**：掌握了 async 函数和 await 关键字的使用，以及 try/catch 错误处理
6. **定时器**：区分了 `setTimeout`、`setImmediate` 和 `process.nextTick` 的执行顺序
7. **实战练习**：实现了异步任务队列，并对比了不同异步方案的代码可读性

掌握这些知识，将为后续学习 Node.js 高级特性和框架打下坚实的基础。
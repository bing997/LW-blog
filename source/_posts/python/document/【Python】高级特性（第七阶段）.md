---
title: 【Python】高级特性（第七阶段）
date: 2026-07-23 14:00:00
categories:
  - Python
tags:
  - Python
  - 教程
  - 高级特性
  - 迭代器
  - 装饰器
description: 深入 Python 核心机制，掌握迭代器、生成器、装饰器、上下文管理器、描述符、元类、协程和类型系统。
cover: /images/cover.png
---

# 七、Python 高级特性（语言表达能力）

> **阶段定位**：本阶段深入 Python 的核心机制，理解这些特性不仅能写出更优雅的代码，还能让你真正"读懂" Python 的内部运作方式。这些知识是区分"会用 Python"和"精通 Python"的分水岭。

```
┌─────────────────────────────────────────────────────────────────┐
│                    Python 高级特性知识图谱                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. 迭代器协议 ─→ Iterable / Iterator / __iter__ / __next__     │
│       │                                                         │
│  2. 生成器 ─────→ send() / throw() / close() / 状态机          │
│       │                                                         │
│  3. 装饰器 ─────→ 带参数装饰器 / 类装饰器 / 叠加顺序 / lru_cache │
│       │                                                         │
│  4. 上下文管理器 ─→ @contextmanager / asynccontextmanager       │
│       │                                                         │
│  5. 描述符 ─────→ __get__ / __set__ / __delete__ / @property    │
│       │                                                         │
│  6. 元类 ───────→ type / __init_subclass__ / 类创建控制          │
│       │                                                         │
│  7. 协程 ───────→ async / await / asyncio / 异步迭代器           │
│       │                                                         │
│  8. 类型系统 ───→ typing / Protocol / TypedDict / Generic       │
│       │                                                         │
│  9. 高级函数 ───→ functools / operator / contextvars / singledispatch │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 1. 迭代器协议与可迭代对象

### 1.1 迭代器 vs 可迭代对象

```python
# 可迭代对象（Iterable）：实现了 __iter__() 的对象
my_list = [1, 2, 3]
print(hasattr(my_list, "__iter__"))   # True

# 迭代器（Iterator）：实现了 __iter__() 和 __next__() 的对象
iterator = iter(my_list)
print(hasattr(iterator, "__next__"))  # True

# 迭代器只能遍历一次
print(next(iterator))   # 1
print(next(iterator))   # 2
print(next(iterator))   # 3
# print(next(iterator))   # StopIteration

# 再次遍历需要重新创建迭代器
for item in iter(my_list):
    print(item, end=" ")   # 1 2 3
```

**迭代器协议关系图**：

```
┌─────────────────────────────────────────────────────────┐
│                  迭代器协议关系图                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Iterable（可迭代对象）                                   │
│    │                                                    │
│    ├── 实现 __iter__()                                   │
│    │    └── 返回 Iterator                                │
│    │                                                    │
│    └── 例子: list, tuple, str, dict, range              │
│                                                         │
│  Iterator（迭代器）                                       │
│    │                                                    │
│    ├── 实现 __iter__() → 返回 self                      │
│    ├── 实现 __next__() → 返回下一个元素                  │
│    │    └── 无元素时抛出 StopIteration                   │
│    │                                                    │
│    └── 特性: 惰性计算，只能遍历一次                       │
│                                                         │
│  for 循环的工作原理:                                      │
│    for item in iterable:                                 │
│      ↓                                                  │
│    iterator = iter(iterable)                             │
│    while True:                                          │
│        try:                                             │
│            item = next(iterator)                         │
│            ...                                          │
│        except StopIteration:                             │
│            break                                        │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 1.2 自定义迭代器

```python
class Countdown:
    """倒计时迭代器。"""
    def __init__(self, start):
        self.start = start

    def __iter__(self):
        return self          # 迭代器本身返回 self

    def __next__(self):
        if self.start <= 0:
            raise StopIteration
        self.start -= 1
        return self.start + 1

# 使用
for num in Countdown(5):
    print(num, end=" ")   # 5 4 3 2 1
```

### 1.3 自定义可迭代对象（分离迭代器）

```python
class Range:
    """简化版 range 实现。"""
    def __init__(self, start, stop=None, step=1):
        if stop is None:
            start, stop = 0, start
        self.start = start
        self.stop = stop
        self.step = step

    def __iter__(self):
        # 每次迭代都返回全新的迭代器，支持多次遍历
        return _RangeIterator(self.start, self.stop, self.step)

    def __repr__(self):
        return f"Range({self.start}, {self.stop}, {self.step})"

class _RangeIterator:
    """独立的迭代器类。"""
    def __init__(self, start, stop, step):
        self.current = start
        self.stop = stop
        self.step = step

    def __iter__(self):
        return self

    def __next__(self):
        if (self.step > 0 and self.current >= self.stop) or \
           (self.step < 0 and self.current <= self.stop):
            raise StopIteration
        value = self.current
        self.current += self.step
        return value

# 可多次遍历
r = Range(3)
print(list(r))   # [0, 1, 2]
print(list(r))   # [0, 1, 2] —— 可以再次遍历
```

> **工程建议**：如果需要支持多次遍历，将迭代器与可迭代对象分离；如果只需要单次遍历，让类同时实现两种协议（如 `Countdown`）。

---

## 2. 生成器的深层次应用

### 2.1 `send()` 双向通信

```python
def accumulator():
    """累加器：通过 send() 接收外部输入。"""
    total = 0
    while True:
        value = yield total    # 发送当前总和，接收新值
        if value is None:
            break
        total += value

acc = accumulator()
next(acc)              # 预激生成器（或用 acc.send(None)）

print(acc.send(10))    # 10
print(acc.send(20))    # 30
print(acc.send(5))     # 35
acc.close()            # 关闭生成器
```

**`send()` 工作原理**：

```
┌─────────────────────────────────────────────────────────┐
│                  send() 双向通信流程                     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  1. next(gen) 或 gen.send(None) ─→ 预激生成器          │
│     └── 执行到 yield，发送初始值，暂停                    │
│                                                         │
│  2. gen.send(value) ─→ 将 value 注入生成器              │
│     └── yield 表达式返回 value，继续执行到下一个 yield   │
│                                                         │
│  3. gen.close() ─→ 关闭生成器                          │
│     └── 在 yield 处抛出 GeneratorExit 异常              │
│                                                         │
│  执行序列示例:                                           │
│    acc = accumulator()                                  │
│    next(acc)       → 执行到 yield total，发送 0，暂停    │
│    acc.send(10)    → yield 返回 10，total=10，发送 10   │
│    acc.send(20)    → yield 返回 20，total=30，发送 30   │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 2.2 `throw()` 注入异常

```python
def resilient_generator():
    """可以处理被注入异常的生成器。"""
    try:
        yield "开始"
        yield "进行中"
    except ValueError:
        yield "捕获了 ValueError"
    yield "结束"

g = resilient_generator()
print(next(g))           # 开始
print(next(g))           # 进行中
print(g.throw(ValueError, "测试异常"))   # 捕获了 ValueError
print(next(g))           # 结束
```

### 2.3 `close()` 与生成器清理

```python
def database_cursor():
    """带清理逻辑的生成器。"""
    conn = create_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT * FROM users")
        for row in cursor:
            yield row
    finally:
        cursor.close()
        conn.close()
        print("资源已清理")

# 使用
g = database_cursor()
for row in g:
    if row["id"] == 5:
        g.close()   # 提前终止，触发 finally 块
        break
```

### 2.4 生成器状态机

```python
def traffic_light():
    """用生成器实现状态机。"""
    while True:
        # 红灯
        yield "红灯"
        # 绿灯
        yield "绿灯"
        # 黄灯
        yield "黄灯"

light = traffic_light()
for _ in range(6):
    print(next(light), end=" -> ")
# 红灯 -> 绿灯 -> 黄灯 -> 红灯 -> 绿灯 -> 黄灯 ->
```

---

## 3. 装饰器进阶

### 3.1 带参数的装饰器（复习+深入）

```python
import functools
import time

def retry(max_attempts=3, delay=1, backoff=2, exceptions=(Exception,)):
    """可配置的重试装饰器。"""
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            last_exception = None
            current_delay = delay
            for attempt in range(1, max_attempts + 1):
                try:
                    return func(*args, **kwargs)
                except exceptions as e:
                    last_exception = e
                    if attempt < max_attempts:
                        time.sleep(current_delay)
                        current_delay *= backoff
            raise last_exception
        return wrapper
    return decorator

@retry(max_attempts=3, delay=0.5, exceptions=(ConnectionError,))
def fetch_data(url):
    """模拟网络请求。"""
    import random
    if random.random() < 0.7:
        raise ConnectionError(f"请求失败: {url}")
    return {"status": "ok", "data": []}
```

### 3.2 类装饰器

```python
def singleton(cls):
    """类装饰器：将任何类变为单例。"""
    instances = {}
    @functools.wraps(cls)
    def wrapper(*args, **kwargs):
        if cls not in instances:
            instances[cls] = cls(*args, **kwargs)
        return instances[cls]
    return wrapper

@singleton
class Database:
    def __init__(self, host="localhost"):
        self.host = host
        print(f"初始化 Database: {host}")

db1 = Database("prod")
db2 = Database("test")
print(db1 is db2)        # True
print(db1.host)          # prod —— 第一次的值
```

### 3.3 装饰器叠加顺序

```python
@decorator_a
@decorator_b
@decorator_c
def my_func():
    pass

# 等价于：my_func = decorator_a(decorator_b(decorator_c(my_func)))
# 执行顺序：
# 1. 装饰时（定义阶段）：从内到外
#    decorator_c → decorator_b → decorator_a
# 2. 调用时（运行阶段）：从外到内
#    decorator_a 的 wrapper → decorator_b 的 wrapper → decorator_c 的 wrapper → my_func
```

**装饰器叠加流程图**：

```
┌─────────────────────────────────────────────────────────┐
│                  装饰器叠加执行流程                       │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  定义阶段（装饰时）：                                      │
│    @decorator_a                                          │
│    @decorator_b                                          │
│    @decorator_c                                          │
│    def my_func():                                        │
│        pass                                              │
│                                                         │
│    执行顺序: decorator_c → decorator_b → decorator_a     │
│                                                         │
│    等价于:                                                │
│    temp1 = decorator_c(my_func)                          │
│    temp2 = decorator_b(temp1)                            │
│    my_func = decorator_a(temp2)                          │
│                                                         │
│  调用阶段（运行时）：                                      │
│    my_func()                                             │
│                                                         │
│    执行顺序: decorator_a → decorator_b → decorator_c     │
│              ↓              ↓              ↓             │
│         wrapper_a     wrapper_b     wrapper_c           │
│              ↓              ↓              ↓             │
│         my_func()（原始函数）                             │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 3.4 实用的装饰器模式

```python
# 1. 方法计时器
import time
import functools

def timer(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        start = time.perf_counter()
        result = func(*args, **kwargs)
        elapsed = time.perf_counter() - start
        print(f"{func.__name__} 耗时: {elapsed:.4f}s")
        return result
    return wrapper

# 2. 缓存（memoization）
def memoize(func):
    cache = {}
    @functools.wraps(func)
    def wrapper(*args):
        if args not in cache:
            cache[args] = func(*args)
        return cache[args]
    wrapper.cache = cache
    return wrapper

# 3. 使用 functools.lru_cache（标准库推荐）
from functools import lru_cache

@lru_cache(maxsize=128)   # 最多缓存 128 个结果
def fibonacci(n):
    if n < 2:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)

print(fibonacci(100))     # 瞬间完成
print(fibonacci.cache_info())   # CacheInfo(hits=98, misses=101, maxsize=128, currsize=101)

# 4. 类型检查装饰器
def type_check(**types):
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            import inspect
            sig = inspect.signature(func)
            bound = sig.bind(*args, **kwargs)
            bound.apply_defaults()
            for name, expected in types.items():
                if name in bound.arguments:
                    value = bound.arguments[name]
                    if not isinstance(value, expected):
                        raise TypeError(f"{name} 期望 {expected.__name__}，实际 {type(value).__name__}")
            return func(*args, **kwargs)
        return wrapper
    return decorator

@type_check(name=str, age=int)
def create_user(name, age):
    return {"name": name, "age": age}

# create_user("Alice", "30")   # TypeError
```

---

## 4. 上下文管理器进阶

### 4.1 `contextlib` 模块

```python
from contextlib import contextmanager, suppress, redirect_stdout, ExitStack

# @contextmanager：用生成器写上下文管理器
@contextmanager
def managed_resource(name):
    print(f"获取资源: {name}")
    resource = {"name": name, "status": "active"}
    try:
        yield resource
    finally:
        print(f"释放资源: {name}")

with managed_resource("db_connection") as res:
    print(f"使用资源: {res}")

# suppress：优雅地忽略异常
with suppress(FileNotFoundError):
    os.remove("nonexistent.txt")   # 不会报错

# redirect_stdout：重定向输出
import io
buffer = io.StringIO()
with redirect_stdout(buffer):
    print("这行被重定向到 buffer")
print(buffer.getvalue())

# ExitStack：动态管理多个上下文
with ExitStack() as stack:
    files = [stack.enter_context(open(f"data{i}.txt")) for i in range(3)]
    # 所有文件会在 with 结束时自动关闭

# 甚至可以延迟决定进入哪些上下文
with ExitStack() as stack:
    if condition:
        file = stack.enter_context(open("optional.txt"))
    # 条件满足时 file 会自动关闭
```

### 4.2 异步上下文管理器

```python
import asyncio
from contextlib import asynccontextmanager

@asynccontextmanager
async def async_database():
    """异步上下文管理器。"""
    conn = await create_async_connection()
    try:
        yield conn
    finally:
        await conn.close()

async def main():
    async with async_database() as db:
        result = await db.query("SELECT * FROM users")
        print(result)

# asyncio.run(main())
```

---

## 5. 描述符与属性访问拦截

### 5.1 描述符协议回顾

```python
class TypedAttribute:
    """类型检查描述符。"""
    def __init__(self, name, expected_type):
        self.name = name
        self.expected_type = expected_type
        self.storage_name = f"_{name}"

    def __get__(self, instance, owner):
        if instance is None:
            return self
        return getattr(instance, self.storage_name, None)

    def __set__(self, instance, value):
        if not isinstance(value, self.expected_type):
            raise TypeError(f"{self.name} 必须是 {self.expected_type.__name__}")
        setattr(instance, self.storage_name, value)

    def __delete__(self, instance):
        raise AttributeError(f"不能删除 {self.name}")

class Person:
    name = TypedAttribute("name", str)
    age = TypedAttribute("age", int)

    def __init__(self, name, age):
        self.name = name
        self.age = age

p = Person("Alice", 30)
# p.name = 123   # TypeError
```

### 5.2 `__getattr__` 与 `__getattribute__`

```python
class LazyObject:
    """延迟加载属性。"""
    def __init__(self):
        self._loaded = False
        self._data = {}

    def _load(self):
        if not self._loaded:
            print("加载数据...")
            self._data = {"name": "Alice", "age": 30, "city": "Beijing"}
            self._loaded = True

    def __getattr__(self, name):
        """访问不存在的属性时调用。"""
        self._load()
        if name in self._data:
            return self._data[name]
        raise AttributeError(f"'{type(self).__name__}' 对象没有属性 '{name}'")

obj = LazyObject()
print(obj.name)    # 加载数据... Alice
print(obj.age)     # 30（不再加载）
# print(obj.xxx)   # AttributeError

class StrictObject:
    """严格拦截所有属性访问。"""
    def __init__(self):
        self.allowed = {"name", "age"}
        self._name = "Alice"
        self._age = 30

    def __getattribute__(self, name):
        """拦截所有属性访问（包括存在的属性）。"""
        allowed = object.__getattribute__(self, "allowed")
        if name not in allowed and not name.startswith("_"):
            raise AttributeError(f"'{name}' 不在允许列表中")
        return object.__getattribute__(self, name)

s = StrictObject()
print(s._name)     # Alice
# print(s.email)   # AttributeError
```

**`__getattr__` vs `__getattribute__`**：

| 特性 | `__getattr__` | `__getattribute__` |
|------|---------------|-------------------|
| 触发时机 | 属性**不存在**时 | **所有**属性访问 |
| 默认行为 | 抛出 `AttributeError` | 正常查找属性 |
| 无限递归风险 | 无 | 高（必须用 `object.__getattribute__`） |
| 使用场景 | 延迟加载、动态属性 | 严格访问控制、代理模式 |

---

## 6. 元类实战

### 6.1 `__init_subclass__`（推荐替代方案）

```python
class PluginBase:
    """插件基类：自动注册所有子类。"""
    _registry = {}

    def __init_subclass__(cls, plugin_name=None, **kwargs):
        super().__init_subclass__(**kwargs)
        name = plugin_name or cls.__name__
        cls._registry[name] = cls
        print(f"注册插件: {name}")

class ImagePlugin(PluginBase, plugin_name="image"):
    pass

class VideoPlugin(PluginBase):
    pass

print(PluginBase._registry)
# {'image': <class 'ImagePlugin'>, 'VideoPlugin': <class 'VideoPlugin'>}
```

### 6.2 元类控制类创建

```python
class ValidateFieldsMeta(type):
    """元类：自动为类添加字段验证。"""
    def __new__(mcs, name, bases, namespace):
        annotations = namespace.get("__annotations__", {})
        for field_name, field_type in annotations.items():
            if field_name.startswith("_"):
                continue
            # 为每个注解字段创建 property
            private_name = f"_{field_name}"
            def make_getter(private):
                return lambda self: getattr(self, private)
            def make_setter(private, expected_type):
                def setter(self, value):
                    if not isinstance(value, expected_type):
                        raise TypeError(f"{field_name} 期望 {expected_type.__name__}")
                    setattr(self, private, value)
                return setter
            namespace[field_name] = property(
                make_getter(private_name),
                make_setter(private_name, field_type)
            )
        return super().__new__(mcs, name, bases, namespace)

class Person(metaclass=ValidateFieldsMeta):
    name: str
    age: int

    def __init__(self, name, age):
        self._name = name
        self._age = age

p = Person("Alice", 30)
# p.age = "abc"   # TypeError
```

---

## 7. 协程与异步编程（async/await）

### 7.1 基础概念

```python
import asyncio

async def say_hello():
    """协程函数：使用 async def 定义。"""
    print("Hello")
    await asyncio.sleep(1)   # 非阻塞等待
    print("World")

# 协程对象（调用协程函数返回）
coro = say_hello()
print(type(coro))   # <class 'coroutine'>

# 运行协程
asyncio.run(say_hello())
```

### 7.2 asyncio 核心 API

```python
import asyncio

async def main():
    # 创建任务
    task1 = asyncio.create_task(fetch_data("url1"))
    task2 = asyncio.create_task(fetch_data("url2"))

    # 等待多个任务
    results = await asyncio.gather(task1, task2, return_exceptions=True)

    # 等待任一完成
    done, pending = await asyncio.wait(
        [task1, task2],
        return_when=asyncio.FIRST_COMPLETED
    )

    # 超时控制
    try:
        result = await asyncio.wait_for(risky_operation(), timeout=5)
    except asyncio.TimeoutError:
        print("操作超时")

    # shield：保护任务不被取消
    important_task = asyncio.create_task(critical_operation())
    result = await asyncio.shield(important_task)

async def fetch_data(url):
    await asyncio.sleep(0.1)
    return f"data from {url}"

# asyncio.run(main())
```

### 7.3 异步迭代器与异步生成器

```python
import asyncio
import aiohttp

class AsyncDataSource:
    """异步迭代器。"""
    def __init__(self, urls):
        self.urls = urls
        self.index = 0

    def __aiter__(self):
        return self

    async def __anext__(self):
        if self.index >= len(self.urls):
            raise StopAsyncIteration
        url = self.urls[self.index]
        self.index += 1
        return await fetch_url(url)

# 异步生成器（更简洁）
async def async_paginator(api, page_size=10):
    """异步分页生成器。"""
    page = 1
    while True:
        data = await api.fetch_page(page, page_size)
        if not data:
            break
        for item in data:
            yield item
        page += 1

# 使用
async def process():
    async for item in async_paginator(api):
        await process_item(item)

# 异步推导式
async def fetch_all(urls):
    return [await fetch_url(url) async for url in async_url_generator()]
```

---

## 8. 类型系统进阶

### 8.1 `typing` 模块核心类型

```python
from typing import (
    List, Dict, Set, Tuple, Optional, Union,
    Callable, Iterator, Generator, Any, Literal,
    TypedDict, Protocol, NewType, Final
)

# 基础类型
numbers: List[int] = [1, 2, 3]
user: Dict[str, Union[str, int]] = {"name": "Alice", "age": 30}
point: Tuple[float, float] = (1.0, 2.0)

# Optional = Union[X, None]
def find_user(user_id: int) -> Optional[User]:
    ...

# Callable
handler: Callable[[int, str], bool]

# Literal（限定具体值）
def set_status(status: Literal["active", "inactive", "pending"]) -> None:
    ...

# Final（不可变常量）
MAX_RETRIES: Final[int] = 3
# MAX_RETRIES = 5   # mypy 会报错

# NewType（创建语义化类型）
UserId = NewType("UserId", int)
OrderId = NewType("OrderId", int)

def get_user(user_id: UserId) -> User:
    ...

# get_user(OrderId(123))   # mypy 会报错，类型不匹配
```

### 8.2 TypedDict

```python
from typing import TypedDict, NotRequired  # 3.11+

class Movie(TypedDict):
    name: str
    year: int
    rating: NotRequired[float]   # 可选字段

movie: Movie = {"name": "Inception", "year": 2010}
movie["rating"] = 8.8

# 错误的键会被检查
# movie["director"] = "Nolan"   # mypy 报错
```

### 8.3 Protocol（结构子类型）

```python
from typing import Protocol

class Drawable(Protocol):
    """协议：任何有 draw() 方法的对象。"""
    def draw(self) -> None:
        ...

def render(item: Drawable) -> None:
    item.draw()

class Circle:
    def draw(self) -> None:
        print("画圆")

class Square:
    def draw(self) -> None:
        print("画方")

# Circle 和 Square 都没有继承 Drawable，但满足协议
render(Circle())   # 通过类型检查
render(Square())   # 通过类型检查
```

### 8.4 泛型

```python
from typing import TypeVar, Generic, List

T = TypeVar("T")
K = TypeVar("K")
V = TypeVar("V")

class Stack(Generic[T]):
    """泛型栈。"""
    def __init__(self) -> None:
        self._items: List[T] = []

    def push(self, item: T) -> None:
        self._items.append(item)

    def pop(self) -> T:
        return self._items.pop()

    def peek(self) -> T:
        return self._items[-1]

int_stack = Stack[int]()
int_stack.push(42)
# int_stack.push("hello")   # mypy 报错

str_stack = Stack[str]()
str_stack.push("hello")
```

---

## 9. 高级函数技巧

### 9.1 `functools` 模块

```python
import functools
from operator import itemgetter, attrgetter

# partial：固定部分参数
from functools import partial

base_two = partial(int, base=2)
print(base_two("1010"))   # 10

# reduce
from functools import reduce
product = reduce(lambda x, y: x * y, [1, 2, 3, 4, 5])
print(product)   # 120

# cmp_to_key：将比较函数转为 key 函数
def compare_length(a, b):
    return len(a) - len(b)

words = ["apple", "pie", "banana"]
words.sort(key=functools.cmp_to_key(compare_length))

# cached_property：只计算一次的属性
class DataProcessor:
    def __init__(self, raw_data):
        self.raw_data = raw_data

    @functools.cached_property
    def processed(self):
        """只计算一次，后续直接读取缓存。"""
        print("处理数据中...")
        return [x.strip().lower() for x in self.raw_data]

# total_ordering：自动生成比较方法
@functools.total_ordering
class Version:
    def __init__(self, major, minor, patch):
        self.major = major
        self.minor = minor
        self.patch = patch

    def __eq__(self, other):
        return (self.major, self.minor, self.patch) == (other.major, other.minor, other.patch)

    def __lt__(self, other):
        return (self.major, self.minor, self.patch) < (other.major, other.minor, other.patch)

# 自动生成 __le__, __gt__, __ge__
```

### 9.2 `operator` 模块

```python
from operator import itemgetter, attrgetter, methodcaller

data = [
    {"name": "Alice", "age": 30},
    {"name": "Bob", "age": 25},
    {"name": "Carol", "age": 35},
]

# itemgetter：按字典键排序/取值
sorted_by_age = sorted(data, key=itemgetter("age"))
get_name = itemgetter("name")
print(list(map(get_name, data)))   # ['Alice', 'Bob', 'Carol']

# attrgetter：按对象属性操作
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

people = [Person("Alice", 30), Person("Bob", 25)]
sorted_people = sorted(people, key=attrgetter("age"))

# methodcaller：调用对象方法
upper = methodcaller("upper")
print(upper("hello"))   # HELLO
```

### 9.3 `contextvars`：异步上下文变量（3.7+）

在异步编程中，`threading.local` 不适用（协程切换不换线程），`contextvars` 提供了正确的协程级上下文隔离。

```python
import asyncio
from contextvars import ContextVar

# 定义上下文变量
request_id = ContextVar("request_id", default="unknown")

async def handle_request():
    tid = request_id.get()
    print(f"处理请求: {tid}")
    await asyncio.sleep(0.1)
    # 即使在异步切换后，上下文变量仍然保持正确
    print(f"完成请求: {request_id.get()}")

async def main():
    # 为不同协程设置不同的上下文
    tasks = []
    for i in range(3):
        token = request_id.set(f"req_{i}")
        tasks.append(handle_request())
        request_id.reset(token)   # 恢复之前的值

    await asyncio.gather(*tasks)

# asyncio.run(main())

# 工程场景：在异步 Web 框架中传递请求 ID、用户信息、数据库会话
# FastAPI 内部就使用 contextvars 实现请求隔离
```

### 9.4 `functools.singledispatch`：单分派泛型函数

根据第一个参数的类型，自动选择不同的函数实现。

```python
from functools import singledispatch

@singledispatch
def process(value):
    """处理不同类型数据的通用接口。"""
    raise NotImplementedError(f"不支持的类型: {type(value)}")

@process.register(int)
def _(value):
    print(f"处理整数: {value}")

@process.register(str)
def _(value):
    print(f"处理字符串: {value}")

@process.register(list)
def _(value):
    print(f"处理列表，长度: {len(value)}")

@process.register(dict)
def _(value):
    print(f"处理字典，键: {list(value.keys())}")

# 注册自定义类型
from typing import NamedTuple
class Point(NamedTuple):
    x: int
    y: int

@process.register(Point)
def _(value):
    print(f"处理 Point: ({value.x}, {value.y})")

# 使用
process(42)           # 处理整数: 42
process("hello")      # 处理字符串: hello
process([1, 2, 3])    # 处理列表，长度: 3
process({"a": 1})     # 处理字典，键: ['a']
process(Point(3, 4))  # 处理 Point: (3, 4)

# 工程场景：数据序列化、策略分发、多类型数据处理
# 优势：比 if/elif/elif 更优雅，添加新类型时不需要修改现有代码
```

---

## 附录：第七阶段自检清单

在继续学习第八阶段之前，请确保你能：

- [ ] 区分可迭代对象和迭代器，并能手写自定义迭代器
- [ ] 解释 `__iter__` 和 `__next__` 的作用
- [ ] 使用生成器的 `send()`、`throw()`、`close()` 方法
- [ ] 手写带参数的装饰器、类装饰器，并理解装饰器叠加顺序
- [ ] 使用 `functools.lru_cache` 进行函数结果缓存
- [ ] 使用 `@contextmanager` 编写自定义上下文管理器
- [ ] 区分 `__getattr__` 和 `__getattribute__`，并能正确使用
- [ ] 理解元类的作用，能用 `__init_subclass__` 替代常见场景
- [ ] 使用 `async`/`await` 编写异步代码，理解事件循环
- [ ] 使用 `typing` 模块进行类型注解（Protocol、TypedDict、泛型）
- [ ] 使用 `functools.partial`、`reduce`、`cached_property` 等工具
- [ ] 使用 `functools.singledispatch` 实现多类型分发
- [ ] 使用 `contextvars` 在异步代码中传递上下文

---

## 10. 异步编程实战进阶

### 10.1 异步 Web 服务器（aiohttp）

```python
import asyncio
from aiohttp import web
import aiohttp

async def handle(request):
    """异步 HTTP 处理器。"""
    user_id = request.match_info.get('id', 'anonymous')
    # 模拟异步数据库查询
    await asyncio.sleep(0.1)
    return web.json_response({
        'user_id': user_id,
        'status': 'active'
    })

async def fetch_external_api(request):
    """异步调用外部 API。"""
    async with aiohttp.ClientSession() as session:
        async with session.get('https://api.github.com/users/octocat') as resp:
            data = await resp.json()
            return web.json_response(data)

async def background_task(app):
    """后台任务：定期清理缓存。"""
    while True:
        await asyncio.sleep(60)  # 每分钟执行一次
        print("清理缓存...")

app = web.Application()
app.router.add_get('/users/{id}', handle)
app.router.add_get('/github', fetch_external_api)

# 启动后台任务
async def on_startup(app):
    app['task'] = asyncio.create_task(background_task(app))

async def on_cleanup(app):
    app['task'].cancel()
    try:
        await app['task']
    except asyncio.CancelledError:
        pass

app.on_startup.append(on_startup)
app.on_cleanup.append(on_cleanup)

# 运行：python -m aiohttp.web -H localhost -P 8080 app:app
```

### 10.2 异步数据库连接池

```python
import asyncio
import asyncpg  # PostgreSQL 异步驱动

class AsyncDatabasePool:
    """异步数据库连接池。"""

    def __init__(self, db_url, min_size=5, max_size=10):
        self.db_url = db_url
        self.min_size = min_size
        self.max_size = max_size
        self.pool = None

    async def connect(self):
        """建立连接池。"""
        self.pool = await asyncpg.create_pool(
            self.db_url,
            min_size=self.min_size,
            max_size=self.max_size
        )

    async def close(self):
        """关闭连接池。"""
        if self.pool:
            await self.pool.close()

    async def execute(self, query, *args):
        """执行查询。"""
        async with self.pool.acquire() as conn:
            return await conn.execute(query, *args)

    async def fetch(self, query, *args):
        """获取多行。"""
        async with self.pool.acquire() as conn:
            return await conn.fetch(query, *args)

    async def fetchrow(self, query, *args):
        """获取单行。"""
        async with self.pool.acquire() as conn:
            return await conn.fetchrow(query, *args)

# 使用
async def main():
    db = AsyncDatabasePool("postgresql://user:pass@localhost/db")
    await db.connect()

    # 并发查询
    users = await db.fetch("SELECT * FROM users WHERE age > $1", 18)
    for user in users:
        print(user['name'])

    await db.close()

# asyncio.run(main())
```

### 10.3 异步生产者-消费者模式

```python
import asyncio
from collections import deque

class AsyncQueue:
    """异步队列：支持生产者-消费者模式。"""

    def __init__(self, maxsize=10):
        self._queue = deque()
        self._maxsize = maxsize
        self._not_empty = asyncio.Event()
        self._not_full = asyncio.Event()
        self._not_full.set()

    async def put(self, item):
        """生产者：添加元素。"""
        await self._not_full.wait()
        self._queue.append(item)
        self._not_empty.set()
        if len(self._queue) >= self._maxsize:
            self._not_full.clear()

    async def get(self):
        """消费者：获取元素。"""
        await self._not_empty.wait()
        item = self._queue.popleft()
        self._not_full.set()
        if not self._queue:
            self._not_empty.clear()
        return item

    def qsize(self):
        return len(self._queue)

async def producer(queue, producer_id):
    """生产者协程。"""
    for i in range(5):
        item = f"商品-{producer_id}-{i}"
        await queue.put(item)
        print(f"[生产者 {producer_id}] 生产: {item}, 队列大小: {queue.qsize()}")
        await asyncio.sleep(0.5)

async def consumer(queue, consumer_id):
    """消费者协程。"""
    while True:
        item = await queue.get()
        print(f"[消费者 {consumer_id}] 消费: {item}, 队列大小: {queue.qsize()}")
        await asyncio.sleep(1)  # 模拟处理时间

async def main():
    queue = AsyncQueue(maxsize=5)

    # 启动 2 个生产者和 3 个消费者
    producers = [asyncio.create_task(producer(queue, i)) for i in range(2)]
    consumers = [asyncio.create_task(consumer(queue, i)) for i in range(3)]

    # 等待所有生产者完成
    await asyncio.gather(*producers)

    # 取消消费者（实际应用中应有更优雅的退出机制）
    for c in consumers:
        c.cancel()

# asyncio.run(main())
```

**生产者-消费者流程图**：

```
┌─────────────────────────────────────────────────────────┐
│              异步生产者-消费者模型                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  生产者协程                                              │
│    │                                                    │
│    ├── asyncio.create_task(producer(queue, id))          │
│    │    └── await queue.put(item)                        │
│    │        └── 队列未满：添加元素，通知消费者             │
│    │        └── 队列已满：等待 not_full 事件              │
│    │                                                    │
│  异步队列 (AsyncQueue)                                   │
│    │                                                    │
│    ├── put(): 生产者添加元素                             │
│    ├── get(): 消费者获取元素                             │
│    ├── _not_empty: 有元素时通知消费者                    │
│    └── _not_full: 有空间时通知生产者                     │
│                                                         │
│  消费者协程                                              │
│    │                                                    │
│    ├── asyncio.create_task(consumer(queue, id))          │
│    │    └── item = await queue.get()                     │
│    │        └── 队列非空：获取元素，通知生产者             │
│    │        └── 队列为空：等待 not_empty 事件             │
│                                                         │
│  优势：                                                  │
│    - 生产者不会阻塞消费者                                 │
│    - 背压控制：队列满时生产者等待                         │
│    - 协程切换开销远小于线程                               │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 10.4 异步超时与重试

```python
import asyncio
import functools

def async_retry(max_attempts=3, delay=1, exceptions=(Exception,)):
    """异步重试装饰器。"""
    def decorator(func):
        @functools.wraps(func)
        async def wrapper(*args, **kwargs):
            last_exception = None
            for attempt in range(1, max_attempts + 1):
                try:
                    return await func(*args, **kwargs)
                except exceptions as e:
                    last_exception = e
                    if attempt < max_attempts:
                        await asyncio.sleep(delay)
                        print(f"重试 {attempt}/{max_attempts}: {e}")
            raise last_exception
        return wrapper
    return decorator

async def fetch_with_timeout(url, timeout=5):
    """带超时的异步请求。"""
    try:
        async with asyncio.timeout(timeout):
            async with aiohttp.ClientSession() as session:
                async with session.get(url) as resp:
                    return await resp.json()
    except asyncio.TimeoutError:
        print(f"请求超时: {url}")
        return None

@async_retry(max_attempts=3, delay=1, exceptions=(ConnectionError,))
async def fetch_unstable_data(url):
    """模拟不稳定的异步请求。"""
    import random
    if random.random() < 0.7:
        raise ConnectionError(f"请求失败: {url}")
    return {"status": "ok", "data": []}

async def main():
    # 超时控制
    data = await fetch_with_timeout("https://api.github.com", timeout=3)

    # 重试机制
    for i in range(5):
        try:
            result = await fetch_unstable_data(f"https://api.example.com/{i}")
            print(result)
            break
        except Exception as e:
            print(f"最终失败: {e}")

# asyncio.run(main())
```

---

## 11. 工作实战场景

### 11.1 场景一：异步爬虫框架

```python
import asyncio
import aiohttp
from urllib.parse import urljoin, urlparse
from collections import deque
import re

class AsyncCrawler:
    """异步网页爬虫。"""

    def __init__(self, max_concurrent=10, max_depth=3):
        self.max_concurrent = max_concurrent
        self.max_depth = max_depth
        self.visited = set()
        self.results = []
        self.semaphore = asyncio.Semaphore(max_concurrent)

    async def fetch(self, session, url):
        """带并发限制的异步请求。"""
        async with self.semaphore:
            try:
                async with session.get(url, timeout=aiohttp.ClientTimeout(total=10)) as resp:
                    if resp.status == 200:
                        return await resp.text()
            except Exception as e:
                print(f"抓取失败: {url}, 错误: {e}")
                return None

    def extract_links(self, html, base_url):
        """提取页面中的链接。"""
        if not html:
            return []
        link_pattern = re.compile(r'href=["\'](https?://[^"\']+)["\']')
        links = link_pattern.findall(html)
        # 过滤同域名链接
        base_domain = urlparse(base_url).netloc
        return [link for link in links if urlparse(link).netloc == base_domain]

    async def crawl_page(self, session, url, depth):
        """爬取单个页面。"""
        if depth > self.max_depth or url in self.visited:
            return

        self.visited.add(url)
        print(f"[深度 {depth}] 爬取: {url}")

        html = await self.fetch(session, url)
        if html:
            self.results.append({
                'url': url,
                'depth': depth,
                'size': len(html)
            })

            # 提取并递归爬取链接
            links = self.extract_links(html, url)
            tasks = []
            for link in links[:10]:  # 限制每页爬取的链接数
                if link not in self.visited:
                    tasks.append(self.crawl_page(session, link, depth + 1))

            if tasks:
                await asyncio.gather(*tasks, return_exceptions=True)

    async def run(self, start_url):
        """启动爬虫。"""
        async with aiohttp.ClientSession() as session:
            await self.crawl_page(session, start_url, 1)

        print(f"\n爬取完成！共访问 {len(self.visited)} 个页面")
        return self.results

# 使用
async def main():
    crawler = AsyncCrawler(max_concurrent=5, max_depth=2)
    results = await crawler.run("https://example.com")
    for r in results[:10]:
        print(f"URL: {r['url']}, 大小: {r['size']} 字节")

# asyncio.run(main())
```

### 11.2 场景二：异步任务调度器

```python
import asyncio
from datetime import datetime
from typing import Callable, Dict, List

class AsyncTaskScheduler:
    """异步任务调度器：支持定时任务、依赖管理。"""

    def __init__(self):
        self.tasks: Dict[str, Callable] = {}
        self.dependencies: Dict[str, List[str]] = {}
        self.schedule: Dict[str, float] = {}  # task_name: interval_seconds

    def register(self, name: str, interval: float = None, depends_on: List[str] = None):
        """注册异步任务。"""
        def decorator(func):
            self.tasks[name] = func
            if interval:
                self.schedule[name] = interval
            if depends_on:
                self.dependencies[name] = depends_on
            return func
        return decorator

    async def _run_with_dependencies(self, task_name: str):
        """按依赖顺序执行任务。"""
        # 先执行依赖的任务
        if task_name in self.dependencies:
            for dep in self.dependencies[task_name]:
                await self._run_with_dependencies(dep)

        # 执行当前任务
        if task_name in self.tasks:
            print(f"[{datetime.now()}] 执行任务: {task_name}")
            await self.tasks[task_name]()

    async def run_once(self):
        """执行所有任务一次（按依赖顺序）。"""
        # 拓扑排序
        executed = set()

        async def execute(task_name):
            if task_name in executed:
                return
            if task_name in self.dependencies:
                for dep in self.dependencies[task_name]:
                    await execute(dep)
            await self._run_with_dependencies(task_name)
            executed.add(task_name)

        for task_name in self.tasks:
            await execute(task_name)

    async def run_scheduled(self):
        """运行定时任务。"""
        jobs = []
        for task_name, interval in self.schedule.items():
            async def periodic_task():
                while True:
                    await self._run_with_dependencies(task_name)
                    await asyncio.sleep(interval)
            jobs.append(periodic_task())

        await asyncio.gather(*jobs)

# 使用示例
scheduler = AsyncTaskScheduler()

@scheduler.register(name="fetch_data", interval=5)
async def fetch_data():
    """每 5 秒获取数据。"""
    print("获取数据...")

@scheduler.register(name="process_data", depends_on=["fetch_data"])
async def process_data():
    """处理数据（依赖 fetch_data）。"""
    print("处理数据...")

@scheduler.register(name="save_data", depends_on=["process_data"], interval=10)
async def save_data():
    """每 10 秒保存数据。"""
    print("保存数据...")

async def main():
    # 执行一次
    await scheduler.run_once()

    # 启动定时任务
    # await scheduler.run_scheduled()

# asyncio.run(main())
```

### 11.3 场景三：装饰器实现缓存与权限控制

```python
import functools
import time
from typing import Callable, Any
import hashlib
import json

# 1. 异步缓存装饰器
def async_cache(expire_seconds=60):
    """异步函数缓存装饰器。"""
    cache = {}

    def decorator(func):
        @functools.wraps(func)
        async def wrapper(*args, **kwargs):
            # 生成缓存键
            key_parts = (func.__name__, args, tuple(sorted(kwargs.items())))
            cache_key = hashlib.md5(str(key_parts).encode()).hexdigest()

            # 检查缓存
            if cache_key in cache:
                data, timestamp = cache[cache_key]
                if time.time() - timestamp < expire_seconds:
                    print(f"[缓存命中] {func.__name__}")
                    return data

            # 执行函数
            result = await func(*args, **kwargs)
            cache[cache_key] = (result, time.time())
            return result

        wrapper.cache = cache
        return wrapper
    return decorator

# 2. 权限检查装饰器
def require_permission(permission: str):
    """权限检查装饰器。"""
    def decorator(func):
        @functools.wraps(func)
        async def wrapper(user, *args, **kwargs):
            if permission not in user.get('permissions', []):
                raise PermissionError(f"用户缺少权限: {permission}")
            return await func(user, *args, **kwargs)
        return wrapper
    return decorator

# 3. 日志记录装饰器
def log_execution(logger=None):
    """执行日志装饰器。"""
    def decorator(func):
        @functools.wraps(func)
        async def wrapper(*args, **kwargs):
            start_time = time.time()
            func_name = func.__name__

            print(f"[开始] {func_name}, 参数: args={args}, kwargs={kwargs}")
            try:
                result = await func(*args, **kwargs)
                elapsed = time.time() - start_time
                print(f"[完成] {func_name}, 耗时: {elapsed:.3f}s")
                return result
            except Exception as e:
                elapsed = time.time() - start_time
                print(f"[错误] {func_name}, 耗时: {elapsed:.3f}s, 错误: {e}")
                raise
        return wrapper
    return decorator

# 综合应用
@log_execution()
@require_permission('admin')
@async_cache(expire_seconds=30)
async def get_user_stats(user, user_id):
    """获取用户统计信息（需要 admin 权限，缓存 30 秒）。"""
    await asyncio.sleep(1)  # 模拟数据库查询
    return {
        'user_id': user_id,
        'posts': 42,
        'followers': 128
    }

async def main():
    admin_user = {'id': 1, 'name': 'Alice', 'permissions': ['admin', 'write']}
    normal_user = {'id': 2, 'name': 'Bob', 'permissions': ['read']}

    # 有权限的用户
    stats1 = await get_user_stats(admin_user, 1)
    print(f"统计信息: {stats1}")

    # 缓存命中
    stats2 = await get_user_stats(admin_user, 1)
    print(f"统计信息（缓存）: {stats2}")

    # 无权限用户
    try:
        stats3 = await get_user_stats(normal_user, 1)
    except PermissionError as e:
        print(f"权限错误: {e}")

# asyncio.run(main())
```

---

## 12. 常见面试题汇总

### 12.1 生成器与迭代器

**Q1: 解释 `yield` 和 `yield from` 的区别。**

```python
# yield: 暂停函数并返回值
def simple_gen():
    yield 1
    yield 2

# yield from: 委托给另一个生成器（Python 3.3+）
def sub_gen():
    yield 1
    yield 2

def main_gen():
    yield from sub_gen()  # 透传子生成器的所有值
    yield 3

# 对比
list(simple_gen())   # [1, 2]
list(main_gen())     # [1, 2, 3]
```

**关键点**：
- `yield` 直接返回值
- `yield from` 建立生成器之间的双向通道，支持 `send()`、`throw()`、`close()` 的透传
- 用于重构嵌套生成器，避免手动 `for` 循环

---

**Q2: 如何用生成器实现无限序列？**

```python
def fibonacci():
    """无限斐波那契数列。"""
    a, b = 0, 1
    while True:
        yield a
        a, b = b, a + b

# 使用 itertools.islice 取前 N 个
from itertools import islice
fib = fibonacci()
first_10 = list(islice(fib, 10))
print(first_10)  # [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]

# 优势：内存占用恒定，无论取多少个
```

---

**Q3: 迭代器和可迭代对象的区别？**

| 特性 | 可迭代对象 (Iterable) | 迭代器 (Iterator) |
|------|----------------------|------------------|
| 协议 | 实现 `__iter__()` | 实现 `__iter__()` + `__next__()` |
| 示例 | `list`, `str`, `dict` | `iter([1,2,3])` 的返回值 |
| 遍历次数 | 可多次遍历 | 只能遍历一次 |
| 内存 | 存储所有元素 | 惰性计算，不存储 |

```python
# 验证
from collections.abc import Iterable, Iterator

lst = [1, 2, 3]
print(isinstance(lst, Iterable))    # True
print(isinstance(lst, Iterator))     # False

it = iter(lst)
print(isinstance(it, Iterator))      # True
```

---

### 12.2 装饰器

**Q4: 编写一个可以统计函数执行次数的装饰器。**

```python
import functools

def count_calls(func):
    """统计函数调用次数。"""
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        wrapper.call_count += 1
        print(f"调用 {func.__name__} 第 {wrapper.call_count} 次")
        return func(*args, **kwargs)

    wrapper.call_count = 0
    return wrapper

@count_calls
def say_hello(name):
    print(f"Hello, {name}!")

say_hello("Alice")  # 调用 say_hello 第 1 次
say_hello("Bob")    # 调用 say_hello 第 2 次
print(f"总调用次数: {say_hello.call_count}")  # 总调用次数: 2
```

---

**Q5: 装饰器的叠加顺序是什么？**

```python
@decorator_a
@decorator_b
@decorator_c
def my_func():
    pass

# 等价于：
my_func = decorator_a(decorator_b(decorator_c(my_func)))

# 定义阶段：从下到上（decorator_c → decorator_b → decorator_a）
# 调用阶段：从外到内（wrapper_a → wrapper_b → wrapper_c → 原函数）
```

**记忆技巧**：就像穿衣服，里面的先穿（定义时），外面的先脱（调用时）。

---

**Q6: 如何实现带可选参数的装饰器？**

```python
import functools

def timer(_func=None, *, precision=4):
    """可以 @timer 或 @timer(precision=2) 使用。"""
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            start = time.time()
            result = func(*args, **kwargs)
            elapsed = time.time() - start
            print(f"{func.__name__} 耗时: {elapsed:.{precision}f}s")
            return result
        return wrapper

    # 如果直接 @timer，_func 是被装饰的函数
    if _func is None:
        return decorator
    else:
        return decorator(_func)

@timer
def slow_function():
    time.sleep(0.1)

@timer(precision=2)
def fast_function():
    time.sleep(0.05)
```

---

### 12.3 上下文管理器

**Q7: `@contextmanager` 的工作原理？**

```python
from contextlib import contextmanager

@contextmanager
def managed_file(name):
    f = open(name, 'w')
    try:
        yield f
    finally:
        f.close()

# 等价于：
class ManagedFile:
    def __init__(self, name):
        self.name = name
        self.file = None

    def __enter__(self):
        self.file = open(self.name, 'w')
        return self.file

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.file:
            self.file.close()
```

**关键点**：
- `yield` 之前的代码对应 `__enter__`
- `yield` 之后的代码对应 `__exit__`
- `finally` 块确保清理代码一定执行

---

### 12.4 元类与描述符

**Q8: 元类的主要用途？**

```python
# 1. 自动注册子类
class PluginBase(type):
    registry = {}

    def __new__(mcs, name, bases, namespace):
        cls = super().__new__(mcs, name, bases, namespace)
        if name != 'BasePlugin':
            mcs.registry[name] = cls
        return cls

class BasePlugin(metaclass=PluginBase):
    pass

class ImagePlugin(BasePlugin):
    pass

print(PluginBase.registry)  # {'ImagePlugin': <class 'ImagePlugin'>}

# 2. 自动添加方法
class AddMethodMeta(type):
    def __new__(mcs, name, bases, namespace):
        cls = super().__new__(mcs, name, bases, namespace)
        def hello(self):
            return f"Hello from {self.__class__.__name__}"
        cls.hello = hello
        return cls

class MyClass(metaclass=AddMethodMeta):
    pass

obj = MyClass()
print(obj.hello())  # Hello from MyClass
```

---

**Q9: 描述符与 `@property` 的关系？**

```python
# @property 本质是描述符
class Person:
    def __init__(self, name):
        self._name = name

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        if not isinstance(value, str):
            raise TypeError("name must be str")
        self._name = value

# 等价的描述符实现
class NameDescriptor:
    def __get__(self, instance, owner):
        if instance is None:
            return self
        return instance._name

    def __set__(self, instance, value):
        if not isinstance(value, str):
            raise TypeError("name must be str")
        instance._name = value

class Person:
    name = NameDescriptor()

    def __init__(self, name):
        self._name = name
```

---

### 12.5 异步编程

**Q10: `asyncio.sleep()` 与 `time.sleep()` 的区别？**

```python
import asyncio
import time

async def test_sync_sleep():
    """同步睡眠：阻塞整个线程。"""
    time.sleep(1)
    print("同步睡眠完成")

async def test_async_sleep():
    """异步睡眠：不阻塞线程，允许其他协程运行。"""
    await asyncio.sleep(1)
    print("异步睡眠完成")

async def main():
    # 同步：串行执行，总耗时 2s
    start = time.time()
    await test_sync_sleep()
    await test_sync_sleep()
    print(f"同步总耗时: {time.time() - start:.2f}s")

    # 异步：并发执行，总耗时约 1s
    start = time.time()
    await asyncio.gather(test_async_sleep(), test_async_sleep())
    print(f"异步总耗时: {time.time() - start:.2f}s")

# asyncio.run(main())
```

**关键区别**：
- `time.sleep()`: 阻塞整个线程，期间不能执行任何代码
- `asyncio.sleep()`: 非阻塞，让出控制权，其他协程可运行

---

**Q11: 何时使用异步编程？**

**适用场景**：
- I/O 密集型任务（网络请求、数据库查询、文件读写）
- 高并发 Web 服务器（FastAPI、Sanic）
- 网络爬虫、聊天应用

**不适用场景**：
- CPU 密集型任务（计算密集型算法）
- 需要多进程处理的任务
- 依赖大量同步库的项目

```python
# 判断依据：任务是否大部分时间在"等待"
async def io_task():
    await asyncio.sleep(1)  # 等待 I/O，异步有优势
    # ...

def cpu_task():
    # 计算 1e8 次循环
    for i in range(10**8):
        pass
    # 异步无优势，应考虑多进程
```

---

### 12.6 类型系统

**Q12: `Protocol` 与抽象基类 (ABC) 的区别？**

```python
from abc import ABC, abstractmethod
from typing import Protocol

# 方式1: 抽象基类（需要显式继承）
class DrawableABC(ABC):
    @abstractmethod
    def draw(self) -> None:
        pass

class CircleABC(DrawableABC):
    def draw(self) -> None:
        print("画圆")

# 方式2: Protocol（结构子类型，无需继承）
class DrawableProtocol(Protocol):
    def draw(self) -> None:
        ...

class CircleProtocol:
    # 没有继承，但满足协议
    def draw(self) -> None:
        print("画圆")

# Protocol 更灵活：第三方类无需修改即可适配
# ABC 更严格：强制子类关系，运行时可检查
```

---

## 13. 实战项目：异步 Web 爬虫 + 数据处理管道

### 13.1 项目概述

**目标**：构建一个异步爬虫系统，爬取多个网站，提取数据，并通过装饰器实现缓存、日志、重试等功能。

**技术栈**：
- `asyncio`: 异步协程
- `aiohttp`: 异步 HTTP 客户端
- `asyncpg`: 异步数据库驱动
- 装饰器：缓存、重试、日志
- 生成器：数据流管道

### 13.2 核心代码

```python
import asyncio
import aiohttp
import functools
import time
import hashlib
import json
from typing import AsyncGenerator, Dict, List
from dataclasses import dataclass

# ============ 装饰器部分 ============

def async_cache(expire_seconds=60):
    """异步缓存装饰器。"""
    cache = {}

    def decorator(func):
        @functools.wraps(func)
        async def wrapper(*args, **kwargs):
            key_parts = (func.__name__, args, tuple(sorted(kwargs.items())))
            cache_key = hashlib.md5(str(key_parts).encode()).hexdigest()

            if cache_key in cache:
                data, timestamp = cache[cache_key]
                if time.time() - timestamp < expire_seconds:
                    print(f"[缓存命中] {func.__name__}")
                    return data

            result = await func(*args, **kwargs)
            cache[cache_key] = (result, time.time())
            return result

        wrapper.cache = cache
        return wrapper
    return decorator

def async_retry(max_attempts=3, delay=1, exceptions=(Exception,)):
    """异步重试装饰器。"""
    def decorator(func):
        @functools.wraps(func)
        async def wrapper(*args, **kwargs):
            last_exception = None
            for attempt in range(1, max_attempts + 1):
                try:
                    return await func(*args, **kwargs)
                except exceptions as e:
                    last_exception = e
                    if attempt < max_attempts:
                        await asyncio.sleep(delay)
                        print(f"[重试 {attempt}/{max_attempts}] {func.__name__}: {e}")
            raise last_exception
        return wrapper
    return decorator

def async_timer(func):
    """异步计时装饰器。"""
    @functools.wraps(func)
    async def wrapper(*args, **kwargs):
        start = time.time()
        result = await func(*args, **kwargs)
        elapsed = time.time() - start
        print(f"[计时] {func.__name__} 耗时: {elapsed:.3f}s")
        return result
    return wrapper

# ============ 数据模型 ============

@dataclass
class Article:
    title: str
    url: str
    content: str
    published_at: str
    source: str

# ============ 核心爬虫类 ============

class AsyncNewsCrawler:
    """异步新闻爬虫。"""

    def __init__(self, max_concurrent=10):
        self.max_concurrent = max_concurrent
        self.semaphore = asyncio.Semaphore(max_concurrent)
        self.session = None

    async def __aenter__(self):
        self.session = aiohttp.ClientSession()
        return self

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        if self.session:
            await self.session.close()

    @async_cache(expire_seconds=300)
    @async_retry(max_attempts=3, delay=1, exceptions=(aiohttp.ClientError,))
    @async_timer
    async def fetch_page(self, url: str) -> str:
        """获取页面内容（带缓存、重试、计时）。"""
        async with self.semaphore:
            async with self.session.get(url, timeout=aiohttp.ClientTimeout(total=10)) as resp:
                return await resp.text()

    async def parse_articles(self, html: str, source: str) -> List[Article]:
        """解析文章列表（简化版，实际应使用 BeautifulSoup）。"""
        import re
        articles = []

        # 模拟解析
        title_pattern = re.compile(r'<h[12][^>]*>([^<]+)</h[12]>')
        titles = title_pattern.findall(html)

        for i, title in enumerate(titles[:10]):
            articles.append(Article(
                title=title.strip(),
                url=f"{source}/article/{i}",
                content=f"内容 {i}",
                published_at="2026-01-01",
                source=source
            ))

        return articles

    async def crawl_source(self, base_url: str) -> List[Article]:
        """爬取单个来源。"""
        html = await self.fetch_page(base_url)
        articles = await self.parse_articles(html, base_url)
        print(f"[{base_url}] 获取 {len(articles)} 篇文章")
        return articles

# ============ 数据处理管道（生成器） ============

async def article_pipeline(articles: List[Article]) -> AsyncGenerator[Dict, None]:
    """异步生成器：处理文章数据流。"""
    for article in articles:
        # 数据清洗
        article.title = article.title.strip()
        article.content = article.content.replace('\n', ' ')

        # 转换为字典
        yield {
            'title': article.title,
            'url': article.url,
            'content': article.content[:200],  # 截取前 200 字符
            'published_at': article.published_at,
            'source': article.source
        }

async def filter_keywords(data_stream: AsyncGenerator, keywords: List[str]):
    """过滤生成器：只保留包含关键词的文章。"""
    async for article in data_stream:
        if any(kw.lower() in article['title'].lower() for kw in keywords):
            yield article

async def save_to_json(data_stream: AsyncGenerator, output_file: str):
    """保存生成器：写入 JSON 文件。"""
    articles = []
    async for article in data_stream:
        articles.append(article)

    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(articles, f, ensure_ascii=False, indent=2)

    print(f"[保存] 写入 {len(articles)} 篇文章到 {output_file}")

# ============ 主流程 ============

async def main():
    sources = [
        "https://news.ycombinator.com",
        "https://www.reddit.com/r/programming",
    ]

    all_articles = []

    # 爬取多个来源
    async with AsyncNewsCrawler(max_concurrent=5) as crawler:
        tasks = [crawler.crawl_source(url) for url in sources]
        results = await asyncio.gather(*tasks, return_exceptions=True)

        for result in results:
            if isinstance(result, Exception):
                print(f"爬取失败: {result}")
            else:
                all_articles.extend(result)

    print(f"\n总共获取 {len(all_articles)} 篇文章")

    # 数据处理管道
    pipeline = article_pipeline(all_articles)
    filtered = filter_keywords(pipeline, keywords=['Python', 'AI', 'Web'])
    await save_to_json(filtered, 'articles.json')

    # 统计耗时
    print("\n=== 性能统计 ===")
    print("爬虫缓存命中率:", sum(1 for _ in range(0)))
    print("总耗时:", time.time() - start_time)

if __name__ == '__main__':
    start_time = time.time()
    asyncio.run(main())
```

### 13.3 项目亮点

1. **综合运用高级特性**：
   - 装饰器：缓存、重试、计时
   - 异步协程：并发爬取、异步 I/O
   - 生成器：数据流管道
   - 上下文管理器：`async with` 管理连接
   - 类型注解：完整类型提示

2. **工程化实践**：
   - 并发控制（`Semaphore`）
   - 错误处理（`return_exceptions=True`）
   - 资源管理（`async with` 自动关闭）
   - 模块化设计（爬虫、管道分离）

3. **可扩展性**：
   - 添加新数据源：只需添加 URL
   - 添加新处理步骤：插入新的生成器
   - 调整并发数：修改 `max_concurrent`

---

> **工程师寄语**：Python 的高级特性不是炫技的工具，而是解决实际问题的利器。当你发现代码里有大量重复的模式时，停下来想一想：是不是可以用描述符、元类或装饰器来抽象？但记住——**不要过度工程化**。如果简单的代码能解决问题,就不要引入元类。

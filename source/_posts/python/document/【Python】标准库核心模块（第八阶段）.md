---
title: 【Python】标准库核心模块（第八阶段）
date: 2026-07-23 15:00:00
categories:
  - Python
tags:
  - Python
  - 教程
  - 标准库
  - collections
  - itertools
description: Python 标准库核心模块详解，按功能分类梳理常用库，建立"标准库优先"的工程思维。
cover: /images/cover.png
---

# 八、标准库核心模块（按功能分类）

> **阶段定位**：Python 的强大不仅在于语法，更在于丰富的标准库。"batteries included"意味着你不需要为常见任务去安装第三方包。本阶段按功能分类梳理核心标准库，帮你建立"标准库优先"的工程思维。

```
┌──────────────────────────────────────────────────────────────────┐
│                   Python 标准库知识图谱                           │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  文本处理                                                        │
│    ├── re（正则表达式）                                          │
│    ├── string（字符串常量）                                      │
│    └── textwrap（文本格式化）                                    │
│                                                                  │
│  数据结构                                                        │
│    ├── collections（namedtuple/deque/Counter/defaultdict等）     │
│    ├── heapq（堆队列）                                           │
│    └── bisect（二分查找）                                        │
│                                                                  │
│  函数式工具                                                      │
│    ├── functools（partial/reduce/lru_cache/wraps）              │
│    ├── itertools（无限迭代/组合生成/分组）                        │
│    └── operator（操作符函数化）                                   │
│                                                                  │
│  文件与路径                                                      │
│    ├── os（操作系统接口）                                        │
│    ├── os.path（路径操作）                                       │
│    ├── pathlib（面向对象路径）                                   │
│    └── shutil（高级文件操作）                                     │
│                                                                  │
│  网络与通信                                                      │
│    ├── urllib（HTTP客户端）                                      │
│    ├── socket（网络编程）                                        │
│    └── http（HTTP协议）                                          │
│                                                                  │
│  并发与异步                                                      │
│    ├── threading（线程）                                         │
│    ├── multiprocessing（进程）                                   │
│    ├── concurrent.futures（并发接口）                            │
│    └── asyncio（异步IO）                                         │
│                                                                  │
│  数据持久化                                                      │
│    ├── json（JSON序列化）                                        │
│    ├── pickle（对象序列化）                                      │
│    └── sqlite3（SQLite数据库）                                   │
│                                                                  │
│  时间与日期                                                      │
│    ├── datetime（日期时间处理）                                  │
│    ├── time（时间基础）                                          │
│    └── calendar（日历操作）                                      │
│                                                                  │
│  其他工具                                                        │
│    ├── logging（日志）                                           │
│    ├── argparse（命令行参数）                                     │
│    ├── configparser（配置文件）                                  │
│    └── hashlib（哈希算法）                                       │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## 1. 文本与字符串

### 1.1 `re` 正则表达式

正则表达式是处理文本的利器，用于模式匹配、查找、替换和分割。

```python
import re

# 基础匹配
text = "Email: alice@example.com, Phone: 138-1234-5678"

# search：查找第一个匹配
match = re.search(r"\w+@\w+\.\w+", text)
if match:
    print(match.group())   # alice@example.com
    print(match.span())    # (7, 24)

# findall：查找所有匹配
emails = re.findall(r"\w+@\w+\.\w+", text)
phones = re.findall(r"\d{3}-\d{4}-\d{4}", text)

# finditer：返回迭代器（节省内存）
for match in re.finditer(r"\d+", text):
    print(f"数字: {match.group()}, 位置: {match.span()}")

# sub：替换
redacted = re.sub(r"\w+@\w+\.\w+", "[EMAIL]", text)

# split：按模式分割
parts = re.split(r"[,;]\s*", "a, b; c, d")

# 编译正则（频繁使用时提升性能）
EMAIL_PATTERN = re.compile(r"^[\w.-]+@[\w.-]+\.\w+$")
print(EMAIL_PATTERN.match("test@example.com"))    # Match
print(EMAIL_PATTERN.match("invalid"))             # None

# 命名捕获组
pattern = re.compile(r"(?P<year>\d{4})-(?P<month>\d{2})-(?P<day>\d{2})")
match = pattern.match("2024-07-20")
print(match.groupdict())   # {'year': '2024', 'month': '07', 'day': '20'}
```

**常用正则模式速查**：

| 模式 | 含义 |
|------|------|
| `.` | 任意字符（除换行） |
| `\d` | 数字 `[0-9]` |
| `\w` | 单词字符 `[a-zA-Z0-9_]` |
| `\s` | 空白字符 |
| `*` | 0 次或多次 |
| `+` | 1 次或多次 |
| `?` | 0 次或 1 次 |
| `{n,m}` | n 到 m 次 |
| `^` / `$` | 字符串开头/结尾 |
| `()` | 捕获组 |
| `(?:...)` | 非捕获组 |
| `(?P<name>...)` | 命名捕获组 |
| `\b` | 单词边界 |

**正则表达式工作流程**：

```
文本输入 → 正则模式 → 匹配引擎 → 匹配结果/None
    │           │           │
    │           └→ 编译正则  │
    │                       │
    └───────────────────────┘
              重复使用
```

**工程实践建议**：
1. 复杂正则使用 `re.compile()` 编译后复用，提升性能
2. 使用命名捕获组 `(?P<name>...)` 让代码更易读
3. 正则表达式调试困难，尽量保持简洁
4. 对于简单模式，优先使用字符串方法（`str.startswith()`, `str.find()` 等）

### 1.2 `string` 与 `textwrap`

```python
import string
import textwrap

# string 常量
print(string.ascii_letters)   # abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
print(string.digits)          # 0123456789
print(string.punctuation)     # !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~

# textwrap：文本格式化
long_text = "这是一个非常长的段落，需要自动换行和缩进处理。"

# 自动换行
wrapped = textwrap.fill(long_text, width=20)
print(wrapped)

# 添加缩进
indented = textwrap.indent(long_text, "    ")
print(indented)

# 去除缩进
dedented = textwrap.dedent("""
    第一行
    第二行
    第三行
""")

# 截断文本
truncated = textwrap.shorten("这是一段很长的文本需要截断显示。", width=20)
```

**应用场景**：
- `string.digits` + `string.ascii_letters`：生成验证码
- `textwrap.fill()`：格式化日志输出
- `textwrap.dedent()`：去除多行字符串的公共缩进

---

## 2. 数据结构增强

### 2.1 `collections`

`collections` 模块提供了高性能的容器类型，是对内置数据结构的扩展。

```python
from collections import namedtuple, deque, Counter, OrderedDict, defaultdict, ChainMap

# namedtuple：轻量级不可变对象
Point = namedtuple("Point", ["x", "y"])
p = Point(3, 4)
print(p.x, p.y)           # 3 4
print(p._asdict())        # {'x': 3, 'y': 4}

# deque：双端队列（两端操作都是 O(1)）
dq = deque([1, 2, 3])
dq.append(4)              # 右端添加
dq.appendleft(0)          # 左端添加
dq.pop()                  # 右端弹出
dq.popleft()              # 左端弹出
dq.rotate(1)              # 旋转

# Counter：计数器
c = Counter(["a", "b", "a", "c", "a", "b"])
print(c)                  # Counter({'a': 3, 'b': 2, 'c': 1})
print(c.most_common(2))   # [('a', 3), ('b', 2)]

# 统计字符频率
char_count = Counter("mississippi")
print(char_count.most_common(3))

# defaultdict：带默认值的字典
word_groups = defaultdict(list)
for word in ["apple", "apricot", "banana", "blueberry"]:
    word_groups[word[0]].append(word)
print(dict(word_groups))   # {'a': ['apple', 'apricot'], 'b': ['banana', 'blueberry']}

# OrderedDict：有序字典（3.7+ 普通 dict 已有序，但 OrderedDict 有特殊方法）
od = OrderedDict([("a", 1), ("b", 2)])
od.move_to_end("a")       # 将 a 移到最后

# ChainMap：链式字典查找（不合并，只链接）
defaults = {"theme": "default", "language": "en"}
user_prefs = {"theme": "dark"}
combined = ChainMap(user_prefs, defaults)
print(combined["theme"])    # dark（从 user_prefs 找到）
print(combined["language"]) # en（从 defaults 找到）
```

**collections 各类型对比**：

| 类型 | 特点 | 适用场景 |
|------|------|----------|
| `namedtuple` | 不可变，字段可通过属性访问 | 轻量级数据结构、记录 |
| `deque` | 双端 O(1) 操作 | 队列、栈、滑动窗口 |
| `Counter` | 自动计数 | 词频统计、投票计数 |
| `defaultdict` | 访问不存在键自动创建默认值 | 分组聚合 |
| `OrderedDict` | 保持插入顺序，支持移动 | LRU 缓存、有序配置 |
| `ChainMap` | 链式查找，不复制 | 配置优先级、多字典合并 |

### 2.2 `heapq` 堆队列

堆是一种特殊的树形数据结构，最小堆的堆顶元素始终是最小的。

```python
import heapq

# 堆（最小堆）：快速获取最小/最大元素
nums = [5, 2, 8, 1, 9, 3]
heapq.heapify(nums)       # 原地转堆，O(n)
print(heapq.heappop(nums))  # 1（最小元素）
heapq.heappush(nums, 0)   # 添加元素，O(log n)

# 获取最大的 N 个元素（比排序后切片快）
largest = heapq.nlargest(3, [5, 2, 8, 1, 9, 3])
smallest = heapq.nsmallest(3, [5, 2, 8, 1, 9, 3])

# 实现优先队列
class PriorityQueue:
    def __init__(self):
        self._queue = []
        self._index = 0

    def push(self, item, priority):
        # (priority, index, item) 保证相同优先级按插入顺序排列
        heapq.heappush(self._queue, (priority, self._index, item))
        self._index += 1

    def pop(self):
        return heapq.heappop(self._queue)[-1]

# 使用优先队列
pq = PriorityQueue()
pq.push("task1", 2)
pq.push("task2", 1)
pq.push("task3", 1)
print(pq.pop())   # task2（优先级最高）
print(pq.pop())   # task3（同优先级，先插入的先出）
```

**堆操作时间复杂度**：

| 操作 | 时间复杂度 |
|------|------------|
| `heapify()` | O(n) |
| `heappush()` | O(log n) |
| `heappop()` | O(log n) |
| `nlargest(n)` | O(n log n) |
| `nsmallest(n)` | O(n log n) |

**应用场景**：
- 任务调度（优先队列）
- Top-K 问题（获取最大/最小的 N 个元素）
- 数据流中位数

### 2.3 `bisect` 二分查找

`bisect` 模块提供了在有序列表中进行二分查找和插入的功能。

```python
import bisect

# 维护有序列表
sorted_list = [1, 3, 5, 7, 9]

# 查找插入位置
pos = bisect.bisect_left(sorted_list, 6)   # 3（在 5 后面）
pos = bisect.bisect_right(sorted_list, 5)  # 3（在 5 后面）

# 插入并保持有序
bisect.insort(sorted_list, 6)   # [1, 3, 5, 6, 7, 9]

# 查找元素是否存在
idx = bisect.bisect_left(sorted_list, 7)
if idx < len(sorted_list) and sorted_list[idx] == 7:
    print("找到 7")

# 二分查找实现
def binary_search(arr, target):
    left, right = 0, len(arr) - 1
    while left <= right:
        mid = (left + right) // 2
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    return -1
```

**bisect 函数对比**：

| 函数 | 行为 | 返回值含义 |
|------|------|------------|
| `bisect_left()` | 查找第一个大于等于 target 的位置 | 插入位置（左侧） |
| `bisect_right()` | 查找第一个大于 target 的位置 | 插入位置（右侧） |
| `insort_left()` | 在 bisect_left 位置插入 | 无 |
| `insort_right()` | 在 bisect_right 位置插入 | 无 |

**应用场景**：
- 维护有序数据结构
- 区间查询
- 时间序列数据查找

---

## 3. 函数式工具

### 3.1 `functools`

```python
from functools import partial, reduce, lru_cache, wraps, cmp_to_key, total_ordering

# partial：固定部分参数
base_two = partial(int, base=2)
print(base_two("1010"))   # 10

# lru_cache：最近最少使用缓存
@lru_cache(maxsize=128)
def fibonacci(n):
    if n < 2:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)

# total_ordering：自动生成比较方法
@total_ordering
class Version:
    def __init__(self, major, minor, patch):
        self.version = (major, minor, patch)
    def __eq__(self, other):
        return self.version == other.version
    def __lt__(self, other):
        return self.version < other.version

# cmp_to_key：将比较函数转为 key 函数
def compare_length(a, b):
    return len(a) - len(b)

words = ["apple", "pie", "banana"]
words.sort(key=cmp_to_key(compare_length))

# wraps：保留原函数元信息
def my_decorator(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        print("Before")
        result = func(*args, **kwargs)
        print("After")
        return result
    return wrapper
```

**functools 常用工具对比**：

| 工具 | 作用 | 场景 |
|------|------|------|
| `partial` | 固定函数部分参数 | 简化函数调用 |
| `reduce` | 累积操作 | 归约计算（求和、乘积等） |
| `lru_cache` | 函数结果缓存 | 避免重复计算 |
| `wraps` | 保留函数元信息 | 装饰器中使用 |
| `cmp_to_key` | 比较函数转 key | 自定义排序 |
| `total_ordering` | 自动生成比较方法 | 类定义 |

### 3.2 `itertools`

`itertools` 提供了高效的循环工具，用于创建各种迭代器。

```python
import itertools

# 无限迭代器
count = itertools.count(start=10, step=2)      # 10, 12, 14, ...
cycle = itertools.cycle(["A", "B", "C"])        # A, B, C, A, B, C, ...
repeat = itertools.repeat("X", 5)              # X, X, X, X, X

# 组合生成器
items = ["A", "B", "C"]
print(list(itertools.permutations(items, 2)))   # 排列：AB, AC, BA, BC, CA, CB
print(list(itertools.combinations(items, 2)))   # 组合：AB, AC, BC
print(list(itertools.combinations_with_replacement(items, 2)))

# 累积
cumulative = list(itertools.accumulate([1, 2, 3, 4, 5]))   # [1, 3, 6, 10, 15]

# 分组（注意：需要先排序）
data = [("A", 1), ("A", 2), ("B", 3), ("B", 4)]
sorted_data = sorted(data, key=lambda x: x[0])
for key, group in itertools.groupby(sorted_data, key=lambda x: x[0]):
    print(key, list(group))

# 链式迭代
combined = itertools.chain([1, 2], [3, 4], [5, 6])
print(list(combined))   # [1, 2, 3, 4, 5, 6]

# zip_longest：不等长序列
names = ["Alice", "Bob"]
ages = [30, 25, 35]
for name, age in itertools.zip_longest(names, ages, fillvalue="N/A"):
    print(name, age)

# islice：切片迭代器
nums = iter(range(10))
sliced = itertools.islice(nums, 2, 8, 2)   # 2, 4, 6

# tee：复制迭代器
it1, it2 = itertools.tee(range(5))
print(list(it1))   # [0, 1, 2, 3, 4]
print(list(it2))   # [0, 1, 2, 3, 4]
```

**itertools 分类速查**：

| 类别 | 函数 | 功能 |
|------|------|------|
| **无限迭代** | `count`, `cycle`, `repeat` | 生成无限序列 |
| **终止迭代** | `accumulate`, `chain`, `islice`, `tee` | 处理有限序列 |
| **组合生成** | `permutations`, `combinations`, `product` | 排列组合 |
| **分组筛选** | `groupby`, `filterfalse`, `compress` | 分组和过滤 |

### 3.3 `operator`

`operator` 模块提供了Python内置操作符的函数化版本。

```python
from operator import itemgetter, attrgetter, methodcaller, add, mul, lt, eq

# itemgetter：用于排序和取值
data = [{"name": "Alice", "age": 30}, {"name": "Bob", "age": 25}]
sorted_data = sorted(data, key=itemgetter("age"))

# 多个键排序
sorted_by_age_name = sorted(data, key=itemgetter("age", "name"))

# 批量取值
get_name = itemgetter("name")
print(list(map(get_name, data)))   # ['Alice', 'Bob']

# attrgetter：获取对象属性
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

people = [Person("Alice", 30), Person("Bob", 25)]
sorted_people = sorted(people, key=attrgetter("age"))

# methodcaller：调用方法
upper = methodcaller("upper")
print(upper("hello"))   # HELLO

# 指定参数调用
replace = methodcaller("replace", "l", "x")
print(replace("hello"))   # hexlo

# 算术操作符
print(add(3, 5))        # 8
print(mul(3, 5))        # 15
print(lt(3, 5))         # True
```

**operator 常用函数**：

| 类别 | 函数 | 对应操作 |
|------|------|----------|
| **算术** | `add`, `sub`, `mul`, `truediv`, `floordiv` | `+`, `-`, `*`, `/`, `//` |
| **比较** | `eq`, `ne`, `lt`, `le`, `gt`, `ge` | `==`, `!=`, `<`, `<=`, `>`, `>=` |
| **逻辑** | `not_`, `truth`, `is_`, `is_not` | `not`, `bool()`, `is`, `is not` |
| **序列** | `itemgetter`, `attrgetter`, `methodcaller` | 索引、属性、方法调用 |

---

## 4. 文件与路径

### 4.1 `os` 模块

```python
import os

# 目录操作
print(os.getcwd())           # 获取当前工作目录
os.chdir("/path/to/dir")     # 切换目录
os.makedirs("dir/subdir", exist_ok=True)  # 创建多级目录
os.rmdir("empty_dir")        # 删除空目录

# 文件操作
os.rename("old.txt", "new.txt")
os.remove("file.txt")

# 路径操作（建议使用 pathlib）
os.path.join("dir", "file.txt")
os.path.abspath("relative/path")
os.path.exists("path/to/file")
os.path.isfile("file.txt")
os.path.isdir("dir")
os.path.getsize("file.txt")

# 环境变量
print(os.environ.get("PATH"))
os.environ["MY_VAR"] = "value"

# 执行命令
result = os.system("ls -l")

# 遍历目录
for root, dirs, files in os.walk("directory"):
    for file in files:
        print(os.path.join(root, file))
```

### 4.2 `pathlib`（面向对象路径）

Python 3.4+ 引入的面向对象路径处理方式，比 `os.path` 更优雅。

```python
from pathlib import Path

# 创建路径对象
p = Path("docs") / "guide" / "readme.txt"
print(p)                    # docs/guide/readme.txt
print(p.resolve())          # 绝对路径
print(p.exists())           # 是否存在
print(p.is_file())          # 是否是文件
print(p.is_dir())           # 是否是目录

# 获取路径信息
print(p.name)               # readme.txt
print(p.stem)               # readme
print(p.suffix)             # .txt
print(p.parent)             # docs/guide
print(p.parents[0])         # docs/guide

# 创建目录
p.mkdir(parents=True, exist_ok=True)

# 读取文件（推荐使用 with 语句）
content = p.read_text(encoding="utf-8")

# 写入文件
p.write_text("Hello, World!", encoding="utf-8")

# 遍历目录
for item in Path(".").glob("**/*.py"):
    print(item)

# 路径比较
p1 = Path("docs/readme.txt")
p2 = Path("docs") / "readme.txt"
print(p1 == p2)             # True
```

**pathlib vs os.path**：

| 操作 | os.path | pathlib |
|------|---------|---------|
| 连接路径 | `os.path.join(a, b)` | `a / b` |
| 绝对路径 | `os.path.abspath(p)` | `p.resolve()` |
| 判断存在 | `os.path.exists(p)` | `p.exists()` |
| 读取文本 | `open(p).read()` | `p.read_text()` |
| 写入文本 | `open(p, 'w').write()` | `p.write_text()` |

### 4.3 `shutil`（高级文件操作）

```python
import shutil

# 复制文件
shutil.copy("src.txt", "dst.txt")
shutil.copy2("src.txt", "dst.txt")  # 保留元数据

# 复制目录（递归）
shutil.copytree("src_dir", "dst_dir", dirs_exist_ok=True)

# 移动文件/目录
shutil.move("src", "dst")

# 删除目录（递归）
shutil.rmtree("dir_to_delete")

# 文件压缩
shutil.make_archive("archive", "zip", "source_dir")

# 文件解压
shutil.unpack_archive("archive.zip", "target_dir")

# 获取磁盘使用情况
disk_usage = shutil.disk_usage("/")
print(f"总空间: {disk_usage.total / 1e9:.2f} GB")
print(f"已使用: {disk_usage.used / 1e9:.2f} GB")
print(f"可用空间: {disk_usage.free / 1e9:.2f} GB")
```

---

## 5. 网络与通信

### 5.1 `urllib`（HTTP 客户端）

```python
from urllib import request, parse, error

# 发送 GET 请求
response = request.urlopen("https://api.example.com/data")
data = response.read().decode("utf-8")

# 发送 POST 请求
data = {"key": "value"}
encoded_data = parse.urlencode(data).encode("utf-8")
response = request.urlopen("https://api.example.com/submit", data=encoded_data)

# 设置请求头
headers = {"User-Agent": "Mozilla/5.0"}
req = request.Request("https://example.com", headers=headers)
response = request.urlopen(req)

# 处理异常
try:
    response = request.urlopen("https://nonexistent.example.com")
except error.HTTPError as e:
    print(f"HTTP Error: {e.code}")
except error.URLError as e:
    print(f"URL Error: {e.reason}")

# 下载文件
request.urlretrieve("https://example.com/image.jpg", "local_image.jpg")
```

### 5.2 `http.server`（内置 Web 服务器）

```python
import http.server
import socketserver

# 启动简单 HTTP 服务器
PORT = 8000
Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Serving at port {PORT}")
    httpd.serve_forever()

# 命令行方式：python -m http.server 8000
```

---

## 6. 并发与异步

### 6.1 `threading`（线程）

```python
import threading
import time

def worker(name, delay):
    for i in range(5):
        print(f"{name}: {i}")
        time.sleep(delay)

# 创建线程
t1 = threading.Thread(target=worker, args=("Thread-1", 0.5))
t2 = threading.Thread(target=worker, args=("Thread-2", 0.5))

# 启动线程
t1.start()
t2.start()

# 等待线程结束
t1.join()
t2.join()

# 线程锁（防止竞态条件）
lock = threading.Lock()
shared_counter = 0

def increment():
    global shared_counter
    with lock:
        shared_counter += 1

# 线程本地存储
local_data = threading.local()
local_data.user_id = "123"
```

### 6.2 `multiprocessing`（进程）

```python
import multiprocessing

def worker(num):
    return num * num

# 创建进程池
with multiprocessing.Pool(processes=4) as pool:
    results = pool.map(worker, [1, 2, 3, 4, 5])
    print(results)   # [1, 4, 9, 16, 25]

# 进程间通信（Queue）
def producer(queue):
    for item in ["A", "B", "C"]:
        queue.put(item)

def consumer(queue):
    while True:
        item = queue.get()
        if item is None:
            break
        print(f"Consumed: {item}")

if __name__ == "__main__":
    queue = multiprocessing.Queue()
    p1 = multiprocessing.Process(target=producer, args=(queue,))
    p2 = multiprocessing.Process(target=consumer, args=(queue,))
    p1.start()
    p2.start()
    p1.join()
    queue.put(None)
    p2.join()
```

### 6.3 `concurrent.futures`（高级并发接口）

```python
from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor

# 线程池
with ThreadPoolExecutor(max_workers=4) as executor:
    future = executor.submit(worker, "task1")
    result = future.result()

    results = list(executor.map(worker, ["task1", "task2", "task3"]))

# 进程池（CPU 密集型任务）
with ProcessPoolExecutor(max_workers=4) as executor:
    results = executor.map(intensive_computation, data)

# 获取 Future 对象
futures = [executor.submit(task, arg) for arg in args]
for future in concurrent.futures.as_completed(futures):
    result = future.result()
```

---

## 7. 数据持久化

### 7.1 `json`（JSON 序列化）

```python
import json

# 序列化
data = {"name": "Alice", "age": 30, "hobbies": ["reading", "coding"]}
json_str = json.dumps(data, indent=2, ensure_ascii=False)

# 写入文件
with open("data.json", "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

# 反序列化
json_str = '{"name": "Alice", "age": 30}'
data = json.loads(json_str)

# 从文件读取
with open("data.json", "r", encoding="utf-8") as f:
    data = json.load(f)

# 自定义编码器
class PersonEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Person):
            return {"name": obj.name, "age": obj.age}
        return super().default(obj)

json.dumps(person, cls=PersonEncoder)
```

### 7.2 `pickle`（对象序列化）

```python
import pickle

# 序列化
data = {"name": "Alice", "age": 30}
pickled = pickle.dumps(data)

# 写入文件
with open("data.pkl", "wb") as f:
    pickle.dump(data, f)

# 反序列化
data = pickle.loads(pickled)

# 从文件读取
with open("data.pkl", "rb") as f:
    data = pickle.load(f)
```

**JSON vs Pickle**：

| 特性 | JSON | Pickle |
|------|------|--------|
| 可读性 | 人类可读 | 二进制格式 |
| 兼容性 | 跨语言 | 仅 Python |
| 支持类型 | 基础类型 | 几乎所有 Python 对象 |
| 安全性 | 安全 | 有安全风险（不要加载不可信数据） |
| 文件大小 | 较大 | 较小 |

### 7.3 `sqlite3`（轻量级数据库）

```python
import sqlite3

# 连接数据库（不存在则创建）
conn = sqlite3.connect("example.db")
cursor = conn.cursor()

# 创建表
cursor.execute("""
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER
    )
""")

# 插入数据
cursor.execute("INSERT INTO users (name, age) VALUES (?, ?)", ("Alice", 30))
conn.commit()

# 查询数据
cursor.execute("SELECT * FROM users")
rows = cursor.fetchall()
for row in rows:
    print(row)

# 参数化查询（防止 SQL 注入）
cursor.execute("SELECT * FROM users WHERE age > ?", (25,))

# 使用上下文管理器
with sqlite3.connect("example.db") as conn:
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users")

conn.close()
```

---

## 8. 时间与日期

### 8.1 `time` 模块

```python
import time

# 时间戳（秒）
now = time.time()
print(now)   # 1721430000.0

# 格式化时间
print(time.strftime("%Y-%m-%d %H:%M:%S"))   # 2024-07-20 10:30:00
print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()))

# 解析时间
parsed = time.strptime("2024-07-20", "%Y-%m-%d")
print(parsed)   # time.struct_time(tm_year=2024, ...)

# 睡眠
print("开始")
time.sleep(1)
print("1秒后")

# 性能计时
start = time.perf_counter()
# do_something()
elapsed = time.perf_counter() - start
```

### 8.2 `datetime` 模块（最常用）

```python
from datetime import datetime, date, time, timedelta, timezone
from zoneinfo import ZoneInfo   # 3.9+

# 当前时间
now = datetime.now()
utc_now = datetime.now(timezone.utc)

# 创建特定时间
dt = datetime(2024, 7, 20, 10, 30, 0)

# 格式化
print(dt.strftime("%Y-%m-%d %H:%M:%S"))
print(dt.isoformat())   # 2024-07-20T10:30:00

# 解析
parsed = datetime.fromisoformat("2024-07-20T10:30:00")

# 时间运算
future = dt + timedelta(days=7, hours=3)
diff = future - dt
print(diff.days)   # 7

# 时区处理（3.9+ 推荐）
nyc = ZoneInfo("America/New_York")
shanghai = ZoneInfo("Asia/Shanghai")

dt_shanghai = datetime(2024, 7, 20, 10, 30, tzinfo=shanghai)
dt_nyc = dt_shanghai.astimezone(nyc)
print(f"上海: {dt_shanghai}")
print(f"纽约: {dt_nyc}")

# 时间戳转换
timestamp = dt.timestamp()
print(datetime.fromtimestamp(timestamp))
```

**strftime 格式代码**：

| 代码 | 含义 | 示例 |
|------|------|------|
| `%Y` | 4 位年份 | 2024 |
| `%m` | 2 位月份 | 07 |
| `%d` | 2 位日期 | 20 |
| `%H` | 24 小时制 | 15 |
| `%M` | 分钟 | 30 |
| `%S` | 秒 | 00 |
| `%A` | 星期全称 | Saturday |
| `%a` | 星期缩写 | Sat |

### 8.3 `calendar`

```python
import calendar

# 打印月历
print(calendar.month(2024, 7))

# 判断闰年
print(calendar.isleap(2024))   # True

# 某月第一天是星期几，该月有多少天
first_weekday, days_in_month = calendar.monthrange(2024, 7)
print(f"7月有{days_in_month}天，第一天是星期{first_weekday}")
```

---

## 9. 数学与随机

### 9.1 `math` 与 `cmath`

```python
import math

print(math.sqrt(16))        # 4.0
print(math.pow(2, 10))      # 1024.0
print(math.log(100, 10))    # 2.0
print(math.log2(1024))      # 10.0
print(math.exp(1))          # 2.718...
print(math.factorial(5))    # 120
print(math.gcd(48, 18))     # 6
print(math.pi, math.e)      # 3.14159... 2.71828...
print(math.floor(3.7))      # 3
print(math.ceil(3.2))       # 4
print(math.trunc(3.9))      # 3

# 三角函数
print(math.sin(math.pi / 2))   # 1.0
print(math.degrees(math.pi))   # 180.0

# 双曲函数
print(math.sinh(1))   # 1.1752...

# 特殊函数
print(math.erf(1))    # 误差函数
print(math.gamma(5))  # 伽马函数
```

### 9.2 `random` 与 `secrets`

```python
import random
import secrets

# random：伪随机（可预测，不用于安全场景）
print(random.random())           # [0, 1) 浮点数
print(random.randint(1, 100))    # [1, 100] 整数
print(random.choice(["A", "B", "C"]))
print(random.choices(["A", "B", "C"], k=10, weights=[5, 3, 2]))
print(random.shuffle([1, 2, 3, 4, 5]))    # 原地打乱
print(random.sample([1, 2, 3, 4, 5], 3))  # 不重复抽样

# secrets：密码学安全的随机（用于 token、密码等）
token = secrets.token_hex(16)     # 32 字符随机十六进制
url_safe = secrets.token_urlsafe(16)   # URL 安全的随机字符串
secure_choice = secrets.choice(["A", "B", "C"])
```

**random vs secrets 对比**：

| 特性 | random | secrets |
|------|--------|---------|
| 随机性 | 伪随机（可复现） | 密码学安全（不可预测） |
| 用途 | 游戏、模拟、测试 | Token、密码、验证码 |
| 可重复性 | 可通过 seed 复现 | 不可复现 |

### 9.3 `statistics` 与 `decimal`

```python
import statistics
from decimal import Decimal, getcontext

# statistics：基础统计
data = [1, 2, 2, 3, 4, 5, 5, 5]
print(statistics.mean(data))      # 平均数
print(statistics.median(data))    # 中位数
print(statistics.mode(data))      # 众数
print(statistics.stdev(data))     # 标准差
print(statistics.quantiles(data)) # 分位数

# decimal：精确小数（金融计算）
getcontext().prec = 6   # 设置全局精度
a = Decimal("0.1")
b = Decimal("0.2")
print(a + b)   # 0.3（精确！）

# 不要用 float 构造 Decimal
print(Decimal(0.1))       # 不精确
print(Decimal("0.1"))     # 精确

# 高精度计算
getcontext().prec = 20
result = Decimal("1") / Decimal("7")
print(result)   # 0.14285714285714285714
```

**浮点精度问题**：

```python
# 浮点精度陷阱
print(0.1 + 0.2)   # 0.30000000000000004（不精确！）

# 使用 decimal 解决
from decimal import Decimal
print(Decimal("0.1") + Decimal("0.2"))   # 0.3（精确！）
```

---

## 10. 并发与并行

### 10.1 `threading` 与 GIL

```python
import threading
import time

def worker(name, delay):
    print(f"线程 {name} 开始")
    time.sleep(delay)
    print(f"线程 {name} 结束")

# 创建并启动线程
threads = []
for i in range(3):
    t = threading.Thread(target=worker, args=(f"T{i}", 1))
    t.start()
    threads.append(t)

# 等待所有线程完成
for t in threads:
    t.join()

# 线程安全：Lock
from threading import Lock
counter = 0
lock = Lock()

def increment():
    global counter
    for _ in range(100000):
        with lock:          # 获取锁
            counter += 1

# 线程本地存储
local = threading.local()
local.user_id = "123"   # 每个线程独立
```

**GIL（全局解释器锁）**：

```
┌──────────────────────────────────────────────┐
│              Python 解释器                   │
├──────────────────────────────────────────────┤
│                                              │
│   ┌──────────────────────────────────────┐   │
│   │           GIL（全局解释器锁）         │   │
│   └───────────────┬──────────────────────┘   │
│                   │                          │
│   ┌───────────────┴───────────────┐          │
│   │                               │          │
│   │  Thread 1   │  Thread 2       │          │
│   │  Python代码 │  Python代码     │          │
│   │             │                 │          │
│   └─────────────┴─────────────────┘          │
│                                              │
│   同一时刻只有一个线程执行 Python 字节码        │
│   I/O 操作时会释放 GIL                        │
└──────────────────────────────────────────────┘
```

### 10.2 `concurrent.futures`

```python
from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor, as_completed
import requests

# 线程池（I/O 密集型）
with ThreadPoolExecutor(max_workers=5) as executor:
    urls = ["http://example.com"] * 10
    # map：按顺序返回结果
    results = executor.map(fetch_url, urls)

    # submit：异步提交，可获取 Future
    futures = [executor.submit(fetch_url, url) for url in urls]
    for future in as_completed(futures):
        try:
            result = future.result()
            print(result)
        except Exception as e:
            print(f"错误: {e}")

# 进程池（CPU 密集型，绕过 GIL）
with ProcessPoolExecutor(max_workers=4) as executor:
    numbers = range(100)
    results = list(executor.map(is_prime, numbers))

def fetch_url(url):
    return requests.get(url, timeout=5).status_code
```

### 10.3 `multiprocessing`

```python
from multiprocessing import Pool, Queue, Process

def square(n):
    return n * n

# 进程池
if __name__ == "__main__":
    with Pool(4) as p:
        results = p.map(square, range(10))
        print(results)   # [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]

# 进程间通信
from multiprocessing import Manager

with Manager() as manager:
    shared_dict = manager.dict()
    shared_list = manager.list()
```

### 10.4 `asyncio`

```python
import asyncio

async def fetch(url):
    await asyncio.sleep(0.1)   # 模拟异步 I/O
    return f"Data from {url}"

async def main():
    urls = ["url1", "url2", "url3"]

    # gather：并发执行
    results = await asyncio.gather(
        *(fetch(url) for url in urls)
    )

    # 创建任务
    tasks = [asyncio.create_task(fetch(url)) for url in urls]
    for task in asyncio.as_completed(tasks):
        result = await task
        print(result)

# asyncio.run(main())
```

**并发模型选择**：

| 场景 | 推荐方案 | 原因 |
|------|----------|------|
| I/O 密集型（网络请求） | `asyncio` | 单线程高并发，内存开销低 |
| I/O 密集型（简单） | `ThreadPoolExecutor` | 代码简单，可调用同步库 |
| CPU 密集型 | `ProcessPoolExecutor` | 绕过 GIL，利用多核 |
| 大量 CPU 计算 | `multiprocessing` | 更灵活的进程控制 |

---

## 11. 网络与通信

### 11.1 `socket` 基础

```python
import socket

# TCP 客户端
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect(("example.com", 80))
    s.sendall(b"GET / HTTP/1.1\r\nHost: example.com\r\n\r\n")
    data = s.recv(4096)
    print(data.decode())

# UDP
with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
    s.sendto(b"Hello", ("localhost", 9999))
    data, addr = s.recvfrom(1024)
```

### 11.2 `http.client` 与 `urllib`

```python
# 标准库的 HTTP 请求（生产环境推荐使用 requests 第三方库）
import urllib.request
import json

req = urllib.request.Request(
    "https://api.example.com/data",
    headers={"Accept": "application/json"}
)
with urllib.request.urlopen(req, timeout=10) as response:
    data = json.loads(response.read())
    print(data)
```

### 11.3 `email` 模块

```python
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

msg = MIMEMultipart()
msg["From"] = "sender@example.com"
msg["To"] = "recipient@example.com"
msg["Subject"] = "测试邮件"

body = MIMEText("这是邮件正文", "plain", "utf-8")
msg.attach(body)

# 发送（需要 SMTP 服务器）
# import smtplib
# with smtplib.SMTP("smtp.example.com") as server:
#     server.send_message(msg)
```

---

## 12. 开发支持

### 12.1 `unittest` 测试框架

```python
import unittest
from unittest.mock import Mock, patch, MagicMock

class TestStringMethods(unittest.TestCase):
    def setUp(self):
        """每个测试方法前执行。"""
        self.sample = "hello world"

    def tearDown(self):
        """每个测试方法后执行。"""
        pass

    def test_upper(self):
        self.assertEqual("foo".upper(), "FOO")

    def test_isupper(self):
        self.assertTrue("FOO".isupper())
        self.assertFalse("Foo".isupper())

    def test_split(self):
        s = "hello world"
        self.assertEqual(s.split(), ["hello", "world"])
        with self.assertRaises(TypeError):
            s.split(2)

    @patch("module.ClassName.method")
    def test_with_mock(self, mock_method):
        mock_method.return_value = "mocked"
        result = module.ClassName().method()
        self.assertEqual(result, "mocked")

# 运行测试
# python -m unittest test_module
```

### 12.2 `doctest`

```python
def factorial(n):
    """计算阶乘。

    >>> factorial(5)
    120
    >>> factorial(0)
    1
    >>> factorial(-1)
    Traceback (most recent call last):
        ...
    ValueError: n must be >= 0
    """
    if n < 0:
        raise ValueError("n must be >= 0")
    if n <= 1:
        return 1
    return n * factorial(n - 1)

# 运行 doctest
# python -m doctest your_module.py -v
```

### 12.3 `timeit` 与性能分析

```python
import timeit

# 简单计时
elapsed = timeit.timeit("sum(range(1000))", number=10000)
print(f"耗时: {elapsed:.4f}s")

# 命令行使用
# python -m timeit "sum(range(1000))"

# cProfile：函数级性能分析
import cProfile
import pstats

def slow_function():
    return sum(i ** 2 for i in range(100000))

profiler = cProfile.Profile()
profiler.enable()
slow_function()
profiler.disable()

stats = pstats.Stats(profiler)
stats.sort_stats("cumulative")
stats.print_stats(10)   # 打印前 10 个耗时函数
```

### 12.4 `enum` 枚举

```python
from enum import Enum, auto, IntEnum

class Color(Enum):
    RED = 1
    GREEN = 2
    BLUE = 3

print(Color.RED)           # Color.RED
print(Color.RED.name)      # RED
print(Color.RED.value)     # 1
print(Color(1))            # Color.RED

# 自动赋值
class Status(Enum):
    PENDING = auto()
    RUNNING = auto()
    COMPLETED = auto()

# IntEnum：可作为整数使用
class Priority(IntEnum):
    LOW = 1
    MEDIUM = 2
    HIGH = 3

print(Priority.HIGH > Priority.LOW)   # True

# 枚举比较
print(Color.RED == Color.GREEN)   # False
print(Color.RED != Color.GREEN)   # True
```

---

## 13. 其他实用模块

### 13.1 `base64` 编码

```python
import base64

encoded = base64.b64encode(b"hello").decode()   # aGVsbG8=
decoded = base64.b64decode(encoded)              # b'hello'

# URL 安全编码
url_safe = base64.urlsafe_b64encode(b"hello?world").decode()

# 文件编码（处理二进制数据）
with open("image.png", "rb") as f:
    encoded_img = base64.b64encode(f.read()).decode()
```

### 13.2 `inspect` 内省

```python
import inspect

def example(a: int, b: str = "default") -> bool:
    """示例函数。"""
    return True

# 获取函数签名
sig = inspect.signature(example)
for name, param in sig.parameters.items():
    print(f"{name}: {param.annotation}, default={param.default}")

# 获取源码
print(inspect.getsource(example))

# 获取调用栈
print(inspect.stack())

# 判断对象类型
print(inspect.isfunction(example))    # True
print(inspect.ismethod(example))      # False

# 获取类的所有方法
class MyClass:
    def method1(self):
        pass
    def method2(self):
        pass

methods = inspect.getmembers(MyClass, predicate=inspect.isfunction)
print([name for name, _ in methods])   # ['method1', 'method2']
```

### 13.3 `weakref`：弱引用

弱引用不增加对象的引用计数，用于解决循环引用问题，以及实现缓存、观察者等场景。

```python
import weakref

class Node:
    def __init__(self, value):
        self.value = value
        self._parent = None        # 强引用
        self._children = []        # 强引用

    @property
    def parent(self):
        """使用弱引用避免循环引用。"""
        return self._parent() if self._parent else None

    @parent.setter
    def parent(self, node):
        self._parent = weakref.ref(node) if node else None

    def add_child(self, child):
        self._children.append(child)
        child.parent = self

# 弱引用被回收时的回调
def on_delete(obj):
    print(f"对象被回收: {obj}")

data = {"key": "value"}
ref = weakref.ref(data, on_delete)   # 注册回调
print(ref())           # {'key': 'value'} —— 获取原对象

del data               # 删除原对象
print(ref())           # None —— 原对象已被回收

# WeakValueDictionary：值被回收时自动删除条目
cache = weakref.WeakValueDictionary()
obj = Node("temp")
cache["temp"] = obj
print(len(cache))      # 1
del obj
print(len(cache))      # 0（自动移除）

# 工程场景：缓存系统、观察者模式（避免阻止观察者回收）、对象池
```

### 13.4 `copy` 模块深度解析

```python
import copy

# 浅拷贝 vs 深拷贝的底层原理
class Container:
    def __init__(self, items):
        self.items = items

original = Container([[1, 2], [3, 4]])

# 浅拷贝：只复制最外层，内层对象共享引用
shallow = copy.copy(original)
print(shallow.items is original.items)   # True（内层同一对象）
shallow.items[0].append(99)
print(original.items)                    # [[1, 2, 99], [3, 4]] —— 被影响了！

# 深拷贝：递归复制所有嵌套对象
deep = copy.deepcopy(original)
print(deep.items is original.items)      # False（内层独立对象）
deep.items[0].append(88)
print(original.items)                    # [[1, 2, 99], [3, 4]] —— 不受影响

# 自定义拷贝行为
class Custom:
    def __init__(self, value):
        self.value = value

    def __copy__(self):
        """浅拷贝自定义。"""
        return Custom(self.value)

    def __deepcopy__(self, memo):
        """深拷贝自定义。注意 memo 参数用于处理循环引用。"""
        return Custom(copy.deepcopy(self.value, memo))

# 拷贝策略选择
# | 场景 | 选择 | 原因 |
# |------|------|------|
# | 不可变对象（int、str、tuple）| 无需拷贝 | 赋值即引用 |
# | 简单容器（列表/字典值类型）| 浅拷贝 | 性能好，够用 |
# | 嵌套容器（列表嵌套列表）| 深拷贝 | 需要完全独立副本 |
# | 大对象 | 自定义 __copy__ | 只拷贝需要的部分 |
```

---

## 14. 工作实战场景

### 14.1 数据处理管道

```python
import itertools
from collections import Counter

class DataPipeline:
    """数据处理管道：流式处理大数据。"""
    
    def __init__(self, data_iter):
        self.data_iter = data_iter
    
    def filter(self, predicate):
        """过滤数据。"""
        return DataPipeline(filter(predicate, self.data_iter))
    
    def map(self, func):
        """转换数据。"""
        return DataPipeline(map(func, self.data_iter))
    
    def group_by(self, key_func):
        """按键分组。"""
        sorted_data = sorted(self.data_iter, key=key_func)
        groups = []
        for key, group in itertools.groupby(sorted_data, key=key_func):
            groups.append((key, list(group)))
        return groups
    
    def count_by(self, key_func):
        """按键计数。"""
        counter = Counter(key_func(item) for item in self.data_iter)
        return counter
    
    def collect(self):
        """收集结果。"""
        return list(self.data_iter)

# 使用示例
data = [
    {"name": "Alice", "category": "A", "value": 10},
    {"name": "Bob", "category": "B", "value": 20},
    {"name": "Charlie", "category": "A", "value": 30},
]

pipeline = DataPipeline(data)
result = pipeline \
    .filter(lambda x: x["value"] > 15) \
    .group_by(lambda x: x["category"])

print(result)
```

### 14.2 高性能缓存系统

```python
from functools import lru_cache
import time
from threading import Lock

class CacheManager:
    """缓存管理器：支持多种缓存策略。"""
    
    def __init__(self):
        self._caches = {}
        self._lock = Lock()
    
    def get_cache(self, name, maxsize=128):
        """获取或创建缓存。"""
        with self._lock:
            if name not in self._caches:
                def decorator(func):
                    @lru_cache(maxsize=maxsize)
                    def wrapper(*args, **kwargs):
                        return func(*args, **kwargs)
                    return wrapper
                self._caches[name] = decorator
        return self._caches[name]
    
    def clear_cache(self, name):
        """清空指定缓存。"""
        with self._lock:
            if name in self._caches:
                # lru_cache 装饰的函数有 cache_clear 方法
                pass

# 使用示例
cache_manager = CacheManager()

@cache_manager.get_cache("user_cache", maxsize=100)
def get_user(user_id):
    """模拟数据库查询。"""
    time.sleep(0.1)  # 模拟耗时操作
    return {"id": user_id, "name": f"User {user_id}"}

# 首次调用：慢
start = time.time()
user = get_user(1)
print(f"首次调用耗时: {time.time() - start:.3f}s")

# 缓存命中：快
start = time.time()
user = get_user(1)
print(f"缓存命中耗时: {time.time() - start:.3f}s")
```

### 14.3 日志分析工具

```python
import re
from collections import Counter
from pathlib import Path

class LogAnalyzer:
    """日志分析工具：统计访问频率、错误类型等。"""
    
    def __init__(self, log_path):
        self.log_path = Path(log_path)
        self._pattern = re.compile(
            r'(?P<ip>\d+\.\d+\.\d+\.\d+) - - \[(?P<time>.*?)\] '
            r'"(?P<method>\w+) (?P<path>.*?) HTTP/1\.\d" '
            r'(?P<status>\d+) (?P<size>\d+)'
        )
    
    def parse_logs(self):
        """解析日志文件，返回生成器。"""
        with open(self.log_path, "r", encoding="utf-8") as f:
            for line in f:
                match = self._pattern.match(line)
                if match:
                    yield match.groupdict()
    
    def get_ip_stats(self):
        """统计 IP 访问次数。"""
        counter = Counter(entry["ip"] for entry in self.parse_logs())
        return counter.most_common(10)
    
    def get_status_stats(self):
        """统计状态码分布。"""
        counter = Counter(entry["status"] for entry in self.parse_logs())
        return dict(counter)
    
    def get_top_paths(self):
        """统计访问最多的路径。"""
        counter = Counter(entry["path"] for entry in self.parse_logs())
        return counter.most_common(10)

# 使用示例
analyzer = LogAnalyzer("access.log")
print("Top IP:", analyzer.get_ip_stats())
print("Status分布:", analyzer.get_status_stats())
print("Top Paths:", analyzer.get_top_paths())
```

### 14.4 并发任务调度器

```python
from concurrent.futures import ThreadPoolExecutor, as_completed
import time

class TaskScheduler:
    """任务调度器：并发执行任务并收集结果。"""
    
    def __init__(self, max_workers=5):
        self.executor = ThreadPoolExecutor(max_workers=max_workers)
    
    def submit(self, task_func, *args, **kwargs):
        """提交单个任务。"""
        return self.executor.submit(task_func, *args, **kwargs)
    
    def run_all(self, tasks):
        """并行执行所有任务。"""
        futures = [self.executor.submit(task) for task in tasks]
        
        results = []
        errors = []
        
        for future in as_completed(futures):
            try:
                results.append(future.result())
            except Exception as e:
                errors.append(e)
        
        return results, errors
    
    def shutdown(self):
        """关闭调度器。"""
        self.executor.shutdown(wait=True)

# 使用示例
def fetch_data(url):
    """模拟网络请求。"""
    time.sleep(0.5)
    return f"Data from {url}"

scheduler = TaskScheduler(max_workers=3)
tasks = [
    lambda: fetch_data("http://api1.example.com"),
    lambda: fetch_data("http://api2.example.com"),
    lambda: fetch_data("http://api3.example.com"),
]

results, errors = scheduler.run_all(tasks)
print("Results:", results)
scheduler.shutdown()
```

---

## 15. 常见面试题汇总

### 15.1 基础概念题

**Q1：`collections` 模块中 `defaultdict` 和普通 `dict` 的区别？**

**A**：`defaultdict` 在访问不存在的键时会自动创建该键，并使用 `default_factory` 提供默认值。普通 `dict` 会抛出 `KeyError`。

---

**Q2：`itertools.chain` 和 `list.extend` 的区别？**

**A**：`itertools.chain` 返回一个迭代器，不立即合并列表，内存效率更高；`list.extend` 会立即将所有元素添加到列表中，占用更多内存。

---

**Q3：`heapq` 实现的是最大堆还是最小堆？如何实现最大堆？**

**A**：`heapq` 实现的是最小堆。要实现最大堆，可以将元素取负值后存储。

---

**Q4：`functools.lru_cache` 的工作原理是什么？**

**A**：`lru_cache` 使用最近最少使用算法缓存函数结果。当缓存满时，会淘汰最近最少使用的条目。它通过装饰器实现，自动将函数参数作为键缓存结果。

---

**Q5：`concurrent.futures.ThreadPoolExecutor` 和 `ProcessPoolExecutor` 的区别？**

**A**：
- `ThreadPoolExecutor`：线程池，适用于 I/O 密集型任务，受 GIL 限制，同一时刻只有一个线程执行 Python 字节码
- `ProcessPoolExecutor`：进程池，适用于 CPU 密集型任务，绕过 GIL，利用多核处理器

---

### 15.2 实战应用题

**Q6：如何选择合适的并发模型？**

**A**：
- I/O 密集型（网络请求、文件读写）：`asyncio`（单线程高并发）或 `ThreadPoolExecutor`（简单）
- CPU 密集型（计算任务）：`ProcessPoolExecutor`（绕过 GIL）
- 需要大量进程控制：`multiprocessing`

---

**Q7：如何处理浮点数精度问题？**

**A**：
1. 使用 `decimal` 模块进行精确小数计算
2. 避免直接比较浮点数，使用容差比较（`abs(a - b) < 1e-9`）
3. 对于金融计算，使用 `decimal` 或整数（以分为单位）

---

**Q8：如何实现高效的缓存系统？**

**A**：
1. 使用 `functools.lru_cache` 装饰器（简单场景）
2. 实现自定义缓存类（复杂场景）
3. 使用 `weakref.WeakValueDictionary`（自动回收缓存）
4. 设置合理的缓存过期策略

---

**Q9：如何进行性能分析？**

**A**：
1. `timeit`：简单计时，比较代码片段
2. `cProfile`：函数级性能分析，找出耗时函数
3. `line_profiler`（第三方）：行级性能分析
4. `memory_profiler`（第三方）：内存使用分析

---

**Q10：`re.compile()` 的作用是什么？何时使用？**

**A**：`re.compile()` 用于编译正则表达式，生成正则表达式对象。对于频繁使用的正则表达式，编译后复用可以提升性能（避免重复编译）。

---

### 15.3 代码分析题

**Q11：分析以下代码的问题：**

```python
import re

text = "email: test@example.com"
if re.match(r"\w+@\w+\.\w+", text):
    print("匹配成功")
else:
    print("匹配失败")
```

**A**：`re.match()` 只从字符串开头匹配，而 `email: test@example.com` 开头是 "email:"，所以匹配失败。应使用 `re.search()`。

---

**Q12：分析以下代码的问题：**

```python
from collections import defaultdict

data = [("A", 1), ("B", 2), ("A", 3)]
groups = defaultdict(list)
for key, value in data:
    groups[key].append(value)

print(dict(groups))
```

**A**：这段代码没有问题，是正确的分组方式。输出为 `{'A': [1, 3], 'B': [2]}`。

---

**Q13：以下代码的输出是什么？**

```python
import heapq

nums = [3, 1, 4, 1, 5, 9]
heapq.heapify(nums)
print(heapq.heappop(nums))
print(heapq.heappop(nums))
```

**A**：输出为 `1` 和 `1`。`heapify` 将列表转为最小堆，`heappop` 每次弹出最小元素。

---

## 16. 实战项目：日志分析系统

### 16.1 项目概述

**项目目标**：开发一个命令行日志分析工具 `loganalyzer`，支持分析 Web 服务器日志。

**功能需求**：
- `loganalyzer access <logfile>` - 分析访问日志
- `loganalyzer errors <logfile>` - 统计错误类型
- `loganalyzer top <logfile>` - 显示 Top 访问 IP/路径
- `loganalyzer export <logfile> <output>` - 导出分析结果

### 16.2 项目结构

```
loganalyzer/
├── README.md
├── pyproject.toml
├── src/
│   └── loganalyzer/
│       ├── __init__.py
│       ├── __main__.py
│       ├── cli.py
│       ├── analyzer.py
│       ├── parsers/
│       │   ├── __init__.py
│       │   └── nginx_parser.py
│       └── exporters/
│           ├── __init__.py
│           └── json_exporter.py
└── tests/
    ├── __init__.py
    └── test_analyzer.py
```

### 16.3 核心代码

**pyproject.toml**：

```toml
[build-system]
requires = ["setuptools>=61.0", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "loganalyzer"
version = "1.0.0"
description = "A log analysis tool"
readme = "README.md"
license = {text = "MIT"}
authors = [
    {name = "Your Name", email = "you@example.com"}
]
requires-python = ">=3.9"
dependencies = [
    "click>=8.0",
]

[project.scripts]
loganalyzer = "loganalyzer.cli:main"

[tool.setuptools.packages.find]
where = ["src"]
```

**cli.py**：

```python
import click
from loganalyzer.analyzer import LogAnalyzer

@click.group()
def main():
    """LogAnalyzer - 日志分析工具"""
    pass

@main.command("access")
@click.argument("logfile")
def analyze_access(logfile):
    """分析访问日志。"""
    analyzer = LogAnalyzer(logfile)
    stats = analyzer.get_access_stats()
    click.echo(f"总访问次数: {stats['total']}")
    click.echo(f"平均响应大小: {stats['avg_size']:.2f} bytes")

@main.command("errors")
@click.argument("logfile")
def analyze_errors(logfile):
    """统计错误类型。"""
    analyzer = LogAnalyzer(logfile)
    errors = analyzer.get_error_stats()
    for status, count in errors.items():
        click.echo(f"{status}: {count} 次")

@main.command("top")
@click.argument("logfile")
@click.option("-t", "--type", default="ip", type=click.Choice(["ip", "path"]))
def show_top(logfile, type):
    """显示 Top IP 或路径。"""
    analyzer = LogAnalyzer(logfile)
    if type == "ip":
        top = analyzer.get_top_ips()
    else:
        top = analyzer.get_top_paths()
    
    click.echo(f"Top 10 {type}:")
    for item, count in top:
        click.echo(f"  {item}: {count}")

@main.command("export")
@click.argument("logfile")
@click.argument("output")
def export_results(logfile, output):
    """导出分析结果。"""
    analyzer = LogAnalyzer(logfile)
    analyzer.export(output)
    click.echo(f"结果已导出到: {output}")
```

**analyzer.py**：

```python
from collections import Counter
from loganalyzer.parsers.nginx_parser import NginxParser
from loganalyzer.exporters.json_exporter import JsonExporter

class LogAnalyzer:
    """日志分析器。"""
    
    def __init__(self, logfile):
        self.logfile = logfile
        self.parser = NginxParser()
        self.exporter = JsonExporter()
    
    def get_entries(self):
        """获取所有日志条目。"""
        return self.parser.parse(self.logfile)
    
    def get_access_stats(self):
        """获取访问统计。"""
        entries = self.get_entries()
        total = len(entries)
        total_size = sum(int(e["size"]) for e in entries)
        
        return {
            "total": total,
            "avg_size": total_size / total if total > 0 else 0,
        }
    
    def get_error_stats(self):
        """获取错误统计。"""
        entries = self.get_entries()
        errors = [e["status"] for e in entries if e["status"].startswith("4") or e["status"].startswith("5")]
        return dict(Counter(errors))
    
    def get_top_ips(self):
        """获取 Top IP。"""
        entries = self.get_entries()
        counter = Counter(e["ip"] for e in entries)
        return counter.most_common(10)
    
    def get_top_paths(self):
        """获取 Top 路径。"""
        entries = self.get_entries()
        counter = Counter(e["path"] for e in entries)
        return counter.most_common(10)
    
    def export(self, output):
        """导出分析结果。"""
        data = {
            "access_stats": self.get_access_stats(),
            "error_stats": self.get_error_stats(),
            "top_ips": self.get_top_ips(),
            "top_paths": self.get_top_paths(),
        }
        self.exporter.export(data, output)
```

**parsers/nginx_parser.py**：

```python
import re

class NginxParser:
    """Nginx 日志解析器。"""
    
    def __init__(self):
        self._pattern = re.compile(
            r'(?P<ip>\d+\.\d+\.\d+\.\d+) - - \[(?P<time>.*?)\] '
            r'"(?P<method>\w+) (?P<path>.*?) HTTP/1\.\d" '
            r'(?P<status>\d+) (?P<size>\d+)'
        )
    
    def parse(self, logfile):
        """解析日志文件。"""
        entries = []
        with open(logfile, "r", encoding="utf-8") as f:
            for line in f:
                match = self._pattern.match(line)
                if match:
                    entries.append(match.groupdict())
        return entries
```

**exporters/json_exporter.py**：

```python
import json

class JsonExporter:
    """JSON 导出器。"""
    
    def export(self, data, output):
        """导出数据到 JSON 文件。"""
        with open(output, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
```

### 16.4 项目运行

```bash
# 开发模式安装
pip install -e .

# 使用命令
loganalyzer access access.log          # 分析访问统计
loganalyzer errors access.log          # 统计错误
loganalyzer top access.log --type ip   # Top IP
loganalyzer top access.log --type path # Top 路径
loganalyzer export access.log result.json

# 或者使用 python -m
python -m loganalyzer access access.log
```

### 16.5 项目亮点

1. **模块化设计**：解析器和导出器独立，易于扩展
2. **正则优化**：预编译正则表达式，提升性能
3. **流式处理**：逐行读取日志，内存效率高
4. **命令行友好**：使用 click 库，提供丰富的命令和选项

---

## 附录：第八阶段自检清单

在继续学习第九阶段之前，请确保你能：

- [ ] 使用 `re` 模块完成常见的匹配、查找、替换操作
- [ ] 使用 `collections` 中的 `deque`、`Counter`、`defaultdict`、`namedtuple`
- [ ] 使用 `heapq` 实现优先队列，使用 `bisect` 维护有序列表
- [ ] 使用 `itertools` 生成排列组合、无限序列、分组
- [ ] 使用 `datetime` 进行时间计算、格式化、时区转换
- [ ] 使用 `decimal` 进行精确的小数计算
- [ ] 使用 `secrets` 生成安全的随机数和 token
- [ ] 选择合适的并发模型（threading/multiprocessing/asyncio）
- [ ] 使用 `concurrent.futures` 的线程池/进程池
- [ ] 编写 `unittest` 测试用例，使用 `mock` 进行依赖隔离
- [ ] 使用 `argparse` 处理命令行参数
- [ ] 使用 `base64` 进行编码解码
- [ ] 使用 `inspect` 进行代码内省
- [ ] 使用 `weakref` 解决循环引用问题
- [ ] 区分浅拷贝和深拷贝的使用场景

---

> **工程师寄语**：标准库是 Python 最大的宝藏。在考虑安装第三方包之前，先问一句："标准库里有吗？" 熟悉标准库不仅能减少依赖，还能提高代码的可维护性和可移植性。`collections`、`itertools`、`functools` 这三个模块特别值得反复研读。

> **性能提示**：对于频繁调用的正则表达式，务必使用 `re.compile()` 编译后复用。对于大数据量处理，优先使用 `itertools` 和生成器表达式，避免一次性加载所有数据到内存。
---
title: 【Python】文件I/O与序列化（第六阶段）
date: 2026-07-23 10:00:00
categories:
  - Python
tags:
  - Python
  - 教程
  - 文件IO
  - 序列化
description: 系统掌握 Python 文件读写、pathlib、上下文管理器、JSON/Pickle/CSV/XML 序列化、压缩归档和工程实践。
cover: /images/cover.png
---

# 六、文件 I/O 与序列化

> **阶段定位**：文件操作和序列化是任何应用程序都无法回避的基础能力。Python 提供了丰富的工具链，从底层的 `os` 到现代的 `pathlib`，从 `json` 到 `pickle`。本阶段从工程实践出发，讲解如何安全、高效地处理文件和数据持久化。

```
┌─────────────────────────────────────────────────────────────────┐
│                   文件 I/O 与序列化知识图谱                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. 文件读写 ──→ open() / with / 文本模式 / 二进制模式            │
│       │                                                         │
│  2. 上下文管理器 ─→ with / @contextmanager / ExitStack           │
│       │                                                         │
│  3. 文件系统 ───→ pathlib / os / os.path / shutil                │
│       │                                                         │
│  4. 序列化 ─────→ JSON / Pickle / CSV / XML                      │
│       │                                                         │
│  5. 压缩归档 ───→ zipfile / tarfile / gzip                       │
│       │                                                         │
│  6. 内存流 ────→ io.StringIO / io.BytesIO                        │
│       │                                                         │
│  7. 工程实践 ───→ 大文件 / 临时文件 / 文件锁 / 原子写入 / sqlite3  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 1. 文件读写基础

### 1.1 基本文件操作

```python
# 基本读写模式
# 'r'  读取（默认）
# 'w'  写入（覆盖）
# 'a'  追加
# 'x'  独占创建（文件已存在则报错）
# 'b'  二进制模式（如 'rb', 'wb'）
# '+'  读写模式（如 'r+', 'w+'）

# 推荐：使用 with 语句确保文件关闭
with open("data.txt", "r", encoding="utf-8") as f:
    content = f.read()          # 读取全部内容
    print(content)

# 逐行读取（内存友好，适合大文件）
with open("data.txt", "r", encoding="utf-8") as f:
    for line in f:              # 惰性逐行读取
        print(line.strip())     # strip() 去除换行符

# 写入文件
with open("output.txt", "w", encoding="utf-8") as f:
    f.write("第一行\n")
    f.write("第二行\n")
    f.writelines(["第三行\n", "第四行\n"])

# 追加模式
with open("output.txt", "a", encoding="utf-8") as f:
    f.write("追加内容\n")
```

**文件打开模式组合**：

```
┌─────────────────────────────────────────────────────────┐
│                  文件打开模式组合                         │
├──────────────┬──────────────┬──────────────────────────┤
│ 模式         │ 含义          │ 特性                      │
├──────────────┼──────────────┼──────────────────────────┤
│ 'r'          │ 只读          │ 默认模式，文件不存在报错    │
│ 'w'          │ 写入（覆盖）   │ 文件不存在创建，存在清空    │
│ 'a'          │ 追加          │ 文件不存在创建，指针在末尾  │
│ 'x'          │ 独占创建      │ 文件已存在则报错           │
│ 'b'          │ 二进制        │ 与其他模式组合使用         │
│ '+'          │ 读写          │ 与其他模式组合使用         │
│ 'r+'         │ 读写（不清空） │ 文件必须存在，指针在开头    │
│ 'w+'         │ 读写（覆盖）   │ 文件不存在创建，存在清空    │
│ 'a+'         │ 读写（追加）   │ 文件不存在创建，指针在末尾  │
└──────────────┴──────────────┴──────────────────────────┘
```

### 1.2 文件指针与随机访问

```python
with open("data.txt", "r+", encoding="utf-8") as f:
    # 读取前 10 字节
    chunk = f.read(10)
    print(f"当前位置: {f.tell()}")    # 返回当前文件指针位置

    # 移动到文件开头
    f.seek(0)

    # 移动到第 20 字节
    f.seek(20)

    # 从当前位置偏移 5 字节
    f.seek(5, 1)    # whence: 0=文件头, 1=当前位置, 2=文件尾
```

**`seek()` 的 `whence` 参数**：

| 参数 | 含义 |
|------|------|
| 0（默认） | 从文件开头计算偏移量 |
| 1 | 从当前位置计算偏移量（仅二进制模式） |
| 2 | 从文件末尾计算偏移量（仅二进制模式） |

### 1.3 二进制文件读写

```python
# 二进制模式（图片、音频、视频等）
with open("image.jpg", "rb") as f:
    header = f.read(4)          # 读取文件头
    print(header)               # b'\xff\xd8\xff\xe0'（JPEG 文件头）

# 复制文件（二进制方式）
def copy_file(src, dst, chunk_size=8192):
    """高效复制文件，使用分块读取避免大文件占用过多内存。"""
    with open(src, "rb") as fsrc, open(dst, "wb") as fdst:
        while True:
            chunk = fsrc.read(chunk_size)
            if not chunk:
                break
            fdst.write(chunk)
```

> **工程建议**：复制文件时使用 `shutil.copy2()` 替代手动实现，它更高效且保留元数据。

---

## 2. `with` 语句与上下文管理器

### 2.1 `with` 的本质

```python
# with 语句自动管理资源（文件、锁、数据库连接等）
# 等价于 try/finally，但语法更优雅

with open("file.txt", "r") as f:
    data = f.read()
# 这里 f 已自动关闭，即使发生异常也会关闭

# 等价于：
f = open("file.txt", "r")
try:
    data = f.read()
finally:
    f.close()
```

**上下文管理器协议**：

```
┌─────────────────────────────────────────────────────────┐
│                  上下文管理器协议                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  一个对象只要实现了 __enter__ 和 __exit__ 方法，          │
│  就可以在 with 语句中使用。                               │
│                                                         │
│  class Resource:                                        │
│      def __enter__(self):                               │
│          # 资源获取逻辑                                  │
│          return self                                    │
│                                                         │
│      def __exit__(self, exc_type, exc_val, exc_tb):     │
│          # 资源释放逻辑（无论是否发生异常都会执行）         │
│          return False  # 返回 True 会抑制异常             │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 2.2 同时打开多个文件

```python
# 同时读写多个文件
with open("input.txt", "r", encoding="utf-8") as fin, \
     open("output.txt", "w", encoding="utf-8") as fout:
    for line in fin:
        processed = line.strip().upper()
        fout.write(processed + "\n")

# Python 3.10+ 更简洁的语法
with (
    open("input.txt", "r", encoding="utf-8") as fin,
    open("output.txt", "w", encoding="utf-8") as fout,
):
    fout.write(fin.read())
```

### 2.3 自定义上下文管理器

```python
from contextlib import contextmanager

@contextmanager
def managed_file(filename, mode="r"):
    """自定义文件上下文管理器。"""
    f = open(filename, mode)
    try:
        print(f"打开文件: {filename}")
        yield f
    finally:
        f.close()
        print(f"关闭文件: {filename}")

with managed_file("test.txt", "w") as f:
    f.write("Hello")

# 更多实用上下文管理器
from contextlib import suppress, redirect_stdout

# suppress：忽略指定异常
with suppress(FileNotFoundError):
    os.remove("nonexistent.txt")   # 不会报错

# redirect_stdout：重定向标准输出
with open("log.txt", "w") as f:
    with redirect_stdout(f):
        print("这行会写入 log.txt")

# ExitStack：动态管理多个上下文
from contextlib import ExitStack

with ExitStack() as stack:
    files = [
        stack.enter_context(open(f"file{i}.txt"))
        for i in range(10)
    ]
    # 所有文件会在 with 结束时自动关闭
```

---

## 3. 文件系统操作：`os`、`os.path`、`pathlib`

### 3.1 `pathlib`（推荐，3.4+）

`pathlib` 是面向对象的文件路径操作库，取代了传统的 `os.path`。

```python
from pathlib import Path

# 创建路径对象
p = Path("/home/user/documents/file.txt")

# 路径属性
print(p.name)           # file.txt
print(p.stem)           # file（不含扩展名）
print(p.suffix)         # .txt
print(p.suffixes)       # ['.txt']（多个扩展名）
print(p.parent)         # /home/user/documents
print(p.parents[0])     # /home/user/documents
print(p.parents[1])     # /home/user
print(p.parts)          # ('/', 'home', 'user', 'documents', 'file.txt')
print(p.anchor)         # /（Windows 为 C:\）

# 路径拼接（使用 / 运算符）
base = Path("/home/user")
doc = base / "documents" / "file.txt"
print(doc)              # /home/user/documents/file.txt

# 相对/绝对路径
print(Path("relative.txt").is_absolute())   # False
print(Path("relative.txt").resolve())        # 转为绝对路径

# 路径存在性检查
print(p.exists())
print(p.is_file())
print(p.is_dir())
```

### 3.2 文件与目录操作

```python
from pathlib import Path

base = Path("my_project")

# 创建目录（parents=True 创建父目录，exist_ok=True 不报错）
base.mkdir(parents=True, exist_ok=True)
(base / "src").mkdir(exist_ok=True)
(base / "tests").mkdir(exist_ok=True)

# 创建文件
config = base / "config.json"
config.write_text('{"debug": true}', encoding="utf-8")

# 读取文件
text = config.read_text(encoding="utf-8")
print(text)

# 读取二进制
# binary_data = config.read_bytes()

# 文件操作
target = base / "config_backup.json"
config.rename(target)           # 重命名
target.replace(config)          # 移动/替换
config.copy(target)             # 复制（3.8+）
config.unlink()                 # 删除文件
target.unlink(missing_ok=True)  # 删除，不存在不报错（3.8+）

# 遍历目录
for item in base.iterdir():
    print(item.name)

# 递归遍历
for py_file in base.rglob("*.py"):   # rglob = recursive glob
    print(py_file)

# glob 模式匹配
for txt in base.glob("*.txt"):
    print(txt)
```

### 3.3 `os` 与 `os.path` 对照表

| 操作 | `os`/`os.path` | `pathlib`（推荐） |
|------|----------------|-------------------|
| 路径拼接 | `os.path.join(a, b)` | `Path(a) / b` |
| 绝对路径 | `os.path.abspath(p)` | `Path(p).resolve()` |
| 存在检查 | `os.path.exists(p)` | `Path(p).exists()` |
| 是否为文件 | `os.path.isfile(p)` | `Path(p).is_file()` |
| 是否为目录 | `os.path.isdir(p)` | `Path(p).is_dir()` |
| 文件名 | `os.path.basename(p)` | `Path(p).name` |
| 目录名 | `os.path.dirname(p)` | `Path(p).parent` |
| 扩展名 | `os.path.splitext(p)` | `Path(p).suffix` |
| 创建目录 | `os.makedirs(p, exist_ok=True)` | `Path(p).mkdir(parents=True, exist_ok=True)` |
| 删除文件 | `os.remove(p)` | `Path(p).unlink()` |
| 删除目录 | `os.rmdir(p)` | `Path(p).rmdir()` |
| 重命名 | `os.rename(src, dst)` | `Path(src).rename(dst)` |

---

## 4. `shutil`：高级文件操作

```python
import shutil
from pathlib import Path

src = Path("source")
dst = Path("destination")

# 复制文件
shutil.copy2("file.txt", "backup/file.txt")     # 保留元数据（修改时间等）
shutil.copy("file.txt", "backup/")              # 不保留元数据

# 复制目录树
shutil.copytree("project", "project_backup")
shutil.copytree("project", "project_backup", dirs_exist_ok=True)  # 3.8+

# 移动文件/目录
shutil.move("old_dir", "new_dir")

# 删除目录树
shutil.rmtree("temp_dir")

# 磁盘使用统计
total, used, free = shutil.disk_usage("/")
print(f"总空间: {total // (1024**3)} GB")
print(f"已用: {used // (1024**3)} GB")
print(f"可用: {free // (1024**3)} GB")

# 查找文件
shutil.which("python")      # '/usr/bin/python'（类 which 命令）
```

---

## 5. 序列化

### 5.1 JSON

```python
import json
from pathlib import Path

data = {
    "name": "Alice",
    "age": 30,
    "skills": ["Python", "Go", "Rust"],
    "address": {
        "city": "Beijing",
        "zipcode": "100000"
    },
    "is_active": True,
}

# 序列化（Python 对象 → JSON 字符串）
json_str = json.dumps(data, ensure_ascii=False, indent=2)
print(json_str)

# 写入文件
Path("data.json").write_text(
    json.dumps(data, ensure_ascii=False, indent=2),
    encoding="utf-8"
)

# 快捷方式（更推荐）
with open("data.json", "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

# 反序列化（JSON 字符串 → Python 对象）
loaded = json.loads(json_str)
print(loaded["name"])

# 从文件读取
with open("data.json", "r", encoding="utf-8") as f:
    loaded = json.load(f)
```

**JSON 参数速查**：

| 参数 | 说明 |
|------|------|
| `ensure_ascii=False` | 允许输出中文，不转义为 Unicode 编码 |
| `indent=2` | 格式化缩进 |
| `sort_keys=True` | 按键排序（提高可读性/可比较性） |
| `separators=(',', ':')` | 紧凑输出（生产环境减小体积） |

**自定义 JSON 编码**：

```python
from datetime import datetime
import json

class CustomEncoder(json.JSONEncoder):
    """自定义 JSON 编码器。"""
    def default(self, obj):
        if isinstance(obj, datetime):
            return obj.isoformat()
        if isinstance(obj, set):
            return list(obj)
        return super().default(obj)

data = {
    "created_at": datetime.now(),
    "tags": {"python", "json"},
}

json_str = json.dumps(data, cls=CustomEncoder, ensure_ascii=False)
print(json_str)
# {"created_at": "2024-07-20T10:30:00.000000", "tags": ["python", "json"]}
```

### 5.2 Pickle

```python
import pickle

# Pickle：Python 专用的二进制序列化
# 可以序列化几乎所有 Python 对象（包括自定义类实例）
# 警告：不要反序列化不受信任的数据！存在安全漏洞

data = {
    "name": "Alice",
    "func": lambda x: x * 2,   # 甚至可以序列化 lambda！
}

# 序列化
with open("data.pkl", "wb") as f:
    pickle.dump(data, f)

# 反序列化
with open("data.pkl", "rb") as f:
    loaded = pickle.load(f)
    print(loaded["func"](5))   # 10
```

**JSON vs Pickle 对比**：

| 特性 | JSON | Pickle |
|------|------|--------|
| 格式 | 文本，人类可读 | 二进制 |
| 跨语言 | 是 | 否（仅限 Python） |
| 安全性 | 安全 | 不安全（不要加载不信任的数据） |
| 对象支持 | 基础类型 | 几乎所有 Python 对象 |
| 速度 | 较慢 | 较快 |
| 适用场景 | API 数据交换、配置文件 | 缓存、临时状态保存 |

> **安全警告**：`pickle.load()` 会执行任意 Python 代码，**永远不要反序列化来自不可信来源的数据**。

### 5.3 CSV

```python
import csv
from pathlib import Path

# 写入 CSV
users = [
    ["name", "age", "city"],
    ["Alice", 30, "Beijing"],
    ["Bob", 25, "Shanghai"],
    ["Carol", 35, "Shenzhen"],
]

with open("users.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerows(users)

# 读取 CSV
with open("users.csv", "r", encoding="utf-8") as f:
    reader = csv.reader(f)
    for row in reader:
        print(row)

# 使用 DictReader/DictWriter（推荐）
with open("users.csv", "r", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for row in reader:
        print(f"{row['name']} 来自 {row['city']}")

# DictWriter
with open("users.csv", "w", newline="", encoding="utf-8") as f:
    fieldnames = ["name", "age", "city"]
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerow({"name": "Alice", "age": 30, "city": "Beijing"})
```

### 5.4 XML

```python
import xml.etree.ElementTree as ET

# 解析 XML
xml_data = """
<library>
    <book id="1">
        <title>Python编程</title>
        <author>张三</author>
        <price>59.00</price>
    </book>
    <book id="2">
        <title>数据结构</title>
        <author>李四</author>
        <price>45.00</price>
    </book>
</library>
"""

root = ET.fromstring(xml_data)

# 遍历
for book in root.findall("book"):
    book_id = book.get("id")
    title = book.find("title").text
    author = book.find("author").text
    price = float(book.find("price").text)
    print(f"[{book_id}] {title} - {author} ({price}元)")

# 生成 XML
new_book = ET.SubElement(root, "book", {"id": "3"})
ET.SubElement(new_book, "title").text = "算法导论"
ET.SubElement(new_book, "author").text = "王五"
ET.SubElement(new_book, "price").text = "89.00"

# 保存
ET.indent(root, space="  ")   # 3.9+ 格式化
tree = ET.ElementTree(root)
tree.write("library.xml", encoding="utf-8", xml_declaration=True)
```

---

## 6. 压缩与归档

### 6.1 `zipfile`

```python
import zipfile
from pathlib import Path

# 创建 ZIP
with zipfile.ZipFile("archive.zip", "w", zipfile.ZIP_DEFLATED) as zf:
    zf.write("file1.txt")
    zf.write("file2.txt", "renamed.txt")   # 写入时重命名

# 追加到 ZIP
with zipfile.ZipFile("archive.zip", "a") as zf:
    zf.write("file3.txt")

# 读取 ZIP
with zipfile.ZipFile("archive.zip", "r") as zf:
    # 列出内容
    print(zf.namelist())

    # 读取文件内容
    with zf.open("file1.txt") as f:
        print(f.read().decode("utf-8"))

    # 解压全部
    zf.extractall("extracted/")

    # 解压单个文件
    zf.extract("file1.txt", "extracted/")

# 解压密码保护的 ZIP
with zipfile.ZipFile("secret.zip", "r") as zf:
    zf.extractall("extracted/", pwd=b"password")
```

### 6.2 `tarfile`

```python
import tarfile
from pathlib import Path

# 创建 tar.gz
with tarfile.open("archive.tar.gz", "w:gz") as tf:
    tf.add("file1.txt")
    tf.add("dir/", arcname="data/")   # 写入时重命名目录

# 读取 tar
with tarfile.open("archive.tar.gz", "r:gz") as tf:
    print(tf.getnames())   # 列出内容

    # 提取全部
    tf.extractall("extracted/")

    # 提取单个
    tf.extract("file1.txt", "extracted/")

    # 安全提取（3.12+）
    # tf.extractall("extracted/", filter="fully_trusted")
```

### 6.3 `gzip`

```python
import gzip

# 压缩
with open("data.txt", "rb") as fsrc:
    with gzip.open("data.txt.gz", "wb") as fdst:
        fdst.write(fsrc.read())

# 更简洁（文本模式）
with gzip.open("data.txt.gz", "wt", encoding="utf-8") as f:
    f.write("Hello, World!")

# 解压读取
with gzip.open("data.txt.gz", "rt", encoding="utf-8") as f:
    print(f.read())
```

---

## 7. 内存流：`io.StringIO` 与 `io.BytesIO`

```python
from io import StringIO, BytesIO

# StringIO：内存中的文本流
output = StringIO()
output.write("第一行\n")
output.write("第二行\n")
print("第三行", file=output)

# 获取内容
content = output.getvalue()
print(content)

# 重置指针，重新读取
output.seek(0)
for line in output:
    print(line.strip())

output.close()

# BytesIO：内存中的字节流
binary = BytesIO()
binary.write(b"Hello")
binary.write(b" World")

binary.seek(0)
print(binary.read())    # b'Hello World'

# 实用场景：避免创建临时文件
def process_csv_in_memory(rows):
    """在内存中生成 CSV，直接发送给 HTTP 响应。"""
    from io import StringIO
    import csv

    output = StringIO()
    writer = csv.writer(output)
    writer.writerows(rows)

    output.seek(0)
    return output.getvalue()
```

---

## 8. 文件 I/O 工程实践

### 8.1 大文件处理

```python
from pathlib import Path

def process_large_file(filepath, chunk_size=8192):
    """分块读取大文件，避免内存溢出。"""
    with open(filepath, "rb") as f:
        while True:
            chunk = f.read(chunk_size)
            if not chunk:
                break
            yield chunk

# 逐行处理（最省内存）
with open("huge.log", "r", encoding="utf-8") as f:
    for line in f:          # 内部使用缓冲区，每次只读一行
        process_line(line)

# 使用 mmap 处理超大文件（内存映射）
import mmap

with open("huge.bin", "r+b") as f:
    with mmap.mmap(f.fileno(), 0) as mm:
        # 像操作内存一样操作文件，操作系统自动处理分页
        print(mm[:100])     # 读取前 100 字节
        mm.seek(1000000)    # 跳转到 1MB 处
        print(mm.read(100))
```

### 8.2 临时文件

```python
import tempfile
from pathlib import Path

# 临时文件（自动删除）
with tempfile.NamedTemporaryFile(mode="w", suffix=".txt", delete=True) as tmp:
    tmp.write("临时内容")
    tmp.flush()
    print(f"临时文件路径: {tmp.name}")
# with 结束时自动删除

# 临时目录
with tempfile.TemporaryDirectory() as tmpdir:
    path = Path(tmpdir) / "data.json"
    path.write_text("{}")
    print(f"临时目录: {tmpdir}")
# with 结束时自动删除整个目录

# 不自动删除的临时文件（用于测试后检查）
tmp = tempfile.NamedTemporaryFile(mode="w", suffix=".txt", delete=False)
tmp.write("保留的内容")
tmp.close()
print(f"保留的临时文件: {tmp.name}")
# 手动删除：os.unlink(tmp.name)
```

### 8.3 文件锁（跨进程同步）

```python
import fcntl  # Linux/macOS
# import msvcrt  # Windows

def acquire_lock(filepath):
    """获取文件锁（Linux/macOS）。"""
    with open(filepath, "w") as f:
        fcntl.flock(f, fcntl.LOCK_EX)   # 排他锁
        try:
            yield f
        finally:
            fcntl.flock(f, fcntl.LOCK_UN)  # 释放锁

# Windows 使用 portalocker 或 filelock 库
# pip install filelock
from filelock import FileLock

lock = FileLock("data.lock")
with lock:
    # 临界区：只有一个进程可以执行
    with open("data.json", "r+") as f:
        data = json.load(f)
        data["count"] += 1
        f.seek(0)
        json.dump(data, f)
        f.truncate()
```

### 8.4 原子写入

```python
from pathlib import Path
import tempfile
import os

def atomic_write(filepath, content):
    """原子写入：要么完全成功，要么完全不写（避免写入中断导致文件损坏）。"""
    filepath = Path(filepath)
    tmp = tempfile.NamedTemporaryFile(
        mode="w",
        dir=filepath.parent,
        suffix=".tmp",
        delete=False,
        encoding="utf-8"
    )
    try:
        tmp.write(content)
        tmp.close()
        os.replace(tmp.name, filepath)   # 原子替换
    except Exception:
        os.unlink(tmp.name)
        raise

# 使用
atomic_write("config.json", '{"key": "value"}')
```

### 8.5 `sqlite3`：内置数据库

Python 自带 SQLite 数据库引擎，无需安装额外服务，轻量且功能完整。

```python
import sqlite3

# 连接数据库（自动创建文件）
conn = sqlite3.connect("app.db")
cur = conn.cursor()

# 创建表
cur.execute("""
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER,
        email TEXT UNIQUE
    )
""")

# 插入数据（参数化查询，防止 SQL 注入）
cur.execute(
    "INSERT INTO users (name, age, email) VALUES (?, ?, ?)",
    ("Alice", 30, "alice@example.com")
)
conn.commit()

# 查询
cur.execute("SELECT * FROM users WHERE age > ?", (25,))
for row in cur.fetchall():
    print(f"ID: {row[0]}, Name: {row[1]}, Age: {row[2]}")

# 使用 Row 作为字典式访问
conn.row_factory = sqlite3.Row
cur = conn.cursor()
cur.execute("SELECT * FROM users LIMIT 1")
row = cur.fetchone()
print(row["name"], row["email"])   # 按列名访问

# 批量操作
users = [
    ("Bob", 25, "bob@example.com"),
    ("Carol", 35, "carol@example.com"),
]
cur.executemany("INSERT INTO users (name, age, email) VALUES (?, ?, ?)", users)
conn.commit()

# 事务管理
try:
    cur.execute("UPDATE users SET age = ? WHERE name = ?", (31, "Alice"))
    conn.commit()
except Exception as e:
    conn.rollback()
    print(f"事务回滚: {e}")

conn.close()

# 工程场景：原型开发、本地缓存、嵌入式应用、数据分析
# 优势：零配置、单文件、标准库自带、支持 SQL
```

---

## 9. 工作实战场景

### 9.1 日志轮转系统

```python
import logging
import logging.handlers
import os
from datetime import datetime

def setup_logging(app_name="app", log_dir="logs", max_size=10*1024*1024, backup_count=5):
    """设置日志轮转系统。"""
    os.makedirs(log_dir, exist_ok=True)
    
    formatter = logging.Formatter(
        "%(asctime)s [%(levelname)s] %(name)s:%(lineno)d: %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S"
    )
    
    # 控制台输出
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.INFO)
    console_handler.setFormatter(formatter)
    
    # 文件输出（按大小轮转）
    file_handler = logging.handlers.RotatingFileHandler(
        os.path.join(log_dir, f"{app_name}.log"),
        maxBytes=max_size,
        backupCount=backup_count,
        encoding="utf-8"
    )
    file_handler.setLevel(logging.INFO)
    file_handler.setFormatter(formatter)
    
    # 错误日志单独文件
    error_handler = logging.handlers.RotatingFileHandler(
        os.path.join(log_dir, f"{app_name}_error.log"),
        maxBytes=max_size,
        backupCount=backup_count,
        encoding="utf-8"
    )
    error_handler.setLevel(logging.ERROR)
    error_handler.setFormatter(formatter)
    
    logger = logging.getLogger(app_name)
    logger.setLevel(logging.DEBUG)
    logger.addHandler(console_handler)
    logger.addHandler(file_handler)
    logger.addHandler(error_handler)
    
    return logger

# 使用示例
logger = setup_logging("myapp")
logger.info("应用启动")
logger.error("数据库连接失败")
```

### 9.2 配置文件热更新

```python
import json
import time
from pathlib import Path

class ConfigManager:
    """配置管理：支持热更新。"""
    
    def __init__(self, config_path):
        self.config_path = Path(config_path)
        self._config = {}
        self._last_modified = 0
        self.load()
    
    def load(self):
        """加载配置文件。"""
        if self.config_path.exists():
            with open(self.config_path, "r", encoding="utf-8") as f:
                self._config = json.load(f)
            self._last_modified = self.config_path.stat().st_mtime
    
    def get(self, key, default=None):
        """获取配置值（自动检测文件变化）。"""
        if self.config_path.exists():
            current_modified = self.config_path.stat().st_mtime
            if current_modified > self._last_modified:
                self.load()
        return self._config.get(key, default)
    
    def watch(self, callback):
        """监听配置文件变化。"""
        while True:
            if self.config_path.exists():
                current_modified = self.config_path.stat().st_mtime
                if current_modified > self._last_modified:
                    self.load()
                    callback(self._config)
            time.sleep(1)

# 使用示例
config = ConfigManager("config.json")

def on_config_change(new_config):
    print(f"配置已更新: {new_config}")

# 后台线程监听配置变化
import threading
threading.Thread(target=config.watch, args=(on_config_change,), daemon=True).start()
```

### 9.3 文件上传与处理

```python
from pathlib import Path
import hashlib
import magic

class FileUploader:
    """文件上传处理器：验证、存储、去重。"""
    
    def __init__(self, upload_dir="uploads", max_size=10*1024*1024):
        self.upload_dir = Path(upload_dir)
        self.max_size = max_size
        self.allowed_types = {"image/jpeg", "image/png", "application/pdf"}
        self.upload_dir.mkdir(parents=True, exist_ok=True)
    
    def _calculate_hash(self, file_path):
        """计算文件 MD5 哈希值。"""
        hash_md5 = hashlib.md5()
        with open(file_path, "rb") as f:
            for chunk in iter(lambda: f.read(8192), b""):
                hash_md5.update(chunk)
        return hash_md5.hexdigest()
    
    def _validate_file(self, file_path):
        """验证文件类型和大小。"""
        # 检查大小
        if file_path.stat().st_size > self.max_size:
            raise ValueError("文件过大")
        
        # 检查类型
        file_type = magic.from_file(str(file_path), mime=True)
        if file_type not in self.allowed_types:
            raise ValueError(f"不支持的文件类型: {file_type}")
        
        return file_type
    
    def upload(self, source_path):
        """上传文件：验证、哈希去重、存储。"""
        source = Path(source_path)
        
        # 验证
        file_type = self._validate_file(source)
        
        # 计算哈希（去重）
        file_hash = self._calculate_hash(source)
        extension = source.suffix.lower()
        target_path = self.upload_dir / f"{file_hash}{extension}"
        
        # 如果已存在，直接返回路径
        if target_path.exists():
            return str(target_path)
        
        # 复制文件
        import shutil
        shutil.copy2(source, target_path)
        
        # 设置权限（可选）
        target_path.chmod(0o644)
        
        return str(target_path)

# 使用示例
uploader = FileUploader()
result = uploader.upload("photo.jpg")
print(f"文件已上传到: {result}")
```

### 9.4 数据导入导出工具

```python
import json
import csv
from pathlib import Path
from datetime import datetime

class DataExporter:
    """数据导入导出工具：支持 JSON/CSV 格式。"""
    
    @staticmethod
    def export_json(data, filepath, **kwargs):
        """导出为 JSON。"""
        kwargs.setdefault("ensure_ascii", False)
        kwargs.setdefault("indent", 2)
        
        with open(filepath, "w", encoding="utf-8") as f:
            json.dump(data, f, **kwargs)
        print(f"数据已导出到: {filepath}")
    
    @staticmethod
    def import_json(filepath):
        """从 JSON 导入。"""
        with open(filepath, "r", encoding="utf-8") as f:
            return json.load(f)
    
    @staticmethod
    def export_csv(data, filepath, headers=None):
        """导出为 CSV。"""
        with open(filepath, "w", newline="", encoding="utf-8") as f:
            writer = csv.writer(f)
            
            # 如果提供了表头，先写表头
            if headers:
                writer.writerow(headers)
            
            # 写入数据
            if isinstance(data, list) and isinstance(data[0], dict):
                # 字典列表，使用表头
                if not headers:
                    headers = data[0].keys()
                    writer.writerow(headers)
                for row in data:
                    writer.writerow([row.get(h) for h in headers])
            else:
                # 普通列表
                writer.writerows(data)
        print(f"数据已导出到: {filepath}")
    
    @staticmethod
    def import_csv(filepath):
        """从 CSV 导入（返回字典列表）。"""
        with open(filepath, "r", encoding="utf-8") as f:
            reader = csv.DictReader(f)
            return list(reader)

# 使用示例
data = [
    {"name": "Alice", "age": 30, "city": "Beijing"},
    {"name": "Bob", "age": 25, "city": "Shanghai"},
]

exporter = DataExporter()
exporter.export_json(data, "users.json")
exporter.export_csv(data, "users.csv")

# 导入
loaded_data = exporter.import_json("users.json")
csv_data = exporter.import_csv("users.csv")
```

---

## 10. 常见面试题汇总

### 10.1 基础概念题

**Q1：`with` 语句的作用是什么？它的原理是什么？**

**A**：`with` 语句用于自动管理资源（文件、锁、数据库连接等），确保资源在使用完毕后被正确释放，即使发生异常也会释放。

原理：实现了上下文管理器协议，即对象必须实现 `__enter__` 和 `__exit__` 方法：
- `__enter__`：进入 `with` 块时调用，返回资源对象
- `__exit__`：退出 `with` 块时调用，负责资源清理

---

**Q2：文件打开模式 `r`、`w`、`a`、`x` 的区别？**

**A**：
- `r`：只读（默认），文件不存在报错
- `w`：写入（覆盖），文件不存在创建，存在清空
- `a`：追加，文件不存在创建，指针在末尾
- `x`：独占创建，文件已存在则报错

---

**Q3：`pathlib` 相比 `os.path` 有什么优势？**

**A**：
1. **面向对象**：路径是对象而非字符串，支持方法调用
2. **操作符重载**：使用 `/` 进行路径拼接，更直观
3. **链式调用**：`Path("a") / "b" / "c"` 可以连续操作
4. **统一接口**：文件操作（read_text/write_text）直接在路径对象上调用
5. **跨平台**：自动处理不同操作系统的路径分隔符

---

**Q4：JSON 和 Pickle 的区别？**

**A**：

| 特性 | JSON | Pickle |
|------|------|--------|
| 格式 | 文本，人类可读 | 二进制 |
| 跨语言 | 是 | 否（仅限 Python） |
| 安全性 | 安全 | 不安全（不要加载不信任的数据） |
| 对象支持 | 基础类型 | 几乎所有 Python 对象 |

---

**Q5：什么是原子写入？为什么需要原子写入？**

**A**：原子写入是指文件写入操作要么完全成功，要么完全不写。使用临时文件写入后再原子替换的方式实现。

原因：避免写入过程中发生异常（如断电、磁盘满）导致文件损坏或内容不完整。

---

### 10.2 实战应用题

**Q6：如何处理大文件（GB 级别）？**

**A**：
1. **逐行读取**：`for line in f:`（最省内存）
2. **分块读取**：`f.read(chunk_size)`，每次读取固定大小
3. **内存映射**：`mmap` 模块，像操作内存一样操作文件
4. **生成器**：使用 `yield` 分块处理，避免一次性加载

---

**Q7：如何实现文件上传的去重功能？**

**A**：
1. 计算文件的哈希值（MD5/SHA256）
2. 使用哈希值作为文件名存储
3. 上传前检查哈希值是否已存在
4. 如果已存在，直接返回已有路径

---

**Q8：如何安全地处理用户上传的文件？**

**A**：
1. **验证文件类型**：检查 MIME 类型和文件头
2. **限制文件大小**：防止大文件攻击
3. **重命名文件**：使用哈希值或随机字符串，避免路径遍历攻击
4. **存储在非 Web 可访问目录**：或使用安全的文件服务
5. **扫描病毒**：使用 ClamAV 等工具
6. **设置合理的文件权限**：避免执行权限

---

**Q9：如何实现配置文件的热更新？**

**A**：
1. 定期检查配置文件的修改时间
2. 如果文件被修改，重新加载配置
3. 使用线程或定时器后台监听
4. 提供回调函数处理配置变化

---

**Q10：`sqlite3` 的适用场景是什么？**

**A**：
- 原型开发、本地缓存、嵌入式应用、数据分析
- 优势：零配置、单文件、标准库自带、支持 SQL
- 不适用：高并发、大规模数据、多进程写入

---

### 10.3 代码分析题

**Q11：分析以下代码的问题：**

```python
f = open("data.txt", "w")
f.write("hello")
# 没有调用 f.close()
```

**A**：没有关闭文件，可能导致：
1. 数据未立即写入磁盘（缓冲问题）
2. 文件句柄泄漏
3. 程序退出时才能释放资源

应使用 `with` 语句：
```python
with open("data.txt", "w") as f:
    f.write("hello")
```

---

**Q12：分析以下代码的问题：**

```python
import json

data = {"name": "张三", "age": 30}
with open("data.json", "w") as f:
    json.dump(data, f)
```

**A**：中文会被转义为 Unicode 编码（如 `\u5f20\u4e09`），可读性差。应添加 `ensure_ascii=False`：
```python
json.dump(data, f, ensure_ascii=False, indent=2)
```

---

**Q13：以下代码能否正确读取大文件？为什么？**

```python
with open("huge_file.txt", "r") as f:
    content = f.read()
print(content)
```

**A**：不能。`f.read()` 会一次性读取整个文件到内存，如果文件过大（如 GB 级别），会导致内存溢出。应使用逐行读取或分块读取：
```python
with open("huge_file.txt", "r") as f:
    for line in f:
        process(line)
```

---

## 11. 实战项目：文件管理工具

### 11.1 项目概述

**项目目标**：开发一个命令行文件管理工具 `filetool`，支持文件压缩、解压、搜索、批量重命名等功能。

**功能需求**：
- `filetool compress <dir>` - 压缩目录
- `filetool extract <archive>` - 解压归档
- `filetool search <pattern>` - 搜索文件
- `filetool rename <pattern> <replace>` - 批量重命名
- `filetool hash <file>` - 计算文件哈希

### 11.2 项目结构

```
filetool/
├── README.md
├── pyproject.toml
├── src/
│   └── filetool/
│       ├── __init__.py
│       ├── __main__.py
│       ├── cli.py
│       ├── commands/
│       │   ├── __init__.py
│       │   ├── compress.py
│       │   ├── extract.py
│       │   ├── search.py
│       │   ├── rename.py
│       │   └── hash.py
│       └── utils/
│           ├── __init__.py
│           └── helpers.py
└── tests/
    ├── __init__.py
    └── test_filetool.py
```

### 11.3 核心代码

**pyproject.toml**：

```toml
[build-system]
requires = ["setuptools>=61.0", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "filetool"
version = "1.0.0"
description = "A command-line file management tool"
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
filetool = "filetool.cli:main"

[tool.setuptools.packages.find]
where = ["src"]
```

**cli.py**：

```python
import click
import importlib
import os

@click.group()
def main():
    """FileTool - 文件管理工具"""
    pass

def _load_commands():
    commands_dir = os.path.join(os.path.dirname(__file__), "commands")
    for filename in os.listdir(commands_dir):
        if filename.endswith(".py") and not filename.startswith("_"):
            module_name = filename[:-3]
            module = importlib.import_module(f"filetool.commands.{module_name}")
            if hasattr(module, "command"):
                main.add_command(module.command)

_load_commands()
```

**commands/compress.py**：

```python
import click
import tarfile
import os

@click.command("compress")
@click.argument("source")
@click.option("-o", "--output", help="输出文件名")
@click.option("-f", "--format", default="gz", type=click.Choice(["gz", "bz2", "xz"]))
def command(source, output, format):
    """压缩目录或文件。"""
    if output is None:
        output = f"{os.path.basename(source)}.tar.{format}"
    
    mode = f"w:{format}"
    with tarfile.open(output, mode) as tf:
        tf.add(source, arcname=os.path.basename(source))
    
    click.echo(f"压缩完成: {output}")
```

**commands/search.py**：

```python
import click
import os
import fnmatch

@click.command("search")
@click.argument("pattern")
@click.option("-d", "--directory", default=".", help="搜索目录")
def command(pattern, directory):
    """搜索匹配模式的文件。"""
    matches = []
    for root, dirs, files in os.walk(directory):
        for filename in files:
            if fnmatch.fnmatch(filename, pattern):
                matches.append(os.path.join(root, filename))
    
    if matches:
        click.echo(f"找到 {len(matches)} 个文件:")
        for filepath in matches:
            click.echo(f"  {filepath}")
    else:
        click.echo("未找到匹配的文件")
```

**commands/rename.py**：

```python
import click
import os
import re

@click.command("rename")
@click.argument("pattern")
@click.argument("replace")
@click.option("-d", "--directory", default=".", help="操作目录")
@click.option("-n", "--dry-run", is_flag=True, help="模拟运行，不实际修改")
def command(pattern, replace, directory, dry_run):
    """批量重命名文件。"""
    count = 0
    for filename in os.listdir(directory):
        new_name = re.sub(pattern, replace, filename)
        if new_name != filename:
            old_path = os.path.join(directory, filename)
            new_path = os.path.join(directory, new_name)
            
            if dry_run:
                click.echo(f"[模拟] {filename} -> {new_name}")
            else:
                os.rename(old_path, new_path)
                click.echo(f"{filename} -> {new_name}")
            count += 1
    
    click.echo(f"共重命名 {count} 个文件")
```

**commands/hash.py**：

```python
import click
import hashlib
import os

@click.command("hash")
@click.argument("file")
@click.option("-a", "--algorithm", default="md5", type=click.Choice(["md5", "sha256"]))
def command(file, algorithm):
    """计算文件哈希值。"""
    hash_obj = hashlib.new(algorithm)
    
    with open(file, "rb") as f:
        for chunk in iter(lambda: f.read(8192), b""):
            hash_obj.update(chunk)
    
    click.echo(f"{algorithm.upper()}: {hash_obj.hexdigest()}")
```

**utils/helpers.py**：

```python
import os

def validate_path(path):
    """验证路径是否存在。"""
    if not os.path.exists(path):
        raise FileNotFoundError(f"路径不存在: {path}")
    return path

def get_file_size(path):
    """获取文件大小（人类可读格式）。"""
    size = os.path.getsize(path)
    for unit in ["B", "KB", "MB", "GB"]:
        if size < 1024:
            return f"{size:.2f} {unit}"
        size /= 1024
    return f"{size:.2f} TB"
```

### 11.4 项目运行

```bash
# 开发模式安装
pip install -e .

# 使用命令
filetool compress project/          # 压缩目录
filetool extract archive.tar.gz    # 解压归档
filetool search "*.py"             # 搜索 Python 文件
filetool rename "(\d+)-" ""        # 批量重命名（去掉数字前缀）
filetool hash data.zip             # 计算文件哈希

# 或者使用 python -m
python -m filetool hash data.zip
```

### 11.5 项目亮点

1. **功能丰富**：覆盖文件压缩、解压、搜索、重命名、哈希计算等常用操作
2. **模块化设计**：每个命令独立模块，易于扩展
3. **安全可靠**：批量操作支持 dry-run 模式，避免误操作
4. **用户友好**：使用 click 库提供丰富的命令行参数和帮助信息

---

## 附录：第六阶段自检清单

在继续学习第七阶段之前，请确保你能：

- [ ] 使用 `with` 语句正确打开和关闭文件，并解释其原理
- [ ] 区分文本模式和二进制模式，知道何时使用哪种
- [ ] 使用 `pathlib` 完成文件路径的拼接、解析、遍历等操作
- [ ] 用 `json` 序列化/反序列化 Python 对象，处理中文和自定义类型
- [ ] 解释 JSON 和 Pickle 的区别，以及各自的安全注意事项
- [ ] 使用 `csv.DictReader` 和 `csv.DictWriter` 读写 CSV
- [ ] 使用 `zipfile`、`tarfile`、`gzip` 进行压缩和解压
- [ ] 使用 `StringIO` / `BytesIO` 在内存中处理流数据
- [ ] 实现大文件的分块读取，避免内存溢出
- [ ] 使用临时文件和临时目录，并了解自动清理机制
- [ ] 实现文件的原子写入操作
- [ ] 使用 `sqlite3` 进行基本的数据库操作（增删改查）

---

> **工程师寄语**：文件 I/O 是最容易出问题的领域——编码错误、路径分隔符、并发写入、磁盘满……永远假设文件操作会失败，并做好错误处理。`pathlib` 让路径操作从"字符串拼接"变成了"对象操作"，这是 Python 3 带来的最大生产力提升之一。

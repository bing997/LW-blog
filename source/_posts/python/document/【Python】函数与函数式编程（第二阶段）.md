---
title: 【Python】函数与函数式编程（第二阶段）
date: 2026-07-22 11:00:00
categories:
  - Python
tags:
  - Python
  - 教程
  - 函数式编程
description: 从函数定义到函数式编程范式，系统掌握 Python 中"一等公民"函数、参数系统、作用域、闭包、装饰器与生成器。
cover: /images/cover.png
---

# 二、函数与函数式编程

> **阶段定位**：函数是 Python 中"一等公民"（First-Class Citizen），理解函数的本质是掌握 Python 高级特性的基石。本阶段从函数定义延伸到函数式编程范式，帮你建立"以函数组合解决问题"的编程思维。

---

## 0. 本章知识地图

在深入学习之前，先用一张图看清本章的知识脉络：

```text
函数基础
├── 函数是对象（赋值、传递、返回、存储）
├── 定义与 return
└── 多返回值与解包

参数系统
├── 传对象引用
├── 位置参数 / 关键字参数
├── 默认参数陷阱
├── *args / **kwargs
├── 参数顺序规则
└── 类型注解

作用域
├── LEGB 规则
├── global / nonlocal
└── 为闭包做准备

函数式工具
├── lambda
├── 高阶函数 map / filter / reduce
├── 闭包
├── 装饰器
├── 递归
└── 生成器

工程实践
├── 纯函数与副作用
├── functools 模块
└── itertools 模块
```

> 配图占位：建议在这里放一张"Python 函数与函数式编程知识地图"思维导图，文件路径 `/images/python/phase2_mindmap.png`。

---

## 1. 函数定义与调用

### 1.1 函数的本质：一切都是对象

在 Python 中，**函数是对象**。这意味着函数可以：
- 赋值给变量
- 作为参数传递给其他函数
- 作为其他函数的返回值
- 存储在数据结构（列表、字典）中

```python
def greet(name):
    return f"Hello, {name}!"

# 函数是对象，可以赋值
say_hi = greet
print(say_hi("Alice"))   # Hello, Alice!
print(say_hi is greet)   # True —— 指向同一个函数对象

# 函数可以存储在字典中（策略模式的基础）
operations = {
    "add": lambda a, b: a + b,
    "mul": lambda a, b: a * b,
}
print(operations["add"](3, 4))   # 7
```

**函数对象的重要属性**：

| 属性 | 含义 | 示例 |
|------|------|------|
| `__name__` | 函数名 | `greet.__name__` → `'greet'` |
| `__doc__` | 文档字符串 | `greet.__doc__` |
| `__defaults__` | 默认参数值元组 | 用于调试 |
| `__code__` | 代码对象 | 包含字节码、局部变量名等 |
| `__call__` | 使对象可被调用 | `greet()` 等价于 `greet.__call__(...)` |

```python
import inspect

def sample(a, b=10, *args, c=20, **kwargs):
    """示例函数。"""
    pass

print(sample.__name__)              # sample
print(sample.__doc__)               # 示例函数。
print(sample.__defaults__)          # (10,)
print(sample.__kwdefaults__)        # {'c': 20}
print(inspect.signature(sample))    # (a, b=10, *args, c=20, **kwargs)
```

**面试真题**：Python 中函数是"一等公民"体现在哪些方面？

### 1.2 函数定义与 return

```python
def calculate(x, y, op="add"):
    """执行基础运算。

    Args:
        x: 左操作数
        y: 右操作数
        op: 操作类型，可选 "add" | "sub" | "mul" | "div"

    Returns:
        运算结果

    Raises:
        ValueError: 当 op 不支持时
        ZeroDivisionError: 除零时
    """
    if op == "add":
        return x + y
    if op == "sub":
        return x - y
    if op == "mul":
        return x * y
    if op == "div":
        return x / y
    raise ValueError(f"不支持的操作: {op}")

# 没有显式 return 的函数，默认返回 None
def log_message(msg):
    print(f"[LOG] {msg}")
    # 隐式 return None

result = log_message("test")
print(result)   # None
```

**文档字符串规范（Google Style）**：

```python
def fetch_user(user_id, include_deleted=False):
    """根据用户 ID 获取用户信息。

    Args:
        user_id: 用户唯一标识，正整数。
        include_deleted: 是否包含已删除用户，默认为 False。

    Returns:
        dict: 用户信息字典；未找到时返回 None。

    Raises:
        ValueError: user_id 不是正整数时。
    """
    if not isinstance(user_id, int) or user_id <= 0:
        raise ValueError("user_id 必须是正整数")
    # ...
```

**工程建议**：
- 函数只做一件事（Single Responsibility），过长时考虑拆分。
- 函数名应当是动词或动词短语：`get_user()`、`validate_email()`、`send_notification()`。
- 返回 `None` 要明确，不要依赖隐式返回。
- 避免使用隐式返回作为有意义的业务结果。

### 1.3 多返回值与解包

```python
def get_min_max(numbers):
    """同时返回最小值和最大值。"""
    if not numbers:
        return None, None      # 多返回值本质是返回一个元组
    return min(numbers), max(numbers)

minimum, maximum = get_min_max([3, 1, 4, 1, 5, 9])
print(minimum, maximum)   # 1 9

# 也可以只取其中一个
min_val, _ = get_min_max([3, 1, 4])   # _ 表示"忽略这个值"
```

**解包的高级用法**：

```python
# 扩展解包（3.0+）
first, *middle, last = [1, 2, 3, 4, 5]
print(first, middle, last)   # 1 [2, 3, 4] 5

# 嵌套解包
(a, b), (c, d) = (1, 2), (3, 4)
print(a, b, c, d)            # 1 2 3 4

# 使用 namedtuple 让多返回值更可读
from collections import namedtuple

Point = namedtuple("Point", ["x", "y"])
def get_origin():
    return Point(0, 0)

origin = get_origin()
print(origin.x, origin.y)    # 0 0
```

---

## 2. 参数系统（面试高频）

### 2.1 Python 的传参机制：传对象引用

Python 的参数传递机制是**"传对象引用"**（Pass by Object Reference）—— 传入的是对象的引用，而非值本身。

```text
调用函数时：
  实参变量 ──→ 对象 ←── 形参变量
              （同一个对象）
```

```python
def try_change(x):
    x = 100          # 让 x 指向新的整数对象 100

a = 1
try_change(a)
print(a)             # 1 —— 不变，因为整数不可变

def append_one(lst):
    lst.append(1)    # 在原地修改列表对象

my_list = [0]
append_one(my_list)
print(my_list)       # [0, 1] —— 变了，因为列表可变
```

**判断口诀**：
- 函数内对参数**重新赋值**，不影响外部（指向了新对象）。
- 函数内对参数**原地修改**，会影响外部（同一对象被修改）。

**面试真题**：Python 是值传递还是引用传递？
> 答：都不是，Python 是"传对象引用"。对于不可变对象（int、str、tuple），效果类似值传递；对于可变对象（list、dict），效果类似引用传递。

### 2.2 参数类型总览

Python 3.8+ 支持完整的参数分类：

```python
def demo(pos, /, pos_or_kw, *, kw_only, **kwargs):
    """参数分类演示（3.8+ 语法）。

    pos:        仅限位置参数（/ 左侧）
    pos_or_kw:  位置或关键字参数（/ 和 * 之间）
    kw_only:    仅限关键字参数（* 右侧）
    **kwargs:   接收多余关键字参数
    """
    print(f"pos={pos}, pos_or_kw={pos_or_kw}, kw_only={kw_only}, kwargs={kwargs}")

# 正确调用
demo(1, 2, kw_only=3, extra="x")
# pos=1, pos_or_kw=2, kw_only=3, kwargs={'extra': 'x'}

demo(1, pos_or_kw=2, kw_only=3)
# pos=1, pos_or_kw=2, kw_only=3, kwargs={}

# 错误调用
demo(pos=1, pos_or_kw=2, kw_only=3)
# TypeError: pos 是仅限位置参数
```

**参数分类速查表**：

| 参数类型 | 语法位置 | 调用方式 | 典型用途 |
|----------|----------|----------|----------|
| 仅限位置 | `/` 左侧 | 只能位置 | 内部参数、避免破坏兼容性 |
| 位置或关键字 | `/` 和 `*` 之间 | 任意 | 最常见的参数 |
| 仅限关键字 | `*` 右侧 | 只能关键字 | 提高可读性、明确语义 |
| `*args` | 接收多余位置 | 自动打包 | 变长参数、转发 |
| `**kwargs` | 接收多余关键字 | 自动打包 | 变长参数、配置转发 |

> 配图占位：建议放一张"Python 参数类型示意图"，文件路径 `/images/python/phase2_parameters.png`。

### 2.3 位置参数与关键字参数

```python
def create_user(name, age, active=True, role="user"):
    return {"name": name, "age": age, "active": active, "role": role}

# 位置调用（顺序必须正确）
create_user("Alice", 30)

# 关键字调用（顺序无关，可读性更好）
create_user(name="Bob", age=25, role="admin")

# 混合调用：位置参数必须在关键字参数之前
create_user("Carol", 28, role="moderator")   # 正确
create_user(name="Dave", 35)                  # 正确（但可读性一般，不推荐）
# create_user(age=40, "Eve")                  # SyntaxError！位置参数不能在关键字参数后
```

**工程建议**：调用函数时，超过 2-3 个参数尽量使用关键字参数，提高可读性：

```python
# 糟糕：不知道每个数字的含义
set_timeout(30, True, False)

# 优秀：一目了然
set_timeout(seconds=30, retry=True, fail_silent=False)
```

### 2.4 默认参数值

```python
def connect(host, port=3306, timeout=30):
    print(f"Connecting to {host}:{port}, timeout={timeout}s")

connect("localhost")                    # 使用全部默认值
connect("localhost", 5432)              # 覆盖 port
connect("localhost", timeout=60)        # 只覆盖 timeout（关键字参数）
```

**经典陷阱：可变对象作为默认参数**

```python
# 错误示范（面试必考）
def append_item(item, items=[]):
    items.append(item)
    return items

print(append_item(1))   # [1]
print(append_item(2))   # [1, 2] —— 默认参数在函数定义时求值，items 被共享了！

# 正确做法
def append_item_safe(item, items=None):
    if items is None:
        items = []
    items.append(item)
    return items

print(append_item_safe(1))   # [1]
print(append_item_safe(2))   # [2] —— 每次调用都是独立的列表
```

**原理剖析**：

```text
函数定义时：
  def append_item(item, items=[]) -> 创建一个空列表对象 L

第一次 append_item(1)：
  items 指向 L，L 变为 [1]

第二次 append_item(2)：
  items 仍然指向 L，L 变为 [1, 2]
```

默认参数值在函数定义时（模块加载时）求值一次，后续调用复用同一个对象。不可变类型（`int`、`str`、`tuple`）作为默认值是安全的，但可变类型（`list`、`dict`、`set`）必须使用 `None` 作为占位符。

**面试真题**：下面代码输出什么？为什么？

```python
def add_end(L=[]):
    L.append("END")
    return L

print(add_end())
print(add_end())
```
> 答：两次都输出 `['END', 'END']`，因为默认参数在定义时求值，列表被所有调用共享。

### 2.5 可变参数：`*args` 与 `**kwargs`

```python
def flexible(*args, **kwargs):
    """*args 接收多余的位置参数，打包成元组。
       **kwargs 接收多余的关键字参数，打包成字典。"""
    print(f"位置参数: {args}")
    print(f"关键字参数: {kwargs}")

flexible(1, 2, 3, name="Alice", age=30)
# 位置参数: (1, 2, 3)
# 关键字参数: {'name': 'Alice', 'age': 30}
```

**拆包（Unpacking）调用**：

```python
def sum_three(a, b, c):
    return a + b + c

nums = [1, 2, 3]
print(sum_three(*nums))   # 6，等价于 sum_three(1, 2, 3)

config = {"a": 1, "b": 2, "c": 3}
print(sum_three(**config))   # 6，等价于 sum_three(a=1, b=2, c=3)

# 组合拆包
data = [1, 2]
print(sum_three(*data, c=3))   # 6
```

**实战：函数参数转发**

```python
import logging

def logged(func):
    """装饰器：记录函数调用日志（后续会详细讲解装饰器）。"""
    def wrapper(*args, **kwargs):
        logging.info(f"Calling {func.__name__} with args={args}, kwargs={kwargs}")
        return func(*args, **kwargs)
    return wrapper

@logged
def compute(x, y, operation="add"):
    if operation == "add":
        return x + y
    return x - y

compute(10, 5, operation="sub")
# 日志: Calling compute with args=(10, 5), kwargs={'operation': 'sub'}
```

### 2.6 参数顺序规则（必须遵守）

```python
def correct(a, b=2, /, c=3, d=4, *, e=5, f=6):
    """正确顺序：
    1. 仅限位置参数（可有默认值）
    2. / 分隔符
    3. 位置或关键字参数（可有默认值）
    4. * 分隔符
    5. 仅限关键字参数（可有默认值）
    6. **kwargs
    """
    pass

# 常见错误
# def wrong(a=1, b):        # SyntaxError: 有默认值的参数不能放在无默认值参数前
# def wrong2(*args, a):     # SyntaxError: *args 后的普通参数必须是仅限关键字
```

### 2.7 类型注解（Type Hints）

Python 3.5+ 支持类型注解，虽然运行时不强制，但能显著提升代码可维护性。

```python
from typing import List, Dict, Optional, Union, Callable

def greet(name: str, times: int = 1) -> str:
    return (f"Hello, {name}!\n") * times

def process_users(users: List[Dict[str, Union[str, int]]]) -> List[str]:
    return [user["name"] for user in users if user.get("active")]

def find_user(user_id: int) -> Optional[Dict]:
    # 可能返回 None
    pass

def apply_operation(a: int, b: int, op: Callable[[int, int], int]) -> int:
    return op(a, b)
```

**常用类型注解速查**：

| 类型 | 含义 | 示例 |
|------|------|------|
| `int`, `str`, `float`, `bool` | 基本类型 | `x: int` |
| `List[T]` | 列表 | `items: List[int]` |
| `Dict[K, V]` | 字典 | `config: Dict[str, Any]` |
| `Optional[T]` | T 或 None | `name: Optional[str]` |
| `Union[T1, T2]` | 多种类型之一 | `value: Union[int, str]` |
| `Callable[[Arg], Ret]` | 可调用对象 | `fn: Callable[[int], str]` |
| `Any` | 任意类型 | `data: Any` |

**面试真题**：Python 类型注解在运行时会检查吗？
> 答：不会。类型注解主要用于静态类型检查工具（如 mypy）、IDE 提示和文档。运行时不会进行类型强制校验。

---

## 3. 作用域与 LEGB 规则

### 3.1 命名空间与作用域层级

Python 查找变量的顺序遵循 **LEGB 规则**：

| 层级 | 含义 | 范围 |
|------|------|------|
| **L**ocal | 局部作用域 | 当前函数内部 |
| **E**nclosing | 嵌套作用域 | 外层（闭包）函数 |
| **G**lobal | 全局作用域 | 当前模块顶层 |
| **B**uilt-in | 内置作用域 | `builtins` 模块 |

```python
x = "global"          # G: 全局作用域

def outer():
    x = "enclosing"   # E: 嵌套作用域

    def inner():
        x = "local"   # L: 局部作用域
        print(x)      # 查找顺序: L -> E -> G -> B，输出 "local"

    inner()

outer()
```

> 配图占位：建议放一张"LEGB 作用域查找顺序"示意图，文件路径 `/images/python/phase2_legb.png`。

### 3.2 `global` 声明

```python
counter = 0

def increment():
    global counter      # 声明：我要修改全局变量 counter
    counter += 1

increment()
print(counter)          # 1
```

**工程建议**：
- 尽量避免使用 `global`，它破坏函数的纯粹性和可测试性。
- 需要共享状态时，考虑使用类封装或使用闭包。

### 3.3 `nonlocal` 声明

```python
def make_counter():
    count = 0           # E: 外层（闭包）变量

    def increment():
        nonlocal count  # 声明：我要修改外层（非全局）变量
        count += 1
        return count

    return increment

counter_a = make_counter()
print(counter_a())      # 1
print(counter_a())      # 2

counter_b = make_counter()
print(counter_b())      # 1 —— 独立的计数器
```

**`global` vs `nonlocal` 对比**：

| 特性 | `global` | `nonlocal` |
|------|----------|------------|
| 修改目标 | 模块级全局变量 | 外层（闭包）函数的局部变量 |
| 使用场景 | 全局状态管理（不推荐） | 闭包状态保持 |
| 报错条件 | 变量不存在时创建 | 变量必须已存在在外层作用域 |

### 3.4 `locals()` 与 `globals()`

```python
def show_scope():
    x = 10
    print(locals())    # {'x': 10}

show_scope()
print(globals().keys())  # 包含全局变量、导入的模块等
```

**注意事项**：
- `locals()` 返回的字典不要修改，行为不可靠。
- `globals()` 返回的字典可以修改，但不推荐。

---

## 4. 匿名函数 `lambda`

### 4.1 基本语法与使用场景

```python
# 基本语法：lambda 参数: 表达式
square = lambda x: x ** 2
print(square(5))        # 25

# 多参数
add = lambda x, y: x + y
print(add(3, 4))        # 7

# 实际场景：作为排序/映射的短回调
users = [
    {"name": "Alice", "age": 30},
    {"name": "Bob", "age": 25},
    {"name": "Carol", "age": 35},
]
users.sort(key=lambda u: u["age"])   # 按年龄排序
print([u["name"] for u in users])    # ['Bob', 'Alice', 'Carol']
```

### 4.2 lambda 的限制

- 只能包含一个表达式，不能写语句（如赋值、循环）。
- 没有文档字符串，调试时显示为 `<lambda>`。
- 不能包含复杂的错误处理。

```python
# 错误的 lambda
# lambda x: if x > 0: return x   # SyntaxError
# lambda x: y = x + 1            # SyntaxError，不能赋值
```

### 4.3 lambda vs def

| 特性 | lambda | def |
|------|--------|-----|
| 名称 | 匿名 | 有名称 |
| 复杂度 | 单行表达式 | 任意复杂 |
| 可读性 | 简单场景好 | 复杂场景好 |
| 调试 | 显示 `<lambda>` | 显示真实函数名 |
| 文档字符串 | 无 | 有 |

**工程建议**：
- 简单的一行表达式用 `lambda`，复杂逻辑用 `def` 定义命名函数。
- 若 `lambda` 超过一行，说明它不应该用 `lambda`。

```python
# 不好的 lambda
process = lambda data: [x.strip().lower() for x in data if x.startswith("http")]

# 好的命名函数
def extract_urls(data):
    """从数据中筛选并处理 URL。"""
    return [x.strip().lower() for x in data if x.startswith("http")]
```

**面试真题**：lambda 能包含多个语句吗？
> 答：不能。lambda 只能包含一个表达式，不能包含语句（如赋值、循环、try/except）。

---

## 5. 高阶函数

**高阶函数**：接收函数作为参数，或返回函数的函数。

### 5.1 `map`、`filter`、`reduce`

```python
from functools import reduce

nums = [1, 2, 3, 4, 5]

# map: 对每个元素应用函数
squares = list(map(lambda x: x ** 2, nums))
print(squares)          # [1, 4, 9, 16, 25]

# 更 Pythonic 的方式：列表推导式
squares = [x ** 2 for x in nums]   # 推荐！可读性更好

# filter: 筛选满足条件的元素
evens = list(filter(lambda x: x % 2 == 0, nums))
print(evens)            # [2, 4]

# 更 Pythonic 的方式
evens = [x for x in nums if x % 2 == 0]   # 推荐！

# reduce: 累积计算
product = reduce(lambda acc, x: acc * x, nums, 1)
print(product)          # 120（1*2*3*4*5）

# reduce 的替代方案
from operator import mul
product = 1
for x in nums:
    product *= x
# 或
import math
product = math.prod(nums)   # 3.8+，最简洁
```

**工程建议**：
- 优先使用**列表推导式**和**生成器表达式**替代 `map`/`filter`，可读性更好。
- `reduce` 的使用场景较少，能不用就不用。

### 5.2 使用 operator 模块避免 lambda

```python
from operator import add, mul, itemgetter, attrgetter

# 替代 lambda x, y: x + y
print(reduce(add, [1, 2, 3, 4]))    # 10

# 替代 lambda u: u["age"]
users = [{"name": "Alice", "age": 30}, {"name": "Bob", "age": 25}]
users.sort(key=itemgetter("age"))

# 替代 lambda obj: obj.name
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

people = [Person("Alice", 30), Person("Bob", 25)]
people.sort(key=attrgetter("age"))
```

### 5.3 自定义高阶函数

```python
def create_multiplier(factor):
    """返回一个乘以 factor 的函数。"""
    def multiply(x):
        return x * factor
    return multiply

triple = create_multiplier(3)
print(triple(5))        # 15

double = create_multiplier(2)
print(double(7))        # 14
```

### 5.4 函数组合

```python
from functools import reduce

def compose(*functions):
    """函数组合：compose(f, g, h)(x) == f(g(h(x)))"""
    def composed(value):
        return reduce(lambda acc, fn: fn(acc), reversed(functions), value)
    return composed

# 使用示例
def add_one(x): return x + 1
def double(x): return x * 2
def to_str(x): return str(x)

transform = compose(to_str, double, add_one)
print(transform(3))   # "8"  -> (3 + 1) * 2 -> "8"
```

> 配图占位：建议放一张"函数组合流程图"，文件路径 `/images/python/phase2_compose.png`。

---

## 6. 闭包（Closure）

### 6.1 闭包的定义

**闭包**：一个函数记住了它被创建时的环境（外层作用域的变量），即使外层函数已经执行完毕。

```python
def make_power(exponent):
    """创建计算 x^n 的函数。"""
    def power(base):
        return base ** exponent    # power 记住了外层变量 exponent
    return power

square = make_power(2)   # exponent=2 被"捕获"
cube = make_power(3)     # exponent=3 被"捕获"

print(square(4))         # 16
print(cube(3))           # 27
```

**闭包的本质**：

```text
make_power(2) 调用时：
  创建局部变量 exponent = 2
  创建函数 power
  power.__closure__ 中保存了对 exponent 的引用

make_power 返回后：
  局部变量 exponent 本应被销毁
  但因为闭包引用了它，所以被保留

square(4) 调用时：
  power 通过闭包找到 exponent = 2
  计算 4 ** 2 = 16
```

```python
print(square.__closure__)           # (<cell at ...: int object at ...>,)
print(square.__closure__[0].cell_contents)  # 2
```

### 6.2 闭包的实际应用

```python
def make_logger(level):
    """创建带有固定日志级别的日志函数。"""
    def log(message):
        print(f"[{level.upper()}] {message}")
    return log

info_log = make_logger("info")
error_log = make_logger("error")

info_log("服务启动成功")     # [INFO] 服务启动成功
error_log("数据库连接失败")   # [ERROR] 数据库连接失败
```

### 6.3 闭包的陷阱：延迟绑定

```python
# 经典的闭包陷阱（面试高频）
functions = []
for i in range(3):
    def func():
        return i          # 闭包捕获的是变量 i，不是值 0/1/2
    functions.append(func)

print(functions[0]())    # 2（不是 0！）
print(functions[1]())    # 2
print(functions[2]())    # 2

# 原因：循环结束时 i=2，所有 func 都引用了同一个 i

# 修复方法：使用默认参数绑定当前值
functions = []
for i in range(3):
    def func(x=i):        # x 在定义时绑定当前 i 的值
        return x
    functions.append(func)

print(functions[0]())    # 0
print(functions[1]())    # 1
print(functions[2]())    # 2
```

**面试真题**：为什么下面的 lambda 列表输出都是 4？

```python
funcs = [(lambda: i) for i in range(5)]
print([f() for f in funcs])   # [4, 4, 4, 4, 4]
```
> 答：与闭包延迟绑定同理，所有 lambda 都引用了同一个 `i`，循环结束时 `i=4`。

---

## 7. 装饰器（Decorator）

装饰器是闭包的高级应用，用于**在不修改原函数代码的前提下，增强函数功能**。

> 配图占位：建议放一张"装饰器工作原理"示意图，文件路径 `/images/python/phase2_decorator.png`。

### 7.1 装饰器基础

```python
import functools
import time

def timing(func):
    """计算函数执行时间的装饰器。"""
    @functools.wraps(func)      # 保留原函数的元数据（__name__、__doc__ 等）
    def wrapper(*args, **kwargs):
        start = time.perf_counter()
        result = func(*args, **kwargs)
        elapsed = time.perf_counter() - start
        print(f"{func.__name__} 耗时: {elapsed:.4f}s")
        return result
    return wrapper

@timing
def slow_function(n):
    """模拟耗时操作。"""
    time.sleep(0.1)
    return n * 2

result = slow_function(5)
# 输出: slow_function 耗时: 0.1002s
```

**装饰器执行过程**：

```text
@timing
 def slow_function(n): ...

等价于：
 slow_function = timing(slow_function)

调用 slow_function(5) 时：
 实际调用 wrapper(5)
 wrapper 记录开始时间
 wrapper 调用原 slow_function(5)
 wrapper 记录结束时间并打印
 wrapper 返回结果
```

### 7.2 `@functools.wraps` 的作用

```python
# 不使用 wraps
@timing
def my_func():
    """我的函数。"""
    pass

print(my_func.__name__)   # "wrapper" —— 元数据丢失！
print(my_func.__doc__)    # None

# 使用 wraps 后
print(my_func.__name__)   # "my_func" —— 元数据保留
print(my_func.__doc__)    # "我的函数。"
```

**`wraps` 到底做了什么？**

```python
# @functools.wraps(func) 等价于：
wrapper.__name__ = func.__name__
wrapper.__doc__ = func.__doc__
wrapper.__module__ = func.__module__
wrapper.__qualname__ = func.__qualname__
wrapper.__dict__.update(func.__dict__)
wrapper.__wrapped__ = func
```

### 7.3 带参数的装饰器

```python
def retry(max_attempts=3, delay=1):
    """带参数的装饰器：失败时自动重试。"""
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            for attempt in range(1, max_attempts + 1):
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    print(f"第 {attempt} 次尝试失败: {e}")
                    if attempt < max_attempts:
                        time.sleep(delay)
            raise Exception(f"{max_attempts} 次尝试全部失败")
        return wrapper
    return decorator

@retry(max_attempts=3, delay=0.5)
def fetch_data():
    """模拟可能失败的请求。"""
    import random
    if random.random() < 0.7:
        raise ConnectionError("连接失败")
    return "数据"

# 调用
# data = fetch_data()
```

**带参数装饰器的执行过程**：

```text
@retry(max_attempts=3)
 def fetch_data(): ...

等价于：
 fetch_data = retry(max_attempts=3)(fetch_data)

retry(max_attempts=3) 返回 decorator
decorator(fetch_data) 返回 wrapper
fetch_data 指向 wrapper
```

### 7.4 类装饰器

```python
class CountCalls:
    """统计函数被调用次数的类装饰器。"""
    def __init__(self, func):
        functools.update_wrapper(self, func)
        self.func = func
        self.count = 0

    def __call__(self, *args, **kwargs):
        self.count += 1
        print(f"{self.func.__name__} 被调用了 {self.count} 次")
        return self.func(*args, **kwargs)

@CountCalls
def say_hello():
    print("Hello!")

say_hello()   # say_hello 被调用了 1 次 / Hello!
say_hello()   # say_hello 被调用了 2 次 / Hello!
```

### 7.5 多个装饰器堆叠

```python
@decorator_a
@decorator_b
@decorator_c
def my_func():
    pass

# 等价于：my_func = decorator_a(decorator_b(decorator_c(my_func)))
# 执行顺序：从内到外（c -> b -> a）
```

> 配图占位：建议放一张"多个装饰器堆叠执行顺序"示意图，文件路径 `/images/python/phase2_decorators_stack.png`。

### 7.6 常用装饰器模式

```python
# 1. 权限检查
def require_login(func):
    @functools.wraps(func)
    def wrapper(user, *args, **kwargs):
        if not user.is_authenticated:
            raise PermissionError("请先登录")
        return func(user, *args, **kwargs)
    return wrapper

# 2. 缓存（简单版，生产环境用 functools.lru_cache）
def simple_cache(func):
    cache = {}
    @functools.wraps(func)
    def wrapper(*args):
        if args not in cache:
            cache[args] = func(*args)
        return cache[args]
    return wrapper

# 3. 参数验证
def validate_types(**types):
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            bound = inspect.signature(func).bind(*args, **kwargs)
            bound.apply_defaults()
            for name, expected_type in types.items():
                if name in bound.arguments:
                    value = bound.arguments[name]
                    if not isinstance(value, expected_type):
                        raise TypeError(f"{name} 期望 {expected_type}，实际 {type(value)}")
            return func(*args, **kwargs)
        return wrapper
    return decorator

import inspect

@validate_types(name=str, age=int)
def register(name, age):
    print(f"注册用户: {name}, {age}")

# register("Alice", "30")   # TypeError: age 期望 <class 'int'>，实际 <class 'str'>
```

### 7.7 内置装饰器

```python
# @staticmethod —— 静态方法，不接收 self
class Math:
    @staticmethod
    def add(a, b):
        return a + b

# @classmethod —— 类方法，接收 cls
class User:
    count = 0

    def __init__(self, name):
        self.name = name
        User.count += 1

    @classmethod
    def get_count(cls):
        return cls.count

# @property —— 把方法变成属性
class Circle:
    def __init__(self, radius):
        self.radius = radius

    @property
    def area(self):
        return 3.14159 * self.radius ** 2

c = Circle(5)
print(c.area)   # 78.53975，不需要加括号
```

---

## 8. 递归

### 8.1 递归基础

```python
def factorial(n):
    """计算阶乘（递归版）。"""
    if n <= 1:
        return 1
    return n * factorial(n - 1)

print(factorial(5))     # 120
```

**递归三要素**：
1. **终止条件**：`n <= 1` 时返回 1。
2. **递归调用**：`factorial(n - 1)`。
3. **状态传递**：通过参数 `n` 传递状态。

```text
factorial(5)
  └── 5 * factorial(4)
        └── 4 * factorial(3)
              └── 3 * factorial(2)
                    └── 2 * factorial(1)
                          └── 1
```

### 8.2 递归的局限

```python
# Python 默认递归深度限制为 1000
import sys
print(sys.getrecursionlimit())   # 1000

# 深度递归会导致栈溢出
def infinite_recursion(n):
    return infinite_recursion(n + 1)

# infinite_recursion(1)   # RecursionError: maximum recursion depth exceeded
```

**工程建议**：
- Python 不擅长深度递归，能用循环解决的不要用递归。
- 树/图的遍历等天然递归结构，考虑使用栈模拟递归或改用迭代。

### 8.3 尾递归（了解即可）

```python
def factorial_tail(n, acc=1):
    """尾递归版阶乘（acc 为累积器）。

    注意：CPython 不支持尾递归优化，这仍然会使用调用栈！
    但在支持尾递归优化的语言（如 Scheme、Erlang）中，这不会增加栈深度。
    """
    if n <= 1:
        return acc
    return factorial_tail(n - 1, n * acc)
```

### 8.4 记忆化递归

```python
from functools import lru_cache

@lru_cache(maxsize=None)
def fibonacci(n):
    if n < 2:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)

print(fibonacci(100))   # 快速计算出结果
```

**记忆化的作用**：
- 避免重复计算，将时间复杂度从 O(2^n) 降到 O(n)。
- 使用 `lru_cache` 自动缓存结果。

---

## 9. 生成器（Generator）

### 9.1 生成器函数与 `yield`

生成器是一种特殊的迭代器，使用 `yield` 关键字可以**暂停**函数执行并返回一个值，下次调用时从暂停处继续。

```python
def count_up_to(n):
    """生成 1 到 n 的整数。"""
    count = 1
    while count <= n:
        yield count
        count += 1

counter = count_up_to(3)
print(type(counter))     # <class 'generator'>

print(next(counter))     # 1
print(next(counter))     # 2
print(next(counter))     # 3
# print(next(counter))   # StopIteration 异常

# 更常用的方式：for 循环自动处理 StopIteration
for num in count_up_to(5):
    print(num, end=" ")  # 1 2 3 4 5
```

> 配图占位：建议放一张"生成器 yield 暂停与恢复"示意图，文件路径 `/images/python/phase2_generator.png`。

### 9.2 生成器 vs 列表

| 特性 | 列表 | 生成器 |
|------|------|--------|
| 内存占用 | 存储所有元素 | 惰性计算，每次只存一个 |
| 可迭代次数 | 无限次 | 只能迭代一次 |
| 随机访问 | 支持 `lst[i]` | 不支持，只能顺序访问 |
| 长度 | `len()` 可知 | 不知道总长度 |

```python
# 列表：占用大量内存
squares_list = [x ** 2 for x in range(10_000_000)]   # 约 400MB+

# 生成器：几乎不占内存
squares_gen = (x ** 2 for x in range(10_000_000))    # 几乎为 0

# 逐个消费
for sq in squares_gen:
    if sq > 100:
        break
```

### 9.3 `yield from`（3.3+）

```python
def flatten(nested):
    """展平嵌套的可迭代对象。"""
    for item in nested:
        if isinstance(item, (list, tuple)):
            yield from flatten(item)    # 委托给子生成器
        else:
            yield item

nested = [1, [2, [3, 4]], 5]
print(list(flatten(nested)))   # [1, 2, 3, 4, 5]
```

**`yield from` 的作用**：
- 将子生成器的值直接转发给调用方。
- 简化了嵌套生成器的写法。
- 在协程中还可以转发 `send()` 和 `throw()`。

### 9.4 生成器的双向通信：`send()` 方法

```python
def running_average():
    """动态计算平均值。"""
    total = 0
    count = 0
    average = None
    while True:
        value = yield average      # 接收外部发送的值
        total += value
        count += 1
        average = total / count

avg = running_average()
next(avg)              # 预激生成器（或使用 avg.send(None)）

print(avg.send(10))    # 10.0
print(avg.send(20))    # 15.0
print(avg.send(30))    # 20.0
```

**生成器协议总结**：

| 方法 | 作用 |
|------|------|
| `next(g)` | 获取下一个值 |
| `g.send(value)` | 向生成器发送值，并获取下一个值 |
| `g.throw(exc)` | 向生成器抛异常 |
| `g.close()` | 关闭生成器 |

### 9.5 生成器表达式

```python
# 列表推导式（生成完整列表）
squares = [x ** 2 for x in range(100)]

# 生成器表达式（惰性求值，括号可省略在函数参数中）
squares_gen = (x ** 2 for x in range(100))

# 直接在函数参数中使用，省略括号
total = sum(x ** 2 for x in range(100))
print(total)   # 328350
```

---

## 10. 函数式编程工程实践

### 10.1 纯函数与副作用

**纯函数**：相同输入永远产生相同输出，且没有副作用。

```python
# 纯函数
def add(a, b):
    return a + b

# 非纯函数（有副作用）
total = 0
def add_to_total(value):
    global total
    total += value

# 非纯函数（依赖外部状态）
import random
def random_add(a):
    return a + random.randint(1, 10)
```

**纯函数的优势**：
- 可预测、易测试。
- 可缓存。
- 可并行化。

### 10.2 `functools` 模块常用工具

```python
from functools import partial, reduce, lru_cache, cmp_to_key

# partial: 冻结部分参数
basetwo = partial(int, base=2)
print(basetwo("1010"))   # 10

# reduce: 累积
product = reduce(lambda x, y: x * y, [1, 2, 3, 4])   # 24

# lru_cache: 缓存
@lru_cache(maxsize=128)
def expensive(n):
    # 耗时计算
    return n * n

# cmp_to_key: 将比较函数转为 key 函数
def compare_length(a, b):
    return len(a) - len(b)

words = ["apple", "pie", "banana"]
words.sort(key=cmp_to_key(compare_length))
```

### 10.3 `itertools` 模块常用工具

```python
import itertools

# 无限迭代器
count = itertools.count(1, 2)        # 1, 3, 5, 7...
cycle = itertools.cycle("AB")        # A, B, A, B...

# 组合
perms = list(itertools.permutations([1, 2, 3]))
combs = list(itertools.combinations([1, 2, 3], 2))

# 分组
for key, group in itertools.groupby("AAABBBCC"):
    print(key, list(group))
# A ['A', 'A', 'A']
# B ['B', 'B', 'B']
# C ['C', 'C']
```

> 配图占位：建议放一张"Python functools 与 itertools 工具速查"示意图，文件路径 `/images/python/phase2_functools_itertools.png`。

---

## 附录 A：第二阶段自检清单

在继续学习第三阶段之前，请确保你能：

- [ ] 解释 Python 的"传对象引用"机制，并判断函数内修改是否影响外部
- [ ] 说明位置参数、关键字参数、仅限位置参数、仅限关键字参数的区别
- [ ] 解释 `*args` 和 `**kwargs` 的区别与用法，并进行拆包调用
- [ ] 解释可变默认参数的陷阱，并写出安全的替代方案
- [ ] 说明 LEGB 规则，并正确使用 `global` 和 `nonlocal`
- [ ] 解释闭包的概念，并写出利用闭包实现状态保持的代码
- [ ] 解释闭包延迟绑定问题及修复方法
- [ ] 手写一个装饰器（不带参数和带参数两种），并解释 `@functools.wraps` 的作用
- [ ] 解释生成器的工作原理，用 `yield` 实现一个简单的生成器函数
- [ ] 说明列表推导式和生成器表达式的区别，以及各自的适用场景
- [ ] 解释 `yield from` 的作用
- [ ] 使用 `lambda` 配合 `sorted()`/`map()`/`filter()` 完成常见操作
- [ ] 说明纯函数的优势和副作用的危害
- [ ] 熟练使用 `functools` 和 `itertools` 中的常用工具

---

## 附录 B：面试题精选

1. **Python 的传参机制是什么？**传对象引用。
2. **可变默认参数有什么陷阱？**默认参数在函数定义时求值，可变对象被所有调用共享。
3. **`*args` 和 `**kwargs` 的星号分别做了什么？**`*` 拆包序列，`**` 拆包字典。
4. **`global` 和 `nonlocal` 的区别？**`global` 修改全局变量，`nonlocal` 修改外层闭包变量。
5. **什么是闭包？**函数记住其创建时的环境。
6. **闭包延迟绑定问题如何修复？**使用默认参数 `x=i` 绑定当前值。
7. **装饰器的本质是什么？**返回函数的高阶函数。
8. **`@functools.wraps` 的作用？**保留原函数的元数据。
9. **生成器和列表的区别？**生成器惰性求值、省内存、只能迭代一次。
10. **`yield from` 有什么用？**委托子生成器，简化嵌套生成器。

---

## 工作实战场景

### 场景 1：处理超大日志文件

**需求**：分析 10GB 的日志文件，提取所有 ERROR 级别的日志行。

**问题**：直接 `read()` 会撑爆内存。

**解决方案**：使用生成器逐行处理

```python
def parse_large_log(filepath):
    """生成器：逐行读取大文件，避免内存溢出"""
    with open(filepath, 'r', encoding='utf-8') as f:
        for line in f:
            if 'ERROR' in line:
                yield line.strip()

# 使用：内存占用恒定，无论文件多大
for error_line in parse_large_log('/var/log/app.log'):
    process_error(error_line)

# 统计错误数量（无需加载整个文件）
error_count = sum(1 for _ in parse_large_log('/var/log/app.log'))
```

### 场景 2：配置验证器

**需求**：验证用户配置，返回所有错误而非遇到第一个错误就停止。

**解决方案**：使用生成器收集所有错误

```python
def validate_config(config):
    """验证配置，返回所有错误"""
    
    def check_required_fields():
        required = ['host', 'port', 'database']
        for field in required:
            if field not in config:
                yield f"缺少必填字段: {field}"
    
    def check_port_range():
        port = config.get('port')
        if port and not (1 <= port <= 65535):
            yield f"端口 {port} 超出有效范围 (1-65535)"
    
    def check_timeout():
        timeout = config.get('timeout', 30)
        if timeout <= 0:
            yield f"超时时间必须为正数: {timeout}"
    
    # 收集所有验证器的错误
    yield from check_required_fields()
    yield from check_port_range()
    yield from check_timeout()

# 使用
config = {'host': 'localhost', 'port': 99999, 'timeout': -5}
errors = list(validate_config(config))

if errors:
    print("配置错误:")
    for err in errors:
        print(f"  - {err}")
else:
    print("配置有效")
```

### 场景 3：缓存装饰器

**需求**：为频繁调用的函数添加缓存，减少数据库查询。

```python
import time
from functools import wraps

def cache_result(ttl_seconds=60):
    """带 TTL 的缓存装饰器"""
    cache = {}
    
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            # 使用参数作为缓存键
            key = (args, tuple(sorted(kwargs.items())))
            
            # 检查缓存是否存在且未过期
            if key in cache:
                result, timestamp = cache[key]
                if time.time() - timestamp < ttl_seconds:
                    return result
            
            # 调用原函数并缓存结果
            result = func(*args, **kwargs)
            cache[key] = (result, time.time())
            return result
        
        return wrapper
    return decorator

# 使用示例
@cache_result(ttl_seconds=30)
def get_user_info(user_id):
    """模拟数据库查询"""
    print(f"查询数据库: user_id={user_id}")
    return {'id': user_id, 'name': f'User{user_id}'}

# 第一次调用：实际查询
user1 = get_user_info(1)  # 输出: 查询数据库: user_id=1

# 30秒内再次调用：使用缓存
user1_again = get_user_info(1)  # 无输出，使用缓存
```

### 场景 4：重试装饰器

**需求**：为不稳定的外部 API 调用添加自动重试机制。

```python
import time
import random
from functools import wraps

def retry(max_attempts=3, delay=1, backoff=2, exceptions=(Exception,)):
    """重试装饰器
    
    Args:
        max_attempts: 最大重试次数
        delay: 初始延迟（秒）
        backoff: 延迟增长因子
        exceptions: 捕获的异常类型
    """
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            current_delay = delay
            last_exception = None
            
            for attempt in range(max_attempts):
                try:
                    return func(*args, **kwargs)
                except exceptions as e:
                    last_exception = e
                    if attempt < max_attempts - 1:
                        time.sleep(current_delay)
                        current_delay *= backoff
            
            raise last_exception
        return wrapper
    return decorator

# 使用示例
@retry(max_attempts=3, delay=0.5, exceptions=(ConnectionError, TimeoutError))
def call_external_api(url):
    """调用外部 API"""
    # 模拟 50% 概率失败
    if random.random() < 0.5:
        raise ConnectionError("网络错误")
    return {"status": "ok"}

# 自动重试
try:
    result = call_external_api("https://api.example.com/data")
    print(f"成功: {result}")
except Exception as e:
    print(f"最终失败: {e}")
```

---

## 实战项目：任务调度器

通过一个完整的任务调度器项目，综合运用函数式编程知识。

### 项目目标

创建一个支持以下功能的任务调度器：
- 定时执行任务
- 支持任务依赖
- 支持任务重试
- 记录任务状态

### 完整代码

```python
#!/usr/bin/env python3
"""
任务调度器 - 第二阶段实战项目
知识点：闭包、装饰器、生成器、高阶函数
"""

import time
from datetime import datetime
from functools import wraps
from typing import Callable, List, Dict, Any, Optional
from dataclasses import dataclass
from enum import Enum

class TaskStatus(Enum):
    """任务状态"""
    PENDING = "pending"
    RUNNING = "running"
    SUCCESS = "success"
    FAILED = "failed"
    RETRYING = "retrying"

@dataclass
class TaskResult:
    """任务执行结果"""
    task_name: str
    status: TaskStatus
    start_time: datetime
    end_time: Optional[datetime] = None
    result: Any = None
    error: Optional[str] = None
    attempts: int = 1

def timer(func):
    """计时装饰器"""
    @wraps(func)
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        elapsed = time.time() - start
        print(f"[Timer] {func.__name__} 执行耗时: {elapsed:.3f}s")
        return result
    return wrapper

def retry_on_failure(max_retries=3, delay=1):
    """重试装饰器"""
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            last_error = None
            for attempt in range(max_retries):
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    last_error = e
                    if attempt < max_retries - 1:
                        print(f"[Retry] {func.__name__} 第{attempt + 1}次失败，{delay}秒后重试...")
                        time.sleep(delay)
            raise last_error
        return wrapper
    return decorator

class TaskScheduler:
    """任务调度器"""
    
    def __init__(self):
        self.tasks: Dict[str, Callable] = {}
        self.dependencies: Dict[str, List[str]] = {}
        self.history: List[TaskResult] = []
    
    def register(self, name: str, depends_on: List[str] = None):
        """注册任务装饰器"""
        def decorator(func):
            self.tasks[name] = func
            self.dependencies[name] = depends_on or []
            return func
        return decorator
    
    def _check_dependencies(self, task_name: str) -> bool:
        """检查任务依赖是否满足"""
        for dep in self.dependencies.get(task_name, []):
            dep_results = [r for r in self.history if r.task_name == dep]
            if not dep_results or dep_results[-1].status != TaskStatus.SUCCESS:
                return False
        return True
    
    def _get_execution_order(self) -> List[str]:
        """获取拓扑排序后的执行顺序"""
        visited = set()
        order = []
        
        def visit(task_name):
            if task_name in visited:
                return
            visited.add(task_name)
            for dep in self.dependencies.get(task_name, []):
                visit(dep)
            order.append(task_name)
        
        for task_name in self.tasks:
            visit(task_name)
        
        return order
    
    def run_task(self, name: str) -> TaskResult:
        """执行单个任务"""
        start_time = datetime.now()
        
        # 检查依赖
        if not self._check_dependencies(name):
            return TaskResult(
                task_name=name,
                status=TaskStatus.FAILED,
                start_time=start_time,
                end_time=datetime.now(),
                error="依赖任务未完成"
            )
        
        # 执行任务
        try:
            result = self.tasks[name]()
            return TaskResult(
                task_name=name,
                status=TaskStatus.SUCCESS,
                start_time=start_time,
                end_time=datetime.now(),
                result=result
            )
        except Exception as e:
            return TaskResult(
                task_name=name,
                status=TaskStatus.FAILED,
                start_time=start_time,
                end_time=datetime.now(),
                error=str(e)
            )
    
    @timer
    def run_all(self):
        """执行所有任务（按依赖顺序）"""
        order = self._get_execution_order()
        print(f"\n[Scheduler] 执行顺序: {' → '.join(order)}\n")
        
        for task_name in order:
            print(f"[Scheduler] 开始执行: {task_name}")
            result = self.run_task(task_name)
            self.history.append(result)
            
            if result.status == TaskStatus.SUCCESS:
                print(f"[Scheduler] ✓ {task_name} 完成")
            else:
                print(f"[Scheduler] ✗ {task_name} 失败: {result.error}")
    
    def get_summary(self) -> str:
        """获取执行摘要"""
        success = sum(1 for r in self.history if r.status == TaskStatus.SUCCESS)
        failed = sum(1 for r in self.history if r.status == TaskStatus.FAILED)
        total_time = sum(
            (r.end_time - r.start_time).total_seconds()
            for r in self.history
            if r.end_time
        )
        
        return f"""
执行摘要:
  总任务数: {len(self.history)}
  成功: {success}
  失败: {failed}
  总耗时: {total_time:.2f}s
"""

# ============== 使用示例 ==============

scheduler = TaskScheduler()

@scheduler.register("fetch_data")
@retry_on_failure(max_retries=2)
def fetch_data():
    """获取数据"""
    print("  → 从数据库获取数据...")
    time.sleep(0.5)
    return {"users": [1, 2, 3], "orders": [100, 200]}

@scheduler.register("process_data", depends_on=["fetch_data"])
def process_data():
    """处理数据"""
    print("  → 处理数据...")
    time.sleep(0.3)
    return {"processed": 6}

@scheduler.register("generate_report", depends_on=["process_data"])
@timer
def generate_report():
    """生成报告"""
    print("  → 生成报告...")
    time.sleep(0.2)
    return "report_20240101.pdf"

@scheduler.register("send_notification", depends_on=["generate_report"])
def send_notification():
    """发送通知"""
    print("  → 发送邮件通知...")
    time.sleep(0.1)
    return "sent"

if __name__ == "__main__":
    print("=" * 50)
    print("       任务调度器 v1.0")
    print("=" * 50)
    
    scheduler.run_all()
    print(scheduler.get_summary())
```

### 运行示例

```
==================================================
       任务调度器 v1.0
==================================================

[Scheduler] 执行顺序: fetch_data → process_data → generate_report → send_notification

[Scheduler] 开始执行: fetch_data
  → 从数据库获取数据...
[Scheduler] ✓ fetch_data 完成
[Scheduler] 开始执行: process_data
  → 处理数据...
[Scheduler] ✓ process_data 完成
[Scheduler] 开始执行: generate_report
  → 生成报告...
[Timer] generate_report 执行耗时: 0.201s
[Scheduler] ✓ generate_report 完成
[Scheduler] 开始执行: send_notification
  → 发送邮件通知...
[Scheduler] ✓ send_notification 完成
[Timer] run_all 执行耗时: 1.104s

执行摘要:
  总任务数: 4
  成功: 4
  失败: 0
  总耗时: 1.10s
```

### 知识点覆盖

| 功能 | 涉及知识点 |
|------|------------|
| 装饰器 | 参数化装饰器、`@wraps`、嵌套装饰器 |
| 闭包 | 装饰器内部状态保持 |
| 生成器 | 任务执行顺序生成 |
| 高阶函数 | `register` 返回装饰器 |
| 数据类 | `@dataclass` 定义结果对象 |
| 枚举 | `Enum` 定义状态 |

### 进阶练习

尝试为任务调度器添加以下功能：
1. 支持定时任务（cron 表达式）
2. 支持并行执行无依赖的任务
3. 添加任务进度追踪
4. 支持任务超时设置
5. 添加任务取消功能

---

> **工程师寄语**：函数式编程的精髓不在于用了多少 `lambda` 或 `map`，而在于能否用**纯函数**和**不可变数据**来构建系统。在 Python 中，适度地借鉴函数式思想（如避免副作用、使用生成器处理大数据流），能让你的代码更健壮、更可测试。

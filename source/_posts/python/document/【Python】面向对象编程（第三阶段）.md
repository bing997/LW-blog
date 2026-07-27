---
title: 【Python】面向对象编程（第三阶段）
date: 2026-07-22 12:00:00
categories:
  - Python
tags:
  - Python
  - 教程
  - 面向对象
description: 系统掌握 Python 面向对象编程——类与对象、封装继承多态、魔术方法协议、元类与描述符、dataclass 与经典设计模式。
cover: /images/cover.png
---

# 三、面向对象编程

> **阶段定位**：面向对象编程（OOP）是 Python 组织大型项目的核心范式。Python 的 OOP 灵活而不教条——它支持封装、继承、多态等经典特性，同时通过鸭子类型和魔术方法提供了独特的表达能力。本阶段不仅要学会"怎么写类"，更要理解"为什么这样设计"。

```
┌─────────────────────────────────────────────────────────────┐
│                   Python OOP 知识图谱                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. 类与对象 ──→ __init__ / __new__ / self / 类属性 vs 实例属性 │
│       │                                                     │
│  2. 三种方法 ──→ 实例方法 / @classmethod / @staticmethod      │
│       │                                                     │
│  3. 封装 ─────→ _受保护 / __私有 / @property / __slots__      │
│       │                                                     │
│  4. 继承多态 ──→ 单继承 / 多继承 / MRO / super() / Mixin / ABC │
│       │                                                     │
│  5. 魔术方法 ──→ __str__ / __repr__ / __len__ / __getitem__   │
│       │           __enter__ / __call__ / 运算符重载 / __hash__ │
│       │                                                     │
│  6. 元编程 ───→ type / 元类 / __init_subclass__ / 描述符       │
│       │                                                     │
│  7. 设计模式 ─→ 单例 / 工厂 / 策略 / 观察者 / 装饰器           │
│       │                                                     │
│  8. 现代特性 ─→ dataclass / Enum / typing.Protocol / slots    │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 1. 类与对象

### 1.1 类的定义与实例化

**面向对象的三大支柱**：

```
┌──────────┐    ┌──────────┐    ┌──────────┐
│  封装     │    │  继承     │    │  多态     │
│ Encaps.  │    │ Inherit. │    │ Polymor.│
├──────────┤    ├──────────┤    ├──────────┤
│ 隐藏内部  │    │ 复用父类  │    │ 同一接口  │
│ 实现细节  │    │ 代码和结构│    │ 不同实现  │
└──────────┘    └──────────┘    └──────────┘
```

```python
class Person:
    """人类：最简单的类定义。"""

    # 类属性（所有实例共享）
    species = "Homo sapiens"

    def __init__(self, name, age):
        """构造方法：创建实例时自动调用。"""
        self.name = name      # 实例属性
        self.age = age

    def introduce(self):
        """实例方法：第一个参数 self 指向当前实例。"""
        return f"我叫 {self.name}，今年 {self.age} 岁"

# 实例化
alice = Person("Alice", 30)
bob = Person("Bob", 25)

print(alice.introduce())    # 我叫 Alice，今年 30 岁
print(alice.species)        # Homo sapiens
print(bob.species)          # Homo sapiens
```

**类属性 vs 实例属性的内存模型**：

```
      Person 类对象
    ┌──────────────────┐
    │ species = "Human" │  ← 类属性（存储在类的 __dict__ 中）
    │ __init__ 方法     │
    └────────┬─────────┘
             │ 实例化
     ┌───────┴───────┐
     ▼               ▼
┌─────────┐    ┌─────────┐
│ alice   │    │ bob     │
├─────────┤    ├─────────┤
│name=Alice│   │name=Bob │  ← 实例属性（各自独立）
│age=30   │    │age=25   │
└─────────┘    └─────────┘
  alice.__dict__  bob.__dict__
  没有 species     没有 species
  → 去 Person 找   → 去 Person 找
```

```python
# 类属性与实例属性的区别
Person.species = "Human"    # 修改类属性，所有实例都受影响
print(alice.species)        # Human
print(bob.species)          # Human

alice.species = "Alien"     # 这其实是给实例创建了一个同名实例属性，不影响类属性
print(alice.species)        # Alien（实例属性遮盖了类属性）
print(Person.species)       # Human（类属性未变）
print(bob.species)          # Human（bob 没有实例属性，仍读取类属性）

# 验证：查看各自的 __dict__
print(alice.__dict__)       # {'name': 'Alice', 'age': 30, 'species': 'Alien'}
print(bob.__dict__)        # {'name': 'Bob', 'age': 25}  —— 没有 species
print(Person.__dict__['species'])  # 'Human'
```

**属性查找顺序**：实例属性 → 类属性 → 父类属性（MRO 顺序）

```
查找 alice.species 的过程：

  1. alice.__dict__['species']  → 找到了！返回 "Alien"
     （如果没有，继续往下找）

  2. Person.__dict__['species'] → 找到了！返回 "Human"
     （如果没有，继续往下找）

  3. object.__dict__ → 没有 species → AttributeError
```

> **面试真题**：以下代码输出什么？
> ```python
> class Test:
>     items = []
>     def add(self, x):
>         self.items.append(x)
> 
> t1 = Test()
> t2 = Test()
> t1.add(1)
> t2.add(2)
> print(t1.items)  # [1, 2]  ← 因为 items 是类属性，所有实例共享同一个列表！
> print(t2.items)  # [1, 2]
> ```
> **解析**：`self.items.append(x)` 查找 `items` 时，实例 `__dict__` 没有，找到类属性。所有实例操作的是同一个列表。这与可变默认参数陷阱是同一类问题。

> **易错点**：在实例上"修改"类属性时，实际上是创建了同名实例属性，不会影响类属性和其他实例：
> ```python
> alice.species = "Alien"   # 创建实例属性，不影响 Person.species
> Person.species = "Robot"  # 修改类属性，影响所有没有实例属性的实例
> print(alice.species)       # 仍然是 "Alien"（实例属性优先）
> print(bob.species)        # "Robot"（读取新的类属性）
> ```

### 1.2 `self` 的本质

`self` 不是关键字，而是一个约定俗成的参数名。它代表**调用该方法的实例对象本身**。

```python
class Demo:
    def __init__(self, value):
        self.value = value

    def show(self):
        print(self.value)

d = Demo(42)

# 两种调用方式等价
d.show()            # 方式一：实例调用，self 自动传入
Demo.show(d)        # 方式二：类调用，需手动传入实例
```

**Python 方法绑定的底层原理**：

```python
class MyClass:
    def greet(self):
        return f"Hello from {self}"

obj = MyClass()

print(MyClass.greet)    # <function MyClass.greet>  —— 这是普通函数
print(obj.greet)        # <bound method MyClass.greet of <...>>  —— 这是绑定方法

# obj.greet 等价于：
print(obj.greet() == MyClass.greet(obj))  # True
```

> **面试真题**：`self` 可以改成别的名字吗？
> ```python
> class Test:
>     def __init__(this, x):
>         this.x = x
>     def show(me):
>         print(me.x)
> ```
> **答案**：可以运行，但**强烈不推荐**。PEP 8 规范要求使用 `self` 作为实例方法第一个参数名，`cls` 作为类方法第一个参数名。

### 1.3 `__init__` vs `__new__`

**对象创建的完整流程**：

```
执行 Person("Alice", 30) 时的内部流程：

  Step 1: Person.__new__(Person, "Alice", 30)
          ├── 创建实例对象（分配内存）
          └── 返回实例 obj

  Step 2: Person.__init__(obj, "Alice", 30)
          ├── 初始化实例属性
          └── 返回 None

  Step 3: 返回 obj 给调用者
```

```python
class Singleton:
    """单例模式：通过 __new__ 控制实例创建。"""
    _instance = None

    def __new__(cls, *args, **kwargs):
        # __new__ 负责创建实例（真正的构造函数）
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance

    def __init__(self, value):
        # __init__ 负责初始化实例（每次"实例化"都会调用）
        # 注意：单例中 __init__ 每次都会被调用！
        self.value = value

a = Singleton(1)
b = Singleton(2)
print(a is b)          # True —— 同一个实例
print(a.value)         # 2 —— 第二次 __init__ 覆盖了 value
print(b.value)         # 2
```

**关键区别**：

| 方法 | 职责 | 返回值 | 调用时机 | 是否常重写 |
|------|------|--------|----------|-----------|
| `__new__(cls)` | 创建实例对象 | 必须返回实例 | 在 `__init__` 之前 | 很少重写 |
| `__init__(self)` | 初始化实例属性 | 必须返回 `None` | 在 `__new__` 之后 | 经常重写 |

> **易错点**：单例模式中 `__init__` 每次都会被调用！
> ```python
> s1 = Singleton(1)
> s2 = Singleton(2)  # __init__ 再次执行，value 被覆盖为 2
> print(s1 is s2)     # True
> print(s1.value)     # 2 ← 被覆盖了！
> ```
> **修复方法**：
> ```python
> def __init__(self, value):
>     if not hasattr(self, '_initialized'):
>         self.value = value
>         self._initialized = True
> ```

> **面试真题**：`__new__` 返回的不是 `cls` 的实例会怎样？
> ```python
> class Weird:
>     def __new__(cls, *args, **kwargs):
>         return "I'm a string, not an instance"
> 
> w = Weird()
> print(w)           # "I'm a string, not an instance"
> print(type(w))     # <class 'str'>  —— __init__ 不会被调用！
> ```

**工程建议**：99% 的场景不需要重写 `__new__`，只在以下场景使用：
- 单例模式
- 不可变类型子类化（如 `str`、`int`、`tuple` 子类）
- 自定义元类中控制类创建

### 1.4 `__slots__`：限制实例属性

默认情况下，Python 实例可以动态添加任意属性。使用 `__slots__` 可以限制允许的属性，同时**大幅减少内存占用**。

```python
class Point:
    __slots__ = ('x', 'y')  # 只允许 x 和 y 属性

    def __init__(self, x, y):
        self.x = x
        self.y = y

p = Point(1, 2)
# p.z = 3  # AttributeError: 'Point' object has no attribute 'z'

# p.__dict__  # AttributeError: 没有 __dict__ 了！
```

**`__slots__` 的内存对比**：

```
普通类实例：
  ┌──────────────┐
  │ __dict__ ────┼──→ {name: ..., age: ..., ...}  ← 字典开销大
  │ __weakref__  │
  └──────────────┘
  100 万个实例 ≈ 200+ MB

__slots__ 类实例：
  ┌──────────────┐
  │ x (slot)     │  ← 直接存储，无字典
  │ y (slot)     │
  └──────────────┘
  100 万个实例 ≈ 16 MB（约 10 倍差距）
```

| 特性 | 普通类 | `__slots__` 类 |
|------|--------|---------------|
| 内存占用 | 大（每个实例有 `__dict__`） | 小（直接存储） |
| 动态属性 | 支持 | 不支持 |
| 属性速度 | 慢（字典查找） | 快（描述符直接访问） |
| 继承 | 正常 | 子类也需定义 `__slots__` |
| 序列化 | 直接 `__dict__` | 需手动处理 |

> **工程建议**：当你需要创建大量实例（如百万级数据对象）时，使用 `__slots__` 可以显著节省内存。但如果项目规模不大，不需要为了优化而使用。

---

## 2. 类方法、静态方法、实例方法

```python
class DateUtils:
    """三种方法的对比。"""

    def instance_method(self):
        """实例方法：操作实例数据，需要 self。"""
        return f"实例方法，可以访问: {self}"

    @classmethod
    def class_method(cls):
        """类方法：操作类级别数据，第一个参数是类本身 cls。"""
        return f"类方法，可以访问: {cls}"

    @staticmethod
    def static_method():
        """静态方法：与类/实例无关的工具函数，放在类中仅是逻辑分组。"""
        return "静态方法，不需要 self 或 cls"

    @classmethod
    def from_string(cls, date_str):
        """类方法典型用途：替代构造器（工厂方法）。"""
        year, month, day = date_str.split("-")
        return cls(int(year), int(month), int(day))


# 使用对比
du = DateUtils()
print(du.instance_method())   # 实例方法
print(DateUtils.class_method())    # 类方法（推荐用类调用）
print(DateUtils.static_method())   # 静态方法
```

**三种方法对比决策树**：

```
需要访问实例属性（self）？
  ├── 是 → 实例方法
  └── 否 → 需要访问类属性（cls）或创建实例？
              ├── 是 → @classmethod
              │         （工厂方法、替代构造器、修改类状态）
              └── 否 → @staticmethod
                        （纯工具函数，逻辑上属于这个类）
```

**工厂方法实战**：

```python
class Date:
    def __init__(self, year, month, day):
        self.year = year
        self.month = month
        self.day = day

    @classmethod
    def from_string(cls, date_str):
        """从字符串创建：Date.from_string("2024-01-15")"""
        year, month, day = map(int, date_str.split("-"))
        return cls(year, month, day)

    @classmethod
    def from_timestamp(cls, ts):
        """从时间戳创建：Date.from_timestamp(1705276800)"""
        import time
        t = time.localtime(ts)
        return cls(t.tm_year, t.tm_mon, t.tm_mday)

    @classmethod
    def today(cls):
        """从当前日期创建：Date.today()"""
        import time
        t = time.localtime()
        return cls(t.tm_year, t.tm_mon, t.tm_mday)

    def __repr__(self):
        return f"Date({self.year}-{self.month:02d}-{self.day:02d})"

d1 = Date.from_string("2024-01-15")
d2 = Date.from_timestamp(1705276800)
d3 = Date.today()
print(d1, d2, d3)
```

> **面试真题**：`@staticmethod` 和在类外面定义普通函数有什么区别？
> ```python
> class MathUtils:
>     @staticmethod
>     def square(x):
>         return x ** 2
>
> def square_outside(x):
>     return x ** 2
> ```
> **答案**：功能上没有区别。`@staticmethod` 只是逻辑分组——告诉使用者"这个函数和这个类有关"。调用方式上 `MathUtils.square(5)` 比全局 `square_outside(5)` 更有组织性。如果你的工具函数和某个类概念上相关，就放在类里作为静态方法；否则直接放模块级。

> **工程建议**：当你发现自己写了多个创建对象的替代方式时，用 `@classmethod` 做工厂方法，而不是在 `__init__` 中写一堆 `if-else` 分支。

---

## 3. 封装与访问控制

### 3.1 Python 的"信任"哲学

**Python vs Java/C++ 的访问控制对比**：

```
Java/C++ 的访问控制（强制）：
  ┌───────────┐
  │  public   │ ← 任何地方都可访问
  ├───────────┤
  │ protected │ ← 子类和同包可访问
  ├───────────┤
  │  private  │ ← 仅类内部可访问（编译器强制）
  └───────────┘

Python 的访问控制（约定）：
  ┌───────────┐
  │  public   │ ← name
  ├───────────┤
  │ _protected│ ← _name（约定：内部使用，但可以访问）
  ├───────────┤
  │ __private │ ← __name（名称改写：_ClassName__name）
  └───────────┘
  "We are all consenting adults here." —— Python 社区格言
```

```python
class BankAccount:
    def __init__(self, owner, balance):
        self.owner = owner          # 公开属性
        self._balance = balance     # 受保护（约定：子类和内部使用）
        self.__pin = "1234"         # 私有（名称改写：_BankAccount__pin）

    def deposit(self, amount):
        """公开方法：存款。"""
        if amount > 0:
            self._balance += amount
        return self._balance

    def _validate_amount(self, amount):
        """受保护方法：内部验证逻辑。"""
        return amount > 0

    def __hash_pin(self):
        """私有方法。"""
        return hash(self.__pin)

# 使用
account = BankAccount("Alice", 1000)
print(account._balance)           # 1000 —— 可以访问，但不应直接访问
# print(account.__pin)            # AttributeError —— 名称改写，无法直接访问
print(account._BankAccount__pin)  # "1234" —— 但可以绕过（不推荐！）
```

**名称改写（Name Mangling）的原理**：

```python
# Python 解释器在编译类定义时，会将 __attr 改写为 _ClassName__attr
class MyClass:
    def __init__(self):
        self.__secret = "hidden"

obj = MyClass()
print(obj.__secret)          # AttributeError
print(obj._MyClass__secret)  # "hidden"
print([k for k in dir(obj) if 'secret' in k])  # ['_MyClass__secret']
```

> **面试真题**：`_name` 和 `__name` 有什么区别？
> - `_name`：纯约定，Python 不做任何特殊处理，外部可以访问
> - `__name`：触发名称改写，变为 `_ClassName__name`，间接"私有化"
> - `__name__`（双下划线开头和结尾）：Python 魔术方法/属性，**不要**自己发明

> **工程建议**：Python 社区的最佳实践是：
> 1. 默认用公开属性（`name`），因为 Python 没有真正的私有
> 2. 需要内部标记时用 `_name`
> 3. 只在确实需要防止子类覆盖时用 `__name`
> 4. 不要用 `__double_leading_and_trailing__`，那是 Python 保留的

### 3.2 `@property`：Pythonic 的 getter/setter

```python
class Temperature:
    def __init__(self, celsius=0):
        self._celsius = celsius

    @property
    def celsius(self):
        """获取摄氏温度。"""
        return self._celsius

    @celsius.setter
    def celsius(self, value):
        """设置摄氏温度，带验证。"""
        if value < -273.15:
            raise ValueError("温度不能低于绝对零度")
        self._celsius = value

    @property
    def fahrenheit(self):
        """计算华氏温度（只读属性）。"""
        return self._celsius * 9 / 5 + 32

    @property
    def kelvin(self):
        """计算开尔文温度（只读属性）。"""
        return self._celsius + 273.15

# 使用
temp = Temperature(25)
print(temp.celsius)       # 25
print(temp.fahrenheit)    # 77.0
print(temp.kelvin)        # 298.15

temp.celsius = 30         # 通过 setter 设置
print(temp.celsius)       # 30

# temp.fahrenheit = 100   # AttributeError: 只读属性
# temp.celsius = -300     # ValueError: 温度不能低于绝对零度
```

**property 的完整生命周期**：

```
┌────────────────────────────────────────────────┐
│              @property 装饰器                    │
├────────────────────────────────────────────────┤
│                                                │
│  @property         → getter（读取属性）         │
│  @xxx.setter       → setter（赋值属性）          │
│  @xxx.deleter      → deleter（删除属性）         │
│                                                │
│  使用场景：                                      │
│  1. 属性需要验证/转换                            │
│  2. 只读计算属性（如 fahrenheit）                │
│  3. 属性变更需要触发副作用（如日志、通知）         │
│  4. 平滑升级：先公开属性，后续加 property 不破坏 API│
│                                                │
└────────────────────────────────────────────────┘
```

**property 的优势**：
- 对外暴露像属性一样访问，内部包含验证/计算逻辑
- 后续可以给已有属性添加验证，而不破坏外部 API
- 配合 `@deleter` 可控制删除行为

```python
class User:
    def __init__(self, name):
        self._name = name

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        if not value.strip():
            raise ValueError("用户名不能为空")
        self._name = value.strip()

    @name.deleter
    def name(self):
        print("删除用户名")
        self._name = None
```

**平滑升级示例**：

```python
# 版本 1：直接公开属性
class Product:
    def __init__(self, price):
        self.price = price

# 用户代码：p.price = 100

# 版本 2：需要加验证，用 property 保护已有 API
class Product:
    def __init__(self, price):
        self.price = price  # 注意：这里 self.price 会调用 setter！

    @property
    def price(self):
        return self._price

    @price.setter
    def price(self, value):
        if value < 0:
            raise ValueError("价格不能为负")
        self._price = value

# 用户代码无需修改：p.price = 100 仍然有效
```

> **易错点**：在 `__init__` 中给 `self.price` 赋值时，会触发 `@price.setter`！
> ```python
> p = Product(-10)  # ValueError: 价格不能为负
> ```

> **工程建议**：不要一开始就给所有属性加 `@property`。先用简单公开属性，需要验证时再用 property 替换——这就是 Python 的"渐进式封装"哲学。

### 3.3 `__slots__` 与内存优化

当需要创建大量实例时，`__slots__` 可以显著节省内存：

```python
import sys

# 普通类
class PointNormal:
    def __init__(self, x, y):
        self.x = x
        self.y = y

# slots 类
class PointSlots:
    __slots__ = ('x', 'y')
    def __init__(self, x, y):
        self.x = x
        self.y = y

p1 = PointNormal(1, 2)
p2 = PointSlots(1, 2)

# 内存对比
print(sys.getsizeof(p1.__dict__))  # 104 bytes（字典本身）
print(sys.getsizeof(p2))           # 48 bytes（无字典开销）

# 创建 100 万个实例：
# PointNormal: ~200 MB
# PointSlots:  ~48 MB（约 4 倍差距）
```

---

## 4. 继承与多态

### 4.1 单继承与多态

**继承的 UML 类图**：

```
         ┌──────────┐
         │  Animal   │  ← 父类（基类）
         │──────────│
         │ + name   │
         │ + speak()│  ← 抽象方法（子类必须实现）
         └────┬─────┘
              │ 继承
     ┌────────┴────────┐
     ▼                 ▼
┌──────────┐    ┌──────────┐
│   Dog     │    │   Cat     │  ← 子类（派生类）
│──────────│    │──────────│
│ + speak()│    │ + speak()│  ← 多态：各自实现
│ "汪汪！"  │    │ "喵喵！"  │
└──────────┘    └──────────┘
```

```python
class Animal:
    def __init__(self, name):
        self.name = name

    def speak(self):
        raise NotImplementedError("子类必须实现 speak 方法")

class Dog(Animal):
    def speak(self):
        return f"{self.name}: 汪汪！"

class Cat(Animal):
    def speak(self):
        return f"{self.name}: 喵喵！"

# 多态：同一接口，不同行为
animals = [Dog("大黄"), Cat("小花"), Dog("小黑")]
for animal in animals:
    print(animal.speak())
# 大黄: 汪汪！
# 小花: 喵喵！
# 小黑: 汪汪！
```

**多态的本质**：

```
多态不是"检查类型"，而是"检查行为"：

  ┌──────────────────────────────────────────┐
  │  for animal in animals:                  │
  │      animal.speak()                      │
  │                                          │
  │  Python 不关心 animal 是 Dog 还是 Cat，  │
  │  只要有 speak() 方法就行。                │
  │                                          │
  │  这就是"鸭子类型"——多态的 Python 实现。   │
  └──────────────────────────────────────────┘
```

### 4.2 多继承与 MRO（方法解析顺序）

**菱形继承结构**：

```
        ┌───┐
        │ A │  ← 共同祖先
        └─┬─┘
       ┌──┴──┐
       ▼     ▼
    ┌───┐ ┌───┐
    │ B │ │ C │  ← 中间层
    └─┬─┘ └─┬─┘
       └──┬──┘
          ▼
       ┌───┐
       │ D │  ← 多继承：class D(B, C)
       └───┘

MRO 顺序：D → B → C → A → object

问题：A 的方法会被调用几次？
  ❌ 错误（C++ 菱形继承）：A 被调用 2 次
  ✅ Python（C3 线性化）：A 只被调用 1 次
```

```python
class A:
    def method(self):
        print("A.method")
        return "A"

class B(A):
    def method(self):
        print("B.method")
        return "B" + super().method()

class C(A):
    def method(self):
        print("C.method")
        return "C" + super().method()

class D(B, C):
    def method(self):
        print("D.method")
        return "D" + super().method()

d = D()
print(d.method())   # D.method → B.method → C.method → A.method → "DBCA"

# 查看 MRO
print(D.__mro__)
# (<class 'D'>, <class 'B'>, <class 'C'>, <class 'A'>, <class 'object'>)
```

**C3 线性化算法的核心规则**：

```
1. 子类优先于父类
2. 在继承列表中，靠前的父类优先于靠后的（B 优先于 C）
3. 所有父类的方法只被调用一次（保证 A 只被调用一次）

验证：D.__mro__ = (D, B, C, A, object)
  D → B → C → A → object
  ✓ D 在最前（子类优先）
  ✓ B 在 C 前（B 是 D 的第一个父类）
  ✓ A 只出现一次
```

> **面试真题**：以下代码的 MRO 是什么？
> ```python
> class X: pass
> class Y: pass
> class A(X, Y): pass
> class B(Y, X): pass
> class C(A, B): pass
> print(C.__mro__)
> ```
> **答案**：会抛出 `TypeError: Cannot create a consistent method resolution`。因为 A 要求 X 在 Y 前面，B 要求 Y 在 X 前面，C 继承 A 和 B 时产生矛盾，C3 算法无法线性化。

> **工程建议**：Python 的多继承虽然强大，但过度使用会导致继承链混乱。最佳实践是：
> 1. 主继承链用单继承
> 2. 额外功能用 Mixin 模式混入
> 3. 接口约束用 ABC
> 4. 如果继承超过 3 层，考虑用组合替代继承

### 4.3 `super()` 的使用

```python
class Parent:
    def __init__(self, name, age):
        self.name = name
        self.age = age

class Child(Parent):
    def __init__(self, name, age, school):
        super().__init__(name, age)   # 调用父类构造方法
        self.school = school

    def __repr__(self):
        return f"Child(name={self.name}, age={self.age}, school={self.school})"

# super() 的两种用法
# Python 3: super().__init__(name, age)           # 推荐
# Python 2: super(Child, self).__init__(name, age) # 旧式写法
```

**`super()` 在多继承中的行为**：

```
super() 不是"调用父类"，而是"按 MRO 顺序调用下一个类"

  Combined 的 MRO: [Combined, MixinA, MixinB, Base, object]

  Combined.process()
      → super().process()  ← super() 指向 MixinA（MRO 中的下一个）
      
  MixinA.process()
      → super().process()  ← super() 指向 MixinB（MRO 中的下一个）
      
  MixinB.process()
      → super().process()  ← super() 指向 Base（MRO 中的下一个）
      
  Base.process()
      → 终止（不再调用 super）
```

```python
class MixinA:
    def process(self):
        print("MixinA.process")
        super().process()       # 按 MRO 继续调用下一个类

class MixinB:
    def process(self):
        print("MixinB.process")
        super().process()

class Base:
    def process(self):
        print("Base.process -> 终止")

class Combined(MixinA, MixinB, Base):
    def process(self):
        print("Combined.process")
        super().process()

c = Combined()
c.process()
# Combined.process → MixinA.process → MixinB.process → Base.process → 终止
```

> **易错点**：`super().__init__()` 在多继承中可能会**跳过某些父类的 `__init__`**！
> ```python
> class A:
>     def __init__(self):
>         print("A.__init__")
>         super().__init__()
>
> class B:
>     def __init__(self):
>         print("B.__init__")
>         super().__init__()
>
> class C(A, B):
>     def __init__(self):
>         print("C.__init__")
>         super().__init__()
>
> C()
> # C.__init__ → A.__init__ → B.__init__ → object.__init__
> # 如果 A 的 __init__ 没有调用 super().__init__()，B 的 __init__ 会被跳过！
> ```
> **结论**：多继承时，所有类都必须调用 `super().__init__()`，否则 MRO 链条会断裂。

### 4.4 Mixin 模式

**Mixin 的设计原则**：

```
┌────────────────────────────────────────────────────────────┐
│                     Mixin 设计原则                          │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  1. Mixin 不单独实例化（它是"插件"）                          │
│  2. Mixin 只添加功能，不改变核心逻辑                           │
│  3. Mixin 通过 super() 参与协作链                             │
│  4. Mixin 通常放在继承列表的最前面                             │
│                                                            │
│  组合优于继承：                                               │
│                                                            │
│  class User(JsonMixin, TimestampMixin, LogMixin):          │
│      ↑          ↑               ↑            ↑             │
│      核心类     JSON序列化      时间戳       日志            │
│                                                            │
│  每个 Mixin 提供一个独立功能，通过组合获得所有能力              │
└────────────────────────────────────────────────────────────┘
```

```python
class JsonMixin:
    """提供 JSON 序列化能力。"""
    def to_json(self):
        import json
        return json.dumps(self.__dict__, ensure_ascii=False)

class TimestampMixin:
    """提供时间戳记录能力。"""
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        import time
        self.created_at = time.time()

class LogMixin:
    """提供日志记录能力。"""
    def log(self, message):
        print(f"[{self.__class__.__name__}] {message}")

class User(JsonMixin, TimestampMixin, LogMixin):
    def __init__(self, name, email):
        super().__init__()    # 调用 TimestampMixin.__init__
        self.name = name
        self.email = email

user = User("Alice", "alice@example.com")
print(user.to_json())
# {"name": "Alice", "email": "alice@example.com", "created_at": 1690000000.0}
user.log("用户创建成功")
# [User] 用户创建成功
```

> **工程建议**：Mixin 是 Python 中实现"组合优于继承"的方式。当你需要给多个不相关的类添加相同功能（如日志、缓存、序列化）时，用 Mixin 比用继承更灵活。

### 4.5 鸭子类型与抽象基类

**鸭子类型 vs ABC 决策**：

```
需要接口约束？
  ├── 否 → 鸭子类型（默认 Pythonic 方式）
  │         优点：灵活、无需继承
  │         缺点：类型不明确，IDE 补全差
  │
  └── 是 → 抽象基类（ABC）
            优点：强制实现接口、提前报错
            缺点：需要继承、不够灵活
```

**鸭子类型**：

```python
class Duck:
    def quack(self):
        return "嘎嘎嘎"

class Person:
    def quack(self):
        return "我在学鸭子叫"

# 鸭子类型：只要对象有 quack() 方法，就可以调用
def make_it_quack(thing):
    print(thing.quack())

make_it_quack(Duck())     # 嘎嘎嘎
make_it_quack(Person())   # 我在学鸭子叫
```

**抽象基类（ABC）**：

```python
from abc import ABC, abstractmethod

class PaymentProcessor(ABC):
    """支付处理器抽象基类。"""

    @abstractmethod
    def pay(self, amount):
        """支付。"""
        pass

    @abstractmethod
    def refund(self, amount):
        """退款。"""
        pass

    def validate_amount(self, amount):
        """具体方法：子类可继承使用。"""
        if amount <= 0:
            raise ValueError("金额必须大于 0")
        return True

class AlipayProcessor(PaymentProcessor):
    def pay(self, amount):
        self.validate_amount(amount)
        print(f"支付宝支付: {amount} 元")

    def refund(self, amount):
        self.validate_amount(amount)
        print(f"支付宝退款: {amount} 元")

# p = PaymentProcessor()   # TypeError: 不能实例化抽象类
processor = AlipayProcessor()
processor.pay(100)          # 支付宝支付: 100 元
```

**鸭子类型 vs ABC**：

| 特性 | 鸭子类型 | 抽象基类 |
|------|----------|----------|
| 检查方式 | 运行时 | 可提前（实例化时） |
| 灵活性 | 高 | 低（必须实现所有抽象方法） |
| 接口保证 | 无 | 有 |
| Pythonic 程度 | 更 Pythonic | 更"工程化" |
| IDE 支持 | 差 | 好 |
| 适用场景 | 脚本、快速开发 | 大型项目、团队协作 |

### 4.6 `typing.Protocol`：结构化类型（3.8+）

```python
from typing import Protocol

class Quackable(Protocol):
    """结构化类型：只要有 quack 方法的类型都算 Quackable。"""
    def quack(self) -> str: ...

class Duck:
    def quack(self) -> str:
        return "嘎嘎嘎"

class Toy:
    def quack(self) -> str:
        return "电子嘎嘎"

# 不需要继承 Quackable，只要有 quack 方法就行
def make_sound(q: Quackable) -> None:
    print(q.quack())

make_sound(Duck())  # 嘎嘎嘎
make_sound(Toy())   # 电子嘎嘎
```

> **总结**：`Protocol` 结合了鸭子类型的灵活性和静态类型检查的安全性。在大型项目中推荐使用。

---

## 5. 魔术方法（协议）

**魔术方法全景图**：

```
┌─────────────────────────────────────────────────────────────┐
│                    Python 魔术方法分类                        │
├──────────────┬──────────────────────────────────────────────┤
│ 类别          │ 方法                                          │
├──────────────┼──────────────────────────────────────────────┤
│ 构造/销毁     │ __new__ / __init__ / __del__                 │
│ 字符串表示    │ __str__ / __repr__ / __format__              │
│ 容器协议      │ __len__ / __getitem__ / __setitem__ /        │
│              │ __delitem__ / __contains__ / __iter__        │
│ 比较运算      │ __eq__ / __ne__ / __lt__ / __le__ /          │
│              │ __gt__ / __ge__                              │
│ 算术运算      │ __add__ / __sub__ / __mul__ / __truediv__ /  │
│              │ __floordiv__ / __mod__ / __pow__            │
│ 反向算术      │ __radd__ / __rsub__ / __rmul__ 等            │
│ 增量赋值      │ __iadd__ / __isub__ / __imul__ 等            │
│ 一元运算      │ __neg__ / __pos__ / __abs__ / __invert__     │
│ 类型转换      │ __int__ / __float__ / __bool__ / __str__     │
│ 上下文管理    │ __enter__ / __exit__                        │
│ 可调用        │ __call__                                     │
│ 哈希          │ __hash__                                     │
│ 属性访问      │ __getattr__ / __setattr__ / __getattribute__ │
│ 描述符协议    │ __get__ / __set__ / __delete__               │
│ 迭代器协议    │ __iter__ / __next__                          │
│ 切片          │ __getitem__ (支持 slice 对象)                │
└──────────────┴──────────────────────────────────────────────┘
```

### 5.1 表示方法：`__str__` 与 `__repr__`

```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __repr__(self):
        """面向开发者的表示：应尽量返回可执行的 Python 代码。"""
        return f"Point(x={self.x}, y={self.y})"

    def __str__(self):
        """面向用户的表示：可读性优先。"""
        return f"({self.x}, {self.y})"

p = Point(3, 4)
print(repr(p))    # Point(x=3, y=4)
print(str(p))     # (3, 4)
print(p)          # (3, 4) —— print() 默认调用 __str__
# 在交互式环境中直接输入 p 会调用 __repr__

# 如果只实现 __repr__，__str__ 会回退到 __repr__
```

**`__str__` vs `__repr__` 调用时机**：

```
┌──────────────────────────────────────────────────────┐
│               __str__  vs  __repr__                  │
├──────────────────┬───────────────────────────────────┤
│ 调用场景          │ 使用的方法                        │
├──────────────────┼───────────────────────────────────┤
│ print(obj)       │ __str__（回退到 __repr__）         │
│ str(obj)         │ __str__（回退到 __repr__）         │
│ repr(obj)        │ __repr__                           │
│ f"{obj}"         │ __str__（回退到 __repr__）         │
│ f"{obj!r}"       │ __repr__                           │
│ f"{obj!s}"       │ __str__                            │
│ 交互式终端直接输入 │ __repr__                           │
│ 列表中的元素      │ __repr__（不是 __str__！）         │
│ 调试器显示        │ __repr__                           │
└──────────────────┴───────────────────────────────────┘
```

> **易错点**：列表打印时，元素使用的是 `__repr__` 而非 `__str__`：
> ```python
> points = [Point(1, 2), Point(3, 4)]
> print(points)
> # [Point(x=1, y=2), Point(x=3, y=4)]  ← 使用 __repr__
> # 不是 [(1, 2), (3, 4)]
> ```

> **工程建议**：至少实现 `__repr__`，因为：
> 1. 调试时能快速看到对象状态
> 2. `__str__` 缺失时自动回退到 `__repr__`
> 3. `__repr__` 应返回可执行的代码（如 `Point(x=3, y=4)`），方便 `eval` 重建

### 5.2 容器协议

```python
class Team:
    """自定义序列：团队成员列表。"""
    def __init__(self, name, members=None):
        self.name = name
        self._members = list(members) if members else []

    def __len__(self):
        """支持 len()"""
        return len(self._members)

    def __getitem__(self, index):
        """支持索引访问 team[i]"""
        return self._members[index]

    def __setitem__(self, index, value):
        """支持索引赋值 team[i] = value"""
        self._members[index] = value

    def __delitem__(self, index):
        """支持 del team[i]"""
        del self._members[index]

    def __contains__(self, item):
        """支持 in 操作符"""
        return item in self._members

    def __iter__(self):
        """支持 for member in team"""
        return iter(self._members)

    def __repr__(self):
        return f"Team({self.name!r}, {self._members!r})"

team = Team("开发组", ["Alice", "Bob", "Carol"])
print(len(team))              # 3
print(team[0])                # Alice
print("Bob" in team)          # True
for member in team:
    print(member, end=" ")    # Alice Bob Carol
```

**容器协议方法与内置函数的映射**：

```
┌──────────────────┬─────────────────────────────────┐
│ 魔术方法          │ 触发的内置操作                    │
├──────────────────┼─────────────────────────────────┤
│ __len__          │ len(obj)                        │
│ __getitem__      │ obj[key], obj[i], obj[a:b]     │
│ __setitem__      │ obj[key] = value               │
│ __delitem__      │ del obj[key]                   │
│ __contains__     │ x in obj                       │
│ __iter__         │ for x in obj, iter(obj)        │
│ __next__         │ next(obj)                      │
│ __reversed__     │ reversed(obj)                  │
│ __missing__      │ dict 子类的 obj[missing_key]   │
└──────────────────┴─────────────────────────────────┘
```

### 5.3 上下文管理器协议

**`with` 语句的执行流程**：

```
with resource as r:
    # 代码块
    pass

执行流程：
  ┌────────────────────────────────────────────────┐
  │ Step 1: 调用 resource.__enter__()              │
  │          返回值赋给 r                           │
  ├────────────────────────────────────────────────┤
  │ Step 2: 执行 with 代码块                        │
  │          ├── 正常结束 ──→ Step 3                │
  │          └── 抛出异常 ──→ Step 3（异常传入参数） │
  ├────────────────────────────────────────────────┤
  │ Step 3: 调用 resource.__exit__(exc_type,        │
  │          exc_val, exc_tb)                      │
  │          ├── 返回 False/None → 异常继续传播      │
  │          └── 返回 True → 异常被抑制（慎用！）      │
  └────────────────────────────────────────────────┘
```

```python
class DatabaseConnection:
    """自定义上下文管理器 —— 替代 with 语句中的 try/finally。"""
    def __init__(self, host, port):
        self.host = host
        self.port = port
        self.connected = False

    def __enter__(self):
        """进入 with 块时调用，返回值赋给 as 变量。"""
        print(f"连接数据库 {self.host}:{self.port}")
        self.connected = True
        return self    # 返回给 as 变量

    def __exit__(self, exc_type, exc_val, exc_tb):
        """退出 with 块时调用（即使发生异常也会执行）。"""
        print("关闭数据库连接")
        self.connected = False
        # 返回 True 会抑制异常，返回 False/None 则继续传播异常
        return False

    def query(self, sql):
        if not self.connected:
            raise RuntimeError("未连接")
        print(f"执行: {sql}")

# 使用
with DatabaseConnection("localhost", 3306) as db:
    db.query("SELECT * FROM users")
# 连接数据库 localhost:3306
# 执行: SELECT * FROM users
# 关闭数据库连接
```

**使用 `contextlib` 简化上下文管理器**：

```python
from contextlib import contextmanager

@contextmanager
def open_file(filename, mode='r'):
    """用生成器实现上下文管理器（更简洁）。"""
    f = open(filename, mode)
    try:
        yield f          # yield 之前 = __enter__
    finally:
        f.close()        # yield 之后 = __exit__

with open_file('test.txt', 'w') as f:
    f.write('Hello')
```

> **工程建议**：需要资源管理（文件、数据库连接、锁）时，优先使用上下文管理器。简单场景用 `@contextmanager`，复杂场景用 `__enter__`/`__exit__`。

### 5.4 可调用对象：`__call__`

```python
class LRUCache:
    """将函数调用缓存为可调用对象。"""
    def __init__(self, func):
        self.func = func
        self.cache = {}

    def __call__(self, *args):
        if args not in self.cache:
            self.cache[args] = self.func(*args)
        return self.cache[args]

@LRUCache
def fibonacci(n):
    """计算斐波那契数列。"""
    if n < 2:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)

print(fibonacci(100))    # 354224848179261915075 —— 有缓存，瞬间完成
```

**`__call__` 的常见用途**：

```
┌──────────────────────┬──────────────────────────────────┐
│ 用途                  │ 示例                              │
├──────────────────────┼──────────────────────────────────┤
│ 装饰器                │ class Timer: __call__(self, ...) │
│ 策略对象              │ class Strategy: __call__(...)    │
│ 状态机                │ class State: __call__(...)       │
│ API 端点（Flask 等）  │ app.route('/') → callable         │
│ 配置对象              │ class Config: __call__(...)      │
└──────────────────────┴──────────────────────────────────┘
```

> **面试真题**：`obj()` 和 `obj.__call__()` 有什么区别？
> ```python
> class A:
>     def __call__(self):
>         return "called"
>
> a = A()
> print(a())          # "called"  —— 语法糖
> print(a.__call__()) # "called"  —— 直接调用
> # 两者等价，但推荐 a()，更简洁可读
> ```

### 5.5 运算符重载

```python
class Vector:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __add__(self, other):
        """支持 v1 + v2"""
        if isinstance(other, Vector):
            return Vector(self.x + other.x, self.y + other.y)
        return NotImplemented

    def __sub__(self, other):
        """支持 v1 - v2"""
        if isinstance(other, Vector):
            return Vector(self.x - other.x, self.y - other.y)
        return NotImplemented

    def __mul__(self, scalar):
        """支持 v * 3"""
        if isinstance(scalar, (int, float)):
            return Vector(self.x * scalar, self.y * scalar)
        return NotImplemented

    def __rmul__(self, scalar):
        """支持 3 * v（右侧乘法）"""
        return self.__mul__(scalar)

    def __neg__(self):
        """支持 -v"""
        return Vector(-self.x, -self.y)

    def __abs__(self):
        """支持 abs(v)"""
        return (self.x ** 2 + self.y ** 2) ** 0.5

    def __eq__(self, other):
        """支持 v1 == v2"""
        if isinstance(other, Vector):
            return self.x == other.x and self.y == other.y
        return NotImplemented

    def __bool__(self):
        """支持 bool(v)"""
        return self.x != 0 or self.y != 0

    def __repr__(self):
        return f"Vector({self.x}, {self.y})"

v1 = Vector(3, 4)
v2 = Vector(1, 2)
print(v1 + v2)      # Vector(4, 6)
print(v1 - v2)      # Vector(2, 2)
print(v1 * 3)       # Vector(9, 12)
print(3 * v1)       # Vector(9, 12)
print(-v1)          # Vector(-3, -4)
print(abs(v1))      # 5.0
print(v1 == Vector(3, 4))   # True
print(bool(Vector(0, 0)))   # False
```

**运算符查找顺序**：

```
v1 + v2 的查找过程：

  1. 调用 v1.__add__(v2)
     ├── 返回具体值 → 使用结果
     ├── 返回 NotImplemented → 继续步骤 2
     └── 返回其他值 → 使用结果

  2. 调用 v2.__radd__(v1)  ← 反向运算符
     ├── 返回具体值 → 使用结果
     └── 返回 NotImplemented → TypeError

  3 * v1 的查找过程：
  1. int 没有 __mul__(Vector) → 返回 NotImplemented
  2. 调用 v1.__rmul__(3) → 结果
```

> **工程建议**：
> 1. 运算符重载方法遇到不支持的类型时，返回 `NotImplemented`（不是 `TypeError`），让 Python 尝试反向运算符
> 2. 实现 `__eq__` 时，也要考虑 `__hash__`（见 5.6）
> 3. 实现 `__lt__` 等比较运算符后，可以用 `@functools.total_ordering` 自动补全其他比较方法

**`@functools.total_ordering` 自动补全比较方法**：

```python
from functools import total_ordering

@total_ordering
class Student:
    def __init__(self, name, grade):
        self.name = name
        self.grade = grade

    def __eq__(self, other):
        return self.grade == other.grade

    def __lt__(self, other):
        return self.grade < other.grade
    # total_ordering 自动生成 __le__、__gt__、__ge__！

s1 = Student("Alice", 90)
s2 = Student("Bob", 85)
print(s1 > s2)   # True（自动生成）
print(s1 >= s2)  # True（自动生成）
```

**常用魔术方法速查**：

| 协议 | 方法 | 触发方式 |
|------|------|----------|
| 构造 | `__init__` | `obj = Class()` |
| 表示 | `__str__` / `__repr__` | `str(obj)` / `repr(obj)` |
| 长度 | `__len__` | `len(obj)` |
| 索引 | `__getitem__` / `__setitem__` | `obj[key]` / `obj[key] = v` |
| 迭代 | `__iter__` / `__next__` | `for x in obj` |
| 包含 | `__contains__` | `x in obj` |
| 上下文 | `__enter__` / `__exit__` | `with obj as x:` |
| 可调用 | `__call__` | `obj()` |
| 比较 | `__eq__` / `__lt__` / `__gt__` 等 | `==` / `<` / `>` |
| 哈希 | `__hash__` | `hash(obj)` / `set()` 成员 |
| 布尔 | `__bool__` | `bool(obj)` / `if obj:` |
| 算术 | `__add__` / `__sub__` / `__mul__` 等 | `+` / `-` / `*` |
| 反向算术 | `__radd__` / `__rmul__` 等 | `其他类型 + obj` |
| 增量赋值 | `__iadd__` / `__isub__` 等 | `+=` / `-=` |
| 一元 | `__neg__` / `__pos__` / `__abs__` | `-obj` / `+obj` / `abs(obj)` |
| 切片 | `__getitem__`(slice) | `obj[a:b]` |
| 格式化 | `__format__` | `f"{obj:spec}"` |

### 5.6 `__hash__` 与 `__eq__` 组合（面试高频）

`__hash__` 和 `__eq__` 共同决定了对象在字典、集合等哈希集合中的行为。

**哈希表工作原理**：

```
┌─────────────────────────────────────────────────────────────┐
│                   哈希表（dict / set）                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  插入对象 obj 时：                                            │
│    1. 计算 hash(obj) → 得到哈希值 h                           │
│    2. h % 桶大小 → 确定桶位置                                 │
│    3. 桶中已有元素？用 __eq__ 检查是否相等                    │
│       ├── 相等 → 不重复插入（覆盖值）                         │
│       └── 不相等 → 哈希碰撞，放到下一个位置                    │
│                                                             │
│  核心约定（必须遵守）：                                       │
│    1. a == b → hash(a) == hash(b)  ✓ 必须成立                │
│    2. hash(a) == hash(b) → a 不一定 == b（哈希碰撞可能）      │
│    3. 实现了 __eq__ → __hash__ 自动设为 None（不可哈希！）     │
│                                                             │
│  示意图：                                                    │
│    Bucket 0: [obj1]                                         │
│    Bucket 1: [obj2 → obj3]  ← 哈希碰撞，链表存储              │
│    Bucket 2: []                                              │
│    Bucket 3: [obj4]                                         │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

```python
# 默认行为：对象基于 id 比较和哈希
class DefaultObj:
    pass

a = DefaultObj()
b = DefaultObj()
print(hash(a))            # 不同
print(a == b)             # False（默认比较 identity）

# 必须遵守的约定（面试核心考点）：
# 1. 如果 a == b，则 hash(a) == hash(b) —— 双向必须一致
# 2. 如果 hash(a) == hash(b)，a 不一定等于 b（哈希碰撞，可能）
# 3. 如果实现了 __eq__，__hash__ 会被设为 None（对象不可哈希）

# 常见陷阱：实现了 __eq__ 但未实现 __hash__
class Person:
    def __init__(self, name):
        self.name = name
    def __eq__(self, other):
        return self.name == other.name
    # __hash__ 被设为 None —— 不可哈希！
    # 如果想放入集合，必须同时实现 __hash__

# 正确实现
class Person:
    def __init__(self, name):
        self.name = name

    def __eq__(self, other):
        if not isinstance(other, Person):
            return NotImplemented
        return self.name == other.name

    def __hash__(self):
        return hash(self.name)   # 使用不可变字段计算哈希

# 现在可以放入集合/字典
p1 = Person("Alice")
p2 = Person("Alice")
people = {p1, p2}          # 只包含一个
print(len(people))         # 1

# 不可变对象才可哈希：tuple 哈希 ≈ 组合所有元素的哈希
# 可变对象不能哈希：list 的 __hash__ = None

# 工程最佳实践：
# - 如果 Person 在业务上是"同 name 即同一个人" → 实现 __eq__ + __hash__
# - 如果 Person 需要独立身份（即使同名也视为不同人）→ 不实现任何方法
# - 使用不可变字段（str、int、tuple）作为哈希依据
# - 不要用可变字段（list、dict）参与哈希计算
```

> **易错点**：修改了参与哈希计算的属性后，对象在集合中的位置会"丢失"：
> ```python
> p = Person("Alice")
> s = {p}
> p.name = "Bob"       # 修改了参与哈希的属性
> print(p in s)         # False！因为哈希值变了，找不到原来的桶
> ```

---

## 6. 元编程与高级 OOP

### 6.1 元类（Metaclass）

**元类层级关系**：

```
┌──────────────────────────────────────────────┐
│                                              │
│  type（元类）                                 │
│    │                                         │
│    ├──→ Person（普通类）                      │
│    │      │                                  │
│    │      ├──→ alice = Person()（实例）       │
│    │      └──→ bob = Person()（实例）         │
│    │                                         │
│    ├──→ SingletonMeta（自定义元类）            │
│    │      │                                  │
│    │      └──→ Database（用元类创建的类）      │
│    │             │                           │
│    │             └──→ db = Database()（实例）  │
│    │                                         │
│    └──→ type 自己也是 type 的实例              │
│                                              │
│  理解："类也是对象"，type 是创建类的类           │
│                                              │
└──────────────────────────────────────────────┘
```

```python
# 类的本质：type 是默认的元类
MyClass = type("MyClass", (object,), {"x": 5, "hello": lambda self: "Hello"})
obj = MyClass()
print(obj.x)        # 5
print(obj.hello())  # Hello

# 以上等价于：
# class MyClass:
#     x = 5
#     def hello(self):
#         return "Hello"
```

**自定义元类**：

```python
class SingletonMeta(type):
    """单例元类：任何使用此元类的类，自动成为单例。"""
    _instances = {}

    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            cls._instances[cls] = super().__call__(*args, **kwargs)
        return cls._instances[cls]

class Database(metaclass=SingletonMeta):
    def __init__(self, host="localhost"):
        self.host = host
        print(f"初始化 Database: {self.host}")

db1 = Database("prod-server")
db2 = Database("test-server")   # 不会重新初始化
print(db1 is db2)                # True
print(db1.host)                  # prod-server —— 第一次的值
```

**元类实战：自动注册子类**：

```python
class PluginRegistry(type):
    """自动注册所有子类的元类。"""
    registry = {}

    def __new__(cls, name, bases, namespace):
        new_cls = super().__new__(cls, name, bases, namespace)
        if name != "Plugin":
            cls.registry[name] = new_cls
        return new_cls

class Plugin(metaclass=PluginRegistry):
    """插件基类。"""
    pass

class ImagePlugin(Plugin):
    pass

class VideoPlugin(Plugin):
    pass

class AudioPlugin(Plugin):
    pass

print(PluginRegistry.registry)
# {'ImagePlugin': <class 'ImagePlugin'>, 'VideoPlugin': <class 'VideoPlugin'>, 'AudioPlugin': <class 'AudioPlugin'>}
```

**`__init_subclass__` 替代元类（3.6+）**：

```python
# 3.6+ 的 __init_subclass__ 常可替代元类，更简单
class PluginBase:
    _registry = {}

    def __init_subclass__(cls, **kwargs):
        super().__init_subclass__(**kwargs)
        if cls.__name__ != "PluginBase":
            PluginBase._registry[cls.__name__] = cls

class ImagePlugin(PluginBase):
    pass

class VideoPlugin(PluginBase):
    pass

print(PluginBase._registry)
# {'ImagePlugin': <class 'ImagePlugin'>, 'VideoPlugin': <class 'VideoPlugin'>}
```

> **工程建议**：元类是 Python 中最强大的特性之一，也是最容易被滥用的。优先级：
> 1. 能用普通类解决 → 不用元类
> 2. 能用 `@property` / 描述符 → 不用元类
> 3. 能用类装饰器 → 不用元类
> 4. 能用 `__init_subclass__` → 不用元类
> 5. 以上都不行 → 才考虑元类

### 6.2 描述符协议

**描述符是 `@property` 的底层实现**：

```
┌────────────────────────────────────────────────────────────┐
│                    描述符的工作原理                          │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  当你访问 obj.attr 时：                                     │
│                                                            │
│  1. Python 检查 type(obj) 的 __dict__                      │
│  2. 如果 attr 是描述符（有 __get__ 方法）                    │
│     → 调用 descriptor.__get__(obj, type(obj))              │
│                                                            │
│  三种描述符：                                               │
│  ├── 数据描述符：有 __get__ + __set__（如 @property）       │
│  ├── 非数据描述符：只有 __get__（如普通方法）                 │
│  └── 查找优先级：数据描述符 > 实例属性 > 非数据描述符         │
│                                                            │
│  @property 就是数据描述符的语法糖                            │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

```python
class ValidatedField:
    """带类型验证的描述符。"""
    def __init__(self, field_type, min_value=None, max_value=None):
        self.field_type = field_type
        self.min_value = min_value
        self.max_value = max_value
        self.data = {}          # 使用字典存储每个实例的值

    def __get__(self, instance, owner):
        if instance is None:
            return self         # 类属性访问时返回描述符本身
        return self.data.get(instance, None)

    def __set__(self, instance, value):
        if not isinstance(value, self.field_type):
            raise TypeError(f"期望 {self.field_type.__name__}，实际 {type(value).__name__}")
        if self.min_value is not None and value < self.min_value:
            raise ValueError(f"值不能小于 {self.min_value}")
        if self.max_value is not None and value > self.max_value:
            raise ValueError(f"值不能大于 {self.max_value}")
        self.data[instance] = value

    def __delete__(self, instance):
        del self.data[instance]

class Person:
    name = ValidatedField(str)             # 必须为字符串
    age = ValidatedField(int, 0, 150)       # 0-150 的整数

    def __init__(self, name, age):
        self.name = name
        self.age = age

p = Person("Alice", 30)
p.age = 31
# p.age = "abc"     # TypeError
# p.age = -1        # ValueError
# p.age = 200       # ValueError
```

> **面试真题**：`@property` 和描述符有什么关系？
> ```python
> # @property 本质上就是创建了一个数据描述符
> class C:
>     @property
>     def x(self):
>         return self._x
>
>     @x.setter
>     def x(self, value):
>         self._x = value
>
> # 等价于：
> class Property:
>     def __get__(self, obj, owner):
>         return obj._x
>     def __set__(self, obj, value):
>         obj._x = value
>
> class C:
>     x = Property()
> ```

### 6.3 数据类 `dataclass`（3.7+）

`dataclass` 自动生成 `__init__`、`__repr__`、`__eq__` 等方法，减少样板代码。

```python
from dataclasses import dataclass, field, asdict, astuple

@dataclass(order=True)     # order=True 自动生成比较方法
class Person:
    name: str
    age: int
    # 有默认值的字段必须放在无默认值字段之后
    email: str = ""
    # field 工厂函数：每个实例独立创建默认值
    tags: list = field(default_factory=list)

    def __post_init__(self):
        """在 __init__ 之后调用的自定义初始化逻辑。"""
        if self.age < 0:
            raise ValueError("年龄不能为负数")

# 自动生成的方法
p1 = Person("Alice", 30, "alice@example.com")
p2 = Person("Bob", 25)
print(p1)                    # Person(name='Alice', age=30, email='alice@example.com', tags=[])
print(p1 == p2)              # False
print(p1 > p2)               # True（按字段顺序比较）

# 转换
print(asdict(p1))            # {'name': 'Alice', 'age': 30, 'email': 'alice@example.com', 'tags': []}
print(astuple(p1))           # ('Alice', 30, 'alice@example.com', [])
```

**dataclass 常用参数**：

| 参数 | 说明 |
|------|------|
| `init=True` | 自动生成 `__init__` |
| `repr=True` | 自动生成 `__repr__` |
| `eq=True` | 自动生成 `__eq__` |
| `order=False` | 自动生成 `__lt__`、`__le__`、`__gt__`、`__ge__` |
| `frozen=False` | 设置为 `True` 使实例不可变（类似命名元组） |
| `slots=False` | 3.10+，使用 `__slots__` 优化内存 |

**不可变 dataclass**：

```python
@dataclass(frozen=True)
class Point:
    x: float
    y: float

p = Point(1.0, 2.0)
# p.x = 3.0  # FrozenInstanceError: cannot assign to field 'x'

# frozen=True 自动实现 __hash__，可用作字典键
d = {p: "origin"}
print(d[Point(1.0, 2.0)])  # "origin"
```

### 6.4 Enum 枚举类（3.4+）

```python
from enum import Enum, auto

class Color(Enum):
    RED = 1
    GREEN = 2
    BLUE = 3

class Status(Enum):
    PENDING = auto()    # 自动赋值
    ACTIVE = auto()
    CLOSED = auto()

# 使用
c = Color.RED
print(c)              # Color.RED
print(c.name)         # RED
print(c.value)        # 1
print(Color(1))        # Color.RED  ← 按值查找
print(Color['RED'])    # Color.RED  ← 按名查找

# 比较
print(Color.RED == Color.RED)    # True
print(Color.RED is Color.RED)    # True
# Color.RED < Color.GREEN  # TypeError: Enum 不支持大小比较（除非用 IntEnum）

# 迭代
for color in Color:
    print(color)
# Color.RED
# Color.GREEN
# Color.BLUE
```

> **工程建议**：用 `Enum` 替代魔术数字和字符串常量，代码更可读、更安全。

---

## 7. 设计模式在 Python 中的实践

### 7.1 单例模式

**三种实现方式对比**：

```python
# 方式一：使用 __new__（见 1.3 节示例）
class SingletonNew:
    _instance = None
    def __new__(cls, *args, **kwargs):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance

# 方式二：模块级单例（最 Pythonic）
# Python 模块本身就是单例，模块级变量天然只初始化一次
# singleton_config.py:
#     _config = {"debug": True, "db": "mysql://..."}
#     def get_config():
#         return _config

# 方式三：使用元类（见 6.1 节示例）
class SingletonMeta(type):
    _instances = {}
    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            cls._instances[cls] = super().__call__(*args, **kwargs)
        return cls._instances[cls]

# 方式四：使用装饰器
def singleton(cls):
    instances = {}
    @functools.wraps(cls)
    def wrapper(*args, **kwargs):
        if cls not in instances:
            instances[cls] = cls(*args, **kwargs)
        return instances[cls]
    return wrapper
```

| 方式 | 优点 | 缺点 |
|------|------|------|
| `__new__` | 简单 | `__init__` 重复调用 |
| 模块级 | 最简单、最 Pythonic | 需要单独模块文件 |
| 元类 | 最干净、`__init__` 只调用一次 | 理解成本高 |
| 装饰器 | 灵活 | 改变了类类型 |

> **工程建议**：Python 中最推荐的方式是**模块级单例**——把状态放在模块的全局变量中，通过函数访问。这是 Django、Flask 等框架的做法。

### 7.2 工厂模式

```python
class PaymentProcessor:
    def pay(self, amount):
        raise NotImplementedError

class WechatPay(PaymentProcessor):
    def pay(self, amount):
        return f"微信支付 {amount} 元"

class Alipay(PaymentProcessor):
    def pay(self, amount):
        return f"支付宝支付 {amount} 元"

class PaymentFactory:
    """简单工厂。"""
    _processors = {
        "wechat": WechatPay,
        "alipay": Alipay,
    }

    @classmethod
    def create(cls, method):
        processor_class = cls._processors.get(method)
        if not processor_class:
            raise ValueError(f"不支持的支付方式: {method}")
        return processor_class()

    @classmethod
    def register(cls, method, processor_class):
        """注册新的支付方式（开放扩展）。"""
        cls._processors[method] = processor_class

# 使用
processor = PaymentFactory.create("wechat")
print(processor.pay(100))   # 微信支付 100 元

# 扩展：注册新的支付方式
class ApplePay(PaymentProcessor):
    def pay(self, amount):
        return f"Apple Pay 支付 {amount} 元"

PaymentFactory.register("apple", ApplePay)
print(PaymentFactory.create("apple").pay(50))  # Apple Pay 支付 50 元
```

### 7.3 策略模式

```python
class DiscountStrategy:
    def apply(self, price):
        raise NotImplementedError

class NoDiscount(DiscountStrategy):
    def apply(self, price):
        return price

class PercentageDiscount(DiscountStrategy):
    def __init__(self, percent):
        self.percent = percent

    def apply(self, price):
        return price * (1 - self.percent / 100)

class FixedDiscount(DiscountStrategy):
    def __init__(self, amount):
        self.amount = amount

    def apply(self, price):
        return max(0, price - self.amount)

class Order:
    def __init__(self, price, discount_strategy):
        self.price = price
        self.discount = discount_strategy

    def final_price(self):
        return self.discount.apply(self.price)

# 使用
order1 = Order(100, PercentageDiscount(20))
order2 = Order(100, FixedDiscount(15))
print(order1.final_price())   # 80.0
print(order2.final_price())   # 85
```

**策略模式的 Pythonic 写法（用函数替代类）**：

```python
# Python 中函数是一等公民，策略模式可以更简洁
def no_discount(price):
    return price

def percentage_discount(percent):
    def apply(price):
        return price * (1 - percent / 100)
    return apply

def fixed_discount(amount):
    def apply(price):
        return max(0, price - amount)
    return apply

# 使用
order = Order(100, percentage_discount(20))
print(order.final_price())  # 80.0
```

### 7.4 观察者模式

```python
class EventEmitter:
    """简单的事件发射器。"""
    def __init__(self):
        self._listeners = {}

    def on(self, event, callback):
        """注册事件监听器。"""
        self._listeners.setdefault(event, []).append(callback)

    def off(self, event, callback):
        """移除事件监听器。"""
        if event in self._listeners:
            self._listeners[event].remove(callback)

    def emit(self, event, *args, **kwargs):
        """触发事件。"""
        for callback in self._listeners.get(event, []):
            callback(*args, **kwargs)

# 使用
emitter = EventEmitter()

emitter.on('login', lambda user: print(f"用户 {user} 登录了"))
emitter.on('login', lambda user: print(f"发送欢迎邮件给 {user}"))

emitter.emit('login', 'Alice')
# 用户 Alice 登录了
# 发送欢迎邮件给 Alice
```

---

## Python vs Java/C++ OOP 对比

很多 Python 学习者来自 Java 或 C++ 背景，了解它们的差异有助于快速建立 Pythonic 的 OOP 思维。

### 核心差异对比表

| 特性 | Python | Java | C++ |
|------|--------|------|-----|
| **访问控制** | 约定（`_var`、`__var`），无强制 | `private`/`protected`/`public` 关键字 | `private`/`protected`/`public` 关键字 |
| **多重继承** | ✅ 直接支持 | ❌ 不支持（接口可多继承）| ✅ 支持 |
| **抽象类** | `ABC` 模块 + `@abstractmethod` | `abstract` 关键字 | 纯虚函数 `= 0` |
| **接口** | 无关键字，用抽象类或协议 | `interface` 关键字 | 纯虚类 |
| **构造函数** | `__init__`（初始化）+ `__new__`（创建）| 构造方法与类同名 | 构造函数与类同名 |
| **析构函数** | `__del__`（不推荐依赖）| `finalize()`（已弃用）| 析构函数 `~ClassName()` |
| **方法重写** | 无需关键字，直接重定义 | 必须加 `@Override` 注解 | `override` 关键字（C++11）|
| **运算符重载** | ✅ `__add__`、`__eq__` 等 | ❌ 不支持 | ✅ 运算符函数 |
| **属性访问** | `@property` 装饰器 | `get`/`set` 方法或 Lombok | 手动编写 getter/setter |
| **元编程** | 元类、`__init_subclass__` | 注解 + 反射 | 模板元编程 |
| **数据类** | `@dataclass`（自动生成方法）| `record`（Java 14+）| 无内置支持 |
| **鸭子类型** | ✅ 核心特性 | ❌ 强类型 | 部分支持（模板）|

### 访问控制对比

**Java/C++：强制访问控制**

```java
// Java
public class User {
    private String name;        // 只能在类内访问
    protected int age;          // 子类可访问
    public String email;        // 公开访问
    
    public String getName() {   // 通过 getter 访问
        return name;
    }
}
```

**Python：约定式访问控制**

```python
# Python
class User:
    def __init__(self):
        self.__id = 0           # 名称修饰（实际是 _User__id），但仍然可访问
        self._internal = None   # 约定：视为私有，但技术上可访问
        self.name = ""          # 公开属性
    
    @property
    def id(self):               # 通过 property 控制访问
        return self.__id

# Python 的哲学：We are all consenting adults here（我们都是成年人）
# 相信使用者不会滥用，而不是强制限制
```

### 多重继承对比

**Java：接口多继承**

```java
// Java - 只能继承一个类，但可实现多个接口
public class Dog extends Animal implements Runnable, Serializable {
    // 必须实现接口的所有方法
}
```

**Python：真·多重继承 + MRO**

```python
# Python - 可直接多继承
class Dog(Animal, Runnable, Serializable):
    pass

# MRO（方法解析顺序）解决钻石问题
class A:
    def method(self): print("A")

class B(A):
    def method(self): print("B"); super().method()

class C(A):
    def method(self): print("C"); super().method()

class D(B, C):
    def method(self): print("D"); super().method()

# MRO: D → B → C → A
# 调用链: D.method() → B.method() → C.method() → A.method()
```

### 运算符重载对比

**Java：不支持运算符重载**

```java
// Java - 必须使用方法
Vector2D a = new Vector2D(1, 2);
Vector2D b = new Vector2D(3, 4);
Vector2D c = a.add(b);  // 不能写 a + b
```

**Python：运算符重载**

```python
# Python - 可以重载运算符
class Vector2D:
    def __init__(self, x, y):
        self.x = x
        self.y = y
    
    def __add__(self, other):
        return Vector2D(self.x + other.x, self.y + other.y)
    
    def __repr__(self):
        return f"Vector2D({self.x}, {self.y})"

a = Vector2D(1, 2)
b = Vector2D(3, 4)
c = a + b  # 自然直观
```

### 设计哲学差异

| 方面 | Python | Java/C++ |
|------|--------|----------|
| **核心理念** | "We are all consenting adults" | "安全优于灵活" |
| **类型检查** | 运行时（动态类型）| 编译时（静态类型）|
| **隐式行为** | 魔术方法（协议）| 显式关键字 |
| **复杂性** | 简单优先 | 严格控制 |
| **错误发现** | 运行时异常 | 编译时错误 |

---

## 常见面试题汇总

### Q1：`__new__` 和 `__init__` 的区别？

**答案**：
- `__new__`：类方法，负责**创建**对象实例（分配内存），返回实例
- `__init__`：实例方法，负责**初始化**对象属性，不返回值

```python
class Singleton:
    _instance = None
    
    def __new__(cls, *args, **kwargs):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance
    
    def __init__(self, value):
        # 每次调用都会执行！所以单例模式要小心
        self.value = value
```

### Q2：Python 的 MRO 是什么？如何计算？

**答案**：MRO（Method Resolution Order）是方法解析顺序，使用 C3 线性化算法计算。

```python
class A: pass
class B(A): pass
class C(A): pass
class D(B, C): pass

print(D.__mro__)  # (D, B, C, A, object)

# C3 算法规则：
# 1. 子类优先于父类
# 2. 左边父类优先于右边父类
# 3. 每个类只出现一次
```

### Q3：`@classmethod`、`@staticmethod` 和实例方法的区别？

**答案**：

| 类型 | 第一个参数 | 调用方式 | 用途 |
|------|------------|----------|------|
| 实例方法 | `self`（实例）| `obj.method()` | 操作实例数据 |
| 类方法 | `cls`（类）| `Class.method()` 或 `obj.method()` | 工厂方法、操作类数据 |
| 静态方法 | 无 | `Class.method()` | 工具函数，与类相关但不需要类/实例 |

```python
class Date:
    def __init__(self, year, month, day):
        self.year = year
        self.month = month
        self.day = day
    
    def display(self):  # 实例方法
        return f"{self.year}-{self.month}-{self.day}"
    
    @classmethod
    def from_string(cls, date_str):  # 类方法（工厂）
        y, m, d = map(int, date_str.split('-'))
        return cls(y, m, d)
    
    @staticmethod
    def is_valid_date(date_str):  # 静态方法（验证工具）
        try:
            y, m, d = map(int, date_str.split('-'))
            return 1 <= m <= 12 and 1 <= d <= 31
        except:
            return False
```

### Q4：为什么实现了 `__eq__` 后对象就不可哈希了？

**答案**：Python 默认认为相等的对象应该有相同的哈希值。如果只实现 `__eq__` 而不实现 `__hash__`，Python 会将 `__hash__` 设为 `None`，表示对象不可哈希。

```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y
    
    def __eq__(self, other):
        return self.x == other.x and self.y == other.y
    
    def __hash__(self):  # 必须同时实现
        return hash((self.x, self.y))

# 现在可以用作 dict 键或放入 set
p1 = Point(1, 2)
p2 = Point(1, 2)
print(p1 == p2)  # True
print(hash(p1) == hash(p2))  # True
```

### Q5：`@property` 的作用是什么？

**答案**：`@property` 将方法变成属性访问，用于：
1. 实现只读属性
2. 添加访问验证
3. 计算属性（延迟计算）

```python
class Circle:
    def __init__(self, radius):
        self._radius = radius
    
    @property
    def radius(self):
        return self._radius
    
    @radius.setter
    def radius(self, value):
        if value <= 0:
            raise ValueError("半径必须为正数")
        self._radius = value
    
    @property
    def area(self):  # 计算属性，只读
        return 3.14159 * self._radius ** 2

c = Circle(5)
print(c.area)  # 78.54（像属性一样访问）
c.radius = 10  # 带验证的设置
```

### Q6：什么是描述符？

**答案**：描述符是实现了 `__get__`、`__set__`、`__delete__` 中任意一个的类，用于控制属性访问。

```python
class Validator:
    """验证描述符"""
    def __init__(self, min_value, max_value):
        self.min_value = min_value
        self.max_value = max_value
    
    def __set_name__(self, owner, name):
        self.name = name
    
    def __get__(self, obj, owner):
        return obj.__dict__.get(self.name)
    
    def __set__(self, obj, value):
        if not (self.min_value <= value <= self.max_value):
            raise ValueError(f"{self.name} 必须在 {self.min_value}-{self.max_value} 之间")
        obj.__dict__[self.name] = value

class Person:
    age = Validator(0, 150)
    
    def __init__(self, age):
        self.age = age

p = Person(25)  # OK
p.age = 200     # ValueError
```

### Q7：`@dataclass` 的优势是什么？

**答案**：`@dataclass` 自动生成 `__init__`、`__repr__`、`__eq__` 等方法，减少样板代码。

```python
from dataclasses import dataclass, field
from typing import List

@dataclass
class Student:
    name: str
    age: int
    grades: List[int] = field(default_factory=list)
    
    def average_grade(self):
        return sum(self.grades) / len(self.grades) if self.grades else 0

# 自动生成：
# __init__(self, name: str, age: int, grades: List[int] = ...)
# __repr__(self): return f"Student(name={self.name}, ...)"
# __eq__(self, other): return self.name == other.name and ...

s1 = Student("Alice", 20, [90, 85, 92])
s2 = Student("Alice", 20, [90, 85, 92])
print(s1 == s2)  # True（自动比较所有字段）
```

### Q8：元类的作用和使用场景？

**答案**：元类是"类的类"，控制类的创建过程。常见用途：
1. 自动注册子类（工厂模式）
2. 添加类属性/方法
3. 接口检查

```python
# 简化方案：__init_subclass__（Python 3.6+）
class PluginBase:
    _registry = {}
    
    def __init_subclass__(cls, **kwargs):
        super().__init_subclass__(**kwargs)
        PluginBase._registry[cls.__name__] = cls

class SpamFilter(PluginBase):
    pass

class VirusScanner(PluginBase):
    pass

print(PluginBase._registry)
# {'SpamFilter': <class SpamFilter>, 'VirusScanner': <class VirusScanner>}
```

---

## 实战项目：简易 ORM 框架

通过实现一个迷你 ORM（对象关系映射），综合运用 OOP 核心知识。

### 项目目标

创建一个支持以下功能的 ORM：
- 类到表的映射
- 字段类型验证
- 简单查询 API
- 关联关系

### 完整代码

```python
#!/usr/bin/env python3
"""
迷你 ORM 框架 - 第三阶段实战项目
知识点：描述符、元类、魔术方法、继承、属性装饰器
"""

from typing import Any, Dict, List, Optional, Type, get_type_hints
from dataclasses import dataclass
from abc import ABC, abstractmethod
import sqlite3

# ============== 字段描述符 ==============

class Field:
    """字段基类描述符"""
    
    def __init__(self, column_type: str, primary_key: bool = False, 
                 nullable: bool = True, default: Any = None):
        self.column_type = column_type
        self.primary_key = primary_key
        self.nullable = nullable
        self.default = default
        self.name = None
    
    def __set_name__(self, owner, name):
        self.name = name
    
    def __get__(self, obj, owner):
        if obj is None:
            return self
        return obj.__dict__.get(self.name, self.default)
    
    def __set__(self, obj, value):
        self._validate(value)
        obj.__dict__[self.name] = value
    
    def _validate(self, value):
        if value is None:
            if not self.nullable and not self.primary_key:
                raise ValueError(f"{self.name} 不能为空")
        else:
            # 类型检查（简化版）
            type_map = {
                'INTEGER': int,
                'TEXT': str,
                'REAL': float,
            }
            expected_type = type_map.get(self.column_type)
            if expected_type and not isinstance(value, expected_type):
                raise TypeError(f"{self.name} 应为 {expected_type.__name__} 类型")

class IntegerField(Field):
    """整型字段"""
    def __init__(self, primary_key: bool = False, nullable: bool = True, default: int = None):
        super().__init__('INTEGER', primary_key, nullable, default)

class TextField(Field):
    """文本字段"""
    def __init__(self, primary_key: bool = False, nullable: bool = True, default: str = None):
        super().__init__('TEXT', primary_key, nullable, default)

class FloatField(Field):
    """浮点字段"""
    def __init__(self, primary_key: bool = False, nullable: bool = True, default: float = None):
        super().__init__('REAL', primary_key, nullable, default)

# ============== Model 元类 ==============

class ModelMeta(type):
    """模型元类：自动收集字段信息"""
    
    def __new__(mcs, name, bases, namespace):
        cls = super().__new__(mcs, name, bases, namespace)
        
        # 收集字段
        fields = {}
        for key, value in namespace.items():
            if isinstance(value, Field):
                fields[key] = value
        
        # 设置类属性
        cls._fields = fields
        cls._table_name = name.lower() + 's'
        cls._primary_key = None
        
        # 找主键
        for field_name, field in fields.items():
            if field.primary_key:
                cls._primary_key = field_name
                break
        
        return cls

# ============== Model 基类 ==============

class Model(metaclass=ModelMeta):
    """模型基类"""
    
    _fields: Dict[str, Field] = {}
    _table_name: str = ""
    _primary_key: Optional[str] = None
    
    def __init__(self, **kwargs):
        for field_name in self._fields:
            value = kwargs.get(field_name, self._fields[field_name].default)
            setattr(self, field_name, value)
    
    def __repr__(self):
        attrs = ', '.join(f"{k}={v}" for k, v in self.__dict__.items())
        return f"{self.__class__.__name__}({attrs})"
    
    @classmethod
    def get_create_sql(cls) -> str:
        """生成建表 SQL"""
        columns = []
        for name, field in cls._fields.items():
            col_def = f"{name} {field.column_type}"
            if field.primary_key:
                col_def += " PRIMARY KEY"
            if not field.nullable:
                col_def += " NOT NULL"
            columns.append(col_def)
        
        return f"CREATE TABLE IF NOT EXISTS {cls._table_name} ({', '.join(columns)})"
    
    def get_insert_sql(self) -> tuple:
        """生成插入 SQL"""
        columns = list(self._fields.keys())
        values = [getattr(self, col) for col in columns]
        placeholders = ', '.join(['?' for _ in columns])
        
        sql = f"INSERT INTO {self._table_name} ({', '.join(columns)}) VALUES ({placeholders})"
        return sql, values
    
    @classmethod
    def get_select_sql(cls, where: str = None) -> str:
        """生成查询 SQL"""
        sql = f"SELECT * FROM {cls._table_name}"
        if where:
            sql += f" WHERE {where}"
        return sql
    
    def save(self, conn):
        """保存到数据库"""
        sql, values = self.get_insert_sql()
        cursor = conn.cursor()
        cursor.execute(sql, values)
        conn.commit()
        return cursor.lastrowid
    
    @classmethod
    def find_by_id(cls, conn, pk_value) -> Optional['Model']:
        """按主键查询"""
        if not cls._primary_key:
            raise ValueError("未定义主键")
        
        sql = cls.get_select_sql(f"{cls._primary_key} = ?")
        cursor = conn.cursor()
        cursor.execute(sql, (pk_value,))
        row = cursor.fetchone()
        
        if row:
            columns = [desc[0] for desc in cursor.description]
            return cls(**dict(zip(columns, row)))
        return None
    
    @classmethod
    def find_all(cls, conn) -> List['Model']:
        """查询所有"""
        sql = cls.get_select_sql()
        cursor = conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        
        columns = [desc[0] for desc in cursor.description]
        return [cls(**dict(zip(columns, row))) for row in rows]

# ============== 模型定义 ==============

class User(Model):
    """用户模型"""
    id = IntegerField(primary_key=True)
    name = TextField(nullable=False)
    email = TextField(nullable=False)
    age = IntegerField(default=0)

class Product(Model):
    """产品模型"""
    id = IntegerField(primary_key=True)
    name = TextField(nullable=False)
    price = FloatField(nullable=False)
    stock = IntegerField(default=0)

# ============== 使用示例 ==============

def main():
    """演示 ORM 使用"""
    # 创建内存数据库
    conn = sqlite3.connect(':memory:')
    
    # 建表
    conn.execute(User.get_create_sql())
    conn.execute(Product.get_create_sql())
    print("✓ 表创建成功\n")
    
    # 插入数据
    user1 = User(id=1, name="Alice", email="alice@example.com", age=25)
    user2 = User(id=2, name="Bob", email="bob@example.com", age=30)
    user1.save(conn)
    user2.save(conn)
    print(f"✓ 用户插入成功: {user1}, {user2}\n")
    
    # 插入产品
    product1 = Product(id=1, name="Python Book", price=59.9, stock=100)
    product2 = Product(id=2, name="Docker Guide", price=39.9, stock=50)
    product1.save(conn)
    product2.save(conn)
    print(f"✓ 产品插入成功: {product1}, {product2}\n")
    
    # 查询单个
    found_user = User.find_by_id(conn, 1)
    print(f"✓ 查询用户: {found_user}\n")
    
    # 查询所有
    all_users = User.find_all(conn)
    print(f"✓ 所有用户: {all_users}\n")
    
    all_products = Product.find_all(conn)
    print(f"✓ 所有产品: {all_products}\n")
    
    conn.close()

if __name__ == "__main__":
    main()
```

### 运行示例

```
✓ 表创建成功

✓ 用户插入成功: User(id=1, name=Alice, email=alice@example.com, age=25), User(id=2, name=Bob, email=bob@example.com, age=30)

✓ 产品插入成功: Product(id=1, name=Python Book, price=59.9, stock=100), Product(id=2, name=Docker Guide, price=39.9, stock=50)

✓ 查询用户: User(id=1, name=Alice, email=alice@example.com, age=25)

✓ 所有用户: [User(id=1, name=Alice, email=alice@example.com, age=25), User(id=2, name=Bob, email=bob@example.com, age=30)]

✓ 所有产品: [Product(id=1, name=Python Book, price=59.9, stock=100), Product(id=2, name=Docker Guide, price=39.9, stock=50)]
```

### 知识点覆盖

| 功能 | 涉及知识点 |
|------|------------|
| 字段类型 | 描述符（`__get__`、`__set__`）|
| 模型元信息 | 元类（`__new__`）、类属性收集 |
| 数据库操作 | 魔术方法（`__init__`、`__repr__`）|
| 类型验证 | 描述符中的验证逻辑 |
| 继承体系 | 基类设计、子类继承 |

### 进阶练习

1. 添加 `update()` 和 `delete()` 方法
2. 支持外键关联（一对多、多对多）
3. 添加查询构建器（链式调用）
4. 支持迁移（自动检测模型变化）
5. 添加事务支持

---

## 附录：第三阶段自检清单

在继续学习第四阶段之前，请确保你能：

- [ ] 解释 `__new__` 和 `__init__` 的区别，以及各自的调用时机
- [ ] 区分实例方法、类方法和静态方法，并说出各自的使用场景
- [ ] 用 `@property` 实现带验证的属性访问
- [ ] 解释 MRO 和 C3 线性化，画出多继承的 MRO 顺序
- [ ] 说明 `super()` 在多继承中的行为
- [ ] 解释鸭子类型和抽象基类的区别，以及各自的使用场景
- [ ] 实现 `__str__`、`__repr__`、`__len__`、`__getitem__`、`__iter__` 等常用魔术方法
- [ ] 用 `__enter__` 和 `__exit__` 实现自定义上下文管理器
- [ ] 理解元类的作用，并能用 `__init_subclass__` 替代常见元类场景
- [ ] 用 `dataclass` 替代手写 `__init__` 和 `__repr__`
- [ ] 手写单例模式、工厂模式和策略模式
- [ ] 解释 `__hash__` 和 `__eq__` 的关系，以及为什么实现 `__eq__` 后对象不可哈希
- [ ] 使用 `__slots__` 优化内存，并说明其限制
- [ ] 使用 `Enum` 替代魔术数字
- [ ] 用描述符实现自定义验证属性

---

> **工程师寄语**：Python 的 OOP 是"实用主义"的——它给你足够的工具，但不过度约束。理解魔术方法和协议比记住所有设计模式更重要。当你发现自己在重复写样板代码时，停下来想一想：是不是可以用 `dataclass`、描述符或元类来简化？

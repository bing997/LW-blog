---
title: 【Python】设计模式与架构思维（第十二阶段）
date: 2026-07-24 12:00:00
categories:
  - Python
tags:
  - Python
  - 教程
  - 设计模式
  - SOLID
  - 架构
description: 深入理解设计原则（SOLID）和常用设计模式，建立架构思维，学会在合适场景选择合适方案。
cover: /images/cover.png
---

# 十二、设计模式与架构思维

> **阶段定位**：设计模式是解决常见问题的经验总结，架构思维是站在系统层面思考问题的能力。本阶段不是教条式地背诵 23 种设计模式，而是理解模式的本质，学会在合适的场景选择合适的方案，最终形成自己的架构判断力。

```
┌──────────────────────────────────────────────────────────────────┐
│                    设计模式与架构知识图谱                         │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  设计原则（SOLID）                                                │
│    ├── SRP（单一职责）                                            │
│    ├── OCP（开闭原则）                                            │
│    ├── LSP（里氏替换）                                            │
│    ├── ISP（接口隔离）                                            │
│    └── DIP（依赖倒置）                                            │
│                                                                  │
│  创建型模式                                                       │
│    ├── 工厂模式（Factory）                                        │
│    ├── 建造者模式（Builder）                                      │
│    ├── 单例模式（Singleton）                                      │
│    ├── 原型模式（Prototype）                                      │
│    └── 抽象工厂模式（Abstract Factory）                           │
│                                                                  │
│  结构型模式                                                       │
│    ├── 适配器模式（Adapter）                                      │
│    ├── 装饰器模式（Decorator）                                    │
│    ├── 代理模式（Proxy）                                          │
│    ├── 组合模式（Composite）                                      │
│    ├── 享元模式（Flyweight）                                      │
│    └── 门面模式（Facade）                                          │
│                                                                  │
│  行为型模式                                                       │
│    ├── 观察者模式（Observer）                                     │
│    ├── 策略模式（Strategy）                                       │
│    ├── 命令模式（Command）                                        │
│    ├── 模板方法模式（Template Method）                            │
│    └── 迭代器模式（Iterator）                                      │
│                                                                  │
│  架构思维                                                         │
│    ├── 分层架构                                                   │
│    ├── 微服务架构                                                 │
│    ├── 事件驱动架构                                               │
│    ├── 领域驱动设计（DDD）                                        │
│    └── 架构权衡与决策                                             │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## 1. 设计原则（SOLID）

在讲具体模式之前，先理解五条核心设计原则。它们是比模式更根本的东西。

### 1.1 单一职责原则（SRP）

一个类应该只有一个引起它变化的原因。

```python
# 反例：一个类做太多事
class UserManager:
    def create_user(self, name, email): ...
    def delete_user(self, user_id): ...
    def send_email(self, user_id, message): ...   # 不该在这里！
    def generate_report(self): ...                 # 不该在这里！

# 正例：拆分职责
class UserService:
    def create_user(self, name, email): ...
    def delete_user(self, user_id): ...

class EmailService:
    def send(self, to, message): ...

class ReportService:
    def generate(self): ...
```

**职责划分示意图**：

```
反例：一个类承担多个职责
┌─────────────────────────────────────┐
│           UserManager               │
│  ┌─────────────┐                    │
│  │ 用户管理    │                    │
│  ├─────────────┤                    │
│  │ 邮件发送    │ ← 不该在这里！     │
│  ├─────────────┤                    │
│  │ 报表生成    │ ← 不该在这里！     │
│  └─────────────┘                    │
└─────────────────────────────────────┘

正例：每个类只有一个职责
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│    UserService  │  │   EmailService  │  │  ReportService  │
│  ┌───────────┐  │  │  ┌───────────┐  │  │  ┌───────────┐  │
│  │ 用户管理  │  │  │  │ 邮件发送  │  │  │  │ 报表生成  │  │
│  └───────────┘  │  │  └───────────┘  │  │  └───────────┘  │
└─────────────────┘  └─────────────────┘  └─────────────────┘
```

### 1.2 开闭原则（OCP）

对扩展开放，对修改关闭。

```python
# 反例：修改现有代码来添加新功能
class AreaCalculator:
    def calculate(self, shape):
        if isinstance(shape, Rectangle):
            return shape.width * shape.height
        elif isinstance(shape, Circle):    # 新增形状要改这里！
            return 3.14 * shape.radius ** 2

# 正例：扩展而不是修改
from abc import ABC, abstractmethod

class Shape(ABC):
    @abstractmethod
    def area(self) -> float: ...

class Rectangle(Shape):
    def __init__(self, width, height):
        self.width = width
        self.height = height
    def area(self):
        return self.width * self.height

class Circle(Shape):
    def __init__(self, radius):
        self.radius = radius
    def area(self):
        return 3.14159 * self.radius ** 2

# 新增三角形，不需要修改 AreaCalculator
class Triangle(Shape):
    def __init__(self, base, height):
        self.base = base
        self.height = height
    def area(self):
        return 0.5 * self.base * self.height

class AreaCalculator:
    def calculate(self, shape: Shape):
        return shape.area()
```

**开闭原则示意图**：

```
┌───────────────────────┐     ┌───────────────────────────────┐
│     AreaCalculator    │     │ 新增形状（扩展，不修改原有代码） │
│                       │     │                               │
│  def calculate(shape):│     │ class Triangle(Shape):        │
│      return shape.area()│   │     def area(): ...           │
│                       │     │                               │
│  对修改关闭 ← 不变    │     │ 对扩展开放 ← 新增              │
└───────────────────────┘     └───────────────────────────────┘
```

### 1.3 里氏替换原则（LSP）

子类应该能够替换父类，而不破坏程序的正确性。

```python
# 反例：子类破坏了父类的契约
class Bird:
    def fly(self):
        print("Flying")

class Penguin(Bird):   # 企鹅是鸟，但不能飞！
    def fly(self):
        raise Exception("Penguins can't fly")

# 正例：重新设计继承体系
class Bird:
    pass

class FlyingBird(Bird):
    def fly(self): ...

class Penguin(Bird):   # 企鹅是鸟，但不是 FlyingBird
    def swim(self): ...
```

**里氏替换原则示意图**：

```
反例：子类违反父类契约
Bird ──→ fly() ──→ 抛出异常（企鹅不能飞）
    │
    └── Penguin（破坏了 fly 的契约）

正例：正确的继承体系
Bird
    ├── FlyingBird ──→ fly()
    │       ├── Sparrow
    │       └── Eagle
    │
    └── Penguin ──→ swim()（不继承 fly）
```

### 1.4 接口隔离原则（ISP）

客户端不应该依赖它不需要的接口。

```python
# 反例：胖接口
class Machine:
    def print(self): ...
    def scan(self): ...
    def fax(self): ...

class OldPrinter(Machine):   # 老打印机不支持扫描和传真
    def scan(self):
        raise NotImplementedError   # 被迫实现不需要的方法
    def fax(self):
        raise NotImplementedError

# 正例：拆分为小接口
class Printer:
    def print(self): ...

class Scanner:
    def scan(self): ...

class Fax:
    def fax(self): ...

class OldPrinter(Printer):
    def print(self): ...

class MultiFunctionDevice(Printer, Scanner, Fax):
    ...
```

**接口隔离原则示意图**：

```
反例：胖接口，被迫实现不需要的方法
┌─────────────────────────────────────────────┐
│              Machine（胖接口）              │
│  print()  │  scan()  │  fax()             │
└───────────┼──────────┼─────────────────────┘
            │          │
            ▼          ▼
    ┌───────────────┐  ┌───────────────┐
    │ OldPrinter    │  │ 被迫实现     │
    │ 只需要 print()│  │ scan()/fax() │
    └───────────────┘  └───────────────┘

正例：接口隔离，按需实现
┌──────────┐  ┌──────────┐  ┌──────────┐
│ Printer  │  │ Scanner  │  │   Fax    │
│ print()  │  │ scan()   │  │  fax()   │
└────┬─────┘  └────┬─────┘  └────┬─────┘
     │             │             │
     ▼             └──────┬──────┘
┌───────────────┐         │
│ OldPrinter    │         ▼
│ 只实现 print()│  ┌──────────────────────────┐
└───────────────┘  │   MultiFunctionDevice    │
                   │ 实现所有三个接口          │
                   └──────────────────────────┘
```

### 1.5 依赖倒置原则（DIP）

高层模块不应该依赖低层模块，两者都应该依赖抽象。

```python
# 反例：高层模块依赖低层模块
class MySQLDatabase:
    def query(self, sql): ...

class UserRepository:
    def __init__(self):
        self.db = MySQLDatabase()   # 直接依赖具体实现

# 正例：依赖抽象
from abc import ABC, abstractmethod

class Database(ABC):
    @abstractmethod
    def query(self, sql): ...

class UserRepository:
    def __init__(self, db: Database):   # 依赖接口
        self.db = db

# 现在可以随意切换数据库
class MySQLDatabase(Database): ...
class PostgreSQLDatabase(Database): ...
class MongoDB(Database): ...

repo = UserRepository(PostgreSQLDatabase())
```

**依赖倒置原则示意图**：

```
反例：高层依赖低层（紧耦合）
┌─────────────────┐     ┌─────────────────┐
│ UserRepository  │────→│ MySQLDatabase   │
│   高层模块      │     │   低层模块      │
└─────────────────┘     └─────────────────┘
         ↑
         │ 难以替换数据库

正例：都依赖抽象（松耦合）
┌─────────────────┐     ┌─────────────────┐
│ UserRepository  │     │ MySQLDatabase   │
│   高层模块      │     │ PostgreSQL      │
└────────┬────────┘     └────────┬────────┘
         │                      │
         └──────────┬───────────┘
                    ▼
            ┌─────────────────┐
            │   Database      │
            │   抽象接口      │
            └─────────────────┘
                    ↑
                    │ 可以轻松切换实现
```

---

## 2. 创建型模式

创建型模式关注对象的创建过程，将对象创建逻辑封装起来，使代码更加灵活。

### 2.1 工厂模式

将对象的创建与使用分离，通过工厂类统一创建对象。

```python
from abc import ABC, abstractmethod

# 产品接口
class Notification(ABC):
    @abstractmethod
    def send(self, message: str): ...

class EmailNotification(Notification):
    def send(self, message):
        print(f"Email: {message}")

class SMSNotification(Notification):
    def send(self, message):
        print(f"SMS: {message}")

class PushNotification(Notification):
    def send(self, message):
        print(f"Push: {message}")

# 简单工厂
class NotificationFactory:
    @staticmethod
    def create(type_: str) -> Notification:
        notifications = {
            "email": EmailNotification,
            "sms": SMSNotification,
            "push": PushNotification,
        }
        if type_ not in notifications:
            raise ValueError(f"Unknown type: {type_}")
        return notifications[type_]()

# 使用
notifier = NotificationFactory.create("email")
notifier.send("Hello!")
```

**工厂模式结构**：

```
┌─────────────────────────────────────────────────────────────┐
│                      客户端代码                               │
│                                                            │
│  notifier = NotificationFactory.create("email")            │
│  notifier.send("Hello!")                                   │
│                                                            │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│              NotificationFactory（工厂）                     │
│                                                            │
│  create(type_) ──→ 根据类型返回对应的产品实例                │
│                                                            │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│              Notification（抽象产品）                        │
│                                                            │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  EmailNotification  │  SMSNotification            │    │
│  │  PushNotification   │                             │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                            │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 建造者模式

将复杂对象的构建过程与表示分离，使同样的构建过程可以创建不同的表示。

```python
class HttpRequest:
    """HTTP 请求对象。"""
    def __init__(self):
        self.method = "GET"
        self.url = ""
        self.headers = {}
        self.body = None

    def __repr__(self):
        return f"HttpRequest({self.method} {self.url})"

class HttpRequestBuilder:
    """建造者：分步骤构建复杂对象。"""
    def __init__(self):
        self._request = HttpRequest()

    def set_method(self, method: str):
        self._request.method = method
        return self

    def set_url(self, url: str):
        self._request.url = url
        return self

    def add_header(self, key: str, value: str):
        self._request.headers[key] = value
        return self

    def set_body(self, body: str):
        self._request.body = body
        return self

    def build(self) -> HttpRequest:
        return self._request

# 使用（链式调用）
request = (
    HttpRequestBuilder()
    .set_method("POST")
    .set_url("https://api.example.com/users")
    .add_header("Content-Type", "application/json")
    .add_header("Authorization", "Bearer token123")
    .set_body('{"name": "Alice"}')
    .build()
)
```

**建造者模式结构**：

```
┌─────────────────────────────────────────────────────────────┐
│                      客户端代码                               │
│                                                            │
│  HttpRequestBuilder()                                      │
│      .set_method("POST")                                    │
│      .set_url(url)                                          │
│      .add_header(k, v)                                      │
│      .build()                                               │
│                                                            │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│              HttpRequestBuilder（建造者）                     │
│                                                            │
│  set_method() / set_url() / add_header() / set_body()      │
│                         │                                   │
│                         ▼                                   │
│              HttpRequest（产品）                              │
│                                                            │
└─────────────────────────────────────────────────────────────┘
```

### 2.3 单例模式

保证一个类只有一个实例，并提供一个全局访问点。

```python
import threading

class SingletonMeta(type):
    """线程安全单例元类。"""
    _instances = {}
    _lock = threading.Lock()

    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            with cls._lock:
                if cls not in cls._instances:
                    cls._instances[cls] = super().__call__(*args, **kwargs)
        return cls._instances[cls]

class Database(metaclass=SingletonMeta):
    def __init__(self, host="localhost"):
        self.host = host

# 使用
db1 = Database()
db2 = Database()
print(db1 is db2)   # True（同一个实例）
```

**单例模式结构**：

```
┌─────────────────────────────────────────────────────────────┐
│                      客户端代码                               │
│                                                            │
│  db1 = Database()  ──┐                                      │
│  db2 = Database()  ──┼──→ 同一个实例                         │
│  db3 = Database()  ──┘                                      │
│                                                            │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│                 Database（单例类）                            │
│                                                            │
│  ┌─────────────────────────────────────────────────────┐    │
│  │              _instances = {Database: instance}      │    │
│  │              （全局唯一实例）                          │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                            │
└─────────────────────────────────────────────────────────────┘
```

### 2.4 原型模式

通过复制现有对象来创建新对象，而不是从头创建。

```python
import copy

class Prototype(ABC):
    @abstractmethod
    def clone(self): ...

class ConcretePrototype(Prototype):
    def __init__(self, value):
        self.value = value

    def clone(self):
        return copy.deepcopy(self)

# 使用
original = ConcretePrototype(42)
clone = original.clone()

print(original.value)   # 42
print(clone.value)      # 42
print(original is clone)   # False（不同对象，但值相同）
```

### 2.5 抽象工厂模式

提供一个创建一系列相关或相互依赖对象的接口，而无需指定它们具体的类。

```python
from abc import ABC, abstractmethod

# 抽象产品族
class Button(ABC):
    @abstractmethod
    def render(self): ...

class Checkbox(ABC):
    @abstractmethod
    def render(self): ...

# 具体产品：Windows 风格
class WindowsButton(Button):
    def render(self):
        print("Windows Button")

class WindowsCheckbox(Checkbox):
    def render(self):
        print("Windows Checkbox")

# 具体产品：Mac 风格
class MacButton(Button):
    def render(self):
        print("Mac Button")

class MacCheckbox(Checkbox):
    def render(self):
        print("Mac Checkbox")

# 抽象工厂
class GUIFactory(ABC):
    @abstractmethod
    def create_button(self) -> Button: ...
    @abstractmethod
    def create_checkbox(self) -> Checkbox: ...

# 具体工厂
class WindowsFactory(GUIFactory):
    def create_button(self):
        return WindowsButton()
    def create_checkbox(self):
        return WindowsCheckbox()

class MacFactory(GUIFactory):
    def create_button(self):
        return MacButton()
    def create_checkbox(self):
        return MacCheckbox()

# 使用
factory = WindowsFactory()
button = factory.create_button()
checkbox = factory.create_checkbox()
button.render()      # Windows Button
checkbox.render()    # Windows Checkbox
```

**抽象工厂模式结构**：

```
┌─────────────────────────────────────────────────────────────┐
│                      客户端代码                               │
│                                                            │
│  factory = WindowsFactory() / MacFactory()                 │
│  button = factory.create_button()                          │
│  checkbox = factory.create_checkbox()                      │
│                                                            │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│                  GUIFactory（抽象工厂）                      │
│                                                            │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  WindowsFactory  │  MacFactory                     │    │
│  └──────────────────┼─────────────────────────────────┘    │
│                     │                                       │
│                     ▼                                       │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  Button / Checkbox（抽象产品）                       │    │
│  │                                                     │    │
│  │  ┌─────────────────┐  ┌─────────────────┐          │    │
│  │  │WindowsButton    │  │MacButton        │          │    │
│  │  │WindowsCheckbox  │  │MacCheckbox      │          │    │
│  │  └─────────────────┘  └─────────────────┘          │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
```

---

## 3. 结构型模式

结构型模式关注如何将类和对象组合成更大的结构。

### 3.1 适配器模式

将一个类的接口转换成客户希望的另一个接口，使原本不兼容的类可以协同工作。

```python
from abc import ABC, abstractmethod

# 旧系统接口
class OldPaymentGateway:
    def make_payment(self, amount):
        print(f"Old gateway: processing ${amount}")

# 新系统接口
class PaymentProcessor(ABC):
    @abstractmethod
    def process(self, amount: float, currency: str): ...

# 适配器
class PaymentAdapter(PaymentProcessor):
    def __init__(self, old_gateway: OldPaymentGateway):
        self._old = old_gateway

    def process(self, amount: float, currency: str):
        if currency != "USD":
            amount = self._convert_currency(amount, currency, "USD")
        self._old.make_payment(amount)

    def _convert_currency(self, amount, from_c, to_c):
        ...

# 使用
old = OldPaymentGateway()
adapter = PaymentAdapter(old)
adapter.process(100, "EUR")   # 新接口调用旧实现
```

**适配器模式结构**：

```
┌─────────────────────────────────────────────────────────────┐
│                      客户端代码                               │
│                                                            │
│  processor.process(amount, currency)                       │
│                                                            │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│              PaymentAdapter（适配器）                         │
│                                                            │
│  process(amount, currency)                                  │
│         │                                                   │
│         │ 转换接口                                           │
│         ▼                                                   │
│  old_gateway.make_payment(amount)                          │
│                                                            │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│              OldPaymentGateway（被适配者）                    │
│                                                            │
│  make_payment(amount)                                       │
│                                                            │
└─────────────────────────────────────────────────────────────┘
```

### 3.2 装饰器模式（与 Python 装饰器的关系）

动态地给对象添加额外的职责。Python 的 `@decorator` 是装饰器模式的语法糖，但类级别的装饰器模式更灵活。

```python
class Coffee:
    """基础组件。"""
    def cost(self):
        return 5
    def description(self):
        return "Coffee"

class CoffeeDecorator:
    """装饰器基类。"""
    def __init__(self, coffee: Coffee):
        self._coffee = coffee

    def cost(self):
        return self._coffee.cost()

    def description(self):
        return self._coffee.description()

class Milk(CoffeeDecorator):
    def cost(self):
        return self._coffee.cost() + 1
    def description(self):
        return self._coffee.description() + ", Milk"

class Sugar(CoffeeDecorator):
    def cost(self):
        return self._coffee.cost() + 0.5
    def description(self):
        return self._coffee.description() + ", Sugar"

# 使用
coffee = Coffee()
coffee = Milk(coffee)
coffee = Sugar(coffee)
print(f"{coffee.description()}: ${coffee.cost()}")
# Coffee, Milk, Sugar: $6.5
```

**装饰器模式结构**：

```
┌─────────────────────────────────────────────────────────────┐
│                      客户端代码                               │
│                                                            │
│  coffee = Coffee()                                          │
│  coffee = Milk(coffee)                                      │
│  coffee = Sugar(coffee)                                     │
│  coffee.cost() → 6.5                                        │
│                                                            │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│                      Sugar 装饰器                            │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                   Milk 装饰器                        │    │
│  │  ┌───────────────────────────────────────────────┐  │    │
│  │  │              Coffee（基础组件）                │  │    │
│  │  │              cost() = 5                        │  │    │
│  │  └───────────────────────────────────────────────┘  │    │
│  │              Milk.cost() = 5 + 1 = 6              │    │
│  └─────────────────────────────────────────────────────┘    │
│              Sugar.cost() = 6 + 0.5 = 6.5                   │
└─────────────────────────────────────────────────────────────┘
```

### 3.3 代理模式

为其他对象提供一个代理以控制对这个对象的访问。

```python
class Image:
    """真实对象。"""
    def __init__(self, filename):
        self.filename = filename
        self._load()

    def _load(self):
        print(f"Loading heavy image: {self.filename}")

    def display(self):
        print(f"Displaying: {self.filename}")

class ImageProxy:
    """代理：延迟加载。"""
    def __init__(self, filename):
        self.filename = filename
        self._image = None

    def display(self):
        if self._image is None:
            self._image = Image(self.filename)
        self._image.display()

# 使用
images = [ImageProxy(f"image{i}.jpg") for i in range(10)]
# 此时没有加载任何图片
images[0].display()   # 第一次访问时才加载
images[0].display()   # 第二次直接显示（已缓存）
```

**代理模式结构**：

```
┌─────────────────────────────────────────────────────────────┐
│                      客户端代码                               │
│                                                            │
│  proxy.display()                                            │
│                                                            │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│              ImageProxy（代理）                               │
│                                                            │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  第一次调用: 创建 Image 对象                         │    │
│  │  后续调用: 直接使用缓存的 Image                      │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                            │
└────────────────────┬────────────────────────────────────────┘
                     │ 延迟加载
                     ▼
┌─────────────────────────────────────────────────────────────┐
│                 Image（真实对象）                              │
│                                                            │
│  _load() → 耗时操作                                         │
│  display()                                                  │
│                                                            │
└─────────────────────────────────────────────────────────────┘
```

### 3.4 组合模式

将对象组合成树形结构以表示"部分-整体"的层次结构。

```python
from abc import ABC, abstractmethod
from typing import List

class Component(ABC):
    @abstractmethod
    def display(self, depth=0): ...

class Leaf(Component):
    def __init__(self, name):
        self.name = name

    def display(self, depth=0):
        print("  " * depth + f"- {self.name}")

class Composite(Component):
    def __init__(self, name):
        self.name = name
        self._children: List[Component] = []

    def add(self, child: Component):
        self._children.append(child)

    def remove(self, child: Component):
        self._children.remove(child)

    def display(self, depth=0):
        print("  " * depth + f"+ {self.name}")
        for child in self._children:
            child.display(depth + 1)

# 使用
root = Composite("root")
root.add(Leaf("leaf1"))
root.add(Leaf("leaf2"))

branch = Composite("branch")
branch.add(Leaf("leaf3"))
branch.add(Leaf("leaf4"))
root.add(branch)

root.display()
# + root
#   - leaf1
#   - leaf2
#   + branch
#     - leaf3
#     - leaf4
```

### 3.5 享元模式

运用共享技术有效地支持大量细粒度的对象。

```python
class Flyweight:
    def __init__(self, intrinsic_state):
        self.intrinsic_state = intrinsic_state

    def operation(self, extrinsic_state):
        print(f"Flyweight: {self.intrinsic_state}, {extrinsic_state}")

class FlyweightFactory:
    def __init__(self):
        self._flyweights = {}

    def get_flyweight(self, key):
        if key not in self._flyweights:
            self._flyweights[key] = Flyweight(key)
        return self._flyweights[key]

# 使用
factory = FlyweightFactory()

# 获取享元对象
f1 = factory.get_flyweight("key1")
f2 = factory.get_flyweight("key1")
f3 = factory.get_flyweight("key2")

print(f1 is f2)   # True（同一个对象）
print(f1 is f3)   # False（不同对象）

f1.operation("state1")
f2.operation("state2")
```

### 3.6 门面模式

提供一个统一的接口，用来访问子系统中的一群接口。

```python
class CPU:
    def boot(self):
        print("CPU booting")

class Memory:
    def load(self):
        print("Memory loading")

class HardDrive:
    def read(self):
        print("HardDrive reading")

class Computer:
    """门面：简化复杂子系统的访问。"""
    def __init__(self):
        self.cpu = CPU()
        self.memory = Memory()
        self.hard_drive = HardDrive()

    def start(self):
        self.cpu.boot()
        self.memory.load()
        self.hard_drive.read()
        print("Computer started!")

# 使用
computer = Computer()
computer.start()   # 一个调用完成所有启动流程
```

---

## 4. 行为型模式

行为型模式关注对象之间的通信和职责分配。

### 4.1 观察者模式

定义对象间的一对多依赖，当一个对象状态改变时，所有依赖者都会收到通知。

```python
from typing import List

class Observer:
    def update(self, event: str, data: dict):
        raise NotImplementedError

class Subject:
    def __init__(self):
        self._observers: List[Observer] = []

    def attach(self, observer: Observer):
        self._observers.append(observer)

    def detach(self, observer: Observer):
        self._observers.remove(observer)

    def notify(self, event: str, data: dict):
        for observer in self._observers:
            observer.update(event, data)

class EmailNotifier(Observer):
    def update(self, event, data):
        if event == "user_registered":
            print(f"Sending welcome email to {data['email']}")

class AnalyticsTracker(Observer):
    def update(self, event, data):
        print(f"Tracking event: {event}")

class AuditLogger(Observer):
    def update(self, event, data):
        print(f"Audit: {event} at {data.get('timestamp')}")

# 使用
subject = Subject()
subject.attach(EmailNotifier())
subject.attach(AnalyticsTracker())
subject.attach(AuditLogger())

subject.notify("user_registered", {"email": "alice@example.com", "timestamp": "2024-01-01"})
```

**观察者模式结构**：

```
┌─────────────────────────────────────────────────────────────┐
│                      Subject（主题）                          │
│                                                            │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  _observers = [EmailNotifier,                        │    │
│  │                AnalyticsTracker,                     │    │
│  │                AuditLogger]                          │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                            │
│  notify(event, data) ──→ 通知所有观察者                      │
│                                                            │
└────────────────────┬────────────────────────────────────────┘
                     │
       ┌─────────────┼─────────────┬─────────────┐
       ▼             ▼             ▼             ▼
┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│EmailNotifier │ │AnalyticsTracker│ │ AuditLogger  │
└──────────────┘ └──────────────┘ └──────────────┘
```

### 4.2 策略模式

定义一系列算法，把它们封装起来，并使它们可以互相替换。

```python
from typing import Callable

# Python 中策略模式可以用函数更简洁地实现
DiscountStrategy = Callable[[float], float]

def no_discount(price: float) -> float:
    return price

def percentage_discount(percent: float) -> DiscountStrategy:
    def apply(price: float) -> float:
        return price * (1 - percent / 100)
    return apply

def fixed_discount(amount: float) -> DiscountStrategy:
    def apply(price: float) -> float:
        return max(0, price - amount)
    return apply

class Order:
    def __init__(self, price: float, strategy: DiscountStrategy = no_discount):
        self.price = price
        self.strategy = strategy

    def final_price(self) -> float:
        return self.strategy(self.price)

# 使用
order1 = Order(100, percentage_discount(20))
order2 = Order(100, fixed_discount(30))
print(order1.final_price())   # 80.0
print(order2.final_price())   # 70.0
```

### 4.3 模板方法模式

定义算法的骨架，将一些步骤延迟到子类中实现。

```python
from abc import ABC, abstractmethod

class DataImporter(ABC):
    """模板：定义导入流程的骨架。"""

    def import_data(self, filepath):
        """模板方法，定义算法骨架。"""
        raw = self._read_file(filepath)
        parsed = self._parse(raw)
        validated = self._validate(parsed)
        self._save(validated)
        self._post_process()

    def _read_file(self, filepath):
        with open(filepath, "r") as f:
            return f.read()

    @abstractmethod
    def _parse(self, raw_data):
        """子类必须实现。"""
        pass

    def _validate(self, data):
        """钩子：默认实现，子类可覆盖。"""
        return data

    def _save(self, data):
        print(f"Saving {len(data)} records")

    def _post_process(self):
        """钩子：可选覆盖。"""
        pass

class CSVImporter(DataImporter):
    def _parse(self, raw_data):
        import csv
        return list(csv.reader(raw_data.splitlines()))

class JSONImporter(DataImporter):
    def _parse(self, raw_data):
        import json
        return json.loads(raw_data)

# 使用
CSVImporter().import_data("data.csv")
JSONImporter().import_data("data.json")
```

**模板方法模式结构**：

```
┌─────────────────────────────────────────────────────────────┐
│              DataImporter（抽象模板类）                       │
│                                                            │
│  import_data(filepath)  ← 模板方法（固定流程）               │
│      │                                                      │
│      ├── _read_file()    ← 固定步骤                         │
│      ├── _parse()        ← 抽象步骤（子类实现）              │
│      ├── _validate()     ← 钩子（可选覆盖）                  │
│      ├── _save()         ← 固定步骤                         │
│      └── _post_process() ← 钩子（可选覆盖）                  │
│                                                            │
└────────────────────┬────────────────────────────────────────┘
                     │
              ┌──────┴──────┐
              ▼             ▼
    ┌───────────────┐  ┌───────────────┐
    │ CSVImporter   │  │ JSONImporter  │
    │ _parse: CSV   │  │ _parse: JSON  │
    └───────────────┘  └───────────────┘
```

### 4.4 责任链模式

将请求沿着链传递，直到有一个处理者处理它。

```python
from typing import Optional
from abc import ABC, abstractmethod

class Handler(ABC):
    def __init__(self):
        self._next: Optional[Handler] = None

    def set_next(self, handler: "Handler") -> "Handler":
        self._next = handler
        return handler

    def handle(self, request):
        if self._next:
            return self._next.handle(request)
        return None

class AuthHandler(Handler):
    def handle(self, request):
        if not request.get("token"):
            return "Unauthorized"
        print("Auth passed")
        return super().handle(request)

class RateLimitHandler(Handler):
    def __init__(self):
        super().__init__()
        self.requests = 0

    def handle(self, request):
        self.requests += 1
        if self.requests > 100:
            return "Rate limit exceeded"
        print("Rate limit ok")
        return super().handle(request)

class ValidationHandler(Handler):
    def handle(self, request):
        if not request.get("data"):
            return "Invalid data"
        print("Validation passed")
        return super().handle(request)

# 组装责任链
auth = AuthHandler()
rate = RateLimitHandler()
validate = ValidationHandler()

auth.set_next(rate).set_next(validate)

# 使用
result = auth.handle({"token": "abc", "data": {"name": "Alice"}})
print(result)   # None（所有处理通过）
```

**责任链模式结构**：

```
┌─────────────────────────────────────────────────────────────┐
│                      客户端代码                               │
│                                                            │
│  auth.handle(request)                                       │
│                                                            │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐
│ AuthHandler      │───→│ RateLimitHandler │───→│ ValidationHandler│
│ 验证 token       │    │ 检查请求频率     │    │ 验证数据         │
└──────────────────┘    └──────────────────┘    └──────────────────┘
```

---

## 5. Pythonic 的架构模式

### 5.1 依赖注入

通过构造函数或参数传入依赖，而不是在内部创建依赖。

```python
from typing import Protocol

class Database(Protocol):
    def get_user(self, user_id: int) -> dict: ...
    def save_user(self, user: dict) -> None: ...

class UserService:
    """依赖注入：通过构造函数传入依赖。"""
    def __init__(self, db: Database, notifier):
        self.db = db
        self.notifier = notifier

    def register_user(self, name: str, email: str):
        user = {"name": name, "email": email}
        self.db.save_user(user)
        self.notifier.send(email, "Welcome!")
        return user

# 使用
from unittest.mock import Mock

# 测试时注入 Mock
mock_db = Mock()
mock_db.get_user.return_value = {"name": "Alice"}
mock_notifier = Mock()

service = UserService(mock_db, mock_notifier)
user = service.register_user("Bob", "bob@example.com")

mock_db.save_user.assert_called_once()
mock_notifier.send.assert_called_once_with("bob@example.com", "Welcome!")
```

**依赖注入示意图**：

```
┌─────────────────────────────────────────────────────────────┐
│                      组装层（DI Container）                   │
│                                                            │
│  db = MySQLDatabase()                                       │
│  notifier = EmailNotifier()                                 │
│  service = UserService(db, notifier)  ← 注入依赖            │
│                                                            │
└─────────────────────────────────────────────────────────────┘
```

### 5.2 仓储模式（Repository）

将数据访问逻辑封装在抽象层中，使业务层与具体数据源解耦。

```python
from abc import ABC, abstractmethod
from typing import List, Optional

class User:
    def __init__(self, id: int, name: str, email: str):
        self.id = id
        self.name = name
        self.email = email

class UserRepository(ABC):
    """抽象仓储：定义数据访问接口。"""
    @abstractmethod
    def get_by_id(self, user_id: int) -> Optional[User]: ...

    @abstractmethod
    def get_all(self) -> List[User]: ...

    @abstractmethod
    def save(self, user: User) -> None: ...

    @abstractmethod
    def delete(self, user_id: int) -> None: ...

class InMemoryUserRepository(UserRepository):
    """内存实现：用于测试。"""
    def __init__(self):
        self._users = {}
        self._counter = 0

    def get_by_id(self, user_id: int):
        return self._users.get(user_id)

    def get_all(self):
        return list(self._users.values())

    def save(self, user: User):
        if user.id == 0:
            self._counter += 1
            user.id = self._counter
        self._users[user.id] = user

    def delete(self, user_id: int):
        self._users.pop(user_id, None)

class SQLUserRepository(UserRepository):
    """SQL 实现：用于生产。"""
    def __init__(self, session):
        self.session = session

    def get_by_id(self, user_id: int):
        row = self.session.execute("SELECT * FROM users WHERE id = ?", (user_id,)).fetchone()
        return User(*row) if row else None

# 使用
# 测试用内存版本
repo = InMemoryUserRepository()
service = UserService(repo)

# 生产用 SQL 版本
# repo = SQLUserRepository(db_session)
# service = UserService(repo)
```

### 5.3 单元工作模式（Unit of Work）

管理事务边界，确保一组操作要么全成功，要么全回滚。

```python
class UnitOfWork:
    """管理事务边界，确保一组操作要么全成功，要么全回滚。"""
    def __init__(self, session):
        self.session = session
        self.new_objects = []
        self.dirty_objects = []
        self.removed_objects = []

    def register_new(self, obj):
        self.new_objects.append(obj)

    def register_dirty(self, obj):
        self.dirty_objects.append(obj)

    def register_removed(self, obj):
        self.removed_objects.append(obj)

    def commit(self):
        try:
            for obj in self.new_objects:
                self.session.insert(obj)
            for obj in self.dirty_objects:
                self.session.update(obj)
            for obj in self.removed_objects:
                self.session.delete(obj)
            self.session.commit()
        except Exception:
            self.session.rollback()
            raise
        finally:
            self.new_objects.clear()
            self.dirty_objects.clear()
            self.removed_objects.clear()

# 使用
with UnitOfWork(session) as uow:
    user = User(name="Alice", email="alice@example.com")
    uow.register_new(user)
    uow.commit()   # 统一提交
```

---

## 6. 架构思维

### 6.1 分层架构

```
典型的 Web 应用分层：

┌─────────────────────────────────────┐
│  表现层 (Presentation)               │  FastAPI / Django Views
│  - API 路由、请求验证、序列化         │
├─────────────────────────────────────┤
│  业务层 (Business/Service)           │  Service 类
│  - 业务逻辑、流程编排、规则校验       │
├─────────────────────────────────────┤
│  数据层 (Data Access)                │  Repository / ORM
│  - 数据库操作、缓存、外部 API 调用    │
├─────────────────────────────────────┤
│  领域模型 (Domain)                   │  Entity / Value Object
│  - 核心业务规则、实体定义             │
└─────────────────────────────────────┘

依赖方向：上层 → 下层（领域层不依赖任何层）
```

### 6.2 微服务拆分原则

```python
# 单体 vs 微服务的决策树

"""
是否应该拆分为微服务？

1. 团队规模 > 10 人？
   否 → 单体足够
   是 → 继续

2. 不同模块的发布节奏差异大？
   否 → 单体 + 模块化
   是 → 继续

3. 有独立扩展需求？（如订单服务压力远大于用户服务）
   否 → 单体 + 模块化
   是 → 考虑微服务

4. 团队具备 DevOps 能力？
   否 → 先提升运维能力
   是 → 可以拆分

微服务拆分粒度：
- 按业务能力（用户服务、订单服务、支付服务）
- 按数据所有权（每个服务独占数据库）
- 避免过细（纳米服务反模式）
"""
```

### 6.3 常见架构反模式

| 反模式 | 症状 | 解决 |
|--------|------|------|
| **大泥球** | 代码耦合严重，改一处坏多处 | 模块化、重构、引入边界 |
| **面条代码** | 没有分层，业务逻辑散落在各处 | 引入分层架构、Service 层 |
| **上帝类** | 一个类几千行，什么都管 | 拆分职责、提取协作类 |
| **重复代码** | 同样的逻辑复制粘贴 | 提取函数/类、使用继承或组合 |
| **过早优化** | 在不需要的地方引入复杂设计 | YAGNI（You Ain't Gonna Need It）|
| **过度工程** | 为了用模式而用模式 | 简单优先，按需引入复杂度 |

### 6.4 补充模式

#### 命令模式（Command）

将请求封装为对象，支持参数化、队列、日志、撤销操作。

```python
from typing import List, Optional
from abc import ABC, abstractmethod

class Command(ABC):
    """命令接口。"""
    @abstractmethod
    def execute(self): ...

    @abstractmethod
    def undo(self): ...

class TextEditor:
    """接收者（Receiver）。"""
    def __init__(self):
        self.text = ""

    def insert(self, text, pos=None):
        if pos is None:
            self.text += text
        else:
            self.text = self.text[:pos] + text + self.text[pos:]

    def delete(self, start, end):
        self.text = self.text[:start] + self.text[end:]

class InsertCommand(Command):
    def __init__(self, editor, text, pos=None):
        self.editor = editor
        self.text = text
        self.pos = pos

    def execute(self):
        self.editor.insert(self.text, self.pos)

    def undo(self):
        if self.pos is None:
            start = len(self.editor.text) - len(self.text)
        else:
            start = self.pos
        self.editor.delete(start, start + len(self.text))

class CommandHistory:
    """保存命令历史，支持撤销。"""
    def __init__(self):
        self._history: List[Command] = []
        self._position = -1

    def execute(self, cmd: Command):
        cmd.execute()
        self._history = self._history[:self._position + 1]
        self._history.append(cmd)
        self._position += 1

    def undo(self):
        if self._position >= 0:
            cmd = self._history[self._position]
            cmd.undo()
            self._position -= 1

    def redo(self):
        if self._position + 1 < len(self._history):
            self._position += 1
            self._history[self._position].execute()

# 使用
editor = TextEditor()
history = CommandHistory()
history.execute(InsertCommand(editor, "Hello"))
history.execute(InsertCommand(editor, " World"))
print(editor.text)   # Hello World
history.undo()
print(editor.text)   # Hello
```

#### 状态模式（State）

允许对象在内部状态改变时改变其行为，看起来就像改变了类。

```python
from abc import ABC, abstractmethod

class OrderState(ABC):
    """订单状态接口。"""
    @abstractmethod
    def pay(self, order): ...
    @abstractmethod
    def ship(self, order): ...
    @abstractmethod
    def cancel(self, order): ...

class PendingState(OrderState):
    def pay(self, order):
        print("订单已支付")
        order.state = PaidState()

    def ship(self, order):
        print("请先支付")

    def cancel(self, order):
        print("订单已取消")
        order.state = CancelledState()

class PaidState(OrderState):
    def pay(self, order):
        print("订单已支付，无需重复支付")

    def ship(self, order):
        print("订单已发货")
        order.state = ShippedState()

    def cancel(self, order):
        print("订单已取消，退款处理中")
        order.state = CancelledState()

class ShippedState(OrderState):
    def pay(self, order):
        print("订单已发货，无需支付")

    def ship(self, order):
        print("订单已发货，请勿重复发货")

    def cancel(self, order):
        print("订单已发货，取消需联系客服")

class CancelledState(OrderState):
    def pay(self, order):
        print("订单已取消，无法支付")

    def ship(self, order):
        print("订单已取消，无法发货")

    def cancel(self, order):
        print("订单已取消，无需重复取消")

class Order:
    def __init__(self):
        self.state = PendingState()

    def pay(self):
        self.state.pay(self)

    def ship(self):
        self.state.ship(self)

    def cancel(self):
        self.state.cancel(self)

# 使用
order = Order()
order.pay()          # 订单已支付
order.ship()         # 订单已发货
order.cancel()       # 订单已发货，取消需联系客服
```

**状态模式转换图**：

```
     ┌──────────────────┐
     │   PendingState   │
     └────────┬─────────┘
              │ pay()
              ▼
     ┌──────────────────┐     cancel()      ┌──────────────────┐
     │   PaidState      │──────────────────→│  CancelledState  │
     └────────┬─────────┘                   └──────────────────┘
              │ ship()
              ▼
     ┌──────────────────┐     cancel()      ┌──────────────────┐
     │  ShippedState    │──────────────────→│  CancelledState  │
     └──────────────────┘                   └──────────────────┘
```

---

## 7. 工作实战场景

### 7.1 重构大型单体应用

**场景描述**：接手一个 10000+ 行的单体应用，代码耦合严重，需要重构为模块化架构。

```python
# 问题：大泥球代码，所有逻辑混在一起
class MegaService:
    def process_order(self, order_data):
        # 验证数据（业务逻辑）
        if not order_data.get("user_id"):
            raise ValueError("Missing user_id")
        
        # 数据库操作（数据层）
        db = MySQLDatabase()
        user = db.query(f"SELECT * FROM users WHERE id = {order_data['user_id']}")
        
        # 发送通知（表现层）
        email_service = EmailService()
        email_service.send(user["email"], "Order received")
        
        # 记录日志（基础设施）
        logger.info(f"Order processed: {order_data}")

# 解决方案：分层重构
# 1. 领域模型层
class Order:
    def __init__(self, user_id, items):
        self.user_id = user_id
        self.items = items
    
    def validate(self):
        if not self.user_id:
            raise ValueError("Missing user_id")
        if not self.items:
            raise ValueError("Empty order")

# 2. 数据访问层（仓储模式）
class OrderRepository:
    def __init__(self, db):
        self.db = db
    
    def save(self, order):
        self.db.execute("INSERT INTO orders ...")

# 3. 业务逻辑层（服务层）
class OrderService:
    def __init__(self, order_repo, user_repo, notifier):
        self.order_repo = order_repo
        self.user_repo = user_repo
        self.notifier = notifier
    
    def process_order(self, order_data):
        order = Order(order_data["user_id"], order_data["items"])
        order.validate()
        
        user = self.user_repo.get_by_id(order.user_id)
        self.order_repo.save(order)
        self.notifier.send(user.email, "Order received")

# 4. 表现层（API 层）
@app.post("/orders")
def create_order(request):
    service = OrderService(order_repo, user_repo, email_notifier)
    service.process_order(request.json())
    return {"status": "success"}
```

### 7.2 构建可扩展的插件系统

**场景描述**：需要构建一个支持插件扩展的应用框架。

```python
# 插件系统设计
from abc import ABC, abstractmethod
from typing import Dict, Type

class Plugin(ABC):
    """插件接口。"""
    @abstractmethod
    def name(self) -> str: ...
    
    @abstractmethod
    def initialize(self): ...

class PluginManager:
    """插件管理器（工厂模式变体）。"""
    def __init__(self):
        self._plugins: Dict[str, Plugin] = {}
        self._registry: Dict[str, Type[Plugin]] = {}
    
    def register(self, plugin_class: Type[Plugin]):
        """注册插件类。"""
        self._registry[plugin_class.name()] = plugin_class
    
    def load(self, plugin_name: str):
        """加载并初始化插件。"""
        if plugin_name not in self._registry:
            raise ValueError(f"Unknown plugin: {plugin_name}")
        
        if plugin_name not in self._plugins:
            plugin = self._registry[plugin_name]()
            plugin.initialize()
            self._plugins[plugin_name] = plugin
        
        return self._plugins[plugin_name]
    
    def get_all(self):
        """获取所有已加载的插件。"""
        return list(self._plugins.values())

# 插件实现示例
class AuthPlugin(Plugin):
    def name(self):
        return "auth"
    
    def initialize(self):
        print("Auth plugin initialized")

class PaymentPlugin(Plugin):
    def name(self):
        return "payment"
    
    def initialize(self):
        print("Payment plugin initialized")

# 使用
manager = PluginManager()
manager.register(AuthPlugin)
manager.register(PaymentPlugin)

auth = manager.load("auth")
payment = manager.load("payment")
```

### 7.3 实现事件驱动架构

**场景描述**：构建一个电商系统，订单创建后需要触发多个下游操作。

```python
# 事件驱动架构（观察者模式变体）
import asyncio
from typing import Callable, Dict, List

class EventBus:
    """事件总线：解耦事件发布者和订阅者。"""
    def __init__(self):
        self._subscribers: Dict[str, List[Callable]] = {}
    
    def subscribe(self, event_type: str, handler: Callable):
        """订阅事件。"""
        if event_type not in self._subscribers:
            self._subscribers[event_type] = []
        self._subscribers[event_type].append(handler)
    
    async def publish(self, event_type: str, data: dict):
        """发布事件（异步）。"""
        handlers = self._subscribers.get(event_type, [])
        tasks = [handler(data) for handler in handlers]
        await asyncio.gather(*tasks)

# 事件处理器
async def send_welcome_email(data):
    print(f"Sending email to {data['email']}")
    await asyncio.sleep(0.5)

async def update_inventory(data):
    print(f"Updating inventory for order {data['order_id']}")
    await asyncio.sleep(0.3)

async def create_analytics_record(data):
    print(f"Recording analytics: {data}")
    await asyncio.sleep(0.2)

# 使用
event_bus = EventBus()
event_bus.subscribe("order_created", send_welcome_email)
event_bus.subscribe("order_created", update_inventory)
event_bus.subscribe("order_created", create_analytics_record)

# 发布事件
asyncio.run(event_bus.publish(
    "order_created",
    {"order_id": 123, "email": "alice@example.com", "items": ["item1"]}
))
```

---

## 8. 常见面试题汇总

### 8.1 SOLID 原则

**Q1：什么是 SOLID 原则？分别解释每个原则。**

> **A**：
> - **S**RP（单一职责）：一个类只负责一件事
> - **O**CP（开闭原则）：对扩展开放，对修改关闭
> - **L**SP（里氏替换）：子类可以替换父类而不破坏功能
> - **I**SP（接口隔离）：客户端不应依赖不需要的接口
> - **D**IP（依赖倒置）：依赖抽象而非具体实现

**Q2：为什么单一职责原则很重要？**

> **A**：
> - 提高代码可维护性：修改一个功能不影响其他功能
> - 提高代码可读性：每个类职责清晰
> - 提高可测试性：职责单一的类更容易测试

**Q3：开闭原则的核心思想是什么？如何实现？**

> **A**：核心思想是通过**抽象**和**多态**实现扩展。实现方式：
> - 定义抽象接口/基类
> - 通过继承或组合扩展功能
> - 使用依赖注入解耦

### 8.2 创建型模式

**Q4：工厂模式和抽象工厂模式的区别是什么？**

> **A**：
> - **工厂模式**：创建单一类型的对象（如不同类型的通知）
> - **抽象工厂模式**：创建一组相关或依赖的对象（如 UI 组件套件）

**Q5：单例模式有什么优缺点？**

> **A**：
> - **优点**：全局唯一实例，节省资源，统一管理状态
> - **缺点**：难以测试（全局状态），可能导致代码耦合，并发问题需要处理

**Q6：建造者模式适用于什么场景？**

> **A**：适用于创建**复杂对象**，需要分步骤构建，且构建过程可能有不同变体的场景：
> - HTTP 请求对象（方法、URL、头、体）
> - 配置对象（多个可选参数）
> - 文档对象（标题、内容、格式）

### 8.3 结构型模式

**Q7：装饰器模式和代理模式的区别是什么？**

> **A**：
> - **装饰器模式**：动态添加职责，关注功能扩展
> - **代理模式**：控制访问，关注权限控制、延迟加载等

**Q8：适配器模式的使用场景是什么？**

> **A**：
> - 集成旧系统与新系统（接口不兼容）
> - 调用第三方库（接口不符合预期）
> - 兼容不同版本的 API

**Q9：组合模式的核心思想是什么？**

> **A**：将对象组合成树形结构，表示"部分-整体"关系，使单个对象和组合对象具有一致的接口。

### 8.4 行为型模式

**Q10：观察者模式和发布订阅模式的区别是什么？**

> **A**：
> - **观察者模式**：同步通知，直接调用
> - **发布订阅模式**：异步通知，通过消息队列解耦

**Q11：策略模式在 Python 中如何简洁实现？**

> **A**：可以直接使用函数作为策略，无需定义接口类：
> ```python
> def discount_10_percent(price):
>     return price * 0.9
> 
> class Order:
>     def __init__(self, price, discount_strategy):
>         self.price = price
>         self.discount_strategy = discount_strategy
> ```

**Q12：责任链模式适用于什么场景？**

> **A**：请求需要经过多个处理步骤，且步骤顺序可能变化：
> - 中间件链（如 Flask/Django 的中间件）
> - 请求处理管道（认证 → 限流 → 验证 → 处理）

### 8.5 架构思维

**Q13：什么是分层架构？各层职责是什么？**

> **A**：
> - **表现层**：处理请求/响应、路由、验证
> - **业务层**：业务逻辑、流程编排
> - **数据层**：数据库操作、缓存
> - **领域层**：核心业务规则、实体定义

**Q14：什么时候应该拆分微服务？**

> **A**：
> - 团队规模大（>10 人），需要并行开发
> - 不同模块发布节奏差异大
> - 有独立扩展需求
> - 具备 DevOps 能力

**Q15：什么是架构反模式？举几个例子。**

> **A**：反模式是常见的错误设计，导致维护困难：
> - **大泥球**：代码耦合严重
> - **上帝类**：一个类做太多事
> - **面条代码**：没有分层
> - **过早优化**：过度设计

---

## 9. 实战项目：电商订单管理系统

### 9.1 项目目标

开发一个完整的电商订单管理系统，涵盖：
1. 订单创建与处理流程
2. 状态管理
3. 事件驱动通知
4. 数据持久化

### 9.2 项目结构

```
order_system/
├── __init__.py
├── domain/              # 领域模型层
│   ├── __init__.py
│   ├── order.py        # 订单实体
│   └── product.py      # 产品实体
├── repository/          # 数据访问层
│   ├── __init__.py
│   ├── order_repo.py   # 订单仓储
│   └── product_repo.py # 产品仓储
├── service/             # 业务逻辑层
│   ├── __init__.py
│   ├── order_service.py # 订单服务
│   └── inventory_service.py # 库存服务
├── event/               # 事件系统
│   ├── __init__.py
│   ├── event_bus.py    # 事件总线
│   └── handlers.py     # 事件处理器
├── state/               # 状态模式
│   ├── __init__.py
│   └── order_state.py  # 订单状态
└── main.py              # 入口
```

### 9.3 核心代码

```python
# domain/order.py - 领域模型
from dataclasses import dataclass
from typing import List

@dataclass
class OrderItem:
    product_id: int
    quantity: int
    price: float

@dataclass
class Order:
    id: int = 0
    user_id: int = 0
    items: List[OrderItem] = None
    status: str = "pending"
    
    def __post_init__(self):
        if self.items is None:
            self.items = []
    
    @property
    def total_amount(self):
        return sum(item.price * item.quantity for item in self.items)
    
    def validate(self):
        if not self.user_id:
            raise ValueError("user_id is required")
        if not self.items:
            raise ValueError("order must have items")
        for item in self.items:
            if item.quantity <= 0:
                raise ValueError(f"quantity must be positive: {item.product_id}")

# state/order_state.py - 状态模式
from abc import ABC, abstractmethod

class OrderState(ABC):
    @abstractmethod
    def pay(self, order): ...
    
    @abstractmethod
    def ship(self, order): ...
    
    @abstractmethod
    def cancel(self, order): ...

class PendingState(OrderState):
    def pay(self, order):
        order.status = "paid"
        return "order paid successfully"
    
    def ship(self, order):
        return "cannot ship: order not paid"
    
    def cancel(self, order):
        order.status = "cancelled"
        return "order cancelled"

class PaidState(OrderState):
    def pay(self, order):
        return "cannot pay: order already paid"
    
    def ship(self, order):
        order.status = "shipped"
        return "order shipped"
    
    def cancel(self, order):
        order.status = "refunded"
        return "order cancelled, refund processing"

class ShippedState(OrderState):
    def pay(self, order):
        return "cannot pay: order already shipped"
    
    def ship(self, order):
        return "cannot ship: order already shipped"
    
    def cancel(self, order):
        return "cannot cancel: order already shipped"

class CancelledState(OrderState):
    def pay(self, order):
        return "cannot pay: order cancelled"
    
    def ship(self, order):
        return "cannot ship: order cancelled"
    
    def cancel(self, order):
        return "cannot cancel: order already cancelled"

STATE_MAP = {
    "pending": PendingState(),
    "paid": PaidState(),
    "shipped": ShippedState(),
    "cancelled": CancelledState(),
    "refunded": CancelledState(),
}

# repository/order_repo.py - 仓储模式
from abc import ABC, abstractmethod
from typing import Optional, List
from domain.order import Order

class OrderRepository(ABC):
    @abstractmethod
    def save(self, order: Order) -> None: ...
    
    @abstractmethod
    def get_by_id(self, order_id: int) -> Optional[Order]: ...
    
    @abstractmethod
    def get_by_user(self, user_id: int) -> List[Order]: ...

class InMemoryOrderRepository(OrderRepository):
    def __init__(self):
        self._orders = {}
        self._counter = 0
    
    def save(self, order: Order):
        if order.id == 0:
            self._counter += 1
            order.id = self._counter
        self._orders[order.id] = order
    
    def get_by_id(self, order_id: int) -> Optional[Order]:
        return self._orders.get(order_id)
    
    def get_by_user(self, user_id: int) -> List[Order]:
        return [o for o in self._orders.values() if o.user_id == user_id]

# event/event_bus.py - 事件系统
from typing import Dict, List, Callable
import asyncio

class EventBus:
    def __init__(self):
        self._subscribers: Dict[str, List[Callable]] = {}
    
    def subscribe(self, event_type: str, handler: Callable):
        if event_type not in self._subscribers:
            self._subscribers[event_type] = []
        self._subscribers[event_type].append(handler)
    
    async def publish(self, event_type: str, data: dict):
        handlers = self._subscribers.get(event_type, [])
        tasks = [handler(data) for handler in handlers]
        await asyncio.gather(*tasks)

# event/handlers.py - 事件处理器
async def handle_order_created(event_data):
    print(f"[Notification] Order {event_data['order_id']} created, sending email to {event_data['user_email']}")

async def handle_order_paid(event_data):
    print(f"[Inventory] Order {event_data['order_id']} paid, updating inventory")

async def handle_order_shipped(event_data):
    print(f"[Analytics] Order {event_data['order_id']} shipped, recording analytics")

# service/order_service.py - 业务服务
class OrderService:
    def __init__(self, order_repo, event_bus):
        self.order_repo = order_repo
        self.event_bus = event_bus
    
    def create_order(self, user_id: int, items: List[dict]) -> Order:
        order_items = [OrderItem(**item) for item in items]
        order = Order(user_id=user_id, items=order_items)
        order.validate()
        self.order_repo.save(order)
        
        asyncio.run(self.event_bus.publish(
            "order_created",
            {"order_id": order.id, "user_id": user_id, "user_email": "user@example.com"}
        ))
        
        return order
    
    def pay_order(self, order_id: int) -> str:
        order = self.order_repo.get_by_id(order_id)
        if not order:
            return "order not found"
        
        state = STATE_MAP.get(order.status)
        result = state.pay(order)
        self.order_repo.save(order)
        
        if order.status == "paid":
            asyncio.run(self.event_bus.publish(
                "order_paid",
                {"order_id": order_id}
            ))
        
        return result
    
    def ship_order(self, order_id: int) -> str:
        order = self.order_repo.get_by_id(order_id)
        if not order:
            return "order not found"
        
        state = STATE_MAP.get(order.status)
        result = state.ship(order)
        self.order_repo.save(order)
        
        if order.status == "shipped":
            asyncio.run(self.event_bus.publish(
                "order_shipped",
                {"order_id": order_id}
            ))
        
        return result

# main.py - 入口
def main():
    # 初始化依赖
    order_repo = InMemoryOrderRepository()
    event_bus = EventBus()
    
    # 注册事件处理器
    event_bus.subscribe("order_created", handle_order_created)
    event_bus.subscribe("order_paid", handle_order_paid)
    event_bus.subscribe("order_shipped", handle_order_shipped)
    
    # 创建服务
    order_service = OrderService(order_repo, event_bus)
    
    # 使用示例
    order = order_service.create_order(
        user_id=1,
        items=[
            {"product_id": 101, "quantity": 2, "price": 99.99},
            {"product_id": 102, "quantity": 1, "price": 199.99}
        ]
    )
    print(f"Created order: {order.id}, total: {order.total_amount:.2f}")
    
    result = order_service.pay_order(order.id)
    print(f"Pay result: {result}, status: {order.status}")
    
    result = order_service.ship_order(order.id)
    print(f"Ship result: {result}, status: {order.status}")

if __name__ == "__main__":
    main()
```

### 9.4 使用示例

```bash
python main.py

# 输出：
# [Notification] Order 1 created, sending email to user@example.com
# Created order: 1, total: 399.97
# [Inventory] Order 1 paid, updating inventory
# Pay result: order paid successfully, status: paid
# [Analytics] Order 1 shipped, recording analytics
# Ship result: order shipped, status: shipped
```

### 9.5 项目扩展

1. **持久化层**：集成 SQLAlchemy 或 Django ORM
2. **API 层**：使用 FastAPI 提供 RESTful API
3. **缓存层**：使用 Redis 缓存热门商品
4. **消息队列**：使用 RabbitMQ 替代简单的事件总线
5. **事务管理**：实现 Unit of Work 模式
6. **权限控制**：添加认证和授权中间件

---

## 附录：第十二阶段自检清单

- [ ] 理解并应用 SOLID 五大设计原则
- [ ] 使用工厂模式解耦对象创建
- [ ] 使用建造者模式构建复杂对象
- [ ] 使用适配器模式兼容不同接口
- [ ] 使用装饰器模式动态扩展功能
- [ ] 使用观察者模式实现事件驱动
- [ ] 使用模板方法模式定义算法骨架
- [ ] 使用依赖注入提高代码可测试性
- [ ] 使用仓储模式抽象数据访问层
- [ ] 理解分层架构和各层职责
- [ ] 能判断何时应该/不应该使用某种设计模式
- [ ] 使用状态模式管理对象生命周期
- [ ] 使用事件驱动架构解耦系统组件
- [ ] 识别并避免常见架构反模式

---

> **工程师寄语**：设计模式是工具，不是教条。最好的代码是"没有模式的代码"——因为它足够简单，不需要模式。当你发现自己在生硬套用模式时，停下来想一想：是不是问题被过度复杂化了？架构的本质是**管理复杂度**，而不是增加复杂度。

> **学习建议**：
> 1. 从理解问题开始，而不是从模式开始
> 2. 先写简单代码，遇到问题再考虑模式
> 3. 在实际项目中尝试应用至少一种模式
> 4. 定期回顾代码，思考是否有过度设计的地方
> 5. 阅读优秀项目的源码，学习别人如何运用模式
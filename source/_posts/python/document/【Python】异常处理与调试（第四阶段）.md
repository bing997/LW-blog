---
title: 【Python】异常处理与调试（第四阶段）
date: 2026-07-22 14:00:00
categories:
  - Python
tags:
  - Python
  - 教程
  - 异常处理
  - 调试
description: 系统掌握 Python 异常处理机制、日志系统、调试技巧和生产环境最佳实践，建立防御性编程思维。
cover: /images/cover.png
---

# 四、异常处理与调试

> **阶段定位**：异常处理是程序健壮性的基石，调试能力是开发效率的倍增器。本阶段从异常机制原理出发，延伸到生产级的日志系统和调试方法论，帮你建立"防御性编程"的思维习惯。

```
┌─────────────────────────────────────────────────────────────────┐
│                    异常处理与调试知识图谱                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. 异常体系 ──→ BaseException / Exception / 常见异常分类          │
│       │                                                         │
│  2. 处理机制 ──→ try/except/else/finally / raise / 异常链         │
│       │                                                         │
│  3. 自定义异常 ─→ 异常层级设计 / 异常信息规范                       │
│       │                                                         │
│  4. 断言 ──────→ assert vs raise / 开发期 vs 生产期                │
│       │                                                         │
│  5. 日志系统 ──→ logging / 日志级别 / 结构化日志 / 轮转策略         │
│       │                                                         │
│  6. 调试技巧 ──→ pdb / breakpoint() / 事后调试 / IDE 调试         │
│       │                                                         │
│  7. 警告控制 ──→ warnings / 废弃 API 标记 / 警告过滤器             │
│       │                                                         │
│  8. 生产模式 ──→ 全局捕获 / 重试 / 断路器 / 优雅降级               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 1. 异常体系

### 1.1 异常层级结构

Python 所有异常都继承自 `BaseException`，理解层级是正确捕获异常的前提：

```
BaseException
 ├── SystemExit              # sys.exit() 触发（不应捕获）
 ├── KeyboardInterrupt       # Ctrl+C 触发（不应捕获）
 ├── GeneratorExit           # 生成器关闭时触发（不应捕获）
 └── Exception               # 所有常规异常的基类（重点捕获）
      ├── ArithmeticError
      │    ├── ZeroDivisionError
      │    └── OverflowError
      ├── AssertionError     # assert 失败
      ├── AttributeError     # 属性不存在
      ├── ImportError / ModuleNotFoundError
      ├── LookupError
      │    ├── IndexError    # 序列索引越界
      │    └── KeyError      # 字典键不存在
      ├── NameError          # 变量未定义
      ├── OSError
      │    ├── FileNotFoundError
      │    ├── PermissionError
      │    └── ConnectionError
      ├── RuntimeError       # 通用运行时错误
      ├── TypeError          # 类型错误
      ├── ValueError         # 值错误（类型正确但值不合法）
      ├── StopIteration      # 迭代器耗尽（for 循环自动处理）
      └── ... 自定义异常
```

**关键设计原则**：

```python
# 错误：捕获 BaseException 会拦截 SystemExit 和 KeyboardInterrupt
try:
    do_something()
except BaseException:   # 不要这样做！
    pass

# 正确：捕获 Exception
try:
    do_something()
except Exception as e:
    logger.error(f"操作失败: {e}")

# 正确：区分不同类型的异常
try:
    result = 10 / int(user_input)
except ValueError:
    print("请输入有效的整数")
except ZeroDivisionError:
    print("不能除以零")
except Exception as e:
    print(f"未知错误: {e}")
```

**异常捕获优先级规则**：

```
try:
    1 / 0
except ArithmeticError:    # 优先检查（更具体）
    print("算术错误")
except Exception:          # 不会触发（因为 ArithmeticError 先匹配）
    print("通用错误")

# 输出: 算术错误

# 规则：从上到下匹配，一旦匹配成功就不再继续检查
```

> **面试真题**：为什么不要捕获 `BaseException`？
> ```python
> try:
>     sys.exit(0)
> except BaseException:
>     print("退出被拦截！")  # 错误：用户无法正常退出程序
>
> try:
>     import time
>     time.sleep(10)
> except BaseException:
>     print("Ctrl+C 被拦截！")  # 错误：用户无法中断程序
> ```
> **答案**：`BaseException` 包含 `SystemExit` 和 `KeyboardInterrupt`，这两种异常是程序的合法退出机制，不应被捕获。应捕获 `Exception`，它不包含这三个特殊异常。

### 1.2 常见异常速查

| 异常 | 触发场景 | 示例 |
|------|----------|------|
| `TypeError` | 对不支持的类型执行操作 | `"a" + 1` |
| `ValueError` | 类型正确但值不合法 | `int("abc")` |
| `IndexError` | 列表索引越界 | `[1, 2][5]` |
| `KeyError` | 字典键不存在 | `{"a": 1}["b"]` |
| `AttributeError` | 对象没有该属性 | `[].push()` |
| `NameError` | 变量未定义 | `print(undefined_var)` |
| `FileNotFoundError` | 文件不存在 | `open("missing.txt")` |
| `ImportError` | 模块导入失败 | `import nonexistent` |
| `ZeroDivisionError` | 除以零 | `1 / 0` |
| `StopIteration` | 迭代器耗尽 | 手动 `next()` 调用 |

> **易错点**：区分 `TypeError` 和 `ValueError`：
> ```python
> "a" + 1       # TypeError —— 类型不兼容
> int("abc")    # ValueError —— 类型正确（str），但值无法转换
> ```

---

## 2. 异常处理机制

### 2.1 基本结构：`try / except / else / finally`

```python
def read_config(filepath):
    """读取配置文件，展示完整的异常处理结构。"""
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            config = f.read()
    except FileNotFoundError:
        print(f"配置文件不存在: {filepath}")
        config = ""       # 使用默认值
    except PermissionError:
        print(f"无权限读取文件: {filepath}")
        raise             # 重新抛出，让调用方处理
    except OSError as e:
        print(f"读取文件时出错: {e}")
        raise
    else:
        # else 子句：仅在 try 块没有异常时执行
        print("配置文件读取成功")
        config = config.strip()
    finally:
        # finally 子句：无论是否发生异常，始终执行
        # 常用于释放资源（文件、数据库连接、锁等）
        print("读取操作完成")

    return config
```

**各子句的执行流程图**：

```
try:
    do_something()
    ↓
    ├── 无异常 ──→ else:（可选）──→ finally:（始终）──→ 继续执行
    │
    └── 有异常 ──→ except:（匹配则执行，不匹配则向上抛出）
                       │
                       └──→ finally:（始终）──→ 继续执行（如果异常被处理）
```

| 子句 | 执行条件 | 典型用途 |
|------|----------|----------|
| `try` | 始终执行 | 执行可能出错的代码 |
| `except` | 仅当 try 中发生匹配的异常 | 处理异常、降级、记录日志 |
| `else` | 仅当 try 中无异常 | 正常流程的后续处理 |
| `finally` | 无论是否有异常，始终执行 | 资源释放、清理操作 |

> **易错点**：`else` 和 `finally` 的区别：
> ```python
> try:
>     print("try")
>     raise ValueError("test")
> except:
>     print("except")
> else:
>     print("else")    # 不会执行（因为有异常）
> finally:
>     print("finally") # 会执行（始终执行）
> ```

### 2.2 捕获多个异常

```python
# 方式一：一个 except 捕获多个异常（用元组）
try:
    value = config["key"]
except (KeyError, TypeError):
    value = "default"

# 方式二：多个 except 分别处理（推荐，更精确）
try:
    result = api.fetch_data()
except ConnectionError:
    # 网络问题，重试
    retry()
except TimeoutError:
    # 超时，降级处理
    fallback()
except Exception as e:
    # 未知异常，记录并上报
    logger.exception("API 调用失败")
    raise

# 方式三：捕获所有异常（不推荐，除非最外层）
try:
    risky_operation()
except Exception as e:
    logger.error(f"操作失败: {e}")
    # 注意：不要直接 pass，至少记录日志
```

### 2.3 异常链：`raise ... from`

**异常链的作用**：保留原始异常信息，便于追溯根因。

```
原始异常（根因）
    ↓
新异常（业务描述）
    ↓
最终抛出（保留完整链）
```

```python
class ConfigError(Exception):
    """配置相关异常。"""
    pass

def load_config(filepath):
    try:
        with open(filepath) as f:
            return json.load(f)
    except FileNotFoundError as e:
        # raise ... from：保留原始异常链，方便追溯根因
        raise ConfigError(f"配置文件 {filepath} 不存在") from e
    except json.JSONDecodeError as e:
        raise ConfigError(f"配置文件 {filepath} 格式错误") from e

# 调用
try:
    config = load_config("config.json")
except ConfigError as e:
    print(f"配置加载失败: {e}")
    print(f"根因: {e.__cause__}")    # 原始异常
    print(f"完整链:")
    import traceback
    traceback.print_exception(type(e), e, e.__traceback__)
```

**`raise ... from` 的三种用法**：

```python
# 1. raise NewError(...) from original_error
#    明确表示新异常是由原始异常导致的
try:
    open("missing.txt")
except FileNotFoundError as e:
    raise ConfigError("文件不存在") from e

# 2. raise NewError(...) from None
#    抑制原始异常，不显示异常链（保密场景）
try:
    validate_password(data)
except ValueError as e:
    # 不泄露原始错误详情
    raise AuthenticationError("认证失败") from None

# 3. raise（不带参数）
#    在 except 块中重新抛出当前异常，保留完整 traceback
try:
    risky_operation()
except Exception:
    logger.error("操作失败")
    raise   # 重新抛出，不改变异常信息
```

> **面试真题**：`raise` 和 `raise e` 有什么区别？
> ```python
> try:
>     1 / 0
> except ZeroDivisionError as e:
>     raise        # 保留原始 traceback（推荐）
>     # raise e    # 重新创建 traceback（不推荐，丢失原始位置）
> ```

### 2.4 获取异常详情

```python
import traceback
import sys

try:
    1 / 0
except Exception as e:
    # 异常类型
    print(f"类型: {type(e).__name__}")     # ZeroDivisionError

    # 异常信息
    print(f"信息: {e}")                     # division by zero

    # 异常参数
    print(f"参数: {e.args}")                # ('division by zero',)

    # 获取 traceback 信息（详细）
    exc_type, exc_value, exc_tb = sys.exc_info()
    extracted = traceback.extract_tb(exc_tb)
    for frame in extracted:
        print(f"文件: {frame.filename}, 行: {frame.lineno}, 函数: {frame.name}")
        print(f"  代码: {frame.line}")

    # 最简单的方式：打印完整 traceback
    traceback.print_exc()

    # 也可以写入文件
    traceback.print_exc(file=open("error.log", "w", encoding="utf-8"))
```

---

## 3. 自定义异常

### 3.1 定义异常类

```python
class AppError(Exception):
    """应用根异常：所有自定义异常的基类。"""
    def __init__(self, message, code=None, details=None):
        super().__init__(message)
        self.message = message
        self.code = code
        self.details = details or {}

class ValidationError(AppError):
    """数据验证异常。"""
    def __init__(self, message, field=None, **kwargs):
        super().__init__(message, code="VALIDATION_ERROR", **kwargs)
        self.field = field

class AuthenticationError(AppError):
    """认证失败异常。"""
    def __init__(self, message="认证失败", **kwargs):
        super().__init__(message, code="AUTH_ERROR", **kwargs)

class NotFoundError(AppError):
    """资源未找到异常。"""
    def __init__(self, resource, identifier, **kwargs):
        message = f"{resource} 未找到: {identifier}"
        super().__init__(message, code="NOT_FOUND", **kwargs)
        self.resource = resource
        self.identifier = identifier

# 使用
def get_user(user_id):
    if user_id <= 0:
        raise ValidationError("用户 ID 无效", field="user_id", details={"value": user_id})
    user = db.find_user(user_id)
    if not user:
        raise NotFoundError("用户", user_id)
    return user

# 捕获（按层级）
try:
    user = get_user(-1)
except ValidationError as e:
    print(f"参数错误: {e.message}, 字段: {e.field}")
except NotFoundError as e:
    print(f"资源不存在: {e.message}")
except AppError as e:
    print(f"应用错误 [{e.code}]: {e.message}")
```

**异常层级设计原则**：

```
┌───────────────────────────────────────────────────┐
│                  异常层级设计                      │
├───────────────────────────────────────────────────┤
│                                                   │
│  AppError（根异常）                                │
│    │                                              │
│    ├── DataError                                  │
│    │    ├── DatabaseError                         │
│    │    │    ├── ConnectionError                  │
│    │    │    └── QueryError                       │
│    │    └── CacheError                            │
│    │                                              │
│    ├── BusinessError                              │
│    │    ├── ValidationError                       │
│    │    ├── AuthenticationError                   │
│    │    └── NotFoundError                         │
│    │                                              │
│    └── ExternalError                              │
│         ├── APIError                              │
│         └── PaymentError                          │
│                                                   │
│  优点：                                           │
│  1. 调用方可以按粒度捕获（如捕获所有 DataError）      │
│  2. 异常信息可以携带结构化数据（code、details）      │
│  3. 易于扩展和维护                                 │
│                                                   │
└───────────────────────────────────────────────────┘
```

### 3.2 异常设计原则

```python
# 1. 建立异常层级，让调用者可以按粒度捕获
class DataError(AppError):
    pass

class DatabaseError(DataError):
    pass

class CacheError(DataError):
    pass

# 2. 异常信息应包含足够上下文，便于排查
# 不好的异常
raise ValueError("无效")

# 好的异常
raise ValueError(f"用户 {user_id} 的邮箱 {email} 格式无效")

# 3. 不要让异常信息泄露敏感数据（如密码、token）
# 不好
raise AuthenticationError(f"密码 {password} 错误")

# 好
raise AuthenticationError("用户名或密码错误")

# 4. 异常信息用英文还是中文？
#    - 内部系统：中文（团队沟通方便）
#    - 对外 API：英文（国际化）
#    - 最好两种都支持（i18n）
```

> **工程建议**：自定义异常应继承 `Exception`（而非 `BaseException`），并在根异常中统一处理日志和错误码。

---

## 4. 断言（assert）

### 4.1 基本用法

```python
def divide(a, b):
    """安全的除法：断言检查前置条件。"""
    assert b != 0, "除数不能为零"
    assert isinstance(a, (int, float)), f"a 必须是数字，实际是 {type(a)}"
    return a / b

# 开发阶段：断言帮助发现 bug
divide(10, 2)    # 正常
divide(10, 0)    # AssertionError: 除数不能为零

# 生产环境：使用 -O 参数禁用断言
# python -O script.py  → 所有 assert 语句被忽略
```

**断言的执行流程**：

```
assert condition, message

等价于（在非优化模式下）：
if __debug__:
    if not condition:
        raise AssertionError(message)

__debug__ 在 -O 模式下为 False，断言被完全跳过
```

### 4.2 assert vs 异常

| 特性 | `assert` | `raise` |
|------|----------|---------|
| 用途 | 开发期检查"不该发生"的逻辑错误 | 处理可预期的运行时错误 |
| 可禁用 | 是（`-O` 参数） | 否 |
| 适用场景 | 内部一致性检查、前置条件 | 外部输入验证、业务逻辑错误 |
| 性能影响 | 非优化模式下有开销 | 始终有开销（但很小） |

```python
# 正确的分工：
def process_order(order):
    # 外部输入 → 用异常（必须处理）
    if not order.items:
        raise ValueError("订单不能为空")

    # 内部逻辑 → 用断言（除非有 bug，否则不会触发）
    total = sum(item.price for item in order.items)
    assert total >= 0, f"订单总额不应为负数: {total}"   # 除非有 bug，否则不会触发

    return total
```

> **工程建议**：永远不要在生产代码中依赖 `assert` 做业务逻辑检查，因为用户可能用 `-O` 参数运行。断言只用于开发期的自我检查。

> **面试真题**：以下代码在 `python -O` 模式下运行会怎样？
> ```python
> def login(username, password):
>     assert username, "用户名不能为空"
>     assert password, "密码不能为空"
>     # ...
> ```
> **答案**：两个断言都被跳过，即使传入空字符串也会继续执行后续逻辑，可能导致更严重的错误。这就是为什么外部输入验证要用 `raise`。

---

## 5. 日志系统

### 5.1 `logging` 模块基础

```python
import logging
import sys

# 最简单的配置
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
    handlers=[
        logging.StreamHandler(sys.stdout),           # 输出到控制台
        logging.FileHandler("app.log", encoding="utf-8"),  # 输出到文件
    ],
)

# 日志级别（从低到高）
logger = logging.getLogger(__name__)

logger.debug("调试信息：变量值 x=%d", 42)        # 开发调试
logger.info("用户登录成功：user_id=%s", "123")   # 关键流程
logger.warning("磁盘空间不足，剩余: %d%%", 10)    # 潜在问题
logger.error("数据库连接失败: %s", "timeout")     # 错误但程序可继续
logger.critical("系统无法启动，端口被占用")        # 严重错误，程序可能终止
```

**日志模块架构**：

```
┌─────────────────────────────────────────────────────────┐
│                    logging 模块架构                      │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Logger（记录器）                                        │
│    │  logger.debug() / logger.info() / ...              │
│    ↓                                                    │
│  Filter（过滤器）                                        │
│    │  决定哪些日志记录可以通过                            │
│    ↓                                                    │
│  Handler（处理器）                                       │
│    │  StreamHandler（控制台）/ FileHandler（文件）/ ...   │
│    ↓                                                    │
│  Formatter（格式化器）                                    │
│    │  将日志记录格式化为字符串                             │
│    ↓                                                    │
│  输出                                                    │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 5.2 日志级别选择策略

| 级别 | 含义 | 生产环境 | 开发环境 | 使用场景 |
|------|------|----------|----------|----------|
| `DEBUG` | 详细诊断信息 | 关闭 | 开启 | 变量值、函数参数、中间结果 |
| `INFO` | 关键业务流程 | 开启 | 开启 | 用户操作、服务启动、定时任务执行 |
| `WARNING` | 潜在问题 | 开启 | 开启 | 配置缺失、磁盘空间不足、重试 |
| `ERROR` | 错误但可恢复 | 开启 | 开启 | 数据库连接失败、API 调用失败 |
| `CRITICAL` | 严重错误 | 开启 | 开启 | 系统崩溃、数据丢失、安全问题 |

### 5.3 高级日志配置

```python
import logging
import logging.config

LOGGING_CONFIG = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "standard": {
            "format": "%(asctime)s [%(levelname)s] %(name)s:%(lineno)d: %(message)s",
            "datefmt": "%Y-%m-%d %H:%M:%S",
        },
        "detailed": {
            "format": (
                '{"time": "%(asctime)s", "level": "%(levelname)s", '
                '"logger": "%(name)s", "line": %(lineno)d, '
                '"message": "%(message)s"}'
            ),
        },
    },
    "handlers": {
        "console": {
            "class": "logging.StreamHandler",
            "level": "DEBUG",
            "formatter": "standard",
            "stream": "ext://sys.stdout",
        },
        "file": {
            "class": "logging.handlers.RotatingFileHandler",
            "level": "INFO",
            "formatter": "detailed",
            "filename": "app.log",
            "maxBytes": 10 * 1024 * 1024,  # 10MB
            "backupCount": 5,               # 保留 5 个备份
            "encoding": "utf-8",
        },
        "error_file": {
            "class": "logging.handlers.RotatingFileHandler",
            "level": "ERROR",
            "formatter": "detailed",
            "filename": "error.log",
            "maxBytes": 10 * 1024 * 1024,
            "backupCount": 5,
            "encoding": "utf-8",
        },
    },
    "loggers": {
        "": {  # 根 logger
            "handlers": ["console", "file", "error_file"],
            "level": "DEBUG",
        },
        "urllib3": {  # 第三方库日志控制
            "level": "WARNING",
        },
    },
}

logging.config.dictConfig(LOGGING_CONFIG)
logger = logging.getLogger(__name__)
```

**日志轮转策略**：

```
┌─────────────────────────────────────────────────────────┐
│                    日志轮转策略                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  RotatingFileHandler（按大小轮转）                        │
│    ├── maxBytes: 10MB                                   │
│    ├── backupCount: 5                                   │
│    └── 生成: app.log, app.log.1, app.log.2, ..., app.log.5│
│                                                         │
│  TimedRotatingFileHandler（按时间轮转）                    │
│    ├── when: "D"（每天）/ "H"（每小时）/ "W0"（每周一）    │
│    ├── interval: 1                                      │
│    └── 生成: app.log, app.log.2024-01-01, app.log.2024-01-02│
│                                                         │
│  组合策略：                                              │
│    1. 按大小轮转（防止单文件过大）                         │
│    2. 按时间轮转（便于按日期查找）                         │
│    3. 设置合理的保留数量（避免磁盘占满）                   │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 5.4 日志最佳实践

```python
import logging
import traceback
import time
from contextlib import contextmanager

logger = logging.getLogger(__name__)

# 1. 使用 logger.exception() 记录完整 traceback
try:
    1 / 0
except Exception:
    logger.exception("计算出错")   # 自动包含 traceback

# 等价于
try:
    1 / 0
except Exception as e:
    logger.error("计算出错", exc_info=True)
    # 或
    logger.error(f"计算出错: {e}", exc_info=True)

# 2. 结构化日志（便于 ELK 等日志系统解析）
logger.info("订单创建", extra={
    "order_id": "ORD-12345",
    "user_id": "U-678",
    "amount": 99.99,
    "status": "created",
})

# 3. 敏感信息脱敏
def log_safe_user(user):
    logger.info(f"用户操作: id={user.id}, email={mask_email(user.email)}")

def mask_email(email):
    if "@" not in email:
        return "***"
    name, domain = email.split("@")
    return f"{name[:2]}***@{domain}"

# 4. 使用上下文管理器记录操作耗时
@contextmanager
def log_duration(operation):
    logger.info(f"开始: {operation}")
    start = time.perf_counter()
    try:
        yield
    finally:
        elapsed = time.perf_counter() - start
        logger.info(f"完成: {operation}, 耗时: {elapsed:.3f}s")

with log_duration("用户数据同步"):
    time.sleep(1.5)

# 5. 使用 % 格式化（logging 推荐）或 f-string
logger.info("用户 %s 登录成功", user_id)    # % 格式（推荐）
logger.info(f"用户 {user_id} 登录成功")      # f-string（也可用）

# 6. 模块级 logger（推荐做法）
# 在每个模块顶部：
# logger = logging.getLogger(__name__)
# __name__ 会自动变成模块路径，便于追踪来源
```

> **面试真题**：`logger.exception()` 和 `logger.error()` 的区别？
> ```python
> try:
>     1 / 0
> except Exception as e:
>     logger.error(f"出错了: {e}")      # 只有错误信息
>     logger.exception("出错了")       # 错误信息 + 完整 traceback
> ```
> **答案**：`logger.exception()` 等价于 `logger.error(..., exc_info=True)`，会自动附加完整的堆栈跟踪信息。只应在 `except` 块中使用。

---

## 6. 调试

### 6.1 `pdb` 交互式调试

```python
import pdb

def buggy_function(a, b):
    result = a + b
    pdb.set_trace()     # 在此处进入调试器（Python 3.7+ 可用 breakpoint()）
    result = result / 0  # 故意制造错误
    return result

# buggy_function(1, 2)
```

**pdb 常用命令**：

| 命令 | 缩写 | 说明 |
|------|------|------|
| `list` | `l` | 显示当前行附近的代码 |
| `next` | `n` | 执行下一行（不进入函数内部） |
| `step` | `s` | 执行下一行（进入函数内部） |
| `continue` | `c` | 继续执行直到下一个断点 |
| `return` | `r` | 执行直到当前函数返回 |
| `print(var)` | `p var` | 打印变量值 |
| `pp var` | - | 美化打印变量 |
| `where` | `w` | 显示调用栈 |
| `up` / `down` | `u` / `d` | 在调用栈中上下移动 |
| `break` | `b` | 设置断点 |
| `args` | `a` | 显示当前函数参数 |
| `quit` | `q` | 退出调试器 |

**pdb 调试流程**：

```
python -m pdb script.py

> /path/to/script.py(1)<module>()
-> def main():
(Pdb) l                    # 查看代码
(Pdb) b 10                 # 在第 10 行设置断点
(Pdb) c                    # 运行到断点
(Pdb) p variable           # 查看变量值
(Pdb) n                    # 执行下一行
(Pdb) s                    # 进入函数
(Pdb) w                    # 查看调用栈
(Pdb) q                    # 退出
```

### 6.2 `breakpoint()`（3.7+）

```python
# Python 3.7+ 推荐使用 breakpoint() 替代 pdb.set_trace()
# 环境变量 PYTHONBREAKPOINT=0 可以禁用所有 breakpoint()

def calculate(x, y):
    temp = x * 2
    breakpoint()    # 进入调试器，支持 Tab 补全
    return temp + y

# 设置其他调试器：PYTHONBREAKPOINT=ipdb.set_trace
# ipdb 是增强版 pdb，支持语法高亮和更好的补全
```

**breakpoint() 的配置方式**：

```python
# 1. 环境变量
# export PYTHONBREAKPOINT=0                  # 禁用所有断点
# export PYTHONBREAKPOINT=ipdb.set_trace     # 使用 ipdb

# 2. 代码中临时配置
import sys
sys.breakpointhook = lambda: None  # 临时禁用

# 3. 上下文管理器（3.11+）
from contextlib import suppress

with suppress(KeyboardInterrupt):
    calculate(3, 4)
```

### 6.3 事后调试（Post-mortem Debugging）

```python
import pdb
import sys
import traceback

def main():
    try:
        do_something_risky()
    except Exception:
        # 捕获异常后自动进入调试器
        traceback.print_exc()
        pdb.post_mortem(sys.exc_info()[2])

# 或者使用异常钩子，全局生效
def debug_excepthook(type, value, tb):
    traceback.print_exception(type, value, tb)
    pdb.post_mortem(tb)

sys.excepthook = debug_excepthook
```

**事后调试的场景**：

```
┌─────────────────────────────────────────────────────────┐
│                    事后调试场景                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  场景 1：异常已经发生，想查看当时的变量状态                 │
│    → pdb.post_mortem(tb)                               │
│                                                         │
│  场景 2：生产环境崩溃后，想分析 core dump                 │
│    → 使用 faulthandler 模块生成 traceback                │
│                                                         │
│  场景 3：测试失败后，自动进入调试器                       │
│    → pytest --pdb 或 unittest 的调试模式                 │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 6.4 IDE 调试技巧

**PyCharm / VS Code 断点调试核心操作**：

1. **条件断点**：右键断点 → 添加条件（如 `user_id == 123`），只在满足条件时暂停
2. **日志断点**：断点不暂停，但记录表达式值到控制台
3. **异常断点**：在特定异常抛出时自动暂停（PyCharm: Run → View Breakpoints → Python Exception Breakpoint）
4. **表达式求值**：暂停时在 Watch 窗口添加表达式，实时查看值变化
5. **Step Into / Step Over / Step Out**：精细控制执行流程

**VS Code 调试配置（launch.json）**：

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: 当前文件",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal",
            "justMyCode": false,
            "env": {
                "PYTHONPATH": "${workspaceFolder}"
            }
        }
    ]
}
```

### 6.5 实用调试技巧

```python
# 1. 使用 icecream 替代 print 调试
# pip install icecream
from icecream import ic

def process(data):
    data = [x.strip() for x in data]
    ic(data)                        # ic| data: ['a', 'b', 'c']
    result = sum(len(x) for x in data)
    ic(result)                      # ic| result: 3
    return result

# 2. 使用 rich 库美化终端输出
# pip install rich
from rich import print as rprint
from rich.console import Console
from rich.traceback import install

install()   # 美化异常 traceback
console = Console()
console.log("Hello, [bold red]World![/bold red]")

# 3. 使用 locals() 和 dir() 检查当前作用域
def mystery(a, b):
    breakpoint()
    # 在 pdb 中:
    # p locals()   → 查看所有局部变量
    # p dir(a)     → 查看对象 a 的所有属性和方法

# 4. 使用 sys._getframe() 查看调用栈
import sys

def who_called_me():
    frame = sys._getframe(1)    # 获取调用者的帧
    print(f"被 {frame.f_code.co_name} 调用，在 {frame.f_code.co_filename}:{frame.f_lineno}")

def caller():
    who_called_me()   # 被 caller 调用，在 xxx.py:行号

# 5. 使用 inspect 模块获取详细信息
import inspect

def debug_info():
    frame = inspect.currentframe()
    print(f"文件: {frame.f_code.co_filename}")
    print(f"函数: {frame.f_code.co_name}")
    print(f"行号: {frame.f_lineno}")
    print(f"局部变量: {frame.f_locals}")
```

---

## 7. 警告控制：`warnings` 模块

### 7.1 基本用法

```python
import warnings

def deprecated_function():
    warnings.warn("deprecated_function 已废弃，请使用 new_function", DeprecationWarning)
    return "旧功能"

def risky_operation():
    warnings.warn("此操作可能导致数据丢失", UserWarning)
    return "完成"

# 控制警告行为
# warnings.filterwarnings("ignore")              # 忽略所有警告
# warnings.filterwarnings("error")               # 将警告转为异常
# warnings.filterwarnings("ignore", category=DeprecationWarning)
# warnings.filterwarnings("once", message=".*数据丢失.*")

# 运行时的控制方式
# python -W ignore script.py                     # 忽略所有警告
# python -W error script.py                      # 所有警告转为异常
# python -W "ignore::DeprecationWarning" script.py

# 使用上下文管理器临时控制
with warnings.catch_warnings():
    warnings.simplefilter("ignore")
    deprecated_function()   # 警告被抑制
```

### 7.2 废弃 API 标记

```python
import warnings
import functools

def deprecated(reason="", removed_in=None):
    """装饰器：标记函数为废弃。"""
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            msg = f"{func.__name__} 已废弃"
            if reason:
                msg += f": {reason}"
            if removed_in:
                msg += f"（将在 {removed_in} 中移除）"
            warnings.warn(msg, DeprecationWarning, stacklevel=2)
            return func(*args, **kwargs)
        return wrapper
    return decorator

@deprecated(reason="请使用 new_api()", removed_in="v3.0")
def old_api():
    return "旧 API"

# 使用
result = old_api()
# DeprecationWarning: old_api 已废弃: 请使用 new_api()（将在 v3.0 中移除）
```

**警告类别**：

| 类别 | 用途 |
|------|------|
| `UserWarning` | 用户代码产生的警告 |
| `DeprecationWarning` | 废弃警告（开发者可见） |
| `FutureWarning` | 将来可能改变行为的警告 |
| `SyntaxWarning` | 语法相关警告 |
| `RuntimeWarning` | 运行时相关警告 |
| `PendingDeprecationWarning` | 即将废弃的警告 |

---

## 8. 生产环境异常处理模式

### 8.1 全局异常捕获

```python
import sys
import logging
import traceback

logger = logging.getLogger(__name__)

def global_exception_handler(exc_type, exc_value, exc_tb):
    """全局未捕获异常处理：记录并优雅退出。"""
    if issubclass(exc_type, KeyboardInterrupt):
        # 让用户正常中断
        sys.__excepthook__(exc_type, exc_value, exc_tb)
        return

    logger.critical(
        "未捕获的异常",
        exc_info=(exc_type, exc_value, exc_tb)
    )
    # 可选：发送告警通知
    # alert(f"未捕获异常: {exc_type.__name__}: {exc_value}")

sys.excepthook = global_exception_handler
```

**Web 框架的全局异常处理**（以 Flask 为例）：

```python
from flask import Flask, jsonify

app = Flask(__name__)

@app.errorhandler(Exception)
def handle_exception(e):
    """处理所有未捕获的异常。"""
    logger.exception("请求处理失败")
    return jsonify({
        "error": "服务器内部错误",
        "code": 500
    }), 500

@app.errorhandler(404)
def handle_not_found(e):
    return jsonify({
        "error": "资源未找到",
        "code": 404
    }), 404
```

### 8.2 重试模式

```python
import time
import functools
import random

def retry(max_attempts=3, delay=1, backoff=2, exceptions=(Exception,)):
    """重试装饰器：指数退避 + 随机抖动。"""
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            last_exception = None
            for attempt in range(1, max_attempts + 1):
                try:
                    return func(*args, **kwargs)
                except exceptions as e:
                    last_exception = e
                    if attempt == max_attempts:
                        break
                    sleep_time = delay * (backoff ** (attempt - 1))
                    sleep_time += random.uniform(0, sleep_time * 0.1)  # 随机抖动
                    print(f"重试 {attempt}/{max_attempts}，等待 {sleep_time:.1f}s: {e}")
                    time.sleep(sleep_time)
            raise last_exception
        return wrapper
    return decorator

@retry(max_attempts=3, delay=0.5, exceptions=(ConnectionError, TimeoutError))
def fetch_data(url):
    import random
    if random.random() < 0.7:
        raise ConnectionError("连接失败")
    return "数据"
```

**重试策略对比**：

```
┌─────────────────────────────────────────────────────────┐
│                    重试策略对比                          │
├──────────────┬──────────────┬──────────────────────────┤
│ 策略          │ 等待时间      │ 适用场景                  │
├──────────────┼──────────────┼──────────────────────────┤
│ 固定间隔      │ 1s, 1s, 1s   │ 简单场景                  │
│ 线性增长      │ 1s, 2s, 3s   │ 轻度拥塞                  │
│ 指数退避      │ 1s, 2s, 4s   │ 高并发场景（推荐）         │
│ 随机抖动      │ 0.9-1.1s     │ 避免请求风暴               │
│ 组合策略      │ 指数+抖动     │ 生产环境最佳实践           │
└──────────────┴──────────────┴──────────────────────────┘
```

### 8.3 断路器模式

```python
import time
from collections import deque

class CircuitBreaker:
    """断路器：防止反复重试已确认失败的服务。"""
    OPEN = "open"          # 断路：直接拒绝请求
    HALF_OPEN = "half_open"  # 半开：允许少量请求探测
    CLOSED = "closed"      # 闭合：正常执行

    def __init__(self, failure_threshold=5, recovery_timeout=60, half_open_limit=3):
        self.failure_threshold = failure_threshold
        self.recovery_timeout = recovery_timeout
        self.half_open_limit = half_open_limit
        self.state = self.CLOSED
        self.failure_count = 0
        self.last_failure_time = 0
        self.half_open_requests = 0

    def __enter__(self):
        if self.state == self.OPEN:
            if time.time() - self.last_failure_time > self.recovery_timeout:
                self.state = self.HALF_OPEN
                self.half_open_requests = 0
            else:
                raise RuntimeError("断路器已打开，服务不可用")

        if self.state == self.HALF_OPEN:
            if self.half_open_requests >= self.half_open_limit:
                raise RuntimeError("半开状态请求已达上限")
            self.half_open_requests += 1

        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if exc_type is None:
            # 成功：恢复
            self.state = self.CLOSED
            self.failure_count = 0
        elif exc_type is not None:
            # 失败：记录
            self.failure_count += 1
            self.last_failure_time = time.time()
            if self.failure_count >= self.failure_threshold:
                self.state = self.OPEN
        return False  # 不抑制异常
```

**断路器状态转换**：

```
┌─────────────────────────────────────────────────────────┐
│                    断路器状态机                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│     失败次数 >= 阈值         成功请求                      │
│    ┌─────────────────┐    ┌─────────────────┐           │
│    │                 │    │                 │           │
│    ▼                 │    ▼                 │           │
│ ┌───────┐        ┌──────────────┐       ┌─────────┐    │
│ │CLOSED │───────→│    OPEN      │───────→│HALF_OPEN│    │
│ │ 闭合   │        │    断路       │       │  半开    │    │
│ │正常执行│←───────│ 直接拒绝请求  │←───────│ 少量探测 │    │
│ └───────┘        └──────────────┘       └─────────┘    │
│     ↑                 │                     │           │
│     │                 │                     │           │
│     │           超时时间到达           失败请求          │
│     │                 │                     │           │
│     └─────────────────┴─────────────────────┘           │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 8.4 优雅降级

```python
class UserService:
    def __init__(self, db, cache):
        self.db = db
        self.cache = cache

    def get_user(self, user_id):
        """获取用户信息，多层降级。"""
        # 第一级：尝试缓存
        try:
            user = self.cache.get(f"user:{user_id}")
            if user:
                return user
        except Exception:
            logger.warning("缓存不可用，回退到数据库")

        # 第二级：尝试数据库
        try:
            user = self.db.find_user(user_id)
            if user:
                # 尝试回写缓存（失败不影响返回）
                try:
                    self.cache.set(f"user:{user_id}", user, ttl=300)
                except Exception:
                    pass
                return user
        except Exception as e:
            logger.error(f"数据库查询失败: {e}")

        # 第三级：返回默认值
        logger.warning(f"无法获取用户 {user_id}，返回默认值")
        return {"id": user_id, "name": "未知用户", "status": "unknown"}
```

**优雅降级的设计原则**：

```
┌─────────────────────────────────────────────────────────┐
│                    优雅降级策略                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  1. 多级缓存：                                          │
│     内存缓存 → Redis → 数据库 → 默认值                   │
│                                                         │
│  2. 服务降级：                                          │
│     核心功能优先，非核心功能可失败                        │
│                                                         │
│  3. 错误隔离：                                          │
│     单个服务失败不影响其他服务                            │
│                                                         │
│  4. 熔断保护：                                          │
│     断路器防止级联故障                                   │
│                                                         │
│  5. 监控告警：                                          │
│     降级时记录日志并发送告警                              │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 9. 工作实战场景

### 9.1 API 服务的异常处理中间件

```python
from functools import wraps
from flask import jsonify
import logging

logger = logging.getLogger(__name__)

def error_handler(f):
    """API 异常处理装饰器：统一错误响应格式。"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        try:
            return f(*args, **kwargs)
        except ValidationError as e:
            logger.warning(f"参数校验失败: {e.message}")
            return jsonify({
                "code": 400,
                "message": e.message,
                "field": e.field
            }), 400
        except AuthenticationError as e:
            logger.warning(f"认证失败: {e.message}")
            return jsonify({
                "code": 401,
                "message": "未授权，请重新登录"
            }), 401
        except NotFoundError as e:
            logger.warning(f"资源未找到: {e.message}")
            return jsonify({
                "code": 404,
                "message": e.message
            }), 404
        except Exception as e:
            logger.exception(f"服务器内部错误: {e}")
            return jsonify({
                "code": 500,
                "message": "服务器内部错误，请稍后重试"
            }), 500
    return decorated_function

@app.route("/api/users/<int:user_id>", methods=["GET"])
@error_handler
def get_user_api(user_id):
    user = get_user(user_id)
    return jsonify(user.serialize())
```

**生产环境的响应格式规范**：

```json
{
    "code": 200,
    "message": "success",
    "data": {...},
    "request_id": "abc-123",
    "timestamp": 1699999999
}
```

### 9.2 数据处理管道的异常日志

```python
import logging
from datetime import datetime

logger = logging.getLogger(__name__)

class DataPipeline:
    """数据处理管道：记录每个阶段的处理情况。"""
    
    def __init__(self, name):
        self.name = name
        self.start_time = None
        self.processed_count = 0
        self.failed_count = 0
    
    def __enter__(self):
        self.start_time = datetime.now()
        logger.info(f"[{self.name}] 管道开始")
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        elapsed = datetime.now() - self.start_time
        logger.info(
            f"[{self.name}] 管道结束 | "
            f"处理: {self.processed_count} | "
            f"失败: {self.failed_count} | "
            f"耗时: {elapsed.total_seconds():.2f}s"
        )
    
    def process_item(self, item, handler):
        """处理单个数据项，记录成功/失败。"""
        try:
            result = handler(item)
            self.processed_count += 1
            return result
        except Exception as e:
            self.failed_count += 1
            logger.error(f"[{self.name}] 处理失败: item={item}, error={e}")
            return None

# 使用示例
with DataPipeline("用户数据同步") as pipeline:
    for user in source_users:
        pipeline.process_item(user, sync_user)
```

### 9.3 定时任务的异常处理

```python
import schedule
import time
import logging

logger = logging.getLogger(__name__)

def safe_job(job_name, job_func, *args, **kwargs):
    """安全的定时任务包装：异常捕获和重试。"""
    def wrapper():
        try:
            logger.info(f"[{job_name}] 任务开始")
            job_func(*args, **kwargs)
            logger.info(f"[{job_name}] 任务完成")
        except Exception as e:
            logger.exception(f"[{job_name}] 任务失败")
            # 可选：发送告警
            # alert(f"定时任务 {job_name} 失败: {e}")
    return wrapper

# 注册定时任务
schedule.every(10).minutes.do(safe_job("数据统计", run_statistics))
schedule.every().hour.do(safe_job("缓存清理", clean_cache))
schedule.every().day.at("02:00").do(safe_job("每日备份", daily_backup))

# 运行调度器
while True:
    try:
        schedule.run_pending()
        time.sleep(1)
    except KeyboardInterrupt:
        logger.info("调度器停止")
        break
    except Exception as e:
        logger.exception("调度器异常")
        time.sleep(60)
```

### 9.4 文件操作的安全封装

```python
import os
import logging

logger = logging.getLogger(__name__)

def safe_write_file(filepath, content, backup=True):
    """安全写文件：先写临时文件，再原子替换。"""
    temp_file = f"{filepath}.tmp"
    
    try:
        # 写入临时文件
        with open(temp_file, "w", encoding="utf-8") as f:
            f.write(content)
        
        # 备份原文件
        if backup and os.path.exists(filepath):
            backup_file = f"{filepath}.bak"
            os.replace(filepath, backup_file)
            logger.info(f"已备份原文件: {backup_file}")
        
        # 原子替换
        os.replace(temp_file, filepath)
        logger.info(f"文件写入成功: {filepath}")
        
    except Exception as e:
        # 清理临时文件
        if os.path.exists(temp_file):
            os.remove(temp_file)
        logger.error(f"文件写入失败: {filepath}, error={e}")
        raise
```

---

## 10. 常见面试题汇总

### 10.1 基础概念题

**Q1：`BaseException` 和 `Exception` 的区别是什么？应该捕获哪个？**

**A**：`BaseException` 是所有异常的基类，包含 `SystemExit`、`KeyboardInterrupt`、`GeneratorExit` 和 `Exception`。`Exception` 是所有常规异常的基类。应捕获 `Exception`，因为 `SystemExit` 和 `KeyboardInterrupt` 是程序的合法退出机制，不应被捕获。

---

**Q2：`try/except/else/finally` 各子句的执行顺序是什么？**

**A**：
1. `try` 块始终执行
2. 如果 `try` 中无异常：执行 `else` → 执行 `finally` → 继续后续代码
3. 如果 `try` 中有异常：匹配 `except`（匹配则执行，不匹配则向上抛出）→ 执行 `finally` → 根据异常是否被处理决定后续

---

**Q3：`raise` 和 `raise e` 有什么区别？**

**A**：`raise` 在 `except` 块中重新抛出当前异常，保留完整的原始 traceback；`raise e` 重新创建 traceback，丢失原始位置信息。推荐使用 `raise`。

---

**Q4：`assert` 在生产环境中是否可靠？为什么？**

**A**：不可靠。`assert` 在 `python -O`（优化模式）下会被完全跳过。因此，外部输入验证必须用 `raise`，`assert` 只用于开发期的内部逻辑检查。

---

**Q5：`logger.exception()` 和 `logger.error()` 的区别？**

**A**：`logger.exception()` 等价于 `logger.error(..., exc_info=True)`，会自动附加完整的堆栈跟踪信息。只应在 `except` 块中使用。

---

### 10.2 实战应用题

**Q6：如何设计一个好的异常体系？**

**A**：
1. 建立异常层级：根异常 → 分类异常 → 具体异常
2. 异常信息包含足够上下文（参数值、操作意图）
3. 不要泄露敏感数据（密码、token）
4. 异常携带错误码，便于上层处理
5. 使用异常链（`raise ... from`）保留根因

---

**Q7：生产环境中日志应该如何配置？**

**A**：
1. 多输出目标：控制台（开发）+ 文件（生产）+ 日志聚合系统（ELK）
2. 日志级别：生产环境至少 INFO，开发环境 DEBUG
3. 日志轮转：按大小（RotatingFileHandler）+ 按时间（TimedRotatingFileHandler）
4. 结构化日志：JSON 格式便于解析和搜索
5. 敏感信息脱敏：密码、手机号、银行卡号等
6. 模块级 logger：使用 `logging.getLogger(__name__)`

---

**Q8：如何实现重试机制？应该注意什么？**

**A**：
1. 使用装饰器封装重试逻辑
2. 设置最大重试次数和退避策略（指数退避最佳）
3. 添加随机抖动避免请求风暴
4. 只重试可恢复的异常（网络问题、超时），不重试业务错误（认证失败）
5. 记录重试日志便于排查

---

**Q9：什么是断路器模式？适用于什么场景？**

**A**：断路器模式用于防止反复重试已确认失败的服务，避免级联故障。当失败次数达到阈值时，断路器打开，直接拒绝请求；经过一段时间后进入半开状态，允许少量请求探测；如果成功则关闭，失败则重新打开。适用于微服务架构中的远程调用。

---

**Q10：如何优雅地处理生产环境中的未捕获异常？**

**A**：
1. 设置全局异常钩子 `sys.excepthook`
2. 在 Web 框架中注册全局异常处理器
3. 记录完整的 traceback 和上下文信息
4. 发送告警通知（邮件、短信、钉钉等）
5. 返回友好的错误信息给用户，隐藏技术细节

---

### 10.3 代码分析题

**Q11：分析以下代码的问题：**

```python
try:
    data = json.loads(user_input)
except Exception:
    pass  # 静默忽略
```

**A**：
1. 静默忽略异常会导致问题被隐藏
2. 不知道具体是什么错误
3. 应该至少记录日志
4. 更好的做法是区分 `JSONDecodeError` 和其他异常

---

**Q12：分析以下代码的问题：**

```python
def login(username, password):
    assert username, "用户名不能为空"
    assert password, "密码不能为空"
    # ...
```

**A**：在 `python -O` 模式下运行时，断言被跳过，即使传入空字符串也会继续执行，可能导致更严重的错误。外部输入验证必须用 `raise`。

---

**Q13：以下代码会打印什么？**

```python
try:
    print("try")
    raise ValueError("test")
except:
    print("except")
else:
    print("else")
finally:
    print("finally")
```

**A**：`try` → `except` → `finally`。`else` 不会执行（因为有异常）。

---

## 11. 实战项目：异常处理与日志系统搭建

### 11.1 项目概述

**项目目标**：搭建一个生产级的异常处理和日志系统，包含：
- 统一的异常层级设计
- 多环境日志配置
- API 异常处理中间件
- 结构化日志输出
- 日志轮转和归档
- 全局异常捕获

### 11.2 项目结构

```
exception_project/
├── app/
│   ├── __init__.py
│   ├── exceptions.py      # 自定义异常定义
│   ├── logging_config.py  # 日志配置
│   ├── middleware.py      # 异常处理中间件
│   ├── services.py        # 业务服务
│   └── api.py             # API 路由
├── config/
│   ├── dev.py             # 开发环境配置
│   └── prod.py            # 生产环境配置
├── requirements.txt
└── main.py
```

### 11.3 核心代码

**exceptions.py**：

```python
class AppError(Exception):
    def __init__(self, message, code=None, details=None):
        super().__init__(message)
        self.message = message
        self.code = code
        self.details = details or {}

class ValidationError(AppError):
    def __init__(self, message, field=None, **kwargs):
        super().__init__(message, code="VALIDATION_ERROR", **kwargs)
        self.field = field

class AuthenticationError(AppError):
    def __init__(self, message="认证失败", **kwargs):
        super().__init__(message, code="AUTH_ERROR", **kwargs)

class NotFoundError(AppError):
    def __init__(self, resource, identifier, **kwargs):
        message = f"{resource} 未找到: {identifier}"
        super().__init__(message, code="NOT_FOUND", **kwargs)

class ExternalServiceError(AppError):
    def __init__(self, service, message, **kwargs):
        super().__init__(message, code=f"{service.upper()}_ERROR", **kwargs)
        self.service = service
```

**logging_config.py**：

```python
import logging
import logging.config
import os
from datetime import datetime

def configure_logging(env="dev"):
    log_dir = os.path.join(os.path.dirname(__file__), "..", "logs")
    os.makedirs(log_dir, exist_ok=True)
    
    today = datetime.now().strftime("%Y%m%d")
    
    config = {
        "version": 1,
        "disable_existing_loggers": False,
        "formatters": {
            "standard": {
                "format": "%(asctime)s [%(levelname)s] %(name)s:%(lineno)d: %(message)s",
            },
            "json": {
                "format": (
                    '{"time": "%(asctime)s", "level": "%(levelname)s", '
                    '"logger": "%(name)s", "line": %(lineno)d, '
                    '"message": "%(message)s"}'
                ),
            },
        },
        "handlers": {
            "console": {
                "class": "logging.StreamHandler",
                "level": "DEBUG" if env == "dev" else "INFO",
                "formatter": "standard",
            },
            "file": {
                "class": "logging.handlers.RotatingFileHandler",
                "level": "INFO",
                "formatter": "json",
                "filename": os.path.join(log_dir, f"app_{today}.log"),
                "maxBytes": 10 * 1024 * 1024,
                "backupCount": 30,
                "encoding": "utf-8",
            },
            "error_file": {
                "class": "logging.handlers.RotatingFileHandler",
                "level": "ERROR",
                "formatter": "json",
                "filename": os.path.join(log_dir, f"error_{today}.log"),
                "maxBytes": 5 * 1024 * 1024,
                "backupCount": 30,
                "encoding": "utf-8",
            },
        },
        "loggers": {
            "": {
                "handlers": ["console", "file", "error_file"],
                "level": "DEBUG" if env == "dev" else "INFO",
                "propagate": False,
            },
            "requests": {
                "level": "WARNING",
            },
            "urllib3": {
                "level": "WARNING",
            },
        },
    }
    
    logging.config.dictConfig(config)
```

**middleware.py**：

```python
from functools import wraps
from flask import jsonify, request
import logging
import traceback
import uuid

logger = logging.getLogger(__name__)

def error_handler(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        request_id = str(uuid.uuid4())[:8]
        
        try:
            logger.info(
                f"[REQ:{request_id}] {request.method} {request.path} | "
                f"params={request.args} | body={request.get_json(silent=True)}"
            )
            
            response = f(*args, **kwargs)
            
            logger.info(f"[RES:{request_id}] {response.status_code}")
            return response
            
        except ValidationError as e:
            logger.warning(f"[ERR:{request_id}] 参数校验失败: {e.message}")
            return jsonify({
                "code": 400,
                "message": e.message,
                "field": e.field,
                "request_id": request_id
            }), 400
            
        except AuthenticationError as e:
            logger.warning(f"[ERR:{request_id}] 认证失败: {e.message}")
            return jsonify({
                "code": 401,
                "message": "未授权，请重新登录",
                "request_id": request_id
            }), 401
            
        except NotFoundError as e:
            logger.warning(f"[ERR:{request_id}] 资源未找到: {e.message}")
            return jsonify({
                "code": 404,
                "message": e.message,
                "request_id": request_id
            }), 404
            
        except ExternalServiceError as e:
            logger.error(f"[ERR:{request_id}] 外部服务错误: {e.service} - {e.message}")
            return jsonify({
                "code": 503,
                "message": "服务暂时不可用",
                "request_id": request_id
            }), 503
            
        except Exception as e:
            logger.exception(f"[ERR:{request_id}] 服务器内部错误")
            return jsonify({
                "code": 500,
                "message": "服务器内部错误，请稍后重试",
                "request_id": request_id
            }), 500
    return decorated_function
```

**services.py**：

```python
import logging
from .exceptions import ValidationError, NotFoundError, ExternalServiceError

logger = logging.getLogger(__name__)

class UserService:
    def __init__(self, db_client, redis_client):
        self.db = db_client
        self.cache = redis_client
    
    def get_user(self, user_id):
        if user_id <= 0:
            raise ValidationError("用户 ID 必须大于 0", field="user_id")
        
        cache_key = f"user:{user_id}"
        try:
            user = self.cache.get(cache_key)
            if user:
                logger.debug(f"从缓存获取用户: {user_id}")
                return user
        except Exception as e:
            logger.warning(f"缓存获取失败: {e}")
        
        try:
            user = self.db.query("SELECT * FROM users WHERE id = %s", (user_id,))
            if not user:
                raise NotFoundError("用户", user_id)
            
            try:
                self.cache.set(cache_key, user, ex=300)
            except Exception as e:
                logger.warning(f"缓存设置失败: {e}")
            
            return user
        except ExternalServiceError:
            raise
        except Exception as e:
            logger.error(f"数据库查询失败: {e}")
            raise ExternalServiceError("database", f"查询用户失败: {e}")
```

**main.py**：

```python
import sys
import logging
from flask import Flask
from app.logging_config import configure_logging
from app.api import register_routes
from app.exceptions import AppError

logger = logging.getLogger(__name__)

def create_app(env="dev"):
    configure_logging(env)
    
    app = Flask(__name__)
    register_routes(app)
    
    # 全局未捕获异常处理
    def global_exception_handler(exc_type, exc_value, exc_tb):
        if issubclass(exc_type, KeyboardInterrupt):
            sys.__excepthook__(exc_type, exc_value, exc_tb)
            return
        
        logger.critical("未捕获的异常", exc_info=(exc_type, exc_value, exc_tb))
    
    sys.excepthook = global_exception_handler
    
    return app

if __name__ == "__main__":
    app = create_app(env="dev")
    app.run(host="0.0.0.0", port=5000, debug=True)
```

### 11.4 项目运行

```bash
# 安装依赖
pip install flask redis

# 开发环境运行
python main.py

# 生产环境运行
gunicorn -w 4 main:create_app('prod')
```

### 11.5 项目亮点

1. **统一异常层级**：所有自定义异常继承自 `AppError`，便于统一处理
2. **结构化日志**：JSON 格式输出，便于日志系统解析和搜索
3. **请求追踪**：每个请求分配唯一 ID，便于关联日志
4. **多级缓存**：缓存失败自动降级到数据库
5. **优雅降级**：外部服务失败返回友好错误，不暴露技术细节
6. **配置分离**：开发和生产环境使用不同的日志级别和配置

---

## 附录：第四阶段自检清单

在继续学习第五阶段之前，请确保你能：

- [ ] 画出 Python 异常层级结构，并说明 `BaseException` 和 `Exception` 的区别
- [ ] 正确使用 `try / except / else / finally` 四个子句
- [ ] 解释 `raise ... from` 的三种用法
- [ ] 设计合理的自定义异常层级
- [ ] 区分 `assert` 和 `raise` 的使用场景
- [ ] 配置生产级的 `logging` 系统（控制台+文件+轮转+JSON 格式）
- [ ] 使用 `pdb` / `breakpoint()` 进行交互式调试
- [ ] 解释 `logger.exception()` 和 `logger.error(exc_info=True)` 的等价性
- [ ] 使用 `warnings` 模块标记废弃 API
- [ ] 实现重试装饰器和断路器模式
- [ ] 编写全局异常处理器
- [ ] 实现优雅降级策略
- [ ] 使用结构化日志（JSON 格式）
- [ ] 使用 `icecream` / `rich` 增强调试体验
- [ ] 设置日志轮转策略

---

> **工程师寄语**：优秀的异常处理不是"捕获所有异常然后忽略"，而是"知道什么可能出错，并优雅地处理每种情况"。日志是你的第二双眼睛——在生产环境中，好的日志比好的调试器更重要。记住：**永远不要让用户看到 traceback**。

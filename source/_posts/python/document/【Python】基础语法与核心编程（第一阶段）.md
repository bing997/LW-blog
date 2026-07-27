---
title: 【Python】基础语法与核心编程（第一阶段）
date: 2026-07-22 10:00:00
categories:
  - Python
tags:
  - Python
  - 教程
  - 基础语法
description: 建立 Python 编程的根基，掌握语言核心机制与开发环境配置。此阶段的重点是"知其然且知其所以然"，养成 Pythonic 的编码直觉。
cover: /images/cover.png
---

## 阶段定位

建立 Python 编程的根基，掌握语言核心机制与开发环境配置。此阶段的重点是"知其然且知其所以然"，养成 Pythonic 的编码直觉。

---

## 1. 环境搭建与工具链

### 1.1 Python 解释器

Python 是解释型语言，代码由解释器逐行翻译执行。工作中常见的解释器实现有三种：

| 解释器 | 适用场景 | 特点 |
|--------|----------|------|
| **CPython** | 通用开发、生产环境（最主流） | 官方标准实现，C 语言编写，兼容性与生态最好 |
| **PyPy** | 计算密集型、长时运行的服务端 | 自带 JIT 编译器，纯 Python 代码可提速 5-10 倍，但启动慢、C 扩展兼容性有限 |
| **Anaconda** | 数据科学、机器学习 | 预装 150+ 科学计算包，自带 `conda` 包管理器 |

**Python 执行流程详解**：理解 Python 代码从编写到执行的完整过程，是深入理解语言机制的基础。

```
源代码 (.py)
    ↓  编译（Compile）
字节码 (.pyc)    ← 可被缓存，下次直接加载
    ↓  解释执行（PVM）
运行结果
```

1. **编译阶段**：Python 解释器将 `.py` 源码编译为字节码（Bytecode），字节码是平台无关的中间代码，存储在 `__pycache__` 目录下的 `.pyc` 文件中。如果源码未修改且 `.pyc` 存在，则跳过编译直接加载字节码。
2. **执行阶段**：Python 虚拟机（PVM, Python Virtual Machine）逐条读取字节码并执行。PVM 是 Python 运行的核心引擎，负责将字节码翻译为机器可执行的指令。

```bash
# 查看字节码
import dis
dis.dis("x = 1; y = x + 2")
# 输出：
#   0 LOAD_CONST               0 (1)
#   2 STORE_NAME               0 (x)
#   4 LOAD_NAME                0 (x)
#   6 LOAD_CONST               1 (2)
#   8 BINARY_ADD
#  10 STORE_NAME               1 (y)
```

**CPython vs PyPy 性能对比数据**：

| 基准测试 | CPython 3.11 | PyPy 7.3 (3.10 兼容) | 提速比 |
|----------|-------------|---------------------|--------|
| 纯数值计算（斐波那契） | 基准 | 约 5-8x 快 | ⬆ |
| 字符串处理 | 基准 | 约 3-5x 快 | ⬆ |
| Django 请求处理 | 基准 | 约 2-3x 快 | ⬆ |
| 含 C 扩展的库（NumPy） | 基准 | 可能更慢或兼容性问题 | ⬇/➡ |
| 启动时间 | 快 | 较慢（JIT 预热） | ⬇ |

**Python 版本选择建议**：

| 版本 | 发布时间 | 核心新特性 | 推荐场景 |
|------|----------|-----------|---------|
| **3.10** | 2021.10 | `match/case` 模式匹配、结构模式匹配、精确错误定位 | 稳定生产环境 |
| **3.11** | 2022.10 | 速度提升 10-60%、ExceptionGroup/except*、Self 类型 | 当前最推荐的生产版本 |
| **3.12** | 2023.10 | 更快的推导式、type 参数语法（PEP 695）、灵活的 f-string | 新项目、尝鲜 |
| **3.13** | 2024.10 | 实验性 GIL-free 模式、改进交互解释器、JIT 实验性编译器 | 前沿探索 |

```bash
# 查看当前解释器信息
python -c "import sys; print(sys.executable); print(sys.version)"

# Python 3.11 的精确错误定位示例
# 旧版报错：SyntaxError: invalid syntax
# 3.11+ 报错：SyntaxError: '(' was never closed（精确指出未闭合的括号位置）
```

> **面试真题**：Python 是解释型语言还是编译型语言？请解释 Python 的执行流程。
>
> **易错点**：Python 并非纯解释型语言。它先将源码编译成字节码（.pyc），再由 PVM 解释执行字节码。因此 Python 兼具编译和解释的特征。说"Python 是纯解释型语言"是不准确的。

![Python interpreter architecture diagram showing CPython PyPy Anaconda comparison, clean technical illustration, blue and white color scheme, infographic style](https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Python%20interpreter%20architecture%20diagram%20showing%20CPython%20PyPy%20Anaconda%20comparison%2C%20clean%20technical%20illustration%2C%20blue%20and%20white%20color%20scheme%2C%20infographic%20style&image_size=landscape_16_9)

### 1.2 虚拟环境

虚拟环境是 Python 项目的"隔离舱"，每个项目拥有独立的依赖空间。

**虚拟环境工作原理**：虚拟环境通过修改 `sys.prefix` 和 `PATH` 环境变量来实现隔离，而非物理复制整个 Python 解释器。

```
系统 Python (/usr/bin/python3)
    │
    ├── site-packages/          ← 全局第三方包
    │       ├── requests/
    │       └── numpy/
    │
    ├── 项目A (.venv/)           ← 独立环境
    │       ├── pyvenv.cfg       ← 指向基础 Python
    │       ├── lib/
    │       │   └── site-packages/
    │       │       └── requests==2.28.0
    │       └── bin/python → 系统Python（修改了sys.prefix）
    │
    └── 项目B (.venv/)           ← 独立环境
            ├── pyvenv.cfg
            └── lib/
                └── site-packages/
                    └── requests==2.31.0
```

关键机制：
- **软链接**：虚拟环境中的 Python 可执行文件是指向系统 Python 的软链接（或脚本），但 `sys.prefix` 被修改为虚拟环境目录。
- **路径优先**：激活虚拟环境后，`PATH` 中虚拟环境的 `bin/` 目录排在最前，确保优先使用虚拟环境中的 `pip` 和 `python`。
- **隔离原理**：`site-packages` 目录独立，每个虚拟环境有自己的第三方包目录。

| 工具 | 命令示例 | 适用场景 |
|------|----------|----------|
| `venv`（内置） | `python -m venv .venv` | 最轻量、无额外依赖，日常开发首选 |
| `virtualenv` | `virtualenv -p python3.11 venv` | 需要指定不同 Python 版本时使用 |
| `conda` | `conda create -n myenv python=3.11` | 数据科学栈，管理非 Python 依赖（如 CUDA） |

**pip 配置文件**（加速下载与镜像源配置）：

```ini
# pip.conf（Linux/macOS: ~/.pip/pip.conf，Windows: %APPDATA%\pip\pip.ini）
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
trusted-host = pypi.tuna.tsinghua.edu.cn

[install]
# 每次安装都生成 requirements 文件（可选）
require-virtualenv = true    # 禁止在全局环境安装包，强制使用虚拟环境
```

**pyproject.toml 配置示例**（现代 Python 项目标准）：

```toml
[project]
name = "my-project"
version = "0.1.0"
description = "A modern Python project"
requires-python = ">=3.10"
dependencies = [
    "requests>=2.28",
    "rich>=13.0",
]

[project.optional-dependencies]
dev = ["pytest", "black", "ruff"]

[tool.ruff]
line-length = 88
select = ["E", "F", "W"]

[tool.pytest.ini_options]
testpaths = ["tests"]
```

**最佳实践**：
1. 每个项目根目录创建 `.venv` 或 `venv` 目录，并加入 `.gitignore`。
2. 养成"进入项目先激活环境"的肌肉记忆：
   ```bash
   # Windows (PowerShell)
   .\.venv\Scripts\Activate.ps1
   # macOS / Linux
   source .venv/bin/activate
   ```
3. 导出依赖锁定文件，确保团队环境一致：
   ```bash
   pip freeze > requirements.txt       # 基础方式
   pip install pip-tools
   pip-compile requirements.in        # 更严谨的依赖解析
   ```

**常见环境问题排查**：

| 问题 | 原因 | 解决方案 |
|------|------|---------|
| `ModuleNotFoundError` | 未安装包 / 未激活虚拟环境 | `pip install <pkg>` 或激活 `.venv` |
| `pip install` 安装到全局 | 未激活虚拟环境 | 先激活虚拟环境，或配置 `require-virtualenv = true` |
| 权限被拒（PowerShell） | 执行策略限制 | `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned` |
| `python` 命令找不到 | Windows 未添加 PATH | 安装时勾选 "Add Python to PATH"，或手动添加 |
| 版本冲突 | 多个 Python 版本混用 | 使用 `py -3.11`（Windows launcher）或 `python3.11` 指定版本 |

> **面试真题**：虚拟环境是如何实现隔离的？`venv` 和 `virtualenv` 有什么区别？
>
> **易错点**：虚拟环境不是完整复制 Python 解释器，而是通过修改 `sys.prefix` 和 `PATH` 实现隔离。`venv` 是 Python 3.3+ 内置模块，功能精简；`virtualenv` 是第三方包，支持更多特性（如指定不同 Python 版本、更快创建速度）。

![Python virtual environment isolation concept diagram showing multiple independent project environments with separate packages, clean infographic, green and white](https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Python%20virtual%20environment%20isolation%20concept%20diagram%20showing%20multiple%20independent%20project%20environments%20with%20separate%20packages%2C%20clean%20infographic%2C%20green%20and%20white&image_size=landscape_16_9)

### 1.3 IDE / 编辑器选择

| 工具 | 定位 | 核心优势 |
|------|------|----------|
| **PyCharm** | 专业级 IDE | 代码分析、重构、调试、数据库工具集成最完善 |
| **VS Code** | 轻量编辑器 + 插件 | 启动快、插件丰富、多语言通用 |
| **Jupyter** | 交互式探索 | 数据分析、算法验证、教学演示的神器 |

**各 IDE 推荐插件列表**：

**PyCharm 插件**：
- `.ignore`：生成各类 `.gitignore` 模板
- `Key Promoter X`：快捷键提示，帮助脱离鼠标
- `Rainbow Brackets`：彩色括号匹配
- `String Manipulation`：字符串格式转换（驼峰/下划线/常量）
- `GitToolBox`：增强 Git 集成
- `.env files support`：环境变量文件高亮

**VS Code 插件**：
- `Python`（Microsoft）：核心 Python 支持（IntelliSense、调试）
- `Pylance`：高性能类型检查和自动补全
- `Ruff`：极速 linter + formatter（替代 flake8 + isort + black）
- `Python Test Explorer`：测试可视化运行
- `Python Docstring Generator`：自动生成 docstring
- `Jupyter`：笔记本支持
- `Error Lens`：行内显示错误信息

**调试器配置技巧**：

```json
// VS Code launch.json 配置示例
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Current File",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal",
            "justMyCode": true    // 仅调试自己的代码，跳过库代码
        },
        {
            "name": "Python: Flask",
            "type": "python",
            "request": "launch",
            "module": "flask",
            "env": {
                "FLASK_APP": "app.py",
                "FLASK_DEBUG": "1"
            },
            "args": ["run", "--port=5000"]
        }
    ]
}
```

**调试高效技巧**：
- **条件断点**：右键断点 → 设置条件（如 `i == 100`），只在满足条件时暂停
- **日志断点**：不暂停执行，仅打印日志（右键断点 → 选择 "Logpoint"）
- **调试时表达式求值**：在 Debug Console 中可实时执行表达式
- **远程调试**：使用 `debugpy` 库进行远程调试

```python
# 使用 breakpoint()（Python 3.7+）—— 比手动 import pdb 更优雅
def compute(data):
    result = process(data)
    breakpoint()    # 自动进入 pdb，可用 n(下一步) s(进入) c(继续) p(打印)
    return result
```

**老工程师的选择逻辑**：
- 大型项目、Web 后端开发 → PyCharm Professional
- 全栈/多语言开发、远程开发 → VS Code + Python 插件
- 数据探索、模型实验 → Jupyter Lab

> **面试真题**：你在项目中如何选择开发工具？如何提高调试效率？
>
> **易错点**：初学者常忽视 `breakpoint()` 的使用，仍然使用 `print()` 调试。在生产代码中应删除断点语句，或通过 `PYTHONBREAKPOINT=0` 环境变量禁用。

### 1.4 包管理

| 工具 | 设计哲学 | 核心文件 | 推荐度 |
|------|----------|----------|--------|
| `pip` | 基础安装器 | `requirements.txt` | 必会基础 |
| `poetry` | 现代全功能 | `pyproject.toml` + `poetry.lock` | ⭐ 新项目首选 |
| `pipenv` | 虚拟环境+包管理一体 | `Pipfile` + `Pipfile.lock` | 社区活跃度下降，新项目不推荐 |

**pip 常用命令速查表**：

```bash
# 安装
pip install requests                    # 安装最新版
pip install requests==2.28.0           # 指定版本
pip install "requests>=2.28,<3.0"      # 版本范围
pip install -r requirements.txt        # 从文件批量安装
pip install -e .                       # 可编辑模式安装（开发本地包）

# 查看
pip list                               # 列出已安装包
pip show requests                      # 查看包详情
pip outdated                           # 查看过期包（需 pip-outdated）

# 卸载
pip uninstall requests                 # 卸载包

# 导出
pip freeze > requirements.txt          # 导出依赖列表
pip check                              # 检查依赖冲突

# 清理
pip cache purge                        # 清除缓存
pip autoremove                         # 移除不再需要的依赖
```

**requirements.txt vs pyproject.toml 对比**：

| 特性 | `requirements.txt` | `pyproject.toml` |
|------|-------------------|-------------------|
| 标准化 | 非官方约定 | PEP 517/518 官方标准 |
| 依赖分组 | 不支持（需多文件） | 原生支持（optional-dependencies） |
| 元数据 | 不支持 | 项目名称、版本、作者等完整元数据 |
| 构建系统 | 不涉及 | 可定义构建后端（setuptools/flit/poetry） |
| 锁定版本 | 需手动 `pip freeze` | `poetry.lock` / 精确依赖解析 |
| 生态兼容 | pip 通用 | 需要构建工具（poetry/build） |
| 推荐场景 | 简单脚本、Docker 部署 | 正式项目、可发布包 |

**Poetry 快速上手**（2024 年最推荐的方案）：
```bash
# 安装
pip install poetry

# 初始化项目
poetry new my-project
cd my-project

# 添加依赖（自动写入 pyproject.toml 并锁定版本）
poetry add requests
poetry add pytest --group dev   # 开发依赖

# 安装所有依赖（根据 poetry.lock 精确还原）
poetry install

# 运行命令在虚拟环境中
poetry run python main.py
poetry shell                      # 进入虚拟环境 shell
```

**Poetry 项目结构**：
```
my-project/
├── pyproject.toml      ← 项目配置 + 依赖声明
├── poetry.lock         ← 锁定的精确依赖版本（提交到 Git）
├── README.md
├── src/
│   └── my_project/
│       ├── __init__.py
│       └── main.py
└── tests/
    ├── __init__.py
    └── test_main.py
```

> **面试真题**：`requirements.txt` 和 `pyproject.toml` 有什么区别？如何管理项目的依赖？
>
> **易错点**：`pip freeze` 会导出所有包（包括间接依赖），导致 requirements.txt 臃肿。推荐使用 `pip-compile`（pip-tools）或 Poetry，只声明直接依赖，由工具自动解析间接依赖。

---

## 2. 基本语法

### 2.1 变量、标识符、关键字

**变量本质**：Python 中的变量是指向对象的"标签"（引用），而非存储数据的容器。这是理解 Python 内存模型的核心概念。

```python
a = [1, 2, 3]
b = a          # b 和 a 指向同一个列表对象
b.append(4)
print(a)       # [1, 2, 3, 4] —— 这是新人最常踩的坑
```

**Python 变量内存模型图解**：

```
变量名（标签）          内存中的对象
   ┌──────┐         ┌──────────────┐
   │  a   │────────→│ list [1,2,3] │  type: list
   └──────┘         │   id: 140xxx │  value: [1,2,3,4]
   ┌──────┐         │  refcnt: 2   │  ← 引用计数为2（a和b都指向它）
   │  b   │────────→│              │
   └──────┘         └──────────────┘
```

Python 的变量赋值本质是"让一个名字指向一个对象"，而非"把数据装进盒子"。因此，多个变量可以指向同一个对象。

**`id()` 函数和 `is` 运算符的关系**：

```python
# id() 返回对象的唯一标识（CPython 中是内存地址）
a = [1, 2, 3]
b = a
c = [1, 2, 3]

print(id(a))        # 例如 140234567890752
print(id(b))        # 与 a 相同
print(id(c))        # 不同！c 是一个新对象

# is 判断两个变量是否指向同一个对象（id 是否相同）
print(a is b)       # True —— 同一个对象
print(a is c)       # False —— 不同对象（即使值相同）

# == 判断两个对象的值是否相等
print(a == c)       # True —— 值相同

# 经典陷阱：小整数和字符串的 is 比较
a = 256
b = 256
print(a is b)       # True —— 小整数池范围内

c = 257
d = 257
print(c is d)       # 可能是 False！—— 超出小整数池范围

# 正确做法：比较值始终用 ==，只有判断 None/True/False 时用 is
x = None
if x is None:       # ✅ 正确
    pass
if x == None:       # ❌ 不推荐
    pass
```

**小整数池机制（-5 ~ 256）**：

CPython 在启动时预创建 -5 到 256 的整数对象，这些对象在整个解释器生命周期内被缓存复用。因此，任何指向这些值的变量都会指向同一个对象。

```python
# 小整数池内的对象被缓存
a = -5
b = -5
print(a is b)   # True —— 指向同一个缓存对象

a = 256
b = 256
print(a is b)   # True —— 仍在缓存范围内

# 超出范围的对象每次创建新实例
a = 257
b = 257
print(a is b)   # False（在交互模式中）—— 但在同一个代码块中可能为 True（编译器优化）

# 注意：在同一个代码块（如脚本文件）中，编译器可能做常量折叠优化
# 以下在脚本文件中运行时可能为 True
x = 257; y = 257
print(x is y)   # 可能为 True（编译器优化为同一常量）
```

**字符串驻留机制**：

Python 会将符合特定规则的字符串进行"驻留"（intern），使相同内容的字符串共享同一个对象，节省内存。

```python
# 符合标识符规则的字符串会被驻留
a = "hello"
b = "hello"
print(a is b)       # True —— 被驻留

# 包含特殊字符的字符串不一定驻留
a = "hello!"
b = "hello!"
print(a is b)       # 可能为 False —— 不符合标识符规则

# 显式驻留
import sys
a = sys.intern("hello!")
b = sys.intern("hello!")
print(a is b)       # True —— 手动驻留后共享对象

# 字符串驻留的应用场景：大量重复字符串的字典键（如日志分析）
# 驻留后可大幅减少内存使用和比较时间（is 比 == 快）
```

**命名规范（PEP 8）**：
- `snake_case`：变量、函数名（如 `user_name`、`calculate_total`）
- `PascalCase`：类名（如 `UserService`、`HttpResponse`）
- `UPPER_CASE`：常量（如 `MAX_RETRY_COUNT`、`DEFAULT_TIMEOUT`）
- `_single_leading_underscore`："内部使用"约定，不公开 API
- `__double_leading_underscore`：触发名称改写（name mangling），用于避免子类属性冲突

**命名反面教材**：

```python
# ❌ 糟糕的命名
l = [1, 2, 3]          # 小写 l 易与 1 混淆
O = 100                 # 大写 O 易与 0 混淆
I = 200                 # 大写 I 易与 l/1 混淆
data = [1, 2, 3]       # 过于笼统
flag = True             # 含义不清
tmp = compute()         # 临时变量名无意义
d1 = get_data()         # 数字后缀无意义

# ✅ 好的命名
user_list = [1, 2, 3]
max_retries = 100
payment_processed = True
computed_value = compute()
primary_data = get_data()
```

**关键字速查**（不可作为标识名）：
```python
import keyword
print(keyword.kwlist)
# ['False', 'None', 'True', 'and', 'as', 'assert', 'async', 'await',
#  'break', 'class', 'continue', 'def', 'del', 'elif', 'else', 'except',
#  'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is',
#  'lambda', 'nonlocal', 'not', 'or', 'pass', 'raise', 'return',
#  'try', 'while', 'with', 'yield']

# Python 3.10+ 新增关键字
print(keyword.softkwlist)
# ['match', 'case', '_'（通配符）]
```

> **面试真题**：Python 中 `is` 和 `==` 的区别是什么？为什么 `a = 257; b = 257; a is b` 在交互模式和脚本中结果可能不同？
>
> **易错点**：① 误用 `is` 比较值相等性（应使用 `==`）；② 误以为 `is` 比较的是值而非对象身份；③ 不知道小整数池的范围是 -5 到 256；④ 在 for 循环中用 `is` 判断是否等于某个整数，结果可能不符合预期。

![Python variable reference model showing variables as labels pointing to objects in memory, arrows from names to memory boxes, technical diagram, purple theme](https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Python%20variable%20reference%20model%20showing%20variables%20as%20labels%20pointing%20to%20objects%20in%20memory%2C%20arrows%20from%20names%20to%20memory%20boxes%2C%20technical%20diagram%2C%20purple%20theme&image_size=landscape_16_9)

### 2.2 缩进与代码块

Python 使用**缩进**定义代码块，这是语法的一部分，不是风格建议。

```python
def check_age(age):
    if age >= 18:                  # if 块开始
        print("成年人")             # 4 空格缩进（PEP 8 标准）
        if age >= 60:              # 嵌套块继续缩进
            print("老年人")         # 8 空格缩进
    else:                          # 与 if 同级
        print("未成年人")
```

**缩进错误排查技巧**：

1. **TabError: inconsistent use of tabs and spaces in indentation**
   ```bash
   # 快速检测文件中的 Tab 字符
   python -c "with open('file.py') as f: [print(f'Line {i+1}: Tab found') for i, line in enumerate(f) if '\t' in line]"
   ```

2. **IndentationError: unindent does not match any outer indentation level**
   - 最常见原因：混用空格和 Tab
   - 复制粘贴代码后未统一缩进
   - 不同编辑器 Tab 宽度设置不一致

3. **自动修复工具**：
   ```bash
   # autopep8 —— 自动修复 PEP 8 违规（包括缩进）
   pip install autopep8
   autopep8 --in-place --aggressive file.py

   # black —— 不可配置的格式化器（统一风格）
   pip install black
   black file.py

   # Ruff —— 超快的 linter + formatter（推荐）
   pip install ruff
   ruff format file.py        # 格式化
   ruff check --fix file.py   # 检查并自动修复
   ```

**血泪教训**：
- 永远不要混用空格和 Tab，团队统一使用 **4 个空格**。
- 在 `.editorconfig` 中配置，从源头杜绝：
  ```ini
  [*.py]
  indent_style = space
  indent_size = 4
  ```
- 复制粘贴代码时，若出现 `IndentationError`，优先检查是否混入了 Tab。
- 在 Git 中设置 `git config --global core.autocrlf false`，避免换行符差异导致缩进问题。

> **面试真题**：Python 为什么用缩进而非花括号？缩进混用空格和 Tab 会怎样？
>
> **易错点**：Tab 和空格在视觉上可能一样，但 Python 解释器会严格区分。PEP 8 规定使用 4 个空格，Tab 只在已有代码中与 Tab 保持一致时使用。

### 2.3 注释与文档字符串

```python
# 单行注释：解释"为什么"，而非"做什么"
# 坏注释：x = x + 1  # x 加 1
# 好注释：补偿边界偏移量，使索引从 0 开始
x = x + 1


# 多行注释（实际是多行字符串，未被引用时会被解释器忽略）
"""
这是模块级别的说明，通常放在文件顶部。
说明模块职责、主要类和函数的概要。
"""


def calculate_area(radius):
    """返回圆的面积。

    Args:
        radius (float): 圆的半径，必须大于 0。

    Returns:
        float: 圆的面积。

    Raises:
        ValueError: 如果 radius <= 0。

    Example:
        >>> calculate_area(5)
        78.53981633974483
    """
    if radius <= 0:
        raise ValueError("半径必须大于 0")
    import math
    return math.pi * radius ** 2
```

**Sphinx 文档生成流程**：

```
docstring（Google/NumPy 风格）
    ↓  sphinx-apidoc / autodoc 扩展
.rst 文件（reStructuredText）
    ↓  sphinx-build
HTML 文档网站
```

```bash
# 安装 Sphinx
pip install sphinx sphinx-rtd-theme

# 初始化文档目录
cd docs
sphinx-quickstart

# 从代码自动生成 API 文档
sphinx-apidoc -o source ../src/my_package

# 构建文档
sphinx-build -b html source build
```

**type hint 配合 docstring 的最佳实践**：

```python
from typing import Optional, Union

def search_user(
    user_id: int,
    *,
    active_only: bool = True,
    fields: Optional[list[str]] = None,
) -> Optional[dict[str, Union[str, int]]]:
    """根据 ID 搜索用户。

    Args:
        user_id: 用户唯一标识符，必须为正整数。
        active_only: 是否只搜索活跃用户，默认 True。
        fields: 需要返回的字段列表，None 表示全部字段。

    Returns:
        用户信息字典，未找到时返回 None。

    Raises:
        ValueError: user_id 不是正整数时。

    Example:
        >>> search_user(42, active_only=False)
        {'id': 42, 'name': 'Alice', 'status': 'inactive'}
    """
    if user_id <= 0:
        raise ValueError("user_id 必须为正整数")
    # ... 实际逻辑
```

**工程规范**：
- 公开 API（函数、类、模块）必须有文档字符串（docstring）。
- 推荐使用 **Google 风格** 或 **NumPy 风格**，配合 Sphinx 自动生成文档。
- 私有函数（`_` 开头）可简化注释，但复杂逻辑仍需说明。
- type hint 和 docstring 互补：type hint 提供机器可读的类型信息，docstring 提供语义说明。

> **面试真题**：Python 的 docstring 有哪几种风格？如何在项目中自动生成 API 文档？
>
> **易错点**：混淆注释和文档字符串的用途。注释是给开发者看的，docstring 是 API 文档的一部分，会被 `help()` 和 Sphinx 提取。单行注释用 `#`，不要用三引号代替。

---

## 3. 数据类型与数据结构

Python 中一切皆为对象，每个对象都有**类型**、**值**和**身份（id）**。

### 3.1 数字类型

```python
# int —— 任意精度整数，不存在溢出问题
big = 2 ** 1000          # 完全可以
print(type(big))         # <class 'int'>

# float —— 双精度浮点数（IEEE 754），精度约 15-17 位有效数字
a = 0.1 + 0.2
print(a)                 # 0.30000000000000004 —— 浮点精度问题
print(a == 0.3)          # False！

# 浮点数比较的正确姿势
import math
print(math.isclose(a, 0.3))   # True

# 金融计算等精确场景用 decimal
from decimal import Decimal, getcontext
getcontext().prec = 6
print(Decimal('0.1') + Decimal('0.2'))   # 0.3

# complex —— 复数
z = 3 + 4j
print(abs(z))            # 5.0（模长）

# bool —— int 的子类，但语义上独立
print(True + True)       # 2（可作数学运算，但不推荐这么写）
print(isinstance(True, int))  # True
```

**整数缓存机制详解**：

CPython 不仅缓存 -5 到 256 的小整数，还会对某些特定值做优化：

```python
# 小整数池：-5 到 256 被预创建并缓存
import sys
print(sys.getsizeof(0))    # 24 字节（64位系统）
print(sys.getsizeof(1))    # 28 字节
print(sys.getsizeof(2**30)) # 32 字节，值越大占用内存越多

# 大整数每增加 2^30 约多占 4 字节
print(sys.getsizeof(2**60))   # 36 字节
print(sys.getsizeof(2**1000)) # 约 160 字节

# 布尔值本质上是整数的子类
print(True == 1)      # True（值相等）
print(False == 0)     # True
print(True is 1)      # False（不是同一个对象，但 bool 继承自 int）
```

**浮点数 IEEE 754 详解**：

```
IEEE 754 双精度浮点数（64 位）结构：
┌─────┬──────────────┬─────────────────────────────────────┐
│ 符号 │    指数(11位) │           尾数(52位)                 │
│ 1位  │   范围: -1022 │   精度: 约 15-17 位有效数字          │
│      │   ~ +1023     │                                     │
└─────┴──────────────┴─────────────────────────────────────┘

特殊值：
- inf / -inf：无穷大（1.0 / 0.0）
- nan：非数字（0.0 / 0.0 或 float('nan')）
- -0.0：负零（-0.0 == 0.0 为 True，但 1/0.0 报错而 1/-0.0 为 -inf）
```

```python
# 浮点数精度问题的根本原因
# 0.1 在二进制中是无限循环小数：0.00011001100110011...
# 存储时被截断，导致 0.1 + 0.2 ≠ 0.3
print(f"{0.1:.60f}")   # 0.100000000000000005551115123125782702118158340454101562500000
print(f"{0.2:.60f}")   # 0.200000000000000011102230246251565404236316680908203125000000
print(f"{0.3:.60f}")   # 0.299999999999999988897769753748434595763683319091796875000000

# 特殊浮点值
print(float('inf'))     # inf
print(float('-inf'))    # -inf
print(float('nan'))     # nan
print(1.0 / 0.0)       # ZeroDivisionError（不是 inf！Python 做了除零检查）
import math
print(math.inf)         # inf（通过 math 获取）
print(math.nan)         # nan
print(math.isnan(math.nan))  # True（nan 不等于自身！）
print(math.nan == math.nan)  # False！
```

**Decimal 精度控制实战**：

```python
from decimal import Decimal, getcontext, ROUND_HALF_UP, ROUND_DOWN

# 设置全局精度
getcontext().prec = 28    # 28 位有效数字（默认值）

# 金融计算：精确到分
price = Decimal('19.99')
tax_rate = Decimal('0.08')
tax = (price * tax_rate).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
print(tax)     # 1.60（四舍五入到分）

# 不同的舍入模式
value = Decimal('2.675')
print(value.quantize(Decimal('0.01'), rounding=ROUND_HALF_UP))   # 2.68
print(value.quantize(Decimal('0.01'), rounding=ROUND_DOWN))       # 2.67

# Decimal 必须用字符串初始化！
print(Decimal(0.1))         # 0.1000000000000000055511151231257827021181583404541015625
print(Decimal('0.1'))       # 0.1 —— 精确值

# 上下文管理器临时修改精度
with getcontext() as ctx:
    ctx.prec = 6
    result = Decimal('1') / Decimal('3')
    print(result)    # 0.333333
```

**Fraction 分数类型**：

```python
from fractions import Fraction

# 精确的分数运算
a = Fraction(1, 3)    # 1/3
b = Fraction(2, 3)    # 2/3
print(a + b)           # 1（精确结果，不是 0.999...）

# 从浮点数创建（可能不是你期望的）
print(Fraction(0.1))          # 3602879701896397/36028797018963968
print(Fraction('0.1'))        # 1/10 —— 用字符串更精确

# 自动约分
print(Fraction(6, 4))         # 3/2

# 分数与浮点数互转
print(float(Fraction(1, 3)))  # 0.3333333333333333
```

> **面试真题**：为什么 `0.1 + 0.2 != 0.3`？如何在 Python 中进行精确的小数运算？
>
> **易错点**：① `Decimal(0.1)` 仍然会有精度问题，必须用 `Decimal('0.1')`；② `math.nan == math.nan` 返回 `False`，判断 nan 必须用 `math.isnan()`；③ 布尔值参与算术运算虽然合法，但代码可读性极差。

![Python numeric types hierarchy diagram showing int float complex bool Decimal relationships, clean technical illustration, orange theme](https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Python%20numeric%20types%20hierarchy%20diagram%20showing%20int%20float%20complex%20bool%20Decimal%20relationships%2C%20clean%20technical%20illustration%2C%20orange%20theme&image_size=landscape_16_9)

### 3.2 序列类型

#### 字符串 `str`（不可变）

```python
s = "Hello, Python!"

# 索引与切片
print(s[0])       # 'H'
print(s[-1])      # '!'
print(s[7:13])    # 'Python'（左闭右开）
print(s[::2])     # 'Hlo yhn'（步长为 2）
print(s[::-1])    # '!nohtyP ,olleH'（反转字符串）

# f-string（3.6+，最推荐的格式化方式）
name = "Alice"
age = 30
print(f"姓名: {name}, 年龄: {age}, 明年: {age + 1}")
# 表达式内联、自动调用 __format__，性能也优于 % 和 format()

# 多行字符串与原始字符串
query = """
SELECT id, name
FROM users
WHERE age > %s
"""
path = r"C:\Users\name\file.txt"   # r 前缀：原始字符串，不转义
```

**字符串切片可视化**：

```
字符串: H  e  l  l  o  ,     P  y  t  h  o  n  !
正索引: 0  1  2  3  4  5  6  7  8  9 10 11 12 13
负索引:-14-13-12-11-10 -9 -8 -7 -6 -5 -4 -3 -2 -1

s[7:13]  →  ┌───────────────┐
             │ P  y  t  h  o  n │
             └───────────────┘

s[::2]   →  H . l . o .   . P . t . o . !
             ↑     ↑     ↑     ↑     ↑     ↑     ↑

s[::-1]  →  ! n o h t y P   , o l l e H   (反转)
```

**切片通用公式**：`s[start:stop:step]`

```python
# 切片永远返回新对象，不会修改原字符串
s = "Hello, Python!"
print(s[3:8])       # 'lo, P'
print(s[-6:])       # 'ython!'
print(s[:5])        # 'Hello'
print(s[5:])        # ', Python!'

# 步长为负数时，默认从右到左
print(s[::-1])      # '!nohtyP ,olleH'（完整反转）
print(s[::-2])      # '!otP olH'（隔一个取一个，从右向左）

# 切片越界不报错（与索引不同！）
print(s[100:])      # ''（空字符串，不报 IndexError）
print(s[:100])      # 'Hello, Python!'（不报错）
# print(s[100])     # IndexError！（直接索引访问越界会报错）
```

**字符串编码与解码详解**：

```python
# encode: str → bytes（编码）
text = "你好，世界"
b = text.encode("utf-8")     # b'\xe4\xbd\xa0\xe5\xa5\xbd\xef\xbc\x8c\xe4\xb8\x96\xe7\x95\x8c'
print(len(b))                 # 15（UTF-8 中每个中文约 3 字节）

b_gbk = text.encode("gbk")   # GBK 编码，每个中文 2 字节
print(len(b_gbk))             # 8

# decode: bytes → str（解码）
decoded = b.decode("utf-8")   # '你好，世界'

# 编码错误处理
bad_bytes = b'\xff\xfe'       # 无效的 UTF-8 字节
# bad_bytes.decode("utf-8")   # UnicodeDecodeError

print(bad_bytes.decode("utf-8", errors="ignore"))   # ''（忽略错误字节）
print(bad_bytes.decode("utf-8", errors="replace"))   # '��'（替换为占位符）
print(bad_bytes.decode("utf-8", errors="backslashreplace"))  # '\\xff\\xfe'

# 常用编码格式
# UTF-8: 可变长度（1-4字节），互联网标准，推荐使用
# GBK: 定长2字节（中文），中文 Windows 常用
# ASCII: 1字节，仅支持英文

# chardet 自动检测编码（需安装：pip install chardet）
# import chardet
# result = chardet.detect(b'\xc4\xe3\xba\xc3')
# print(result)  # {'encoding': 'GB2312', 'confidence': 0.99, ...}
```

> **面试真题**：Python 中字符串的切片和索引有什么区别？切片越界会怎样？字符串编码和解码的过程是什么？
>
> **易错点**：① 切片越界不报错但索引越界报 `IndexError`；② `s[::-1]` 不是原地修改，而是返回新字符串；③ 编码和解码方向搞反——`str.encode()` 得到 bytes，`bytes.decode()` 得到 str。

![Python string slicing visualization with index positions shown above and below a string, highlighting slice ranges with colored boxes, red theme](https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Python%20string%20slicing%20visualization%20with%20index%20positions%20shown%20above%20and%20below%20a%20string%2C%20highlighting%20slice%20ranges%20with%20colored%20boxes%2C%20red%20theme&image_size=landscape_16_9)

#### `bytes` 与 `bytearray`（二进制序列）

```python
# bytes —— 不可变的字节序列
b = b"hello"                    # 字面量
b = bytes([104, 101, 108, 108, 111])  # 从列表构造
b = "hello".encode("utf-8")     # 从字符串编码
print(b[0])                     # 104（整数！不是字节对象）

# bytearray —— 可变的字节序列
ba = bytearray(b"hello")
ba[0] = 104                     # 支持原地修改
ba.append(33)                   # 追加
print(ba)                       # bytearray(b'hello!')

# 工程场景：处理二进制协议、文件读写、网络传输
# 差异对照：
# | 特性 | bytes | bytearray |
# |------|-------|-----------|
# | 可变性 | 不可变 | 可变 |
# | 哈希able | 是 | 否 |
# | 适用场景 | 常量数据、dict 键 | 需要修改的缓冲区 |
```

#### 列表 `list`（可变，有序）

```python
# 列表推导式（List Comprehension）—— Pythonic 的核心标志
squares = [x**2 for x in range(10)]
evens = [x for x in range(10) if x % 2 == 0]

# 带条件的推导式
labels = ["even" if x % 2 == 0 else "odd" for x in range(5)]
# ['even', 'odd', 'even', 'odd', 'even']

# 嵌套推导式（扁平化矩阵）
matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
flat = [x for row in matrix for x in row]
# [1, 2, 3, 4, 5, 6, 7, 8, 9]
```

**列表 28 种常用方法速查**：

| 类别 | 方法 | 说明 | 时间复杂度 |
|------|------|------|-----------|
| **添加** | `append(x)` | 尾部追加 | O(1)均摊 |
| | `extend(iter)` | 追加可迭代对象 | O(k) |
| | `insert(i, x)` | 指定位置插入 | O(n) |
| **删除** | `remove(x)` | 删除第一个值为 x 的元素 | O(n) |
| | `pop()` | 弹出最后一个元素 | O(1) |
| | `pop(i)` | 弹出指定位置元素 | O(n) |
| | `clear()` | 清空列表 | O(1) |
| **查找** | `index(x)` | 返回 x 的索引 | O(n) |
| | `count(x)` | 统计 x 出现次数 | O(n) |
| | `x in lst` | 成员检测 | O(n) |
| **排序** | `sort()` | 原地排序 | O(n log n) |
| | `reverse()` | 原地反转 | O(n) |
| **复制** | `copy()` | 浅拷贝 | O(n) |
| **其他** | `len(lst)` | 长度 | O(1) |
| | `lst[i]` | 索引访问 | O(1) |
| | `lst[i] = x` | 索引赋值 | O(1) |
| | `lst + lst2` | 拼接（返回新列表） | O(n+m) |
| | `lst * n` | 重复（注意嵌套陷阱！） | O(n*k) |

```python
# 列表重复的陷阱
a = [[0]] * 3     # [[0], [0], [0]]
a[0][0] = 1       # [[1], [1], [1]] —— 三个子列表是同一个对象！

# 正确的二维列表创建方式
a = [[0] for _ in range(3)]   # [[0], [0], [0]]
a[0][0] = 1                    # [[1], [0], [0]] —— 互不影响

# sort() 的高级用法
data = [("Alice", 30), ("Bob", 25), ("Charlie", 35)]
data.sort(key=lambda x: x[1])              # 按年龄排序
data.sort(key=lambda x: x[1], reverse=True) # 降序

# 稳定排序：多次排序
employees = [
    {"name": "Alice", "dept": "Engineering", "salary": 120000},
    {"name": "Bob", "dept": "Engineering", "salary": 110000},
    {"name": "Charlie", "dept": "Sales", "salary": 90000},
]
# 先按薪水排序，再按部门排序 → 最终以部门为主要排序
employees.sort(key=lambda x: x["salary"])      # 第一排序键
employees.sort(key=lambda x: x["dept"])         # 第二排序键（稳定排序保证前面的相对顺序）
```

**常见操作时间复杂度（面试常考）**：
- 索引访问 `lst[i]`：O(1)
- 尾部追加 `append()`：均摊 O(1)
- 任意位置插入 `insert(i, x)`：O(n)
- 查找 `x in lst`：O(n)
- 排序 `sort()`：O(n log n)

**深浅拷贝（面试高频）**：

```python
import copy
original = [[1, 2], [3, 4]]
shallow = original.copy()          # 或 list(original) / original[:]
deep = copy.deepcopy(original)

original[0][0] = 99
print(shallow)   # [[99, 2], [3, 4]] —— 内层对象共享引用
print(deep)      # [[1, 2], [3, 4]] —— 完全独立副本
```

**深浅拷贝内存模型对比**：

```
浅拷贝 (shallow copy):
  original ──→ [ ┌──┐ , ┌──┐ ]
               │  │   │  │
  shallow  ──→ [ └│┘   └│┘ ]    ← 外层列表是新的，但内层对象共享！
                │      │
                ↓      ↓
              [99,2]  [3,4]      ← 修改 original[0][0] 会影响 shallow

深拷贝 (deep copy):
  original ──→ [ ┌──┐ , ┌──┐ ]
                ↓      ↓
              [99,2]  [3,4]      ← 原始对象

  deep     ──→ [ ┌──┐ , ┌──┐ ]  ← 完全独立的新列表
                ↓      ↓
              [1,2]   [3,4]      ← 内层对象也被递归复制，互不影响
```

三种浅拷贝方式的区别：
```python
lst = [1, [2, 3], 4]

# 方式1：list.copy()
c1 = lst.copy()

# 方式2：list()
c2 = list(lst)

# 方式3：切片
c3 = lst[:]

# 三种方式效果完全相同：创建新的外层列表，内层对象共享引用
# 注意：lst * 1 也是浅拷贝
```

> **面试真题**：Python 中深拷贝和浅拷贝有什么区别？`list.copy()` 是深拷贝还是浅拷贝？如何实现一个真正的深拷贝？
>
> **易错点**：① `list.copy()` / `list()` / `lst[:]` 都是浅拷贝；② `[[0]] * 3` 三个子列表是同一个对象；③ `copy.deepcopy()` 会递归复制所有嵌套对象，但无法拷贝自定义对象的内部状态（如文件句柄、数据库连接）。

![Python deep copy vs shallow copy memory diagram showing reference sharing, two comparison diagrams side by side, teal color scheme](https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Python%20deep%20copy%20vs%20shallow%20copy%20memory%20diagram%20showing%20reference%20sharing%2C%20two%20comparison%20diagrams%20side%20by%20side%2C%20teal%20color%20scheme&image_size=landscape_16_9)

#### 元组 `tuple`（不可变，有序）

```python
# 元组的"不可变"指的是引用不可变，但引用的对象可变
t = (1, [2, 3], 4)
# t[0] = 10     # TypeError
# t[1] = [5, 6] # TypeError
t[1].append(4)   # 合法！t 变为 (1, [2, 3, 4], 4)

# 元组解包 —— 优雅地处理多返回值
coord = (120.5, 30.2)
lng, lat = coord

# 扩展解包（3.0+）
first, *middle, last = [1, 2, 3, 4, 5]
print(middle)    # [2, 3, 4]

# 单元素元组（注意逗号！）
single = (42,)   # (42,) 是元组
not_tuple = (42) # 42 是整数，括号被当作数学优先级
```

**元组作为 dict 键的优势**：

```python
# 元组是不可变的（前提是内部元素也 immutable），因此可以作为字典的键
location_data = {
    (35.6762, 139.6503): "东京",
    (39.9042, 116.4074): "北京",
    (40.7128, -74.0060): "纽约",
}

# 列表不能作为字典的键（因为列表可变，不可哈希）
# key = [1, 2]   # TypeError: unhashable type: 'list'

# 注意：元组内含可变对象时也不能作为键
# bad_key = (1, [2, 3])  # TypeError: unhashable type: 'list'
```

**namedtuple 用法**：

```python
from collections import namedtuple

# 定义命名元组
Point = namedtuple('Point', ['x', 'y'])
p = Point(x=3, y=4)
print(p.x, p.y)          # 3 4
print(p[0], p[1])        # 3 4（仍支持索引访问）
x, y = p                  # 支持解包

# 命名元组比普通元组可读性更好
# 普通元组：point = (3, 4)，需要记住位置含义
# 命名元组：point.x, point.y，自文档化

# 命名元组是不可变的
# p.x = 10  # AttributeError

# _make 从可迭代对象创建
coords = [1, 2, 3, 4]
Point = namedtuple('Point', ['x', 'y', 'z', 'w'])
p = Point._make(coords)

# _asdict 转为字典
print(p._asdict())        # OrderedDict([('x', 1), ('y', 2), ('z', 3), ('w', 4)])

# _replace 创建新实例（因为不可变，只能"替换"生成新对象）
p2 = p._replace(x=10)
print(p2)                 # Point(x=10, y=2, z=3, w=4)

# Python 3.7+ 还可以用 typing.NamedTuple（支持类型提示）
from typing import NamedTuple

class Employee(NamedTuple):
    name: str
    age: int
    department: str = "Engineering"  # 支持默认值

emp = Employee("Alice", 30)
print(emp.name, emp.department)   # Alice Engineering
```

#### `range` 深入理解

`range` 是 Python 中常被低估的序列类型，它不只是 for 循环的辅助工具。

```python
# range 是惰性序列，不存储所有元素
r = range(0, 10, 2)
print(type(r))          # <class 'range'>
print(list(r))          # [0, 2, 4, 6, 8]
print(len(r))           # 5
print(r[3])             # 6（支持索引访问！）
print(r.index(4))       # 2（支持查找）
print(r.count(2))       # 1

# 内存优势：range(1000000) 只占约 48 字节，无论范围多大
import sys
print(sys.getsizeof(range(1000000)))       # 48
print(sys.getsizeof(list(range(1000000)))) # 约 8MB

# 底层原理：range 存储 (start, stop, step) 三元组，通过公式计算值
# 值 = start + index * step

# 工程场景：大范围遍历、检查某个数是否在范围内
# 检查性能：in 操作是 O(1)
print(500000 in range(1000000))   # True，瞬间返回
```

### 3.3 哈希类数据结构

#### 字典 `dict`（3.7+ 有序，键必须可哈希）

```python
# 字典推导式
word_lengths = {word: len(word) for word in ["apple", "banana", "cherry"]}

# get() 避免 KeyError
counts = {"a": 1}
print(counts.get("b", 0))   # 0，不报错

# setdefault() 与 defaultdict 的对比
# 笨方法：
if "b" not in counts:
    counts["b"] = []
counts["b"].append(2)

# 优雅方法（但 setdefault 可读性一般）
counts.setdefault("c", []).append(3)

# 最优雅：collections.defaultdict
from collections import defaultdict
d = defaultdict(list)
d["d"].append(4)   # 自动创建空列表

# 合并字典（3.9+）
d1 = {"a": 1, "b": 2}
d2 = {"b": 3, "c": 4}
merged = d1 | d2    # {'a': 1, 'b': 3, 'c': 4} —— d2 覆盖 d1 的同名键
```

**dict 底层哈希表实现原理**：

```
哈希表（Hash Table）内部结构：

┌─────────────────────────────────────────────┐
│ 哈希函数 hash(key) → 索引位置                │
│                                              │
│ Bucket Array（桶数组）:                       │
│  ┌───┬──────────────────┬──────────────┐    │
│  │ 0 │   (空)            │              │    │
│  ├───┼──────────────────┼──────────────┤    │
│  │ 1 │ hash=...  key='name' val='Alice'│    │
│  ├───┼──────────────────┼──────────────┤    │
│  │ 2 │   (空)            │              │    │
│  ├───┼──────────────────┼──────────────┤    │
│  │ 3 │ hash=...  key='age'  val=30     │    │
│  ├───┼──────────────────┼──────────────┤    │
│  │ 4 │ (碰撞→指向下一位置)              │    │
│  └───┴──────────────────┴──────────────┘    │
│                                              │
│ 查找流程:                                    │
│ 1. hash(key) → 计算哈希值                    │
│ 2. hash % len(table) → 定位桶索引            │
│ 3. 比较键是否相等 → 找到或继续探查            │
│ 4. 负载因子 > 2/3 时扩容（重新哈希）          │
└─────────────────────────────────────────────┘
```

```python
# 哈希表的键要求
# 1. 可哈希（hashable）：实现了 __hash__ 和 __eq__
# 2. 不可变类型：int, float, str, tuple（内部元素也需可哈希）, frozenset, bool, None
# 3. 不可哈希：list, dict, set, bytearray

# 查看对象的哈希值
print(hash("name"))     # 整数
print(hash(42))         # 42
print(hash((1, 2)))     # 整数
# hash([1, 2])          # TypeError: unhashable type: 'list'

# 自定义对象默认可哈希（基于 id），但定义了 __eq__ 后需同时定义 __hash__
class Person:
    def __init__(self, name):
        self.name = name
    def __eq__(self, other):
        return self.name == other.name
    def __hash__(self):
        return hash(self.name)  # 必须！否则变为不可哈希
```

**dict vs list 性能对比数据**：

| 操作 | dict 时间复杂度 | list 时间复杂度 | 倍率 |
|------|---------------|----------------|------|
| 查找 `x in obj` | O(1) | O(n) | dict 快约 100-10000 倍 |
| 插入 `obj[k] = v` | O(1)均摊 | `append` O(1), `insert(i,v)` O(n) | dict 更稳定 |
| 删除 `del obj[k]` | O(1) | O(n) | dict 快得多 |
| 遍历 | O(n) | O(n) | 相同 |
| 内存占用 | 较大（哈希表开销） | 较小 | list 更省内存 |

```python
# 实际性能测试
import timeit

# 在 100000 个元素中查找
setup_dict = "d = {i: i*2 for i in range(100000)}"
setup_list = "l = list(range(100000))"

dict_time = timeit.timeit("50000 in d", setup=setup_dict, number=10000)
list_time = timeit.timeit("50000 in l", setup=setup_list, number=10000)

print(f"dict 查找: {dict_time:.4f}s")   # 约 0.001s
print(f"list 查找: {list_time:.4f}s")   # 约 3-5s
# dict 快约 3000-5000 倍！
```

**高级字典类型**：

```python
# OrderedDict —— 有序字典（3.7 之前 dict 无序时的选择，现仍有特殊用途）
from collections import OrderedDict
od = OrderedDict()
od['z'] = 1
od['a'] = 2
od['m'] = 3
print(od)                    # OrderedDict([('z', 1), ('a', 2), ('m', 3)])
print(od.popitem(last=True)) # ('m', 3) —— 弹出最后插入的
print(od.popitem(last=False))# ('z', 1) —— 弹出最先插入的（FIFO）
# 按插入顺序移动到末尾
od['a'] = 2                  # 不移动位置
od.move_to_end('a')          # 移到末尾

# ChainMap —— 多字典链式查找
from collections import ChainMap
defaults = {"theme": "dark", "lang": "en", "debug": False}
user_config = {"theme": "light", "lang": "zh"}
env_config = {"debug": True}

config = ChainMap(env_config, user_config, defaults)
print(config["theme"])    # "light"（从 user_config 中找到）
print(config["debug"])    # True（从 env_config 中找到）
print(config["lang"])     # "zh"（从 user_config 中找到）
# 查找顺序：从左到右，第一个找到的为准

# Counter —— 计数器
from collections import Counter
words = ["apple", "banana", "apple", "cherry", "banana", "apple"]
word_counts = Counter(words)
print(word_counts)                    # Counter({'apple': 3, 'banana': 2, 'cherry': 1})
print(word_counts.most_common(2))     # [('apple', 3), ('banana', 2)]

# Counter 运算
c1 = Counter("aabbc")
c2 = Counter("abccc")
print(c1 + c2)     # Counter({'c': 4, 'a': 3, 'b': 3})  —— 加法
print(c1 - c2)     # Counter({'a': 1})                    —— 减法（只保留正数）
print(c1 & c2)     # Counter({'a': 1, 'b': 1, 'c': 1})  —— 交集（取最小）
print(c1 | c2)     # Counter({'a': 2, 'b': 2, 'c': 3})  —— 并集（取最大）
```

> **面试真题**：Python 字典的底层实现原理是什么？为什么字典的键必须是可哈希的？dict 和 list 在查找性能上差多少？
>
> **易错点**：① Python 3.7+ 的 dict 是有序的（按插入顺序），但不要将 dict 当作有序数据结构使用，`OrderedDict` 才有 `move_to_end`、`popitem(last=False)` 等有序操作；② 自定义类定义了 `__eq__` 后不定义 `__hash__` 会使实例变为不可哈希。

![Python dictionary hash table internal structure diagram showing key-value pairs with hash function and bucket array, technical illustration, blue theme](https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Python%20dictionary%20hash%20table%20internal%20structure%20diagram%20showing%20key-value%20pairs%20with%20hash%20function%20and%20bucket%20array%2C%20technical%20illustration%2C%20blue%20theme&image_size=landscape_16_9)

#### 集合 `set`（可变）与 `frozenset`（不可变）

```python
a = {1, 2, 3, 3, 3}   # {1, 2, 3}，自动去重
b = {3, 4, 5}

# 集合运算（代码比数学公式还简洁）
print(a | b)     # 并集：{1, 2, 3, 4, 5}
print(a & b)     # 交集：{3}
print(a - b)     # 差集：{1, 2}
print(a ^ b)     # 对称差集：{1, 2, 4, 5}

# 典型应用场景：去重与成员检测
users_seen = set()
for user_id in stream:
    if user_id in users_seen:      # O(1)，远快于列表的 O(n)
        continue
    users_seen.add(user_id)
    process(user_id)

# frozenset —— 不可变集合，可作为 dict 的键
fs = frozenset([1, 2, 3])
d = {fs: "hello"}    # 合法！
```

### 3.4 特殊类型

```python
# None —— 表示"无"的单例对象
result = None
print(result is None)    # True（用 is 判断，不要用 ==）

# 函数默认参数的陷阱（经典面试题）
def append_item(item, lst=[]):
    lst.append(item)
    return lst

print(append_item(1))   # [1]
print(append_item(2))   # [1, 2] —— 惊喜！默认参数在定义时求值，lst 被共享了

# 正确写法
def append_item_safe(item, lst=None):
    if lst is None:
        lst = []
    lst.append(item)
    return lst

# Ellipsis —— 省略号对象，NumPy 中用于切片，类型提示中表示可变长度元组
from typing import Tuple
def process(items: Tuple[int, ...]) -> None:
    ...                    # pass 的占位符，常用于 stub 文件

# memoryview —— 内存视图（零拷贝访问内存）
# 在不复制数据的情况下，以不同方式查看底层内存
data = bytearray(b"hello world")
mv = memoryview(data)
print(mv[0])              # 104（访问第一个字节）
mv[0] = 72                # 修改内存视图会反映到原数据
print(data)               # bytearray(b'Hello world')

# 切片不复制数据，返回新视图
slice_view = mv[6:11]
print(slice_view.tobytes())   # b'world'

# 工程场景：大文件处理、网络包解析、NumPy 数组操作
# 性能优势：避免大量数据复制
```

**Enum 枚举类型**：

```python
from enum import Enum, auto, IntEnum, Flag, IntFlag

# 基本枚举
class Color(Enum):
    RED = 1
    GREEN = 2
    BLUE = 3

print(Color.RED)              # Color.RED
print(Color.RED.value)        # 1
print(Color(1))               # Color.RED（通过值查找）
print(Color['RED'])           # Color.RED（通过名称查找）

# auto() 自动分配值
class Status(Enum):
    PENDING = auto()
    PROCESSING = auto()
    DONE = auto()

# IntEnum —— 可与整数比较
class Priority(IntEnum):
    LOW = 1
    MEDIUM = 2
    HIGH = 3

print(Priority.HIGH > Priority.LOW)   # True
print(Priority.HIGH == 3)             # True（IntEnum 支持与 int 比较）

# Flag / IntFlag —— 支持位运算的组合枚举
class Permission(Flag):
    READ = auto()       # 1
    WRITE = auto()      # 2
    EXECUTE = auto()    # 4

perm = Permission.READ | Permission.WRITE
print(perm)                         # Permission.READ|WRITE
print(Permission.READ in perm)      # True
```

**dataclass 数据类**（Python 3.7+）：

```python
from dataclasses import dataclass, field, asdict, astuple

@dataclass
class User:
    name: str
    age: int
    email: str = ""                      # 默认值
    tags: list[str] = field(default_factory=list)  # 可变默认值必须用 field
    id: int = field(init=False, repr=False)  # 不参与 __init__，不显示在 repr 中

    def __post_init__(self):
        """初始化后自动调用"""
        self.id = hash(self.name)

user = User("Alice", 30, tags=["admin"])
print(user)                   # User(name='Alice', age=30, email='', tags=['admin'])
print(asdict(user))           # {'name': 'Alice', 'age': 30, 'email': '', 'tags': ['admin'], 'id': ...}
print(astuple(user))          # ('Alice', 30, '', ['admin'], ...)

# frozen=True 使实例不可变（可哈希，可作为 dict 键）
@dataclass(frozen=True)
class Point:
    x: float
    y: float

p = Point(1.0, 2.0)
# p.x = 3.0  # FrozenInstanceError
print(hash(p))   # 可哈希！
```

**typing 常用类型提示**：

```python
from typing import (
    Optional, Union, Literal, TypeAlias,
    Callable, Iterable, Sequence, Mapping,
    TypeVar, Generic, Protocol, Any, Never,
)

# Optional —— 可选类型（等价于 Union[T, None]）
def find_user(user_id: int) -> Optional[dict]:
    ...  # 返回 dict 或 None

# Union —— 联合类型
def process(value: Union[str, int, float]) -> str:
    ...  # 接受 str/int/float

# Python 3.10+ 可用 | 语法
def process(value: str | int | float) -> str:
    ...

# Literal —— 字面量类型
def set_mode(mode: Literal["train", "eval", "test"]) -> None:
    ...  # 只接受这三个字符串

# TypeAlias —— 类型别名
Vector: TypeAlias = list[float]  # Python 3.12+ 可用 type Vector = list[float]

# Callable —— 可调用对象
def apply(func: Callable[[int, int], int], a: int, b: int) -> int:
    return func(a, b)

# 泛型
T = TypeVar('T')
def first(items: list[T]) -> T:
    return items[0]

# Protocol —— 结构化子类型（鸭子类型的类型提示版）
class Drawable(Protocol):
    def draw(self) -> None: ...

def render(obj: Drawable) -> None:
    obj.draw()  # 任何有 draw() 方法的对象都满足
```

> **面试真题**：Python 的 `@dataclass` 和普通 `class` 有什么区别？`Enum` 和普通常量相比有什么优势？
>
> **易错点**：① dataclass 中可变默认值必须使用 `field(default_factory=list)`，不能直接写 `tags: list = []`；② `Enum` 成员是单例，比较用 `is` 而非 `==`（虽然 `==` 也能用）；③ `Optional[T]` 不等于 `T | None`（Python 3.10 以下），但语义相同。

---

## 4. 运算符与表达式

### 4.1 运算符分类

| 类别 | 运算符 | 要点 |
|------|--------|------|
| 算术 | `+ - * / // % **` | `//` 是向下取整除法，`-3 // 2 == -2` |
| 比较 | `== != > < >= <=` | 可链式比较：`1 < x < 10` |
| 赋值 | `= += -= *= /=` | 没有 `++` / `--` |
| 逻辑 | `and or not` | 短路求值，返回最后一个求值的操作数 |
| 位运算 | `& \| ^ ~ << >>` | 直接操作二进制位，效率优化场景使用 |
| 成员 | `in not in` | 字典判断键：`"key" in dict_obj` |
| 身份 | `is is not` | 判断同一对象，不要用于值比较 |

**整除运算的数学原理**：

```python
# Python 的 // 是向下取整（floor division），而非截断取整
print(7 // 2)     # 3（正数：向下取整 = 截断取整）
print(-7 // 2)    # -4（负数：向下取整 ≠ 截断取整！）
# 数学：-7 / 2 = -3.5，向下取整为 -4
# C/Java 截断取整：-7 / 2 = -3

# divmod 同时获取商和余数
print(divmod(7, 2))     # (3, 1)
print(divmod(-7, 2))    # (-4, 1)  ← 余数始终与除数同号
# 验证：商 * 除数 + 余数 = 被除数 → -4 * 2 + 1 = -7 ✓

# % 取模运算也是向下取整配套的
print(-7 % 2)    # 1（不是 -1！）
print(7 % -2)    # -1
# 规则：a % b 的符号与 b 相同
```

**位运算实战技巧**：

```python
# 1. 权限控制（Linux 文件权限模型）
READ = 0b100     # 4
WRITE = 0b010    # 2
EXECUTE = 0b001  # 1

# 组合权限
user_perm = READ | WRITE          # 0b110 = 6
admin_perm = READ | WRITE | EXECUTE  # 0b111 = 7

# 检查权限
print(bool(user_perm & READ))     # True（有读权限）
print(bool(user_perm & EXECUTE))  # False（无执行权限）

# 添加/移除权限
user_perm |= EXECUTE              # 添加执行权限
user_perm &= ~WRITE               # 移除写权限

# 2. 颜色计算（RGB 值）
def rgb_to_hex(r, g, b):
    return (r << 16) | (g << 8) | b

def hex_to_rgb(hex_color):
    r = (hex_color >> 16) & 0xFF
    g = (hex_color >> 8) & 0xFF
    b = hex_color & 0xFF
    return r, g, b

print(hex(rgb_to_hex(255, 128, 0)))    # '0xff8000'
print(hex_to_rgb(0xff8000))             # (255, 128, 0)

# 3. 快速乘除 2 的幂
print(5 << 3)    # 40（5 * 2^3 = 40）
print(40 >> 3)   # 5（40 / 2^3 = 5）

# 4. 交换两个数（不用临时变量）
a, b = 10, 20
a ^= b; b ^= a; a ^= b
print(a, b)  # 20 10
# 实际开发中用 a, b = b, a 更 Pythonic
```

> **面试真题**：Python 中 `-7 // 2` 的结果是什么？和 C 语言的结果一样吗？位运算如何实现权限控制？
>
> **易错点**：① Python 的 `//` 是向下取整，负数结果与 C/Java 不同；② `%` 取模的结果符号与除数相同，不是与被除数相同；③ `~x = -(x+1)`，而不是简单的按位取反加 1（那是补码视角）。

### 4.2 逻辑运算符的短路特性

```python
# and：若左操作数为 False，直接返回左操作数；否则返回右操作数
result = 0 and 999      # 0
result = 5 and 999      # 999

# or：若左操作数为 True，直接返回左操作数；否则返回右操作数
result = 5 or 999       # 5
result = 0 or 999       # 999

# 实战：默认值设置
greeting = user_input or "Hello"   # 若 user_input 为假值（空串/None），使用默认值

# 三目运算符（条件表达式）
status = "adult" if age >= 18 else "minor"
```

**短路求值的更多实战案例**：

```python
# 1. 安全访问属性（避免 AttributeError）
# 假设 obj 可能为 None
result = obj and obj.method()   # 如果 obj 为 None，短路返回 None

# 2. 条件执行函数
debug and print("调试信息")     # debug 为 False 时不执行 print

# 3. 链式默认值
config = env_value or default_value or "fallback"

# 4. 安全的列表访问
# 避免 IndexError
item = len(lst) > 0 and lst[0] or None
# 更 Pythonic 的写法：
item = lst[0] if lst else None

# 5. 数据库查询中的常见模式
user = db.get_user(id) or db.create_guest_user()
```

**and/or 实现三元运算**：

```python
# 传统 if-else
result = value_if_true if condition else value_if_false

# 使用 and/or 模拟（不推荐，了解即可）
result = condition and value_if_true or value_if_false
# ⚠️ 陷阱：当 value_if_true 为假值（0, '', None）时，结果错误！
print(True and 0 or "fallback")   # "fallback" —— 不是 0！

# 正确的三元运算始终用 if-else 语法
result = 0 if True else "fallback"  # 0 —— 正确
```

> **面试真题**：Python 中 `and` 和 `or` 的返回值是什么？如何利用短路求值实现默认值？
>
> **易错点**：① `and` 和 `or` 返回的不是 `True/False`，而是最后一个求值的操作数；② `condition and value or fallback` 在 `value` 为假值时会出错，不要用这种方式替代三元运算符；③ `not` 返回的是 `True/False`，与 `and/or` 行为不同。

### 4.3 海象运算符 `:=`（3.8+）

在表达式内部进行赋值，减少重复计算：

```python
# 传统写法
match = pattern.search(data)
if match:
    print(match.group(1))

# 海象运算符
if match := pattern.search(data):
    print(match.group(1))

# while 循环中读取直到空
while (line := file.readline().strip()):
    process(line)
```

**海象运算符的更多使用场景**：

```python
# 1. 列表推导式中避免重复计算
# 不使用海象运算符：计算两次
results = [expensive_computation(x) for x in data if expensive_computation(x) > threshold]

# 使用海象运算符：只计算一次
results = [y for x in data if (y := expensive_computation(x)) > threshold]

# 2. while 循环中的缓冲区读取
while (chunk := response.read(8192)):
    process(chunk)

# 3. 条件语句中的复杂计算
if (n := len(data)) > 10:
    print(f"数据量过大: {n} 条记录")

# 4. 三元表达式中复用计算结果
discount = 0.1 if (total := sum(prices)) > 1000 else 0
print(f"总价: {total}, 折扣: {discount}")

# 5. any/all 中的值捕获
if any((invalid := not is_valid(item)) for item in items):
    print(f"发现无效项: {invalid}")  # 注意：这里捕获的是最后一个值
```

**海象运算符的限制**：

```python
# ❌ 不能用于属性赋值
# obj.attr := value  # SyntaxError

# ❌ 不能用于简单赋值（没有意义）
# x := 10  # SyntaxError: cannot use assignment expressions with simple name

# ✅ 必须在表达式中使用
(x := 10)  # 加括号可以，但不推荐这样写

# ❌ 不能用于 f-string 中的简单表达式（3.8-3.11）
# Python 3.12+ 可以在 f-string 中使用
# print(f"{x := 10}")  # Python 3.12+ 才支持

# ⚠️ 可读性警告：不要过度使用海象运算符
# 简单场景用传统写法更清晰
```

> **面试真题**：海象运算符 `:=` 有什么用？在列表推导式中如何避免重复计算？
>
> **易错点**：① 海象运算符不能用于属性赋值（`obj.attr := val` 是语法错误）；② 过度使用会降低代码可读性；③ 在 `any()`/`all()` 中使用时，捕获的值是生成器中最后一个被计算的值，可能不是你期望的。

### 4.4 运算符优先级与运算符重载

**运算符优先级（常用优先级，从高到低）**：

| 优先级 | 运算符 |
|--------|--------|
| 最高 | `()`（括号） |
| 高 | `**` |
| 中 | `* / // % @` |
| 中 | `+ -` |
| 中 | `== != > < >= <=` |
| 低 | `not` |
| 低 | `and` |
| 最低 | `or` |

**工程建议**：不要依赖记忆优先级，复杂表达式用括号明确意图。

**运算符重载（魔术方法）简介**：

```python
class Vector:
    """二维向量，演示运算符重载"""

    def __init__(self, x, y):
        self.x = x
        self.y = y

    # + 运算符
    def __add__(self, other):
        return Vector(self.x + other.x, self.y + other.y)

    # - 运算符
    def __sub__(self, other):
        return Vector(self.x - other.x, self.y - other.y)

    # * 运算符（标量乘法）
    def __mul__(self, scalar):
        if isinstance(scalar, (int, float)):
            return Vector(self.x * scalar, self.y * scalar)
        return NotImplemented

    # == 运算符
    def __eq__(self, other):
        if not isinstance(other, Vector):
            return NotImplemented
        return self.x == other.x and self.y == other.y

    # < 运算符（按模长比较）
    def __lt__(self, other):
        return (self.x**2 + self.y**2) < (other.x**2 + other.y**2)

    # str() 和 repr()
    def __repr__(self):
        return f"Vector({self.x}, {self.y})"

    # len() 支持
    def __abs__(self):
        return (self.x**2 + self.y**2) ** 0.5

    # bool() 支持（模长为0则为False）
    def __bool__(self):
        return self.x != 0 or self.y != 0

v1 = Vector(3, 4)
v2 = Vector(1, 2)
print(v1 + v2)       # Vector(4, 6)
print(v1 * 3)        # Vector(9, 12)
print(v1 == v2)      # False
print(v1 > v2)       # True（模长 5 > 2.24）
print(abs(v1))        # 5.0
print(bool(v1))       # True
```

**常用运算符与对应魔术方法速查**：

| 运算符 | 魔术方法 | 说明 |
|--------|---------|------|
| `+` | `__add__`, `__radd__` | 加法 / 右侧加法 |
| `-` | `__sub__`, `__rsub__` | 减法 |
| `*` | `__mul__`, `__rmul__` | 乘法 |
| `//` | `__floordiv__` | 整除 |
| `**` | `__pow__` | 幂运算 |
| `==` | `__eq__` | 等于 |
| `<` | `__lt__` | 小于 |
| `<=` | `__le__` | 小于等于 |
| `in` | `__contains__` | 成员检测 |
| `len()` | `__len__` | 长度 |
| `str()` | `__str__` | 字符串表示 |
| `repr()` | `__repr__` | 开发者表示 |
| `bool()` | `__bool__` | 布尔转换 |
| `[]` | `__getitem__`, `__setitem__` | 索引访问/赋值 |
| `()` | `__call__` | 可调用对象 |

> **面试真题**：Python 如何实现运算符重载？`__eq__` 和 `__hash__` 的关系是什么？
>
> **易错点**：① 运算符重载方法返回 `NotImplemented`（不是 `NotImplementedError`！）表示不支持该操作，Python 会尝试反向方法；② 定义了 `__eq__` 后，`__hash__` 会被设为 `None`，实例变为不可哈希，需要同时定义。

---

## 5. 流程控制

### 5.1 条件语句

```python
score = 85

if score >= 90:
    grade = "A"
elif score >= 80:
    grade = "B"
elif score >= 60:
    grade = "C"
else:
    grade = "D"
```

**三元表达式嵌套的陷阱**：

```python
# 三元表达式（条件表达式）
grade = "A" if score >= 90 else "B" if score >= 80 else "C" if score >= 60 else "D"
# ⚠️ 虽然语法正确，但嵌套三元表达式极难阅读！
# 推荐拆分为 if-elif-else 或使用字典映射

# 更优雅的写法：字典映射替代 if-elif
grade_map = {
    "A": lambda s: s >= 90,
    "B": lambda s: s >= 80,
    "C": lambda s: s >= 60,
}
grade = next((g for g, cond in grade_map.items() if cond(score)), "D")

# 简化版：利用 bisect（适合连续区间）
import bisect
breakpoints = [60, 80, 90]
grades = ["D", "C", "B", "A"]
grade = grades[bisect.bisect_right(breakpoints, score)]

# 函数分派模式（替代冗长的 if-elif）
handlers = {
    "create": handle_create,
    "update": handle_update,
    "delete": handle_delete,
}
handler = handlers.get(action, handle_default)
handler(data)
```

**链式比较的妙用**：

```python
# Python 支持链式比较（其他语言不支持！）
x = 5
print(1 < x < 10)      # True
print(1 < x > 0)       # True
print(0 < x < 10 < 100) # True

# 等价展开
# 1 < x < 10 等价于 (1 < x) and (x < 10)
# 但链式写法中 x 只计算一次！

# 实用场景
age = 25
if 18 <= age <= 65:
    print("工作年龄")
```

**Python 没有 switch 语句**，但 3.10+ 提供了更强大的 `match / case`。

> **面试真题**：Python 中如何替代 switch/case？三元表达式嵌套有什么问题？
>
> **易错点**：① 嵌套三元表达式可读性极差，不要在生产代码中使用；② 字典映射模式要求所有分支返回相同类型；③ 链式比较 `a < b > c` 不是 `a < b and b > c and a > c`，而是 `a < b and b > c`。

### 5.2 循环语句

```python
# for 循环 —— 遍历可迭代对象
for i in range(5):           # 0, 1, 2, 3, 4
    print(i)

# enumerate —— 同时获取索引和值
for idx, value in enumerate(["a", "b", "c"], start=1):
    print(f"{idx}: {value}")

# zip —— 并行遍历多个序列
names = ["Alice", "Bob"]
ages = [25, 30]
for name, age in zip(names, ages):
    print(f"{name} is {age}")

# while 循环
n = 5
while n > 0:
    print(n)
    n -= 1
else:
    print("循环正常结束（未被 break）")

# break / continue / else 子句
for num in range(10):
    if num == 3:
        continue      # 跳过当前迭代
    if num == 7:
        break         # 终止循环
    print(num)
else:
    print("循环完整执行")   # 若被 break，else 不会执行
```

> **for-else 的实用场景**：在搜索场景下避免引入标志变量。

```python
# 搜索列表中是否存在素数（不用 flag 变量）
for n in [4, 6, 8, 9, 11, 12]:
    if is_prime(n):
        print(f"找到素数: {n}")
        break
else:
    print("没有找到素数")   # 循环未被 break 时才执行
```

**迭代器与可迭代对象的区别**：

```python
# 可迭代对象（Iterable）：实现了 __iter__() 方法
# 迭代器（Iterator）：同时实现了 __iter__() 和 __next__() 方法

# 可迭代对象 ≠ 迭代器
lst = [1, 2, 3]          # 可迭代对象
it = iter(lst)            # 调用 __iter__() 返回迭代器
print(type(it))           # <class 'list_iterator'>

print(next(it))           # 1 —— 调用 __next__()
print(next(it))           # 2
print(next(it))           # 3
# print(next(it))         # StopIteration —— 迭代耗尽

# 迭代器是一次性的
print(list(it))           # [] —— 迭代器已耗尽！

# 字符串、列表、元组、字典、集合都是可迭代对象，但不是迭代器
# 文件对象、map、filter、zip 返回的是迭代器

# 判断是否可迭代 / 是否为迭代器
from collections.abc import Iterable, Iterator
print(isinstance(lst, Iterable))   # True
print(isinstance(lst, Iterator))   # False
print(isinstance(it, Iterator))    # True
```

**itertools 常用函数**：

```python
import itertools

# count —— 无限计数器
for i in itertools.count(start=1, step=2):
    if i > 10:
        break
    print(i)  # 1, 3, 5, 7, 9

# cycle —— 无限循环
# for item in itertools.cycle([1, 2, 3]):
#     ...  # 1, 2, 3, 1, 2, 3, ...（无限循环）

# repeat —— 重复
print(list(itertools.repeat("hello", 3)))  # ['hello', 'hello', 'hello']

# chain —— 链接多个可迭代对象
print(list(itertools.chain([1, 2], [3, 4], [5])))  # [1, 2, 3, 4, 5]

# islice —— 切片迭代器
print(list(itertools.islice(range(100), 5, 10)))  # [5, 6, 7, 8, 9]

# product —— 笛卡尔积
print(list(itertools.product([1, 2], ['a', 'b'])))
# [(1, 'a'), (1, 'b'), (2, 'a'), (2, 'b')]

# permutations —— 排列
print(list(itertools.permutations([1, 2, 3], 2)))
# [(1, 2), (1, 3), (2, 1), (2, 3), (3, 1), (3, 2)]

# combinations —— 组合
print(list(itertools.combinations([1, 2, 3, 4], 2)))
# [(1, 2), (1, 3), (1, 4), (2, 3), (2, 4), (3, 4)]

# groupby —— 分组（需要先排序！）
data = [("A", 1), ("A", 2), ("B", 3), ("B", 4)]
for key, group in itertools.groupby(data, key=lambda x: x[0]):
    print(key, list(group))
# A [('A', 1), ('A', 2)]
# B [('B', 3), ('B', 4)]

# accumulate —— 累积
print(list(itertools.accumulate([1, 2, 3, 4])))  # [1, 3, 6, 10]
print(list(itertools.accumulate([1, 2, 3, 4], initial=0)))  # [0, 1, 3, 6, 10]
```

**生成器表达式 vs 列表推导式性能对比**：

```python
import sys

# 列表推导式：一次性创建完整列表
list_comp = [x**2 for x in range(1000000)]
print(sys.getsizeof(list_comp))  # 约 8.4MB

# 生成器表达式：惰性求值，只存储当前元素
gen_expr = (x**2 for x in range(1000000))
print(sys.getsizeof(gen_expr))   # 约 200 字节！

# 性能对比
import timeit

# 列表推导式：需要先创建完整列表，再求和
list_time = timeit.timeit(
    "sum([x**2 for x in range(10000)])",
    number=1000
)

# 生成器表达式：惰性求值，逐个产生
gen_time = timeit.timeit(
    "sum(x**2 for x in range(10000))",
    number=1000
)

# 列表推导式通常稍快（避免生成器开销），但占用更多内存
# 内存敏感场景（大数据处理）优先用生成器表达式

# 选择原则：
# - 需要多次遍历 / 索引访问 → 列表推导式
# - 只遍历一次 / 数据量大 → 生成器表达式
# - 需要作为函数参数立即消费 → 生成器表达式
```

> **面试真题**：可迭代对象和迭代器有什么区别？生成器表达式和列表推导式在性能上有什么差异？
>
> **易错点**：① 迭代器是一次性的，遍历完后不能重用；② `zip` 在 Python 3 中返回迭代器，遍历一次后为空；③ 生成器表达式更省内存但不一定更快（生成器有函数调用开销）；④ `itertools.groupby` 要求输入已按分组键排序，否则会创建多个分组。

![Python control flow diagram showing if-elif-else for-else while-break-continue flowchart, clean technical illustration, dark blue theme](https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Python%20control%20flow%20diagram%20showing%20if-elif-else%20for-else%20while-break-continue%20flowchart%2C%20clean%20technical%20illustration%2C%20dark%20blue%20theme&image_size=landscape_16_9)

### 5.3 模式匹配 `match / case`（3.10+）

```python
def handle_command(command):
    match command:
        case ["load", filename]:
            print(f"加载文件: {filename}")
        case ["save", filename, *options]:
            print(f"保存文件: {filename}, 选项: {options}")
        case {"type": "error", "msg": message}:
            print(f"错误: {message}")
        case _:
            print("未知命令")

handle_command(["load", "data.txt"])
handle_command({"type": "error", "msg": "连接超时"})
```

`match` 支持：
- 序列解构（列表、元组）
- 映射解构（字典）
- 捕获变量、通配符 `_`
- 守卫子句（guard）：`case [x, y] if x == y:`

**更多模式匹配高级用法**：

```python
# 1. 类型匹配
def describe(value):
    match value:
        case int(n) if n > 0:
            return f"正整数: {n}"
        case int(n):
            return f"非正整数: {n}"
        case float(f):
            return f"浮点数: {f}"
        case str(s):
            return f"字符串: {s}"
        case [x, y]:
            return f"二元组: ({x}, {y})"
        case _:
            return f"其他类型: {type(value)}"

# 2. OR 模式（多模式匹配）
def is_vowel(char):
    match char.lower():
        case "a" | "e" | "i" | "o" | "u":
            return True
        case _:
            return False

# 3. 类匹配（需要 __match_args__ 或使用关键字参数）
class Point:
    __match_args__ = ("x", "y")
    def __init__(self, x, y):
        self.x = x
        self.y = y

def where_is(point):
    match point:
        case Point(x=0, y=0):
            return "原点"
        case Point(x=0):
            return "Y 轴上"
        case Point(y=0):
            return "X 轴上"
        case Point():
            return "其他位置"

# 4. 嵌套解构
def process_config(config):
    match config:
        case {"database": {"host": host, "port": port}, "debug": True}:
            print(f"调试模式连接: {host}:{port}")
        case {"database": {"host": host, "port": port}}:
            print(f"连接: {host}:{port}")
        case _:
            print("配置格式不正确")
```

**match/case 与 if-elif 的性能对比**：

```python
# match/case 的优势在于模式解构，而非性能
# 简单的条件判断，if-elif 性能相当甚至略优
# 复杂的模式解构，match/case 代码更清晰

# 性能测试
import timeit

# if-elif 版本
def classify_if(x):
    if x == 0: return "zero"
    elif x == 1: return "one"
    elif x == 2: return "two"
    else: return "other"

# match 版本
def classify_match(x):
    match x:
        case 0: return "zero"
        case 1: return "one"
        case 2: return "two"
        case _: return "other"

# 性能差异通常在 5% 以内，选择依据是可读性和表达力
# match/case 适合：复杂数据结构解构、类型匹配、OR 模式
# if-elif 适合：简单条件、范围判断、复杂布尔表达式
```

**工程建议**：`match` 适合处理复杂的数据结构模式，简单的条件判断仍用 `if/elif`。

> **面试真题**：Python 3.10 的 `match/case` 和 `if/elif` 有什么区别？match 支持哪些模式？
>
> **易错点**：① `case _:` 中的 `_` 是通配符，不是变量名，不会绑定值；② `case [x, y]` 匹配的是长度为 2 的序列，`case [x, y, *rest]` 匹配长度 ≥ 2 的序列；③ 类匹配需要 `__match_args__` 或使用关键字参数。

---

## 6. 输入输出基础

### 6.1 `print()` 深度用法

```python
# 自定义分隔符与结尾
print("2024", "07", "20", sep="-")        # 2024-07-20
print("Loading", end="")                    # 不换行
print(".", end="")

# 输出到文件
with open("log.txt", "w") as f:
    print("日志内容", file=f)

# 格式化输出（对齐与精度）
print(f"{'Product':<15} {'Price':>10}")
print(f"{'Apple':<15} {5.5:>10.2f}")
print(f"{'Banana':<15} {3.0:>10.2f}")
# Product               Price
# Apple                  5.50
# Banana                 3.00
```

**flush 参数详解**：

```python
# flush=False（默认）：输出到缓冲区，由系统决定何时刷新
# flush=True：立即刷新输出缓冲区

# 场景1：进度条（必须 flush）
import time
for i in range(10):
    print(f"\r进度: {'█' * (i+1)}{'░' * (9-i)} {(i+1)*10}%", end="", flush=True)
    time.sleep(0.5)

# 场景2：实时日志
import sys
print("开始处理...", flush=True)
# 长时间计算...
print("完成！")

# 场景3：管道输出时
# python script.py | grep "error"
# 需要 flush=True 确保输出及时被管道读取

# 缓冲模式
# - 交互终端：行缓冲（遇到换行自动刷新）
# - 管道/重定向：全缓冲（缓冲区满才刷新）
# - flush=True：无缓冲（立即刷新）
```

**logging 模块入门**：

```python
import logging

# 基本配置
logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
    filename="app.log",
    filemode="a",    # 追加模式
)

# 五个日志级别（从低到高）
logging.debug("调试信息，仅开发时可见")     # DEBUG
logging.info("常规信息，如启动/关闭")        # INFO
logging.warning("警告，可继续运行但需注意")  # WARNING
logging.error("错误，功能受影响")            # ERROR
logging.critical("严重错误，系统可能崩溃")   # CRITICAL

# 生产环境推荐配置
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)-8s] %(filename)s:%(lineno)d - %(message)s",
    handlers=[
        logging.FileHandler("app.log"),      # 输出到文件
        logging.StreamHandler(),              # 输出到控制台
    ],
)

# __name__ 作为 logger 名称，便于追踪
logger = logging.getLogger(__name__)
logger.info("模块初始化完成")

# 异常日志（自动包含堆栈跟踪）
try:
    risky_operation()
except Exception as e:
    logger.exception("操作失败")  # 自动打印完整堆栈
```

> **面试真题**：Python 的 `print()` 的 `flush` 参数有什么用？生产环境中应该用 `print` 还是 `logging`？
>
> **易错点**：① 在管道/重定向场景下，`print` 默认全缓冲，输出可能延迟；② 生产代码中不要用 `print` 做日志，应使用 `logging` 模块；③ `logging.basicConfig()` 只在第一次调用时生效，后续调用不会更新配置。

### 6.2 `input()` 与类型转换

```python
# input 始终返回字符串
age_str = input("请输入年龄: ")
age = int(age_str)       # 需手动转换，若输入非数字会抛出 ValueError

# 安全的输入处理
def get_int(prompt):
    while True:
        try:
            return int(input(prompt))
        except ValueError:
            print("请输入有效的整数！")

age = get_int("请输入年龄: ")
```

**argparse 命令行参数解析**：

```python
import argparse

def main():
    parser = argparse.ArgumentParser(description="数据处理工具")
    # 位置参数（必需）
    parser.add_argument("input_file", help="输入文件路径")

    # 可选参数
    parser.add_argument("-o", "--output", default="output.txt", help="输出文件路径")
    parser.add_argument("-v", "--verbose", action="store_true", help="详细输出模式")
    parser.add_argument("-n", "--count", type=int, default=10, help="处理数量")
    parser.add_argument("--mode", choices=["fast", "safe"], default="safe", help="处理模式")

    args = parser.parse_args()

    if args.verbose:
        print(f"输入: {args.input_file}")
        print(f"输出: {args.output}")
        print(f"模式: {args.mode}")

# 使用示例：
# python script.py data.txt -o result.txt -v --mode fast
# python script.py --help

if __name__ == "__main__":
    main()
```

**文件读写基础**：

```python
# 读取文件
# 方式1：一次性读取全部内容
with open("data.txt", "r", encoding="utf-8") as f:
    content = f.read()          # 读取全部内容为字符串

# 方式2：逐行读取（推荐，内存友好）
with open("data.txt", "r", encoding="utf-8") as f:
    for line in f:              # 文件对象本身是可迭代的
        process(line.strip())   # strip() 移除换行符

# 方式3：读取所有行为列表
with open("data.txt", "r", encoding="utf-8") as f:
    lines = f.readlines()       # ["line1\n", "line2\n", ...]

# 写入文件
with open("output.txt", "w", encoding="utf-8") as f:   # "w" 覆盖写入
    f.write("Hello, World!\n")
    f.writelines(["line1\n", "line2\n"])                # 写入多行

with open("output.txt", "a", encoding="utf-8") as f:   # "a" 追加写入
    f.write("追加的内容\n")

# 文件模式
# "r"  只读（默认）
# "w"  写入（覆盖）
# "a"  追加
# "x"  独占创建（文件已存在则报错）
# "b"  二进制模式（如 "rb", "wb"）
# "+"  读写模式（如 "r+", "w+"）

# 始终使用 with 语句！确保文件自动关闭
# 始终指定 encoding！避免跨平台编码问题
```

> **面试真题**：Python 读取大文件时应该用什么方式？`with` 语句的作用是什么？
>
> **易错点**：① `f.read()` 读取大文件会撑爆内存，应使用 `for line in f` 逐行读取；② 不指定 `encoding` 在 Windows 上默认用 GBK，Linux 上用 UTF-8，导致跨平台问题；③ `f.readlines()` 也会一次性读取全部内容，大文件慎用。

### 6.3 字符串格式化方式对比

| 方式 | 示例 | 推荐度 | 适用场景 |
|------|------|--------|----------|
| f-string | `f"Hello, {name}"` | ⭐⭐⭐ | 所有新代码 |
| `str.format()` | `"Hello, {}".format(name)` | ⭐⭐ | 动态模板、国际化 |
| `%` 格式化 | `"Hello, %s" % name` | ⭐ | 仅维护旧代码 |

```python
name = "Alice"
age = 30

# f-string（3.6+，性能最好、可读性最高）
print(f"{name} 今年 {age} 岁")
print(f"明年 {name} 就是 {age + 1} 岁了")
print(f"圆周率: {3.14159:.2f}")     # 3.14
print(f"二进制: {42:b}")            # 101010
print(f"千分位: {1234567:,}")       # 1,234,567

# 对齐与填充
print(f"{name:*>10}")    # *****Alice（右对齐，* 填充）
print(f"{name:*<10}")    # Alice*****（左对齐）
print(f"{name:*^10}")    # **Alice***（居中）
```

**f-string 高级用法**：

```python
# 1. 调试输出 = 语法（Python 3.8+）
x = 42
y = [1, 2, 3]
print(f"{x = }")          # x = 42
print(f"{x = :b}")         # x = 101010（调试 + 格式化）
print(f"{y = }")           # y = [1, 2, 3]
print(f"{len(y) = }")      # len(y) = 3

# 2. 嵌套格式化（Python 3.12+ 放宽了限制）
width = 10
precision = 3
value = 3.14159
print(f"{value:{width}.{precision}f}")   # '     3.142'

# 动态对齐宽度
align = ">"
fill = "*"
print(f"{name:{fill}{align}10}")   # '*****Alice'

# 3. 日期格式化
from datetime import datetime
now = datetime.now()
print(f"{now:%Y-%m-%d %H:%M:%S}")       # 2026-07-22 10:30:00
print(f"{now:%A, %B %d, %Y}")            # Wednesday, July 22, 2026
print(f"{now:%I:%M %p}")                 # 10:30 AM

# 4. 数字格式化
num = 1234567.8912
print(f"{num:.2f}")         # 1234567.89（2位小数）
print(f"{num:,.2f}")        # 1,234,567.89（千分位+2位小数）
print(f"{num:.2e}")         # 1.23e+06（科学计数法）
print(f"{num:.3%}")         # 123456789.120%（百分比）
print(f"{42:#b}")           # 0b101010（带前缀的二进制）
print(f"{42:#x}")           # 0x2a（带前缀的十六进制）
print(f"{42:#o}")           # 0o52（带前缀的八进制）

# 5. 对象格式化
class Point:
    def __format__(self, format_spec):
        if format_spec == "r":
            return f"({self.x}, {self.y})"
        return repr(self)

    def __init__(self, x, y):
        self.x = x
        self.y = y

p = Point(3, 4)
print(f"{p:r}")   # (3, 4) —— 使用自定义格式

# 6. 多行 f-string
query = f"""
    SELECT *
    FROM users
    WHERE name = '{name}'
      AND age > {age}
"""

# 7. 字典键的 f-string（注意引号！）
data = {"name": "Alice", "age": 30}
print(f"{data['name']}")       # Alice（外层双引号，内层单引号）
# print(f"{data["name"]}")     # SyntaxError（Python 3.11 及以下）
# Python 3.12+ 放宽了限制，可以在 f-string 中使用同类型引号
```

> **面试真题**：f-string 的 `=` 语法有什么用？f-string 中如何使用字典的键？f-string 和 `str.format()` 的性能差异？
>
> **易错点**：① f-string 中的表达式在运行时求值，不是编译期常量；② Python 3.11 及以下 f-string 中字典键不能用同类型引号；③ f-string 不能跨行使用反斜杠（`\n`），需要用变量代替。

---

## 新手常见错误 Top 10

以下是 Python 初学者最容易犯的错误，务必牢记：

### 1. 缩进错误

Python 使用缩进表示代码块，混用空格和 Tab 会导致错误。

```python
# 错误：混用空格和 Tab
def greet():
	print("Hello")      # Tab 缩进
        print("World")     # 空格缩进（IndentationError）

# 正确：统一使用 4 个空格
def greet():
    print("Hello")
    print("World")
```

**建议**：在编辑器中设置"显示不可见字符"，并配置"将 Tab 转换为空格"。

### 2. 变量未定义就使用

```python
# 错误：变量未定义
print(count)  # NameError: name 'count' is not defined

# 正确：先定义后使用
count = 0
print(count)
```

### 3. 列表可变陷阱

```python
# 错误：列表作为默认参数（同一对象被复用）
def add_item(item, items=[]):
    items.append(item)
    return items

print(add_item(1))  # [1]
print(add_item(2))  # [1, 2] ← 不是 [2]！

# 正确：使用 None 作为默认值
def add_item(item, items=None):
    if items is None:
        items = []
    items.append(item)
    return items
```

### 4. 循环中修改列表

```python
# 错误：在遍历时删除元素
numbers = [1, 2, 3, 4, 5]
for n in numbers:
    if n % 2 == 0:
        numbers.remove(n)
print(numbers)  # [1, 3, 5] ← 可能漏删！

# 正确：遍历副本或使用列表推导式
numbers = [n for n in numbers if n % 2 != 0]
```

### 5. 整数除法丢失精度

```python
# Python 3 中 / 是浮点除法，// 是整数除法
print(5 / 2)   # 2.5（浮点数）
print(5 // 2)  # 2（整数）

# 错误场景：期望整数但得到浮点数
index = 5 / 2
my_list[index]  # TypeError: list indices must be integers

# 正确：使用整数除法
index = 5 // 2
my_list[index]  # OK
```

### 6. 误用 is 比较值

```python
# 错误：用 is 比较值相等性
a = 257
b = 257
print(a is b)  # 可能是 False（超出小整数池范围）

# 正确：用 == 比较值
print(a == b)  # True
```

### 7. 字典键不存在错误

```python
# 错误：直接访问不存在的键
d = {"name": "Alice"}
print(d["age"])  # KeyError: 'age'

# 正确：使用 get() 方法并提供默认值
print(d.get("age", 0))  # 0
```

### 8. 字符串不可变陷阱

```python
# 错误：尝试修改字符串
s = "hello"
s[0] = "H"  # TypeError: 'str' object does not support item assignment

# 正确：创建新字符串
s = "H" + s[1:]  # "Hello"
# 或使用 replace
s = s.replace("h", "H")
```

### 9. 浮点数精度问题

```python
# 错误：浮点数精确比较
print(0.1 + 0.2 == 0.3)  # False（因为 0.1 + 0.2 = 0.30000000000000004）

# 正确：使用 decimal 模块或设置容差
from decimal import Decimal
print(Decimal('0.1') + Decimal('0.2') == Decimal('0.3'))  # True

# 或使用容差比较
abs((0.1 + 0.2) - 0.3) < 1e-9  # True
```

### 10. 文件未关闭

```python
# 错误：手动打开但忘记关闭
f = open("data.txt")
data = f.read()
# 忘记 f.close()，可能导致数据丢失或资源泄漏

# 正确：使用 with 语句（自动关闭）
with open("data.txt") as f:
    data = f.read()
# 文件自动关闭，即使发生异常
```

---

## 常见面试题汇总

### Q1：Python 是解释型语言还是编译型语言？

**答案**：Python 是**解释型语言**，但准确地说，Python 采用"编译+解释"的混合模式。

**执行流程**：
1. 源代码 (.py) 被编译成字节码 (.pyc)
2. Python 虚拟机（PVM）逐行解释执行字节码

**与纯解释型语言的区别**：Python 会缓存字节码，下次执行时如果源码未修改，直接加载 .pyc 文件，提高了启动速度。

### Q2：`is` 和 `==` 的区别是什么？

**答案**：
- `is` 比较对象的身份（内存地址），即两个引用是否指向同一个对象
- `==` 比较对象的值相等性，调用对象的 `__eq__` 方法

```python
a = [1, 2, 3]
b = [1, 2, 3]
print(a is b)  # False（不同对象）
print(a == b)  # True（值相等）

# 小整数池
a = 256
b = 256
print(a is b)  # True（小整数池范围内）

a = 257
b = 257
print(a is b)  # 可能 False（超出范围）
```

### Q3：什么是 Python 的小整数池？

**答案**：CPython 将 -5 到 256 的整数预先创建并缓存，这些整数是单例的，可以安全地用 `is` 比较。

**目的**：减少内存分配，提高性能。

```python
a = 256
b = 256
print(a is b)  # True

a = 257
b = 257
print(a is b)  # False（在交互式中）
```

### Q4：深拷贝和浅拷贝的区别？

**答案**：
- **浅拷贝**：创建新对象，但对内部子对象仍是引用（`copy.copy()` 或 `list[:]`）
- **深拷贝**：递归复制所有子对象，完全独立（`copy.deepcopy()`）

```python
import copy

original = [[1, 2], [3, 4]]

shallow = copy.copy(original)
shallow[0][0] = 99
print(original)  # [[99, 2], [3, 4]] ← 被影响

deep = copy.deepcopy(original)
deep[0][0] = 100
print(original)  # [[99, 2], [3, 4]] ← 不受影响
```

### Q5：Python 中的变量是什么？

**答案**：Python 中的变量是**对象的引用**，不是"盒子"。

```python
a = [1, 2, 3]
b = a
b.append(4)
print(a)  # [1, 2, 3, 4] ← a 也变了

# 赋值是创建新引用，不是复制对象
```

### Q6：`*args` 和 `**kwargs` 的作用？

**答案**：
- `*args`：收集位置参数为元组
- `**kwargs`：收集关键字参数为字典

```python
def func(*args, **kwargs):
    print(args)      # (1, 2, 3)
    print(kwargs)    # {'a': 4, 'b': 5}

func(1, 2, 3, a=4, b=5)
```

### Q7：Python 中如何实现多行注释？

**答案**：Python 没有原生的多行注释语法，通常使用三引号字符串作为"伪注释"：

```python
"""
这是多行字符串，
可以用作文档字符串（docstring），
也可以当作多行注释使用。
"""
```

### Q8：`pass` 语句的作用？

**答案**：`pass` 是空操作占位符，用于语法上需要语句但不需要执行任何操作的场景。

```python
def not_implemented():
    pass  # TODO: 稍后实现

class EmptyClass:
    pass
```

### Q9：Python 3 相比 Python 2 的重要变化？

**答案**：
- `print` 从语句变为函数
- 整数除法：`/` 返回浮点数，`//` 返回整数
- 默认字符串为 Unicode
- `range` 返回迭代器，不再返回列表
- 新增 `async/await` 语法
- 类型注解支持

### Q10：如何判断一个对象是否可迭代？

**答案**：

```python
from collections.abc import Iterable

print(isinstance([1, 2, 3], Iterable))  # True
print(isinstance(123, Iterable))         # False

# 或使用 hasattr
print(hasattr([1, 2, 3], '__iter__'))    # True
```

---

## 实战项目：命令行计算器

通过一个完整的小项目，综合运用本阶段学习的知识点。

### 项目目标

创建一个支持基本运算的命令行计算器，具备以下功能：
- 加、减、乘、除四则运算
- 支持连续计算
- 友好的错误提示
- 输入 `quit` 退出程序

### 完整代码

```python
#!/usr/bin/env python3
"""
命令行计算器 - 第一阶段实战项目
知识点：变量、运算符、控制流、函数、异常处理、字符串格式化
"""

def add(a, b):
    """加法"""
    return a + b

def subtract(a, b):
    """减法"""
    return a - b

def multiply(a, b):
    """乘法"""
    return a * b

def divide(a, b):
    """除法"""
    if b == 0:
        raise ValueError("除数不能为零")
    return a / b

def calculate(a, op, b):
    """根据运算符执行计算"""
    operations = {
        '+': add,
        '-': subtract,
        '*': multiply,
        '/': divide
    }
    
    if op not in operations:
        raise ValueError(f"不支持的运算符: {op}")
    
    return operations[op](a, b)

def get_number(prompt):
    """获取用户输入的数字"""
    while True:
        try:
            return float(input(prompt))
        except ValueError:
            print("请输入有效的数字！")

def get_operator():
    """获取用户输入的运算符"""
    while True:
        op = input("请输入运算符 (+, -, *, /): ").strip()
        if op in ('+', '-', '*', '/'):
            return op
        print("请输入有效的运算符: +, -, *, /")

def main():
    """主函数"""
    print("=" * 40)
    print("       命令行计算器 v1.0")
    print("  输入 'quit' 或 'q' 退出程序")
    print("=" * 40)
    
    history = []  # 计算历史
    
    while True:
        print("\n" + "-" * 30)
        
        # 获取第一个数字
        first_input = input("请输入第一个数字 (或输入 quit 退出): ").strip()
        if first_input.lower() in ('quit', 'q'):
            break
        
        try:
            a = float(first_input)
        except ValueError:
            print("请输入有效的数字！")
            continue
        
        # 获取运算符
        op = get_operator()
        
        # 获取第二个数字
        b = get_number("请输入第二个数字: ")
        
        # 执行计算
        try:
            result = calculate(a, op, b)
            print(f"\n结果: {a} {op} {b} = {result}")
            
            # 记录历史
            history.append(f"{a} {op} {b} = {result}")
            
        except ValueError as e:
            print(f"错误: {e}")
    
    # 显示历史记录
    if history:
        print("\n" + "=" * 40)
        print("本次计算历史:")
        for i, record in enumerate(history, 1):
            print(f"  {i}. {record}")
    
    print("\n感谢使用，再见！")

if __name__ == "__main__":
    main()
```

### 运行示例

```
========================================
       命令行计算器 v1.0
  输入 'quit' 或 'q' 退出程序
========================================

------------------------------
请输入第一个数字 (或输入 quit 退出): 10
请输入运算符 (+, -, *, /): +
请输入第二个数字: 5

结果: 10.0 + 5.0 = 15.0

------------------------------
请输入第一个数字 (或输入 quit 退出): 100
请输入运算符 (+, -, *, /): /
请输入第二个数字: 0

错误: 除数不能为零

------------------------------
请输入第一个数字 (或输入 quit 退出): quit

========================================
本次计算历史:
  1. 10.0 + 5.0 = 15.0

感谢使用，再见！
```

### 知识点覆盖

| 功能 | 涉及知识点 |
|------|------------|
| 函数定义 | `def`、参数、返回值、文档字符串 |
| 运算符 | 算术运算符、比较运算符 |
| 控制流 | `while`、`if`、`break`、`continue` |
| 异常处理 | `try/except`、`raise` |
| 字符串 | `input()`、`strip()`、`lower()`、f-string |
| 数据结构 | 字典映射运算符、列表存储历史 |
| 模块入口 | `if __name__ == "__main__"` |

### 进阶练习

尝试为计算器添加以下功能：
1. 支持取模（`%`）和幂运算（`**`）
2. 支持科学计数法输入（如 `1e10`）
3. 添加 `history` 命令查看历史
4. 支持从文件读取计算表达式
5. 添加 `help` 命令显示帮助信息

---

## 附录：第一阶段自检清单

在继续学习第二阶段之前，请确保你能：

- [ ] 独立完成 Python 环境搭建，创建并激活虚拟环境
- [ ] 解释 `is` 和 `==` 的区别，并正确使用
- [ ] 说明 Python 代码从源码到执行的完整流程（编译→字节码→PVM）
- [ ] 解释小整数池（-5~256）和字符串驻留机制
- [ ] 写出列表推导式，并理解其执行过程
- [ ] 说明 `dict` 的键为什么必须可哈希，以及哈希表的查找流程
- [ ] 解释深拷贝与浅拷贝的区别，并能用代码验证
- [ ] 理解 `Decimal` 和 `Fraction` 的使用场景
- [ ] 区分可迭代对象和迭代器
- [ ] 正确使用 `try/except` 处理 `input()` 的类型转换异常
- [ ] 用 f-string 完成常见的格式化需求（对齐、精度、进制转换、调试输出）
- [ ] 解释 `for-else` 的执行逻辑，并写出实际应用场景
- [ ] 理解函数默认参数的可变对象陷阱，并能写出安全版本
- [ ] 区分 `and/or` 的返回值与 `True/False`
- [ ] 使用 `logging` 模块替代 `print` 做日志输出
- [ ] 理解 `@dataclass` 和 `Enum` 的基本用法
- [ ] 使用海象运算符减少重复计算
- [ ] 使用 `match/case` 进行模式匹配

---

> **工程师寄语**：基础语法的熟练程度决定了你写代码的"手感"。不要急于求成，多写、多错、多总结。Python 的优雅不在于语法本身，而在于用简洁的代码表达清晰的意图。

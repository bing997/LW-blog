---
title: 【Python】工程化与代码质量（第九阶段）
date: 2026-07-23 16:00:00
categories:
  - Python
tags:
  - Python
  - 教程
  - 工程化
  - 测试
  - CI/CD
description: Python 工程化实践，涵盖编码规范、测试策略、性能优化、CI/CD 和项目发布，建立"可维护、可协作、可交付"的工程思维。
cover: /images/cover.png
---

# 九、工程化与代码质量

> **阶段定位**：写代码容易，写好代码难。工程化是将个人编码习惯升级为团队协作规范的过程。本阶段从编码规范出发，覆盖测试策略、性能优化、CI/CD 和项目发布，帮你建立"可维护、可协作、可交付"的工程思维。

```
┌──────────────────────────────────────────────────────────────────┐
│                  Python 工程化知识图谱                            │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  编码规范                                                        │
│    ├── PEP 8 风格指南                                           │
│    ├── 命名规范（模块/类/函数/常量）                              │
│    └── 文档字符串（Google/Numpy 风格）                           │
│                                                                  │
│  代码质量工具                                                    │
│    ├── black（格式化）                                          │
│    ├── isort（导入排序）                                        │
│    ├── flake8 / pylint（代码检查）                              │
│    ├── mypy（类型检查）                                         │
│    └── pre-commit（Git 钩子）                                   │
│                                                                  │
│  测试策略                                                        │
│    ├── 单元测试（pytest）                                       │
│    ├── 集成测试                                                  │
│    ├── Mock 与依赖隔离                                          │
│    └── 测试覆盖率（pytest-cov）                                 │
│                                                                  │
│  性能优化                                                        │
│    ├── cProfile（性能分析）                                     │
│    ├── 优化技巧（推导式/生成器/内置函数）                         │
│    └── Numba / Cython（JIT 编译）                               │
│                                                                  │
│  CI/CD                                                           │
│    ├── GitHub Actions                                           │
│    ├── tox（多环境测试）                                        │
│    └── 自动化流水线                                              │
│                                                                  │
│  打包发布                                                        │
│    ├── pyproject.toml                                           │
│    ├── 构建与发布（build / twine）                              │
│    └── Docker 容器化                                             │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## 1. 编码规范与文档

### 1.1 PEP 8 核心规则

PEP 8 是 Python 的官方编码风格指南，遵循它不是束缚，而是让代码"像 Python"。

```python
# 命名规范
module_name.py           # 模块：小写 + 下划线
package_name             # 包：小写，简短
ClassName                # 类：大驼峰
function_name            # 函数/变量：小写 + 下划线
CONSTANT_NAME            # 常量：大写 + 下划线
_private                 # 内部使用：单下划线前缀
__mangled                # 避免子类冲突：双下划线前缀

# 空白规范
# 运算符两侧空格
x = 1 + 2
# 函数参数默认值不加空格
def func(a, b=1):
    pass
# 切片内部不加空格
items[1:3]
# 逗号后空格
items = [1, 2, 3]

# 行长：79 字符（传统）或 88 字符（Black 默认）
# 续行：括号内隐式续行优先于反斜杠
result = some_function(
    arg1, arg2, arg3,
    arg4, arg5,
)
# 而非
# result = some_function(arg1, arg2, arg3, \
#                        arg4, arg5)

# 导入规范：标准库 > 第三方 > 本地，每组空一行
import os
import sys

import requests
import numpy as np

from myproject import utils
from myproject.core import models
```

**PEP 8 命名规范速查**：

| 类型 | 命名风格 | 示例 |
|------|----------|------|
| 模块 | 小写 + 下划线 | `my_module.py` |
| 包 | 小写，简短 | `mypackage` |
| 类 | 大驼峰 | `MyClass` |
| 函数 | 小写 + 下划线 | `my_function` |
| 变量 | 小写 + 下划线 | `my_variable` |
| 常量 | 大写 + 下划线 | `MY_CONSTANT` |
| 私有属性 | 单下划线前缀 | `_private_attr` |
| 名称改写 | 双下划线前缀 | `__mangled` |

### 1.2 代码质量工具链

现代 Python 项目使用自动化工具保证代码质量：

| 工具 | 用途 | 命令 |
|------|------|------|
| `black` | 代码格式化（opinionated） | `black src/` |
| `isort` | 导入排序 | `isort src/` |
| `flake8` | 风格检查 | `flake8 src/` |
| `pylint` | 深度代码分析 | `pylint src/` |
| `mypy` | 静态类型检查 | `mypy src/` |
| `bandit` | 安全检查 | `bandit -r src/` |
| `pydocstyle` | 文档字符串规范 | `pydocstyle src/` |

```python
# pyproject.toml 配置示例
[tool.black]
line-length = 88
target-version = ['py39']

[tool.isort]
profile = "black"
line_length = 88

[tool.mypy]
python_version = "3.9"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true

[tool.flake8]
max-line-length = 88
extend-ignore = ["E203", "W503"]
```

**工具链工作流程**：

```
代码提交
    │
    ▼
pre-commit 钩子
    │
    ├── black（格式化）─────────────┐
    │                              │
    ├── isort（导入排序）───────────┤
    │                              │
    ├── flake8（风格检查）──────────┤──→ 通过 ✓
    │                              │
    └── mypy（类型检查）────────────┘
                                   │
                                   ▼
                              提交成功
```

### 1.3 pre-commit 钩子

pre-commit 在每次 git commit 前自动运行代码检查，确保代码质量。

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace    # 删除行尾空白
      - id: end-of-file-fixer      # 文件末尾换行
      - id: check-yaml             # YAML 语法检查
      - id: check-added-large-files # 大文件检查

  - repo: https://github.com/psf/black
    rev: 23.12.1
    hooks:
      - id: black

  - repo: https://github.com/PyCQA/isort
    rev: 5.13.2
    hooks:
      - id: isort

  - repo: https://github.com/PyCQA/flake8
    rev: 7.0.0
    hooks:
      - id: flake8

  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.8.0
    hooks:
      - id: mypy
```

```bash
# 安装 pre-commit
pip install pre-commit
pre-commit install    # 安装到 git hooks
pre-commit run --all-files   # 手动运行所有检查
```

### 1.4 文档规范

```python
"""
模块级文档字符串。

描述模块的职责、主要类和函数的概要。
可以包含使用示例。

Example:
    >>> from myproject.utils import calculate
    >>> calculate(1, 2)
    3
"""

class Calculator:
    """计算器类。

    提供基础的数学运算功能。

    Attributes:
        history: 操作历史记录。

    Example:
        >>> calc = Calculator()
        >>> calc.add(1, 2)
        3
    """

    def add(self, a: int, b: int) -> int:
        """返回两数之和。

        Args:
            a: 第一个加数。
            b: 第二个加数。

        Returns:
            两数之和。

        Raises:
            TypeError: 如果参数不是数字。
        """
        if not isinstance(a, (int, float)) or not isinstance(b, (int, float)):
            raise TypeError("参数必须是数字")
        return a + b
```

**文档生成工具**：

| 工具 | 特点 | 适用场景 |
|------|------|----------|
| `Sphinx` | 功能强大，支持多种输出格式 | 大型项目文档 |
| `MkDocs` | 基于 Markdown，配置简单 | 项目文档站点 |
| `pdoc` | 零配置，自动生成 API 文档 | 快速文档生成 |

---

## 2. 测试策略

### 2.1 测试金字塔

```
        /\
       /  \      E2E 测试（少而精）
      /----\     - 模拟真实用户操作
     /      \    - 执行慢，维护成本高
    /--------\
   /          \  集成测试（中等数量）
  /------------\ - 测试模块间交互
 /              \ - 需要外部依赖
/----------------\
                  单元测试（大量）
                  - 测试最小单元
                  - 快速、独立、可重复
```

**比例建议**：单元测试 70% / 集成测试 20% / E2E 测试 10%

**测试类型对比**：

| 类型 | 速度 | 维护成本 | 覆盖范围 | 数量建议 |
|------|------|----------|----------|----------|
| 单元测试 | 快 | 低 | 单个函数/方法 | 大量 |
| 集成测试 | 中等 | 中等 | 模块间交互 | 中等 |
| E2E 测试 | 慢 | 高 | 完整业务流程 | 少量 |

### 2.2 pytest 框架

pytest 是 Python 最流行的测试框架，语法简洁，功能强大。

```python
# test_calculator.py
import pytest
from myproject.calculator import Calculator

# fixture：共享测试资源
@pytest.fixture
def calc():
    """每个测试方法前创建 Calculator 实例。"""
    return Calculator()

@pytest.fixture(scope="module")
def database():
    """模块级只创建一次。"""
    db = create_test_database()
    yield db
    db.cleanup()

# 参数化测试
@pytest.mark.parametrize("a,b,expected", [
    (1, 2, 3),
    (-1, 1, 0),
    (0, 0, 0),
    (100, 200, 300),
])
def test_add(calc, a, b, expected):
    assert calc.add(a, b) == expected

# 测试异常
def test_add_invalid_type(calc):
    with pytest.raises(TypeError, match="必须是数字"):
        calc.add("1", 2)

# 跳过和标记
@pytest.mark.skip(reason="功能尚未实现")
def test_future_feature():
    pass

@pytest.mark.skipif(sys.version_info < (3, 10), reason="需要 Python 3.10+")
def test_match_case():
    pass

@pytest.mark.slow    # 自定义标记
@pytest.mark.integration
def test_database_integration():
    pass
```

**pytest 常用命令**：

```bash
pytest -v                          # 详细输出
pytest -x                          # 第一次失败就停止
pytest -k "test_add"               # 按名称过滤
pytest -m "not slow"               # 排除慢测试
pytest --cov=myproject             # 覆盖率
pytest --cov=myproject --cov-report=html
pytest -n 4                        # 并行执行（需要 pytest-xdist）
```

**fixture 作用域**：

| 作用域 | 说明 | 适用场景 |
|--------|------|----------|
| `function` | 每个测试函数调用一次（默认） | 独立测试数据 |
| `class` | 每个测试类调用一次 | 类级别共享资源 |
| `module` | 每个模块调用一次 | 数据库连接、配置 |
| `package` | 每个包调用一次 | 包级别资源 |
| `session` | 整个测试会话调用一次 | 全局资源 |

### 2.3 Mock 与依赖隔离

Mock 用于隔离外部依赖，让测试更快、更稳定。

```python
from unittest.mock import Mock, patch, MagicMock, call

# patch：替换对象
def test_fetch_user():
    with patch("myproject.api.requests.get") as mock_get:
        mock_get.return_value.json.return_value = {"id": 1, "name": "Alice"}
        mock_get.return_value.status_code = 200

        user = fetch_user(1)
        assert user["name"] == "Alice"
        mock_get.assert_called_once_with("https://api.example.com/users/1")

# patch 作为装饰器
@patch("myproject.api.requests.get")
def test_fetch_user_decorator(mock_get):
    mock_get.return_value.json.return_value = {"id": 1}
    user = fetch_user(1)
    assert user["id"] == 1

# Mock 对象
mock = Mock()
mock.some_method.return_value = 42
mock.other.side_effect = [1, 2, 3]   # 每次调用返回不同值

print(mock.some_method())   # 42
print(mock.other())         # 1
print(mock.other())         # 2

# 验证调用
mock.func(1, 2, key="value")
mock.func.assert_called_with(1, 2, key="value")
mock.func.assert_called_once()
print(mock.func.call_args)   # call(1, 2, key='value')
print(mock.func.call_count)  # 1

# MagicMock：支持魔术方法
mock_dict = MagicMock()
mock_dict.__getitem__.return_value = "value"
print(mock_dict["key"])   # value
```

**Mock 使用场景**：

```
┌─────────────────────────────────────────────────────────────┐
│                     测试代码                                 │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   def test_fetch_user():                                    │
│       with patch("requests.get") as mock:                   │
│           # Mock 替代真实的 HTTP 请求                        │
│           mock.return_value.json.return_value = {...}       │
│           result = fetch_user(1)                            │
│           assert result["name"] == "Alice"                  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
                          │
                          │ 替代
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                   外部依赖（被 Mock）                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   - HTTP 请求（requests）                                   │
│   - 数据库查询                                              │
│   - 文件系统                                                │
│   - 第三方 API                                              │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 2.4 测试覆盖率

测试覆盖率衡量测试代码覆盖了多少生产代码。

```bash
# 安装
pip install pytest-cov

# 运行并生成报告
pytest --cov=myproject --cov-report=term-missing
pytest --cov=myproject --cov-report=html
pytest --cov=myproject --cov-report=xml   # 用于 CI 集成
```

```ini
# .coveragerc 配置
[run]
source = src/myproject
omit = */tests/*, */migrations/*

[report]
fail_under = 80   # 覆盖率低于 80% 报错
exclude_lines =
    pragma: no cover
    if TYPE_CHECKING:
    raise NotImplementedError
```

**覆盖率目标**：

| 项目类型 | 目标覆盖率 |
|----------|------------|
| 个人项目 | 60-70% |
| 团队项目 | 70-80% |
| 开源库 | 80-90% |
| 金融/医疗 | 90%+ |

---

## 3. 性能优化与 Profiling

### 3.1 性能分析工具

```python
# cProfile：函数级分析
import cProfile
import pstats

profiler = cProfile.Profile()
profiler.enable()
# 执行需要分析的代码
result = heavy_computation()
profiler.disable()

stats = pstats.Stats(profiler)
stats.sort_stats("cumulative")   # 按累积时间排序
stats.print_stats(20)            # 打印前 20

# 保存到文件
stats.dump_stats("profile.stats")
# 可视化：snakeviz profile.stats

# 命令行方式
# python -m cProfile -s cumulative script.py
```

**cProfile 输出示例**：

```
         1000004 function calls in 0.357 seconds

   Ordered by: cumulative time

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        1    0.000    0.000    0.357    0.357 script.py:1(<module>)
        1    0.200    0.200    0.350    0.350 script.py:5(heavy_computation)
  1000000    0.150    0.000    0.150    0.000 {built-in method math.sqrt}
        1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler'}
```

### 3.2 常见性能优化技巧

```python
# 1. 列表推导式替代循环
# 慢
squares = []
for x in range(1000):
    squares.append(x ** 2)

# 快
squares = [x ** 2 for x in range(1000)]

# 2. 生成器表达式处理大数据
# 节省内存
total = sum(x ** 2 for x in range(1000000))

# 3. 局部变量比全局变量快
def process_local(data):
    append = result.append   # 绑定到局部变量
    for item in data:
        append(item * 2)

# 4. 使用内置函数
# 慢
result = []
for x in items:
    if x > 0:
        result.append(x)

# 快
result = list(filter(None, items))

# 5. 字符串拼接用 join
# 慢
result = ""
for s in strings:
    result += s

# 快
result = "".join(strings)

# 6. 字典查找替代列表/元组
# O(n) → O(1)
if item in large_list:     # 慢：O(n)
if item in large_set:      # 快：O(1)

# 7. 使用 __slots__ 减少内存
class Point:
    __slots__ = ["x", "y"]   # 不用 __dict__，节省内存
    def __init__(self, x, y):
        self.x = x
        self.y = y

# 8. 批量操作减少 I/O
# 慢：1000 次数据库查询
for user_id in user_ids:
    db.query(f"SELECT * FROM users WHERE id = {user_id}")

# 快：1 次批量查询
placeholders = ",".join(["?"] * len(user_ids))
db.query(f"SELECT * FROM users WHERE id IN ({placeholders})", user_ids)
```

**性能优化速查表**：

| 优化点 | 慢代码 | 快代码 | 提升 |
|--------|--------|--------|------|
| 循环 | for + append | 列表推导式 | ~20% |
| 大数据 | 列表 | 生成器 | 内存节省 90% |
| 字符串拼接 | += | join() | ~10x |
| 查找 | list | set/dict | O(n)→O(1) |
| 函数调用 | 全局函数 | 局部变量绑定 | ~15% |
| 内存 | 普通 class | `__slots__` | 节省 30-50% |

### 3.3 Numba JIT 编译

对于数值计算密集型任务，Numba 可以实现接近 C 的性能。

```python
# Numba：JIT 编译（适合数值计算）
# pip install numba
from numba import jit
import numpy as np

@jit(nopython=True)
def fast_sum(arr):
    """使用 Numba 加速的求和函数。"""
    total = 0.0
    for i in range(arr.shape[0]):
        total += arr[i]
    return total

arr = np.random.randn(1000000)
# fast_sum(arr)  比纯 Python 快 100x+

# 对比
def slow_sum(arr):
    """纯 Python 实现。"""
    total = 0.0
    for i in range(arr.shape[0]):
        total += arr[i]
    return total

# 性能对比：
# slow_sum: 0.15s
# fast_sum: 0.001s（快 150x）
```

---

## 4. CI/CD 与自动化

### 4.1 GitHub Actions 示例

GitHub Actions 是 GitHub 提供的 CI/CD 服务，与代码仓库深度集成。

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ["3.9", "3.10", "3.11", "3.12"]

    steps:
      - uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -e ".[dev]"

      - name: Lint with ruff
        run: ruff check .

      - name: Format check with black
        run: black --check .

      - name: Type check with mypy
        run: mypy src/

      - name: Test with pytest
        run: pytest --cov=src --cov-report=xml

      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          file: ./coverage.xml
```

**CI/CD 流水线**：

```
代码推送
    │
    ▼
┌─────────────────────────────────────────────────────────────┐
│                    GitHub Actions                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐     │
│  │ 安装依赖 │──→│ 代码检查 │──→│ 类型检查 │──→│ 运行测试 │     │
│  └─────────┘   └─────────┘   └─────────┘   └─────────┘     │
│       │             │             │             │           │
│       └─────────────┴─────────────┴─────────────┘           │
│                               │                             │
│                               ▼                             │
│                        ┌───────────┐                        │
│                        │ 上传覆盖率 │                        │
│                        └───────────┘                        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
                    │
                    ▼
              ┌───────────┐
              │ 自动部署   │
              └───────────┘
```

### 4.2 tox 多环境测试

tox 可以在多个 Python 版本下运行测试，确保代码兼容性。

```ini
# tox.ini
[tox]
envlist = py39, py310, py311, py312, lint, type

[testenv]
deps = pytest
       pytest-cov
commands = pytest {posargs}

[testenv:lint]
deps = flake8
       black
commands =
    black --check .
    flake8 src/

[testenv:type]
deps = mypy
commands = mypy src/
```

```bash
tox          # 运行所有环境
tox -e py311 # 只运行 Python 3.11
tox -e lint  # 只运行代码检查
```

---

## 5. 打包与发布

### 5.1 现代打包流程

Python 现在使用 `pyproject.toml` 作为项目配置文件。

```toml
# pyproject.toml（完整版）
[build-system]
requires = ["setuptools>=61.0", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "myproject"
version = "1.0.0"
description = "项目描述"
readme = "README.md"
license = {text = "MIT"}
requires-python = ">=3.9"
classifiers = [
    "Development Status :: 4 - Beta",
    "Intended Audience :: Developers",
    "License :: OSI Approved :: MIT License",
    "Programming Language :: Python :: 3",
    "Programming Language :: Python :: 3.9",
    "Programming Language :: Python :: 3.10",
    "Programming Language :: Python :: 3.11",
]
dependencies = [
    "requests>=2.28.0",
    "pydantic>=2.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0",
    "pytest-cov",
    "black",
    "flake8",
    "mypy",
    "pre-commit",
]

[project.scripts]
myproject = "myproject.cli:main"

[project.urls]
Homepage = "https://github.com/username/myproject"
Repository = "https://github.com/username/myproject"
Documentation = "https://myproject.readthedocs.io"

[tool.setuptools.packages.find]
where = ["src"]
```

**项目结构**：

```
myproject/
├── src/
│   └── myproject/
│       ├── __init__.py
│       └── core.py
├── tests/
│   ├── __init__.py
│   └── test_core.py
├── pyproject.toml
├── README.md
└── LICENSE
```

**构建与发布命令**：

```bash
# 安装构建工具
pip install build twine

# 构建
python -m build

# 发布到 PyPI
python -m twine upload dist/*

# 发布到 TestPyPI（测试）
python -m twine upload --repository testpypi dist/*

# 可编辑安装（开发模式）
pip install -e ".[dev]"
```

### 5.2 Docker 化

Docker 确保应用在任何环境下一致运行。

```dockerfile
# Dockerfile
FROM python:3.11-slim

WORKDIR /app

# 先复制依赖，利用缓存层
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 再复制代码
COPY src/ ./src/

ENV PYTHONPATH=/app/src
EXPOSE 8000

CMD ["python", "-m", "myproject"]
```

```yaml
# docker-compose.yml
version: "3.8"
services:
  app:
    build: .
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgresql://user:pass@db:5432/mydb
    depends_on:
      - db

  db:
    image: postgres:15
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
      POSTGRES_DB: mydb
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

**Docker 常用命令**：

```bash
# 构建镜像
docker build -t myproject:1.0 .

# 运行容器
docker run -p 8000:8000 myproject:1.0

# 使用 docker-compose
docker-compose up -d        # 启动
docker-compose logs -f      # 查看日志
docker-compose down         # 停止
```

---

## 附录：第九阶段自检清单

在继续学习第十阶段之前，请确保你能：

- [ ] 遵循 PEP 8 编码规范，使用 black + isort + flake8 格式化代码
- [ ] 配置 pre-commit 钩子，在提交前自动检查代码质量
- [ ] 使用 pytest 编写单元测试，掌握 fixture、参数化和标记
- [ ] 使用 unittest.mock 隔离外部依赖
- [ ] 配置测试覆盖率，目标达到 80% 以上
- [ ] 使用 cProfile 分析性能瓶颈
- [ ] 应用至少 5 种 Python 性能优化技巧
- [ ] 编写 GitHub Actions 工作流实现 CI/CD
- [ ] 使用 pyproject.toml 打包并发布 Python 项目
- [ ] 编写 Dockerfile 和 docker-compose.yml 容器化应用

---

## 6. 工作实战场景

### 6.1 场景一：为遗留项目添加测试

**问题**：接手一个没有测试的老项目，如何快速建立测试体系？

```python
# 第一步：识别核心业务逻辑（通常在 utils.py, core.py）
# src/myproject/utils.py
def calculate_discount(price, discount_rate, max_discount=100):
    """计算折扣价格。"""
    if price <= 0:
        raise ValueError("价格必须大于 0")
    if discount_rate < 0 or discount_rate > 1:
        raise ValueError("折扣率必须在 0-1 之间")

    discount = price * discount_rate
    actual_discount = min(discount, max_discount)
    return price - actual_discount

# tests/test_utils.py（先写基本测试）
import pytest
from myproject.utils import calculate_discount

def test_calculate_discount_normal():
    assert calculate_discount(100, 0.1) == 90

def test_calculate_discount_max_cap():
    assert calculate_discount(1000, 0.5, max_discount=200) == 800

def test_calculate_discount_invalid_price():
    with pytest.raises(ValueError, match="价格必须大于 0"):
        calculate_discount(0, 0.1)

# 第二步：使用 pytest-cov 找出未覆盖的代码
# pytest --cov=src/myproject --cov-report=html

# 第三步：逐步增加覆盖率
# - 从最常用的函数开始
# - 优先测试关键业务逻辑
# - 遗留代码可以先黑盒测试（集成测试），再逐步重构
```

**步骤总结**：
1. **优先级排序**：核心业务 > 常用功能 > 边缘功能
2. **集成测试先行**：对于难以单元测试的遗留代码，先写集成测试
3. **重构时添加单元测试**：每次修改遗留代码时，先写测试
4. **设定合理目标**：遗留项目 60-70% 覆盖率即可，新代码 80%+

---

### 6.2 场景二：CI/CD 流水线搭建

**目标**：为团队项目搭建完整的 CI/CD 流水线。

```yaml
# .github/workflows/ci-cd.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  # Job 1: 代码质量检查
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: "3.11"

      - name: Install linters
        run: pip install black isort flake8 mypy ruff

      - name: Run Black
        run: black --check .

      - name: Run isort
        run: isort --check-only --diff .

      - name: Run flake8
        run: flake8 src/ --max-line-length=88

      - name: Run mypy
        run: mypy src/ --ignore-missing-imports

  # Job 2: 单元测试
  test:
    runs-on: ubuntu-latest
    needs: lint
    strategy:
      matrix:
        python-version: ["3.9", "3.10", "3.11", "3.12"]
        os: [ubuntu-latest, windows-latest, macos-latest]
      fail-fast: false

    steps:
      - uses: actions/checkout@v4

      - name: Set up Python ${{ matrix.python-version }}
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -e ".[dev]"

      - name: Run tests
        run: pytest --cov=src --cov-report=xml --cov-report=html

      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          file: ./coverage.xml
          flags: unittests
          fail_ci_if_error: true

  # Job 3: 安全检查
  security:
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - uses: actions/checkout@v4

      - name: Run Bandit security check
        uses: tj-actions/bandit@v5
        with:
          targets: src/

      - name: Run Safety check for dependencies
        run: |
          pip install safety
          safety check --json

  # Job 4: 构建和发布
  build:
    runs-on: ubuntu-latest
    needs: [test, security]
    if: github.ref == 'refs/heads/main'

    steps:
      - uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.11"

      - name: Install build tools
        run: pip install build twine

      - name: Build package
        run: python -m build

      - name: Publish to PyPI
        uses: pypa/gh-action-pypi-publish@release/v1
        with:
          password: ${{ secrets.PYPI_API_TOKEN }}

  # Job 5: Docker 构建
  docker:
    runs-on: ubuntu-latest
    needs: [test, security]
    if: github.ref == 'refs/heads/main'

    steps:
      - uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Login to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: |
            myproject:latest
            myproject:${{ github.sha }}
```

**流水线架构图**：

```
┌─────────────────────────────────────────────────────────────┐
│                    CI/CD 流水线                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  代码推送                                                    │
│    │                                                        │
│    ▼                                                        │
│  ┌──────────────┐                                          │
│  │  lint 检查   │  black + isort + flake8 + mypy           │
│  └──────────────┘                                          │
│    │                                                        │
│    ├──────────────────────┐                                │
│    ▼                      ▼                                │
│  ┌──────────────┐   ┌──────────────┐                      │
│  │  test 测试   │   │ security 检查 │                      │
│  │ (多版本多系统) │   │  bandit+safety │                     │
│  └──────────────┘   └──────────────┘                      │
│    │                      │                                │
│    └──────────────────────┘                                │
│              │                                              │
│              ▼                                              │
│      ┌─────────────┐                                       │
│      │  构建发布   │  PyPI + Docker Hub                    │
│      └─────────────┘                                       │
│                                                             │
│  耗时估计：                                                  │
│    lint: ~1min                                              │
│    test: ~5min (并行)                                       │
│    build: ~2min                                             │
│    总计: ~8-10min                                           │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

### 6.3 场景三：性能优化实战

**问题**：API 接口响应慢，如何定位和优化？

```python
# 第一步：使用 cProfile 定位瓶颈
import cProfile
import pstats
from io import StringIO

def profile_api():
    profiler = cProfile.Profile()
    profiler.enable()

    # 执行慢接口
    result = slow_api_endpoint()

    profiler.disable()

    # 分析结果
    s = StringIO()
    stats = pstats.Stats(profiler, stream=s).sort_stats('cumulative')
    stats.print_stats(20)
    print(s.getvalue())

# 第二步：根据分析结果优化
# 假设瓶颈在数据库查询和 JSON 序列化

# 优化前：
def get_users_slow():
    users = db.query("SELECT * FROM users")  # 查询所有字段
    result = []
    for user in users:
        result.append({
            "id": user.id,
            "name": user.name,
            "email": user.email,
            # ... 计算其他字段
        })
    return json.dumps(result)

# 优化后：
def get_users_fast():
    # 1. 只查询需要的字段
    users = db.query("SELECT id, name, email FROM users")

    # 2. 使用列表推导式 + 直接返回（避免中间变量）
    result = [
        {"id": u.id, "name": u.name, "email": u.email}
        for u in users
    ]

    # 3. 使用 orjson（比标准 json 快 5-10x）
    import orjson
    return orjson.dumps(result)

# 第三步：使用 Numba 优化计算密集型任务
from numba import jit
import numpy as np

@jit(nopython=True)
def calculate_score_batch(user_scores: np.ndarray):
    """批量计算用户评分（比纯 Python 快 50x）。"""
    result = np.zeros_like(user_scores)
    for i in range(len(user_scores)):
        # 复杂计算逻辑
        result[i] = np.log(user_scores[i] + 1) * 100
    return result

# 第四步：引入缓存
from functools import lru_cache
import redis

# 内存缓存（小数据量）
@lru_cache(maxsize=1000)
def get_user_config(user_id: int):
    return db.query("SELECT config FROM user_settings WHERE user_id = ?", user_id)

# Redis 缓存（大数据量，多进程共享）
redis_client = redis.Redis(host='localhost', port=6379, db=0)

def get_user_stats_cached(user_id: int):
    cache_key = f"user_stats:{user_id}"
    cached = redis_client.get(cache_key)

    if cached:
        return json.loads(cached)

    # 未命中，从数据库查询
    stats = db.query("SELECT * FROM user_stats WHERE user_id = ?", user_id)
    redis_client.setex(cache_key, 300, json.dumps(stats))  # 缓存 5 分钟
    return stats
```

**性能优化检查清单**：

```
□ 数据库查询
  □ 是否只查询必要的字段？
  □ 是否使用了索引？
  □ 是否避免了 N+1 查询？
  □ 是否使用了批量操作？

□ 数据处理
  □ 是否使用了列表推导式代替循环？
  □ 是否使用了生成器处理大数据？
  □ 是否使用了内置函数（map/filter/sorted）？

□ I/O 操作
  □ 是否使用了缓存（lru_cache / Redis）？
  □ 是否减少了文件读写次数？
  □ 是否使用了异步 I/O（aiohttp/asyncio）？

□ 序列化
  □ 是否使用了高速 JSON 库（orjson/ujson）？
  □ 是否避免了大对象的深拷贝？

□ 计算密集型
  □ 是否可以考虑 Numba/Cython 加速？
  □ 是否可以使用多进程（multiprocessing）？
```

---

## 7. 常见面试题汇总

### 7.1 测试相关

**Q1: 什么是测试金字塔？如何平衡不同类型的测试？**

**答案要点**：
- 测试金字塔：单元测试（底）> 集成测试（中）> E2E 测试（顶）
- 比例建议：70% / 20% / 10%
- 单元测试：快速、独立、维护成本低
- 集成测试：测试模块间交互，需要外部依赖
- E2E 测试：模拟真实用户操作，执行慢、维护成本高

```python
# 单元测试示例
def test_calculate_discount():
    assert calculate_discount(100, 0.1) == 90

# 集成测试示例
def test_order_flow():
    order = create_order(user_id=1, items=[...])
    payment = process_payment(order.id)
    assert payment.status == "success"

# E2E 测试示例（Selenium/Playwright）
def test_user_checkout_flow():
    browser.get("/products/1")
    browser.find_element("#add-to-cart").click()
    browser.find_element("#checkout").click()
    assert "订单成功" in browser.page_source
```

---

**Q2: 如何使用 Mock 测试依赖外部 API 的函数？**

```python
from unittest.mock import patch, Mock
import pytest
from myproject.api import fetch_user_data

@patch("myproject.api.requests.get")
def test_fetch_user_data(mock_get):
    """测试依赖 HTTP 请求的函数。"""
    # 配置 Mock 返回值
    mock_response = Mock()
    mock_response.json.return_value = {"id": 1, "name": "Alice"}
    mock_response.status_code = 200
    mock_get.return_value = mock_response

    # 执行测试
    result = fetch_user_data(1)

    # 验证结果
    assert result["name"] == "Alice"

    # 验证调用
    mock_get.assert_called_once_with("https://api.example.com/users/1")

# 使用 side_effect 模拟不同返回值
@patch("myproject.api.requests.get")
def test_fetch_user_data_retry(mock_get):
    """测试重试逻辑。"""
    # 第一次失败，第二次成功
    mock_get.side_effect = [
        ConnectionError("网络错误"),
        Mock(json=lambda: {"id": 1}, status_code=200)
    ]

    result = fetch_user_data_with_retry(1)
    assert result["id"] == 1
    assert mock_get.call_count == 2  # 调用了 2 次
```

---

**Q3: 测试覆盖率多少合适？100% 覆盖率是必要的吗？**

**答案要点**：
- 个人项目：60-70%
- 团队项目：70-80%
- 开源库：80-90%
- 金融/医疗：90%+

**100% 覆盖率不是目标**：
1. 有些代码难以测试（如异常处理分支）
2. 过度追求覆盖率会导致测试质量下降
3. 关键业务逻辑必须有测试，边缘功能可以适当放宽

```python
# 不重要的代码可以跳过覆盖率检查
def debug_log(message):
    if os.getenv("DEBUG"):
        print(message)  # pragma: no cover

# 类型检查代码不需要测试
if TYPE_CHECKING:  # pragma: no cover
    from typing import List
```

---

### 7.2 CI/CD 相关

**Q4: 解释 CI/CD 的核心概念和流程。**

**CI（持续集成）**：
- 开发者频繁提交代码到主分支
- 每次提交自动运行测试、代码检查
- 快速发现问题，避免集成地狱

**CD（持续交付/部署）**：
- 持续交付：代码随时可以部署到生产环境
- 持续部署：自动部署到生产环境（无需人工干预）

**典型流程**：

```
开发者提交代码
    ↓
Git Push
    ↓
CI 服务器触发（GitHub Actions/Jenkins）
    ↓
代码检查（black/flake8/mypy）
    ↓
运行测试（pytest）
    ↓
构建产物（Docker/Wheel）
    ↓
部署到测试环境
    ↓
人工审批（可选）
    ↓
部署到生产环境
```

---

**Q5: 如何确保 CI/CD 流水线的安全性？**

**答案要点**：

1. **密钥管理**：
   - 不要在代码中硬编码密钥
   - 使用 CI 平台的 Secrets 功能
   - 定期轮换密钥

2. **权限控制**：
   - 限制谁能修改 CI 配置
   - 分支保护：关键分支必须通过 CI 才能 merge

3. **依赖安全**：
   - 锁定依赖版本（requirements.lock）
   - 使用 Dependabot 自动更新依赖
   - 运行安全扫描（Safety/Bandit）

```yaml
# GitHub Actions Secrets 示例
env:
  DATABASE_URL: ${{ secrets.DATABASE_URL }}
  API_KEY: ${{ secrets.API_KEY }}

# 依赖安全检查
- name: Run Safety
  run: |
    pip install safety
    safety check --json
```

---

### 7.3 性能优化相关

**Q6: 如何定位 Python 程序的性能瓶颈？**

```python
# 方法1：cProfile
import cProfile
import pstats

profiler = cProfile.Profile()
profiler.enable()
# 执行需要分析的代码
result = slow_function()
profiler.disable()

stats = pstats.Stats(profiler)
stats.sort_stats('cumulative')
stats.print_stats(20)

# 方法2：line_profiler（逐行分析）
from line_profiler import LineProfiler

lp = LineProfiler()
lp.add_function(slow_function)
lp_wrapper = lp(slow_function)

result = lp_wrapper()
lp.print_stats()

# 方法3：memory_profiler（内存分析）
from memory_profiler import profile

@profile
def memory_intensive_function():
    large_list = [i for i in range(1000000)]
    return sum(large_list)
```

---

**Q7: 列举 5 种常见的 Python 性能优化技巧。**

```python
# 1. 列表推导式代替循环
# 慢：
squares = []
for x in range(1000):
    squares.append(x ** 2)
# 快：
squares = [x ** 2 for x in range(1000)]

# 2. 使用生成器节省内存
# 慢（占用大量内存）：
data = [process(item) for item in huge_list]
# 快（惰性计算）：
data = (process(item) for item in huge_list)

# 3. 字符串拼接用 join
# 慢：
result = ""
for s in strings:
    result += s
# 快：
result = "".join(strings)

# 4. 使用 set/dict 代替 list 进行查找
# 慢（O(n)）：
if item in large_list:
    pass
# 快（O(1)）：
if item in large_set:
    pass

# 5. 局部变量比全局变量快
import math
def calculate_fast():
    sqrt = math.sqrt  # 绑定到局部变量
    return [sqrt(x) for x in range(1000)]
```

---

### 7.4 打包发布相关

**Q8: 解释 pyproject.toml 的作用和结构。**

**答案要点**：
- 现代 Python 项目的配置文件（替代 setup.py）
- 声明式配置，更易维护
- 包含构建系统、项目元数据、依赖、工具配置

```toml
[build-system]
requires = ["setuptools>=61.0"]
build-backend = "setuptools.build_meta"

[project]
name = "myproject"
version = "1.0.0"
description = "项目描述"
requires-python = ">=3.9"
dependencies = [
    "requests>=2.28.0",
    "pydantic>=2.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0",
    "black",
    "mypy",
]

[project.scripts]
myproject = "myproject.cli:main"

[tool.black]
line-length = 88

[tool.mypy]
python_version = "3.11"
strict = true
```

---

**Q9: 如何发布 Python 包到 PyPI？**

```bash
# 第一步：安装工具
pip install build twine

# 第二步：构建产物
python -m build
# 生成：
#   dist/myproject-1.0.0.tar.gz（源码包）
#   dist/myproject-1.0.0-py3-none-any.whl（Wheel 包）

# 第三步：检查产物
twine check dist/*

# 第四步：上传到 TestPyPI（测试）
twine upload --repository testpypi dist/*

# 第五步：上传到 PyPI（正式）
twine upload dist/*
```

---

### 7.5 Docker 相关

**Q10: 编写一个生产级 Dockerfile 的最佳实践。**

```dockerfile
# 多阶段构建，减小镜像体积
FROM python:3.11-slim as builder

WORKDIR /app

# 安装依赖到独立层
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# 最终镜像
FROM python:3.11-slim

WORKDIR /app

# 从 builder 复制依赖
COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH

# 复制应用代码
COPY src/ ./src/

# 安全：非 root 用户运行
RUN useradd -m appuser
USER appuser

# 健康检查
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

# 环境变量
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

EXPOSE 8000

CMD ["python", "-m", "myproject"]
```

**最佳实践要点**：
1. 使用 `.dockerignore` 排除无关文件
2. 多阶段构建减小镜像体积
3. 非特权用户运行（安全）
4. 健康检查（HEALTHCHECK）
5. 固定基础镜像版本（`python:3.11-slim` 而非 `python:latest`）
6. 利用 Docker 缓存层（依赖先安装，代码后复制）

---

## 8. 实战项目：完整的 CI/CD 流水线搭建

### 8.1 项目概述

**目标**：为 Flask API 项目搭建完整的 CI/CD 流水线，包括代码检查、测试、安全扫描、自动部署。

**技术栈**：
- Flask：Web 框架
- pytest：测试框架
- GitHub Actions：CI/CD 平台
- Docker：容器化
- PyPI：包发布

### 8.2 项目结构

```
myflaskapp/
├── src/
│   └── myflaskapp/
│       ├── __init__.py
│       ├── app.py
│       ├── models.py
│       └── utils.py
├── tests/
│   ├── __init__.py
│   ├── conftest.py
│   ├── test_app.py
│   └── test_utils.py
├── .github/
│   └── workflows/
│       └── ci.yml
├── Dockerfile
├── docker-compose.yml
├── pyproject.toml
├── requirements.txt
├── .pre-commit-config.yaml
├── .dockerignore
└── .gitignore
```

### 8.3 核心文件

**pyproject.toml**：

```toml
[build-system]
requires = ["setuptools>=61.0"]
build-backend = "setuptools.build_meta"

[project]
name = "myflaskapp"
version = "1.0.0"
description = "Flask API with CI/CD"
requires-python = ">=3.9"
dependencies = [
    "flask>=3.0",
    "flask-sqlalchemy>=3.0",
    "pydantic>=2.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0",
    "pytest-cov",
    "pytest-flask",
    "black",
    "isort",
    "flake8",
    "mypy",
    "pre-commit",
]

[tool.black]
line-length = 88
target-version = ['py39']

[tool.isort]
profile = "black"

[tool.mypy]
python_version = "3.11"
warn_return_any = true
disallow_untyped_defs = true

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = "test_*.py"
python_classes = "Test*"
python_functions = "test_*"
addopts = "-v --cov=src --cov-report=term-missing"
```

**Flask 应用代码**：

```python
# src/myflaskapp/app.py
from flask import Flask, jsonify, request
from pydantic import BaseModel, Field
from typing import Optional

app = Flask(__name__)

class UserCreate(BaseModel):
    """用户创建模型。"""
    name: str = Field(..., min_length=1, max_length=50)
    email: str = Field(..., pattern=r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
    age: Optional[int] = Field(None, ge=0, le=150)

# 模拟数据库
users_db = {}

@app.route("/health", methods=["GET"])
def health():
    """健康检查端点。"""
    return jsonify({"status": "ok"})

@app.route("/users", methods=["POST"])
def create_user():
    """创建用户。"""
    try:
        user_data = UserCreate(**request.json)
    except Exception as e:
        return jsonify({"error": str(e)}), 400

    user_id = len(users_db) + 1
    users_db[user_id] = user_data.dict()

    return jsonify({
        "id": user_id,
        "user": user_data.dict()
    }), 201

@app.route("/users/<int:user_id>", methods=["GET"])
def get_user(user_id: int):
    """获取用户。"""
    if user_id not in users_db:
        return jsonify({"error": "User not found"}), 404

    return jsonify({
        "id": user_id,
        "user": users_db[user_id]
    })

if __name__ == "__main__":
    app.run(debug=True)
```

**测试代码**：

```python
# tests/conftest.py
import pytest
from myflaskapp.app import app

@pytest.fixture
def client():
    """创建测试客户端。"""
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client

# tests/test_app.py
import pytest
from myflaskapp.app import app

def test_health(client):
    """测试健康检查。"""
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json["status"] == "ok"

def test_create_user(client):
    """测试创建用户。"""
    response = client.post("/users", json={
        "name": "Alice",
        "email": "alice@example.com",
        "age": 30
    })
    assert response.status_code == 201
    assert response.json["user"]["name"] == "Alice"

def test_create_user_invalid_email(client):
    """测试无效邮箱。"""
    response = client.post("/users", json={
        "name": "Bob",
        "email": "invalid-email"
    })
    assert response.status_code == 400

def test_get_user_not_found(client):
    """测试获取不存在的用户。"""
    response = client.get("/users/999")
    assert response.status_code == 404
```

**GitHub Actions CI/CD**：

```yaml
# .github/workflows/ci.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-python@v5
        with:
          python-version: "3.11"

      - name: Install linters
        run: pip install black isort flake8 mypy

      - name: Run Black
        run: black --check .

      - name: Run isort
        run: isort --check-only --diff .

      - name: Run flake8
        run: flake8 src/ --max-line-length=88

      - name: Run mypy
        run: mypy src/

  test:
    runs-on: ubuntu-latest
    needs: lint
    strategy:
      matrix:
        python-version: ["3.9", "3.10", "3.11", "3.12"]

    steps:
      - uses: actions/checkout@v4

      - name: Set up Python ${{ matrix.python-version }}
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -e ".[dev]"

      - name: Run tests
        run: pytest --cov=src --cov-report=xml

      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          file: ./coverage.xml

  build:
    runs-on: ubuntu-latest
    needs: [test]
    if: github.ref == 'refs/heads/main'

    steps:
      - uses: actions/checkout@v4

      - name: Build Docker image
        run: docker build -t myflaskapp:${{ github.sha }} .

      - name: Push to registry
        run: |
          echo ${{ secrets.DOCKER_PASSWORD }} | docker login -u ${{ secrets.DOCKER_USERNAME }} --password-stdin
          docker push myflaskapp:${{ github.sha }}
```

**Dockerfile**：

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src/

ENV FLASK_APP=myflaskapp.app
ENV FLASK_ENV=production

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:5000/health || exit 1

CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
```

### 8.4 项目亮点

1. **完整的 CI/CD 流程**：
   - 代码检查（lint）
   - 多版本测试（test）
   - Docker 构建（build）
   - 自动部署

2. **测试覆盖**：
   - 单元测试（pytest）
   - 覆盖率报告（pytest-cov）
   - 异常处理测试

3. **代码质量**：
   - pre-commit 钩子
   - 类型检查（mypy）
   - 格式化（black）

4. **容器化**：
   - 多阶段构建（可选）
   - 健康检查
   - 生产级配置

---

> **工程师寄语**：代码质量不是"写完后再检查"，而是"写的时候就有意识"。自动化工具（black、pytest、CI）是质量的护城河，但真正的质量来自于工程师对"简洁、清晰、可测试"的追求。记住：**写代码是给人看的，顺便让机器执行**。

> **工程化建议**：
> 1. 从项目第一天就配置好自动化工具（pre-commit、CI）
> 2. 测试覆盖率是手段，不是目的——关键路径必须有测试
> 3. 性能优化前先 profiling，避免过早优化
> 4. CI/CD 流水线越早建立，后期越轻松
---
title: 【Python】主流应用领域（第十阶段）
date: 2026-07-24 10:00:00
categories:
  - Python
tags:
  - Python
  - 教程
  - 应用领域
  - Web开发
  - 数据科学
description: Python 主流应用领域全景，涵盖 Web 开发、数据科学、爬虫、AI/ML、自动化运维等方向，帮助你建立领域地图并选择深入方向。
cover: /images/cover.png
---

# 十、主流应用领域

> **阶段定位**：Python 的应用生态极其丰富。本阶段不是深入讲解每个领域的细节，而是建立"领域地图"——了解各方向的核心技术栈、常用工具和入门路径，帮助你根据兴趣选择深入方向。

```
┌──────────────────────────────────────────────────────────────────┐
│                    Python 应用领域全景图                         │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  🌐 Web 后端开发                                                 │
│     ├── FastAPI（现代异步，高性能）                              │
│     ├── Django（全功能，batteries included）                    │
│     ├── Flask（微框架，灵活轻量）                                │
│     └── ORM：SQLAlchemy / Django ORM                           │
│                                                                  │
│  📊 数据科学与分析                                               │
│     ├── NumPy（数值计算）                                        │
│     ├── Pandas（数据处理）                                       │
│     ├── Matplotlib / Seaborn（可视化）                          │
│     ├── Scikit-learn（机器学习）                                 │
│     └── PySpark（大数据）                                        │
│                                                                  │
│  🕷️ 网络爬虫                                                     │
│     ├── requests（HTTP 请求）                                    │
│     ├── BeautifulSoup（HTML 解析）                              │
│     ├── Scrapy（爬虫框架）                                       │
│     └── Selenium / Playwright（动态页面）                       │
│                                                                  │
│  🤖 人工智能与机器学习                                           │
│     ├── Scikit-learn（传统 ML）                                 │
│     ├── PyTorch / TensorFlow（深度学习）                        │
│     ├── LangChain（LLM 应用）                                   │
│     └── Transformers（预训练模型）                               │
│                                                                  │
│  🚀 自动化运维与 DevOps                                          │
│     ├── subprocess（系统命令）                                   │
│     ├── Fabric（远程执行）                                       │
│     ├── Docker / K8s（容器编排）                                │
│     └── boto3 / kubernetes（云原生）                            │
│                                                                  │
│  💻 桌面应用与 GUI                                               │
│     ├── Tkinter（标准库）                                        │
│     ├── PyQt / PySide（专业应用）                                │
│     ├── Kivy（跨平台移动）                                       │
│     └── Flet（类 Flutter）                                       │
│                                                                  │
│  🎮 游戏开发                                                     │
│     ├── Pygame（2D 学习）                                        │
│     ├── Arcade（现代 2D）                                        │
│     ├── Panda3D（3D）                                           │
│     └── Godot + Python（游戏引擎）                               │
│                                                                  │
│  🔌 物联网与嵌入式                                               │
│     ├── MicroPython（ESP8266/ESP32）                            │
│     ├── CircuitPython（Adafruit）                               │
│     └── Raspberry Pi（树莓派）                                   │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## 1. Web 后端开发

> Web 后端开发是 Python 应用最广泛、岗位需求最大的方向。本节不仅列出技术栈，更带你**从零跑通第一个项目**。

### 1.1 主流框架对比

| 框架 | 定位 | 异步支持 | 内置 ORM | 内置 Admin | 自动文档 | 学习曲线 | 性能 | 适用场景 |
|------|------|----------|----------|------------|----------|----------|------|----------|
| **Django** | 全功能 | 3.0+ 支持 | ✅ Django ORM | ✅ | ❌ | 中等 | 中 | 快速开发、CMS、电商、内容平台 |
| **Flask** | 微框架 | ❌（需扩展） | ❌ | ❌ | ❌ | 低 | 中 | 中小型项目、API 原型、微服务 |
| **FastAPI** | 现代异步 | ✅ 原生 | ❌（配 SQLAlchemy） | ❌ | ✅ Swagger/ReDoc | 低 | **高** | 高性能 API、微服务、实时应用 |
| **Tornado** | 异步网络库 | ✅ 原生 | ❌ | ❌ | ❌ | 中高 | 高 | 长连接、WebSocket、聊天室 |
| **Sanic** | 异步框架 | ✅ 原生 | ❌ | ❌ | ❌ | 低 | 高 | 高并发 API |

**框架选择决策树**：

```
需要快速开发全功能网站？
    │
    ├── Yes → Django（内置 ORM、Admin、认证，开箱即用）
    │
    └── No → 需要高性能异步 API？
                │
                ├── Yes → FastAPI（现代异步，自动生成文档，类型安全）
                │
                └── No → 需要极简和灵活？
                            │
                            ├── Yes → Flask（轻量，扩展丰富，适合学习和小项目）
                            │
                            └── No → 需要长连接/WebSocket？
                                        │
                                        └── Yes → Tornado
```

**新手建议**：先学 **FastAPI**（类型提示 + 自动文档，调试最方便），再学 **Django**（理解全功能框架的设计哲学），Flask 可作为兴趣了解。

---

### 1.2 从零开始：FastAPI 完整项目

> 目标：搭建一个带**数据库持久化 + JWT 认证**的完整 API 项目，跑通后你就有了一个可以继续扩展的后端骨架。

#### 第一步：环境搭建

```bash
# 1. 创建项目目录
mkdir fastapi-demo && cd fastapi-demo

# 2. 创建虚拟环境（强烈建议每个项目都用虚拟环境，避免依赖冲突）
python -m venv .venv

# 3. 激活虚拟环境
# Windows：
.venv\Scripts\activate
# macOS / Linux：
source .venv/bin/activate

# 4. 安装依赖
pip install fastapi uvicorn[standard] sqlalchemy alembic pyjwt passlib[bcrypt] python-multipart

# 5. （可选）把依赖固化到 requirements.txt
pip freeze > requirements.txt
```

**依赖说明**：

| 包名 | 作用 |
|------|------|
| `fastapi` | Web 框架 |
| `uvicorn[standard]` | ASGI 服务器，`[standard]` 包含 uvloop 等性能优化 |
| `sqlalchemy` | ORM，用 Python 对象操作数据库 |
| `alembic` | 数据库迁移工具（类似 Django Migrations） |
| `pyjwt` | JWT 令牌生成与验证 |
| `passlib[bcrypt]` | 密码哈希（bcrypt 算法） |
| `python-multipart` | 处理表单上传（FastAPI 登录表单需要） |

#### 第二步：项目结构

```
fastapi-demo/
├── .venv/                  # 虚拟环境（不提交到 Git）
├── app/
│   ├── __init__.py
│   ├── main.py             # 入口：创建 FastAPI 实例、注册路由和中间件
│   ├── config.py           # 配置：数据库 URL、密钥等
│   ├── database.py         # 数据库引擎和会话
│   ├── models.py           # SQLAlchemy ORM 模型（表结构）
│   ├── schemas.py          # Pydantic 模型（请求/响应的数据验证）
│   ├── auth.py             # JWT 认证逻辑
│   └── routers/
│       ├── __init__.py
│       ├── users.py        # 用户相关路由
│       └── items.py        # 示例业务路由（商品/待办等）
├── requirements.txt
└── README.md
```

#### 第三步：完整代码

**`app/config.py`** — 配置：

```python
"""项目配置：集中管理所有配置项，方便统一修改。"""
import os
from pathlib import Path

# 项目根目录
BASE_DIR = Path(__file__).resolve().parent.parent

# 数据库：使用 SQLite（零配置，适合学习；生产环境换 PostgreSQL）
SQLALCHEMY_DATABASE_URL = f"sqlite:///{BASE_DIR / 'app.db'}"

# JWT 密钥：生产环境务必从环境变量读取，不要硬编码！
# 生成方法：python -c "import secrets; print(secrets.token_urlsafe(32))"
SECRET_KEY = os.getenv("SECRET_KEY", "dev-only-secret-key-do-not-use-in-production")

# JWT 令牌过期时间（分钟）
ACCESS_TOKEN_EXPIRE_MINUTES = 60

# 算法
ALGORITHM = "HS256"
```

**`app/database.py`** — 数据库引擎和会话：

```python
"""数据库引擎和会话管理。"""
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

from app.config import SQLALCHEMY_DATABASE_URL

# 创建数据库引擎
# SQLite 需要 check_same_thread=False，因为 FastAPI 的异步请求可能在不同线程
engine = create_engine(
    SQLALCHEMY_DATABASE_URL,
    connect_args={"check_same_thread": False},  # 仅 SQLite 需要此参数
)

# 会话工厂：每次请求创建一个独立会话，请求结束自动关闭
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# ORM 基类：所有模型类都继承自 Base
Base = declarative_base()


def get_db():
    """依赖注入：获取数据库会话。FastAPI 会自动在请求结束后调用 finally 关闭会话。"""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
```

**`app/models.py`** — ORM 模型（数据库表结构）：

```python
"""数据库表结构定义（SQLAlchemy ORM 模型）。每个类对应数据库中的一张表。"""
from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship

from app.database import Base


class User(Base):
    """用户表：存储账号信息。"""
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    username = Column(String(50), unique=True, index=True, nullable=False, comment="用户名，唯一")
    email = Column(String(120), unique=True, index=True, nullable=False, comment="邮箱，唯一")
    hashed_password = Column(String(128), nullable=False, comment="密码哈希值，绝不存明文！")
    is_active = Column(Boolean, default=True, comment="是否激活")

    # 关联：一个用户可以拥有多个 Item
    items = relationship("Item", back_populates="owner", lazy="selectin")


class Item(Base):
    """业务表：示例"物品/待办"表，演示外键关联。"""
    __tablename__ = "items"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    title = Column(String(200), nullable=False, comment="标题")
    description = Column(String(500), nullable=True, comment="描述")
    owner_id = Column(Integer, ForeignKey("users.id"), nullable=False, comment="所属用户 ID")

    # 关联：指向 User
    owner = relationship("User", back_populates="items")
```

**`app/schemas.py`** — Pydantic 模型（请求/响应数据验证）：

```python
"""Pydantic 模型：定义 API 的请求体和响应体格式，FastAPI 会自动做数据校验。"""
from pydantic import BaseModel, ConfigDict


# ── 用户相关 ──────────────────────────────────────────

class UserCreate(BaseModel):
    """创建用户的请求体。"""
    username: str
    email: str  # 安装 pydantic[email] 后可改为 EmailStr
    password: str


class UserUpdate(BaseModel):
    """更新用户的请求体（所有字段可选）。"""
    username: str | None = None
    email: str | None = None


class UserOut(BaseModel):
    """用户响应体：绝不返回密码！"""
    model_config = ConfigDict(from_attributes=True)  # 允许从 ORM 对象读取

    id: int
    username: str
    email: str
    is_active: bool


# ── Token 相关 ──────────────────────────────────────────

class Token(BaseModel):
    """JWT 令牌响应。"""
    access_token: str
    token_type: str = "bearer"


class TokenData(BaseModel):
    """JWT 令牌中携带的数据。"""
    username: str | None = None


# ── Item 相关 ──────────────────────────────────────────

class ItemCreate(BaseModel):
    """创建 Item 的请求体。"""
    title: str
    description: str | None = None


class ItemOut(BaseModel):
    """Item 响应体。"""
    model_config = ConfigDict(from_attributes=True)

    id: int
    title: str
    description: str | None = None
    owner_id: int
```

**`app/auth.py`** — JWT 认证：

```python
"""JWT 认证：签发令牌、验证令牌、获取当前用户。"""
from datetime import datetime, timedelta, timezone
from typing import Annotated

from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import JWTError, jwt  # pip install python-jose[cryptopy]
from passlib.context import CryptContext
from sqlalchemy.orm import Session

from app.config import SECRET_KEY, ALGORITHM, ACCESS_TOKEN_EXPIRE_MINUTES
from app.database import get_db
from app.models import User
from app.schemas import Token, TokenData

# OAuth2 密码模式：客户端发送用户名+密码，服务端返回 access_token
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="auth/token")

# 密码哈希上下文（使用 bcrypt 算法）
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


# ── 密码工具函数 ────────────────────────────────────────

def hash_password(plain_password: str) -> str:
    """将明文密码哈希化，存入数据库。"""
    return pwd_context.hash(plain_password)


def verify_password(plain_password: str, hashed_password: str) -> bool:
    """验证明文密码是否与哈希匹配。"""
    return pwd_context.verify(plain_password, hashed_password)


# ── JWT 工具函数 ────────────────────────────────────────

def create_access_token(data: dict, expires_delta: timedelta | None = None) -> str:
    """签发 JWT 令牌。data 中通常包含 {"sub": username}。"""
    to_encode = data.copy()
    expire = datetime.now(timezone.utc) + (
        expires_delta or timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    )
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)


def decode_token(token: str) -> TokenData:
    """解码并验证 JWT 令牌，返回其中携带的数据。"""
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str | None = payload.get("sub")
        if username is None:
            raise JWTError()
        return TokenData(username=username)
    except JWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="无法验证凭据",
            headers={"WWW-Authenticate": "Bearer"},
        )


# ── 依赖注入：获取当前用户 ─────────────────────────────

async def get_current_user(
    token: Annotated[str, Depends(oauth2_scheme)],
    db: Annotated[Session, Depends(get_db)],
) -> User:
    """从请求头中提取 token，验证后返回当前用户对象。需要登录的路由用 Depends() 注入。"""
    token_data = decode_token(token)
    user = db.query(User).filter(User.username == token_data.username).first()
    if user is None:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="用户不存在")
    return user


async def get_current_active_user(
    current_user: Annotated[User, Depends(get_current_user)],
) -> User:
    """获取当前活跃用户：如果用户被禁用则拒绝访问。"""
    if not current_user.is_active:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="用户已被禁用")
    return current_user
```

**`app/routers/users.py`** — 用户路由：

```python
"""用户路由：注册、登录、查询、修改。"""
from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from app.database import get_db
from app.models import User
from app.schemas import UserCreate, UserUpdate, UserOut, Token
from app.auth import (
    hash_password,
    verify_password,
    create_access_token,
    get_current_active_user,
)

router = APIRouter(prefix="/users", tags=["用户管理"])


@router.post("/register", response_model=UserOut, status_code=status.HTTP_201_CREATED)
async def register(user_in: UserCreate, db: Annotated[Session, Depends(get_db)]):
    """注册新用户：检查用户名和邮箱是否已存在，密码哈希后存入数据库。"""
    # 检查用户名是否已存在
    if db.query(User).filter(User.username == user_in.username).first():
        raise HTTPException(status_code=400, detail="用户名已存在")
    # 检查邮箱是否已存在
    if db.query(User).filter(User.email == user_in.email).first():
        raise HTTPException(status_code=400, detail="邮箱已存在")
    # 创建用户（密码必须哈希，绝不能存明文！）
    db_user = User(
        username=user_in.username,
        email=user_in.email,
        hashed_password=hash_password(user_in.password),
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)  # 刷新以获取自增 id
    return db_user


@router.post("/token", response_model=Token)
async def login(
    form_data: Annotated[OAuth2PasswordRequestForm, Depends()],
    db: Annotated[Session, Depends(get_db)],
):
    """登录获取 JWT 令牌：OAuth2PasswordRequestForm 会自动解析 username + password。"""
    user = db.query(User).filter(User.username == form_data.username).first()
    if not user or not verify_password(form_data.password, user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="用户名或密码错误",
            headers={"WWW-Authenticate": "Bearer"},
        )
    # 签发令牌，sub（subject）字段存用户名
    access_token = create_access_token(data={"sub": user.username})
    return Token(access_token=access_token)


@router.get("/me", response_model=UserOut)
async def read_current_user(current_user: Annotated[User, Depends(get_current_active_user)]):
    """获取当前登录用户信息（需要认证）。"""
    return current_user


@router.put("/me", response_model=UserOut)
async def update_current_user(
    user_in: UserUpdate,
    current_user: Annotated[User, Depends(get_current_active_user)],
    db: Annotated[Session, Depends(get_db)],
):
    """更新当前用户信息（需要认证）。"""
    if user_in.username is not None:
        current_user.username = user_in.username
    if user_in.email is not None:
        current_user.email = user_in.email
    db.commit()
    db.refresh(current_user)
    return current_user
```

**`app/routers/items.py`** — 业务路由（带认证保护）：

```python
"""业务路由：Item 的增删改查，演示需要登录才能操作的路由。"""
from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.database import get_db
from app.models import User, Item
from app.schemas import ItemCreate, ItemOut
from app.auth import get_current_active_user

router = APIRouter(prefix="/items", tags=["物品管理"])


@router.get("/", response_model=list[ItemOut])
async def list_items(
    skip: int = 0,
    limit: int = 100,
    db: Annotated[Session, Depends(get_db)] = None,
):
    """获取物品列表（公开接口，无需登录）。"""
    return db.query(Item).offset(skip).limit(limit).all()


@router.post("/", response_model=ItemOut, status_code=status.HTTP_201_CREATED)
async def create_item(
    item_in: ItemCreate,
    current_user: Annotated[User, Depends(get_current_active_user)],
    db: Annotated[Session, Depends(get_db)],
):
    """创建物品（需要登录）。物品自动归属当前用户。"""
    db_item = Item(**item_in.model_dump(), owner_id=current_user.id)
    db.add(db_item)
    db.commit()
    db.refresh(db_item)
    return db_item


@router.get("/{item_id}", response_model=ItemOut)
async def read_item(item_id: int, db: Annotated[Session, Depends(get_db)]):
    """获取单个物品详情（公开接口）。"""
    item = db.query(Item).filter(Item.id == item_id).first()
    if not item:
        raise HTTPException(status_code=404, detail="物品不存在")
    return item


@router.delete("/{item_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_item(
    item_id: int,
    current_user: Annotated[User, Depends(get_current_active_user)],
    db: Annotated[Session, Depends(get_db)],
):
    """删除物品（需要登录，且只能删除自己的物品）。"""
    item = db.query(Item).filter(Item.id == item_id).first()
    if not item:
        raise HTTPException(status_code=404, detail="物品不存在")
    if item.owner_id != current_user.id:
        raise HTTPException(status_code=403, detail="无权删除他人的物品")
    db.delete(item)
    db.commit()
```

**`app/main.py`** — 入口（创建应用、注册路由、中间件、启动事件）：

```python
"""FastAPI 应用入口：创建实例、注册路由、配置中间件和启动事件。"""
import time
from contextlib import asynccontextmanager

from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from sqlalchemy.orm import Session

from app.database import engine, Base, get_db
from app.models import User, Item  # 导入所有模型，确保建表时能识别
from app.routers import users, items


# ── 生命周期事件：应用启动时建表 ─────────────────────────

@asynccontextmanager
async def lifespan(app: FastAPI):
    """应用启动时自动创建所有数据库表（仅用于开发，生产用 Alembic 迁移）。"""
    Base.metadata.create_all(bind=engine)
    print("✅ 数据库表已创建（如不存在）")
    yield  # 应用运行中...
    print("👋 应用正在关闭")


# ── 创建 FastAPI 实例 ────────────────────────────────────

app = FastAPI(
    title="FastAPI 完整示例",
    description="带数据库 + JWT 认证的完整项目骨架",
    version="1.0.0",
    lifespan=lifespan,
)


# ── 中间件 ─────────────────────────────────────────────

# 1. CORS 中间件：允许前端跨域请求（前后端分离必备）
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],        # 生产环境应改为具体域名，如 ["https://yourdomain.com"]
    allow_credentials=True,
    allow_methods=["*"],        # 允许所有 HTTP 方法
    allow_headers=["*"],        # 允许所有请求头
)


# 2. 自定义中间件：请求耗时日志（方便排查慢接口）
@app.middleware("http")
async def log_request_time(request: Request, call_next):
    """记录每个请求的处理耗时。"""
    start = time.time()
    response = await call_next(request)  # 继续处理请求
    elapsed = time.time() - start
    print(f"⏱  {request.method} {request.url.path} → {elapsed:.3f}s")
    return response


# ── 全局异常处理 ────────────────────────────────────────

@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    """全局异常兜底：防止未捕获的异常返回 500 时泄露堆栈信息。"""
    print(f"❌ 未处理异常: {exc}")
    return JSONResponse(
        status_code=500,
        content={"detail": "服务器内部错误，请稍后重试"},
    )


# ── 注册路由 ─────────────────────────────────────────────

app.include_router(users.router)
app.include_router(items.router)


# ── 健康检查 ─────────────────────────────────────────────

@app.get("/", tags=["系统"])
async def health_check():
    """健康检查接口，部署后用于负载均衡器探测服务是否存活。"""
    return {"status": "ok", "message": "FastAPI 服务运行中"}
```

#### 第四步：启动和测试

```bash
# 确保在项目根目录（fastapi-demo/），且虚拟环境已激活
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

# --reload   ：代码修改后自动重启（仅开发用）
# --host     ：监听所有网卡（Docker 部署需要）
# --port     ：端口号
```

启动后打开浏览器：

| 地址 | 说明 |
|------|------|
| `http://localhost:8000/docs` | **Swagger UI**：可视化交互式 API 文档，可直接在页面测试接口 |
| `http://localhost:8000/redoc` | **ReDoc**：另一种风格的 API 文档 |
| `http://localhost:8000/` | 健康检查，返回 `{"status": "ok"}` |

**测试流程**（在 Swagger UI 中操作最方便）：

```
1. POST /users/register  → 注册一个用户（填 username, email, password）
2. POST /users/token     → 登录获取 JWT 令牌（点页面上的 🔒 Authorize 按钮填 token）
3. GET  /users/me        → 查看当前用户信息（需登录）
4. POST /items/           → 创建一个物品（需登录）
5. GET  /items/           → 查看所有物品（无需登录）
```

**补充安装**：如果 `auth.py` 中用了 `python-jose`，请额外安装：

```bash
pip install python-jose[cryptopy]
```

---

### 1.3 从零开始：Django 快速入门

> Django 是"batteries included"的全功能框架——ORM、Admin 后台、认证系统、表单、模板引擎全部内置，适合快速搭建完整网站。

#### 第一步：安装和创建项目

```bash
# 1. 安装 Django
pip install django

# 2. 创建项目（myproject 是项目名，末尾的 . 表示在当前目录创建，不额外套一层）
django-admin startproject myproject .

# 3. 创建应用（一个项目可以有多个应用，每个应用是一个功能模块）
python manage.py startapp blog

# 4. 此时目录结构如下：
# myproject/
# ├── manage.py              # Django 命令行入口
# ├── myproject/
# │   ├── __init__.py
# │   ├── settings.py        # 项目配置（数据库、安装的应用、中间件等）
# │   ├── urls.py            # 根路由
# │   ├── asgi.py
# │   └── wsgi.py
# ├── blog/
# │   ├── __init__.py
# │   ├── models.py          # 数据模型
# │   ├── views.py           # 视图（处理请求的逻辑）
# │   ├── urls.py            # 应用路由（需手动创建）
# │   ├── admin.py           # Admin 后台配置
# │   ├── apps.py
# │   ├── tests.py
# │   └── migrations/
# └── db.sqlite3             # 默认 SQLite 数据库（执行 migrate 后自动生成）
```

#### 第二步：注册应用

编辑 `myproject/settings.py`，在 `INSTALLED_APPS` 中添加 `'blog'`：

```python
# myproject/settings.py

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'blog',  # ← 添加我们创建的应用
]
```

#### 第三步：定义 Model（数据库表）

```python
# blog/models.py

from django.db import models
from django.contrib.auth.models import User


class Post(models.Model):
    """博客文章模型：对应数据库中的 blog_post 表。"""
    title = models.CharField("标题", max_length=200)
    content = models.TextField("正文")
    author = models.ForeignKey(
        User,                    # 关联 Django 内置用户模型
        on_delete=models.CASCADE,  # 作者被删除时，其文章也全部删除
        verbose_name="作者",
    )
    created_at = models.DateTimeField("创建时间", auto_now_add=True)  # 自动记录创建时间
    updated_at = models.DateTimeField("更新时间", auto_now=True)      # 每次保存自动更新
    is_published = models.BooleanField("是否发布", default=False)

    class Meta:
        ordering = ['-created_at']  # 默认按创建时间倒序排列（最新的在前）
        verbose_name = "文章"
        verbose_name_plural = verbose_name

    def __str__(self):
        """在 Admin 后台和打印时显示的名称。"""
        return self.title
```

**生成并执行数据库迁移**：

```bash
# 根据模型变更生成迁移文件
python manage.py makemigrations

# 执行迁移，实际创建/修改数据库表
python manage.py migrate

# 输出示例：
#   Creating table blog_post ...
#   Running migrate: OK
```

#### 第四步：Admin 后台

```python
# blog/admin.py

from django.contrib import admin
from .models import Post


@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    """文章的 Admin 后台配置：控制列表显示、搜索、筛选等功能。"""
    list_display = ['title', 'author', 'is_published', 'created_at']  # 列表页显示的列
    list_filter = ['is_published', 'created_at']   # 右侧筛选栏
    search_fields = ['title', 'content']           # 搜索框可搜索的字段
    list_editable = ['is_published']               # 可在列表页直接编辑的字段
    date_hierarchy = 'created_at'                  # 按日期层级导航
```

**创建超级管理员**：

```bash
python manage.py createsuperuser
# 按提示输入用户名、邮箱、密码
```

**启动开发服务器**：

```bash
python manage.py runserver
# 访问 http://127.0.0.1:8000/admin/ → 进入 Admin 后台
# 访问 http://127.0.0.1:8000/ → 欢迎页（还没写视图，会 404）
```

#### 第五步：视图和路由

```python
# blog/views.py

from django.shortcuts import render, get_object_or_404
from django.http import JsonResponse
from .models import Post


def post_list(request):
    """文章列表页：渲染 HTML 模板。"""
    # 只查询已发布的文章，按创建时间倒序
    posts = Post.objects.filter(is_published=True).order_by('-created_at')
    return render(request, 'blog/post_list.html', {'posts': posts})


def post_detail(request, pk):
    """文章详情页：根据主键查询单篇文章。"""
    post = get_object_or_404(Post, pk=pk, is_published=True)
    return render(request, 'blog/post_detail.html', {'post': post})


def post_list_api(request):
    """API 视图：返回 JSON 格式的文章列表（演示 JsonResponse 用法）。"""
    posts = Post.objects.filter(is_published=True).values('id', 'title', 'author__username', 'created_at')
    return JsonResponse(list(posts), safe=False)  # safe=False 允许返回列表
```

**创建应用路由文件**：

```python
# blog/urls.py（手动创建此文件）

from django.urls import path
from . import views

app_name = 'blog'  # 命名空间，模板中可以用 {% url 'blog:post_list' %}

urlpatterns = [
    path('', views.post_list, name='post_list'),           # /blog/
    path('<int:pk>/', views.post_detail, name='post_detail'),  # /blog/1/
    path('api/', views.post_list_api, name='post_list_api'),   # /blog/api/
]
```

**在项目根路由中包含应用路由**：

```python
# myproject/urls.py

from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),     # Admin 后台
    path('blog/', include('blog.urls')), # 博客应用的路由
]
```

#### 第六步：模板渲染

创建模板目录和文件：

```
blog/
└── templates/
    └── blog/
        ├── post_list.html     # 文章列表页
        └── post_detail.html   # 文章详情页
```

**`blog/templates/blog/post_list.html`**：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>博客文章列表</title>
    <style>
        body { font-family: sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; }
        .post { border-bottom: 1px solid #eee; padding: 16px 0; }
        .post h2 a { color: #333; text-decoration: none; }
        .post h2 a:hover { color: #0066cc; }
        .meta { color: #999; font-size: 14px; }
    </style>
</head>
<body>
    <h1>📝 博客文章</h1>
    {% for post in posts %}
    <div class="post">
        <h2><a href="{% url 'blog:post_detail' post.pk %}">{{ post.title }}</a></h2>
        <p class="meta">作者：{{ post.author.username }} | 发布于：{{ post.created_at|date:"Y-m-d H:i" }}</p>
        <p>{{ post.content|truncatewords:30 }}</p>
    </div>
    {% empty %}
    <p>暂无文章。</p>
    {% endfor %}
</body>
</html>
```

**`blog/templates/blog/post_detail.html`**：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>{{ post.title }}</title>
    <style>
        body { font-family: sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; }
        .meta { color: #999; font-size: 14px; }
        a.back { color: #0066cc; }
    </style>
</head>
<body>
    <a class="back" href="{% url 'blog:post_list' %}">← 返回列表</a>
    <h1>{{ post.title }}</h1>
    <p class="meta">作者：{{ post.author.username }} | 发布于：{{ post.created_at|date:"Y-m-d H:i" }}</p>
    <hr>
    <div>{{ post.content|linebreaks }}</div>
</body>
</html>
```

**完整运行流程**：

```bash
python manage.py makemigrations   # 生成迁移
python manage.py migrate          # 执行迁移
python manage.py createsuperuser  # 创建管理员
python manage.py runserver        # 启动服务器

# 然后访问：
# http://127.0.0.1:8000/admin/   → Admin 后台，先创建几篇文章
# http://127.0.0.1:8000/blog/    → 前台文章列表
# http://127.0.0.1:8000/blog/1/  → 文章详情
# http://127.0.0.1:8000/blog/api/ → JSON API
```

---

### 1.4 Web 开发核心概念入门

> 如果你刚接触 Web 开发，这些概念是理解后端工作的基础。

| 概念 | 一句话解释 | 类比 |
|------|-----------|------|
| **HTTP** | 浏览器和服务器之间的通信协议，定义了请求方法（GET/POST/PUT/DELETE）和状态码（200/404/500） | 客户和服务员的对话规则 |
| **RESTful** | 一种 API 设计风格：用 URL 表示资源，用 HTTP 方法表示操作。`GET /users` 查所有用户，`POST /users` 创建用户 | 图书馆的检索规则 |
| **MVC / MTV** | Model-View-Controller：模型管数据、视图管展示、控制器管逻辑。Django 用 MTV（Model-Template-View），本质一样 | 餐厅的后厨/菜单/服务员 |
| **ORM** | Object-Relational Mapping：用 Python 对象操作数据库，不用手写 SQL。`User.objects.filter(age__gt=18)` 等价于 `SELECT * FROM users WHERE age > 18` | 翻译官：Python ↔ SQL |
| **ASGI / WSGI** | Python Web 服务器接口标准。WSGI 是同步的，ASGI 是异步的（支持 WebSocket）。FastAPI 用 ASGI，Django 两种都支持 | 餐厅的前台接单方式 |
| **JWT** | JSON Web Token：无状态认证方案。用户登录后服务器签发一个加密令牌，客户端每次请求带上令牌证明身份 | 电影票：买一次，进场查验 |
| **CORS** | Cross-Origin Resource Sharing：浏览器安全策略，默认禁止跨域请求。前后端分离时必须配置 | 小区的门禁：外人需要登记才能进 |
| **中间件** | 在请求到达路由之前/响应返回之后执行的通用逻辑（如日志、认证、CORS），类似管道 | 机场安检：所有人都必须经过 |

**HTTP 请求方法与 CRUD 对应**：

```
HTTP 方法   │ CRUD 操作  │ 示例                │ 幂等性
────────────┼────────────┼─────────────────────┼────────
GET         │ 读取 Read  │ GET /users/1        │ ✅ 多次调用结果不变
POST        │ 创建 Create│ POST /users         │ ❌ 每次创建一个新资源
PUT         │ 全量更新   │ PUT /users/1        │ ✅
PATCH       │ 部分更新   │ PATCH /users/1      │ ✅
DELETE      │ 删除 Delete│ DELETE /users/1     │ ✅
```

**RESTful API 设计示例**：

```
资源：用户（users）

GET    /users           → 获取用户列表
GET    /users/1         → 获取 ID=1 的用户详情
POST   /users           → 创建新用户
PUT    /users/1         → 全量更新 ID=1 的用户
PATCH  /users/1         → 部分更新（如只改邮箱）
DELETE /users/1         → 删除 ID=1 的用户
GET    /users/1/items   → 获取 ID=1 用户的所有物品（嵌套资源）
```

**常见 HTTP 状态码**：

```
2xx 成功：
  200 OK              - 请求成功
  201 Created         - 资源创建成功（POST 请求）
  204 No Content      - 成功但无返回内容（DELETE 请求）

4xx 客户端错误：
  400 Bad Request     - 请求参数有误
  401 Unauthorized    - 未认证（没登录或 token 无效）
  403 Forbidden       - 已认证但无权限
  404 Not Found       - 资源不存在
  422 Unprocessable   - 数据验证失败（FastAPI 常用）

5xx 服务端错误：
  500 Internal Error  - 服务器内部错误
  502 Bad Gateway     - 网关/代理无法连接上游
  503 Service Unavail - 服务暂不可用（过载或维护）
```

---

### 1.5 部署实战

> 开发环境跑通了，怎么部署到服务器？最主流的方式是 **Docker + Nginx**。

#### 5.1 Docker 部署 FastAPI

**`Dockerfile`**：

```dockerfile
# 第一阶段：构建依赖
FROM python:3.12-slim AS builder

WORKDIR /app

# 先复制依赖文件，利用 Docker 缓存层（依赖不变时无需重新安装）
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 第二阶段：运行
FROM python:3.12-slim

WORKDIR /app

# 从构建阶段复制已安装的包
COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# 复制项目代码
COPY app/ ./app/

# 非 root 用户运行（安全最佳实践）
RUN useradd --create-home appuser
USER appuser

# 暴露端口
EXPOSE 8000

# 启动命令：生产环境不用 --reload
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "4"]
```

**`docker-compose.yml`**（FastAPI + PostgreSQL）：

```yaml
version: "3.9"

services:
  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: myapp
      POSTGRES_PASSWORD: changeme  # 生产环境用 Docker secrets 或 .env
    volumes:
      - pgdata:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U myapp"]
      interval: 5s
      timeout: 3s
      retries: 5

  api:
    build: .
    ports:
      - "8000:8000"
    environment:
      DATABASE_URL: postgresql://myapp:changeme@db:5432/myapp
      SECRET_KEY: ${SECRET_KEY}  # 从 .env 文件读取
    depends_on:
      db:
        condition: service_healthy
    restart: unless-stopped

volumes:
  pgdata:
```

#### 5.2 Nginx 反向代理配置

```nginx
# /etc/nginx/sites-available/myapp

server {
    listen 80;
    server_name yourdomain.com;

    # 将所有请求转发到 FastAPI（Docker 容器）
    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # WebSocket 支持（如果用 FastAPI WebSocket）
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    # 静态文件直接由 Nginx 处理（更快）
    location /static/ {
        alias /app/static/;
        expires 30d;
    }
}
```

#### 5.3 完整部署命令

```bash
# 1. 在服务器上克隆项目
git clone https://github.com/yourname/fastapi-demo.git
cd fastapi-demo

# 2. 创建 .env 文件存放敏感配置
echo "SECRET_KEY=$(python -c 'import secrets; print(secrets.token_urlsafe(32))')" > .env

# 3. 构建并启动容器
docker compose up -d --build

# 4. 查看日志
docker compose logs -f api

# 5. 配置 Nginx
sudo cp nginx.conf /etc/nginx/sites-available/myapp
sudo ln -s /etc/nginx/sites-available/myapp /etc/nginx/sites-enabled/
sudo nginx -t          # 测试配置语法
sudo systemctl reload nginx

# 6. （可选）配置 HTTPS（Let's Encrypt 免费证书）
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d yourdomain.com
```

---

### 1.6 常见新手坑

| # | 坑 | 现象 | 解决方法 |
|---|----|------|----------|
| 1 | **不用虚拟环境** | 全局装了一堆包，项目之间互相冲突，`pip install` 报错 | 每个项目都 `python -m venv .venv`，养成习惯 |
| 2 | **密码存明文** | 数据库泄露后所有用户密码暴露 | 永远用 `passlib` + bcrypt 哈希后存储 |
| 3 | **SECRET_KEY 硬编码** | 代码推到 GitHub，密钥泄露，JWT 可被伪造 | 从环境变量读取：`os.getenv("SECRET_KEY")`，`.env` 文件加入 `.gitignore` |
| 4 | **CORS 不配置** | 前端请求后端报跨域错误 | 添加 `CORSMiddleware`，生产环境限制 `allow_origins` 为具体域名 |
| 5 | **数据库会话不关闭** | 请求越来越多，数据库连接耗尽，服务假死 | 用 `get_db()` 依赖注入确保会话关闭，或用 `try/finally` |
| 6 | **生产环境用 `--reload`** | uvicorn 开了 `--reload`，性能差且文件保存可能触发意外重启 | 生产环境去掉 `--reload`，增加 `--workers` 多进程 |
| 7 | **不写 .gitignore** | `db.sqlite3`、`.env`、`__pycache__` 全提交了 | 标准模板：`__pycache__/`、`.venv/`、`*.db`、`.env`、`*.pyc` |
| 8 | **不用 Alembic 迁移** | 直接改模型然后 `create_all`，线上数据丢失 | 用 `alembic revision --autogenerate` + `alembic upgrade head` |
| 9 | **Django 的 DEBUG=True 上线** | 报错时页面显示完整堆栈和配置，泄露敏感信息 | `settings.py` 中 `DEBUG = False`，配置 `ALLOWED_HOSTS` |
| 10 | **不理解同步 vs 异步** | 在 FastAPI 里用 `time.sleep()` 或同步 ORM 查询，整个服务阻塞 | FastAPI 中用 `await asyncio.sleep()`；SQLAlchemy 查询用 `run_in_executor` 或换 async 版本 |

---

## 2. 数据科学与分析

### 2.1 数据科学是什么？工作内容

数据科学简单说就是**用数据回答业务问题**。日常工作大致分五步：

```
提出问题 → 获取数据 → 清洗整理数据 → 分析建模 → 输出结论/报告
```

举几个真实场景：

| 场景 | 你要回答的问题 | 用到的工具 |
|------|---------------|-----------|
| 电商运营 | 哪个品类利润最高？用户复购率多少？ | Pandas + Matplotlib |
| 金融风控 | 这笔贷款违约概率多大？ | Scikit-learn + XGBoost |
| 产品迭代 | A/B 测试哪个方案转化率高？ | SciPy（统计检验） |
| 用户画像 | 核心用户长什么样？ | Pandas 分组聚合 + Seaborn |

**数据科学 vs 数据分析 vs 机器学习**：

- **数据分析**：侧重描述"发生了什么"，以报表、可视化为主
- **数据科学**：在分析基础上加入建模，预测"将会发生什么"
- **机器学习**：更偏算法和模型，是数据科学的一个子方向

新手入门的**最短路径**：先学好 NumPy → Pandas → Matplotlib，就能完成 80% 的日常工作。

---

### 2.2 从零上手：环境搭建

#### 安装 Anaconda / Miniconda

Anaconda 是数据科学的一站式发行版，自带 Python + NumPy + Pandas + Jupyter 等 200+ 包。
Miniconda 是精简版，只带 conda 包管理器，其余按需安装。

**Windows 安装步骤**：

1. 下载：[https://www.anaconda.com/download](https://www.anaconda.com/download)（选 Windows 版本）
2. 双击安装，建议**不要勾选** "Add Anaconda to my PATH"（让 Anaconda 自己管理环境）
3. 安装完成后，打开 **Anaconda Prompt**（不是普通 CMD）

**Miniconda 安装**（推荐给磁盘空间有限的同学）：

```bash
# 下载地址 https://docs.conda.io/en/latest/miniconda.html
# 安装完后创建独立环境
conda create -n datascience python=3.11 -y
conda activate datascience
# 安装核心包
conda install numpy pandas matplotlib seaborn jupyter -y
```

#### 验证安装

```bash
python -c "import numpy; print('NumPy', numpy.__version__)"
python -c "import pandas;  print('Pandas', pandas.__version__)"
python -c "import matplotlib; print('Matplotlib', matplotlib.__version__)"
```

#### Jupyter Notebook 使用

Jupyter 是数据科学的**主力 IDE**——代码、图表、文字混排，就像一本交互式笔记本。

```bash
# 启动（在目标目录下运行）
jupyter notebook

# 或者用 JupyterLab（下一代界面）
jupyter lab
```

**常用快捷键**（在命令模式下，按 `Esc` 进入命令模式）：

| 快捷键 | 作用 |
|--------|------|
| `Enter` | 进入编辑模式 |
| `Shift+Enter` | 运行当前单元格，跳到下一个 |
| `Ctrl+Enter` | 运行当前单元格，不跳转 |
| `A` | 在当前单元格上方插入新单元格 |
| `B` | 在当前单元格下方插入新单元格 |
| `DD` | 删除当前单元格 |
| `M` | 将单元格切换为 Markdown |
| `Y` | 将单元格切换为 Code |

> **提示**：Jupyter 中按 `Tab` 可自动补全，按 `Shift+Tab` 在括号内可查看函数文档。

---

### 2.3 NumPy 详细教程

NumPy（Numerical Python）是所有数据科学库的基石，Pandas、Scikit-learn 底层都依赖它。

#### 数组创建

```python
import numpy as np

# ── 1. 从 Python 列表创建 ──────────────────────────
a1 = np.array([1, 2, 3, 4])            # 一维数组
a2 = np.array([[1, 2, 3],              # 二维数组（2行3列）
               [4, 5, 6]])
print(a1)            # [1 2 3 4]
print(a2)
# [[1 2 3]
#  [4 5 6]]
print(a2.shape)      # (2, 3)  —— 2行3列
print(a2.dtype)      # int64   —— 元素类型

# ── 2. 用内置函数快速创建 ──────────────────────────
zeros  = np.zeros((3, 4))              # 3行4列，全0
ones   = np.ones((2, 3))               # 2行3列，全1
full   = np.full((2, 2), 7)            # 2行2列，全填7
eye    = np.eye(3)                     # 3×3 单位矩阵
arange = np.arange(0, 10, 2)           # [0 2 4 6 8]，步长2
linspace = np.linspace(0, 1, 5)        # [0. 0.25 0.5 0.75 1.]，等分5个点

print(arange)    # [0 2 4 6 8]
print(linspace)  # [0.   0.25 0.5  0.75 1.  ]

# ── 3. 随机数创建 ──────────────────────────────────
np.random.seed(42)                     # 固定随机种子，结果可复现
r1 = np.random.rand(3, 2)             # 3×2，[0,1)均匀分布
r2 = np.random.randn(3, 2)            # 3×2，标准正态分布
r3 = np.random.randint(1, 100, size=(2, 5))  # 2×5，[1,100)随机整数

print(r3)
# 示例输出：
# [[52 93 15 72 61]
#  [21 83 87 75 75]]
```

#### 数组运算（加减乘除、广播机制）

```python
import numpy as np

a = np.array([1, 2, 3, 4])
b = np.array([10, 20, 30, 40])

# ── 逐元素运算 ──────────────────────────────────────
print(a + b)     # [11 22 33 44]
print(a - b)     # [ -9 -18 -27 -36]
print(a * b)     # [ 10  40  90 160]  —— 注意：这是逐元素相乘，不是矩阵乘法
print(b / a)     # [10. 10. 10. 10.]
print(a ** 2)    # [ 1  4  9 16]      —— 逐元素平方

# ── 标量运算（广播机制）──────────────────────────────
print(a * 10)    # [10 20 30 40]   —— 标量自动"广播"到每个元素
print(a + 100)   # [101 102 103 104]

# ── 广播机制详解 ────────────────────────────────────
# 形状不同的数组也能运算，NumPy 会自动"扩展"小数组
c = np.array([[1], [2], [3]])   # 形状 (3, 1)
d = np.array([10, 20, 30])     # 形状 (3,)
print(c + d)
# [[11 21 31]
#  [12 22 32]
#  [13 23 33]]
# c 被广播为 (3,3)，d 也被广播为 (3,3)

# ── 常用数学函数 ────────────────────────────────────
x = np.array([0, np.pi/2, np.pi])
print(np.sin(x))     # [0.000e+00 1.000e+00 1.224e-16]（≈0,1,0）
print(np.sqrt(a))    # [1.    1.414 1.732 2.   ]
print(np.exp(a))     # [ 2.718  7.389 20.086 54.598]
print(np.log(a))     # [0.    0.693 1.099 1.386]
```

#### 索引和切片

```python
import numpy as np

arr = np.array([
    [10, 20, 30, 40],
    [50, 60, 70, 80],
    [90, 100, 110, 120]
])
# arr 形状 (3, 4)

# ── 基础索引 ────────────────────────────────────────
print(arr[0])         # [10 20 30 40]     —— 第0行
print(arr[1, 2])      # 70                —— 第1行第2列
print(arr[-1])        # [ 90 100 110 120] —— 最后一行

# ── 切片 ────────────────────────────────────────────
print(arr[0:2])       # 前两行
# [[10 20 30 40]
#  [50 60 70 80]]
print(arr[:, 1])      # [ 20  60 100]     —— 所有行的第1列
print(arr[1:, 2:])    # 第1行往后、第2列往右
# [[ 70  80]
#  [110 120]]

# ── 布尔索引（非常常用！）────────────────────────────
print(arr[arr > 50])  # [ 60  70  80  90 100 110 120] —— 所有大于50的元素

# ── 花式索引（用数组做下标）─────────────────────────
print(arr[[0, 2]])    # 第0行和第2行
# [[ 10  20  30  40]
#  [ 90 100 110 120]]
```

#### 统计函数

```python
import numpy as np

data = np.array([23, 45, 12, 67, 34, 89, 56, 78, 11, 90])

# ── 基础统计量 ──────────────────────────────────────
print("均值:",   np.mean(data))      # 50.5
print("中位数:", np.median(data))    # 50.5
print("标准差:", np.std(data))       # 27.49...
print("方差:",   np.var(data))       # 755.65
print("最小值:", np.min(data))       # 11
print("最大值:", np.max(data))       # 90
print("求和:",   np.sum(data))       # 505

# ── 分位数 ──────────────────────────────────────────
print("25%分位:", np.percentile(data, 25))  # 23.0
print("75%分位:", np.percentile(data, 75))  # 78.0

# ── 二维数组按轴统计 ────────────────────────────────
scores = np.array([
    [80, 90, 70],   # 语文、数学、英语
    [60, 85, 95],
    [75, 88, 82]
])
print("每科平均分（按列）:", np.mean(scores, axis=0))  # [71.67 87.67 82.33]
print("每人平均分（按行）:", np.mean(scores, axis=1))  # [80.   80.   81.67]

# ── 累计运算 ────────────────────────────────────────
print("累计求和:", np.cumsum(data))   # [ 23  68  80 147 181 270 326 404 415 505]
print("累计乘积:", np.cumprod(data[:5]))  # 前5个元素的累计乘积
```

#### 矩阵运算

```python
import numpy as np

A = np.array([[1, 2],
              [3, 4]])
B = np.array([[5, 6],
              [7, 8]])

# ── 矩阵乘法（点乘）────────────────────────────────
# 注意：A * B 是逐元素相乘，A @ B 才是矩阵乘法
print("逐元素相乘:\n", A * B)
# [[ 5 12]
#  [21 32]]

print("矩阵乘法:\n", A @ B)
# [[19 22]
#  [43 50]]
# 等价写法：np.dot(A, B) 或 A.dot(B)

# ── 转置 ────────────────────────────────────────────
print("A 的转置:\n", A.T)
# [[1 3]
#  [2 4]]

# ── 逆矩阵 ────────────────────────────────────────
A_inv = np.linalg.inv(A)
print("A 的逆矩阵:\n", A_inv)
# [[-2.   1. ]
#  [ 1.5 -0.5]]

# 验证：A @ A_inv 应该等于单位矩阵
print("A @ A_inv:\n", np.round(A @ A_inv))
# [[1. 0.]
#  [0. 1.]]

# ── 行列式 ──────────────────────────────────────────
print("A 的行列式:", np.linalg.det(A))  # -2.0

# ── 特征值和特征向量 ────────────────────────────────
eigenvalues, eigenvectors = np.linalg.eig(A)
print("特征值:", eigenvalues)   # [-0.372  5.372]

# ── 解线性方程组 Ax = b ────────────────────────────
b = np.array([1, 2])
x = np.linalg.solve(A, b)
print("方程组解 x =", x)       # [-1.110e-16  5.000e-01]（≈ [0, 0.5]）
```

---

### 2.4 Pandas 详细教程

Pandas 是数据分析的**核心武器**，90% 的数据处理工作都靠它完成。核心数据结构：
- **Series**：一维数组（带标签）
- **DataFrame**：二维表格（带行标签和列标签），类似 Excel 表

#### 创建和读取数据

```python
import pandas as pd
import numpy as np

# ── 1. 从字典创建 DataFrame ────────────────────────
df = pd.DataFrame({
    "姓名": ["张三", "李四", "王五", "赵六", "钱七"],
    "年龄": [25, 30, 35, 28, 40],
    "城市": ["北京", "上海", "广州", "深圳", "杭州"],
    "薪资": [8000, 12000, 15000, 9000, 20000],
    "入职年份": pd.to_datetime(["2020-01-15", "2019-06-01", "2018-03-20", "2021-09-10", "2017-11-05"])
})
print(df)
#    姓名  年龄  城市     薪资       入职年份
# 0  张三  25  北京   8000 2020-01-15
# 1  李四  30  上海  12000 2019-06-01
# 2  王五  35  广州  15000 2018-03-20
# 3  赵六  28  深圳   9000 2021-09-10
# 4  钱七  40  杭州  20000 2017-11-05

# ── 2. 从 CSV 读取 ────────────────────────────────
# df = pd.read_csv("data.csv", encoding="utf-8")

# 常用参数：
# df = pd.read_csv("data.csv",
#     encoding="gbk",          # 中文文件常用 gbk
#     nrows=1000,              # 只读前1000行（大文件先预览）
#     usecols=["姓名","薪资"], # 只读指定列
#     parse_dates=["日期"],    # 自动解析日期列
#     na_values=["NA","null"], # 把这些值视为缺失值
# )

# ── 3. 从 Excel 读取 ───────────────────────────────
# df = pd.read_excel("data.xlsx", sheet_name="Sheet1")
# 需要安装：pip install openpyxl

# ── 4. 从 SQL 数据库读取 ────────────────────────────
# from sqlalchemy import create_engine
# engine = create_engine("mysql+pymysql://user:password@host:3306/dbname")
# df = pd.read_sql("SELECT * FROM employees", engine)

# ── 5. 保存数据 ────────────────────────────────────
# df.to_csv("output.csv", index=False, encoding="utf-8-sig")  # utf-8-sig 带 BOM，Excel 打开不乱码
# df.to_excel("output.xlsx", index=False)
```

#### 数据查看（head / info / describe）

```python
import pandas as pd
import numpy as np

df = pd.DataFrame({
    "姓名": ["张三", "李四", "王五", "赵六", "钱七", "孙八", "周九", "吴十"],
    "年龄": [25, 30, 35, 28, 40, 32, 27, 45],
    "城市": ["北京", "上海", "广州", "深圳", "杭州", "成都", "武汉", "南京"],
    "薪资": [8000, 12000, 15000, 9000, 20000, 11000, 7500, 18000],
    "部门": ["技术", "市场", "技术", "运营", "技术", "市场", "运营", "技术"]
})

# ── 预览数据 ────────────────────────────────────────
print(df.head())        # 默认看前5行
print(df.head(3))       # 只看前3行
print(df.tail(2))       # 看最后2行

# ── 基本信息 ────────────────────────────────────────
print(df.info())
# <class 'pandas.core.frame.DataFrame'>
# RangeIndex: 8 entries, 0 to 7
# Data columns (total 5 columns):
#  #   Column  Non-Null Count  Dtype
# ---  ------  --------------  -----
#  0   姓名     8 non-null      object
#  1   年龄     8 non-null      int64
#  ...

# ── 描述性统计 ──────────────────────────────────────
print(df.describe())
#        年龄       薪资
# count   8.00     8.00
# mean   32.75  12562.50
# std     6.52   4467.85
# min    25.00   7500.00
# 25%    27.75   8750.00
# 50%    31.00  11500.00
# 75%    36.25  15750.00
# max    45.00  20000.00

# ── 查看各列数据类型 ────────────────────────────────
print(df.dtypes)
# 姓名    object
# 年龄     int64
# 城市    object
# 薪资     int64
# 部门    object

# ── 查看唯一值 ──────────────────────────────────────
print(df["城市"].unique())       # ['北京' '上海' '广州' '深圳' '杭州' '成都' '武汉' '南京']
print(df["部门"].value_counts()) # 各部门人数
# 技术    4
# 市场    2
# 运营    2
```

#### 数据筛选和排序

```python
import pandas as pd

df = pd.DataFrame({
    "姓名": ["张三", "李四", "王五", "赵六", "钱七", "孙八"],
    "年龄": [25, 30, 35, 28, 40, 32],
    "城市": ["北京", "上海", "广州", "深圳", "杭州", "成都"],
    "薪资": [8000, 12000, 15000, 9000, 20000, 11000],
    "部门": ["技术", "市场", "技术", "运营", "技术", "市场"]
})

# ── 单条件筛选 ──────────────────────────────────────
high_salary = df[df["薪资"] > 10000]
print(high_salary)
#    姓名  年龄  城市     薪资  部门
# 1  李四  30  上海  12000  市场
# 2  王五  35  广州  15000  技术
# 4  钱七  40  杭州  20000  技术
# 5  孙八  32  成都  11000  市场

# ── 多条件筛选 ──────────────────────────────────────
# & 表示且，| 表示或，每个条件要用括号包裹！
tech_high = df[(df["部门"] == "技术") & (df["薪资"] > 10000)]
print(tech_high)
#    姓名  年龄  城市     薪资  部门
# 2  王五  35  广州  15000  技术
# 4  钱七  40  杭州  20000  技术

# ── isin 筛选（值在列表中）─────────────────────────
south = df[df["城市"].isin(["广州", "深圳", "杭州", "成都"])]
print(south)
#    姓名  年龄  城市     薪资  部门
# 2  王五  35  广州  15000  技术
# 3  赵六  28  深圳   9000  运营
# 4  钱七  40  杭州  20000  技术
# 5  孙八  32  成都  11000  市场

# ── 字符串包含筛选 ──────────────────────────────────
# df[df["姓名"].str.contains("张")]  # 姓名含"张"的行

# ── 排序 ────────────────────────────────────────────
print(df.sort_values("薪资", ascending=False))  # 按薪资降序
#    姓名  年龄  城市     薪资  部门
# 4  钱七  40  杭州  20000  技术
# 2  王五  35  广州  15000  技术
# 1  李四  30  上海  12000  市场
# ...

print(df.sort_values(["部门", "薪资"], ascending=[True, False]))
# 先按部门升序，同部门内按薪资降序

# ── 取最大/最小行的索引 ─────────────────────────────
print(df.loc[df["薪资"].idxmax()])   # 薪资最高的人
# 姓名     钱七
# 年龄      40
# 城市     杭州
# 薪资   20000
# 部门     技术
```

#### 分组聚合

```python
import pandas as pd
import numpy as np

df = pd.DataFrame({
    "部门":  ["技术", "技术", "技术", "市场", "市场", "运营", "运营"],
    "姓名":  ["张三", "王五", "钱七", "李四", "孙八", "赵六", "周九"],
    "薪资":  [8000, 15000, 20000, 12000, 11000, 9000, 7500],
    "绩效":  ["A", "B", "A", "B", "C", "A", "C"],
})

# ── 单列分组 ────────────────────────────────────────
print(df.groupby("部门")["薪资"].mean())
# 部门
# 技术    14333.33
# 市场    11500.00
# 运营     8250.00

# ── 多种聚合 ────────────────────────────────────────
print(df.groupby("部门")["薪资"].agg(["mean", "median", "min", "max", "count"]))
#            mean  median    min    max  count
# 部门
# 技术  14333.33  15000   8000  20000      3
# 市场  11500.00  11500  11000  12000      2
# 运营   8250.00   8250   7500   9000      2

# ── 自定义聚合函数 ──────────────────────────────────
print(df.groupby("部门")["薪资"].agg(
    平均薪资="mean",
    薪资极差=lambda x: x.max() - x.min()
))
#           平均薪资  薪资极差
# 部门
# 技术  14333.33   12000
# 市场  11500.00    1000
# 运营   8250.00    1500

# ── 多列分组 ────────────────────────────────────────
print(df.groupby(["部门", "绩效"])["薪资"].mean())
# 部门  绩效
# 技术  A      14000
#       B      15000
# 市场  B      12000
#       C      11000
# 运营  A       9000
#       C       7500

# ── transform：不改变行数，给每行加上组统计量 ────────
df["部门平均薪资"] = df.groupby("部门")["薪资"].transform("mean")
print(df[["姓名", "部门", "薪资", "部门平均薪资"]])
#   姓名  部门    薪资  部门平均薪资
# 0  张三  技术   8000  14333.33
# 1  王五  技术  15000  14333.33
# 2  钱七  技术  20000  14333.33
# 3  李四  市场  12000  11500.00
# ...
```

#### 数据清洗（缺失值、重复值、类型转换）

```python
import pandas as pd
import numpy as np

# 构造一份"脏数据"
df = pd.DataFrame({
    "姓名":  ["张三", "李四", np.nan, "张三", "王五", "赵六", np.nan],
    "年龄":  [25, np.nan, 35, 25, 40, np.nan, 30],
    "薪资":  ["8000", "12000", "15000", "8000", "20000", "N/A", "9000"],
    "入职日期": ["2020-01-15", "2019-06-01", "2018-03-20", "2020-01-15", "2017-11-05", "2021-09-10", "2022-02-28"]
})

print("── 原始数据 ──")
print(df)
#     姓名   年龄     薪资       入职日期
# 0   张三  25.0    8000  2020-01-15
# 1   李四   NaN   12000  2019-06-01
# 2   NaN  35.0   15000  2018-03-20
# 3   张三  25.0    8000  2020-01-15   ← 完全重复第0行
# 4   王五  40.0   20000  2017-11-05
# 5   赵六   NaN     N/A  2021-09-10   ← 薪资是 "N/A"
# 6   NaN  30.0    9000  2022-02-28

# ── 1. 查看缺失值 ───────────────────────────────────
print(df.isnull().sum())
# 姓名      2
# 年龄      2
# 薪资      0    ← "N/A" 是字符串，Pandas 不认为它是缺失！
# 入职日期    0

# ── 2. 处理缺失值 ───────────────────────────────────
# 方式一：删除含缺失值的行
df_dropna = df.dropna()
print("删除缺失后行数:", len(df_dropna))  # 3

# 方式二：填充缺失值（更常用）
df_filled = df.copy()
df_filled["姓名"] = df_filled["姓名"].fillna("未知")        # 姓名填"未知"
df_filled["年龄"] = df_filled["年龄"].fillna(df_filled["年龄"].median())  # 年龄填中位数
print(df_filled)

# ── 3. 处理重复值 ───────────────────────────────────
print("重复行数:", df.duplicated().sum())   # 1
df_dedup = df.drop_duplicates()             # 去重
print("去重后行数:", len(df_dedup))         # 6

# ── 4. 类型转换 ────────────────────────────────────
# 先把 "N/A" 替换为 NaN，再转数值
df_clean = df.copy()
df_clean["薪资"] = df_clean["薪资"].replace("N/A", np.nan)
df_clean["薪资"] = df_clean["薪资"].astype(float)    # 转为浮点数
print(df_clean["薪资"].dtype)  # float64

# 日期类型转换
df_clean["入职日期"] = pd.to_datetime(df_clean["入职日期"])
print(df_clean["入职日期"].dtype)  # datetime64[ns]

# ── 5. 列重命名 ────────────────────────────────────
df_clean = df_clean.rename(columns={"姓名": "name", "薪资": "salary"})

# ── 6. 添加计算列 ──────────────────────────────────
df_clean["入职年限"] = 2026 - df_clean["入职日期"].dt.year
print(df_clean[["name", "入职年限"]])
```

#### 合并和拼接

```python
import pandas as pd

# ── 1. merge：类似 SQL 的 JOIN ─────────────────────
employees = pd.DataFrame({
    "员工ID": [1, 2, 3, 4],
    "姓名":   ["张三", "李四", "王五", "赵六"],
    "部门ID": [101, 102, 101, 103]
})

departments = pd.DataFrame({
    "部门ID": [101, 102, 104],
    "部门名称": ["技术部", "市场部", "财务部"]
})

# 内连接（只保留两边都有的）
inner = pd.merge(employees, departments, on="部门ID", how="inner")
print("内连接:\n", inner)
#    员工ID  姓名  部门ID 部门名称
# 0     1  张三    101  技术部
# 1     3  王五    101  技术部
# 2     2  李四    102  市场部

# 左连接（保留左表所有行）
left = pd.merge(employees, departments, on="部门ID", how="left")
print("左连接:\n", left)
# 赵六的部门名称为 NaN，因为 103 在右表不存在

# 全外连接
outer = pd.merge(employees, departments, on="部门ID", how="outer")
print("全外连接:\n", outer)

# ── 2. concat：纵向/横向拼接 ──────────────────────
df1 = pd.DataFrame({"A": [1, 2], "B": [3, 4]})
df2 = pd.DataFrame({"A": [5, 6], "B": [7, 8]})

# 纵向拼接（追加行）
print(pd.concat([df1, df2], ignore_index=True))
#    A  B
# 0  1  3
# 1  2  4
# 2  5  7
# 3  6  8

# 横向拼接（追加列）
df3 = pd.DataFrame({"C": [9, 10], "D": [11, 12]})
print(pd.concat([df1, df3], axis=1))
#    A  B   C   D
# 0  1  3   9  11
# 1  2  4  10  12
```

#### 时间序列处理

```python
import pandas as pd
import numpy as np

# ── 创建时间序列 ────────────────────────────────────
# 生成2024年1月每天的销售数据
dates = pd.date_range("2024-01-01", periods=31, freq="D")
np.random.seed(42)
sales = np.random.randint(100, 500, size=31)
ts = pd.DataFrame({"日期": dates, "销售额": sales})
ts = ts.set_index("日期")  # 把日期设为索引
print(ts.head())
#             销售额
# 日期
# 2024-01-01    137
# 2024-01-02    269
# 2024-01-03    141
# 2024-01-04    447
# 2024-01-05    215

# ── 按时间范围切片 ──────────────────────────────────
print(ts["2024-01-10":"2024-01-15"])  # 1月10日到15日

# ── 重采样（降频：日 → 周/月）──────────────────────
weekly = ts.resample("W").sum()       # 按周汇总
monthly = ts.resample("M").mean()     # 按月取平均
print("周度汇总:\n", weekly.head())
print("月度平均:\n", monthly)

# ── 滚动窗口 ────────────────────────────────────────
ts["7日移动平均"] = ts["销售额"].rolling(window=7).mean()
print(ts.head(10))
#             销售额  7日移动平均
# 日期
# 2024-01-01    137       NaN
# ...
# 2024-01-07    295    258.43   ← 从第7天开始有值
# 2024-01-08    253    264.14

# ── 差分（计算环比变化）─────────────────────────────
ts["日环比变化"] = ts["销售额"].diff()
print(ts.head())
#             销售额  日环比变化
# 日期
# 2024-01-01    137       NaN
# 2024-01-02    269     132.0
# 2024-01-03    141    -128.0

# ── 提取时间特征 ────────────────────────────────────
ts["星期几"] = ts.index.dayofweek      # 0=周一, 6=周日
ts["是否周末"] = ts.index.dayofweek >= 5
print(ts[["销售额", "星期几", "是否周末"]].head(7))
```

---

### 2.5 Matplotlib / Seaborn 可视化教程

#### 中文字体配置（必看！）

```python
import matplotlib.pyplot as plt
import matplotlib

# ── 方式一：设置系统中文字体 ────────────────────────
plt.rcParams["font.sans-serif"] = ["SimHei"]    # 黑体（Windows）
plt.rcParams["axes.unicode_minus"] = False       # 正常显示负号

# ── 方式二：Mac 用户 ───────────────────────────────
# plt.rcParams["font.sans-serif"] = ["Arial Unicode MS"]

# ── 方式三：Linux 用户 ─────────────────────────────
# plt.rcParams["font.sans-serif"] = ["WenQuanYi Micro Hei"]
```

> **如果本机没有中文字体**，可用以下代码查看所有可用字体：
> ```python
> from matplotlib.font_manager import fontManager
> for f in fontManager.ttflist:
>     if "Hei" in f.name or "Song" in f.name or "CN" in f.name:
>         print(f.name, f.fname)
> ```

#### 折线图

```python
import matplotlib.pyplot as plt
import numpy as np

plt.rcParams["font.sans-serif"] = ["SimHei"]
plt.rcParams["axes.unicode_minus"] = False

months = ["1月", "2月", "3月", "4月", "5月", "6月"]
sales_A = [120, 150, 170, 160, 200, 220]
sales_B = [80,  110, 130, 140, 120, 150]

plt.figure(figsize=(10, 5))
plt.plot(months, sales_A, marker="o", linewidth=2, label="产品A", color="#1f77b4")
plt.plot(months, sales_B, marker="s", linewidth=2, label="产品B", color="#ff7f0e")

plt.title("月度销售趋势对比", fontsize=16)
plt.xlabel("月份", fontsize=12)
plt.ylabel("销售额（万元）", fontsize=12)
plt.legend(fontsize=12)              # 显示图例
plt.grid(alpha=0.3)                  # 添加网格线，透明度0.3
plt.tight_layout()                   # 自动调整布局
plt.savefig("line_chart.png", dpi=150)
plt.show()
```

#### 柱状图

```python
import matplotlib.pyplot as plt

plt.rcParams["font.sans-serif"] = ["SimHei"]
plt.rcParams["axes.unicode_minus"] = False

departments = ["技术部", "市场部", "运营部", "财务部"]
salaries = [15000, 12000, 9000, 11000]

plt.figure(figsize=(8, 5))
bars = plt.bar(departments, salaries, color=["#4e79a7", "#f28e2b", "#e15759", "#76b7b2"])

# 在柱子上方标注数值
for bar, val in zip(bars, salaries):
    plt.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 200,
             f"¥{val:,}", ha="center", fontsize=11)

plt.title("各部门平均薪资", fontsize=16)
plt.ylabel("薪资（元）", fontsize=12)
plt.ylim(0, 18000)                   # 留出标注空间
plt.tight_layout()
plt.savefig("bar_chart.png", dpi=150)
plt.show()
```

#### 散点图

```python
import matplotlib.pyplot as plt
import numpy as np

plt.rcParams["font.sans-serif"] = ["SimHei"]
plt.rcParams["axes.unicode_minus"] = False

np.random.seed(42)
experience = np.random.uniform(1, 10, 50)         # 工作年限
salary = 5000 + experience * 2000 + np.random.normal(0, 1500, 50)  # 薪资

plt.figure(figsize=(8, 5))
plt.scatter(experience, salary, alpha=0.7, edgecolors="k", linewidths=0.5, c="#2ca02c")

# 添加趋势线
z = np.polyfit(experience, salary, 1)              # 线性拟合
p = np.poly1d(z)
x_line = np.linspace(1, 10, 100)
plt.plot(x_line, p(x_line), "r--", linewidth=2, label=f"趋势线: y={z[0]:.0f}x+{z[1]:.0f}")

plt.title("工作年限 vs 薪资", fontsize=16)
plt.xlabel("工作年限（年）", fontsize=12)
plt.ylabel("薪资（元）", fontsize=12)
plt.legend()
plt.grid(alpha=0.3)
plt.tight_layout()
plt.savefig("scatter_chart.png", dpi=150)
plt.show()
```

#### 饼图

```python
import matplotlib.pyplot as plt

plt.rcParams["font.sans-serif"] = ["SimHei"]
plt.rcParams["axes.unicode_minus"] = False

labels = ["技术部", "市场部", "运营部", "财务部"]
sizes = [40, 25, 20, 15]
colors = ["#4e79a7", "#f28e2b", "#e15759", "#76b7b2"]
explode = (0.05, 0, 0, 0)                # 突出技术部

plt.figure(figsize=(7, 7))
plt.pie(sizes, explode=explode, labels=labels, colors=colors,
        autopct="%1.1f%%",                  # 显示百分比
        shadow=True, startangle=90,
        textprops={"fontsize": 12})

plt.title("各部门人数占比", fontsize=16)
plt.tight_layout()
plt.savefig("pie_chart.png", dpi=150)
plt.show()
```

#### Seaborn 热力图

```python
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np

plt.rcParams["font.sans-serif"] = ["SimHei"]
plt.rcParams["axes.unicode_minus"] = False

# 相关性热力图（展示各变量间的相关系数）
data = {
    "薪资":   [8000, 12000, 15000, 9000, 20000, 11000, 7500, 18000],
    "年龄":   [25, 30, 35, 28, 40, 32, 27, 45],
    "工龄":   [2, 5, 8, 3, 12, 6, 1, 15],
    "绩效分": [78, 85, 92, 70, 95, 80, 65, 88]
}
import pandas as pd
df_corr = pd.DataFrame(data)
corr_matrix = df_corr.corr()            # 计算相关系数矩阵

plt.figure(figsize=(8, 6))
sns.heatmap(corr_matrix, annot=True, fmt=".2f", cmap="RdBu_r",
            vmin=-1, vmax=1, center=0,
            linewidths=0.5)
plt.title("各变量相关性热力图", fontsize=16)
plt.tight_layout()
plt.savefig("heatmap.png", dpi=150)
plt.show()
```

#### Seaborn 箱线图

```python
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

plt.rcParams["font.sans-serif"] = ["SimHei"]
plt.rcParams["axes.unicode_minus"] = False

np.random.seed(42)
df = pd.DataFrame({
    "部门": np.repeat(["技术部", "市场部", "运营部"], 30),
    "薪资": np.concatenate([
        np.random.normal(15000, 3000, 30),
        np.random.normal(12000, 2500, 30),
        np.random.normal(9000,  2000, 30)
    ])
})

plt.figure(figsize=(8, 5))
sns.boxplot(x="部门", y="薪资", data=df, palette="Set2")
plt.title("各部门薪资分布（箱线图）", fontsize=16)
plt.ylabel("薪资（元）", fontsize=12)
plt.tight_layout()
plt.savefig("boxplot.png", dpi=150)
plt.show()
# 箱线图解读：箱体=25%~75%分位，中线=中位数，须=1.5倍IQR范围，点=离群值
```

---

### 2.6 完整案例：电商销售数据分析

下面演示一个从 CSV 读取到出报告的**完整流程**。假设原始数据如下（实际工作中通常直接读 CSV）：

```python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

plt.rcParams["font.sans-serif"] = ["SimHei"]
plt.rcParams["axes.unicode_minus"] = False

# ═══════════════════════════════════════════════════
# 第1步：读取数据
# ═══════════════════════════════════════════════════
# 实际工作：df = pd.read_csv("sales_data.csv", encoding="utf-8")
# 这里用模拟数据演示

np.random.seed(42)
n = 500
df = pd.DataFrame({
    "订单ID":    range(10001, 10001 + n),
    "日期":      pd.date_range("2024-01-01", periods=n, freq="D"),
    "品类":      np.random.choice(["电子产品", "服装", "食品", "家居", "图书"], n),
    "城市":      np.random.choice(["北京", "上海", "广州", "深圳", "杭州", "成都"], n),
    "金额":      np.random.exponential(300, n).round(2),  # 金额服从指数分布
    "数量":      np.random.randint(1, 10, n),
    "是否退款":  np.random.choice([0, 1], n, p=[0.9, 0.1]),  # 10%退款率
})
df["实付金额"] = df["金额"] * df["数量"] * (1 - df["是否退款"])  # 退款则为0

print(f"数据量：{len(df)} 行")
print(df.head())

# ═══════════════════════════════════════════════════
# 第2步：数据概览
# ═══════════════════════════════════════════════════
print("\n── 基本信息 ──")
print(df.info())
print("\n── 描述性统计 ──")
print(df.describe())

# ═══════════════════════════════════════════════════
# 第3步：核心指标计算
# ═══════════════════════════════════════════════════
total_revenue = df["实付金额"].sum()
avg_order_value = df["实付金额"].mean()
refund_rate = df["是否退款"].mean()
total_orders = len(df)

print(f"\n{'='*40}")
print(f"  总营收：¥{total_revenue:,.2f}")
print(f"  订单量：{total_orders}")
print(f"  客单价：¥{avg_order_value:,.2f}")
print(f"  退款率：{refund_rate:.1%}")
print(f"{'='*40}")

# ═══════════════════════════════════════════════════
# 第4步：各品类分析
# ═══════════════════════════════════════════════════
category_stats = df.groupby("品类").agg(
    订单数=("订单ID", "count"),
    总营收=("实付金额", "sum"),
    客单价=("实付金额", "mean"),
    退款率=("是否退款", "mean")
).sort_values("总营收", ascending=False)

print("\n── 各品类统计 ──")
print(category_stats)

# ═══════════════════════════════════════════════════
# 第5步：可视化
# ═══════════════════════════════════════════════════
fig, axes = plt.subplots(2, 2, figsize=(14, 10))

# 5-1 各品类营收柱状图
category_stats["总营收"].plot(kind="bar", ax=axes[0, 0], color="#4e79a7")
axes[0, 0].set_title("各品类总营收", fontsize=14)
axes[0, 0].set_ylabel("营收（元）")
axes[0, 0].tick_params(axis="x", rotation=0)

# 5-2 各城市订单量
city_orders = df["城市"].value_counts()
city_orders.plot(kind="bar", ax=axes[0, 1], color="#f28e2b")
axes[0, 1].set_title("各城市订单量", fontsize=14)
axes[0, 1].set_ylabel("订单数")
axes[0, 1].tick_params(axis="x", rotation=0)

# 5-3 月度营收趋势
monthly = df.set_index("日期")["实付金额"].resample("M").sum()
monthly.plot(ax=axes[1, 0], marker="o", color="#2ca02c", linewidth=2)
axes[1, 0].set_title("月度营收趋势", fontsize=14)
axes[1, 0].set_ylabel("营收（元）")
axes[1, 0].grid(alpha=0.3)

# 5-4 退款率饼图
refund_counts = df["是否退款"].value_counts()
axes[1, 1].pie(refund_counts, labels=["未退款", "已退款"],
               autopct="%1.1f%%", colors=["#76b7b2", "#e15759"],
               startangle=90, textprops={"fontsize": 12})
axes[1, 1].set_title("退款比例", fontsize=14)

plt.suptitle("电商销售数据分析报告", fontsize=18, y=1.02)
plt.tight_layout()
plt.savefig("ecommerce_report.png", dpi=150, bbox_inches="tight")
plt.show()

# ═══════════════════════════════════════════════════
# 第6步：输出结论
# ═══════════════════════════════════════════════════
top_category = category_stats.index[0]
top_city = city_orders.index[0]
print(f"\n📊 分析结论：")
print(f"  1. 营收最高的品类：{top_category}（¥{category_stats.loc[top_category, '总营收']:,.2f}）")
print(f"  2. 订单最多的城市：{top_city}（{city_orders[top_city]} 单）")
print(f"  3. 整体退款率：{refund_rate:.1%}，建议关注退款原因")
print(f"  4. 客单价：¥{avg_order_value:,.2f}，可考虑提升客单价的运营策略")
```

---

### 2.7 常见新手坑

| 序号 | 坑 | 说明 | 正确做法 |
|------|---|------|---------|
| 1 | **SettingWithCopyWarning** | 链式赋值 `df[df["age"]>30]["salary"] = 999` 触发警告，改的是副本不是原表 | 用 `.loc`：`df.loc[df["age"]>30, "salary"] = 999` |
| 2 | **中文乱码** | Matplotlib 默认不显示中文，标题/标签变方块 | 设 `rcParams["font.sans-serif"] = ["SimHei"]`（见 2.5 节） |
| 3 | **CSV 编码错误** | `UnicodeDecodeError` | 先用 `encoding="gbk"` 或 `"utf-8-sig"` 试试 |
| 4 | **Pandas 链式索引** | `df[df["a"]>0]["b"]` 返回副本，后续修改不生效 | 统一用 `df.loc[条件, 列名]` |
| 5 | **NumPy 广播报错** | 形状不兼容时报 `ValueError: operands could not be broadcast` | 检查两个数组的 shape，确保满足广播规则（末维相同或一方为1） |
| 6 | **`inplace=True` 不可靠** | `df.dropna(inplace=True)` 在某些场景下不生效 | 改用赋值：`df = df.dropna()` |
| 7 | **大文件内存溢出** | `pd.read_csv()` 默认全部加载到内存 | 用 `chunksize` 分块读，或指定 `usecols` 只读需要的列 |
| 8 | **日期解析慢** | `pd.read_csv(parse_dates=["col"])` 对大文件很慢 | 改用 `pd.to_datetime()` 读完后单独转换，或指定 `format` 参数 |
| 9 | **`==` 判断 NaN** | `NaN == NaN` 返回 `False` | 用 `pd.isna()` 或 `df.isnull()` |
| 10 | **忘记 `import`** | `NameError: name 'np' is not defined` | 每个脚本开头统一导入：`import numpy as np; import pandas as pd; import matplotlib.pyplot as plt` |

**大文件分块读取示例**：

```python
import pandas as pd

# 方式一：分块迭代处理
chunk_summary = []
for chunk in pd.read_csv("huge_file.csv", chunksize=10000, encoding="utf-8"):
    # 每次只读 10000 行，处理完释放内存
    result = chunk.groupby("品类")["金额"].sum()
    chunk_summary.append(result)

# 合并各块结果
final = pd.concat(chunk_summary).groupby(level=0).sum()
print(final)

# 方式二：只读需要的列（大幅减少内存）
df = pd.read_csv("huge_file.csv", usecols=["品类", "金额"], encoding="utf-8")
```

**数据科学工具链全景**：

```
数据科学工具链：
├── 数据处理：NumPy / Pandas / Polars（更快）
├── 可视化：Matplotlib / Seaborn / Plotly / Bokeh
├── 机器学习：Scikit-learn / XGBoost / LightGBM
├── 深度学习：PyTorch / TensorFlow / JAX
├── notebooks：Jupyter / JupyterLab / Google Colab
├── 大数据：PySpark / Dask / Ray
├── 特征工程：Feature-engine / category_encoders
└── AutoML：Auto-sklearn / TPOT / H2O
```

---

## 3. 网络爬虫与数据采集

### 3.1 爬虫是什么？合法边界

**爬虫原理**：网络爬虫（Web Crawler / Spider）本质上是一个自动化程序，它模拟浏览器向服务器发送 HTTP 请求，获取网页内容，然后从中提取需要的数据。

```
爬虫工作流程：
用户程序 → 发送 HTTP 请求 → 目标服务器 → 返回 HTML/JSON → 解析提取数据 → 存储
    │            │                                              │
    └→ 构造 URL  └→ 添加请求头/Cookie                           └→ CSS/XPath/JSON
```

**robots.txt**：网站通过 `robots.txt` 文件声明哪些页面允许/禁止爬取。访问方式：`https://example.com/robots.txt`

```
# robots.txt 示例
User-agent: *          # 对所有爬虫生效
Allow: /public/        # 允许爬取 /public/ 下的页面
Disallow: /admin/      # 禁止爬取 /admin/ 下的页面
Disallow: /private/    # 禁止爬取 /private/ 下的页面
Crawl-delay: 5         # 请求间隔至少 5 秒
```

> ⚠️ **法律注意事项**：
> 1. **遵守 robots.txt**：虽然它不是法律强制要求，但违反可能被视为不正当竞争
> 2. **不爬取个人隐私数据**：手机号、身份证、住址等属于个人信息，未经授权采集违法
> 3. **控制请求频率**：高频请求可能构成 DDOS 攻击，务必加延迟（建议至少 1-3 秒）
> 4. **尊重版权**：爬取的内容用于商业用途需获得授权
> 5. **不绕过登录限制**：绕过付费墙或登录验证可能违法
> 6. **了解《数据安全法》《个人信息保护法》**：中国法律对数据采集有明确约束

### 3.2 从零上手：requests + BeautifulSoup

**安装依赖**：

```bash
pip install requests beautifulsoup4 lxml
```

**发送请求（GET/POST、请求头、Cookie、Session）**：

```python
import requests
from bs4 import BeautifulSoup

# ===== 1. 最简单的 GET 请求 =====
response = requests.get("https://httpbin.org/get", timeout=10)
print(f"状态码: {response.status_code}")   # 200 表示成功
print(f"响应内容: {response.text[:200]}")  # 前面 200 个字符

# ===== 2. 带请求头（模拟浏览器，防止被拒绝） =====
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
                  "(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8",
}
response = requests.get("https://httpbin.org/get", headers=headers, timeout=10)
print(response.json())  # httpbin 返回 JSON，可以看到请求头已被修改

# ===== 3. GET 请求带参数 =====
params = {
    "q": "Python 爬虫",
    "page": 1,
}
response = requests.get("https://httpbin.org/get", params=params, timeout=10)
print(response.json()["args"])  # {'q': 'Python 爬虫', 'page': '1'}

# ===== 4. POST 请求（提交表单 / JSON） =====
# 提交表单数据
form_data = {"username": "admin", "password": "123456"}
response = requests.post("https://httpbin.org/post", data=form_data, timeout=10)
print(response.json()["form"])  # {'username': 'admin', 'password': '123456'}

# 提交 JSON 数据
json_data = {"title": "测试", "content": "Hello"}
response = requests.post("https://httpbin.org/post", json=json_data, timeout=10)
print(response.json()["json"])  # {'title': '测试', 'content': 'Hello'}

# ===== 5. 使用 Cookie =====
# 方式一：手动设置 Cookie
cookies = {"session_id": "abc123", "user": "admin"}
response = requests.get("https://httpbin.org/cookies", cookies=cookies, timeout=10)
print(response.json()["cookies"])  # {'session_id': 'abc123', 'user': 'admin'}

# 方式二：从响应中获取 Cookie
response = requests.post("https://httpbin.org/cookies/set?name=value", timeout=10)
print(response.cookies.get_dict())  # {'name': 'value'}

# ===== 6. 使用 Session（自动管理 Cookie，模拟登录状态） =====
session = requests.Session()
session.headers.update({"User-Agent": "Mozilla/5.0 ..."})
# 第一次请求：登录（服务器会返回 Set-Cookie）
session.post("https://httpbin.org/cookies/set?token=mytoken", timeout=10)
# 后续请求自动携带 Cookie
response = session.get("https://httpbin.org/cookies", timeout=10)
print(response.json()["cookies"])  # {'token': 'mytoken'}
session.close()  # 用完关闭
```

**解析 HTML（find/find_all、CSS 选择器）**：

```python
from bs4 import BeautifulSoup

# 模拟一个网页 HTML
html = """
<!DOCTYPE html>
<html>
<head><title>示例网站</title></head>
<body>
    <div class="container">
        <h1 class="title">新闻列表</h1>
        <div class="news-list">
            <article class="news-item" data-id="1">
                <h2 class="news-title"><a href="/news/1">Python 3.12 正式发布</a></h2>
                <p class="summary">新版本带来了更快的性能和更多特性。</p>
                <span class="tag">技术</span>
                <span class="date">2024-10-01</span>
            </article>
            <article class="news-item" data-id="2">
                <h2 class="news-title"><a href="/news/2">AI 改变世界</a></h2>
                <p class="summary">人工智能正在重塑各行各业。</p>
                <span class="tag">AI</span>
                <span class="date">2024-10-02</span>
            </article>
            <article class="news-item" data-id="3">
                <h2 class="news-title"><a href="/news/3">爬虫入门教程</a></h2>
                <p class="summary">从零开始学习 Python 爬虫。</p>
                <span class="tag">教程</span>
                <span class="date">2024-10-03</span>
            </article>
        </div>
        <div id="sidebar">
            <ul class="hot-topics">
                <li><a href="/topic/python">Python</a></li>
                <li><a href="/topic/ai">AI</a></li>
            </ul>
        </div>
    </div>
</body>
</html>
"""

soup = BeautifulSoup(html, "lxml")  # 也可以用 "html.parser"

# ===== 1. find —— 找第一个匹配的元素 =====
title = soup.find("h1", class_="title")
print(title.get_text())  # "新闻列表"

# ===== 2. find_all —— 找所有匹配的元素 =====
articles = soup.find_all("article", class_="news-item")
for article in articles:
    # 获取子元素
    title_tag = article.find("h2", class_="news-title")
    link_tag = title_tag.find("a")
    summary = article.find("p", class_="summary")
    tag = article.find("span", class_="tag")
    date = article.find("span", class_="date")

    print(f"标题: {link_tag.get_text()}")
    print(f"链接: {link_tag['href']}")
    print(f"摘要: {summary.get_text()}")
    print(f"标签: {tag.get_text()}")
    print(f"日期: {date.get_text()}")
    print("---")

# ===== 3. CSS 选择器（更灵活，类似 jQuery） =====
# select_one —— 找第一个
first_article = soup.select_one("article.news-item")
print(first_article.select_one("a")["href"])  # "/news/1"

# select —— 找所有
all_links = soup.select("article.news-item a")
for link in all_links:
    print(f"{link.get_text()}: {link['href']}")

# 属性选择器
article_with_id = soup.select_one('article[data-id="2"]')
print(article_with_id.select_one(".news-title").get_text())  # "AI 改变世界"

# 组合选择器
sidebar_links = soup.select("#sidebar .hot-topics a")
for link in sidebar_links:
    print(link.get_text(), link["href"])

# ===== 4. 获取属性和文本 =====
article = soup.select_one("article.news-item")
print(article.get_text(strip=True))     # 所有文本（合并）
print(article["data-id"])               # 属性值：'1'
print(article.get("data-id"))           # 属性值：'1'（不存在返回 None）
print(article.attrs)                    # 所有属性字典
```

**保存数据（CSV/JSON/数据库）**：

```python
import csv
import json
import sqlite3
import requests
from bs4 import BeautifulSoup

# 先采集数据（假设已经拿到新闻列表）
# 这里用模拟数据演示保存方式
news_list = [
    {"title": "Python 3.12 正式发布", "link": "/news/1", "tag": "技术", "date": "2024-10-01"},
    {"title": "AI 改变世界", "link": "/news/2", "tag": "AI", "date": "2024-10-02"},
    {"title": "爬虫入门教程", "link": "/news/3", "tag": "教程", "date": "2024-10-03"},
]

# ===== 1. 保存为 CSV =====
with open("news.csv", "w", newline="", encoding="utf-8-sig") as f:
    writer = csv.DictWriter(f, fieldnames=["title", "link", "tag", "date"])
    writer.writeheader()         # 写入表头
    writer.writerows(news_list)  # 写入所有数据
print("已保存到 news.csv")

# ===== 2. 保存为 JSON =====
with open("news.json", "w", encoding="utf-8") as f:
    json.dump(news_list, f, ensure_ascii=False, indent=2)
print("已保存到 news.json")

# ===== 3. 保存到 SQLite 数据库 =====
conn = sqlite3.connect("news.db")
cursor = conn.cursor()

# 创建表
cursor.execute("""
    CREATE TABLE IF NOT EXISTS news (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        link TEXT,
        tag TEXT,
        date TEXT
    )
""")

# 插入数据
for item in news_list:
    cursor.execute(
        "INSERT INTO news (title, link, tag, date) VALUES (?, ?, ?, ?)",
        (item["title"], item["link"], item["tag"], item["date"])
    )

conn.commit()

# 验证：查询数据
cursor.execute("SELECT * FROM news")
for row in cursor.fetchall():
    print(row)

conn.close()
print("已保存到 news.db")
```

### 3.3 动态页面爬取

很多现代网站使用 JavaScript 动态加载数据，requests 只能拿到初始 HTML，看不到动态内容。这时需要用 **Playwright** 让浏览器自动渲染页面。

```bash
pip install playwright
playwright install chromium  # 下载浏览器（只需执行一次）
```

```python
from playwright.sync_api import sync_playwright
import json
import time

def scrape_dynamic_page():
    """使用 Playwright 爬取动态加载的网页。"""
    with sync_playwright() as p:
        # 启动浏览器（headless=True 表示不显示浏览器窗口）
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()

        # 设置请求头
        page.set_extra_http_headers({
            "Accept-Language": "zh-CN,zh;q=0.9",
        })

        # 访问目标页面
        page.goto("https://news.ycombinator.com/", wait_until="networkidle")
        # wait_until="networkidle" 表示等到网络请求基本结束

        # 等待特定元素出现
        page.wait_for_selector(".athing")

        # ===== 方法1：用 Playwright 内置选择器提取数据 =====
        items = page.query_selector_all(".athing")
        results = []
        for item in items[:10]:  # 只取前 10 条
            title_el = item.query_selector(".titleline > a")
            if title_el:
                title = title_el.inner_text()
                link = title_el.get_attribute("href")
                results.append({"title": title, "link": link})

        # ===== 方法2：用 BeautifulSoup 解析（更灵活） =====
        # 获取完整渲染后的 HTML
        html = page.content()
        from bs4 import BeautifulSoup
        soup = BeautifulSoup(html, "lxml")
        # 后续和 3.2 节一样解析...

        # ===== 截图（调试用） =====
        page.screenshot(path="screenshot.png")

        # ===== 滚动加载（无限滚动页面） =====
        # for i in range(3):  # 滚动 3 次
        #     page.evaluate("window.scrollTo(0, document.body.scrollHeight)")
        #     page.wait_for_timeout(2000)  # 等待 2 秒加载

        # ===== 模拟点击（如"加载更多"按钮） =====
        # more_btn = page.query_selector(".load-more")
        # if more_btn:
        #     more_btn.click()
        #     page.wait_for_timeout(2000)

        browser.close()

    return results

# 运行
data = scrape_dynamic_page()
for item in data:
    print(f"标题: {item['title']}")
    print(f"链接: {item['link']}")
    print("---")

# 保存结果
with open("hacker_news.json", "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
```

### 3.4 Scrapy 框架入门

Scrapy 是 Python 最强大的爬虫框架，适合大规模、结构化的爬虫项目。

**安装和创建项目**：

```bash
pip install scrapy

# 创建项目
scrapy startproject news_spider
cd news_spider

# 创建爬虫
scrapy genspider quotes quotes.toscrape.com
```

**项目结构**：

```
news_spider/
├── scrapy.cfg                # 项目配置
└── news_spider/
    ├── __init__.py
    ├── items.py              # 数据结构定义
    ├── middlewares.py        # 中间件
    ├── pipelines.py          # 数据管道
    ├── settings.py           # 全局设置
    └── spiders/
        ├── __init__.py
        └── quotes_spider.py  # 爬虫文件
```

**定义 Item（items.py）**：

```python
import scrapy

class NewsSpiderItem(scrapy.Item):
    """定义要采集的数据字段。"""
    title = scrapy.Field()     # 标题
    author = scrapy.Field()    # 作者
    tags = scrapy.Field()      # 标签
    content = scrapy.Field()   # 内容
```

**编写 Spider（spiders/quotes_spider.py）**：

```python
import scrapy
from news_spider.items import NewsSpiderItem

class QuotesSpider(scrapy.Spider):
    """Quotes 网站爬虫 —— Scrapy 入门示例。"""

    name = "quotes"                       # 爬虫名称（唯一标识）
    allowed_domains = ["quotes.toscrape.com"]  # 限制爬取域名
    start_urls = ["https://quotes.toscrape.com/"]  # 起始 URL

    def parse(self, response):
        """解析页面，提取数据。"""
        # 使用 CSS 选择器提取所有名言块
        for quote in response.css("div.quote"):
            item = NewsSpiderItem()
            item["title"] = quote.css("span.text::text").get()     # 名言内容
            item["author"] = quote.css("small.author::text").get() # 作者
            item["tags"] = quote.css("div.tags a.tag::text").getall()  # 标签列表
            item["content"] = None
            yield item  # 交给 Pipeline 处理

        # 翻页：提取下一页链接，继续爬取
        next_page = response.css("li.next a::attr(href)").get()
        if next_page:
            yield response.follow(next_page, callback=self.parse)
            # response.follow 会自动拼接完整 URL

    # 也可以用 XPath 选择器（更灵活）
    # def parse(self, response):
    #     for quote in response.xpath('//div[@class="quote"]'):
    #         item = NewsSpiderItem()
    #         item["title"] = quote.xpath('.//span[@class="text"]/text()').get()
    #         item["author"] = quote.xpath('.//small[@class="author"]/text()').get()
    #         yield item
```

**数据管道 Pipeline（pipelines.py）**：

```python
import json
import csv
import sqlite3

class JsonPipeline:
    """将数据保存为 JSON 文件。"""

    def open_spider(self, spider):
        """爬虫启动时调用。"""
        self.file = open("quotes.json", "w", encoding="utf-8")
        self.data = []

    def close_spider(self, spider):
        """爬虫关闭时调用。"""
        json.dump(self.data, self.file, ensure_ascii=False, indent=2)
        self.file.close()

    def process_item(self, item, spider):
        """处理每一条数据。"""
        self.data.append(dict(item))
        return item  # 必须返回 item，交给下一个 Pipeline


class CsvPipeline:
    """将数据保存为 CSV 文件。"""

    def open_spider(self, spider):
        self.file = open("quotes.csv", "w", newline="", encoding="utf-8-sig")
        self.writer = csv.DictWriter(
            self.file, fieldnames=["title", "author", "tags", "content"]
        )
        self.writer.writeheader()

    def close_spider(self, spider):
        self.file.close()

    def process_item(self, item, spider):
        self.writer.writerow(dict(item))
        return item


class SQLitePipeline:
    """将数据保存到 SQLite 数据库。"""

    def open_spider(self, spider):
        self.conn = sqlite3.connect("quotes.db")
        self.cursor = self.conn.cursor()
        self.cursor.execute("""
            CREATE TABLE IF NOT EXISTS quotes (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT,
                author TEXT,
                tags TEXT,
                content TEXT
            )
        """)

    def close_spider(self, spider):
        self.conn.commit()
        self.conn.close()

    def process_item(self, item, spider):
        self.cursor.execute(
            "INSERT INTO quotes (title, author, tags, content) VALUES (?, ?, ?, ?)",
            (item["title"], item["author"], json.dumps(item["tags"], ensure_ascii=False), item["content"])
        )
        return item
```

**配置 Pipeline（settings.py）**：

```python
# settings.py 中启用 Pipeline（取消注释并修改）
ITEM_PIPELINES = {
    "news_spider.pipelines.JsonPipeline": 300,    # 数字越小优先级越高
    # "news_spider.pipelines.CsvPipeline": 400,
    # "news_spider.pipelines.SQLitePipeline": 500,
}

# 其他常用设置
ROBOTSTXT_OBEY = True          # 遵守 robots.txt
DOWNLOAD_DELAY = 2             # 请求间隔 2 秒
CONCURRENT_REQUESTS = 8        # 并发请求数
USER_AGENT = "Mozilla/5.0 ..." # 自定义 UA
FEED_EXPORT_ENCODING = "utf-8" # 导出编码
```

**运行命令**：

```bash
# 运行指定爬虫
scrapy crawl quotes

# 运行并导出为 JSON 文件
scrapy crawl quotes -o quotes.json

# 运行并导出为 CSV 文件
scrapy crawl quotes -o quotes.csv -t csv

# 调试模式（在 Shell 中测试选择器）
scrapy shell "https://quotes.toscrape.com/"
>>> response.css("span.text::text").getall()
```

### 3.5 反反爬技巧

网站会使用各种手段阻止爬虫，以下是常见应对方法：

```python
import random
import time
import requests
from itertools import cycle

# ===== 1. User-Agent 轮换 =====
# 每次请求使用不同的 UA，避免被识别为爬虫
USER_AGENTS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 Chrome/119.0.0.0 Safari/537.36",
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 Chrome/120.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 Safari/17.1",
]

def get_random_ua():
    """随机获取一个 User-Agent。"""
    return random.choice(USER_AGENTS)

# 使用
headers = {"User-Agent": get_random_ua()}
response = requests.get("https://httpbin.org/user-agent", headers=headers, timeout=10)
print(response.json()["user-agent"])

# ===== 2. 代理池 =====
# 通过代理 IP 发送请求，隐藏真实 IP
PROXIES = [
    "http://proxy1:8080",
    "http://proxy2:8080",
    "http://proxy3:8080",
    # 实际使用中从代理服务商获取，如快代理、芝麻代理等
]

proxy_pool = cycle(PROXIES)  # 循环使用代理

def request_with_proxy(url, max_retries=3):
    """使用代理池发送请求，失败自动重试。"""
    for attempt in range(max_retries):
        proxy = next(proxy_pool)
        proxies = {"http": proxy, "https": proxy}
        try:
            response = requests.get(
                url,
                headers={"User-Agent": get_random_ua()},
                proxies=proxies,
                timeout=10,
            )
            if response.status_code == 200:
                return response
        except requests.RequestException as e:
            print(f"代理 {proxy} 请求失败（第 {attempt + 1} 次）: {e}")
            continue
    return None

# ===== 3. 请求频率控制 =====
def polite_crawl(urls, min_delay=1, max_delay=3):
    """礼貌爬取：控制请求频率，避免给服务器造成压力。"""
    results = []
    session = requests.Session()

    for i, url in enumerate(urls):
        # 随机延迟 1~3 秒
        delay = random.uniform(min_delay, max_delay)
        time.sleep(delay)

        try:
            response = session.get(
                url,
                headers={"User-Agent": get_random_ua()},
                timeout=10,
            )
            if response.status_code == 200:
                results.append(response)
                print(f"[{i + 1}/{len(urls)}] 成功: {url}")
            else:
                print(f"[{i + 1}/{len(urls)}] 状态码 {response.status_code}: {url}")
        except requests.RequestException as e:
            print(f"[{i + 1}/{len(urls)}] 失败: {url} - {e}")

    return results

# 使用
# urls = ["https://example.com/page/1", "https://example.com/page/2"]
# responses = polite_crawl(urls)
```

### 3.6 完整案例：新闻网站爬虫

将前面学到的知识整合起来，写一个完整的新闻爬虫项目：

```python
"""
完整案例：新闻网站爬虫
目标网站：https://quotes.toscrape.com/（专为学习爬虫设计的网站）
功能：采集名言、作者、标签，保存为 CSV 和 JSON
"""

import csv
import json
import random
import time
import requests
from bs4 import BeautifulSoup

class NewsSpider:
    """新闻网站爬虫（requests + BeautifulSoup 版）。"""

    def __init__(self):
        self.base_url = "https://quotes.toscrape.com"
        self.session = requests.Session()
        self.session.headers.update({
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                          "AppleWebKit/537.36 Chrome/120.0.0.0 Safari/537.36",
        })
        self.results = []

    def fetch_page(self, url):
        """发送请求并返回 BeautifulSoup 对象。"""
        try:
            response = self.session.get(url, timeout=10)
            response.raise_for_status()  # 状态码非 200 抛异常
            return BeautifulSoup(response.text, "lxml")
        except requests.RequestException as e:
            print(f"请求失败: {url} - {e}")
            return None

    def parse_page(self, soup):
        """解析单个页面，提取数据。"""
        items = []
        for quote in soup.select("div.quote"):
            item = {
                "text": quote.select_one("span.text").get_text(),
                "author": quote.select_one("small.author").get_text(),
                "tags": [tag.get_text() for tag in quote.select("div.tags a.tag")],
            }
            items.append(item)
        return items

    def get_next_page(self, soup):
        """获取下一页的 URL，没有则返回 None。"""
        next_link = soup.select_one("li.next a")
        if next_link:
            return self.base_url + next_link["href"]
        return None

    def crawl(self, max_pages=5):
        """主爬取逻辑。"""
        url = self.base_url + "/page/1/"
        page_count = 0

        while url and page_count < max_pages:
            page_count += 1
            print(f"正在爬取第 {page_count} 页: {url}")

            soup = self.fetch_page(url)
            if not soup:
                break

            # 提取数据
            items = self.parse_page(soup)
            self.results.extend(items)
            print(f"  本页采集 {len(items)} 条数据")

            # 获取下一页
            url = self.get_next_page(soup)

            # 礼貌延迟
            time.sleep(random.uniform(1, 2))

        print(f"\n爬取完成！共采集 {len(self.results)} 条数据")

    def save_csv(self, filename="quotes.csv"):
        """保存为 CSV。"""
        with open(filename, "w", newline="", encoding="utf-8-sig") as f:
            writer = csv.DictWriter(f, fieldnames=["text", "author", "tags"])
            writer.writeheader()
            for item in self.results:
                writer.writerow({
                    "text": item["text"],
                    "author": item["author"],
                    "tags": "|".join(item["tags"]),  # 列表转字符串
                })
        print(f"已保存到 {filename}")

    def save_json(self, filename="quotes.json"):
        """保存为 JSON。"""
        with open(filename, "w", encoding="utf-8") as f:
            json.dump(self.results, f, ensure_ascii=False, indent=2)
        print(f"已保存到 {filename}")

# ===== 运行 =====
if __name__ == "__main__":
    spider = NewsSpider()
    spider.crawl(max_pages=5)
    spider.save_csv()
    spider.save_json()
```

### 3.7 常见新手坑

| 坑 | 说明 | 解决方案 |
|----|------|----------|
| **不设请求头** | 服务器返回 403 或空内容 | 始终添加 User-Agent |
| **不设超时** | 程序卡死在某个请求上 | 所有请求加 `timeout=10` |
| **频率太高** | IP 被封，或给服务器造成压力 | 每次请求后 `time.sleep(1~3)` |
| **编码错误** | 中文乱码 | 用 `response.encoding = response.apparent_encoding` 或指定 `utf-8` |
| **只看 HTML** | 数据是 JS 动态加载的 | 用 Playwright 或找 API 接口 |
| **不处理异常** | 网络波动导致程序崩溃 | 用 try-except 包裹请求代码 |
| **无视 robots.txt** | 可能面临法律风险 | 先检查 `域名/robots.txt` |
| **直接爬生产环境** | 高并发影响正常用户 | 优先找官方 API，限制并发数 |

---

## 4. 自动化运维与 DevOps

### 4.1 DevOps 是什么？日常工作

DevOps 是 Development（开发）和 Operations（运维）的组合词，核心理念是**打通开发与运维的壁垒，通过自动化实现软件的快速、可靠交付**。

**运维工程师的日常工作**：

```
日常运维工作：
├── 服务器管理
│   ├── 部署新服务、扩容缩容
│   ├── 监控服务器状态（CPU/内存/磁盘/网络）
│   └── 处理告警和故障
├── 自动化脚本
│   ├── 日志清理、备份归档
│   ├── 批量文件操作
│   └── 定时任务管理
├── CI/CD 流水线
│   ├── 代码提交 → 自动测试 → 自动构建 → 自动部署
│   └── 管理 GitHub Actions / Jenkins / GitLab CI
├── 容器与编排
│   ├── Docker 镜像构建与管理
│   └── K8s 集群维护
└── 云资源管理
    ├── AWS / 阿里云资源操作
    └── 成本监控与优化
```

> **一句话理解**：DevOps = 用代码和自动化工具来管理服务器、部署应用、监控状态，减少手动操作和人为失误。

### 4.2 从零上手：Python 运维脚本

#### 文件批量管理（查找大文件、清理日志、备份）

```python
"""
文件批量管理脚本
功能：查找大文件、清理过期日志、自动备份
"""
import os
import shutil
import time
from pathlib import Path
from datetime import datetime, timedelta


def find_large_files(directory: str, size_mb: int = 100) -> list[dict]:
    """查找指定目录下超过 size_mb 的大文件。"""
    threshold = size_mb * 1024 * 1024  # 转换为字节
    large_files = []

    for root, dirs, files in os.walk(directory):
        for filename in files:
            filepath = os.path.join(root, filename)
            try:
                file_size = os.path.getsize(filepath)
                if file_size > threshold:
                    large_files.append({
                        "path": filepath,
                        "size_mb": round(file_size / (1024 * 1024), 2),
                        "modified": datetime.fromtimestamp(
                            os.path.getmtime(filepath)
                        ).strftime("%Y-%m-%d %H:%M"),
                    })
            except (PermissionError, FileNotFoundError):
                continue  # 跳过无权限或已删除的文件

    # 按大小降序排列
    large_files.sort(key=lambda x: x["size_mb"], reverse=True)
    return large_files


def clean_old_logs(log_dir: str, days: int = 30) -> list[str]:
    """清理超过 days 天的旧日志文件。"""
    cutoff = time.time() - days * 86400  # 计算截止时间戳
    deleted = []

    for log_file in Path(log_dir).rglob("*.log"):
        # 也处理 .log.gz 等压缩日志
        if log_file.stat().st_mtime < cutoff:
            try:
                log_file.unlink()  # 删除文件
                deleted.append(str(log_file))
            except PermissionError:
                continue

    # 同时清理空的日志目录
    for subdir in sorted(Path(log_dir).rglob("*"), reverse=True):
        if subdir.is_dir() and not any(subdir.iterdir()):
            subdir.rmdir()

    return deleted


def backup_directory(
    src: str, dst: str, exclude: list[str] | None = None
) -> str:
    """将 src 目录备份到 dst，自动添加日期后缀。"""
    exclude = exclude or []
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_name = f"{Path(src).name}_backup_{timestamp}"
    backup_path = os.path.join(dst, backup_name)

    # 如果目标目录不存在，先创建
    os.makedirs(dst, exist_ok=True)

    # 复制整个目录，忽略指定文件
    def ignore_patterns(path, names):
        return [n for n in names if n in exclude]

    shutil.copytree(src, backup_path, ignore=ignore_patterns)
    return backup_path


# ===== 使用示例 =====
if __name__ == "__main__":
    # 1. 查找大文件
    print("=== 查找大文件 ===")
    big_files = find_large_files("/var/log", size_mb=10)
    for f in big_files[:10]:  # 只显示前 10 个
        print(f"  {f['size_mb']} MB  {f['modified']}  {f['path']}")

    # 2. 清理 30 天前的旧日志
    print("\n=== 清理旧日志 ===")
    deleted_logs = clean_old_logs("/var/log/app", days=30)
    print(f"  已清理 {len(deleted_logs)} 个日志文件")

    # 3. 备份目录
    print("\n=== 备份目录 ===")
    backup_path = backup_directory(
        src="/home/user/project",
        dst="/backup",
        exclude=["__pycache__", ".git", "node_modules"],
    )
    print(f"  备份完成: {backup_path}")
```

#### 系统监控脚本（CPU / 内存 / 磁盘）

```python
"""
系统监控脚本
功能：实时监控 CPU、内存、磁盘，超阈值自动告警
"""
import psutil
import time
import json
from datetime import datetime


class SystemMonitor:
    """系统资源监控器。"""

    def __init__(
        self,
        cpu_threshold: float = 80.0,
        memory_threshold: float = 85.0,
        disk_threshold: float = 90.0,
    ):
        self.cpu_threshold = cpu_threshold        # CPU 告警阈值（%）
        self.memory_threshold = memory_threshold  # 内存告警阈值（%）
        self.disk_threshold = disk_threshold      # 磁盘告警阈值（%）

    def get_cpu_info(self) -> dict:
        """获取 CPU 信息。"""
        return {
            "percent": psutil.cpu_percent(interval=1),     # 总使用率
            "per_cpu": psutil.cpu_percent(interval=1, percpu=True),  # 每核使用率
            "count_logical": psutil.cpu_count(),           # 逻辑核心数
            "count_physical": psutil.cpu_count(logical=False),  # 物理核心数
        }

    def get_memory_info(self) -> dict:
        """获取内存信息。"""
        mem = psutil.virtual_memory()
        return {
            "total_gb": round(mem.total / (1024 ** 3), 2),
            "used_gb": round(mem.used / (1024 ** 3), 2),
            "available_gb": round(mem.available / (1024 ** 3), 2),
            "percent": mem.percent,
        }

    def get_disk_info(self) -> list[dict]:
        """获取所有磁盘分区信息。"""
        disks = []
        for partition in psutil.disk_partitions():
            try:
                usage = psutil.disk_usage(partition.mountpoint)
                disks.append({
                    "mountpoint": partition.mountpoint,
                    "device": partition.device,
                    "fstype": partition.fstype,
                    "total_gb": round(usage.total / (1024 ** 3), 2),
                    "used_gb": round(usage.used / (1024 ** 3), 2),
                    "free_gb": round(usage.free / (1024 ** 3), 2),
                    "percent": usage.percent,
                })
            except (PermissionError, FileNotFoundError):
                continue
        return disks

    def get_top_processes(self, n: int = 5) -> list[dict]:
        """获取内存占用最高的前 n 个进程。"""
        processes = []
        for proc in psutil.process_iter(["pid", "name", "memory_percent", "cpu_percent"]):
            try:
                processes.append(proc.info)
            except (psutil.NoSuchProcess, psutil.AccessDenied):
                continue

        # 按内存占用降序排列
        processes.sort(key=lambda x: x.get("memory_percent", 0), reverse=True)
        return processes[:n]

    def check_alerts(self) -> list[str]:
        """检查是否有资源超阈值，返回告警列表。"""
        alerts = []

        # 检查 CPU
        cpu_percent = psutil.cpu_percent(interval=1)
        if cpu_percent > self.cpu_threshold:
            alerts.append(f"⚠ CPU 使用率 {cpu_percent}% 超过阈值 {self.cpu_threshold}%")

        # 检查内存
        mem = psutil.virtual_memory()
        if mem.percent > self.memory_threshold:
            alerts.append(f"⚠ 内存使用率 {mem.percent}% 超过阈值 {self.memory_threshold}%")

        # 检查磁盘
        for partition in psutil.disk_partitions():
            try:
                usage = psutil.disk_usage(partition.mountpoint)
                if usage.percent > self.disk_threshold:
                    alerts.append(
                        f"⚠ 磁盘 {partition.mountpoint} 使用率 {usage.percent}% "
                        f"超过阈值 {self.disk_threshold}%"
                    )
            except (PermissionError, FileNotFoundError):
                continue

        return alerts

    def run(self, interval: int = 60, times: int = 0):
        """
        持续监控。
        interval: 检查间隔（秒）
        times: 检查次数，0 表示无限
        """
        count = 0
        while times == 0 or count < times:
            count += 1
            timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

            print(f"\n{'='*50}")
            print(f"系统监控报告 [{timestamp}]  (第 {count} 次检查)")
            print(f"{'='*50}")

            # CPU 信息
            cpu = self.get_cpu_info()
            print(f"\n📊 CPU 使用率: {cpu['percent']}%  (共 {cpu['count_logical']} 核)")
            if len(cpu['per_cpu']) <= 8:
                for i, pct in enumerate(cpu['per_cpu']):
                    bar = "█" * int(pct / 5) + "░" * (20 - int(pct / 5))
                    print(f"  核心 {i}: [{bar}] {pct}%")

            # 内存信息
            mem = self.get_memory_info()
            print(f"\n💾 内存: {mem['used_gb']}/{mem['total_gb']} GB ({mem['percent']}%)")
            bar_len = int(mem['percent'] / 5)
            bar = "█" * bar_len + "░" * (20 - bar_len)
            print(f"  [{bar}] {mem['percent']}%")

            # 磁盘信息
            print(f"\n💽 磁盘:")
            for disk in self.get_disk_info():
                print(f"  {disk['mountpoint']}: "
                      f"{disk['used_gb']}/{disk['total_gb']} GB ({disk['percent']}%)")

            # 占用最高的进程
            print(f"\n🔝 内存占用 TOP 5:")
            for proc in self.get_top_processes(5):
                print(f"  PID {proc['pid']:>6}  "
                      f"{proc['name']:<20}  "
                      f"内存 {proc.get('memory_percent', 0):.1f}%")

            # 告警检查
            alerts = self.check_alerts()
            if alerts:
                print(f"\n🚨 告警:")
                for alert in alerts:
                    print(f"  {alert}")
            else:
                print(f"\n✅ 所有指标正常")

            if times == 0 or count < times:
                time.sleep(interval)


# ===== 使用示例 =====
if __name__ == "__main__":
    monitor = SystemMonitor(
        cpu_threshold=80.0,      # CPU 超过 80% 告警
        memory_threshold=85.0,   # 内存超过 85% 告警
        disk_threshold=90.0,     # 磁盘超过 90% 告警
    )
    # 检查 3 次，每次间隔 10 秒（演示用，实际建议 60 秒）
    monitor.run(interval=10, times=3)
```

#### 日志分析脚本（统计错误、提取关键信息）

```python
"""
日志分析脚本
功能：统计错误数量、按级别分类、提取关键信息、生成报告
"""
import re
from collections import Counter, defaultdict
from pathlib import Path
from datetime import datetime


class LogAnalyzer:
    """日志分析器。"""

    # 匹配常见日志格式的正则表达式
    # 格式示例：2025-07-24 10:30:45 [ERROR] Database connection failed
    LOG_PATTERN = re.compile(
        r"(?P<timestamp>\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2})\s+"
        r"\[(?P<level>DEBUG|INFO|WARNING|ERROR|CRITICAL)\]\s+"
        r"(?P<message>.*)"
    )

    def __init__(self, log_path: str):
        self.log_path = Path(log_path)
        self.entries = []       # 所有解析后的日志条目
        self.errors = []        # 错误日志
        self.level_counts = Counter()    # 各级别计数
        self.hourly_counts = defaultdict(int)  # 每小时日志计数

    def parse(self):
        """解析日志文件。"""
        with open(self.log_path, "r", encoding="utf-8") as f:
            for line_num, line in enumerate(f, 1):
                line = line.strip()
                if not line:
                    continue

                match = self.LOG_PATTERN.match(line)
                if match:
                    entry = {
                        "line": line_num,
                        "timestamp": match.group("timestamp"),
                        "level": match.group("level"),
                        "message": match.group("message"),
                    }
                    self.entries.append(entry)
                    self.level_counts[entry["level"]] += 1

                    # 提取小时用于统计
                    try:
                        hour = entry["timestamp"].split(" ")[1][:2]
                        self.hourly_counts[hour] += 1
                    except (IndexError, ValueError):
                        pass

                    # 收集错误日志
                    if entry["level"] in ("ERROR", "CRITICAL"):
                        self.errors.append(entry)
                else:
                    # 无法匹配的行，归为 UNKNOWN 级别
                    self.entries.append({
                        "line": line_num,
                        "timestamp": "",
                        "level": "UNKNOWN",
                        "message": line,
                    })
                    self.level_counts["UNKNOWN"] += 1

    def find_error_patterns(self) -> list[dict]:
        """找出重复出现的错误模式（按错误消息分类）。"""
        error_messages = Counter()
        for error in self.errors:
            # 去掉动态内容（如数字、ID），只保留模式
            pattern = re.sub(r"\d+", "N", error["message"])
            pattern = re.sub(r"0x[0-9a-fA-F]+", "0xHEX", pattern)
            error_messages[pattern] += 1

        # 返回出现次数最多的错误模式
        results = []
        for message, count in error_messages.most_common(10):
            # 找到该模式的一条完整日志作为示例
            example = next(
                e for e in self.errors
                if re.sub(r"\d+", "N", e["message"]) == message
            )
            results.append({
                "pattern": message,
                "count": count,
                "example": example,
            })
        return results

    def get_hourly_summary(self) -> dict[str, int]:
        """获取每小时的日志数量统计。"""
        return dict(sorted(self.hourly_counts.items()))

    def generate_report(self) -> str:
        """生成文本格式的分析报告。"""
        lines = []
        lines.append("=" * 60)
        lines.append(f"  日志分析报告: {self.log_path.name}")
        lines.append(f"  生成时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        lines.append("=" * 60)

        # 总体统计
        total = len(self.entries)
        lines.append(f"\n📊 总体统计:")
        lines.append(f"  总日志条数: {total}")
        for level, count in self.level_counts.most_common():
            pct = count / total * 100 if total > 0 else 0
            lines.append(f"  {level:<10} {count:>6} 条  ({pct:.1f}%)")

        # 错误统计
        lines.append(f"\n🚨 错误详情 ({len(self.errors)} 条):")
        for pattern_info in self.find_error_patterns():
            lines.append(
                f"  [{pattern_info['count']}次] {pattern_info['pattern']}"
            )
            lines.append(
                f"    示例: 行 {pattern_info['example']['line']} - "
                f"{pattern_info['example']['message']}"
            )

        # 每小时分布
        lines.append(f"\n📈 每小时日志分布:")
        hourly = self.get_hourly_summary()
        if hourly:
            max_count = max(hourly.values())
            for hour, count in hourly.items():
                bar_len = int(count / max(max_count, 1) * 30)
                bar = "█" * bar_len
                lines.append(f"  {hour}:00 [{bar}] {count}")

        return "\n".join(lines)


# ===== 使用示例 =====
if __name__ == "__main__":
    # 先创建一个示例日志文件用于测试
    sample_log = """2025-07-24 08:01:23 [INFO] Application started
2025-07-24 08:05:45 [INFO] User login: user_id=123
2025-07-24 08:10:12 [WARNING] Cache miss for key=product_456
2025-07-24 08:15:30 [ERROR] Database connection failed: timeout after 30s
2025-07-24 08:20:01 [INFO] Request processed: /api/users
2025-07-24 08:25:44 [ERROR] Database connection failed: timeout after 30s
2025-07-24 09:01:00 [INFO] Scheduled task started
2025-07-24 09:05:22 [CRITICAL] Out of memory: allocated 8192MB
2025-07-24 09:10:15 [ERROR] File not found: /data/report_789.csv
2025-07-24 09:30:00 [INFO] Backup completed successfully
2025-07-24 10:00:00 [INFO] Health check passed
2025-07-24 10:15:33 [ERROR] Database connection failed: timeout after 30s
2025-07-24 10:20:11 [WARNING] Disk usage at 85%
"""
    test_log_path = "test_app.log"
    with open(test_log_path, "w", encoding="utf-8") as f:
        f.write(sample_log)

    # 分析日志
    analyzer = LogAnalyzer(test_log_path)
    analyzer.parse()
    report = analyzer.generate_report()
    print(report)

    # 清理测试文件
    Path(test_log_path).unlink()
```

### 4.3 Docker 自动化

用 Python 操作 Docker，实现镜像构建、容器管理的自动化。

#### 安装 Docker SDK

```bash
pip install docker
```

#### 自动构建和部署

```python
"""
Docker 自动化脚本
功能：用 Python 操作 Docker，自动构建镜像、管理容器
"""
import docker
import time
from datetime import datetime


class DockerManager:
    """Docker 管理器。"""

    def __init__(self):
        # 连接本地 Docker 守护进程
        # 需要先安装 Docker 并启动 Docker 服务
        self.client = docker.from_env()

    def list_containers(self, all: bool = False) -> list[dict]:
        """列出容器。all=True 包含已停止的容器。"""
        containers = self.client.containers.list(all=all)
        result = []
        for c in containers:
            result.append({
                "id": c.short_id,
                "name": c.name,
                "image": str(c.image.tags),
                "status": c.status,
            })
        return result

    def build_image(self, path: str, tag: str) -> dict:
        """
        根据 Dockerfile 构建镜像。
        path: Dockerfile 所在目录
        tag: 镜像标签，如 "myapp:1.0"
        """
        print(f"正在构建镜像 {tag} ...")
        image, build_logs = self.client.images.build(
            path=path,
            tag=tag,
            rm=True,  # 构建完成后删除中间容器
        )
        # 打印构建日志
        for log in build_logs:
            if "stream" in log:
                print(f"  {log['stream']}", end="")

        return {
            "id": image.short_id,
            "tags": image.tags,
        }

    def run_container(
        self,
        image: str,
        name: str,
        ports: dict | None = None,
        env: dict | None = None,
        volumes: dict | None = None,
        detach: bool = True,
    ) -> dict:
        """
        运行容器。
        ports: 端口映射，如 {"8000/tcp": 8000}
        env: 环境变量，如 {"DEBUG": "true"}
        volumes: 挂载卷，如 {"./data": {"bind": "/app/data", "mode": "rw"}}
        """
        print(f"正在启动容器 {name} ...")
        container = self.client.containers.run(
            image=image,
            name=name,
            ports=ports,
            environment=env,
            volumes=volumes,
            detach=detach,  # 后台运行
        )

        if detach:
            # 等待容器启动
            time.sleep(2)
            container.reload()  # 刷新容器状态
            return {
                "id": container.short_id,
                "name": container.name,
                "status": container.status,
            }
        return {"output": container.decode("utf-8")}

    def get_container_logs(self, name: str, tail: int = 50) -> str:
        """获取容器日志。"""
        container = self.client.containers.get(name)
        return container.logs(tail=tail).decode("utf-8")

    def stop_container(self, name: str):
        """停止容器。"""
        container = self.client.containers.get(name)
        container.stop()
        print(f"容器 {name} 已停止")

    def remove_container(self, name: str, force: bool = False):
        """删除容器。"""
        container = self.client.containers.get(name)
        container.remove(force=force)
        print(f"容器 {name} 已删除")

    def cleanup_unused(self):
        """清理未使用的镜像、容器、网络。"""
        try:
            # 删除所有已停止的容器
            self.client.containers.prune()
            print("已清理停止的容器")
            # 删除未使用的镜像
            self.client.images.prune()
            print("已清理未使用的镜像")
        except Exception as e:
            print(f"清理失败: {e}")


# ===== 使用示例 =====
if __name__ == "__main__":
    dm = DockerManager()

    # 1. 列出当前运行的容器
    print("=== 当前容器 ===")
    for c in dm.list_containers(all=True):
        print(f"  {c['name']:<20} {c['status']:<15} {c['image']}")

    # 2. 构建镜像（需要有 Dockerfile）
    # image_info = dm.build_image(path="./myproject", tag="myapp:1.0")
    # print(f"构建完成: {image_info}")

    # 3. 运行容器
    # container_info = dm.run_container(
    #     image="myapp:1.0",
    #     name="myapp-server",
    #     ports={"8000/tcp": 8000},
    #     env={"DEBUG": "true"},
    # )
    # print(f"容器已启动: {container_info}")

    # 4. 查看日志
    # logs = dm.get_container_logs("myapp-server", tail=20)
    # print(logs)
```

### 4.4 CI/CD 自动化

**GitHub Actions + Python 示例**：在代码推送后自动运行测试和部署。

在项目根目录创建 `.github/workflows/ci.yml`：

```yaml
# .github/workflows/ci.yml
# GitHub Actions CI/CD 配置文件

name: Python CI/CD

# 触发条件：push 到 main 分支 或 提交 Pull Request
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    name: 测试
    runs-on: ubuntu-latest

    # 使用矩阵测试多个 Python 版本
    strategy:
      matrix:
        python-version: ["3.10", "3.11", "3.12"]

    steps:
      # 第1步：拉取代码
      - name: 检出代码
        uses: actions/checkout@v4

      # 第2步：安装 Python
      - name: 设置 Python ${{ matrix.python-version }}
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}

      # 第3步：安装依赖
      - name: 安装依赖
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt
          pip install pytest pytest-cov flake8

      # 第4步：代码风格检查
      - name: 代码风格检查
        run: flake8 src/ --max-line-length=88 --exclude=__pycache__

      # 第5步：运行测试
      - name: 运行测试
        run: |
          pytest tests/ -v --cov=src --cov-report=xml

      # 第6步：上传覆盖率报告
      - name: 上传覆盖率
        uses: codecov/codecov-action@v4

  deploy:
    name: 部署
    needs: test  # 测试通过后才执行部署
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'  # 只有 main 分支才部署

    steps:
      - name: 检出代码
        uses: actions/checkout@v4

      - name: 构建 Docker 镜像
        run: docker build -t myapp:latest .

      - name: 推送镜像到仓库
        run: |
          docker login -u ${{ secrets.DOCKER_USER }} -p ${{ secrets.DOCKER_PASS }}
          docker tag myapp:latest ${{ secrets.DOCKER_USER }}/myapp:latest
          docker push ${{ secrets.DOCKER_USER }}/myapp:latest
```

**配套的 Dockerfile**（放在项目根目录）：

```dockerfile
FROM python:3.11-slim

WORKDIR /app

# 先复制依赖文件，利用 Docker 缓存层
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 再复制源代码
COPY . .

# 健康检查
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')"

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

> **上手步骤**：
> 1. 在 GitHub 创建仓库，把代码推上去
> 2. 在仓库 Settings → Secrets 中添加 `DOCKER_USER` 和 `DOCKER_PASS`
> 3. 推送代码到 main 分支，GitHub Actions 会自动运行
> 4. 在仓库的 "Actions" 标签页查看运行结果

### 4.5 常见新手坑

| 坑 | 说明 | 解决方案 |
|---|---|---|
| **subprocess 乱码** | `subprocess.run` 返回中文乱码 | 加 `encoding="utf-8"` 参数 |
| **硬编码路径** | Windows 和 Linux 路径格式不同 | 用 `pathlib.Path` 代替字符串拼接 |
| **权限不足** | 操作系统文件/目录没有权限 | 用 `try-except PermissionError` 捕获 |
| **忘记 Docker 启动** | 代码连接 Docker 失败 | 先确认 `docker info` 能正常运行 |
| **GitHub Actions Secret 泄露** | 把密码写进 yml 明文 | 使用 `secrets.XXX` 引用，不要硬编码 |
| **psutil 跨平台差异** | 部分字段在 Windows 上返回 None | 做好 `None` 检查，参考 psutil 官方文档 |
| **日志正则不匹配** | 不同应用的日志格式不一样 | 先用 `head` 查看几行日志，再写正则 |
| **Docker 镜像太大** | 基础镜像用了完整版 Python | 使用 `python:3.11-slim` 或 Alpine 版 |

---

## 5. 人工智能与机器学习

### 5.1 AI/ML 是什么？岗位方向

**AI / ML / DL 的关系**：

```
人工智能 (AI)
└── 机器学习 (ML)         ← 用数据训练模型，让机器"学会"规则
    └── 深度学习 (DL)     ← 用神经网络自动提取特征
        ├── CNN（图像）
        ├── RNN/LSTM（序列）
        └── Transformer（NLP / LLM）
```

**不同岗位的工作内容**：

| 岗位 | 日常工作 | 核心技能 | 典型产出 |
|------|----------|----------|----------|
| **算法工程师** | 研究和改进算法，提升模型指标 | 数学推导、PyTorch/TensorFlow、论文阅读 | 算法专利、顶会论文、SOTA 模型 |
| **ML 工程师** | 将模型从实验推向生产环境 | Scikit-learn、MLOps、模型部署、数据管道 | 可用的 ML 服务、自动化流水线 |
| **数据科学家** | 从数据中提取洞察，辅助业务决策 | SQL、Pandas、统计分析、可视化、A/B 测试 | 分析报告、业务建议、预测模型 |
| **AI 应用开发** | 基于 LLM 等模型构建应用产品 | LangChain、Prompt Engineering、API 调用、后端开发 | RAG 应用、智能助手、AI 工具 |

> 💡 **新手建议**：从"ML 工程师"或"数据科学家"切入最实际——数学门槛比算法工程师低，就业面广。有一定基础后再考虑算法方向。

### 5.2 从零上手：Scikit-learn 完整流程

**安装和导入**：

```bash
pip install scikit-learn pandas numpy matplotlib
```

```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import SVC
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import (
    accuracy_score,
    confusion_matrix,
    classification_report,
)
import joblib
```

**数据加载和探索**：

```python
# 加载鸢尾花数据集（经典入门数据集）
iris = load_iris()
X = iris.data          # 特征：花萼长度、花萼宽度、花瓣长度、花瓣宽度
y = iris.target        # 标签：0=Setosa, 1=Versicolor, 2=Virginica
feature_names = iris.feature_names
target_names = iris.target_names

print(f"数据形状: {X.shape}")          # (150, 4) —— 150 条数据，4 个特征
print(f"特征名称: {feature_names}")
print(f"类别名称: {target_names}")      # ['setosa' 'versicolor' 'virginica']
print(f"类别分布: {np.bincount(y)}")    # [50, 50, 50] —— 每类 50 条，均衡数据集

# 转为 DataFrame 方便查看
df = pd.DataFrame(X, columns=feature_names)
df["target"] = y
df["species"] = [target_names[i] for i in y]
print(df.head())
#    sepal length (cm)  sepal width (cm)  petal length (cm)  petal width (cm)  target   species
# 0                5.1               3.5                1.4               0.2        0    setosa
# 1                4.9               3.0                1.4               0.2        0    setosa

# 简单可视化
plt.figure(figsize=(12, 5))

plt.subplot(1, 2, 1)
for i, species in enumerate(target_names):
    mask = y == i
    plt.scatter(X[mask, 0], X[mask, 1], label=species)
plt.xlabel("花萼长度 (cm)")
plt.ylabel("花萼宽度 (cm)")
plt.title("花萼特征散点图")
plt.legend()

plt.subplot(1, 2, 2)
for i, species in enumerate(target_names):
    mask = y == i
    plt.scatter(X[mask, 2], X[mask, 3], label=species)
plt.xlabel("花瓣长度 (cm)")
plt.ylabel("花瓣宽度 (cm)")
plt.title("花瓣特征散点图")
plt.legend()

plt.tight_layout()
plt.savefig("iris_scatter.png")
plt.show()
```

**数据预处理（拆分、标准化）**：

```python
# 拆分训练集和测试集（80% 训练，20% 测试）
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)
# stratify=y 保证训练集和测试集中各类别比例一致

print(f"训练集大小: {X_train.shape[0]}")  # 120
print(f"测试集大小: {X_test.shape[0]}")   # 30

# 标准化（让每个特征的均值为 0，标准差为 1）
# 注意：fit 只在训练集上做，然后 transform 训练集和测试集
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)   # 在训练集上计算均值和标准差，并转换
X_test_scaled = scaler.transform(X_test)          # 用训练集的均值和标准差转换测试集

print("标准化前（训练集前 5 行）:")
print(X_train[:5])
print("标准化后（训练集前 5 行）:")
print(X_train_scaled[:5])
```

**模型训练（多种模型对比）**：

```python
# 定义多个模型，方便对比
models = {
    "逻辑回归": LogisticRegression(max_iter=200, random_state=42),
    "随机森林": RandomForestClassifier(n_estimators=100, random_state=42),
    "SVM": SVC(kernel="rbf", random_state=42),
    "KNN": KNeighborsClassifier(n_neighbors=5),
}

# 训练并评估每个模型
results = {}
for name, model in models.items():
    # 训练模型
    model.fit(X_train_scaled, y_train)

    # 预测测试集
    y_pred = model.predict(X_test_scaled)

    # 计算准确率
    acc = accuracy_score(y_test, y_pred)
    results[name] = {"model": model, "accuracy": acc, "predictions": y_pred}
    print(f"{name} 准确率: {acc:.4f}")

# 对比结果
print("\n===== 模型对比 =====")
for name, result in sorted(results.items(), key=lambda x: x[1]["accuracy"], reverse=True):
    print(f"{name}: {result['accuracy']:.4f}")
```

**模型评估（准确率、混淆矩阵、分类报告）**：

```python
# 选择表现最好的模型进行详细评估
best_name = max(results, key=lambda x: results[x]["accuracy"])
best_model = results[best_name]["model"]
y_pred = results[best_name]["predictions"]

print(f"\n最佳模型: {best_name}")

# ===== 1. 混淆矩阵 =====
cm = confusion_matrix(y_test, y_pred)
print("\n混淆矩阵:")
print(cm)
# 每行代表真实类别，每列代表预测类别
# 对角线是正确预测的数量，非对角线是错误预测

# 可视化混淆矩阵
plt.figure(figsize=(6, 5))
plt.imshow(cm, cmap="Blues")
plt.title(f"混淆矩阵 - {best_name}")
plt.xlabel("预测类别")
plt.ylabel("真实类别")
plt.xticks(range(3), target_names)
plt.yticks(range(3), target_names)
# 在每个格子中显示数字
for i in range(3):
    for j in range(3):
        plt.text(j, i, cm[i, j], ha="center", va="center", fontsize=14)
plt.colorbar()
plt.tight_layout()
plt.savefig("confusion_matrix.png")
plt.show()

# ===== 2. 分类报告 =====
report = classification_report(y_test, y_pred, target_names=target_names)
print("\n分类报告:")
print(report)
# precision（精确率）: 预测为正的样本中，实际为正的比例
# recall（召回率）:    实际为正的样本中，被预测为正的比例
# f1-score:           精确率和召回率的调和平均
# support:            每个类别的样本数
```

**模型保存和加载**：

```python
# 保存模型和标准化器（部署时需要用相同的标准化参数）
joblib.dump(best_model, "iris_model.pkl")
joblib.dump(scaler, "iris_scaler.pkl")
print("模型已保存到 iris_model.pkl")

# 加载模型并预测新数据
loaded_model = joblib.load("iris_model.pkl")
loaded_scaler = joblib.load("iris_scaler.pkl")

# 模拟新数据：花萼长 5.0、宽 3.6、花瓣长 1.4、宽 0.2
new_sample = np.array([[5.0, 3.6, 1.4, 0.2]])
new_sample_scaled = loaded_scaler.transform(new_sample)  # 必须用同样的标准化参数
prediction = loaded_model.predict(new_sample_scaled)
probability = loaded_model.predict_proba(new_sample_scaled)

print(f"预测类别: {target_names[prediction[0]]}")         # setosa
print(f"各类别概率: {dict(zip(target_names, probability[0]))}")
```

### 5.3 深度学习入门：PyTorch 基础

```bash
pip install torch torchvision
```

**Tensor 操作**：

```python
import torch

# ===== 创建 Tensor =====
# 从列表创建
a = torch.tensor([1.0, 2.0, 3.0])
print(a)            # tensor([1., 2., 3.])
print(a.dtype)      # torch.float32

# 创建全零、全一、随机 Tensor
zeros = torch.zeros(3, 4)           # 3x4 全零矩阵
ones = torch.ones(2, 3)             # 2x3 全一矩阵
random = torch.randn(2, 3)          # 2x3 标准正态分布随机数
arange = torch.arange(0, 10, 2)     # [0, 2, 4, 6, 8]

print(f"zeros shape: {zeros.shape}")   # torch.Size([3, 4])

# ===== Tensor 运算 =====
x = torch.tensor([1.0, 2.0, 3.0])
y = torch.tensor([4.0, 5.0, 6.0])

print(x + y)         # 加法: tensor([5., 7., 9.])
print(x * y)         # 逐元素乘法: tensor([4., 10., 18.])
print(x.dot(y))      # 点积: tensor(32.)
print(x.sum())       # 求和: tensor(6.)
print(x.mean())      # 均值: tensor(2.)

# ===== 矩阵运算 =====
A = torch.randn(3, 4)
B = torch.randn(4, 2)
C = A @ B            # 矩阵乘法，结果形状 (3, 2)
print(f"矩阵乘法结果 shape: {C.shape}")

# ===== 形状操作 =====
t = torch.arange(12)
print(t.shape)                    # torch.Size([12])
print(t.reshape(3, 4).shape)      # torch.Size([3, 4])
print(t.view(2, 6).shape)         # torch.Size([2, 6])
print(t.reshape(3, -1).shape)     # torch.Size([3, 4])，-1 自动计算

# ===== GPU 加速 =====
if torch.cuda.is_available():
    device = torch.device("cuda")
    x = x.to(device)           # 移到 GPU
    print(f"使用设备: {x.device}")
else:
    print("没有 GPU，使用 CPU 训练（入门阶段足够）")

# ===== 与 NumPy 互转 =====
import numpy as np
arr = np.array([1, 2, 3])
t = torch.from_numpy(arr)        # NumPy → Tensor
arr_back = t.numpy()             # Tensor → NumPy
```

**自动求导**：

```python
import torch

# requires_grad=True 表示需要计算梯度
x = torch.tensor([2.0, 3.0], requires_grad=True)

# 前向计算
y = x ** 2           # y = [4, 9]
z = y.sum()          # z = 13

# 反向传播（自动计算梯度）
z.backward()

# 查看梯度：dz/dx = 2x
print(f"x 的梯度: {x.grad}")  # tensor([4., 6.])
# 解释：z = x1² + x2²，∂z/∂x1 = 2*2 = 4，∂z/∂x2 = 2*3 = 6

# ===== 在训练中的使用模式 =====
weights = torch.randn(3, requires_grad=True)

# 前向计算
loss = (weights ** 2).sum()

# 反向传播
loss.backward()
print(f"梯度: {weights.grad}")

# 更新参数（注意：更新参数时不参与计算图）
with torch.no_grad():
    weights -= 0.1 * weights.grad   # 梯度下降：w = w - lr * grad

# 清零梯度（每次迭代前必须清零，否则梯度会累加）
weights.grad.zero_()
```

**构建神经网络**：

```python
import torch
import torch.nn as nn

class SimpleNet(nn.Module):
    """一个简单的全连接神经网络。"""

    def __init__(self, input_size=4, hidden_size=16, num_classes=3):
        super().__init__()
        # 定义网络层
        self.fc1 = nn.Linear(input_size, hidden_size)   # 输入层 → 隐藏层
        self.relu = nn.ReLU()                           # 激活函数
        self.dropout = nn.Dropout(0.2)                  # Dropout 防过拟合
        self.fc2 = nn.Linear(hidden_size, num_classes)  # 隐藏层 → 输出层

    def forward(self, x):
        """前向传播：定义数据如何流过网络。"""
        x = self.fc1(x)        # 线性变换: (batch, 4) → (batch, 16)
        x = self.relu(x)       # 激活: 引入非线性
        x = self.dropout(x)    # 随机丢弃 20% 神经元（训练时生效）
        x = self.fc2(x)        # 线性变换: (batch, 16) → (batch, 3)
        return x

# 创建模型
model = SimpleNet(input_size=4, hidden_size=16, num_classes=3)
print(model)
# 打印模型结构和参数数量
total_params = sum(p.numel() for p in model.parameters())
print(f"总参数量: {total_params}")

# 测试前向传播
dummy_input = torch.randn(5, 4)   # batch_size=5，4 个特征
output = model(dummy_input)
print(f"输出形状: {output.shape}")  # torch.Size([5, 3])
```

**训练循环详解（每步都有注释）**：

```python
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader, TensorDataset
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import numpy as np

# ===== 1. 准备数据 =====
iris = load_iris()
X, y = iris.data, iris.target

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# 标准化
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

# 转为 PyTorch Tensor
X_train_tensor = torch.FloatTensor(X_train)
y_train_tensor = torch.LongTensor(y_train)
X_test_tensor = torch.FloatTensor(X_test)
y_test_tensor = torch.LongTensor(y_test)

# 创建 DataLoader（自动分批）
train_dataset = TensorDataset(X_train_tensor, y_train_tensor)
train_loader = DataLoader(train_dataset, batch_size=16, shuffle=True)

# ===== 2. 创建模型、损失函数、优化器 =====
model = SimpleNet(input_size=4, hidden_size=16, num_classes=3)

criterion = nn.CrossEntropyLoss()                        # 多分类用交叉熵损失
optimizer = optim.Adam(model.parameters(), lr=0.01)      # Adam 优化器

# ===== 3. 训练循环 =====
num_epochs = 50

for epoch in range(num_epochs):
    model.train()  # 设置为训练模式（启用 Dropout 等）
    running_loss = 0.0

    for batch_X, batch_y in train_loader:
        # 第 1 步：清零梯度（防止梯度累加）
        optimizer.zero_grad()

        # 第 2 步：前向传播（计算预测值）
        outputs = model(batch_X)

        # 第 3 步：计算损失（预测值 vs 真实值）
        loss = criterion(outputs, batch_y)

        # 第 4 步：反向传播（计算梯度）
        loss.backward()

        # 第 5 步：更新参数（w = w - lr * grad）
        optimizer.step()

        running_loss += loss.item()

    # 每 10 个 epoch 打印一次训练损失
    if (epoch + 1) % 10 == 0:
        avg_loss = running_loss / len(train_loader)
        print(f"Epoch [{epoch + 1}/{num_epochs}], 损失: {avg_loss:.4f}")

# ===== 4. 评估模型 =====
model.eval()  # 设置为评估模式（关闭 Dropout 等）
with torch.no_grad():  # 评估时不计算梯度，节省内存
    outputs = model(X_test_tensor)
    _, predicted = torch.max(outputs, 1)  # 取最大概率的类别
    correct = (predicted == y_test_tensor).sum().item()
    accuracy = correct / y_test_tensor.size(0)
    print(f"\n测试集准确率: {accuracy:.4f}")

# ===== 5. 保存模型 =====
torch.save(model.state_dict(), "iris_net.pth")
print("模型已保存到 iris_net.pth")

# 加载模型
loaded_model = SimpleNet(input_size=4, hidden_size=16, num_classes=3)
loaded_model.load_state_dict(torch.load("iris_net.pth"))
loaded_model.eval()
print("模型加载成功")
```

### 5.4 LLM 应用开发实战

使用 LangChain 构建 RAG（Retrieval-Augmented Generation，检索增强生成）应用：

```bash
pip install langchain langchain-openai langchain-community chromadb sentence-transformers
```

```python
"""
RAG 应用：让 LLM 基于你自己的文档回答问题
流程：文档加载 → 文档分割 → 向量化存储 → 检索 → 生成回答
"""

from langchain_community.document_loaders import TextLoader, PyPDFLoader
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_community.embeddings import HuggingFaceEmbeddings
from langchain_community.vectorstores import Chroma
from langchain_openai import ChatOpenAI
from langchain.chains import RetrievalQA
from langchain.prompts import PromptTemplate

# ===== 1. 文档加载和分割 =====

# 加载文本文件
loader = TextLoader("company_faq.txt", encoding="utf-8")
documents = loader.load()

# 也可以加载 PDF
# loader = PyPDFLoader("company_manual.pdf")
# documents = loader.load()

print(f"加载了 {len(documents)} 个文档")

# 文档分割：把长文档切成小段，便于检索
text_splitter = RecursiveCharacterTextSplitter(
    chunk_size=500,       # 每段最多 500 个字符
    chunk_overlap=50,     # 相邻段落重叠 50 个字符，保证上下文连贯
    separators=["\n\n", "\n", "。", "！", "？", "，", " ", ""],  # 按优先级切分
)

splits = text_splitter.split_documents(documents)
print(f"分割为 {len(splits)} 个文本块")

# ===== 2. 向量存储和检索 =====

# 使用本地嵌入模型（不依赖 OpenAI API）
# 首次运行会自动下载模型，约 400MB
embeddings = HuggingFaceEmbeddings(
    model_name="shibing624/text2vec-base-chinese",  # 中文嵌入模型
)

# 创建向量数据库并存储文档
vectorstore = Chroma.from_documents(
    documents=splits,
    embedding=embeddings,
    persist_directory="./chroma_db",  # 持久化到本地
)

# 测试检索：找出与问题最相关的文本块
query = "公司的年假有多少天？"
results = vectorstore.similarity_search(query, k=3)  # 返回最相关的 3 段
for i, doc in enumerate(results):
    print(f"\n--- 相关片段 {i + 1} ---")
    print(doc.page_content[:200])

# ===== 3. 问答链 =====

# 初始化 LLM（需要设置 OPENAI_API_KEY 环境变量）
# 也可以换成其他模型，如 ChatOllama 使用本地模型
llm = ChatOpenAI(
    model="gpt-4o-mini",
    temperature=0,  # 温度越低，回答越确定
)

# 自定义提示词模板
prompt_template = """请根据以下参考内容回答问题。如果参考内容中没有相关信息，
请回答"根据已有信息无法回答该问题"，不要编造内容。

参考内容：
{context}

问题：{question}

回答："""

prompt = PromptTemplate(
    template=prompt_template,
    input_variables=["context", "question"],
)

# 创建 RAG 问答链
qa_chain = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",                        # 把所有检索到的片段塞进提示词
    retriever=vectorstore.as_retriever(        # 检索器
        search_type="similarity",              # 相似度搜索
        search_kwargs={"k": 3},                # 返回 3 个最相关的片段
    ),
    return_source_documents=True,              # 返回来源文档
    chain_type_kwargs={"prompt": prompt},      # 使用自定义提示词
)

# ===== 4. 提问 =====

questions = [
    "公司的年假有多少天？",
    "迟到怎么扣款？",
    "公司提供什么培训？",
]

for question in questions:
    print(f"\n{'='*50}")
    print(f"问题: {question}")
    result = qa_chain.invoke({"query": question})
    print(f"回答: {result['result']}")
    print(f"来源: {result['source_documents'][0].page_content[:100]}...")

# ===== 5. 对话模式（保留上下文） =====
from langchain.memory import ConversationBufferMemory
from langchain.chains import ConversationalRetrievalChain

memory = ConversationBufferMemory(
    memory_key="chat_history",
    return_messages=True,
    output_key="answer",
)

conv_chain = ConversationalRetrievalChain.from_llm(
    llm=llm,
    retriever=vectorstore.as_retriever(search_kwargs={"k": 3}),
    memory=memory,
    return_source_documents=True,
)

# 多轮对话
print("\n" + "=" * 50)
print("对话模式:")
response1 = conv_chain.invoke({"question": "公司的年假有多少天？"})
print(f"Q: 公司的年假有多少天？")
print(f"A: {response1['answer']}")

response2 = conv_chain.invoke({"question": "那病假呢？"})  # 会理解"病假"是追问
print(f"Q: 那病假呢？")
print(f"A: {response2['answer']}")
```

### 5.5 常见新手坑

| 坑 | 说明 | 解决方案 |
|----|------|----------|
| **跳过数学直接调包** | 不理解原理，遇到问题无法排查 | 至少理解线性回归、梯度下降、损失函数的含义 |
| **不做数据预处理** | 直接把原始数据喂给模型 | 先清洗、标准化、处理缺失值 |
| **测试集泄漏** | 在全数据上标准化/调参，再用测试集评估 | 预处理只 fit 训练集，测试集只 transform |
| **只用准确率评估** | 数据不均衡时准确率有误导性 | 同时看精确率、召回率、F1 和混淆矩阵 |
| **过拟合不处理** | 训练集准确率 99%，测试集 60% | 加 Dropout、正则化、数据增强、早停 |
| **一上来就用深度学习** | 简单问题用复杂模型，训练慢效果不一定好 | 先试传统 ML（逻辑回归/随机森林），不够再用 DL |
| **忽略随机种子** | 每次运行结果不同，无法复现 | 设置 `random_state=42` / `torch.manual_seed(42)` |
| **直接上生产** | 模型没有持久化，重启后丢失 | 用 `joblib.dump` / `torch.save` 保存模型 |

---

## 6. 桌面应用与 GUI

### 6.1 GUI 开发是什么？选择框架

GUI（Graphical User Interface，图形用户界面）开发就是做"带窗口、按钮、输入框的桌面软件"。和命令行不同，GUI 让用户通过鼠标点击、拖拽来操作程序。

**框架选择指南**：

| 框架 | 特点 | 适合谁 | 安装方式 |
|------|------|--------|----------|
| **Tkinter** | Python 标准库内置，无需安装 | 零基础入门、小型工具 | 无需安装，Python 自带 |
| **PyQt / PySide** | 功能最强大，组件丰富 | 想做专业桌面应用的人 | `pip install PyQt6` 或 `pip install PySide6` |
| **Kivy** | 支持触屏，可打包手机 App | 想做跨平台移动应用 | `pip install kivy` |
| **Dear PyGui** | GPU 加速，适合数据可视化 | 做实时数据展示工具 | `pip install dearpygui` |
| **Flet** | 类 Flutter 语法，Web+桌面 | 想做现代风格应用 | `pip install flet` |

> **新手建议**：先学 Tkinter（不用装任何东西），再做 PyQt 项目。这两个覆盖 90% 的桌面开发需求。

### 6.2 Tkinter 完整项目：文件搜索工具

从界面布局到功能实现，做一个真正有用的桌面工具——按文件名和大小搜索文件。

```python
"""
文件搜索工具 - Tkinter 完整项目
功能：按文件名关键词和大小范围搜索文件，支持双击打开文件所在目录
"""
import os
import tkinter as tk
from tkinter import ttk, messagebox, filedialog
from pathlib import Path
from datetime import datetime
import threading


class FileSearchApp:
    """文件搜索工具应用。"""

    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title("文件搜索工具")
        self.root.geometry("750x520")
        self.root.minsize(600, 400)

        # 搜索状态
        self.is_searching = False

        # 构建界面
        self._build_ui()

    def _build_ui(self):
        """构建完整的用户界面。"""

        # ===== 顶部：搜索条件区域 =====
        top_frame = ttk.LabelFrame(self.root, text="搜索条件", padding=10)
        top_frame.pack(fill="x", padx=10, pady=(10, 5))

        # 第1行：搜索目录
        dir_frame = ttk.Frame(top_frame)
        dir_frame.pack(fill="x", pady=2)

        ttk.Label(dir_frame, text="搜索目录：").pack(side="left")
        self.dir_var = tk.StringVar(value=os.path.expanduser("~"))
        self.dir_entry = ttk.Entry(dir_frame, textvariable=self.dir_var, width=55)
        self.dir_entry.pack(side="left", padx=5, fill="x", expand=True)
        ttk.Button(dir_frame, text="浏览", command=self._browse_dir).pack(side="left")

        # 第2行：文件名关键词
        name_frame = ttk.Frame(top_frame)
        name_frame.pack(fill="x", pady=2)

        ttk.Label(name_frame, text="文件名关键词：").pack(side="left")
        self.keyword_var = tk.StringVar()
        keyword_entry = ttk.Entry(name_frame, textvariable=self.keyword_var, width=30)
        keyword_entry.pack(side="left", padx=5)
        keyword_entry.bind("<Return>", lambda e: self.start_search())  # 回车搜索

        # 第3行：文件大小范围
        size_frame = ttk.Frame(top_frame)
        size_frame.pack(fill="x", pady=2)

        ttk.Label(size_frame, text="最小大小(MB)：").pack(side="left")
        self.min_size_var = tk.StringVar(value="0")
        ttk.Entry(size_frame, textvariable=self.min_size_var, width=8).pack(side="left", padx=5)

        ttk.Label(size_frame, text="最大大小(MB)：").pack(side="left", padx=(15, 0))
        self.max_size_var = tk.StringVar(value="0")
        ttk.Entry(size_frame, textvariable=self.max_size_var, width=8).pack(side="left", padx=5)
        ttk.Label(size_frame, text="（0 表示不限）").pack(side="left")

        # 搜索按钮
        btn_frame = ttk.Frame(top_frame)
        btn_frame.pack(fill="x", pady=(8, 0))

        self.search_btn = ttk.Button(btn_frame, text="🔍 开始搜索", command=self.start_search)
        self.search_btn.pack(side="left", padx=5)

        self.stop_btn = ttk.Button(btn_frame, text="⏹ 停止", command=self.stop_search, state="disabled")
        self.stop_btn.pack(side="left", padx=5)

        self.status_var = tk.StringVar(value="就绪")
        ttk.Label(btn_frame, textvariable=self.status_var).pack(side="right", padx=5)

        # ===== 中部：搜索结果列表 =====
        result_frame = ttk.LabelFrame(self.root, text="搜索结果", padding=5)
        result_frame.pack(fill="both", expand=True, padx=10, pady=5)

        # 使用 Treeview 显示表格数据
        columns = ("name", "size", "modified", "path")
        self.tree = ttk.Treeview(result_frame, columns=columns, show="headings", height=15)

        # 设置列标题和宽度
        self.tree.heading("name", text="文件名")
        self.tree.heading("size", text="大小")
        self.tree.heading("modified", text="修改时间")
        self.tree.heading("path", text="完整路径")

        self.tree.column("name", width=180)
        self.tree.column("size", width=80, anchor="e")
        self.tree.column("modified", width=140, anchor="center")
        self.tree.column("path", width=300)

        # 滚动条
        scrollbar = ttk.Scrollbar(result_frame, orient="vertical", command=self.tree.yview)
        self.tree.configure(yscrollcommand=scrollbar.set)

        self.tree.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        # 双击打开文件所在目录
        self.tree.bind("<Double-1>", self._on_double_click)

        # ===== 底部：状态栏 =====
        self.count_var = tk.StringVar(value="共 0 个结果")
        ttk.Label(self.root, textvariable=self.count_var, relief="sunken").pack(
            fill="x", padx=10, pady=(0, 10)
        )

    def _browse_dir(self):
        """打开文件夹选择对话框。"""
        selected = filedialog.askdirectory(initialdir=self.dir_var.get())
        if selected:
            self.dir_var.set(selected)

    def _on_double_click(self, event):
        """双击结果行，打开文件所在目录。"""
        selected = self.tree.selection()
        if not selected:
            return
        item = self.tree.item(selected[0])
        filepath = item["values"][3]  # 完整路径
        dir_path = os.path.dirname(filepath)

        # 用系统默认方式打开目录
        if os.path.exists(dir_path):
            os.startfile(dir_path)  # Windows
        else:
            messagebox.showwarning("提示", f"目录不存在：{dir_path}")

    def start_search(self):
        """开始搜索（在新线程中执行，避免界面卡死）。"""
        search_dir = self.dir_var.get()
        if not os.path.isdir(search_dir):
            messagebox.showerror("错误", f"目录不存在：{search_dir}")
            return

        keyword = self.keyword_var.get().strip().lower()
        try:
            min_size = float(self.min_size_var.get()) * 1024 * 1024  # 转字节
            max_size = float(self.max_size_var.get()) * 1024 * 1024
        except ValueError:
            messagebox.showerror("错误", "文件大小请输入数字")
            return

        # 清空之前的结果
        for item in self.tree.get_children():
            self.tree.delete(item)

        # 更新状态
        self.is_searching = True
        self.search_btn.config(state="disabled")
        self.stop_btn.config(state="normal")
        self.status_var.set("搜索中...")

        # 在新线程中搜索，避免界面卡死
        thread = threading.Thread(
            target=self._do_search,
            args=(search_dir, keyword, min_size, max_size),
            daemon=True,
        )
        thread.start()

    def _do_search(self, search_dir: str, keyword: str, min_size: float, max_size: float):
        """在后台线程中执行搜索。"""
        found = 0

        for root, dirs, files in os.walk(search_dir):
            if not self.is_searching:
                break  # 用户点了停止

            for filename in files:
                if not self.is_searching:
                    break

                # 按文件名过滤
                if keyword and keyword not in filename.lower():
                    continue

                filepath = os.path.join(root, filename)
                try:
                    file_size = os.path.getsize(filepath)
                except (PermissionError, FileNotFoundError):
                    continue

                # 按大小过滤
                if min_size > 0 and file_size < min_size:
                    continue
                if max_size > 0 and file_size > max_size:
                    continue

                # 格式化显示
                size_str = self._format_size(file_size)
                mtime = os.path.getmtime(filepath)
                modified = datetime.fromtimestamp(mtime).strftime("%Y-%m-%d %H:%M")

                # 在主线程中更新界面（线程安全）
                self.root.after(0, self._add_result, filename, size_str, modified, filepath)
                found += 1

        # 搜索完成，恢复界面状态
        self.root.after(0, self._search_done, found)

    def _add_result(self, name: str, size: str, modified: str, path: str):
        """向结果列表添加一行（在主线程中调用）。"""
        self.tree.insert("", "end", values=(name, size, modified, path))
        self.count_var.set(f"已找到 {len(self.tree.get_children())} 个结果")

    def _search_done(self, found: int):
        """搜索完成后的回调。"""
        self.is_searching = False
        self.search_btn.config(state="normal")
        self.stop_btn.config(state="disabled")
        total = len(self.tree.get_children())
        self.status_var.set(f"搜索完成，共找到 {total} 个文件")

    def stop_search(self):
        """停止搜索。"""
        self.is_searching = False
        self.status_var.set("搜索已停止")

    @staticmethod
    def _format_size(size_bytes: int) -> str:
        """将字节数格式化为可读字符串。"""
        if size_bytes < 1024:
            return f"{size_bytes} B"
        elif size_bytes < 1024 * 1024:
            return f"{size_bytes / 1024:.1f} KB"
        elif size_bytes < 1024 * 1024 * 1024:
            return f"{size_bytes / (1024 * 1024):.1f} MB"
        else:
            return f"{size_bytes / (1024 * 1024 * 1024):.2f} GB"


# ===== 启动应用 =====
if __name__ == "__main__":
    root = tk.Tk()
    app = FileSearchApp(root)
    root.mainloop()
```

> **这个项目学到了什么**：
> - **布局**：用 `Frame` + `LabelFrame` 分区，`pack` 排列组件
> - **输入组件**：`Entry`（文本框）、`Button`（按钮）、`filedialog`（文件对话框）
> - **表格展示**：`Treeview` 显示多列数据，带滚动条
> - **多线程**：搜索放在后台线程，用 `root.after()` 更新界面，避免卡死
> - **事件绑定**：`<Double-1>` 双击事件、`<Return>` 回车事件

### 6.3 PyQt 快速入门

#### 安装

```bash
pip install PyQt6
```

#### 基础组件与信号槽机制

PyQt 的核心概念是**信号（Signal）和槽（Slot）**：当用户操作（点击按钮、修改文本）时，组件发出"信号"，连接到"槽"函数来响应。

```python
"""
PyQt6 快速入门
核心概念：信号（Signal）与 槽（Slot）
"""
import sys
from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QWidget,
    QVBoxLayout, QHBoxLayout,
    QLabel, QLineEdit, QPushButton, QTextEdit,
    QComboBox, QSpinBox, QCheckBox,
    QGroupBox, QMessageBox,
)
from PyQt6.QtCore import Qt


class QuickStartWindow(QMainWindow):
    """PyQt6 快速入门窗口。"""

    def __init__(self):
        super().__init__()
        self.setWindowTitle("PyQt6 快速入门")
        self.setGeometry(100, 100, 500, 400)

        # 创建中心部件和布局
        central = QWidget()
        self.setCentralWidget(central)
        layout = QVBoxLayout(central)

        # ===== 1. 输入区域 =====
        input_group = QGroupBox("个人信息")
        input_layout = QVBoxLayout()

        # 文本输入
        name_layout = QHBoxLayout()
        name_layout.addWidget(QLabel("姓名："))
        self.name_input = QLineEdit()
        self.name_input.setPlaceholderText("请输入姓名")
        name_layout.addWidget(self.name_input)
        input_layout.addLayout(name_layout)

        # 下拉选择
        city_layout = QHBoxLayout()
        city_layout.addWidget(QLabel("城市："))
        self.city_combo = QComboBox()
        self.city_combo.addItems(["北京", "上海", "广州", "深圳", "杭州"])
        city_layout.addWidget(self.city_combo)
        input_layout.addLayout(city_layout)

        # 数字输入
        age_layout = QHBoxLayout()
        age_layout.addWidget(QLabel("年龄："))
        self.age_spin = QSpinBox()
        self.age_spin.setRange(1, 150)
        self.age_spin.setValue(25)
        age_layout.addWidget(self.age_spin)
        input_layout.addLayout(age_layout)

        # 复选框
        self.agree_check = QCheckBox("我同意用户协议")
        input_layout.addWidget(self.agree_check)

        input_group.setLayout(input_layout)
        layout.addWidget(input_group)

        # ===== 2. 按钮区域 =====
        btn_layout = QHBoxLayout()

        submit_btn = QPushButton("提交")
        clear_btn = QPushButton("清空")

        # 【核心】信号与槽的连接
        # 当按钮被点击（clicked 信号），调用对应的槽函数
        submit_btn.clicked.connect(self.on_submit)   # 点击提交 → 调用 on_submit
        clear_btn.clicked.connect(self.on_clear)     # 点击清空 → 调用 on_clear

        # 其他常用信号示例
        self.name_input.textChanged.connect(self.on_text_changed)  # 文本变化 → on_text_changed
        self.city_combo.currentTextChanged.connect(self.on_city_changed)  # 下拉变化

        btn_layout.addWidget(submit_btn)
        btn_layout.addWidget(clear_btn)
        layout.addLayout(btn_layout)

        # ===== 3. 输出区域 =====
        self.output = QTextEdit()
        self.output.setReadOnly(True)
        self.output.setPlaceholderText("输出信息将显示在这里...")
        layout.addWidget(self.output)

    # ===== 槽函数（响应信号） =====

    def on_submit(self):
        """提交按钮的槽函数。"""
        name = self.name_input.text().strip()
        if not name:
            QMessageBox.warning(self, "提示", "请输入姓名！")
            return

        if not self.agree_check.isChecked():
            QMessageBox.warning(self, "提示", "请先同意用户协议！")
            return

        city = self.city_combo.currentText()
        age = self.age_spin.value()

        result = f"✅ 提交成功！\n姓名：{name}\n城市：{city}\n年龄：{age}"
        self.output.append(result)

    def on_clear(self):
        """清空按钮的槽函数。"""
        self.name_input.clear()
        self.city_combo.setCurrentIndex(0)
        self.age_spin.setValue(25)
        self.agree_check.setChecked(False)
        self.output.clear()

    def on_text_changed(self, text: str):
        """文本变化时的槽函数。"""
        self.output.append(f"📝 文本变化：{text}")

    def on_city_changed(self, city: str):
        """城市选择变化时的槽函数。"""
        self.output.append(f"🏙 城市切换：{city}")


# ===== 启动应用 =====
if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = QuickStartWindow()
    window.show()
    sys.exit(app.exec())
```

> **Tkinter vs PyQt 对比**：
>
> | 对比项 | Tkinter | PyQt |
> |--------|---------|------|
> | 安装 | 自带 | 需 pip install |
> | 组件丰富度 | 基础 | 非常丰富（表格、图表、富文本） |
> | 信号槽机制 | `command=` 回调 | `signal.connect(slot)` 更灵活 |
> | 界面美观度 | 一般 | 更现代 |
> | 打包体积 | 小 | 较大 |
> | 学习曲线 | 低 | 中等 |

### 6.4 常见新手坑

| 坑 | 说明 | 解决方案 |
|---|---|---|
| **界面卡死** | 在主线程做耗时操作（网络请求、大量计算） | 用 `threading` 做后台任务，`root.after()` 更新界面 |
| **Tkinter 中文乱码** | Windows 上部分中文字体显示异常 | 设置字体：`font=("微软雅黑", 10)` |
| **PyQt 打包太大** | PyInstaller 打包 PyQt 应用超过 100MB | 用 `--exclude-module` 排除不需要的模块，或用 Nuitka |
| **忘记 `mainloop()`** | 窗口一闪而过 | 必须在最后调用 `root.mainloop()` 进入事件循环 |
| **布局混乱** | `pack` 和 `grid` 混用在同一个容器 | 同一容器只用一种布局方式 |
| **Tkinter 无表格** | 想显示多列数据没有现成组件 | 用 `ttk.Treeview` 实现表格 |
| **PyQt 信号槽断开** | 连接后信号没有触发槽函数 | 检查信号名称拼写，确认 `connect()` 在 `show()` 之前 |

---

## 7. 游戏开发

### 7.1 Python 游戏开发适合什么？

Python 不是做 3A 大作的语言（那是 C++/C# 的领域），但 Python 在以下场景非常合适：

| 适合做什么 | 不适合做什么 |
|-----------|-------------|
| 2D 休闲游戏（弹球、贪吃蛇、俄罗斯方块） | 3A 3D 大作 |
| 游戏原型验证（快速试玩） | 高性能实时渲染 |
| 游戏工具开发（地图编辑器、关卡生成器） | 大型网游服务端 |
| AI 游戏对战（强化学习训练） | 手机游戏（除非用 Kivy） |
| 教学和学习游戏开发原理 | 商业级游戏引擎 |

**工具选择**：

```
Python 游戏开发工具链：
├── Pygame    ← 新手首选，2D 游戏学习，社区资源最多
├── Arcade    ← Pygame 的现代替代，API 更友好
├── Panda3D   ← 迪士尼开发的 3D 引擎，适合学 3D
├── Godot     ← 用 GDScript（类 Python）开发，真正的游戏引擎
└── Ren'Py    ← 视觉小说/文字冒险游戏专用
```

> **新手建议**：从 Pygame 开始，做出第一个完整游戏比选工具更重要。

### 7.2 Pygame 完整项目：弹球游戏

包含碰撞检测、计分、游戏循环、暂停/重开等完整功能。

```bash
pip install pygame
```

```python
"""
弹球游戏 - Pygame 完整项目
功能：挡板接球、碰撞反弹、计分、暂停、重新开始
操作：← → 移动挡板，空格暂停，R 重新开始
"""
import pygame
import sys
import random
import math

# ===== 初始化 =====
pygame.init()

# 常量定义
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
FPS = 60

# 颜色定义（R, G, B）
COLOR_BG = (15, 15, 35)         # 深蓝黑背景
COLOR_WHITE = (255, 255, 255)
COLOR_BALL = (255, 100, 80)     # 橙红色球
COLOR_PADDLE = (80, 200, 255)   # 蓝色挡板
COLOR_BRICK = []                 # 砖块颜色（稍后填充）
COLOR_SCORE = (255, 220, 80)    # 黄色分数
COLOR_TEXT = (200, 200, 200)    # 灰色文字

# 砖块颜色方案（每行一种颜色）
BRICK_COLORS = [
    (255, 80, 80),    # 红
    (255, 160, 60),   # 橙
    (255, 220, 80),   # 黄
    (80, 220, 100),   # 绿
    (80, 160, 255),   # 蓝
]

# 砖块参数
BRICK_ROWS = 5          # 行数
BRICK_COLS = 10         # 列数
BRICK_WIDTH = 70        # 砖块宽度
BRICK_HEIGHT = 25       # 砖块高度
BRICK_PADDING = 5       # 砖块间距
BRICK_TOP = 60          # 砖块区域顶部偏移


class Ball:
    """球。"""

    def __init__(self):
        self.radius = 8
        self.reset()

    def reset(self):
        """重置球的位置和速度。"""
        self.x = SCREEN_WIDTH / 2
        self.y = SCREEN_HEIGHT - 80
        # 随机向上发射，速度固定
        angle = random.uniform(math.radians(220), math.radians(320))
        speed = 5
        self.vx = speed * math.cos(angle)
        self.vy = speed * math.sin(angle)

    def update(self):
        """更新球的位置。"""
        self.x += self.vx
        self.y += self.vy

        # 左右墙壁碰撞
        if self.x - self.radius <= 0:
            self.x = self.radius
            self.vx = abs(self.vx)  # 向右反弹
        elif self.x + self.radius >= SCREEN_WIDTH:
            self.x = SCREEN_WIDTH - self.radius
            self.vx = -abs(self.vx)  # 向左反弹

        # 顶部墙壁碰撞
        if self.y - self.radius <= 0:
            self.y = self.radius
            self.vy = abs(self.vy)  # 向下反弹

    def draw(self, surface: pygame.Surface):
        """绘制球。"""
        pygame.draw.circle(surface, COLOR_BALL, (int(self.x), int(self.y)), self.radius)
        # 高光效果
        highlight_pos = (int(self.x - 2), int(self.y - 2))
        pygame.draw.circle(surface, (255, 200, 180), highlight_pos, 3)


class Paddle:
    """挡板。"""

    def __init__(self):
        self.width = 120
        self.height = 14
        self.x = SCREEN_WIDTH / 2 - self.width / 2
        self.y = SCREEN_HEIGHT - 40
        self.speed = 8  # 移动速度

    def move_left(self):
        """向左移动。"""
        self.x = max(0, self.x - self.speed)

    def move_right(self):
        """向右移动。"""
        self.x = min(SCREEN_WIDTH - self.width, self.x + self.speed)

    def draw(self, surface: pygame.Surface):
        """绘制挡板。"""
        rect = pygame.Rect(int(self.x), int(self.y), self.width, self.height)
        pygame.draw.rect(surface, COLOR_PADDLE, rect, border_radius=7)
        # 高光条
        highlight = pygame.Rect(int(self.x + 4), int(self.y + 2), self.width - 8, 4)
        pygame.draw.rect(surface, (150, 230, 255), highlight, border_radius=2)

    def get_rect(self) -> pygame.Rect:
        """获取挡板的碰撞矩形。"""
        return pygame.Rect(int(self.x), int(self.y), self.width, self.height)


class Brick:
    """砖块。"""

    def __init__(self, x: int, y: int, color: tuple):
        self.rect = pygame.Rect(x, y, BRICK_WIDTH, BRICK_HEIGHT)
        self.color = color
        self.alive = True  # 是否还在

    def draw(self, surface: pygame.Surface):
        """绘制砖块。"""
        if self.alive:
            pygame.draw.rect(surface, self.color, self.rect, border_radius=3)
            # 高光效果
            highlight = pygame.Rect(
                self.rect.x + 3, self.rect.y + 2,
                self.rect.width - 6, 6
            )
            lighter = tuple(min(255, c + 60) for c in self.color)
            pygame.draw.rect(surface, lighter, highlight, border_radius=2)


class Game:
    """弹球游戏主类。"""

    def __init__(self):
        self.screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
        pygame.display.set_caption("弹球游戏 - Pygame")
        self.clock = pygame.time.Clock()

        # 字体（用系统默认字体）
        self.font_large = pygame.font.SysFont("microsoftyahei", 36)
        self.font_medium = pygame.font.SysFont("microsoftyahei", 24)
        self.font_small = pygame.font.SysFont("microsoftyahei", 18)

        self.reset_game()

    def reset_game(self):
        """重置游戏状态。"""
        self.ball = Ball()
        self.paddle = Paddle()
        self.bricks = self._create_bricks()
        self.score = 0
        self.lives = 3          # 剩余生命数
        self.paused = False     # 是否暂停
        self.game_over = False  # 是否结束
        self.won = False        # 是否胜利

    def _create_bricks(self) -> list[Brick]:
        """创建砖块阵列。"""
        bricks = []
        # 计算砖块区域的起始位置（使其居中）
        total_width = BRICK_COLS * (BRICK_WIDTH + BRICK_PADDING) - BRICK_PADDING
        start_x = (SCREEN_WIDTH - total_width) / 2

        for row in range(BRICK_ROWS):
            color = BRICK_COLORS[row % len(BRICK_COLORS)]
            for col in range(BRICK_COLS):
                x = start_x + col * (BRICK_WIDTH + BRICK_PADDING)
                y = BRICK_TOP + row * (BRICK_HEIGHT + BRICK_PADDING)
                bricks.append(Brick(x, y, color))
        return bricks

    def handle_input(self):
        """处理键盘输入。"""
        keys = pygame.key.get_pressed()

        if not self.paused and not self.game_over:
            if keys[pygame.K_LEFT] or keys[pygame.K_a]:
                self.paddle.move_left()
            if keys[pygame.K_RIGHT] or keys[pygame.K_d]:
                self.paddle.move_right()

    def check_collisions(self):
        """碰撞检测。"""
        # 1. 球与挡板碰撞
        paddle_rect = self.paddle.get_rect()
        ball_rect = pygame.Rect(
            self.ball.x - self.ball.radius,
            self.ball.y - self.ball.radius,
            self.ball.radius * 2,
            self.ball.radius * 2,
        )

        if ball_rect.colliderect(paddle_rect) and self.ball.vy > 0:
            # 根据球击中挡板的位置，改变水平反弹角度
            # 击中挡板左侧 → 向左反弹，右侧 → 向右反弹
            relative_x = (self.ball.x - self.paddle.x) / self.paddle.width  # 0~1
            bounce_angle = (relative_x - 0.5) * 2.5  # -1.25 ~ 1.25

            speed = math.sqrt(self.ball.vx ** 2 + self.ball.vy ** 2)
            # 确保速度不低于最小值
            speed = max(speed, 5)
            self.ball.vx = bounce_angle * speed
            self.ball.vy = -abs(self.ball.vy)  # 保证向上反弹

            # 把球放到挡板上方，防止穿透
            self.ball.y = self.paddle.y - self.ball.radius

        # 2. 球与砖块碰撞
        for brick in self.bricks:
            if not brick.alive:
                continue
            if ball_rect.colliderect(brick.rect):
                brick.alive = False
                self.score += 10  # 每击碎一块砖块加 10 分

                # 判断碰撞方向：从哪个面撞入
                # 简化处理：反转 vy
                self.ball.vy = -self.ball.vy
                break  # 一帧只处理一次砖块碰撞

        # 3. 球掉出底部 → 扣命
        if self.ball.y - self.ball.radius > SCREEN_HEIGHT:
            self.lives -= 1
            if self.lives <= 0:
                self.game_over = True
            else:
                self.ball.reset()  # 重新发球

        # 4. 所有砖块消除 → 胜利
        if all(not brick.alive for brick in self.bricks):
            self.won = True
            self.game_over = True

    def update(self):
        """更新游戏逻辑。"""
        if self.paused or self.game_over:
            return
        self.ball.update()
        self.check_collisions()

    def draw(self):
        """绘制所有游戏元素。"""
        # 背景
        self.screen.fill(COLOR_BG)

        # 砖块
        for brick in self.bricks:
            brick.draw(self.screen)

        # 球和挡板
        self.ball.draw(self.screen)
        self.paddle.draw(self.screen)

        # 分数
        score_text = self.font_medium.render(f"分数: {self.score}", True, COLOR_SCORE)
        self.screen.blit(score_text, (15, 15))

        # 生命值（用圆圈表示）
        for i in range(self.lives):
            cx = SCREEN_WIDTH - 25 - i * 28
            pygame.draw.circle(self.screen, COLOR_BALL, (cx, 25), 10)

        # 暂停提示
        if self.paused and not self.game_over:
            overlay = pygame.Surface((SCREEN_WIDTH, SCREEN_HEIGHT), pygame.SRCALPHA)
            overlay.fill((0, 0, 0, 120))  # 半透明遮罩
            self.screen.blit(overlay, (0, 0))
            pause_text = self.font_large.render("暂停中", True, COLOR_WHITE)
            tip_text = self.font_small.render("按空格继续", True, COLOR_TEXT)
            self.screen.blit(pause_text, (SCREEN_WIDTH // 2 - pause_text.get_width() // 2, 250))
            self.screen.blit(tip_text, (SCREEN_WIDTH // 2 - tip_text.get_width() // 2, 300))

        # 游戏结束/胜利
        if self.game_over:
            overlay = pygame.Surface((SCREEN_WIDTH, SCREEN_HEIGHT), pygame.SRCALPHA)
            overlay.fill((0, 0, 0, 150))
            self.screen.blit(overlay, (0, 0))

            if self.won:
                msg = self.font_large.render("恭喜通关！", True, COLOR_SCORE)
            else:
                msg = self.font_large.render("游戏结束", True, (255, 80, 80))
            score_msg = self.font_medium.render(f"最终分数: {self.score}", True, COLOR_WHITE)
            tip_msg = self.font_small.render("按 R 重新开始", True, COLOR_TEXT)

            self.screen.blit(msg, (SCREEN_WIDTH // 2 - msg.get_width() // 2, 220))
            self.screen.blit(score_msg, (SCREEN_WIDTH // 2 - score_msg.get_width() // 2, 280))
            self.screen.blit(tip_msg, (SCREEN_WIDTH // 2 - tip_msg.get_width() // 2, 330))

        pygame.display.flip()

    def run(self):
        """游戏主循环。"""
        while True:
            # 事件处理
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    sys.exit()
                elif event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_SPACE and not self.game_over:
                        self.paused = not self.paused  # 空格暂停/继续
                    elif event.key == pygame.K_r and self.game_over:
                        self.reset_game()  # R 重新开始
                    elif event.key == pygame.K_ESCAPE:
                        pygame.quit()
                        sys.exit()

            self.handle_input()
            self.update()
            self.draw()
            self.clock.tick(FPS)  # 限制帧率为 60 FPS


# ===== 启动游戏 =====
if __name__ == "__main__":
    game = Game()
    game.run()
```

> **这个项目学到了什么**：
> - **游戏循环**：事件处理 → 逻辑更新 → 画面绘制 → 帧率控制，这是所有游戏的基本结构
> - **碰撞检测**：`Rect.colliderect()` 矩形碰撞判断
> - **状态管理**：暂停、游戏结束、胜利等状态的控制
> - **键盘输入**：`pygame.key.get_pressed()` 持续按键检测
> - **面向对象**：Ball、Paddle、Brick 各自管理自己的数据和绘制

### 7.3 常见新手坑

| 坑 | 说明 | 解决方案 |
|---|---|---|
| **帧率不稳定** | 没有调用 `clock.tick(FPS)` | 在主循环末尾加 `clock.tick(60)` 锁定帧率 |
| **球穿透挡板** | 球速度太快，一帧移动距离超过挡板厚度 | 碰撞后将球放到挡板上方，或限制球速度 |
| **忘记 `pygame.display.flip()`** | 画面不更新 | 每帧绘制完后必须调用 |
| **图片加载失败** | `pygame.image.load()` 报错 | 用 `os.path.join()` 拼路径，检查文件是否存在 |
| **中文显示乱码** | `pygame.font` 默认不支持中文 | 用 `pygame.font.SysFont("microsoftyahei", 24)` 指定中文字体 |
| **游戏无法退出** | 关闭窗口后程序卡住 | 在事件循环中处理 `QUIT` 事件，调用 `pygame.quit()` |
| **碰撞检测不精确** | 矩形碰撞对圆形球不精确 | 简单游戏用矩形即可，精确碰撞用距离公式 `math.hypot()` |

---

## 8. 物联网与嵌入式

### 8.1 IoT 开发是什么？硬件选购指南

物联网（IoT，Internet of Things）就是让日常设备连上网——温度传感器把数据传到云端、手机远程控制灯泡、智能门锁自动开锁，都是 IoT。

**Python 在 IoT 中的角色**：

```
Python 在 IoT 中的应用：
├── MicroPython  ← 运行在微控制器上（ESP32），直接控制硬件
├── 树莓派       ← 运行完整 Linux + Python，适合复杂项目
├── 数据后端     ← 用 FastAPI/Flask 接收传感器数据
└── 数据分析     ← 用 Pandas/NumPy 分析 IoT 数据
```

**硬件选购指南**：

| 硬件 | 价格 | 适合谁 | 说明 |
|------|------|--------|------|
| **ESP32** | ￥20~40 | 入门首选 | 带 WiFi+蓝牙，MicroPython 支持，便宜好用 |
| **ESP8266** | ￥10~20 | 预算极低 | 只有 WiFi，比 ESP32 弱，但够用 |
| **树莓派 5** | ￥400~600 | 进阶项目 | 完整 Linux 系统，可接摄像头、屏幕 |
| **Arduino** | ￥30~80 | C 语言爱好者 | 不运行 Python，但和 Python 可串口通信 |
| **Micro:bit** | ￥80~120 | 青少年教育 | 图形化+Python，适合教学 |

> **新手建议**：花 ￥30 买一块 ESP32 开发板 + 一个 DHT11 温湿度传感器，跟着下面的项目做，30 分钟上手。

**你需要准备的（ESP32 入门套装）**：

```
ESP32 入门必备：
├── ESP32 开发板              ￥25
├── DHT11/DHT22 温湿度传感器   ￥5~15
├── LED 灯 + 220Ω 电阻        ￥1
├── 面包板 + 杜邦线           ￥10
└── USB 数据线                ￥5
                        总计：约 ￥50
```

**开发环境搭建**：

1. 安装 [Thonny IDE](https://thonny.org/)（专为 MicroPython 设计的编辑器）
2. 给 ESP32 烧录 MicroPython 固件（Thonny 内置一键烧录）
3. USB 连接 ESP32，在 Thonny 中选择"MicroPython (ESP32)"解释器
4. 开始写代码！

### 8.2 MicroPython 入门：ESP32 温湿度监控

用 ESP32 + DHT11 传感器，每 5 秒采集温湿度数据并通过串口输出。

```python
"""
ESP32 温湿度监控 - MicroPython 完整项目
硬件连接：
  - DHT11 数据引脚 → ESP32 的 GPIO 4
  - DHT11 VCC → ESP32 的 3.3V
  - DHT11 GND → ESP32 的 GND
功能：每 5 秒采集温湿度，LED 闪烁表示正在工作，超温报警
"""

from machine import Pin
import dht
import time

# ===== 硬件初始化 =====

# DHT11 传感器，接 GPIO4
dht_sensor = dht.DHT11(Pin(4))

# 板载 LED（ESP32 通常是 GPIO2）
led = Pin(2, Pin.OUT)

# 蜂鸣器（可选，接 GPIO5），超温报警用
buzzer = Pin(5, Pin.OUT)

# ===== 报警阈值 =====
TEMP_HIGH = 35.0   # 温度超过 35°C 报警
HUMIDITY_HIGH = 80.0  # 湿度超过 80% 报警


def read_sensor():
    """读取传感器数据，返回 (温度, 湿度)。"""
    try:
        dht_sensor.measure()  # 触发测量
        temp = dht_sensor.temperature()  # 温度（°C）
        humi = dht_sensor.humidity()     # 湿度（%）
        return temp, humi
    except OSError as e:
        # DHT 传感器偶尔读取失败是正常的，重试即可
        print(f"传感器读取失败: {e}")
        return None, None


def check_alert(temp, humi):
    """检查是否超阈值，返回报警列表。"""
    alerts = []
    if temp is not None and temp > TEMP_HIGH:
        alerts.append(f"高温报警: {temp}°C > {TEMP_HIGH}°C")
    if humi is not None and humi > HUMIDITY_HIGH:
        alerts.append(f"高湿报警: {humi}% > {HUMIDITY_HIGH}%")
    return alerts


def blink_led(times=1, interval=0.1):
    """LED 闪烁，表示正在工作。"""
    for _ in range(times):
        led.value(1)
        time.sleep(interval)
        led.value(0)
        time.sleep(interval)


def alarm_buzzer(times=3):
    """蜂鸣器报警。"""
    for _ in range(times):
        buzzer.value(1)
        time.sleep(0.2)
        buzzer.value(0)
        time.sleep(0.1)


# ===== 主循环 =====
print("=" * 40)
print("ESP32 温湿度监控系统启动")
print(f"报警阈值: 温度 > {TEMP_HIGH}°C, 湿度 > {HUMIDITY_HIGH}%")
print("=" * 40)

count = 0
while True:
    count += 1

    # 读取传感器
    temp, humi = read_sensor()

    if temp is not None and humi is not None:
        # 显示数据
        print(f"[{count:04d}] 温度: {temp:.1f}°C  湿度: {humi:.1f}%")

        # 检查报警
        alerts = check_alert(temp, humi)
        if alerts:
            for alert in alerts:
                print(f"  ⚠ {alert}")
            alarm_buzzer()  # 蜂鸣器报警
        else:
            print("  ✅ 正常")
    else:
        print(f"[{count:04d}] 读取失败，5秒后重试...")

    # LED 闪烁表示在工作
    blink_led(1, 0.05)

    # 等待 5 秒
    time.sleep(5)
```

> **如果 DHT11 读取总是失败**：检查接线是否正确，DHT11 的数据引脚需要接上拉电阻（有的模块自带），确保使用 3.3V 供电。

**进阶：把数据上传到电脑（串口通信）**：

在电脑上用 Python 接收 ESP32 的数据并保存到 CSV 文件：

```python
"""
电脑端：接收 ESP32 串口数据并保存
安装：pip install pyserial
"""
import serial
import csv
from datetime import datetime

# 修改为你的 ESP32 串口
# Windows: "COM3", "COM4" 等
# Linux/Mac: "/dev/ttyUSB0" 或 "/dev/tty.usbserial-xxx"
SERIAL_PORT = "COM3"
BAUD_RATE = 115200

csv_file = open("sensor_data.csv", "a", newline="", encoding="utf-8")
writer = csv.writer(csv_file)
writer.writerow(["时间", "温度(°C)", "湿度(%)"])  # 写入表头

try:
    ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)
    print(f"已连接 {SERIAL_PORT}，等待数据...")

    while True:
        line = ser.readline().decode("utf-8", errors="ignore").strip()
        if not line:
            continue

        print(line)  # 打印原始数据

        # 简单解析：从 "[0001] 温度: 25.3°C  湿度: 60.5%" 中提取数值
        if "温度:" in line and "湿度:" in line:
            try:
                temp_str = line.split("温度:")[1].split("°C")[0].strip()
                humi_str = line.split("湿度:")[1].split("%")[0].strip()
                now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                writer.writerow([now, temp_str, humi_str])
                csv_file.flush()  # 立即写入磁盘
            except (IndexError, ValueError):
                continue

except KeyboardInterrupt:
    print("\n数据采集已停止")
finally:
    csv_file.close()
    if "ser" in locals():
        ser.close()
```

### 8.3 树莓派项目：智能家居控制

树莓派比 ESP32 强大得多——它运行完整的 Linux 系统，可以装 Python、跑 Web 服务、接摄像头。下面用树莓派的 GPIO 控制继电器，实现手机远程控制家电。

```python
"""
树莓派智能家居控制
硬件连接：
  - 继电器模块 IN → GPIO 18（控制灯）
  - 继电器模块 IN → GPIO 23（控制风扇）
  - DHT22 数据引脚 → GPIO 4（温湿度传感器）
功能：
  1. 读取室内温湿度
  2. 温度高于阈值自动开风扇
  3. 提供 Web 接口，手机远程控制
"""
import RPi.GPIO as GPIO
import time
import json
from http.server import HTTPServer, BaseHTTPRequestHandler
from datetime import datetime

# ===== GPIO 配置 =====
RELAY_LIGHT = 18    # 灯的继电器引脚
RELAY_FAN = 23      # 风扇的继电器引脚
DHT_PIN = 4         # DHT22 传感器引脚

# 继电器控制模式：低电平触发（大多数继电器模块）
RELAY_ON = GPIO.LOW
RELAY_OFF = GPIO.HIGH

# 自动控制阈值
FAN_ON_TEMP = 28.0   # 温度超过 28°C 自动开风扇
FAN_OFF_TEMP = 25.0   # 温度低于 25°C 自动关风扇

# ===== 设备状态 =====
device_state = {
    "light": False,   # 灯：关
    "fan": False,     # 风扇：关
    "auto_fan": True,  # 自动风扇控制：开
    "temperature": None,
    "humidity": None,
    "last_update": "",
}


def setup_gpio():
    """初始化 GPIO。"""
    GPIO.setmode(GPIO.BCM)
    GPIO.setwarnings(False)

    # 设置继电器引脚为输出
    GPIO.setup(RELAY_LIGHT, GPIO.OUT)
    GPIO.setup(RELAY_FAN, GPIO.OUT)

    # 初始状态：全部关闭
    GPIO.output(RELAY_LIGHT, RELAY_OFF)
    GPIO.output(RELAY_FAN, RELAY_OFF)


def control_light(on: bool):
    """控制灯。"""
    GPIO.output(RELAY_LIGHT, RELAY_ON if on else RELAY_OFF)
    device_state["light"] = on
    status = "开" if on else "关"
    print(f"[{datetime.now():%H:%M:%S}] 灯: {status}")


def control_fan(on: bool):
    """控制风扇。"""
    GPIO.output(RELAY_FAN, RELAY_ON if on else RELAY_OFF)
    device_state["fan"] = on
    status = "开" if on else "关"
    print(f"[{datetime.now():%H:%M:%S}] 风扇: {status}")


def read_dht22():
    """读取 DHT22 温湿度传感器。"""
    try:
        # 方式1：使用 adafruit-circuitpython-dht 库
        # import adafruit_dht
        # dht_device = adafruit_dht.DHT22(board.D4)
        # temp = dht_device.temperature
        # humi = dht_device.humidity

        # 方式2：使用系统命令读取（更稳定）
        import subprocess
        result = subprocess.run(
            ["python3", "-c",
             "import adafruit_dht, board; "
             "d = adafruit_dht.DHT22(board.D4); "
             "print(f'{d.temperature},{d.humidity}')"],
            capture_output=True, text=True, timeout=5
        )
        parts = result.stdout.strip().split(",")
        if len(parts) == 2:
            temp = float(parts[0])
            humi = float(parts[1])
            return temp, humi
    except Exception as e:
        print(f"DHT22 读取失败: {e}")
    return None, None


def auto_control():
    """自动控制逻辑：根据温度自动开关风扇。"""
    if not device_state["auto_fan"]:
        return

    temp = device_state["temperature"]
    if temp is None:
        return

    # 温度超过阈值 → 开风扇
    if temp > FAN_ON_TEMP and not device_state["fan"]:
        control_fan(True)
        print(f"  自动控制: 温度 {temp}°C > {FAN_ON_TEMP}°C，开启风扇")

    # 温度低于阈值 → 关风扇
    elif temp < FAN_OFF_TEMP and device_state["fan"]:
        control_fan(False)
        print(f"  自动控制: 温度 {temp}°C < {FAN_OFF_TEMP}°C，关闭风扇")


# ===== Web 控制接口 =====

class SmartHomeHandler(BaseHTTPRequestHandler):
    """智能家居 Web 控制处理器。"""

    def do_GET(self):
        """处理 GET 请求。"""
        if self.path == "/" or self.path == "/index.html":
            # 返回控制页面
            html = self._get_control_page()
            self._send_response(200, html, "text/html")

        elif self.path == "/api/status":
            # 返回设备状态 JSON
            self._send_response(200, json.dumps(device_state, ensure_ascii=False), "application/json")

        else:
            self._send_response(404, "Not Found")

    def do_POST(self):
        """处理 POST 请求，控制设备。"""
        content_length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(content_length).decode("utf-8")

        try:
            data = json.loads(body)
        except json.JSONDecodeError:
            self._send_response(400, '{"error": "Invalid JSON"}')
            return

        # 控制灯
        if "light" in data:
            control_light(data["light"])

        # 控制风扇
        if "fan" in data:
            control_fan(data["fan"])

        # 自动模式
        if "auto_fan" in data:
            device_state["auto_fan"] = data["auto_fan"]

        self._send_response(200, json.dumps(device_state, ensure_ascii=False), "application/json")

    def _send_response(self, code: int, content: str, content_type: str = "text/plain"):
        """发送 HTTP 响应。"""
        self.send_response(code)
        self.send_header("Content-Type", f"{content_type}; charset=utf-8")
        self.send_header("Access-Control-Allow-Origin", "*")  # 允许跨域
        self.end_headers()
        self.wfile.write(content.encode("utf-8"))

    def _get_control_page(self) -> str:
        """生成简易控制页面。"""
        return """<!DOCTYPE html>
<html><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>智能家居控制</title>
<style>
  body { font-family: sans-serif; text-align: center; padding: 20px; }
  .device { border: 2px solid #ddd; border-radius: 12px; padding: 20px;
            margin: 10px; display: inline-block; min-width: 200px; }
  .btn { padding: 12px 30px; font-size: 18px; border: none;
         border-radius: 8px; cursor: pointer; margin: 5px; }
  .btn-on { background: #4CAF50; color: white; }
  .btn-off { background: #f44336; color: white; }
  #status { margin-top: 20px; font-size: 16px; }
</style></head>
<body>
<h1>🏠 智能家居控制</h1>
<div class="device">
  <h2>💡 灯</h2>
  <button class="btn btn-on" onclick="control('light', true)">开灯</button>
  <button class="btn btn-off" onclick="control('light', false)">关灯</button>
</div>
<div class="device">
  <h2>🌀 风扇</h2>
  <button class="btn btn-on" onclick="control('fan', true)">开风扇</button>
  <button class="btn btn-off" onclick="control('fan', false)">关风扇</button>
</div>
<div id="status">加载中...</div>
<script>
function control(device, state) {
  fetch('/api/status', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify({[device]: state})
  }).then(r => r.json()).then(updateStatus);
}
function updateStatus(s) {
  document.getElementById('status').innerHTML =
    `🌡 温度: ${s.temperature ?? '--'}°C &nbsp; 💧 湿度: ${s.humidity ?? '--'}%<br>`
    + `💡 灯: ${s.light ? '开' : '关'} &nbsp; 🌀 风扇: ${s.fan ? '开' : '关'}<br>`
    + `🤖 自动风扇: ${s.auto_fan ? '开' : '关'}`;
}
setInterval(() => fetch('/api/status').then(r=>r.json()).then(updateStatus), 3000);
fetch('/api/status').then(r=>r.json()).then(updateStatus);
</script>
</body></html>"""


# ===== 主程序 =====
def main():
    """主函数。"""
    setup_gpio()
    print("智能家居系统启动")
    print(f"风扇自动控制: 温度 > {FAN_ON_TEMP}°C 开启, < {FAN_OFF_TEMP}°C 关闭")

    # 启动 Web 服务器（在独立线程中运行）
    server = HTTPServer(("0.0.0.0", 8080), SmartHomeHandler)
    print("Web 控制面板: http://树莓派IP:8080")

    import threading
    server_thread = threading.Thread(target=server.serve_forever, daemon=True)
    server_thread.start()

    try:
        while True:
            # 读取传感器
            temp, humi = read_dht22()
            if temp is not None:
                device_state["temperature"] = round(temp, 1)
                device_state["humidity"] = round(humi, 1)
                device_state["last_update"] = datetime.now().strftime("%H:%M:%S")
                print(f"[{device_state['last_update']}] "
                      f"温度: {temp:.1f}°C  湿度: {humi:.1f}%")

            # 自动控制
            auto_control()

            # 每 10 秒采集一次
            time.sleep(10)

    except KeyboardInterrupt:
        print("\n正在关闭...")
    finally:
        GPIO.cleanup()
        server.shutdown()
        print("已清理 GPIO，程序退出")


if __name__ == "__main__":
    main()
```

> **树莓派项目上手步骤**：
> 1. 烧录 Raspberry Pi OS（官方系统）
> 2. 连接 WiFi，SSH 登录
> 3. `pip install RPi.GPIO adafruit-circuitpython-dht`
> 4. 按照接线说明连接继电器和传感器
> 5. 运行脚本，手机浏览器访问 `http://树莓派IP:8080`

### 8.4 常见新手坑

| 坑 | 说明 | 解决方案 |
|---|---|---|
| **ESP32 串口连不上** | Thonny 找不到 ESP32 | 安装 CP210x/CH340 驱动，换 USB 线（有些线只能充电不能传数据） |
| **DHT 读取经常失败** | 传感器偶尔返回错误 | 加 `try-except` 忽略失败，自动重试 |
| **GPIO 编号混乱** | BCM 和 BOARD 两种编号方式 | 统一使用 `GPIO.BCM` 编号，和网上教程一致 |
| **继电器不工作** | 继电器没反应 | 确认是高电平还是低电平触发，大多数模块是低电平触发 |
| **树莓派 GPIO 烧毁** | 接错电压导致 GPIO 损坏 | GPIO 只能输出 3.3V，接 5V 设备必须用继电器或电平转换 |
| **MicroPython 固件版本不对** | 导入模块报错 | 从 [micropython.org](https://micropython.org/download/ESP32_GENERIC/) 下载最新固件重新烧录 |
| **ESP32 重启循环** | 程序报错导致反复重启 | 在 Thonny 中查看错误信息，修复后重新保存 |
| **WiFi 连接不稳定** | ESP32 WiFi 频繁断开 | 添加自动重连逻辑，检查路由器信号强度 |

---

## 9. 各领域学习路径建议

> 以下路径包含**具体学习资源、推荐练手项目**，帮你从"知道技术栈"到"真正能做项目"。

### 9.1 Web 后端工程师

```
阶段 1：基础（2-4 周）
  ├── Python 基础（阶段一~四）
  ├── HTTP 协议理解（请求方法、状态码、Header）
  └── SQL 基础（SELECT / JOIN / 索引）

  📚 资源：
  - MDN HTTP 教程：https://developer.mozilla.org/zh-CN/docs/Web/HTTP
  - SQLZoo 在线练习：https://sqlzoo.net
  - 练手项目：用 Flask 写一个 TODO API（增删改查）

阶段 2：框架深入（4-6 周）
  ├── FastAPI / Django 深入
  ├── SQLAlchemy ORM
  ├── 认证授权（JWT/OAuth2）
  └── RESTful API 设计

  📚 资源：
  - FastAPI 官方教程：https://fastapi.tiangolo.com/zh/tutorial/
  - Django 官方教程（Polls 应用）：https://docs.djangoproject.com/zh-hans/
  - 练手项目：博客系统 API（用户注册/登录/文章CRUD/评论/分页）

阶段 3：工程化（4-6 周）
  ├── 测试（pytest + 覆盖率）
  ├── Docker 容器化
  ├── CI/CD（GitHub Actions）
  └── 监控与日志

  📚 资源：
  - pytest 官方文档：https://docs.pytest.org/
  - Docker 从入门到实践：https://yeasy.github.io/docker_practice/
  - 练手项目：将阶段2的项目 Docker 化 + 添加 CI/CD + 部署到云服务器

阶段 4：高级（持续学习）
  ├── 微服务架构
  ├── 分布式系统（消息队列/缓存）
  ├── 性能优化（异步/数据库优化）
  └── 安全加固

  📚 资源：
  - 《Python Web 开发实战》
  - 练手项目：电商后端（多服务 + Redis 缓存 + Celery 异步任务）
```

### 9.2 数据工程师 / 数据分析师

```
阶段 1：基础（3-4 周）
  ├── Python + NumPy + Pandas（参见本阶段第2节）
  ├── SQL 高级（窗口函数/CTE/子查询）
  └── 统计学基础（均值/方差/假设检验/相关系数）

  📚 资源：
  - Pandas 官方 10 分钟入门：https://pandas.pydata.org/docs/getting_started/intro_tutorials/
  - LeetCode SQL 题库：https://leetcode.cn/problemset/database/
  - 练手项目：用 Pandas 分析某电商真实数据集（Kaggle 下载）

阶段 2：可视化与报告（2-3 周）
  ├── Matplotlib / Seaborn / Plotly
  ├── Jupyter Notebook 技巧
  └── 数据报告撰写

  📚 资源：
  - Python Data Science Handbook：https://jakevdp.github.io/PythonDataScienceHandbook/
  - 练手项目：某行业数据分析报告（含 5+ 种图表、结论、建议）

阶段 3：机器学习基础（4-6 周）
  ├── Scikit-learn 完整流程
  ├── 特征工程
  └── 模型评估与调优

  📚 资源：
  - Scikit-learn 官方教程：https://scikit-learn.org/stable/tutorial/
  - Kaggle 入门竞赛：Titanic / House Prices
  - 练手项目：Kaggle 首战（Titanic 生存预测，Top 50% 即可）

阶段 4：大数据（进阶）
  ├── ETL 流程（Airflow / Prefect）
  ├── 大数据（PySpark / Dask）
  ├── 数据仓库
  └── 消息队列（Kafka）

  📚 资源：
  - PySpark 官方文档
  - 练手项目：构建 ETL 管道（CSV → 清洗 → 聚合 → 入库）
```

### 9.3 AI/ML 工程师

```
阶段 1：基础（4-6 周）
  ├── Python + NumPy + Pandas
  ├── 线性代数（矩阵运算/特征值/向量空间）
  ├── 概率统计（贝叶斯/分布/假设检验）
  └── 机器学习理论（分类/回归/聚类/降维）

  📚 资源：
  - 吴恩达机器学习课程：https://www.coursera.org/learn/machine-learning
  - 3Blue1Brown 线性代数（视频）：https://www.3blue1brown.com/topics/linear-algebra
  - 练手项目：手写数字分类（MNIST，不使用框架，纯 NumPy 实现）

阶段 2：实践（6-8 周）
  ├── Scikit-learn 熟练使用
  ├── PyTorch / TensorFlow 深度学习
  ├── CNN / RNN / Transformer 原理
  └── 模型部署（ONNX / TorchServe）

  📚 资源：
  - PyTorch 官方教程：https://pytorch.org/tutorials/
  - 动手学深度学习（d2l.ai）：https://zh.d2l.ai/
  - 练手项目：图像分类（CIFAR-10）+ 文本分类（IMDB 情感分析）

阶段 3：应用（持续学习）
  ├── LLM 应用开发（LangChain / LlamaIndex）
  ├── 计算机视觉（YOLO / SAM）
  ├── NLP（BERT / GPT 微调）
  └── MLOps（MLflow / Weights & Biases）

  📚 资源：
  - LangChain 官方文档：https://python.langchain.com/
  - Hugging Face 教程：https://huggingface.co/learn
  - 练手项目：RAG 知识库问答系统（用自己整理的文档构建）
```

### 9.4 爬虫工程师

```
阶段 1：基础（1-2 周）
  ├── requests + BeautifulSoup（参见本阶段第3节）
  ├── HTTP 协议和开发者工具
  └── 数据存储

  📚 资源：
  - requests 官方文档：https://requests.readthedocs.io/
  - 练手项目：爬取某新闻网站标题和链接，保存为 CSV

阶段 2：进阶（2-3 周）
  ├── 动态页面（Playwright）
  ├── Scrapy 框架
  └── 反反爬技术

  📚 资源：
  - Scrapy 官方教程：https://docs.scrapy.org/
  - Playwright Python 文档：https://playwright.dev/python/
  - 练手项目：爬取某电商商品信息（含翻页+异步+存数据库）

阶段 3：规模化（进阶）
  ├── 分布式爬虫（Scrapy-Redis）
  ├── 代理池和验证码
  └── 增量爬取和去重

  📚 资源：
  - 练手项目：分布式爬虫（多机协同爬取百万级数据）
```

### 9.5 综合练手项目推荐

| 难度 | 项目 | 涉及技术 | 预计时间 |
|------|------|----------|----------|
| 入门 | 个人博客 API | FastAPI + SQLite + JWT | 1 周 |
| 入门 | 豆瓣电影 Top250 爬虫 | requests + BeautifulSoup | 2 天 |
| 入门 | CSV 数据分析报告 | Pandas + Matplotlib | 3 天 |
| 中级 | 电商后台管理系统 | Django + ORM + Admin | 2 周 |
| 中级 | 新闻聚合爬虫 | Scrapy + Playwright + Pipeline | 1 周 |
| 中级 | 销售数据仪表盘 | Dash + Plotly + Pandas | 1 周 |
| 高级 | AI 客服聊天机器人 | LangChain + Chroma + FastAPI | 2 周 |
| 高级 | 股票分析系统 | yfinance + Scikit-learn + Dash | 3 周 |
| 高级 | 自动化部署平台 | Docker SDK + Fabric + CI/CD | 3 周 |

**项目来源**：
- Kaggle 数据集：https://www.kaggle.com/datasets
- 真实 API：GitHub API / 天气 API / 新闻 API
- 公开数据：国家统计局 / 各城市开放数据平台

---

## 附录：第十阶段自检清单

- [ ] 能用 FastAPI/Django/Flask 搭建简单的 Web API
- [ ] 能用 Pandas 完成数据清洗、筛选、聚合操作
- [ ] 能用 requests + BeautifulSoup 抓取静态网页
- [ ] 了解 Scikit-learn 的基本使用流程（训练/预测/评估）
- [ ] 了解 PyTorch 的基本概念（Tensor、Model、Loss、Optimizer）
- [ ] 了解 OpenAI API / LangChain 的基本用法
- [ ] 能用 subprocess / Fabric 编写自动化运维脚本
- [ ] 了解至少一种 GUI 框架的基本用法
- [ ] 了解 Docker 的基本概念（镜像、容器、Dockerfile）
- [ ] 能根据自身兴趣选择一个方向制定学习路径

---

## 附录：Python 学习路线图总结

```
┌──────────────────────────────────────────────────────────────────┐
│                    Python 学习路线图                             │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  第一阶段：基础语法与核心编程                                     │
│     ├── 变量、数据类型、运算符                                    │
│     ├── 流程控制（if/for/while）                                 │
│     ├── 函数定义与调用                                           │
│     └── 列表、字典、集合                                         │
│                                                                  │
│  第二阶段：函数与函数式编程                                       │
│     ├── 函数参数、返回值                                         │
│     ├── 匿名函数、闭包、装饰器                                    │
│     ├── 生成器、迭代器                                           │
│     └── functools / itertools                                   │
│                                                                  │
│  第三阶段：面向对象编程                                           │
│     ├── 类与对象                                                 │
│     ├── 继承、多态                                               │
│     ├── 封装、属性装饰器                                         │
│     └── 设计模式入门                                             │
│                                                                  │
│  第四阶段：异常处理与调试                                         │
│     ├── try-except 异常处理                                      │
│     ├── 自定义异常                                               │
│     ├── 日志记录                                                 │
│     └── 调试技巧                                                 │
│                                                                  │
│  第五阶段：模块、包与项目结构                                     │
│     ├── import 机制                                              │
│     ├── 包管理                                                   │
│     ├── 项目结构设计                                             │
│     └── __init__.py / __main__.py                               │
│                                                                  │
│  第六阶段：文件 I/O 与序列化                                      │
│     ├── 文件读写                                                 │
│     ├── 上下文管理器                                             │
│     ├── JSON / Pickle / CSV                                     │
│     └── 压缩与归档                                               │
│                                                                  │
│  第七阶段：高级特性                                               │
│     ├── 迭代器协议                                               │
│     ├── 生成器（send/throw/close）                               │
│     ├── 装饰器进阶                                               │
│     ├── 描述符、元类                                             │
│     └── async/await 协程                                        │
│                                                                  │
│  第八阶段：标准库核心模块                                         │
│     ├── collections / itertools / functools                      │
│     ├── re / datetime / pathlib                                  │
│     ├── threading / multiprocessing / asyncio                    │
│     └── unittest / argparse / logging                            │
│                                                                  │
│  第九阶段：工程化与代码质量                                       │
│     ├── PEP 8 / black / isort / flake8                          │
│     ├── pytest / Mock / 测试覆盖率                               │
│     ├── cProfile / 性能优化                                      │
│     ├── CI/CD（GitHub Actions）                                 │
│     └── 打包发布（pyproject.toml / Docker）                      │
│                                                                  │
│  第十阶段：主流应用领域                                           │
│     ├── Web 开发（FastAPI/Django/Flask）                         │
│     ├── 数据科学（NumPy/Pandas/Scikit-learn）                    │
│     ├── AI/ML（PyTorch/LangChain）                               │
│     ├── 爬虫（requests/Scrapy）                                  │
│     ├── 自动化运维（subprocess/Fabric）                          │
│     └── 桌面应用 / 游戏开发 / 物联网                             │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## 10. AI 与数据科学实战进阶

### 10.1 端到端机器学习项目

**目标**：构建一个完整的机器学习项目，从数据收集到模型部署。

**项目：房价预测系统**

```python
# 第一步：数据收集与探索
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor
from sklearn.metrics import mean_squared_error, r2_score
import joblib

# 加载数据
df = pd.read_csv("house_prices.csv")

# 数据探索
print(df.info())
print(df.describe())
print(df.isnull().sum())

# 可视化
plt.figure(figsize=(12, 8))
sns.heatmap(df.corr(), annot=True, cmap='coolwarm')
plt.title("特征相关性热力图")
plt.savefig("correlation_heatmap.png")

# 第二步：数据预处理
# 处理缺失值
df['area'] = df['area'].fillna(df['area'].median())
df['bedrooms'] = df['bedrooms'].fillna(df['bedrooms'].mode()[0])

# 特征工程
df['price_per_sqm'] = df['price'] / df['area']
df['age_category'] = pd.cut(df['age'], bins=[0, 5, 15, 30, 100], labels=['new', 'medium', 'old', 'very_old'])

# 编码分类特征
le = LabelEncoder()
df['location_encoded'] = le.fit_transform(df['location'])

# 特征选择
features = ['area', 'bedrooms', 'bathrooms', 'age', 'location_encoded', 'price_per_sqm']
X = df[features]
y = df['price']

# 划分数据集
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 特征缩放
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# 第三步：模型训练与对比
models = {
    'RandomForest': RandomForestRegressor(n_estimators=100, random_state=42),
    'GradientBoosting': GradientBoostingRegressor(n_estimators=100, random_state=42)
}

results = {}
for name, model in models.items():
    model.fit(X_train_scaled, y_train)
    y_pred = model.predict(X_test_scaled)

    mse = mean_squared_error(y_test, y_pred)
    r2 = r2_score(y_test, y_pred)

    results[name] = {
        'model': model,
        'mse': mse,
        'r2': r2,
        'predictions': y_pred
    }

    print(f"{name}:")
    print(f"  MSE: {mse:.2f}")
    print(f"  R²: {r2:.4f}")

# 选择最佳模型
best_model_name = max(results, key=lambda x: results[x]['r2'])
best_model = results[best_model_name]['model']
print(f"\n最佳模型: {best_model_name}")

# 第四步：模型保存与部署
joblib.dump(best_model, 'house_price_model.pkl')
joblib.dump(scaler, 'scaler.pkl')
joblib.dump(le, 'label_encoder.pkl')

# 第五步：预测 API（FastAPI）
from fastapi import FastAPI
from pydantic import BaseModel
import joblib

app = FastAPI(title="房价预测 API")

# 加载模型
model = joblib.load('house_price_model.pkl')
scaler = joblib.load('scaler.pkl')
label_encoder = joblib.load('label_encoder.pkl')

class HouseFeatures(BaseModel):
    area: float
    bedrooms: int
    bathrooms: int
    age: int
    location: str

@app.post("/predict")
async def predict_price(features: HouseFeatures):
    """预测房价。"""
    # 特征工程
    location_encoded = label_encoder.transform([features.location])[0]

    # 构建特征向量
    input_data = np.array([[
        features.area,
        features.bedrooms,
        features.bathrooms,
        features.age,
        location_encoded
    ]])

    # 预测
    input_scaled = scaler.transform(input_data)
    predicted_price = model.predict(input_scaled)[0]

    return {
        "predicted_price": round(predicted_price, 2),
        "confidence": "medium",
        "model": best_model_name
    }

# 运行：uvicorn house_price_api:app --reload
```

---

### 10.2 大语言模型（LLM）应用开发

**项目：智能客服助手**

```python
import openai
from typing import List, Dict
import json
from dataclasses import dataclass
from enum import Enum

# 配置 OpenAI API
openai.api_key = "your-api-key"

class Intent(Enum):
    """用户意图。"""
    PRODUCT_INQUIRY = "产品咨询"
    ORDER_STATUS = "订单查询"
    REFUND_REQUEST = "退款申请"
    TECH_SUPPORT = "技术支持"
    GENERAL_QUESTION = "一般问题"

@dataclass
class Message:
    """对话消息。"""
    role: str  # 'user' / 'assistant' / 'system'
    content: str

class CustomerServiceBot:
    """智能客服机器人。"""

    def __init__(self, model: str = "gpt-4"):
        self.model = model
        self.conversation_history: List[Dict] = []
        self.system_prompt = """你是一个专业的客服助手,负责回答用户关于产品、订单和技术支持的问题。

规则：
1. 友好、专业地回答问题
2. 如果涉及订单号、退款等敏感操作,请提醒用户提供相关信息
3. 无法回答的问题,请建议联系人工客服
4. 保持回答简洁明了"""

        self.conversation_history.append({
            "role": "system",
            "content": self.system_prompt
        })

        # 知识库（实际应用中应从数据库加载）
        self.knowledge_base = {
            "退货政策": "购买后7天内可无理由退货,需保持商品完好。",
            "发货时间": "订单支付成功后48小时内发货。",
            "运费": "订单满99元包邮,否则运费10元。"
        }

    def classify_intent(self, user_message: str) -> Intent:
        """意图分类（使用 LLM）。"""
        prompt = f"""分类以下用户消息的意图:
消息: "{user_message}"

可能的意图:
- PRODUCT_INQUIRY: 产品咨询（价格、规格等）
- ORDER_STATUS: 订单查询（物流、状态）
- REFUND_REQUEST: 退款申请
- TECH_SUPPORT: 技术支持
- GENERAL_QUESTION: 一般问题

只返回意图代码,不要其他内容。"""

        response = openai.ChatCompletion.create(
            model=self.model,
            messages=[{"role": "user", "content": prompt}],
            temperature=0,
            max_tokens=20
        )

        intent_str = response.choices[0].message.content.strip()

        # 映射到枚举
        intent_mapping = {
            "PRODUCT_INQUIRY": Intent.PRODUCT_INQUIRY,
            "ORDER_STATUS": Intent.ORDER_STATUS,
            "REFUND_REQUEST": Intent.REFUND_REQUEST,
            "TECH_SUPPORT": Intent.TECH_SUPPORT,
            "GENERAL_QUESTION": Intent.GENERAL_QUESTION
        }

        return intent_mapping.get(intent_str, Intent.GENERAL_QUESTION)

    def search_knowledge(self, query: str) -> str:
        """搜索知识库（简化版）。"""
        for key, value in self.knowledge_base.items():
            if key in query:
                return value
        return "未找到相关信息。"

    def chat(self, user_message: str) -> str:
        """对话主流程。"""
        # 意图分类
        intent = self.classify_intent(user_message)

        # 添加用户消息
        self.conversation_history.append({
            "role": "user",
            "content": user_message
        })

        # 如果是知识库问题,优先返回知识库答案
        knowledge_answer = self.search_knowledge(user_message)
        if knowledge_answer != "未找到相关信息。":
            return knowledge_answer

        # 调用 LLM
        response = openai.ChatCompletion.create(
            model=self.model,
            messages=self.conversation_history,
            temperature=0.7,
            max_tokens=500
        )

        assistant_message = response.choices[0].message.content

        # 添加助手回复
        self.conversation_history.append({
            "role": "assistant",
            "content": assistant_message
        })

        return assistant_message

    def reset(self):
        """重置对话。"""
        self.conversation_history = [
            {"role": "system", "content": self.system_prompt}
        ]

# 使用示例
bot = CustomerServiceBot()

print(bot.chat("你好,我想了解一下退货政策"))
# 输出: 购买后7天内可无理由退货,需保持商品完好。

print(bot.chat("那运费是多少呢？"))
# 输出: 订单满99元包邮,否则运费10元。

print(bot.chat("我的订单什么时候发货？"))
# 输出: 订单支付成功后48小时内发货。
```

**LangChain 实现（更结构化）**：

```python
from langchain.chat_models import ChatOpenAI
from langchain.prompts import ChatPromptTemplate
from langchain.chains import LLMChain, ConversationalRetrievalChain
from langchain.memory import ConversationBufferMemory
from langchain.vectorstores import Chroma
from langchain.embeddings import OpenAIEmbeddings
from langchain.document_loaders import TextLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter

# 初始化 LLM
llm = ChatOpenAI(model_name="gpt-4", temperature=0.7)

# 加载知识库
loader = TextLoader("customer_service_manual.txt")
documents = loader.load()

# 文档分割
text_splitter = RecursiveCharacterTextSplitter(
    chunk_size=1000,
    chunk_overlap=200
)
splits = text_splitter.split_documents(documents)

# 构建向量数据库
vectorstore = Chroma.from_documents(
    documents=splits,
    embedding=OpenAIEmbeddings()
)

# 创建对话链
memory = ConversationBufferMemory(
    memory_key="chat_history",
    return_messages=True
)

qa_chain = ConversationalRetrievalChain.from_llm(
    llm=llm,
    retriever=vectorstore.as_retriever(),
    memory=memory,
    return_source_documents=True
)

# 对话
response = qa_chain({"question": "退货政策是什么？"})
print(response['answer'])

response = qa_chain({"question": "发货需要多久？"})
print(response['answer'])
```

---

### 10.3 数据可视化与仪表盘

**项目：销售数据仪表盘**

```python
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import dash
from dash import dcc, html
from dash.dependencies import Input, Output

# 数据准备（模拟）
df = pd.DataFrame({
    'date': pd.date_range('2025-01-01', periods=90, freq='D'),
    'sales': np.random.randint(1000, 5000, 90),
    'category': np.random.choice(['Electronics', 'Clothing', 'Books'], 90),
    'region': np.random.choice(['North', 'South', 'East', 'West'], 90)
})

df['month'] = df['date'].dt.to_period('M').astype(str)
df['week'] = df['date'].dt.isocalendar().week

# Dash 应用
app = dash.Dash(__name__)

app.layout = html.Div([
    html.H1("销售数据仪表盘", style={'textAlign': 'center'}),

    # 控制面板
    html.Div([
        dcc.Dropdown(
            id='category-dropdown',
            options=[{'label': cat, 'value': cat} for cat in df['category'].unique()],
            value='Electronics',
            clearable=False
        ),
        dcc.DatePickerRange(
            id='date-range',
            min_date_allowed=df['date'].min(),
            max_date_allowed=df['date'].max(),
            start_date=df['date'].min(),
            end_date=df['date'].max()
        )
    ], style={'display': 'flex', 'gap': '20px', 'padding': '20px'}),

    # 图表区域
    html.Div([
        dcc.Graph(id='sales-trend'),
        dcc.Graph(id='sales-by-region'),
        dcc.Graph(id='sales-by-category')
    ], style={'display': 'grid', 'gridTemplateColumns': 'repeat(2, 1fr)', 'gap': '20px'})
])

@app.callback(
    [Output('sales-trend', 'figure'),
     Output('sales-by-region', 'figure'),
     Output('sales-by-category', 'figure')],
    [Input('category-dropdown', 'value'),
     Input('date-range', 'start_date'),
     Input('date-range', 'end_date')]
)
def update_charts(category, start_date, end_date):
    # 过滤数据
    filtered_df = df[
        (df['category'] == category) &
        (df['date'] >= start_date) &
        (df['date'] <= end_date)
    ]

    # 图表1: 销售趋势
    trend_fig = px.line(
        filtered_df.groupby('date')['sales'].sum().reset_index(),
        x='date',
        y='sales',
        title='销售趋势'
    )

    # 图表2: 区域分布
    region_fig = px.bar(
        filtered_df.groupby('region')['sales'].sum().reset_index(),
        x='region',
        y='sales',
        title='区域销售分布',
        color='region'
    )

    # 图表3: 类别占比
    category_fig = px.pie(
        filtered_df,
        values='sales',
        names='category',
        title='类别销售占比'
    )

    return trend_fig, region_fig, category_fig

# 运行：python app.py
if __name__ == '__main__':
    app.run_server(debug=True)
```

---

## 11. 常见面试题汇总

### 11.1 Web 开发相关

**Q1: FastAPI 与 Flask/Django 的主要区别？**

**答案要点**：

| 特性 | FastAPI | Flask | Django |
|------|---------|-------|--------|
| 异步支持 | 原生支持 | 需要扩展 | Django 3.0+ 支持 |
| 性能 | 高（异步） | 中等 | 中等 |
| 自动文档 | Swagger/ReDoc 自动生成 | 需要手动 | 需要第三方库 |
| 学习曲线 | 中等 | 低 | 高 |
| 类型系统 | Pydantic 强类型 | 无 | 弱类型 |
| 适用场景 | 高性能 API | 小型项目 | 全功能网站 |

```python
# FastAPI 示例（自动生成文档）
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Item(BaseModel):
    name: str
    price: float

@app.post("/items/")
async def create_item(item: Item):
    return item

# 访问 /docs 自动生成 Swagger UI
```

---

**Q2: 什么是 ORM？为什么使用 ORM？**

**答案要点**：
- ORM（对象关系映射）：将数据库表映射为 Python 类
- 优势：
  1. 不用写 SQL，提高开发效率
  2. 数据库无关性（切换数据库无需改代码）
  3. 自动处理关系、事务
  4. 代码更易维护和测试

```python
# SQLAlchemy ORM 示例
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

Base = declarative_base()

class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True)
    name = Column(String(50))
    email = Column(String(100), unique=True)

    # 关系
    posts = relationship("Post", back_populates="author")

class Post(Base):
    __tablename__ = 'posts'

    id = Column(Integer, primary_key=True)
    title = Column(String(100))
    author_id = Column(Integer, ForeignKey('users.id'))

    author = relationship("User", back_populates="posts")
```

---

### 11.2 数据科学相关

**Q3: Pandas 中 `groupby` 的工作原理？**

```python
import pandas as pd

df = pd.DataFrame({
    'category': ['A', 'B', 'A', 'B', 'A'],
    'value': [10, 20, 15, 25, 30]
})

# groupby 分三步：
# 1. Split: 按 category 分组
# 2. Apply: 对每组应用聚合函数
# 3. Combine: 合并结果

result = df.groupby('category')['value'].sum()
# 输出:
# category
# A    55
# B    45

# 多级分组
result = df.groupby(['category', 'value']).size()
```

---

**Q4: 如何处理数据中的缺失值？**

```python
import pandas as pd
import numpy as np

df = pd.DataFrame({
    'A': [1, 2, np.nan, 4],
    'B': [5, np.nan, np.nan, 8],
    'C': ['a', 'b', 'c', np.nan]
})

# 方法1: 删除缺失值
df_drop = df.dropna()  # 删除含缺失值的行
df_drop_cols = df.dropna(axis=1)  # 删除含缺失值的列

# 方法2: 填充缺失值
df_fill_zero = df.fillna(0)  # 用 0 填充
df_fill_mean = df['A'].fillna(df['A'].mean())  # 用均值填充
df_fill_median = df['B'].fillna(df['B'].median())  # 用中位数填充

# 方法3: 插值
df_interpolate = df.interpolate()  # 线性插值

# 方法4: 前向/后向填充
df_ffill = df.fillna(method='ffill')  # 前向填充
df_bfill = df.fillna(method='bfill')  # 后向填充
```

---

### 11.3 AI/ML 相关

**Q5: 解释机器学习中的过拟合与欠拟合。**

**答案要点**：

| 问题 | 定义 | 原因 | 解决方法 |
|------|------|------|----------|
| **过拟合** | 模型在训练集表现好,测试集差 | 模型太复杂、数据量少、训练时间长 | 正则化、Dropout、增加数据、早停 |
| **欠拟合** | 训练集和测试集都表现差 | 模型太简单、特征不足 | 增加特征、使用更复杂模型、减少正则化 |

```python
from sklearn.model_selection import learning_curve
import matplotlib.pyplot as plt
import numpy as np

# 学习曲线诊断
train_sizes, train_scores, test_scores = learning_curve(
    estimator=RandomForestClassifier(),
    X=X_train,
    y=y_train,
    train_sizes=np.linspace(0.1, 1.0, 10),
    cv=5
)

train_mean = np.mean(train_scores, axis=1)
test_mean = np.mean(test_scores, axis=1)

plt.plot(train_sizes, train_mean, label='Training Score')
plt.plot(train_sizes, test_mean, label='Cross-validation Score')
plt.xlabel('Training Size')
plt.ylabel('Score')
plt.legend()
plt.show()

# 过拟合: Training Score 高, Cross-validation Score 低
# 欠拟合: 两者都低
```

---

**Q6: 什么是交叉验证？为什么使用？**

**答案要点**：
- 目的：更准确评估模型性能，避免过拟合
- 原理：将数据分成 K 份，轮流用 K-1 份训练，1 份验证，重复 K 次

```python
from sklearn.model_selection import cross_val_score, KFold
from sklearn.ensemble import RandomForestClassifier

# K 折交叉验证
kfold = KFold(n_splits=5, shuffle=True, random_state=42)
model = RandomForestClassifier()

scores = cross_val_score(model, X, y, cv=kfold, scoring='accuracy')
print(f"准确率: {scores.mean():.3f} (+/- {scores.std():.3f})")

# 分层 K 折（保持类别比例）
from sklearn.model_selection import StratifiedKFold

skfold = StratifiedKFold(n_splits=5, shuffle=True, random_state=42)
scores = cross_val_score(model, X, y, cv=skfold)
```

---

### 11.4 爬虫相关

**Q7: 如何处理动态加载的网页？**

```python
# 方法1: Selenium
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

driver = webdriver.Chrome()
driver.get("https://example.com")

# 等待元素加载
element = WebDriverWait(driver, 10).until(
    EC.presence_of_element_located((By.CLASS_NAME, "dynamic-content"))
)

content = element.text
driver.quit()

# 方法2: Playwright（推荐）
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)
    page = browser.new_page()
    page.goto("https://example.com")

    # 等待动态内容
    page.wait_for_selector(".dynamic-content")
    content = page.text_content(".dynamic-content")

    browser.close()

# 方法3: 分析 API 请求（最快）
import requests

# 使用浏览器开发者工具找到真实的 API 端点
api_url = "https://example.com/api/data"
response = requests.get(api_url)
data = response.json()
```

---

### 11.5 DevOps 相关

**Q8: 解释 Docker 的核心概念。**

**答案要点**：
- **镜像（Image）**：只读模板，包含运行应用所需的一切（代码、依赖、配置）
- **容器（Container）**：镜像的运行实例，相互隔离
- **Dockerfile**：构建镜像的脚本
- **仓库（Registry）**：存储和分发镜像（如 Docker Hub）

```dockerfile
# Dockerfile 示例
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "app.py"]
```

```bash
# 常用命令
docker build -t myapp:1.0 .    # 构建镜像
docker run -p 8000:8000 myapp  # 运行容器
docker ps                       # 查看运行中的容器
docker logs <container_id>      # 查看日志
docker exec -it <container_id> bash  # 进入容器
```

---

## 12. 实战项目：多领域综合项目

### 12.1 项目概述

**目标**：构建一个完整的 AI 驱动的股票分析系统，涵盖数据采集、分析、预测和可视化。

**技术栈**：
- 数据采集：yfinance, BeautifulSoup
- 数据分析：Pandas, NumPy
- 机器学习：Scikit-learn, PyTorch
- 可视化：Plotly, Dash
- Web 界面：FastAPI
- 部署：Docker

### 12.2 项目架构

```
stock_analyzer/
├── src/
│   ├── data/
│   │   ├── collector.py      # 数据采集
│   │   └── preprocessor.py   # 数据预处理
│   ├── models/
│   │   ├── predictor.py      # 预测模型
│   │   └── trainer.py        # 模型训练
│   ├── api/
│   │   └── main.py           # FastAPI 接口
│   └── dashboard/
│       └── app.py            # Dash 仪表盘
├── tests/
├── requirements.txt
├── Dockerfile
└── docker-compose.yml
```

### 12.3 核心代码片段

**数据采集模块**：

```python
# src/data/collector.py
import yfinance as yf
import pandas as pd
from typing import List

class StockDataCollector:
    """股票数据采集器。"""

    def __init__(self, symbols: List[str]):
        self.symbols = symbols

    def fetch_historical_data(self, period: str = "1y") -> pd.DataFrame:
        """获取历史数据。"""
        data = yf.download(self.symbols, period=period, group_by='ticker')

        all_data = []
        for symbol in self.symbols:
            df = data[symbol].copy()
            df['symbol'] = symbol
            df['date'] = df.index
            all_data.append(df)

        return pd.concat(all_data, ignore_index=True)

    def fetch_realtime(self, symbol: str) -> dict:
        """获取实时数据。"""
        stock = yf.Ticker(symbol)
        info = stock.info

        return {
            'symbol': symbol,
            'price': info.get('currentPrice'),
            'change': info.get('regularMarketChange'),
            'change_percent': info.get('regularMarketChangePercent'),
            'volume': info.get('regularMarketVolume'),
            'market_cap': info.get('marketCap')
        }

# 使用
collector = StockDataCollector(['AAPL', 'GOOGL', 'MSFT'])
df = collector.fetch_historical_data(period="2y")
```

**预测模型**：

```python
# src/models/predictor.py
import numpy as np
import pandas as pd
from sklearn.preprocessing import MinMaxScaler
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, Dense, Dropout

class StockPricePredictor:
    """股票价格预测器（LSTM）。"""

    def __init__(self, sequence_length: int = 60):
        self.sequence_length = sequence_length
        self.scaler = MinMaxScaler(feature_range=(0, 1))
        self.model = None

    def prepare_data(self, prices: pd.Series) -> tuple:
        """准备训练数据。"""
        scaled_data = self.scaler.fit_transform(prices.values.reshape(-1, 1))

        X, y = [], []
        for i in range(self.sequence_length, len(scaled_data)):
            X.append(scaled_data[i-self.sequence_length:i])
            y.append(scaled_data[i])

        return np.array(X), np.array(y)

    def build_model(self, input_shape: tuple):
        """构建 LSTM 模型。"""
        model = Sequential([
            LSTM(50, return_sequences=True, input_shape=input_shape),
            Dropout(0.2),
            LSTM(50, return_sequences=False),
            Dropout(0.2),
            Dense(25),
            Dense(1)
        ])

        model.compile(optimizer='adam', loss='mean_squared_error')
        self.model = model

    def train(self, X_train, y_train, epochs: int = 50):
        """训练模型。"""
        self.model.fit(X_train, y_train, epochs=epochs, batch_size=32, verbose=1)

    def predict(self, recent_prices: pd.Series) -> float:
        """预测下一天价格。"""
        scaled = self.scaler.transform(recent_prices.values.reshape(-1, 1))
        X = scaled[-self.sequence_length:].reshape(1, self.sequence_length, 1)
        prediction = self.model.predict(X)
        return self.scaler.inverse_transform(prediction)[0][0]

# 使用
predictor = StockPricePredictor(sequence_length=60)
X, y = predictor.prepare_data(df['Close'])
predictor.build_model((X.shape[1], 1))
predictor.train(X, y, epochs=10)
next_price = predictor.predict(df['Close'][-100:])
```

---

> **工程师寄语**：Python 的强大在于它的"通用性"。但成为优秀的工程师，需要在某个领域深入扎根。选择一个你感兴趣的方向，从"能运行"到"能生产"，从"会写代码"到"会设计系统"。领域知识 + Python 技能 = 不可替代性。

> **最终建议**：
> 1. 不要贪多，选择一个方向深入
> 2. 做项目！项目经验比理论更重要
> 3. 持续学习，技术在不断演进
> 4. 加入社区，分享知识，帮助他人
> 5. 保持好奇心，享受编程的乐趣
# 毕设项目库博客 - 部署与维护指南

## 一、项目信息

- **博客地址**: https://bing997.github.io/LW-blog
- **GitHub 仓库**: https://github.com/bing997/LW-blog
- **主题**: Butterfly 5.5.4
- **框架**: Hexo 8.x
- **Node.js**: >= 18.x

---

## 二、目录结构

```
blog/                          # 博客根目录
├── _config.yml               # 主配置文件（本地开发环境，root: /）
├── _config.deploy.yml       # 部署环境配置（GitHub Pages，root: /LW-blog/）
├── _config.butterfly.yml    # Butterfly 主题配置
├── deploy.bat               # Windows 一键部署脚本
├── deploy.sh                # Linux/macOS 一键部署脚本
├── package.json             # 依赖管理
├── source/                  # 博客内容目录
│   ├── _data/               # 静态数据
│   │   ├── projects.json    # 毕设项目数据（102条）
│   │   └── link.yml         # 友链数据
│   ├── _posts/              # 博客文章
│   │   └── hello-world.md   # 示例文章
│   ├── projects/            # 毕设项目库页面
│   │   └── index.md
│   ├── about/               # 关于页面
│   │   └── index.md
│   ├── link/                # 友链页面
│   │   └── index.md
│   └── img/                 # 图片资源
├── themes/                  # 主题目录（空，主题在 node_modules 中）
└── node_modules/            # 依赖包
```

---

## 三、多环境配置说明（重要）

本项目采用**多环境配置**管理，解决本地开发与线上部署的路径差异问题。

### 环境配置对比

| 配置文件 | 用途 | `root` 设置 | 使用场景 |
|---------|------|------------|---------|
| `_config.yml` | 本地开发 | `root: /` | `hexo server` 本地预览 |
| `_config.deploy.yml` | 部署环境 | `root: /LW-blog/` | `hexo deploy` GitHub Pages |

### 为什么要分开配置？

- **本地开发**：服务器运行在根路径 `http://localhost:4000/`，资源路径需要是 `/css/xxx`、`/images/xxx`
- **GitHub Pages**：博客部署在子目录 `https://bing997.github.io/LW-blog/`，资源路径需要是 `/LW-blog/css/xxx`、`/LW-blog/images/xxx`

> **提示**：如果混用会导致资源 404 错误（CSS 不加载、图片不显示）。

---

## 四、日常部署命令

> **提示**: 所有命令在 `blog/` 目录下执行

### ✅ 推荐：一键部署脚本（最简单）

**Windows 用户**：
```bash
# 双击运行或在命令行执行
deploy.bat
```

**Linux / macOS 用户**：
```bash
# 先添加执行权限（首次使用）
chmod +x deploy.sh

# 运行部署脚本
./deploy.sh
```

脚本会自动完成：清理缓存 → 生成静态文件（使用部署配置）→ 部署到 GitHub Pages

### 方式一：手动部署

```bash
# 1. 进入博客目录
cd blog

# 2. 清理旧构建文件
hexo clean

# 3. 生成静态网站（使用部署配置）
hexo generate --config _config.yml,_config.deploy.yml

# 4. 部署到 GitHub Pages（使用部署配置）
hexo deploy --config _config.yml,_config.deploy.yml
```

### 方式二：合并执行

```bash
hexo clean && hexo generate --config _config.yml,_config.deploy.yml && hexo deploy --config _config.yml,_config.deploy.yml
```

### 本地预览

```bash
# 启动本地服务器，访问 http://localhost:4000
# 使用主配置（root: /），资源路径正确
hexo server

# 指定端口启动
hexo server -p 8080
```

> **注意**：本地预览时不需要 `--config` 参数，默认使用 `_config.yml`。

---

## 五、GitHub 操作

### 首次设置（已完成，可跳过）

```bash
# 1. 初始化 Git 仓库
git init

# 2. 添加所有文件
git add .

# 3. 提交
git commit -m "Initial commit"

# 4. 添加远程仓库
git remote add origin https://github.com/bing997/LW-blog.git

# 5. 推送主分支
git branch -M main
git push -u origin main

# 6. 推送 gh-pages 分支（部署用）
git push origin main:gh-pages
```

### 日常更新代码（不部署）

```bash
git add .
git commit -m "更新说明"
git push origin main
```

### 拉取远程更新

```bash
git pull origin main --allow-unrelated-histories
```

---

## 六、常见问题

### 1. 部署后样式丢失（404 错误）

**原因**：部署时未使用 `_config.deploy.yml`，导致 `root` 路径不正确。

**解决**：确保部署命令包含部署配置：

```bash
hexo generate --config _config.yml,_config.deploy.yml
hexo deploy --config _config.yml,_config.deploy.yml
```

或直接使用一键部署脚本：
```bash
deploy.bat        # Windows
./deploy.sh       # Linux/macOS
```

**检查配置**：
- `_config.yml`（本地开发）：`root: /`
- `_config.deploy.yml`（部署）：`root: /LW-blog/`

### 2. hexo deploy 报错 "rejected"

远程仓库有新提交，先拉取合并：

```bash
git pull origin main --allow-unrelated-histories
git push origin main
```

### 3. 依赖安装失败

```bash
# 删除 node_modules 和 package-lock.json
rm -rf node_modules package-lock.json

# 重新安装
npm install
```

### 4. 部署后页面没更新

- GitHub Pages 需要 1-2 分钟生效
- 尝试 `Ctrl+Shift+R` 强制刷新
- 或清除浏览器缓存

### 5. 本地预览正常但部署后异常

**原因**：本地和部署环境使用了不同的 `root` 配置，但部署时未加载 `_config.deploy.yml`。

**解决**：
- 本地预览：`hexo server`（使用 `_config.yml`，`root: /`）
- 部署上线：`deploy.bat` 或 `./deploy.sh`（自动加载 `_config.deploy.yml`，`root: /LW-blog/`）

**不要**在部署时直接使用 `hexo deploy`（不带 `--config` 参数），这会导致资源路径错误。

---

## 七、内容管理

### 新建文章

```bash
hexo new "文章标题"
# 或简写
hexo n "文章标题"
```

文章会自动创建在 `source/_posts/` 目录下。

### 新建页面

```bash
hexo new page "页面名称"
```

### 管理毕设项目数据

项目数据存储在 `source/_data/projects.json`，包含以下字段：

| 字段 | 说明 |
|------|------|
| id | 序号 |
| title | 项目名称 |
| tech | 技术栈 |
| type | 项目类型 |
| domain | 业务领域 |

如需添加新项目，直接编辑 JSON 文件，格式如下：

```json
{
  "id": 103,
  "title": "项目名称",
  "tech": "技术栈",
  "type": "Web管理系统",
  "domain": "业务领域"
}
```

### 添加友链

编辑 `source/_data/link.yml`：

```yaml
- class_name: 分类名称
  class_desc: 分类描述
  link_list:
    - name: 网站名称
      link: https://example.com
      descr: 网站描述
      avatar: https://example.com/avatar.png
```

---

## 八、Hexo 常用命令速查

| 命令 | 说明 |
|------|------|
| `hexo new "标题"` | 新建文章 |
| `hexo new page "名称"` | 新建页面 |
| `hexo generate` / `hexo g` | 生成静态文件 |
| `hexo server` / `hexo s` | 启动本地预览 |
| `hexo deploy` / `hexo d` | 部署到 GitHub |
| `hexo clean` | 清理缓存和旧文件 |
| `hexo list route` | 列出所有路由 |
| `hexo version` | 查看版本 |

---

## 九、工作流程总结

```
日常更新流程：

1. 修改内容（文章、数据、配置）
       ↓
2. 本地预览确认效果（使用本地配置）
   hexo server
       ↓
3. 确认无误后部署（使用部署配置）
   deploy.bat         # Windows 一键部署
   或 ./deploy.sh     # Linux/macOS 一键部署
       ↓
4. 等待 1-2 分钟，访问博客验证
   https://bing997.github.io/LW-blog/
```

```
代码备份流程：

1. git add .
2. git commit -m "本次更新说明"
3. git push origin main
```

---

## 十、重要配置提醒

修改后需要**重新部署**才会生效的配置：
- `_config.yml` 中的所有配置
- `_config.butterfly.yml` 中的主题配置
- 页面和文章内容

只需**推送代码**不需要重新部署的配置：
- `README.md`
- 本文档

---

## 十一、参考资料

- Hexo 文档: https://hexo.io/zh-cn/docs/
- Butterfly 主题: https://butterfly.js.org/
- Butterfly 文档: https://butterfly.js.org/posts/dc584b9b/

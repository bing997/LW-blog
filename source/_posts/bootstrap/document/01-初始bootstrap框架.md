---
title: 01-Bootstrap 核心概念与快速开始
date: 2024-08-21T07:00:00+08:00
tags:
    - bootstrap
    - 教程
categories: bootstrap
cover: /images/cover01.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: 掌握 Bootstrap 的引入方式、页面模板、容器系统与响应式断点设计。
---

# 01-Bootstrap 核心概念与快速开始

Bootstrap 是目前最流行的前端 UI 框架之一。它提供了一套完整的 CSS 样式库、JavaScript 交互组件以及响应式栅格系统，能够帮助开发者快速构建现代化、跨终端的网页应用。本章将从 Bootstrap 的诞生背景讲起，逐步介绍它的核心定位、版本选择、引入方式、页面模板、容器系统、响应式断点，并通过一个完整的实战示例带领大家写出第一个 Bootstrap 页面。

---

## 一、Bootstrap 的诞生与定位

### 1.1 Bootstrap 的起源

Bootstrap 最初由 Twitter 公司的 Mark Otto 和 Jacob Thornton 于 2011 年开发并开源，原名为 "Twitter Blueprint"，后来更名为 Bootstrap。它的设计初衷是为了统一 Twitter 内部众多项目中的前端样式和交互规范，减少重复劳动，提高团队协作效率。

开源之后，Bootstrap 迅速成为全球开发者最喜爱的前端框架之一。截至目前，Bootstrap 已经发布了多个大版本，其中 Bootstrap 3、Bootstrap 4 和 Bootstrap 5 是应用最广泛的三个版本。

### 1.2 Bootstrap 的核心定位

Bootstrap 的定位可以概括为：**一个基于 HTML、CSS 和 JavaScript 的前端组件库与响应式框架**。它并不是一套完整的前端开发框架（如 Vue、React 这类 MVVM 框架），而是专注于解决页面样式、布局和常用交互组件的问题。

Bootstrap 的核心能力包括：

- **响应式栅格系统**：通过 `.container`、`.row`、`.col-*` 等类名实现适配手机、平板、桌面设备的自适应布局。
- **预设组件样式**：按钮、导航、卡片、表单、轮播图、模态框等常用组件开箱即用。
- **CSS 工具类**：间距、颜色、文字、浮动、定位、显示隐藏等工具类，快速调整样式。
- **JavaScript 插件**：基于原生 JavaScript（Bootstrap 5 已移除 jQuery 依赖）实现下拉菜单、标签页、弹窗等交互效果。

### 1.3 适用场景

Bootstrap 特别适合以下场景：

- 需要快速搭建后台管理系统、企业官网、营销落地页等中小型项目。
- 团队缺乏专职 UI 设计师，需要一套成熟、统一的视觉规范。
- 项目对浏览器兼容性要求较高，需要同时支持桌面端和移动端。
- 学习前端响应式布局的入门阶段，Bootstrap 能帮助理解断点、栅格、移动优先等核心概念。

---

## 二、为什么使用 Bootstrap

### 2.1 提高开发效率

在没有 UI 框架的情况下，开发者需要从零编写大量 CSS 样式：按钮样式、表单样式、导航栏、卡片阴影、响应式布局等。这些样式虽然基础，但编写和调试非常耗时。Bootstrap 将这些常见需求封装成预设类名，开发者只需在 HTML 标签上添加相应类名即可。

例如，一个蓝色主按钮只需要以下代码：

```html
<button class="btn btn-primary">主要按钮</button>
```

相比手写几十行 CSS，效率提升非常明显。

### 2.2 统一的视觉风格

Bootstrap 提供了一套经过专业设计的视觉系统，包括颜色、字体、间距、圆角、阴影等。使用 Bootstrap 可以让整个项目的界面风格保持一致，避免不同开发者写出风格迥异的样式。

### 2.3 强大的响应式支持

Bootstrap 的栅格系统基于 **移动优先（Mobile First）** 的设计思想，通过 `xs`、`sm`、`md`、`lg`、`xl`、`xxl` 六个断点控制不同屏幕尺寸下的布局表现。开发者可以轻松实现同一套代码在手机、平板、桌面设备上呈现不同布局。

### 2.4 活跃的社区与生态

Bootstrap 拥有庞大的用户群体和丰富的第三方生态。无论是官方文档、社区教程、免费主题，还是基于 Bootstrap 的 UI 套件（如 AdminLTE、Tabler、CoreUI），都能为项目开发提供大量参考资源。

### 2.5 学习曲线平缓

Bootstrap 的学习成本相对较低。只要掌握 HTML 和 CSS 基础，就可以快速上手。它不需要理解复杂的状态管理或组件化概念，非常适合前端初学者作为第一个 UI 框架学习。

---

## 三、Bootstrap 的版本选择

### 3.1 主流版本对比

目前 Bootstrap 主要有三个版本仍在广泛使用：

| 版本 | 发布时间 | 核心特点 | 是否推荐新项目使用 |
|------|----------|----------|--------------------|
| Bootstrap 3 | 2013 年 | 基于 float 布局，兼容 IE8+，已停止维护 | 不推荐 |
| Bootstrap 4 | 2018 年 | 引入 Flexbox 布局，增加卡片组件，依赖 jQuery | 谨慎使用 |
| Bootstrap 5 | 2021 年 | 移除 jQuery 依赖，引入 CSS 自定义属性，优化 Grid 系统 | 强烈推荐 |

### 3.2 为什么选择 Bootstrap 5

Bootstrap 5 是目前官方主推的版本，相较于 Bootstrap 4 和 Bootstrap 3，它有以下几个显著优势：

- **移除 jQuery 依赖**：Bootstrap 5 的 JavaScript 插件完全基于原生 JavaScript 编写，减少了项目的依赖体积。
- **更强大的栅格系统**：新增了 `xxl` 断点，支持更精细的响应式控制。
- **CSS 自定义属性增强**：大量主题色、间距值通过 CSS 变量管理，便于主题定制。
- **改进的表单组件**：表单样式更加现代化，表单控件统一了外观。
- **更好的文档和工具**：官方文档更完善，同时提供了 Bootstrap Icons 图标库作为独立项目。

### 3.3 本章示例的版本约定

本章所有示例均基于 **Bootstrap 5.3.2** 版本编写。在涉及 Bootstrap 4 差异的地方，会特别标注说明，帮助读者理解版本迁移时的注意事项。

---

## 四、三种引入方式

要使用 Bootstrap，必须将它的 CSS 和 JavaScript 文件引入到项目中。常见的引入方式有三种：CDN 引入、本地文件引入、包管理器引入。

### 4.1 CDN 引入（最快捷，推荐学习和测试使用）

CDN（Content Delivery Network，内容分发网络）引入是最简单的方式。只需要在 HTML 文件的 `<head>` 中引入 CSS，在 `</body>` 之前引入 JavaScript 即可。

**概念说明**：CDN 引入不需要下载任何文件，浏览器会直接从远程服务器加载 Bootstrap 的静态资源。优点是方便快捷、不占用项目空间；缺点是依赖网络环境，如果 CDN 服务不可用，页面样式会失效。

**适用场景**：快速原型开发、在线代码演示、学习测试、内网可访问公网的项目。

**完整示例代码**：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bootstrap 5 CDN 引入</title>
  <!-- Bootstrap 5.3.2 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container mt-5">
    <h1 class="text-primary">Hello Bootstrap 5</h1>
    <button class="btn btn-success">点击我</button>
  </div>

  <!-- Bootstrap 5.3.2 JS（包含 Popper） -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**代码解析**：

- `<link>` 标签引入 Bootstrap 的 CSS 文件，负责样式和栅格系统。
- `bootstrap.bundle.min.js` 是 Bootstrap 的 JavaScript 文件和 Popper.js 的合并版本，用于支持下拉菜单、弹窗、工具提示等交互组件。
- 将 `<script>` 放在 `</body>` 之前可以确保页面 DOM 元素先加载完成，再执行脚本。
- `mt-5` 是 Bootstrap 的工具类，表示 `margin-top: 3rem`。

> **Bootstrap 4 差异说明**：Bootstrap 4 的 CDN 链接通常是 `bootstrap@4.6.2`，并且需要单独引入 jQuery、Popper.js 和 Bootstrap JS 三个文件。Bootstrap 5 已经不需要 jQuery。

### 4.2 本地文件引入（推荐生产环境使用）

本地引入需要先从 Bootstrap 官网下载编译后的文件，将 CSS 和 JS 文件放入项目目录中，然后通过相对路径引用。

**概念说明**：本地引入将 Bootstrap 的静态资源保存在项目内部，不依赖外部网络。优点是加载稳定、可控性强；缺点是会增加项目体积，需要手动更新版本。

**适用场景**：生产环境项目、内网无法访问公网的环境、对加载速度要求较高的项目。

**完整示例代码**：

假设项目目录结构如下：

```
project/
├── index.html
├── css/
│   └── bootstrap.min.css
└── js/
    └── bootstrap.bundle.min.js
```

`index.html` 内容如下：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>本地引入 Bootstrap</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
  <div class="container">
    <div class="alert alert-info mt-4" role="alert">
      这是通过本地文件引入的 Bootstrap 提示框组件。
    </div>
  </div>

  <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**代码解析**：

- `href="css/bootstrap.min.css"` 使用相对路径指向本地 CSS 文件。
- `src="js/bootstrap.bundle.min.js"` 使用相对路径指向本地 JS 文件。
- `.alert-info` 是 Bootstrap 的信息提示框样式类，`.mt-4` 表示顶部外边距。

### 4.3 包管理器引入（推荐现代前端工程化项目）

对于使用 Webpack、Vite、Parcel 等构建工具的项目，可以通过 npm 或 yarn 安装 Bootstrap。

**概念说明**：包管理器引入将 Bootstrap 作为项目的依赖进行管理，方便版本控制和按需引入。配合构建工具还可以实现样式覆盖、Tree Shaking、自动化构建等高级功能。

**适用场景**：中大型前端工程化项目、需要自定义主题或按需引入组件的项目。

**完整示例代码**：

安装命令：

```bash
npm install bootstrap@5.3.2
```

在 JavaScript 入口文件中引入：

```javascript
// main.js
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
```

或者在 HTML 构建后的产物中引用打包后的 CSS 和 JS。

**代码解析**：

- `npm install bootstrap@5.3.2` 会将 Bootstrap 安装到 `node_modules` 目录。
- `import` 语法由 Webpack 或 Vite 处理，构建时会将 Bootstrap 的样式和脚本打包到最终产物中。
- 这种方式便于覆盖 Bootstrap 的 Sass 变量，实现深度定制。

> **Bootstrap 4 差异说明**：Bootstrap 4 可以通过 npm 安装 `bootstrap` 包，但部分 JavaScript 组件仍依赖 jQuery，需要额外安装 `jquery` 和 `popper.js`。

---

## 五、Bootstrap 页面模板

### 5.1 最小可用模板

一个完整的 Bootstrap 5 页面至少需要包含以下结构：

- `<!DOCTYPE html>` 声明。
- `<html lang="zh-CN">` 设置页面语言。
- `<meta charset="UTF-8">` 声明字符编码。
- `<meta name="viewport" content="width=device-width, initial-scale=1.0">` 设置视口，确保响应式生效。
- Bootstrap CSS 文件。
- Bootstrap JS 文件。

**概念说明**：视口（Viewport）元标签是响应式设计的核心。它告诉浏览器页面的宽度应该等于设备宽度，并且初始缩放比例为 1。如果没有这个标签，Bootstrap 的响应式断点将无法正常工作。

**适用场景**：所有使用 Bootstrap 的页面都应以此模板为基础开始开发。

**完整示例代码**：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bootstrap 5 基础模板</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <h1>这是一个最小可用的 Bootstrap 页面</h1>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**代码解析**：

- `<meta name="viewport">` 是移动优先响应式布局的前提。
- CSS 放在 `<head>` 中，确保页面渲染时样式已经可用。
- JS 放在 `</body>` 之前，避免阻塞页面内容渲染。

### 5.2 推荐的完整模板

在实际开发中，一个更完整的 Bootstrap 页面模板还会包含语言设置、图标字体、自定义样式文件等。

**完整示例代码**：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Bootstrap 5 完整页面模板">
  <title>Bootstrap 5 完整模板</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
  <!-- 自定义样式 -->
  <style>
    body {
      font-family: "Microsoft YaHei", "PingFang SC", sans-serif;
    }
  </style>
</head>
<body>
  <!-- 页面内容区域 -->
  <main class="container py-5">
    <h1 class="display-4">欢迎使用 Bootstrap 5</h1>
    <p class="lead">这是一个包含图标字体和自定义样式的完整模板。</p>
    <i class="bi bi-bootstrap-fill text-primary" style="font-size: 3rem;"></i>
  </main>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**代码解析**：

- `<main>` 标签表示页面的主要内容区域，语义化更好。
- `container` 类限制内容最大宽度并居中显示。
- `py-5` 表示上下内边距（padding-top 和 padding-bottom）为较大值。
- `display-4` 和 `lead` 是 Bootstrap 的排版类，分别用于大标题和引导性文字。
- `bi-bootstrap-fill` 是 Bootstrap Icons 的图标类。
- 自定义 `<style>` 用于覆盖默认字体，适配中文显示。

---

## 六、容器系统

### 6.1 容器的作用

Bootstrap 的容器（Container）是布局的基础。容器会自动调整宽度、设置水平内边距，并将内容居中显示。所有 Bootstrap 的栅格行（`.row`）都应该放在容器内部。

**概念说明**：容器是 Bootstrap 布局的最外层包裹元素。它定义了内容区域的最大宽度和两侧的内边距，确保页面在不同屏幕尺寸下都有良好的阅读体验。

**适用场景**：页面主体内容包裹、卡片列表包裹、表单区域包裹等需要限制宽度并居中的场景。

### 6.2 三种容器类型

Bootstrap 5 提供了三种容器类：

| 类名 | 说明 |
|------|------|
| `.container` | 固定最大宽度的响应式容器，随断点变化 |
| `.container-fluid` | 全宽容器，始终占据父元素 100% 宽度 |
| `.container-{breakpoint}` | 在指定断点以上变为固定宽度，以下全宽 |

**完整示例代码**：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bootstrap 容器系统</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <!-- 固定宽度容器 -->
  <div class="container bg-light p-3 mb-3">
    <h2>.container</h2>
    <p>在不同断点下拥有最大宽度限制，内容居中。</p>
  </div>

  <!-- 全宽容器 -->
  <div class="container-fluid bg-info text-white p-3 mb-3">
    <h2>.container-fluid</h2>
    <p>始终占据整个视口宽度，适合做横幅、导航栏背景。</p>
  </div>

  <!-- 断点容器：在 md 断点以上变为固定宽度 -->
  <div class="container-md bg-success text-white p-3">
    <h2>.container-md</h2>
    <p>在屏幕宽度小于 768px 时全宽，大于等于 768px 时变为固定宽度。</p>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**代码解析**：

- `.container` 在 `sm`（≥576px）、`md`（≥768px）、`lg`（≥992px）、`xl`（≥1200px）、`xxl`（≥1400px）断点下有不同的最大宽度。
- `.container-fluid` 没有最大宽度限制，适合通栏布局。
- `.container-md` 是一种响应式容器，在小于 `md` 断点时表现与 `.container-fluid` 相同，大于等于 `md` 断点时表现与 `.container` 相同。
- `bg-light`、`bg-info`、`bg-success` 是背景色工具类；`text-white` 是文字颜色工具类；`p-3` 是内边距工具类；`mb-3` 是下外边距工具类。

### 6.3 容器宽度对照表

`.container` 在不同断点下的最大宽度如下：

| 断点 | 最大宽度 |
|------|----------|
| < 576px（xs） | 100% |
| ≥576px（sm） | 540px |
| ≥768px（md） | 720px |
| ≥992px（lg） | 960px |
| ≥1200px（xl） | 1140px |
| ≥1400px（xxl） | 1320px |

> **Bootstrap 4 差异说明**：Bootstrap 4 没有 `xxl` 断点，`.container` 的最大宽度只到 `xl`（1140px）。Bootstrap 5 新增了 `xxl` 断点，桌面大屏幕下内容区域更宽。

---

## 七、响应式断点

### 7.1 什么是响应式断点

响应式断点（Breakpoints）是 CSS 媒体查询中的关键阈值。Bootstrap 通过预定义的断点，让同一套 HTML 结构在不同屏幕宽度下呈现不同的布局效果。

**概念说明**：断点是响应式设计的核心机制。Bootstrap 采用 **移动优先（Mobile First）** 策略，即默认样式先适配最小屏幕，然后通过 `min-width` 媒体查询逐步增强大屏幕下的表现。

**适用场景**：同一套页面需要同时适配手机、平板、笔记本电脑、大屏幕显示器等多种设备。

### 7.2 Bootstrap 5 的六大断点

Bootstrap 5 定义了六个断点：

| 断点名称 | 类中缀 | 宽度范围 | CSS 媒体查询 |
|----------|--------|----------|--------------|
| X-Small | 无（xs） | < 576px | 默认样式 |
| Small | sm | ≥ 576px | `@media (min-width: 576px)` |
| Medium | md | ≥ 768px | `@media (min-width: 768px)` |
| Large | lg | ≥ 992px | `@media (min-width: 992px)` |
| Extra large | xl | ≥ 1200px | `@media (min-width: 1200px)` |
| Extra extra large | xxl | ≥ 1400px | `@media (min-width: 1400px)` |

### 7.3 断点在栅格系统中的应用

Bootstrap 的栅格类名格式为 `.col-{breakpoint}-{number}`，例如 `.col-md-6` 表示在 `md` 断点及以上占据 6 列（即 50% 宽度），而在 `md` 以下会垂直堆叠。

**完整示例代码**：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bootstrap 响应式断点</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .box {
      background-color: #0d6efd;
      color: white;
      padding: 1rem;
      text-align: center;
      border: 1px solid white;
    }
  </style>
</head>
<body>
  <div class="container mt-4">
    <h2>响应式栅格布局</h2>
    <p>调整浏览器窗口大小，观察下方列的变化：</p>

    <div class="row">
      <!-- 小屏幕占 12 列（全宽），中等屏幕占 6 列（半宽），大屏幕占 4 列（三分之一宽） -->
      <div class="col-12 col-md-6 col-lg-4">
        <div class="box">列 1</div>
      </div>
      <div class="col-12 col-md-6 col-lg-4">
        <div class="box">列 2</div>
      </div>
      <div class="col-12 col-md-12 col-lg-4">
        <div class="box">列 3</div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**代码解析**：

- `.row` 是栅格行容器，内部列使用 Flexbox 布局。
- `.col-12` 表示在 `xs` 断点（即所有屏幕）下占据 12 列，也就是全宽。
- `.col-md-6` 表示在 `md` 断点及以上占据 6 列，即 50% 宽度。
- `.col-lg-4` 表示在 `lg` 断点及以上占据 4 列，即约 33.33% 宽度。
- 由于 Bootstrap 采用移动优先策略，类名从小到大依次生效。如果没有指定某个断点的类名，会继承更小的断点设置。

### 7.4 断点在显示隐藏中的应用

Bootstrap 还提供了一组用于控制元素显示和隐藏的工具类，例如 `.d-none`、`.d-sm-block`、`.d-md-none` 等。

**完整示例代码**：

```html
<div class="container mt-4">
  <p class="d-block d-sm-none">你正在使用手机浏览（xs 屏幕）。</p>
  <p class="d-none d-sm-block d-md-none">你正在使用平板浏览（sm 屏幕）。</p>
  <p class="d-none d-md-block d-lg-none">你正在使用小型笔记本浏览（md 屏幕）。</p>
  <p class="d-none d-lg-block d-xl-none">你正在使用桌面显示器浏览（lg 屏幕）。</p>
  <p class="d-none d-xl-block d-xxl-none">你正在使用大屏幕浏览（xl 屏幕）。</p>
  <p class="d-none d-xxl-block">你正在使用超大屏幕浏览（xxl 屏幕）。</p>
</div>
```

**代码解析**：

- `.d-none` 表示元素隐藏。
- `.d-sm-block` 表示在 `sm` 断点及以上将元素显示为块级元素。
- 组合使用 `.d-none` 和 `.d-sm-block` 可以实现只在 `sm` 及以上屏幕显示。
- 通过为不同断点设置不同的显示类，可以实现设备专属提示信息。

---

## 八、第一个 Bootstrap 页面

### 8.1 实战目标

本节将综合运用前面所学的知识，创建一个完整的 Bootstrap 5 页面。页面包含响应式导航栏、英雄区块（Hero Section）、三列特性介绍、卡片列表和页脚。该页面在手机端会自动调整为单列布局，在桌面端呈现多列布局。

### 8.2 完整代码

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>我的第一个 Bootstrap 页面</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    .hero {
      background: linear-gradient(135deg, #0d6efd, #6610f2);
      color: white;
    }
    .feature-icon {
      width: 60px;
      height: 60px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      border-radius: 50%;
      background-color: rgba(13, 110, 253, 0.1);
      color: #0d6efd;
      font-size: 1.5rem;
    }
  </style>
</head>
<body>
  <!-- 导航栏 -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand" href="#">我的网站</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item"><a class="nav-link active" href="#">首页</a></li>
          <li class="nav-item"><a class="nav-link" href="#">产品</a></li>
          <li class="nav-item"><a class="nav-link" href="#">服务</a></li>
          <li class="nav-item"><a class="nav-link" href="#">联系我们</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- 英雄区块 -->
  <header class="hero py-5 py-lg-7">
    <div class="container text-center">
      <h1 class="display-3 fw-bold mb-3">欢迎来到 Bootstrap 世界</h1>
      <p class="lead mb-4">用更少的代码，构建更优秀的响应式网页</p>
      <a href="#features" class="btn btn-light btn-lg me-2">了解特性</a>
      <a href="#" class="btn btn-outline-light btn-lg">立即开始</a>
    </div>
  </header>

  <!-- 特性介绍 -->
  <section id="features" class="py-5">
    <div class="container">
      <div class="row g-4 text-center">
        <div class="col-md-4">
          <div class="feature-icon mb-3">
            <i class="bi bi-grid-3x3-gap"></i>
          </div>
          <h3>响应式栅格</h3>
          <p class="text-muted">基于 Flexbox 的 12 列栅格系统，轻松适配各种屏幕尺寸。</p>
        </div>
        <div class="col-md-4">
          <div class="feature-icon mb-3">
            <i class="bi bi-palette"></i>
          </div>
          <h3>丰富组件</h3>
          <p class="text-muted">按钮、卡片、表单、导航等数十种组件，开箱即用。</p>
        </div>
        <div class="col-md-4">
          <div class="feature-icon mb-3">
            <i class="bi bi-braces"></i>
          </div>
          <h3>原生 JS</h3>
          <p class="text-muted">Bootstrap 5 移除 jQuery 依赖，使用原生 JavaScript 实现交互。</p>
        </div>
      </div>
    </div>
  </section>

  <!-- 卡片列表 -->
  <section class="py-5 bg-light">
    <div class="container">
      <h2 class="text-center mb-5">精选内容</h2>
      <div class="row g-4">
        <div class="col-md-6 col-lg-4">
          <div class="card h-100 shadow-sm">
            <div class="card-body">
              <h5 class="card-title">快速上手</h5>
              <p class="card-text">通过 CDN 引入 Bootstrap，只需几分钟即可搭建出现代化页面。</p>
              <a href="#" class="btn btn-primary">阅读更多</a>
            </div>
          </div>
        </div>
        <div class="col-md-6 col-lg-4">
          <div class="card h-100 shadow-sm">
            <div class="card-body">
              <h5 class="card-title">定制主题</h5>
              <p class="card-text">利用 Sass 变量和 CSS 自定义属性，轻松打造专属品牌风格。</p>
              <a href="#" class="btn btn-primary">阅读更多</a>
            </div>
          </div>
        </div>
        <div class="col-md-6 col-lg-4">
          <div class="card h-100 shadow-sm">
            <div class="card-body">
              <h5 class="card-title">浏览器兼容</h5>
              <p class="card-text">Bootstrap 5 支持所有现代浏览器，包括 Chrome、Firefox、Safari 和 Edge。</p>
              <a href="#" class="btn btn-primary">阅读更多</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- 页脚 -->
  <footer class="bg-dark text-white text-center py-4">
    <div class="container">
      <p class="mb-0">&copy; 2024 我的第一个 Bootstrap 页面。保留所有权利。</p>
    </div>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 8.3 代码解析

- **导航栏**：使用 `.navbar` 组件，`.navbar-expand-lg` 表示在 `lg` 断点以上展开为水平导航，以下折叠为汉堡菜单。`data-bs-toggle="collapse"` 和 `data-bs-target="#navbarNav"` 是 Bootstrap 5 的折叠组件触发属性。
- **英雄区块**：使用自定义渐变背景，`.display-3` 创建大标题，`.lead` 创建引导文字，两个按钮分别使用 `.btn-light` 和 `.btn-outline-light`。
- **特性介绍**：三列布局使用 `.col-md-4`，在 `md` 及以上屏幕水平排列三列，在 `md` 以下垂直堆叠。`.g-4` 设置列间距。
- **卡片列表**：使用 `.card` 组件，`.h-100` 让卡片等高，`.shadow-sm` 添加轻微阴影。`.col-md-6 col-lg-4` 实现平板端两列、桌面端三列。
- **页脚**：使用深色背景，文字居中，容器限制宽度。

---

## 九、开发规范与注意事项

### 9.1  always 引入视口元标签

如果没有正确设置视口，Bootstrap 的响应式布局将无法生效。每个页面都必须包含：

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

### 9.2 栅格行必须放在容器内

`.row` 元素必须放在 `.container`、`.container-fluid` 或 `.container-{breakpoint}` 内部，否则会出现水平滚动条或布局错乱。

### 9.3 优先使用 Bootstrap 提供的类名

在 Bootstrap 项目中，应优先使用框架内置的类名（如 `.p-3`、`.mb-4`、`.text-center`）来控制样式，而不是写大量自定义 CSS。这样既能保持风格统一，也能减少代码量。

### 9.4 注意 Bootstrap 5 与 jQuery 的关系

Bootstrap 5 的 JavaScript 组件不再依赖 jQuery。如果你的项目已经从 Bootstrap 4 迁移到 Bootstrap 5，可以移除 jQuery 依赖，使用原生 JavaScript 或框架（如 Vue、React）来操作组件。

### 9.5 合理选择 CDN 或本地文件

学习和原型阶段可以使用 CDN，方便快速验证想法。生产环境建议使用本地文件或将 Bootstrap 打包到构建产物中，避免 CDN 不可用导致页面异常。

### 9.6 善用官方文档

Bootstrap 官方文档非常完善，涵盖了所有组件、工具类、布局系统和 JavaScript API。遇到不确定的类名或用法时，应优先查阅官方文档。

---

## 十、本章小结

本章系统介绍了 Bootstrap 的核心概念与快速开始方法：

1. **Bootstrap 的诞生与定位**：Bootstrap 是由 Twitter 开源的前端 UI 框架，专注于响应式布局、组件样式和交互插件。
2. **为什么使用 Bootstrap**：它能显著提高开发效率、统一视觉风格、提供强大的响应式支持，并且学习曲线平缓。
3. **Bootstrap 的版本选择**：Bootstrap 5 是当前最推荐的版本，已移除 jQuery 依赖，新增了 `xxl` 断点和更完善的 CSS 变量支持。
4. **三种引入方式**：CDN 引入适合学习和测试，本地文件引入适合生产环境，包管理器引入适合工程化项目。
5. **Bootstrap 页面模板**：一个完整的 Bootstrap 页面需要包含视口元标签、CSS 和 JS 文件，并推荐补充图标字体和自定义样式。
6. **容器系统**：`.container`、`.container-fluid` 和 `.container-{breakpoint}` 分别适用于不同宽度需求的场景。
7. **响应式断点**：Bootstrap 5 提供了 xs、sm、md、lg、xl、xxl 六个断点，支持移动优先的响应式设计。
8. **第一个 Bootstrap 页面**：通过导航栏、英雄区块、特性介绍、卡片列表和页脚，完成了一个完整的响应式页面示例。
9. **开发规范与注意事项**：强调视口标签、栅格结构、类名使用、版本差异和文档查阅的重要性。

掌握本章内容后，读者已经具备了使用 Bootstrap 5 进行页面开发的基础能力。后续章节将在此基础上深入讲解 Bootstrap 的栅格系统、表单组件、导航组件、工具类以及自定义主题等高级内容。

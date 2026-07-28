---
title: 06-Bootstrap JavaScript 插件
date: 2024-08-21T02:00:00+08:00
tags:
    - bootstrap
    - 教程
categories: bootstrap
cover: /images/cover06.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: 掌握 Bootstrap 的 Modal、Carousel、Collapse、Dropdown、Tooltip、Popover、Scrollspy 等 JavaScript 交互插件。
---

Bootstrap 不仅是一套强大的 CSS 框架，更提供了一组开箱即用的 JavaScript 插件。从 Bootstrap 5 开始，官方彻底移除了 jQuery 依赖，所有插件均使用原生 JavaScript 编写，基于 ES6 模块化构建，体积更小、性能更高、与现代前端工程化流程结合更紧密。本章将系统讲解 Bootstrap 5 中最常用、最实用的 JavaScript 插件，包括模态框、轮播、折叠、下拉菜单、工具提示、弹出框、滚动监听、Toast 等，并通过一个完整的后台管理页实战项目，帮助大家将理论知识融会贯通。

<!-- more -->

## 一、Bootstrap JS 插件机制

在深入学习具体插件之前，有必要先了解 Bootstrap 5 JavaScript 插件的整体工作机制。掌握这些底层原理，可以帮助我们在实际开发中更加得心应手地定制、扩展和调试插件行为。

### 1.1 两种使用方式

Bootstrap 5 的每个插件几乎都支持两种使用方式：

- **data 属性方式**：无需编写任何 JavaScript，只需在 HTML 元素上添加特定的 `data-bs-*` 属性，Bootstrap 会自动扫描并初始化。这种方式适合快速原型开发和简单交互。
- **JavaScript API 方式**：通过原生 JavaScript 手动创建插件实例，调用方法、监听事件、传入配置对象。这种方式适合需要精细控制的场景。

例如，一个按钮触发模态框，既可以用 `data-bs-toggle="modal"` 实现，也可以通过 `new bootstrap.Modal(element)` 手动控制。

### 1.2 基于 data 属性的自动初始化

Bootstrap 5 在页面加载完成后，会自动扫描文档中带有 `data-bs-toggle` 等属性的元素，并为它们绑定对应插件的交互行为。所有 data 属性均使用 `data-bs-*` 前缀，以避免与其他库的 `data-*` 属性冲突。例如：

- `data-bs-toggle="modal"` 表示触发模态框
- `data-bs-target="#myModal"` 指定目标元素
- `data-bs-dismiss="modal"` 表示关闭模态框

### 1.3 编程式 API 与事件监听

每个插件都暴露了一个同名的 JavaScript 类，挂载在全局的 `bootstrap` 对象上。例如：

```javascript
const myModal = new bootstrap.Modal(document.getElementById('myModal'));
myModal.show();
```

同时，每个插件在状态变化时都会触发自定义事件，事件名通常以插件名的小写形式开头，例如 `show.bs.modal`、`shown.bs.modal`、`hide.bs.modal`、`hidden.bs.modal`。我们可以通过 `addEventListener` 监听这些事件，在适当的时机插入自定义逻辑。

### 1.4 配置选项与默认值

Bootstrap 插件的配置可以通过以下三种方式传入，优先级从低到高依次为：

1. 插件类上的 `Default` 静态属性，即全局默认值；
2. HTML 元素上的 `data-bs-*` 属性；
3. 通过 JavaScript 构造函数或 `dispose()`/`getOrCreateInstance()` 传入的选项对象。

```javascript
const tooltip = new bootstrap.Tooltip(element, {
  placement: 'bottom',
  trigger: 'click'
});
```

### 1.5 页面引入方式

要使用 Bootstrap 5 的 JS 插件，需要同时引入 CSS 和 JS。推荐通过 CDN 引入：

```html
<!-- CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- JS Bundle（包含 Popper） -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
```

如果需要更精细地控制，也可以分别引入 `bootstrap.min.js` 和 `@popperjs/core`。但绝大多数情况下，`bootstrap.bundle.min.js` 已经足够。

## 二、模态框 Modal

模态框（Modal）是网页中最常用的弹窗组件，常用于确认操作、表单填写、信息展示等场景。Bootstrap 5 的 Modal 插件功能完善，支持静态背景、滚动行为、多种尺寸、垂直居中、动画过渡等特性。

### 2.1 触发方式

模态框可以通过 data 属性或 JavaScript 触发。

**data 属性触发**：在按钮上添加 `data-bs-toggle="modal"` 和 `data-bs-target="#modalId"`。

```html
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  打开模态框
</button>
```

**JavaScript 触发**：

```javascript
const myModal = new bootstrap.Modal(document.getElementById('exampleModal'));
myModal.show();
```

### 2.2 常用配置

| 选项 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `backdrop` | boolean \| string | `true` | 是否显示背景遮罩，`'static'` 表示点击背景不关闭 |
| `keyboard` | boolean | `true` | 是否允许按 Esc 键关闭 |
| `focus` | boolean | `true` | 打开时是否自动聚焦 |
| `show` | boolean | `false` | 初始化时是否立即显示 |

### 2.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Modal 示例</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container py-5">
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#loginModal">
      登录
    </button>
  </div>

  <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="loginModalLabel">用户登录</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="关闭"></button>
        </div>
        <div class="modal-body">
          <form>
            <div class="mb-3">
              <label for="username" class="form-label">用户名</label>
              <input type="text" class="form-control" id="username">
            </div>
            <div class="mb-3">
              <label for="password" class="form-label">密码</label>
              <input type="password" class="form-control" id="password">
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
          <button type="button" class="btn btn-primary">提交</button>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 2.4 JavaScript 控制方法

```javascript
const loginModalEl = document.getElementById('loginModal');
const loginModal = new bootstrap.Modal(loginModalEl, {
  backdrop: 'static',
  keyboard: false
});

// 显示
loginModal.show();

// 隐藏
loginModal.hide();

// 切换显示状态
loginModal.toggle();

// 销毁实例
loginModal.dispose();

// 监听事件
loginModalEl.addEventListener('shown.bs.modal', () => {
  console.log('模态框已完全显示');
  document.getElementById('username').focus();
});

loginModalEl.addEventListener('hidden.bs.modal', () => {
  console.log('模态框已完全隐藏');
});
```

### 2.5 常用技巧

- 使用 `.modal-lg`、`.modal-sm`、`.modal-xl` 调整模态框尺寸；
- 使用 `.modal-dialog-centered` 实现垂直居中；
- 使用 `.modal-dialog-scrollable` 让模态框主体单独滚动；
- 使用 `.modal-fullscreen` 创建全屏模态框。

## 三、轮播 Carousel

轮播（Carousel）用于循环播放图片、卡片或其他内容，是首页 Banner、产品展示、新闻推荐等场景的常见组件。Bootstrap 5 的 Carousel 支持自动播放、键盘控制、指示器、左右切换箭头、渐入淡出效果等。

### 3.1 触发方式

最简单的方式是直接在 HTML 结构上添加 `data-bs-ride="carousel"`，Bootstrap 会自动初始化轮播。

```html
<div id="heroCarousel" class="carousel slide" data-bs-ride="carousel">
  ...
</div>
```

### 3.2 常用配置

| 选项 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `interval` | number | `5000` | 自动播放间隔，单位为毫秒 |
| `wrap` | boolean | `true` | 是否循环播放 |
| `keyboard` | boolean | `true` | 是否支持键盘左右方向键切换 |
| `pause` | string \| boolean | `'hover'` | 悬停时是否暂停 |
| `ride` | string \| boolean | `false` | 是否自动播放，`'carousel'` 表示页面加载后自动播放 |
| `touch` | boolean | `true` | 是否支持触摸滑动 |

### 3.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Carousel 示例</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container py-5">
    <div id="productCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel">
      <!-- 指示器 -->
      <div class="carousel-indicators">
        <button type="button" data-bs-target="#productCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#productCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#productCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
      </div>

      <!-- 轮播项 -->
      <div class="carousel-inner rounded">
        <div class="carousel-item active">
          <img src="https://picsum.photos/id/10/1200/400" class="d-block w-100" alt="风景1">
          <div class="carousel-caption d-none d-md-block">
            <h5>第一屏标题</h5>
            <p>这里是第一屏的说明文字。</p>
          </div>
        </div>
        <div class="carousel-item">
          <img src="https://picsum.photos/id/11/1200/400" class="d-block w-100" alt="风景2">
          <div class="carousel-caption d-none d-md-block">
            <h5>第二屏标题</h5>
            <p>这里是第二屏的说明文字。</p>
          </div>
        </div>
        <div class="carousel-item">
          <img src="https://picsum.photos/id/12/1200/400" class="d-block w-100" alt="风景3">
          <div class="carousel-caption d-none d-md-block">
            <h5>第三屏标题</h5>
            <p>这里是第三屏的说明文字。</p>
          </div>
        </div>
      </div>

      <!-- 左右切换 -->
      <button class="carousel-control-prev" type="button" data-bs-target="#productCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">上一张</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#productCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">下一张</span>
      </button>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 3.4 JavaScript 控制方法

```javascript
const carouselEl = document.getElementById('productCarousel');
const carousel = new bootstrap.Carousel(carouselEl, {
  interval: 3000,
  wrap: true,
  keyboard: true,
  pause: 'hover',
  touch: true
});

// 切换到上一张
carousel.prev();

// 切换到下一张
carousel.next();

// 切换到指定索引，从 0 开始
carousel.to(1);

// 暂停自动播放
carousel.pause();

// 循环播放
carousel.cycle();

// 监听切换事件
carouselEl.addEventListener('slide.bs.carousel', (event) => {
  console.log('即将切换到第', event.to + 1, '张');
});
```

### 3.5 注意事项

- 轮播容器必须设置 `id`，否则左右按钮和指示器无法通过 `data-bs-target` 关联；
- 每个 `.carousel-item` 中只能有一个活动项带有 `.active` 类；
- 使用 `.carousel-fade` 可以实现淡入淡出效果，默认是滑动切换。

## 四、折叠 Collapse

折叠（Collapse）插件用于显示和隐藏内容，常见于手风琴（Accordion）、侧边栏菜单、更多详情展开等场景。Bootstrap 5 的 Collapse 支持水平折叠和垂直折叠，并且可以与 `.accordion` 类组合实现手风琴效果。

### 4.1 触发方式

通过 `data-bs-toggle="collapse"` 和 `data-bs-target="#collapseId"` 触发。

```html
<button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
  展开/收起
</button>
```

### 4.2 常用配置

| 选项 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `parent` | string \| HTMLElement | `null` | 指定父元素，实现手风琴效果 |
| `toggle` | boolean | `true` | 初始化时是否切换状态 |

### 4.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Collapse 示例</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container py-5">
    <!-- 单个折叠 -->
    <p>
      <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample">
        点击展开详情
      </button>
    </p>
    <div class="collapse" id="collapseExample">
      <div class="card card-body">
        这是一段可以展开和收起的详细内容。Bootstrap 的 Collapse 插件让这种交互变得非常简单。
      </div>
    </div>

    <hr class="my-5">

    <!-- 手风琴效果 -->
    <div class="accordion" id="faqAccordion">
      <div class="accordion-item">
        <h2 class="accordion-header">
          <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faqOne">
            什么是 Bootstrap？
          </button>
        </h2>
        <div id="faqOne" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
          <div class="accordion-body">
            Bootstrap 是世界上最流行的前端开源框架，用于快速构建响应式、移动设备优先的网站。
          </div>
        </div>
      </div>
      <div class="accordion-item">
        <h2 class="accordion-header">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faqTwo">
            Bootstrap 5 是否依赖 jQuery？
          </button>
        </h2>
        <div id="faqTwo" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
          <div class="accordion-body">
            Bootstrap 5 已经完全移除了 jQuery 依赖，所有插件均使用原生 JavaScript 编写。
          </div>
        </div>
      </div>
      <div class="accordion-item">
        <h2 class="accordion-header">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faqThree">
            如何自定义 Bootstrap 主题？
          </button>
        </h2>
        <div id="faqThree" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
          <div class="accordion-body">
            可以通过覆盖 Sass 变量、自定义 CSS 或使用 Bootstrap 提供的工具类来实现主题定制。
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 4.4 JavaScript 控制方法

```javascript
const collapseEl = document.getElementById('collapseExample');
const bsCollapse = new bootstrap.Collapse(collapseEl, {
  toggle: false
});

// 显示
bsCollapse.show();

// 隐藏
bsCollapse.hide();

// 切换
bsCollapse.toggle();

// 监听事件
collapseEl.addEventListener('shown.bs.collapse', () => {
  console.log('折叠内容已展开');
});
```

### 4.5 水平折叠

Bootstrap 5 还支持水平方向的折叠，只需在折叠容器上添加 `.collapse-horizontal`，并设置宽度即可。

```html
<div class="collapse collapse-horizontal" id="collapseWidthExample">
  <div style="width: 300px;">
    水平折叠的内容
  </div>
</div>
```

## 五、下拉菜单 Dropdown

下拉菜单（Dropdown）用于在按钮或链接下方展开一组选项，广泛应用于导航栏、表单筛选、操作菜单等场景。Bootstrap 5 的 Dropdown 基于 Popper 定位，支持自动翻转、对齐、分隔线、标题、禁用项等功能。

### 5.1 触发方式

通过 `data-bs-toggle="dropdown"` 触发。

```html
<div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
    下拉菜单
  </button>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="#">Action</a></li>
    <li><a class="dropdown-item" href="#">Another action</a></li>
  </ul>
</div>
```

### 5.2 常用配置

| 选项 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `autoClose` | boolean \| string | `true` | 是否自动关闭菜单，`'outside'`、`'inside'` 可精细控制 |
| `boundary` | string \| HTMLElement | `'clippingParents'` | 边界约束 |
| `placement` | string | `null` | 弹出位置，默认自动判断 |
| `offset` | string \| array | `[0, 2]` | 偏移量 |
| `popperConfig` | object \| function | `null` | 自定义 Popper 配置 |

### 5.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dropdown 示例</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container py-5">
    <div class="btn-group">
      <button type="button" class="btn btn-danger">操作</button>
      <button type="button" class="btn btn-danger dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
        <span class="visually-hidden">Toggle Dropdown</span>
      </button>
      <ul class="dropdown-menu">
        <li><a class="dropdown-item" href="#">查看详情</a></li>
        <li><a class="dropdown-item" href="#">编辑</a></li>
        <li><a class="dropdown-item" href="#">导出</a></li>
        <li><hr class="dropdown-divider"></li>
        <li><a class="dropdown-item text-danger" href="#">删除</a></li>
      </ul>
    </div>

    <div class="dropdown mt-4">
      <button class="btn btn-outline-primary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
        选择排序方式
      </button>
      <ul class="dropdown-menu">
        <li><h6 class="dropdown-header">排序选项</h6></li>
        <li><a class="dropdown-item active" href="#">按时间倒序</a></li>
        <li><a class="dropdown-item" href="#">按时间正序</a></li>
        <li><a class="dropdown-item" href="#">按热度</a></li>
        <li><a class="dropdown-item disabled" href="#">按评分（开发中）</a></li>
      </ul>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 5.4 JavaScript 控制方法

```javascript
const dropdownEl = document.querySelector('.dropdown-toggle');
const dropdown = new bootstrap.Dropdown(dropdownEl, {
  autoClose: 'outside',
  offset: [0, 10]
});

// 显示
dropdown.show();

// 隐藏
dropdown.hide();

// 切换
dropdown.toggle();

// 更新位置
dropdown.update();
```

### 5.5 导航栏中的下拉菜单

Dropdown 与 Navbar 结合使用时，只需将触发元素放在 `.navbar-nav` 中，Bootstrap 会自动适配移动端折叠菜单。

## 六、工具提示 Tooltip

工具提示（Tooltip）用于在用户悬停或聚焦时显示一段提示信息，常用于解释图标按钮含义、表单字段说明等场景。Bootstrap 5 的 Tooltip 基于 Popper 进行定位，支持上下左右等多种方向。

### 6.1 触发方式

Tooltip 不会通过 data 属性自动初始化，必须手动通过 JavaScript 初始化。通常在页面加载完成后，统一为所有带有 `data-bs-toggle="tooltip"` 的元素初始化。

```html
<button type="button" class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-placement="top" title="我是提示文字">
  悬停查看提示
</button>
```

### 6.2 常用配置

| 选项 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `animation` | boolean | `true` | 是否启用动画 |
| `container` | string \| HTMLElement \| false | `false` | 提示框的挂载容器 |
| `delay` | number \| object | `0` | 显示和隐藏的延迟 |
| `html` | boolean | `false` | 是否允许 HTML 内容 |
| `placement` | string \| function | `'top'` | 显示位置 |
| `title` | string \| HTMLElement \| function | `''` | 提示文本 |
| `trigger` | string | `'hover focus'` | 触发方式 |

### 6.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tooltip 示例</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container py-5">
    <div class="d-flex gap-2 justify-content-center">
      <button type="button" class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-placement="top" title="上方提示">
        上
      </button>
      <button type="button" class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-placement="right" title="右侧提示">
        右
      </button>
      <button type="button" class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-placement="bottom" title="下方提示">
        下
      </button>
      <button type="button" class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-placement="left" title="左侧提示">
        左
      </button>
    </div>

    <div class="mt-4 text-center">
      <button type="button" class="btn btn-primary" data-bs-toggle="tooltip" data-bs-html="true" title="<em>斜体</em> <u>下划线</u>">
        HTML 提示
      </button>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    document.addEventListener('DOMContentLoaded', function () {
      const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
      const tooltipList = [...tooltipTriggerList].map(el => new bootstrap.Tooltip(el));
    });
  </script>
</body>
</html>
```

### 6.4 JavaScript 控制方法

```javascript
const tooltipEl = document.getElementById('myTooltip');
const tooltip = new bootstrap.Tooltip(tooltipEl, {
  placement: 'bottom',
  trigger: 'click',
  title: '通过 JS 设置的提示内容'
});

// 显示
tooltip.show();

// 隐藏
tooltip.hide();

// 切换
tooltip.toggle();

// 销毁
tooltip.dispose();

// 更新内容
tooltip.setContent({ '.tooltip-inner': '新的提示内容' });
```

### 6.5 注意事项

- Tooltip 必须手动初始化，忘记初始化是新手最常犯的错误；
- 如果提示内容来自用户输入，务必先进行 XSS 过滤，或者关闭 `html` 选项；
- 动态生成的元素需要在插入 DOM 后再初始化 Tooltip。

## 七、弹出框 Popover

弹出框（Popover）比 Tooltip 更复杂，可以显示标题和内容的组合，常用于展示更多信息、操作确认、轻量表单等场景。Popover 同样基于 Popper 定位，并且需要手动初始化。

### 7.1 触发方式

```html
<button type="button" class="btn btn-lg btn-danger" data-bs-toggle="popover" title="Popover 标题" data-bs-content="这里是弹出框的内容，可以写更多说明文字。">
  点击显示 Popover
</button>
```

### 7.2 常用配置

| 选项 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `animation` | boolean | `true` | 是否启用动画 |
| `container` | string \| HTMLElement \| false | `false` | 挂载容器 |
| `content` | string \| HTMLElement \| function | `''` | 内容 |
| `html` | boolean | `false` | 是否允许 HTML 内容 |
| `placement` | string \| function | `'right'` | 显示位置 |
| `title` | string \| HTMLElement \| function | `''` | 标题 |
| `trigger` | string | `'click'` | 触发方式 |
| `delay` | number \| object | `0` | 延迟 |

### 7.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Popover 示例</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container py-5 text-center">
    <button type="button" class="btn btn-secondary" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="top" data-bs-content="顶部的 Popover 内容">
      Popover on top
    </button>

    <button type="button" class="btn btn-secondary" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="right" data-bs-content="右侧的 Popover 内容">
      Popover on right
    </button>

    <button type="button" class="btn btn-secondary" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="bottom" data-bs-content="底部的 Popover 内容">
      Popover on bottom
    </button>

    <button type="button" class="btn btn-secondary" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="left" data-bs-content="左侧的 Popover 内容">
      Popover on left
    </button>

    <hr class="my-4">

    <button type="button" class="btn btn-primary" id="livePopover" data-bs-toggle="popover" data-bs-html="true" title="自定义标题" data-bs-content="<p>这是一段 <strong>加粗</strong> 的 HTML 内容。</p>">
      HTML Popover
    </button>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    document.addEventListener('DOMContentLoaded', function () {
      const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]');
      const popoverList = [...popoverTriggerList].map(el => new bootstrap.Popover(el));
    });
  </script>
</body>
</html>
```

### 7.4 JavaScript 控制方法

```javascript
const popoverEl = document.getElementById('livePopover');
const popover = new bootstrap.Popover(popoverEl, {
  trigger: 'focus',
  placement: 'bottom'
});

// 显示
popover.show();

// 隐藏
popover.hide();

// 切换
popover.toggle();

// 销毁
popover.dispose();

// 更新内容
popover.setContent({
  '.popover-header': '新标题',
  '.popover-body': '新内容'
});
```

### 7.5 与 Tooltip 的区别

Tooltip 通常只显示一行简短提示，而 Popover 可以显示标题和正文，适合展示更丰富的内容。Popover 默认通过点击触发，Tooltip 默认通过悬停和聚焦触发。

## 八、滚动监听 Scrollspy

滚动监听（Scrollspy）插件用于根据页面滚动位置自动更新导航链接的高亮状态，常用于长文档、单页应用、目录导航等场景。Bootstrap 5 的 Scrollspy 支持基于滚动容器或基于 `body` 的监听。

### 8.1 触发方式

在需要监听的滚动容器上添加 `data-bs-spy="scroll"`，并指定 `data-bs-target` 为导航容器。

```html
<body data-bs-spy="scroll" data-bs-target="#navbar-example" data-bs-offset="0" tabindex="0">
  ...
</body>
```

### 8.2 常用配置

| 选项 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `offset` | number | `10` | 计算滚动位置时的偏移量 |
| `method` | string | `'auto'` | 滚动监听方法，`'auto'`、`'offset'`、`'position'` |
| `target` | string \| HTMLElement \| JQuery | `null` | 导航目标容器 |
| `rootMargin` | string | `'0px 0px -40%'` | Intersection Observer 的 rootMargin |
| `smoothScroll` | boolean | `false` | 是否平滑滚动 |
| `threshold` | array | `[0.1, 0.5, 1]` | Intersection Observer 阈值 |

### 8.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Scrollspy 示例</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .scrollspy-example {
      position: relative;
      height: 300px;
      overflow: auto;
      margin-top: 1rem;
    }
    .scrollspy-example h4 {
      padding-top: 2rem;
    }
  </style>
</head>
<body>
  <div class="container py-5">
    <nav id="navbar-example2" class="navbar bg-body-tertiary px-3 mb-3">
      <a class="navbar-brand" href="#">文档目录</a>
      <ul class="nav nav-pills">
        <li class="nav-item">
          <a class="nav-link" href="#scrollspyHeading1">第一章</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#scrollspyHeading2">第二章</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#scrollspyHeading3">第三章</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#scrollspyHeading4">第四章</a>
        </li>
      </ul>
    </nav>

    <div data-bs-spy="scroll" data-bs-target="#navbar-example2" data-bs-root-margin="0px 0px -40%" data-bs-smooth-scroll="true" class="scrollspy-example bg-body-tertiary p-3 rounded-2" tabindex="0">
      <h4 id="scrollspyHeading1">第一章 绪论</h4>
      <p>这里是第一章的内容。Scrollspy 会在滚动到该章节时自动高亮对应的导航链接。</p>
      <p>继续补充一些占位文字，让章节有足够的高度用于演示滚动效果。</p>
      <h4 id="scrollspyHeading2">第二章 理论基础</h4>
      <p>这里是第二章的内容。Bootstrap 5 使用 Intersection Observer API 实现滚动监听，性能比传统的 scroll 事件监听更优。</p>
      <p>继续补充一些占位文字，让章节有足够的高度用于演示滚动效果。</p>
      <h4 id="scrollspyHeading3">第三章 实验设计</h4>
      <p>这里是第三章的内容。可以通过 data-bs-offset 调整触发高亮的时机。</p>
      <p>继续补充一些占位文字，让章节有足够的高度用于演示滚动效果。</p>
      <h4 id="scrollspyHeading4">第四章 总结</h4>
      <p>这里是第四章的内容。Scrollspy 非常适合用于文档站点、博客目录、长页面导航。</p>
      <p>继续补充一些占位文字，让章节有足够的高度用于演示滚动效果。</p>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 8.4 JavaScript 控制方法

```javascript
const scrollSpyEl = document.querySelector('[data-bs-spy="scroll"]');
const scrollSpy = new bootstrap.ScrollSpy(scrollSpyEl, {
  target: '#navbar-example2',
  offset: 80,
  smoothScroll: true
});

// 刷新 Scrollspy，通常在动态添加目标元素后调用
scrollSpy.refresh();
```

### 8.5 注意事项

- 必须确保目标元素和导航链接的 `href` 正确对应；
- 如果监听的是 `body`，需要给 `body` 设置 `position: relative` 或确保有滚动条；
- 动态添加章节后，记得调用 `refresh()` 方法刷新监听。

## 九、Toast 消息提示

Toast（烤面包片）是 Bootstrap 4 引入、Bootstrap 5 继续沿用的一种轻量级消息提示组件，通常从屏幕角落弹出，用于展示操作成功、失败、警告等反馈信息。Toast 不会自动获得焦点，不会阻塞用户操作，是一种非侵入式的通知方式。

### 9.1 触发方式

Toast 需要通过 JavaScript 手动创建和显示。通常将 Toast 容器预先放在 HTML 中隐藏，需要时通过 JS 调用 `show()` 方法。

```html
<div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
  <div class="toast-header">
    <strong class="me-auto">通知</strong>
    <small>刚刚</small>
    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
  </div>
  <div class="toast-body">
    操作已成功完成！
  </div>
</div>
```

### 9.2 常用配置

| 选项 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `animation` | boolean | `true` | 是否启用淡入淡出动画 |
| `autohide` | boolean | `true` | 是否自动隐藏 |
| `delay` | number | `5000` | 自动隐藏前的延迟时间 |

### 9.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Toast 示例</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container py-5">
    <button type="button" class="btn btn-primary" id="liveToastBtn">显示 Toast</button>

    <div class="toast-container position-fixed bottom-0 end-0 p-3">
      <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
          <strong class="me-auto">系统消息</strong>
          <small>刚刚</small>
          <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body">
          您有一条新的系统通知，请注意查收。
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    const toastTrigger = document.getElementById('liveToastBtn');
    const toastLiveExample = document.getElementById('liveToast');

    if (toastTrigger) {
      const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLiveExample, {
        autohide: true,
        delay: 3000
      });
      toastTrigger.addEventListener('click', () => {
        toastBootstrap.show();
      });
    }
  </script>
</body>
</html>
```

### 9.4 JavaScript 控制方法

```javascript
const toastEl = document.getElementById('liveToast');
const toast = new bootstrap.Toast(toastEl, {
  animation: true,
  autohide: true,
  delay: 5000
});

// 显示
toast.show();

// 隐藏
toast.hide();

// 获取或创建实例，避免重复创建
const toastInstance = bootstrap.Toast.getOrCreateInstance(toastEl);
```

### 9.5 动态创建 Toast

在实际项目中，我们经常需要根据业务逻辑动态生成 Toast，而不是预先写好 HTML。

```javascript
function showToast(message, type = 'primary') {
  const container = document.querySelector('.toast-container') || createToastContainer();
  const toastEl = document.createElement('div');
  toastEl.className = `toast align-items-center text-bg-${type} border-0`;
  toastEl.setAttribute('role', 'alert');
  toastEl.innerHTML = `
    <div class="d-flex">
      <div class="toast-body">${message}</div>
      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
  `;
  container.appendChild(toastEl);
  const toast = new bootstrap.Toast(toastEl, { delay: 4000 });
  toast.show();
  toastEl.addEventListener('hidden.bs.toast', () => {
    toastEl.remove();
  });
}

function createToastContainer() {
  const container = document.createElement('div');
  container.className = 'toast-container position-fixed top-0 end-0 p-3';
  document.body.appendChild(container);
  return container;
}

// 使用
showToast('保存成功', 'success');
showToast('保存失败，请重试', 'danger');
```

## 十、实战：交互式后台管理页

前面我们分别学习了 Bootstrap 5 的各种 JavaScript 插件，接下来通过一个完整的交互式后台管理页项目，将这些插件综合运用起来。该页面包含顶部导航栏、左侧折叠菜单、右侧内容区、数据表格、操作模态框、消息提示 Toast、轮播公告等模块。

### 10.1 页面结构

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>交互式后台管理页</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <style>
    body {
      min-height: 100vh;
    }
    .sidebar {
      min-height: calc(100vh - 56px);
    }
    .stat-card {
      transition: transform 0.2s;
    }
    .stat-card:hover {
      transform: translateY(-5px);
    }
  </style>
</head>
<body>
  <!-- 顶部导航 -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">AdminPro</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#topNavbar">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="topNavbar">
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
              <i class="bi bi-person-circle"></i> 管理员
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
              <li><a class="dropdown-item" href="#">个人资料</a></li>
              <li><a class="dropdown-item" href="#">设置</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="#">退出登录</a></li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container-fluid">
    <div class="row">
      <!-- 左侧菜单 -->
      <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse" id="sidebarMenu">
        <div class="position-sticky pt-3">
          <ul class="nav flex-column">
            <li class="nav-item">
              <a class="nav-link active" href="#" data-bs-toggle="tooltip" title="返回首页">
                <i class="bi bi-house-door"></i> 首页
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#" data-bs-toggle="tooltip" title="订单管理">
                <i class="bi bi-cart"></i> 订单
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#" data-bs-toggle="tooltip" title="用户管理">
                <i class="bi bi-people"></i> 用户
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#productSubmenu" data-bs-toggle="collapse">
                <i class="bi bi-box-seam"></i> 商品
              </a>
              <div class="collapse" id="productSubmenu">
                <ul class="nav flex-column ms-3">
                  <li class="nav-item"><a class="nav-link" href="#">商品列表</a></li>
                  <li class="nav-item"><a class="nav-link" href="#">分类管理</a></li>
                </ul>
              </div>
            </li>
          </ul>
        </div>
      </nav>

      <!-- 主内容区 -->
      <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
        <h1 class="h2">仪表盘</h1>

        <!-- 轮播公告 -->
        <div id="announcementCarousel" class="carousel slide bg-light rounded p-3 mb-4" data-bs-ride="carousel">
          <div class="carousel-inner text-center">
            <div class="carousel-item active">
              <p class="mb-0">🎉 欢迎使用 AdminPro 后台管理系统！</p>
            </div>
            <div class="carousel-item">
              <p class="mb-0">📢 系统将于本周日凌晨进行维护升级。</p>
            </div>
            <div class="carousel-item">
              <p class="mb-0">💡 新版本支持暗黑模式，敬请期待。</p>
            </div>
          </div>
        </div>

        <!-- 统计卡片 -->
        <div class="row g-4 mb-4">
          <div class="col-md-4">
            <div class="card stat-card border-primary h-100">
              <div class="card-body d-flex align-items-center">
                <div class="flex-shrink-0 bg-primary text-white rounded p-3 me-3">
                  <i class="bi bi-people fs-2"></i>
                </div>
                <div>
                  <h6 class="card-subtitle mb-2 text-muted">总用户</h6>
                  <h3 class="card-title mb-0">12,345</h3>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card stat-card border-success h-100">
              <div class="card-body d-flex align-items-center">
                <div class="flex-shrink-0 bg-success text-white rounded p-3 me-3">
                  <i class="bi bi-currency-dollar fs-2"></i>
                </div>
                <div>
                  <h6 class="card-subtitle mb-2 text-muted">今日收入</h6>
                  <h3 class="card-title mb-0">¥ 8,920</h3>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card stat-card border-warning h-100">
              <div class="card-body d-flex align-items-center">
                <div class="flex-shrink-0 bg-warning text-white rounded p-3 me-3">
                  <i class="bi bi-bag fs-2"></i>
                </div>
                <div>
                  <h6 class="card-subtitle mb-2 text-muted">待处理订单</h6>
                  <h3 class="card-title mb-0">156</h3>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 数据表格 -->
        <div class="card">
          <div class="card-header d-flex justify-content-between align-items-center">
            <span>最新订单</span>
            <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#addOrderModal">
              <i class="bi bi-plus-lg"></i> 新增订单
            </button>
          </div>
          <div class="card-body">
            <table class="table table-hover align-middle">
              <thead>
                <tr>
                  <th>订单号</th>
                  <th>客户</th>
                  <th>金额</th>
                  <th>状态</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>#20240817001</td>
                  <td>张三</td>
                  <td>¥ 299.00</td>
                  <td><span class="badge bg-success">已完成</span></td>
                  <td>
                    <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#orderDetailModal" data-order-id="#20240817001">
                      查看
                    </button>
                    <button class="btn btn-sm btn-outline-danger delete-btn" data-order-id="#20240817001">
                      删除
                    </button>
                  </td>
                </tr>
                <tr>
                  <td>#20240817002</td>
                  <td>李四</td>
                  <td>¥ 599.00</td>
                  <td><span class="badge bg-warning">待发货</span></td>
                  <td>
                    <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#orderDetailModal" data-order-id="#20240817002">
                      查看
                    </button>
                    <button class="btn btn-sm btn-outline-danger delete-btn" data-order-id="#20240817002">
                      删除
                    </button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </main>
    </div>
  </div>

  <!-- 新增订单模态框 -->
  <div class="modal fade" id="addOrderModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">新增订单</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form id="addOrderForm">
            <div class="mb-3">
              <label class="form-label">客户姓名</label>
              <input type="text" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">订单金额</label>
              <input type="number" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">订单状态</label>
              <select class="form-select">
                <option value="pending">待处理</option>
                <option value="shipped">已发货</option>
                <option value="completed">已完成</option>
              </select>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
          <button type="button" class="btn btn-primary" id="saveOrderBtn">保存</button>
        </div>
      </div>
    </div>
  </div>

  <!-- 订单详情模态框 -->
  <div class="modal fade" id="orderDetailModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">订单详情</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <p>订单号：<span id="detailOrderId">-</span></p>
          <p>下单时间：2024-08-17 10:30:00</p>
          <p>商品清单：示例商品 A x 1，示例商品 B x 2</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
        </div>
      </div>
    </div>
  </div>

  <!-- Toast 容器 -->
  <div class="toast-container position-fixed bottom-0 end-0 p-3"></div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    document.addEventListener('DOMContentLoaded', function () {
      // 初始化所有 Tooltip
      const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
      [...tooltipTriggerList].map(el => new bootstrap.Tooltip(el));

      // 初始化轮播
      const announcementCarousel = document.getElementById('announcementCarousel');
      new bootstrap.Carousel(announcementCarousel, {
        interval: 4000,
        wrap: true
      });

      // 新增订单保存
      const addOrderModalEl = document.getElementById('addOrderModal');
      const addOrderModal = new bootstrap.Modal(addOrderModalEl);
      document.getElementById('saveOrderBtn').addEventListener('click', function () {
        const form = document.getElementById('addOrderForm');
        if (form.checkValidity()) {
          addOrderModal.hide();
          showToast('订单新增成功！', 'success');
          form.reset();
        } else {
          form.reportValidity();
        }
      });

      // 订单详情回显
      const orderDetailModalEl = document.getElementById('orderDetailModal');
      orderDetailModalEl.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget;
        const orderId = button.getAttribute('data-order-id');
        document.getElementById('detailOrderId').textContent = orderId;
      });

      // 删除按钮
      document.querySelectorAll('.delete-btn').forEach(btn => {
        btn.addEventListener('click', function () {
          const orderId = this.getAttribute('data-order-id');
          if (confirm('确定要删除订单 ' + orderId + ' 吗？')) {
            this.closest('tr').remove();
            showToast('订单 ' + orderId + ' 已删除', 'danger');
          }
        });
      });

      // Toast 工具函数
      function showToast(message, type = 'primary') {
        const container = document.querySelector('.toast-container');
        const toastEl = document.createElement('div');
        toastEl.className = `toast align-items-center text-bg-${type} border-0`;
        toastEl.setAttribute('role', 'alert');
        toastEl.innerHTML = `
          <div class="d-flex">
            <div class="toast-body">${message}</div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
          </div>
        `;
        container.appendChild(toastEl);
        const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
        toast.show();
        toastEl.addEventListener('hidden.bs.toast', () => toastEl.remove());
      }
    });
  </script>
</body>
</html>
```

### 10.2 代码解析

这个实战页面综合运用了本章学习的多个插件：

- **Dropdown**：顶部导航栏的管理员下拉菜单；
- **Collapse**：左侧商品子菜单的折叠展开、移动端的顶部导航折叠；
- **Tooltip**：左侧菜单图标的悬停提示；
- **Carousel**：仪表盘顶部的公告轮播；
- **Modal**：新增订单和查看订单详情的弹窗；
- **Toast**：保存订单、删除订单后的消息提示。

通过这个例子可以看到，Bootstrap 5 的插件可以很好地协同工作，帮助我们快速搭建功能完善的后台管理系统。

## 十一、本章小结

本章系统介绍了 Bootstrap 5 中最重要的 JavaScript 插件，内容覆盖了从基础机制到具体插件，再到综合实战的完整学习路径。下面我们对本章内容进行简要回顾。

Bootstrap 5 的 JavaScript 插件已经全部基于原生 JavaScript 实现，不再依赖 jQuery。每个插件都支持 data 属性自动初始化和 JavaScript API 手动控制两种方式。data 属性方式适合快速开发，JavaScript API 方式适合需要精细控制的场景。

模态框 Modal 是最常用的弹窗组件，支持静态背景、键盘关闭、多种尺寸和垂直居中。轮播 Carousel 适合图片或内容的循环展示，支持指示器、切换箭头、自动播放和触摸滑动。折叠 Collapse 常用于手风琴、侧边栏菜单和更多详情展开。下拉菜单 Dropdown 基于 Popper 定位，支持自动翻转和丰富的菜单项类型。工具提示 Tooltip 和弹出框 Popover 都需要手动初始化，适合显示补充信息。滚动监听 Scrollspy 可以根据滚动位置自动高亮导航。Toast 是一种轻量级的非阻塞消息提示组件。

在实际项目中，这些插件往往需要组合使用。本章最后的交互式后台管理页实战案例，展示了如何将 Dropdown、Collapse、Tooltip、Carousel、Modal、Toast 等插件整合到一个完整的页面中。掌握这些插件的使用方法，能够显著提升前端开发效率，让我们用更少的代码实现更丰富的交互体验。

学习 Bootstrap 的 JavaScript 插件，关键在于多写代码、多实践。建议大家将本章的示例逐一运行，修改配置参数，观察效果变化，并在自己的项目中尝试组合使用这些插件。只有经过反复练习，才能真正做到融会贯通、灵活运用。

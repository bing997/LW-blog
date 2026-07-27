---
title: 01-初始bootstrap框架
date: 2024-08-14T09:43:40+08:00
tags:
    - bootstrap
    - 教程
categories: bootstrap
cover:  https://bing997.github.io/LW-blog/images/cover01.png
index_enable: true # 是否显示文章封面
aside_enable: true 
archives_enable: true 
position: both  # 封面显示的位置 三个值可配置left , right , both 
default_cover:   # 当没有设置cover时，默认的封面显示
sticky: false  # 设置为 true 即可置顶
description: "bootstrap"
---
## 一、Bootstrap简介

### Bootstrap简述
Bootstrap 来自 Twitter(推特)，是目前最受欢迎的前端框架。Bootstrap 是基于 HTML、CSS 和 JAVASCRIPT 的，它简洁灵活，使得 Web 开发更加快捷。

HTML定义页面元素，CSS定义页面布局，而JavaScript负责页面元素的响应。Bootstrap将HTML、CSS和JavaScript封装成一个个功能组件，用起来简洁灵活，使得 Web 开发更加快捷。

![](../../../images/20240814120416.png)

Bootstrap5 目前是 Bootstrap 的最新版本，利用提供的 Sass 变量和大量 mixin、响应式栅格系统、可扩展的预制组件、基于 jQuery 的强大的插件系统，能够快速为你的想法开发出原型或者构建整个 app。

> 浏览器兼容性：Bootstrap5 兼容所有主流浏览器（Chrome、Firefox、Edge、Safari 和 Opera）。 如果您需要支持 IE11 及以下版本，请使用 Bootstrap4 或 Bootstrap3。

**框架**：顾名思义就是一套架构，它有一套比较完整的网页功能解决方案，而且控制权在框架本身，有预制样式库、组件和插件。使用者要按照框架所规定的某种`规范`进行开发。


### 为什么使用Bootstrap
<span style="color: red;">移动设备优先</span>：自 Bootstrap3 起，框架包含了贯穿于整个库移动设备优先的样式。
+ 不是简单的增加一些可选的针对移动设备的样式，而是直接融合进了框架的内核中。
+ 也就是说，针对移动设备的样式融合进了框架的每个角落，而不是增加一个额外的文件。
<span style="color: red;"></span>

<span style="color: red;">浏览器支持</span>：所有的主流浏览器都支持 Bootstrap

<span style="color: red;">容易上手</span>：只要您具备 HTML 和 CSS 的基础知识，您就可以开始学习 Bootstrap。

<span style="color: red;">响应式设计</span>：Bootstrap 的响应式 CSS 能够自适应于台式机、平板电脑和手机。

它为开发人员创建接口提供了一个简洁统一的解决方案。

它包含了功能强大的内置组件，易于定制。

它还提供了基于 Web 的定制。

它是**开源**的。


### 如何使用Bootstrap
中文官网：http://www.bootcss.com/ 

官网：http://getbootstrap.com/ 

#### 使用CDN
**CSS 文件**
> 复制以下 <link> 标签并粘贴到 <head> 标签内，注意，务必放到其它所有 CSS 样式前面。
```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
```
**JS**
> Bootstrap 自带的大部分组件都需要依赖 JavaScript 才能起作用。

> 复制下面的 `<script>` 标签 粘贴到页面底部，并且是在 `</body>` 标签之前，就能起作用了。注意，顺序很重要，不能错，首先是 jQuery，然后是 Popper，最后是我们自己的 JavaScript 插件。

<span style="color: red;">
我们提供的两个集成包都包含了 Bootstrap 的每一个 JavaScript 插件。即 bootstrap.bundle.js 和 bootstrap.bundle.min.js，此外，还包含了 Popper，用于支持工具提示（tooltip）和弹出框（popover）功能，但是不包含 jQuery。
</span>


```html
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-7ymO4nGrkm372HoSbq1OY2DP4pEZnMiA+E0F3zPr+JQQtQ82gQ1HPY3QIVtztVua" crossorigin="anonymous"></script>
```
或者分开加载
```html
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-Lge2E2XotzMiwH69/MXB72yLpwyENMiOKX8zS8Qo7LDCvaBIWGL+GlRQEKIpYR04" crossorigin="anonymous"></script>
```


#### 使用本地文件
![](../../../images/下载bootstrap.png)

> 下载完成后解压`bootstrap-4.6.2-dist.zip`文件，分别导入CSS文件和JS文件即可



### 简单模板

```html
<!doctype html>
<html lang="zh-CN">
  <head>
    <!-- 必须的 meta 标签 -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap 的 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

    <title>Hello, world!</title>
  </head>
  <body>
    <h1>Hello, world!</h1>

    <!-- JavaScript 文件是可选的。从以下两种建议中选择一个即可！ -->

    <!-- 选项 1：jQuery 和 Bootstrap 集成包（集成了 Popper） -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-7ymO4nGrkm372HoSbq1OY2DP4pEZnMiA+E0F3zPr+JQQtQ82gQ1HPY3QIVtztVua" crossorigin="anonymous"></script>

    <!-- 选项 2：Popper 和 Bootstrap 的 JS 插件各自独立 -->
    <!--
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-Lge2E2XotzMiwH69/MXB72yLpwyENMiOKX8zS8Qo7LDCvaBIWGL+GlRQEKIpYR04" crossorigin="anonymous"></script>
    -->
  </body>
</html>
```


### 案例：第 一个Bootstrap实例

将代码保存为一个 .html 文件（例如 index.html）

使用浏览器打开这个文件，就可以看到一个简单的网页，其中包含一个导航栏、标题、段落和按钮。
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bootstrap 第一个实例</title>
    <!-- 引入 Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <!-- 导航栏 -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">我的网站</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link" href="#">首页 <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">功能</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">定价</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">禁用</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- 标题 -->
    <div class="container mt-5">
        <h1 class="display-4">欢迎使用 Bootstrap!</h1>
        <p class="lead">这是一个简单的 Bootstrap 框架示例。</p>
        <hr class="my-4">
        <p>它使用了 Bootstrap 提供的内置组件，如导航栏、排版、按钮等。</p>
        <a class="btn btn-primary btn-lg" href="#" role="button">了解更多</a>
    </div>

    <!-- 引入 Bootstrap JS 和依赖库 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
```
> `引入 Bootstrap CSS`：在 <head> 标签中，我们使用 <link> 标签引入 Bootstrap 的 CSS 文件。这使得我们能够使用 Bootstrap 提供的样式和组件。
`导航栏 (Navbar)`：这是一个基本的导航栏组件，使用了 Bootstrap 提供的 .navbar、.navbar-brand、.navbar-nav 等类。它包含了一个品牌名称和几个导航链接。
`标题和内容`：在 .container 内，使用了 .display-4 类来创建一个大标题，并通过 .lead 类创建副标题。内容块中使用了 .btn 类来创建一个按钮。
`引入 Bootstrap JS 和依赖库`：Bootstrap 的一些功能（如下拉菜单、模态框等）依赖于 JavaScript，因此需要引入 jQuery、Popper.js 和 Bootstrap 的 JavaScript 文件。


### Bootstrap4

> 直接拿Bootstrap 预先定义好的样式来使用
修改Bootstrap 原来的样式，注意权重问题
学好Bootstrap 的关键在于知道它定义了哪些样式，以及这些样式能实现什么样的效果


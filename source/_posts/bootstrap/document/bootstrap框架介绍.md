---
title: boostrap框架介绍
date: 2024-08-08 17:04:05
tags: 
    - test
    - bootstrap
categories: bootstrap
cover: https://bing997.github.io/LW-blog/images/bg.png
# 是否显示文章封面
index_enable: true 
aside_enable: true 
archives_enable: true 
# 封面显示的位置
# 三个值可配置left , right , both 
position: both 
# 当没有设置cover时，默认的封面显示
default_cover:
sticky: true  # 设置为 true 即可置顶
description: "bootstrap"
---

## bootstrap框架
### 1. 基本结构
Container: 包裹页面内容，分为.container和.container-fluid两种。
Grid System: 采用12列的栅格系统，通过.row和.col-*类定义响应式布局。
```html
<div class="container">
  <div class="row">
    <div class="col-md-4">Column 1</div>
    <div class="col-md-4">Column 2</div>
    <div class="col-md-4">Column 3</div>
  </div>
</div>
```
> 此代码展示了一个基本的3列布局，在中等设备及以上设备上每列占据屏幕的1/3。

### 2. 排版
排版和文本工具: 提供了标题、段落、列表、文本对齐、文本变换等样式类。
代码块: 使用.code或`<pre>`标签展示代码。


### 3. 表单
表单控制: 包括文本框、选择框、复选框、单选按钮等元素，使用.form-control类。
表单布局: 可以水平、垂直排列表单元素。
```html
<form>
  <div class="mb-3">
    <label for="exampleInputEmail1" class="form-label">Email address</label>
    <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
  </div>
  <div class="mb-3">
    <label for="exampleInputPassword1" class="form-label">Password</label>
    <input type="password" class="form-control" id="exampleInputPassword1">
  </div>
  <button type="submit" class="btn btn-primary">Submit</button>
</form>
```
> 此代码展示了一个简单的表单，包含电子邮件和密码输入字段以及提交按钮。

### 4. 按钮
按钮样式: 使用.btn类和颜色修饰类如.btn-primary、.btn-success等。
按钮组: 使用.btn-group类创建按钮组。
```html
<div class="btn-group" role="group" aria-label="Basic example">
  <button type="button" class="btn btn-secondary">Left</button>
  <button type="button" class="btn btn-secondary">Middle</button>
  <button type="button" class="btn btn-secondary">Right</button>
</div>
```
> 此代码创建了一个包含三个按钮的按钮组。

### 5. 组件
导航: 包括导航条、选项卡、面包屑导航等，使用.nav、.navbar类。
模态框: 弹出框，通过.modal类定义。
工具提示和弹出框: 通过.tooltip和.popover类实现。
折叠组件: 使用.collapse类管理内容的显示与隐藏。
```html
<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
```
> 此代码展示了一个基本的模态框，包含标题、正文和页脚。

```html
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Features</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Pricing</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
```
> 此代码展示了一个简单的响应式导航栏。



```html
<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="..." class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="..." class="d-block w-100" alt="...">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
```
> 此代码展示了一个具有指示器和前后控制按钮的轮播图。

### 6. JavaScript 插件
模态框: 动态加载内容和表单。
轮播图: 创建幻灯片效果，使用.carousel类。
滚动监听: 通过.scrollspy类跟踪滚动位置。


### 7. 响应式设计
断点: 定义不同设备上的响应式设计，使用.col-*类。
隐藏与显示: 使用.d-none、.d-sm-*等类控制元素在不同设备上的显示。


### 8. 自定义
Sass 变量: 定制主题颜色、字体、间距等。
主题生成器: 官方提供在线工具生成自定义主题。


### 9. 实用工具类
间距工具类: 使用.m-*和.p-*控制外边距和内边距。
浮动工具类: 使用.float-*控制元素浮动。
这些知识点涵盖了 Bootstrap 框架的核心内容，帮助开发者快速构建响应式、现代化的网页。如果需要更深入的理解或实践，官方文档是一个非常有用的资源。


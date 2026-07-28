---
title: 12-项目案例：Web设计与定制网站
date: 2024-08-20T23:50:00+08:00
tags:
    - bootstrap
    - 教程
    - 项目案例
categories: bootstrap
cover: /images/cover17.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: "构建一个 Web 设计与定制服务站点，包含顶部固定导航、Hero 区、团队展示、数据看板、服务卡片、博客图廊与价格套餐等模块。"
---

本案例构建一个**Web 设计与定制服务**单页站点，使用 Bootstrap 4 + 滚动监听（ScrollSpy）实现锚点导航，涵盖首页、关于、团队、服务、博客、定制六大模块。重点练习固定导航、ScrollSpy、Jumbotron、图标卡片、列表组套餐、滚动动画等。

## 一、案例概述

### 1.1 业务背景

Web 设计工作室的官网需要突出**专业感与设计感**。本案例通过深色主题、显眼的 Hero 大图、数据化的能力展示、清晰的价格套餐，让潜在客户快速了解服务能力与报价。

### 1.2 涉及知识点

| 知识点 | 在本案例中的作用 |
|--------|----------------|
| 固定导航 `fixed-top` | 顶部常驻导航 |
| ScrollSpy `data-spy` | 滚动监听锚点高亮 |
| Jumbotron | Hero 大图 |
| 卡片 `.card` | 团队成员 |
| 列表组 `.list-group` | 价格套餐明细 |
| 图标 `.fa` | 服务图标 |
| transform/scale | 鼠标悬停动效 |
| 媒体查询 | 自定义背景与高度 |

### 1.3 页面结构

```
Web 设计与定制
├── 固定顶部导航（首页/关于/团队/服务/博客/定制）
├── 首页 Hero + 三大服务理念
├── 关于我们（职责 + 图片展示）
├── 我们的团队（3 成员 + 数据看板）
├── 我们的服务（认证/咨询/培训/检查 4 项）
├── 我们的博客（6 张图片网格）
├── 我们的定制（3 档套餐）
└── 底部脚注
```

## 二、实现步骤拆解

### 2.1 顶部固定导航

```html
<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top" id="navbar">
    <a href="#" class="navbar-brand px-5"><b><i>刘飞</i></b><small>&nbsp;个人站点</small></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarContent">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse ml-5" id="navbarContent">
        <ul class="navbar-nav mr-auto mt-2 mt-lg-0 nav-list">
            <li class="nav-item"><a href="#list1" class="nav-link">首页</a></li>
            <li class="nav-item"><a href="#list2" class="nav-link">关于</a></li>
            <li class="nav-item"><a href="#list3" class="nav-link">团队</a></li>
            <li class="nav-item"><a href="#list4" class="nav-link">服务</a></li>
            <li class="nav-item"><a href="#list5" class="nav-link">博客</a></li>
            <li class="nav-item"><a href="#list6" class="nav-link">定制</a></li>
        </ul>
        <div class="px-5 iconColor">
            <a href="#"><i class="fa fa-weixin"></i></a>
            <a href="#"><i class="fa fa-qq"></i></a>
            <a href="#"><i class="fa fa-twitter"></i></a>
            <a href="#"><i class="fa fa-google-plus"></i></a>
            <a href="#"><i class="fa fa-github"></i></a>
        </div>
    </div>
</nav>
```

在 `<body>` 上声明 ScrollSpy，让导航根据滚动位置高亮：

```html
<body data-spy="scroll" data-target="#navbar">
```

### 2.2 首页 Hero

```html
<h4 id="list1" class="list"></h4>
<div class="img-b">
    <div class="jumbotron jumbotron-fluid text-white d-flex align-items-center m-0">
        <div class="container">
            <h1 class="display-4">专业网页设计10年</h1>
            <p class="lead">我们让每一个品牌都更加出色</p>
            <a href="javascript:;" class="btn btn-danger">了解更多</a>
        </div>
    </div>
</div>
<div class="bg-dark py-5 text-white">
    <div class="container">
        <div class="row">
            <div class="col-lg-4">
                <h2><i class="fa fa-laptop mr-2"></i>网页设计与 <span class="text-white-50">发展</span></h2>
                <p>设计网页的目的不同，应选择不同的网页策划与设计方案</p>
            </div>
            <div class="col-lg-4">
                <h2><i class="fa fa-rocket mr-2"></i>网页设计与 <span class="text-white-50">品牌化</span></h2>
                <p>网页设计的主要目标，是通过使用合理的颜色、字体、图片、样式进行页面美化</p>
            </div>
            <div class="col-lg-4">
                <h2><i class="fa fa-camera mr-2"></i>网页设计与 <span class="text-white-50">创意</span></h2>
                <p>在功能限定的情况下，尽可能给予用户完美的视觉体验</p>
            </div>
        </div>
    </div>
</div>
```

### 2.3 关于我们

```html
<h4 id="list2" class="list"></h4>
<div class="container">
    <h1 class="text-center">__关于我们__</h1>
    <p class="my-4">运营平台的强大流量资源与用户资源，把企业信息即时的展现在有需求的移动用户面前，促使用户关注您的企业产品与服务，并进一步与您的企业建立深入沟通，最终达成交易</p>
    <div class="row">
        <div class="col-lg-6">
            <h3 class="mb-4">我们的职责</h3>
            <ul>
                <li><i class="fa fa-angle-right"></i>负责对网站整体表现风格的定位，对用户视觉感受的整体把握。</li>
                <li><i class="fa fa-angle-right"></i>进行网页的具体设计制作。</li>
                <li><i class="fa fa-angle-right"></i>产品目录的平面设计。</li>
                <li><i class="fa fa-angle-right"></i>各类活动的广告设计。</li>
                <li><i class="fa fa-angle-right"></i>协助开发人员页面设计等工作。</li>
            </ul>
            <a href="javascript:;" class="btn btn-primary">开始你的工作吧</a>
        </div>
        <div class="col-lg-6">
            <img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593143278393&di=5cdacd851b265e108657a8355d5077f4&imgtype=0&src=http%3A%2F%2F7xil86.com2.z0.glb.qiniucdn.com%2Fuploads%2Fimages%2F2016%2F07%2F43.jpeg"
                 alt="about" class="img-fluid img-thumbnail">
        </div>
    </div>
    <div class="row no-gutters mt-5">
        <div class="col-md-6">
            <img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593143278383&di=1da1a7339ac418dbe776ed3979d94439&imgtype=0&src=http%3A%2F%2Fimg01.chrstatic.com%2Fimages%2Fphoto%2F201608%2F1471573521334syh8zy.jpg"
                 class="img-fluid" alt="">
        </div>
        <div class="col-md-6 bg-dark text-white px-5 pt-5">
            <h3 class="mb-4">工作的内容:</h3>
            <p>网页如门面，小到个人主页，大到大公司……这一切都是网页设计的范畴，都是网页设计师的工作。</p>
        </div>
    </div>
</div>
```

### 2.4 团队展示 + 数据看板

```html
<h4 id="list3" class="list"></h4>
<div class="container">
    <h1 class="text-center">__我们的团队__</h1>
    <p class="my-4">每一天我们都憧憬更高更远的未来……我们也相信明天一定会更好。</p>
    <div class="row">
        <div class="col-12 col-md-4">
            <div class="box">
                <img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593145049739&di=7dff328db1e6eca2671fb26edabcfca2&imgtype=0&src=http%3A%2F%2Fimg3.cutv.com%2Fimages%2F2019%2F7%2F4%2F2019741562253671878_412.jpg"
                     class="img-fluid w-100" alt="">
            </div>
            <div class="bg-primary text-center py-2 iconColor">
                <a href="javascript:;"><i class="fa fa-weixin"></i></a>
                <a href="javascript:;"><i class="fa fa-qq"></i></a>
                <a href="javascript:;"><i class="fa fa-phone"></i></a>
            </div>
            <h2 class="text-center bg-dark text-white py-3">Wilson</h2>
        </div>
        <!-- Anne / Kevin 略 -->
    </div>
    <!--数据看板-->
    <div class="mt-4 bg1">
        <div class="row text-white">
            <div class="col-md-3 text-center py-5">
                <div><i class="fa fa-trophy fa-3x i-circle rounded-circle"></i></div>
                <h2 class="my-4">50</h2>
                <h5>获奖</h5>
            </div>
            <div class="col-md-3 text-center py-5">
                <div><i class="fa fa-code fa-3x i-circle rounded-circle"></i></div>
                <h2 class="my-4">358000</h2>
                <h5>代码行</h5>
            </div>
            <div class="col-md-3 text-center py-5">
                <div><i class="fa fa-globe fa-3x i-circle rounded-circle"></i></div>
                <h2 class="my-4">786</h2>
                <h5>全球客户</h5>
            </div>
            <div class="col-md-3 text-center py-5">
                <div><i class="fa fa-rocket fa-3x i-circle rounded-circle"></i></div>
                <h2 class="my-4">1280</h2>
                <h5>交付的项目</h5>
            </div>
        </div>
    </div>
</div>
```

### 2.5 服务卡片

```html
<h4 id="list4" class="list"></h4>
<div class="container">
    <h1 class="text-center">__我们的服务__</h1>
    <p class="my-4">我们可以为您的公司提供全面服务……</p>
    <div class="row">
        <div class="col-md-6">
            <div class="row">
                <div class="col-md-4 text-center"><i class="fa fa-diamond fa-3x i-circle rounded-circle"></i></div>
                <div class="col-md-8">
                    <h4>认证</h4>
                    <p>在众多技术领域和国家地区、我们都已获得授信以验证您的体系、产品、人员或资产满足特定要求、并颁发证书正式确认。</p>
                    <a href="javascript:;" class="btn btn-primary">更多信息</a>
                </div>
            </div>
        </div>
        <!-- 咨询/培训/检查 略 -->
    </div>
</div>
```

### 2.6 博客图廊

```html
<h4 id="list5" class="list"></h4>
<div class="container blog">
    <h1 class="text-center">__我们的博客__</h1>
    <p class="my-4">"乐于分享，加速成长，共同进步，和谐共赢"……分享知识会得到更多的知识以及更多超越知识的东西！</p>
    <div class="row">
        <div class="col-4"><img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593149879032&di=169f096c4a4dc42e4c161f78de01f698&imgtype=0&src=http%3A%2F%2Fimg.mw8.com%2F170620%2F1496967818.gif" class="img-fluid" alt=""></div>
        <!-- 更多 5 张图 -->
    </div>
</div>
```

### 2.7 定制套餐

```html
<h4 id="list6" class="list"></h4>
<div class="container px-5">
    <h1 class="text-center">__我们的定制__</h1>
    <p class="my-4">我们的定制内容包括以下 3 种，您可以根据需要进行选择，期待与您的合作。</p>
    <div class="row text-white">
        <div class="col-4">
            <div class="text-center">
                <h5 class="bg-light py-3 m-0 text-success">创业基础</h5>
                <h5 class="bg-primary py-2 m-0">服务标准</h5>
            </div>
            <ul class="list-group list-group-flush text-center">
                <li class="list-group-item list-group-item-secondary">1-3年经验设计师</li>
                <li class="list-group-item list-group-item-secondary">2套LOGO设计方案</li>
                <li class="list-group-item list-group-item-secondary">3个工作日出设计初稿</li>
                <li class="list-group-item list-group-item-secondary">5个工作日出设计稿</li>
                <li class="list-group-item list-group-item-secondary">12项可编辑矢量源文件</li>
                <li class="list-group-item list-group-item-secondary py-4"><a href="javascript:;" class="btn btn-primary">现在定制</a></li>
            </ul>
        </div>
        <!-- 豪华套餐 / 全部套餐 略 -->
    </div>
</div>
```

### 2.8 底部脚注

```html
<footer class="footer bg-dark text-white py-5 mt-5">
    <div class="iconColor text-center">
        <a href="javascript:;"><i class="fa fa-weixin fa-2x"></i></a>
        <a href="javascript:;" class="mx-3"><i class="fa fa-qq fa-2x"></i></a>
        <a href="javascript:;"><i class="fa fa-twitter fa-2x"></i></a>
        <a href="javascript:;" class="mx-3"><i class="fa fa-google-plus fa-2x"></i></a>
        <a href="javascript:;"><i class="fa fa-github fa-2x"></i></a>
    </div>
    <div class="text-center my-3">
        <p>Copyright &copy;2020.</p>
    </div>
</footer>
```

## 三、核心 CSS

```css
#navbar{ height: 60px; box-shadow: 0 1px 10px red; }
.list{ height: 50px; }
.nav-list li{ margin-left: 10px; }
.nav-list li:hover{ border-bottom: 2px solid white; }
.iconColor a{ color: white; }
.iconColor a:hover i{ color: red; transform: scale(1.5); }
.active{ border-bottom: 2px solid red; }
.navbar-brand:hover{ transform: scale(1.5); }
.img-b{ background: url("https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1447425589,2489704120&fm=26&gp=0.jpg"); background-size: 1150px 568px; }
.jumbotron{ height: 500px; background: rgba(0,0,255,0.6); }
ul li{ list-style: none; }
img{ transition: all 0.2s ease-in; }
img:hover{ transform: scale(1.05); }
p{ text-indent: 2em; }
.bg1{ background: #7870E8; padding: 30px 0; }
.i-circle{ padding: 20px 20px; background: white; color: #7870E8; }
.i-circle:hover{ transform: scale(1.1); }
```

## 四、关键技术解析

### 4.1 滚动监听 ScrollSpy

`<body data-spy="scroll" data-target="#navbar">` + 导航项的 `href="#list1"` 锚点即可实现"滚动到对应区域，导航高亮"的效果。`#list1` 等空 `<h4>` 充当滚动锚点，避免区域顶部被固定导航遮住。

### 4.2 固定导航遮罩问题

固定导航会盖住内容顶部，常见做法是给 `<body>` 加 `padding-top: 60px`（与导航同高），或在每个区域顶部插入高度为导航高度的"空 `<h4>` 锚点"。本案例采用后者。

### 4.3 数据看板的视觉技巧

`.i-circle` 圆形图标 + 紫色背景 `.bg1` + 数字放大显示（`h2.my-4`）形成强烈的"数据感"。这是企业站展示"实力指标"的常见组合。

### 4.4 价格套餐层次

通过"套餐名（白底）→ 服务标准（蓝底）→ 详情列表（普通背景）→ CTA 按钮"的视觉层次，让用户一眼看清每档套餐的核心差异。`.list-group-flush` 移除列表项的外边距和圆角，使套餐更紧凑。

## 五、小结

本案例是**单页应用（SPA）式企业站**的入门示例，结构清晰、模块完整。建议扩展练习：

- 把滚动监听改为 jQuery `scroll` 事件 + 自定义动画版本。
- 给团队成员加 hover 浮层（联系信息）。
- 把"我们的定制"接入真实表单提交。
- 把整个站点拆为多个 pug/ejs 模板并通过 include 复用。

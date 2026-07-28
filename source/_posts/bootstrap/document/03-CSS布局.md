---
title: 03-Bootstrap CSS 样式与排版
date: 2024-08-21T05:00:00+08:00
tags: [bootstrap, 教程]
categories: bootstrap
cover: /images/cover03.png
index_enable: true # 是否显示文章封面
aside_enable: true 
archives_enable: true 
position: both  # 封面显示的位置 三个值可配置left , right , both 
default_cover:   # 当没有设置cover时，默认的封面显示
sticky: false  # 设置为 true 即可置顶
description: "详解 Bootstrap 排版、表格、表单、按钮、图片、辅助类等核心 CSS 工具。"
---

Bootstrap 是全球最流行的前端 UI 框架之一，其核心价值在于提供了一套经过精心设计、语义清晰、响应式友好的 CSS 工具类。掌握 Bootstrap 的 CSS 样式与排版，不仅能够快速搭建出美观一致的页面，还能让开发者将更多精力投入到业务逻辑与交互设计上。本章将围绕 Bootstrap 5.3.2 版本，系统讲解排版、表格、表单、按钮、图片、辅助类、颜色背景、间距工具等核心内容，并通过一个完整的登录与注册表单实战案例，帮助读者把知识点融会贯通。

## 一、排版系统

### 1.1 标题样式

**概念说明**

Bootstrap 对 HTML 原生的 `<h1>` 到 `<h6>` 标题标签进行了样式重制，使其在默认情况下拥有统一的字体、字重与行高。同时，框架提供了 `.h1` 到 `.h6` 这一系列类，使得开发者可以在非标题元素（如 `<p>`、`<div>`）上获得与对应标题完全一致的视觉样式。这种设计在需要保持页面语义结构、又希望视觉层次灵活调整时非常有用。

**使用场景**

标题样式适用于页面标题、章节标题、卡片标题、侧边栏小标题等。例如，在一个博客文章详情页中，文章的 `<h1>` 标题使用原生标签，而评论列表中的“热门评论”提示则可以使用 `<p class="h5">`，既保证了语义正确，又获得了统一的标题视觉。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>标题样式示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <h1>一级标题 h1</h1>
    <h2>二级标题 h2</h2>
    <h3>三级标题 h3</h3>
    <h4>四级标题 h4</h4>
    <h5>五级标题 h5</h5>
    <h6>六级标题 h6</h6>
    <hr>
    <p class="h1">使用 .h1 类的段落</p>
    <p class="h2">使用 .h2 类的段落</p>
    <p class="h3">使用 .h3 类的段落</p>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

示例中，`<h1>` 到 `<h6>` 会从上到下呈现出递减的字号，Bootstrap 默认使用 2.5rem、2rem、1.75rem、1.5rem、1.25rem、1rem 的阶梯式大小。而 `<p class="h1">` 等段落虽然在 HTML 结构中仍然是段落标签，但视觉上与真正的 `<h1>` 完全一致，这种能力在 CMS 内容渲染或需要动态控制标题外观时非常实用。

### 1.2 段落与正文

**概念说明**

Bootstrap 为 `<p>` 标签设置了默认的底部外边距（margin-bottom: 1rem）和舒适的行高（line-height: 1.5），让大段文字更易于阅读。框架还提供了 `.lead` 类，用于突出显示引导性段落，通常表现为更大的字号和更轻的字重。此外，通过文本颜色类（如 `.text-muted`、`.text-primary`）可以快速改变段落的情绪色彩。

**使用场景**

普通段落用于文章正文、产品说明、用户协议等长文本区域。`.lead` 类常用于页面顶部的 Slogan、摘要介绍或引导语。文本颜色类则用于状态提示、强调说明或链接性文字。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>段落样式示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <p class="lead">这是一段引导性文字，通常用于页面开篇，吸引用户继续阅读。</p>
    <p>这是一段普通的正文内容。Bootstrap 会自动为段落设置合适的外边距和行高，让阅读体验更加舒适。</p>
    <p class="text-muted">这是一段次要说明文字，使用 .text-muted 类降低视觉权重。</p>
    <p class="text-primary">这是一段带有主色调的文本，用于强调重要信息。</p>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.lead` 类的段落会比普通段落略大（默认 1.25rem），字重更轻（font-weight: 300），适合用作引言。普通段落之间会自动留出空白，无需手动设置 margin。`.text-muted` 呈现灰色，适合注释；`.text-primary` 呈现主题蓝色，适合重点提示。

### 1.3 行内文本修饰

**概念说明**

Bootstrap 保留了浏览器对 `<mark>`、`<small>`、`<del>`、`<s>`、`<ins>`、`<u>`、`<strong>`、`<em>`、`<b>`、`<i>` 等行内标签的默认渲染，并在此基础上进行了细微美化。例如 `<mark>` 会获得醒目的黄色背景，`<small>` 会缩小字号并降低字重，`<del>` 和 `<s>` 会显示删除线，`<ins>` 和 `<u>` 会显示下划线。

**使用场景**

这些标签在电商价格展示、搜索关键词高亮、文本对比、法律条款修订等场景中广泛使用。例如，原价使用 `<del>` 标签划掉，现价使用 `<strong>` 强调；搜索结果中的关键词使用 `<mark>` 高亮。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>行内文本修饰示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <p>搜索结果显示：<mark>Bootstrap</mark> 是最受欢迎的前端框架之一。</p>
    <p><small>免责声明：以上内容仅供参考，不构成任何投资建议。</small></p>
    <p>原价 <del>￥299</del>，现价 <strong>￥199</strong>。</p>
    <p>待办事项：<s>完成第一章学习</s> <ins>完成第二章学习</ins></p>
    <p>请<u>务必</u>在截止日期前提交作业。</p>
    <p><em>这段话需要语气上的强调</em>，而 <b>这个词</b> 只是单纯加粗。</p>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`<mark>` 会在文字背后添加浅黄色背景，形成高亮效果。`<small>` 将文字缩小到 0.875em，适合标注说明。`<del>` 和 `<s>` 虽然视觉效果相似，但前者表示内容已被删除，后者表示内容不再准确。`<ins>` 表示新增内容，`<u>` 仅作下划线样式。`<strong>` 和 `<em>` 带有语义强调，而 `<b>` 和 `<i>` 更偏向纯样式。

### 1.4 文本对齐与大小写

**概念说明**

Bootstrap 提供了一系列文本对齐工具类，包括 `.text-start`（左对齐）、`.text-center`（居中）、`.text-end`（右对齐）以及 `.text-justify`（两端对齐，在 Bootstrap 5 中已被移除，建议使用 CSS）。同时，大小写工具类 `.text-lowercase`、`.text-uppercase`、`.text-capitalize` 可以快速转换文本大小写，常用于按钮、标签、标题等场景。

**使用场景**

文本左对齐适合正文阅读，居中对齐适合标题与引导语，右对齐适合价格、日期、操作按钮等。大小写转换常用于英文 UI，例如导航菜单全部大写 `.text-uppercase`、表单标签首字母大写 `.text-capitalize`。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文本对齐与大小写示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <p class="text-start border p-2">左对齐文本，适合大多数阅读场景。</p>
    <p class="text-center border p-2">居中对齐文本，常用于标题。</p>
    <p class="text-end border p-2">右对齐文本，适合数值和操作。</p>
    <hr>
    <p class="text-lowercase">BOOTSTRAP CSS</p>
    <p class="text-uppercase">bootstrap css</p>
    <p class="text-capitalize">bootstrap css utilities</p>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.text-start`、`.text-center`、`.text-end` 分别将文本对齐到容器左侧、中间和右侧。在 Bootstrap 5 中，这些类名已经取代了旧版的 `.text-left`、`.text-right`。`.text-lowercase` 会把所有字母转为小写，`.text-uppercase` 转为大写，`.text-capitalize` 仅将每个单词的首字母大写。

### 1.5 缩略语、地址与引用

**概念说明**

`<abbr>` 标签用于定义缩写，配合 `title` 属性可以在鼠标悬停时显示完整含义。`<address>` 标签用于标记联系信息，Bootstrap 会为其设置合适的行高和间距。`<blockquote>` 标签配合 `.blockquote` 类可以实现美观的引用块，来源信息可以使用 `.blockquote-footer` 类。

**使用场景**

缩略语适合在技术文档中解释专业术语；地址标签适合联系方式、公司信息页；引用块适合 testimonials、评论摘录、名言展示等。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>缩略语、地址与引用示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <p><abbr title="Cascading Style Sheets">CSS</abbr> 是网页样式的核心语言。</p>
    <address>
        <strong>某科技公司</strong><br>
        北京市海淀区中关村大街 100 号<br>
        <abbr title="Phone">电话：</abbr> (010) 1234-5678
    </address>
    <blockquote class="blockquote">
        <p>Talk is cheap. Show me the code.</p>
        <footer class="blockquote-footer">Linus Torvalds</footer>
    </blockquote>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`<abbr>` 默认会显示为点状下划线，鼠标悬停时浏览器会弹出 `title` 提示。`<address>` 会显示为斜体并保留换行。`.blockquote` 会让引用文字加大并增加左侧内边距，`.blockquote-footer` 会以灰色小字显示来源，并在前面自动添加短横线。

### 1.6 列表

**概念说明**

Bootstrap 为无序列表 `<ul>`、有序列表 `<ol>` 和描述列表 `<dl>` 提供了样式重置。`.list-unstyled` 可以移除列表默认的项目符号和内边距，`.list-inline` 与 `.list-inline-item` 可以将列表项水平排列，适合制作简单的横向导航或标签组。

**使用场景**

无样式列表常用于页脚链接、侧边栏菜单、面包屑容器等。内联列表适合展示标签云、分类筛选、步骤指示器等横向布局。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>列表样式示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <h5>默认无序列表</h5>
    <ul>
        <li>HTML</li>
        <li>CSS</li>
        <li>JavaScript</li>
    </ul>
    <h5>无样式列表</h5>
    <ul class="list-unstyled">
        <li>首页</li>
        <li>产品</li>
        <li>关于我们</li>
    </ul>
    <h5>内联列表</h5>
    <ul class="list-inline">
        <li class="list-inline-item">前端</li>
        <li class="list-inline-item">后端</li>
        <li class="list-inline-item">移动端</li>
    </ul>
    <h5>描述列表</h5>
    <dl>
        <dt>Bootstrap</dt>
        <dd>流行的前端开源框架。</dd>
        <dt>Vue</dt>
        <dd>渐进式 JavaScript 框架。</dd>
    </dl>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

默认无序列表会显示圆点符号，有序列表会显示数字序号。`.list-unstyled` 会移除这些符号，并将左内边距清零。`.list-inline` 配合 `.list-inline-item` 会把列表项变为 inline-block 元素，使其在同一行显示，并带有默认的水平间距。描述列表中的 `<dt>` 为粗体术语，`<dd>` 为缩进描述。

### 1.7 代码与预格式化文本

**概念说明**

`<code>` 标签用于显示行内代码，Bootstrap 会将其渲染为等宽字体并添加粉色。`<pre>` 标签用于显示预格式化文本块，适合展示多行代码。配合 `.pre-scrollable`（Bootstrap 5 中已移除，建议配合 `style` 使用）可以限制最大高度并启用滚动条。

**使用场景**

代码标签常用于技术文档、API 说明、教程内容中引用变量名、函数名或命令。预格式化文本块则用于展示完整的代码片段、JSON 数据或终端输出。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>代码与预格式化文本示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <p>使用 <code>npm install bootstrap</code> 命令安装 Bootstrap。</p>
    <p>变量 <var>x</var> 表示输入值，<kbd>Ctrl</kbd> + <kbd>C</kbd> 用于复制。</p>
    <pre><code>&lt;div class="container"&gt;
    &lt;h1&gt;Hello Bootstrap&lt;/h1&gt;
&lt;/div&gt;</code></pre>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`<code>` 内部文字使用等宽字体并呈现粉色，适合与正文区分。`<pre>` 标签会保留源码中的空格和换行，配合 `<code>` 标签可形成完整的代码块。`<var>` 用于变量，会显示为斜体；`<kbd>` 用于键盘按键，会显示为带边框的小方块。

## 二、表格样式

### 2.1 基本表格

**概念说明**

在 Bootstrap 中，只需要为 `<table>` 标签添加 `.table` 类，即可获得一套干净的表格样式，包括水平分隔线、合理的内边距、紧凑的字号和表头加粗效果。这是最基础也是最常用的表格增强方式。

**使用场景**

基本表格适用于后台数据列表、财务报表、用户信息表、课程表等需要结构化展示数据的场景。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>基本表格示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <table class="table">
        <thead>
            <tr>
                <th>编号</th>
                <th>姓名</th>
                <th>年龄</th>
                <th>城市</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>张三</td>
                <td>28</td>
                <td>北京</td>
            </tr>
            <tr>
                <td>2</td>
                <td>李四</td>
                <td>32</td>
                <td>上海</td>
            </tr>
            <tr>
                <td>3</td>
                <td>王五</td>
                <td>25</td>
                <td>广州</td>
            </tr>
        </tbody>
    </table>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.table` 类会为表格添加底部外边距、为 `<thead>` 添加底部边框，并为 `<th>` 设置加粗样式。每一行 `<tr>` 之间会有细细的灰色分隔线，使数据行清晰可辨。整个表格的宽度会自动占满父容器。

### 2.2 斑马线表格

**概念说明**

斑马线效果通过为表格的奇数行或偶数行设置不同的背景色，帮助用户更轻松地横向扫视数据。在 Bootstrap 中，只需在 `.table` 的基础上追加 `.table-striped` 类即可实现。

**使用场景**

当表格列数较多或行数较多时，斑马线能显著提升可读性，常用于数据报表、日志列表、库存管理等场景。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>斑马线表格示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>订单号</th>
                <th>商品</th>
                <th>金额</th>
                <th>状态</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>20240815001</td>
                <td>无线耳机</td>
                <td>￥299</td>
                <td>已支付</td>
            </tr>
            <tr>
                <td>20240815002</td>
                <td>机械键盘</td>
                <td>￥499</td>
                <td>待发货</td>
            </tr>
            <tr>
                <td>20240815003</td>
                <td>显示器</td>
                <td>￥1299</td>
                <td>已完成</td>
            </tr>
            <tr>
                <td>20240815004</td>
                <td>鼠标</td>
                <td>￥99</td>
                <td>已取消</td>
            </tr>
        </tbody>
    </table>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.table-striped` 会通过 CSS 伪类为 `<tbody>` 中的奇数行或偶数行（具体取决于 Bootstrap 版本与主题变量）添加浅灰色背景。斑马线的颜色通常非常淡，不会影响文字阅读，同时又能清晰区分相邻行。

### 2.3 带边框与悬停效果

**概念说明**

`.table-bordered` 类会为表格的所有单元格添加边框，使每个单元格都有清晰的边界。`.table-hover` 类则会在鼠标悬停时为整行添加背景色，便于用户追踪当前查看的数据行。这两个类可以单独使用，也可以组合使用。

**使用场景**

带边框表格适合需要严格对齐、单元格边界明确的场景，如打印报表、财务对账单。悬停效果适合交互式后台系统，用户需要频繁查看和操作某一行数据。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>带边框与悬停表格示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <h5>带边框表格</h5>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>项目</th>
                <th>预算</th>
                <th>支出</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>市场推广</td>
                <td>￥50,000</td>
                <td>￥32,000</td>
            </tr>
            <tr>
                <td>研发投入</td>
                <td>￥120,000</td>
                <td>￥98,000</td>
            </tr>
        </tbody>
    </table>
    <h5 class="mt-4">悬停表格</h5>
    <table class="table table-hover">
        <thead>
            <tr>
                <th>员工</th>
                <th>部门</th>
                <th>绩效</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>赵六</td>
                <td>技术部</td>
                <td>A</td>
            </tr>
            <tr>
                <td>孙七</td>
                <td>产品部</td>
                <td>B+</td>
            </tr>
        </tbody>
    </table>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.table-bordered` 会在每个 `<td>` 和 `<th>` 上添加 1px 的边框线，使表格呈现网格状。`.table-hover` 会在鼠标指针所在的行上叠加一层半透明的背景色，移开鼠标后自动恢复，提升交互反馈感。

### 2.4 紧凑型表格

**概念说明**

`.table-sm` 类通过减少单元格的内边距，让表格在垂直方向上更加紧凑。这个类对于需要在有限空间内展示大量数据的场景非常有用。

**使用场景**

紧凑型表格常见于数据密集型后台、仪表盘、日志列表、手机端数据列表等。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>紧凑型表格示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <table class="table table-sm">
        <thead>
            <tr>
                <th>时间</th>
                <th>级别</th>
                <th>内容</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>09:00</td>
                <td>INFO</td>
                <td>系统启动成功</td>
            </tr>
            <tr>
                <td>09:15</td>
                <td>WARN</td>
                <td>数据库连接池接近上限</td>
            </tr>
            <tr>
                <td>09:30</td>
                <td>ERROR</td>
                <td>第三方接口超时</td>
            </tr>
        </tbody>
    </table>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.table-sm` 会显著减少 `<td>` 和 `<th>` 的上下内边距，使行高变矮。与普通表格相比，同样高度下可以显示更多行数据，适合高密度信息展示。

### 2.5 表格状态类

**概念说明**

Bootstrap 为表格行和单元格提供了情境颜色类，包括 `.table-active`、`.table-primary`、`.table-secondary`、`.table-success`、`.table-danger`、`.table-warning`、`.table-info`、`.table-light`、`.table-dark`。这些类可以直接应用于 `<tr>`、`<td>` 或 `<th>`。

**使用场景**

表格状态类常用于表示数据的状态，例如成功、失败、警告、选中、禁用等。在后台管理系统中，可以用不同颜色区分订单状态或任务优先级。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>表格状态类示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <table class="table">
        <thead>
            <tr>
                <th>任务</th>
                <th>负责人</th>
                <th>状态</th>
            </tr>
        </thead>
        <tbody>
            <tr class="table-active">
                <td>需求评审</td>
                <td>张三</td>
                <td>进行中</td>
            </tr>
            <tr class="table-success">
                <td>接口联调</td>
                <td>李四</td>
                <td>已完成</td>
            </tr>
            <tr class="table-warning">
                <td>性能优化</td>
                <td>王五</td>
                <td>有风险</td>
            </tr>
            <tr class="table-danger">
                <td>支付模块</td>
                <td>赵六</td>
                <td>异常</td>
            </tr>
            <tr class="table-info">
                <td>文档整理</td>
                <td>孙七</td>
                <td>待确认</td>
            </tr>
        </tbody>
    </table>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

每个状态类都会为整行应用对应主题色的浅色调背景。例如 `.table-success` 为浅绿色，`.table-danger` 为浅红色，`.table-warning` 为浅黄色。这些颜色与 Bootstrap 的全局主题色保持一致，便于用户快速理解数据含义。

### 2.6 响应式表格

**概念说明**

当表格列数较多时，在小屏幕设备上可能会出现内容被挤压、换行甚至溢出的问题。Bootstrap 提供了 `.table-responsive` 类，将表格包裹在一个具有水平滚动能力的容器中，保证在小屏幕上也能完整查看数据。

**使用场景**

响应式表格适合移动端数据展示、多列报表、复杂的数据详情页等。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>响应式表格示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th>姓名</th>
                    <th>一月</th>
                    <th>二月</th>
                    <th>三月</th>
                    <th>四月</th>
                    <th>五月</th>
                    <th>六月</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>张三</td>
                    <td>80</td>
                    <td>85</td>
                    <td>90</td>
                    <td>88</td>
                    <td>92</td>
                    <td>95</td>
                </tr>
                <tr>
                    <td>李四</td>
                    <td>78</td>
                    <td>82</td>
                    <td>85</td>
                    <td>89</td>
                    <td>91</td>
                    <td>94</td>
                </tr>
            </tbody>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.table-responsive` 会创建一个 `overflow-x: auto` 的容器。当屏幕宽度不足以容纳表格内容时，容器下方会出现水平滚动条，用户可以通过左右滑动查看被隐藏的列。这样可以避免表格被压缩变形，保持每列的最小宽度。

## 三、表单控件

### 3.1 基本表单控件

**概念说明**

Bootstrap 对 `<input>`、`<select>`、`<textarea>` 等原生表单控件进行了样式增强，使其具有一致的边框、内边距、焦点状态和占位符样式。在 Bootstrap 5 中，表单控件默认采用较大的内边距和圆角，视觉效果更加现代。

**使用场景**

基本表单控件适用于登录框、搜索框、注册表单、评论输入、设置页面等所有需要用户输入信息的场景。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>基本表单控件示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <form>
        <div class="mb-3">
            <label for="username" class="form-label">用户名</label>
            <input type="text" class="form-control" id="username" placeholder="请输入用户名">
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">邮箱</label>
            <input type="email" class="form-control" id="email" placeholder="name@example.com">
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">密码</label>
            <input type="password" class="form-control" id="password" placeholder="请输入密码">
        </div>
        <div class="mb-3">
            <label for="city" class="form-label">城市</label>
            <select class="form-select" id="city">
                <option selected>请选择城市</option>
                <option>北京</option>
                <option>上海</option>
                <option>广州</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="intro" class="form-label">个人简介</label>
            <textarea class="form-control" id="intro" rows="3" placeholder="请简单介绍您自己"></textarea>
        </div>
        <button type="submit" class="btn btn-primary">提交</button>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.form-label` 为标签提供合适的下边距和字体样式。`.form-control` 会让输入框占满父容器宽度，并设置圆角边框、内边距和焦点时的蓝色阴影。`.form-select` 会美化下拉选择框，移除默认的箭头并用 Bootstrap 自定义箭头替代。`<textarea>` 应用 `.form-control` 后会获得一致的边框和缩放行为。

### 3.2 表单控件尺寸与禁用状态

**概念说明**

Bootstrap 提供了 `.form-control-lg` 和 `.form-control-sm` 类用于调整输入框尺寸，分别对应大号和小号输入框。`.form-select-lg` 和 `.form-select-sm` 同理。此外，通过添加 `disabled` 属性或 `.disabled` 类，可以让表单控件变为不可编辑状态。

**使用场景**

大号输入框适合需要突出显示的核心搜索框或登录框；小号输入框适合表格内编辑、紧凑表单。禁用状态常用于只读信息展示、权限不足时的字段保护。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>表单控件尺寸与禁用状态示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <div class="mb-3">
        <input class="form-control form-control-lg" type="text" placeholder="大号输入框">
    </div>
    <div class="mb-3">
        <input class="form-control" type="text" placeholder="默认输入框">
    </div>
    <div class="mb-3">
        <input class="form-control form-control-sm" type="text" placeholder="小号输入框">
    </div>
    <div class="mb-3">
        <input class="form-control" type="text" placeholder="禁用输入框" disabled>
    </div>
    <div class="mb-3">
        <select class="form-select" disabled>
            <option>禁用下拉框</option>
        </select>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.form-control-lg` 会增大输入框的内边距和字号，使其更加醒目。`.form-control-sm` 则会让输入框变得更紧凑。禁用状态的控件会呈现灰色背景，边框颜色变浅，并且无法获得焦点或输入内容，鼠标悬停时会显示禁止光标。

### 3.3 复选框与单选框

**概念说明**

Bootstrap 对复选框 `<input type="checkbox">` 和单选框 `<input type="radio">` 进行了美化，使其在不同浏览器中显示一致。在 Bootstrap 5 中，默认样式已经比较现代，同时支持 `.form-check`、`.form-check-input`、`.form-check-label` 类来构建结构清晰的选项组。

**使用场景**

复选框适用于多选场景，如兴趣爱好、权限配置、商品筛选。单选框适用于互斥选择，如性别、支付方式、配送方式。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>复选框与单选框示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <h5>兴趣爱好（多选）</h5>
    <div class="form-check">
        <input class="form-check-input" type="checkbox" value="" id="hobby1">
        <label class="form-check-label" for="hobby1">阅读</label>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="checkbox" value="" id="hobby2" checked>
        <label class="form-check-label" for="hobby2">编程</label>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="checkbox" value="" id="hobby3" disabled>
        <label class="form-check-label" for="hobby3">旅游（禁用）</label>
    </div>
    <h5 class="mt-4">性别（单选）</h5>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="gender" id="gender1" checked>
        <label class="form-check-label" for="gender1">男</label>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="gender" id="gender2">
        <label class="form-check-label" for="gender2">女</label>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.form-check` 为每个选项提供合理的垂直间距。`.form-check-input` 会美化复选框和单选框的选中、悬停、焦点状态。`.form-check-label` 会让标签与选项对齐。禁用状态的选项会呈现灰色，并且不可点击。单选框通过相同的 `name` 属性实现互斥选择。

### 3.4 输入组

**概念说明**

输入组 `.input-group` 可以将文本、图标、按钮等元素与输入框组合在一起，形成更加紧凑和语义明确的输入区域。`.input-group-text` 用于定义附加内容，可以放在输入框的前面或后面。

**使用场景**

输入组常用于价格输入（前面加货币符号）、手机号输入（前面加区号）、搜索框（后面加搜索按钮）、URL 输入（前面加协议前缀）等场景。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>输入组示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <div class="input-group mb-3">
        <span class="input-group-text">@</span>
        <input type="text" class="form-control" placeholder="用户名">
    </div>
    <div class="input-group mb-3">
        <input type="text" class="form-control" placeholder="请输入金额">
        <span class="input-group-text">.00</span>
    </div>
    <div class="input-group mb-3">
        <span class="input-group-text">https://</span>
        <input type="text" class="form-control" placeholder="example.com">
    </div>
    <div class="input-group">
        <input type="text" class="form-control" placeholder="搜索关键词">
        <button class="btn btn-primary" type="button">搜索</button>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.input-group-text` 会渲染为灰色的附加区域，与输入框自然衔接。输入组中的 `.form-control` 会自动调整边框半径，确保组合后的外观是一个整体。按钮作为输入组的一部分时，会与输入框紧密相邻，常用于搜索和提交操作。

### 3.5 表单验证状态

**概念说明**

Bootstrap 提供了丰富的表单验证样式，通过 `.is-valid` 和 `.is-invalid` 类可以快速标记输入框的验证状态。配合 `.valid-feedback` 和 `.invalid-feedback` 类，可以在输入框下方显示对应的提示信息。在真实项目中，这些类通常由 JavaScript 根据验证结果动态添加。

**使用场景**

表单验证状态适用于注册、登录、提交评论、支付信息等需要确保数据格式正确的场景。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>表单验证状态示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <form>
        <div class="mb-3">
            <label for="validEmail" class="form-label">邮箱</label>
            <input type="email" class="form-control is-valid" id="validEmail" value="test@example.com">
            <div class="valid-feedback">邮箱格式正确</div>
        </div>
        <div class="mb-3">
            <label for="invalidPassword" class="form-label">密码</label>
            <input type="password" class="form-control is-invalid" id="invalidPassword" value="123">
            <div class="invalid-feedback">密码长度至少为 6 位</div>
        </div>
        <div class="form-check mb-3">
            <input class="form-check-input is-invalid" type="checkbox" value="" id="invalidCheck">
            <label class="form-check-label" for="invalidCheck">同意用户协议</label>
            <div class="invalid-feedback">必须同意用户协议才能继续</div>
        </div>
        <button type="submit" class="btn btn-primary">提交</button>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.is-valid` 会为输入框添加绿色边框和绿色的对勾图标，`.valid-feedback` 会显示绿色提示文字。`.is-invalid` 会添加红色边框和感叹号图标，`.invalid-feedback` 会显示红色错误文字。这些视觉反馈能够清晰地告诉用户哪些字段需要修正。

## 四、按钮系统

### 4.1 预定义按钮样式

**概念说明**

Bootstrap 的按钮系统由 `.btn` 基础类和 `.btn-{color}` 情境类共同组成。`.btn` 负责重置按钮的默认样式并设置基本形状，`.btn-primary`、`.btn-secondary`、`.btn-success`、`.btn-danger`、`.btn-warning`、`.btn-info`、`.btn-light`、`.btn-dark`、`.btn-link` 等类负责定义不同的颜色和用途。

**使用场景**

主按钮 `.btn-primary` 用于页面最重要的操作，如提交表单、确认支付。`.btn-secondary` 用于次要操作。`.btn-success` 用于成功、保存、通过等正向操作。`.btn-danger` 用于删除、退出、拒绝等危险操作。`.btn-link` 用于看起来像链接的按钮操作。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>预定义按钮样式示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <button type="button" class="btn btn-primary">Primary</button>
    <button type="button" class="btn btn-secondary">Secondary</button>
    <button type="button" class="btn btn-success">Success</button>
    <button type="button" class="btn btn-danger">Danger</button>
    <button type="button" class="btn btn-warning">Warning</button>
    <button type="button" class="btn btn-info">Info</button>
    <button type="button" class="btn btn-light">Light</button>
    <button type="button" class="btn btn-dark">Dark</button>
    <button type="button" class="btn btn-link">Link</button>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

每个按钮都会有对应的背景色、文字色、边框色和悬停效果。`.btn-primary` 为蓝色，`.btn-success` 为绿色，`.btn-danger` 为红色，`.btn-warning` 为黄色，`.btn-info` 为青色，`.btn-light` 为浅灰，`.btn-dark` 为深灰，`.btn-link` 则去掉了背景，只保留链接文字样式。

### 4.2 轮廓按钮

**概念说明**

轮廓按钮使用 `.btn-outline-{color}` 类，与实心按钮相比，轮廓按钮默认具有透明背景和彩色边框，悬停时才填充背景色。这种风格更加简洁现代，适合工具栏、次级操作区等场景。

**使用场景**

轮廓按钮常用于卡片底部操作区、表格行内操作、筛选条件切换等，不会抢夺页面主视觉焦点。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>轮廓按钮示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <button type="button" class="btn btn-outline-primary">Primary</button>
    <button type="button" class="btn btn-outline-secondary">Secondary</button>
    <button type="button" class="btn btn-outline-success">Success</button>
    <button type="button" class="btn btn-outline-danger">Danger</button>
    <button type="button" class="btn btn-outline-warning">Warning</button>
    <button type="button" class="btn btn-outline-info">Info</button>
    <button type="button" class="btn btn-outline-light text-dark">Light</button>
    <button type="button" class="btn btn-outline-dark">Dark</button>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

轮廓按钮默认显示为彩色边框配透明背景，文字颜色与边框颜色一致。鼠标悬停时，背景会填充为对应颜色，文字颜色会反转为白色或深色，形成明显的点击反馈。

### 4.3 按钮尺寸与块级按钮

**概念说明**

Bootstrap 提供了 `.btn-lg` 和 `.btn-sm` 类来调整按钮尺寸。`.btn-lg` 适合强调性操作，`.btn-sm` 适合紧凑布局。在 Bootstrap 5 中，块级按钮不再使用 `.btn-block` 类，而是直接使用网格工具类（如 `.d-grid`、`.col-12`）或宽度工具类（如 `.w-100`）实现。

**使用场景**

大号按钮常用于登录页提交按钮、引导页 CTA。小号按钮常用于表格操作列、标签页切换。块级按钮常用于移动端表单底部，让按钮占满整行，便于点击。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>按钮尺寸与块级按钮示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <button type="button" class="btn btn-primary btn-lg">大号按钮</button>
    <button type="button" class="btn btn-primary">默认按钮</button>
    <button type="button" class="btn btn-primary btn-sm">小号按钮</button>
    <hr>
    <div class="d-grid gap-2">
        <button class="btn btn-primary" type="button">块级按钮 1</button>
        <button class="btn btn-secondary" type="button">块级按钮 2</button>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.btn-lg` 会显著增大按钮的内边距和字号，`.btn-sm` 会让按钮更小巧。`.d-grid` 配合 `.gap-2` 会让子按钮以网格方式排列，并自动占满父容器宽度，按钮之间保留一定的间隙。

### 4.4 按钮状态与禁用

**概念说明**

按钮可以处于默认、悬停、焦点、激活、禁用等多种状态。`.active` 类用于标记按钮当前处于激活状态，`disabled` 属性或 `.disabled` 类用于禁止按钮交互。需要注意的是，`<a>` 标签模拟的按钮不支持 `disabled` 属性，必须使用 `.disabled` 类，并自行处理点击事件。

**使用场景**

激活状态常用于按钮组中选中的选项、步骤条当前步骤。禁用状态常用于表单未填写完整时、权限不足时、操作正在提交时。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>按钮状态与禁用示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <button type="button" class="btn btn-primary active">激活状态</button>
    <button type="button" class="btn btn-primary" disabled>禁用按钮</button>
    <a href="#" class="btn btn-primary disabled" role="button" aria-disabled="true">禁用的链接按钮</a>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.active` 类会让按钮呈现按下去的深色状态，通常与 aria-pressed 属性配合使用。禁用状态的按钮会变灰，无法触发点击事件，鼠标悬停时会显示禁止图标。链接按钮的 `.disabled` 类只是视觉上的禁用，还需要 JavaScript 阻止默认跳转行为。

### 4.5 按钮组

**概念说明**

按钮组 `.btn-group` 可以将多个按钮合并在一起，形成一组紧密相关的操作区域。配合 `.btn-group-lg`、`.btn-group-sm` 可以调整整组按钮的尺寸。通过 `.btn-group-vertical` 还可以创建垂直按钮组。

**使用场景**

按钮组常用于分页切换、富文本编辑器工具栏、图表时间范围选择、文件操作工具栏等。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>按钮组示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <div class="btn-group mb-3" role="group" aria-label="Basic example">
        <button type="button" class="btn btn-primary">左对齐</button>
        <button type="button" class="btn btn-primary">居中</button>
        <button type="button" class="btn btn-primary">右对齐</button>
    </div>
    <br>
    <div class="btn-group btn-group-sm mb-3" role="group" aria-label="Small button group">
        <button type="button" class="btn btn-outline-primary">昨天</button>
        <button type="button" class="btn btn-outline-primary active">今天</button>
        <button type="button" class="btn btn-outline-primary">近 7 天</button>
    </div>
    <br>
    <div class="btn-group-vertical" role="group" aria-label="Vertical button group">
        <button type="button" class="btn btn-secondary">新建</button>
        <button type="button" class="btn btn-secondary">编辑</button>
        <button type="button" class="btn btn-secondary">删除</button>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.btn-group` 会移除相邻按钮之间的双边框，并调整圆角，使整组按钮看起来像是一个整体。中间按钮会失去圆角，只有最外侧按钮保留左右圆角。垂直按钮组会让按钮纵向堆叠，并调整上下圆角。

## 五、图片与图形

### 5.1 响应式图片

**概念说明**

`.img-fluid` 类让图片具有响应式能力，它会将图片的最大宽度设置为父容器的 100%，同时保持高度自动缩放。这是 Bootstrap 中处理图片响应式的首选方式。

**使用场景**

响应式图片适用于文章配图、商品图片、轮播图、banner 图等需要适应不同屏幕宽度的场景。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>响应式图片示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <img src="https://via.placeholder.com/1200x400" class="img-fluid" alt="响应式图片">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.img-fluid` 会设置 `max-width: 100%; height: auto;`。当容器宽度小于图片原始宽度时，图片会自动缩放；当容器宽度大于图片原始宽度时，图片保持原始尺寸，不会失真拉伸。

### 5.2 图片形状

**概念说明**

Bootstrap 提供了 `.rounded`、`.rounded-circle` 和 `.img-thumbnail` 类来快速改变图片形状。`.rounded` 添加圆角，`.rounded-circle` 将图片裁剪为圆形，`.img-thumbnail` 添加边框和内边距，形成缩略图效果。

**使用场景**

圆角图片适合卡片配图和文章封面。圆形图片常用于用户头像、团队成员照片。缩略图适合图片列表、相册预览。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>图片形状示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <img src="https://via.placeholder.com/150" class="rounded me-2" alt="圆角图片">
    <img src="https://via.placeholder.com/150" class="rounded-circle me-2" alt="圆形图片">
    <img src="https://via.placeholder.com/150" class="img-thumbnail" alt="缩略图">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.rounded` 会为图片四个角添加较小的圆角。`.rounded-circle` 会设置 `border-radius: 50%`，如果图片是正方形则显示为正圆，长方形则显示为椭圆。`.img-thumbnail` 会为图片添加浅灰色边框和白色内边距，呈现 Polaroid 风格的缩略图效果。

### 5.3 图片对齐

**概念说明**

通过浮动工具类 `.float-start`、`.float-end` 或 Flexbox 工具类 `.d-block`、`.mx-auto`，可以实现图片的左对齐、右对齐和居中显示。Bootstrap 5 中已使用 `.float-start` 和 `.float-end` 替代旧版的 `.float-left` 和 `.float-right`。

**使用场景**

图文混排时，图片可以浮动在文字左侧或右侧，文字环绕图片显示。单独展示的图片通常需要居中显示，以保持页面平衡。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>图片对齐示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <div class="clearfix">
        <img src="https://via.placeholder.com/200" class="img-thumbnail float-start me-3" alt="左浮动图片">
        <p>这是一段环绕图片的文字。通过 float-start 类，图片会浮动在容器左侧，文字会从图片右侧开始排列。clearfix 类用于清除浮动，确保父容器能够正确包裹浮动的图片和文字内容。</p>
    </div>
    <hr>
    <img src="https://via.placeholder.com/200" class="img-thumbnail d-block mx-auto" alt="居中图片">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.float-start` 会让图片靠左浮动，后续文字环绕在右侧。`.clearfix` 用于清除浮动，防止父容器高度塌陷。`.d-block` 将图片设置为块级元素，`.mx-auto` 使其水平居中。

## 六、辅助工具类

### 6.1 显示与隐藏

**概念说明**

Bootstrap 提供了一整套 display 工具类，例如 `.d-block`、`.d-inline`、`.d-inline-block`、`.d-flex`、`.d-inline-flex`、`.d-grid`、`.d-none` 等。这些类可以快速改变元素的显示属性，并且支持响应式断点，如 `.d-md-block`、`.d-lg-none`。

**使用场景**

显示工具类用于控制元素在不同屏幕尺寸下的显示与隐藏，例如桌面端显示侧边栏、移动端隐藏侧边栏，或者将行内元素临时变为块级元素。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>显示与隐藏示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <div class="d-block p-2 bg-primary text-white">块级元素</div>
    <div class="d-inline p-2 bg-secondary text-white">行内元素 1</div>
    <div class="d-inline p-2 bg-success text-white">行内元素 2</div>
    <div class="d-none">这段文字默认隐藏</div>
    <div class="d-block d-md-none text-danger mt-3">仅在移动端显示</div>
    <div class="d-none d-md-block text-info mt-3">仅在中等屏幕及以上显示</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.d-block` 会让元素独占一行。`.d-inline` 会让多个元素在同一行显示。`.d-none` 会完全隐藏元素。响应式显示类如 `.d-block d-md-none` 表示在断点 `md`（768px）以下显示，在 `md` 及以上隐藏；`.d-none d-md-block` 则相反。

### 6.2 浮动与清除浮动

**概念说明**

浮动工具类 `.float-start` 和 `.float-end` 可以快速实现元素的左右浮动。`.clearfix` 类用于清除浮动，解决父元素因子元素浮动而导致的高度塌陷问题。

**使用场景**

浮动常用于图文混排、左右分栏、旧版布局兼容等场景。清除浮动则是使用浮动布局时的必备操作。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>浮动与清除浮动示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <div class="clearfix border p-2">
        <div class="float-start bg-primary text-white p-2">左侧浮动</div>
        <div class="float-end bg-success text-white p-2">右侧浮动</div>
    </div>
    <p class="mt-3">父容器应用了 clearfix，因此即使子元素浮动，父容器依然能正确包裹它们。</p>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

两个子元素分别浮动到父容器的左右两侧。如果没有 `.clearfix`，父容器的高度会塌陷为 0，导致后续内容向上移动并与浮动元素重叠。`.clearfix` 通过伪元素清除浮动，使父容器能够正确计算高度。

### 6.3 文本工具类

**概念说明**

除了前面提到的对齐和大小写工具类，Bootstrap 还提供了文本粗细、换行、截断等工具类。例如 `.fw-bold` 加粗、`.fw-normal` 正常、`.fst-italic` 斜体、`.text-decoration-underline` 下划线、`.text-decoration-line-through` 删除线、`.text-truncate` 单行截断等。

**使用场景**

文本工具类用于快速调整文字的视觉表现，无需编写自定义 CSS。例如表格中过长的文本可以用 `.text-truncate` 截断，标题可以用 `.fw-bold` 加粗。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文本工具类示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <p class="fw-bold">加粗文本</p>
    <p class="fw-light">细体文本</p>
    <p class="fst-italic">斜体文本</p>
    <p class="text-decoration-underline">下划线文本</p>
    <p class="text-decoration-line-through">删除线文本</p>
    <div class="text-truncate" style="max-width: 200px;">
        这是一段很长的文本，超出最大宽度后会被截断并显示省略号。
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.fw-bold` 设置字重为 700，`.fw-light` 设置为 300。`.fst-italic` 应用斜体样式。文本装饰类可以添加下划线或删除线。`.text-truncate` 会设置 `overflow: hidden`、`text-overflow: ellipsis` 和 `white-space: nowrap`，需要配合固定宽度容器使用。

### 6.4 屏幕阅读器专用

**概念说明**

`.visually-hidden` 类（Bootstrap 5 中取代了旧版的 `.sr-only`）可以将元素在视觉上隐藏，但保留在文档流中，使屏幕阅读器仍能读取其内容。这对于提升网页的无障碍访问体验非常重要。

**使用场景**

屏幕阅读器专用类常用于为图标按钮添加文字说明、为表单错误提示补充语义、为装饰性图标提供替代文本等。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>屏幕阅读器专用示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <button class="btn btn-primary">
        <span class="visually-hidden">关闭弹窗</span>
        <span aria-hidden="true">&times;</span>
    </button>
    <p class="mt-3">
        <span class="visually-hidden">重要提示：</span>
         visually-hidden 中的内容对普通用户不可见，但屏幕阅读器会朗读出来。
    </p>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.visually-hidden` 通过绝对定位、裁剪、溢出隐藏等技术将元素从视觉上去除，但不设置 `display: none`，因此屏幕阅读器仍然可以访问。`aria-hidden="true"` 则告诉屏幕阅读器忽略装饰性的关闭符号。

## 七、颜色与背景

### 7.1 文本颜色

**概念说明**

Bootstrap 提供了一组文本颜色工具类，命名格式为 `.text-{color}`，例如 `.text-primary`、`.text-secondary`、`.text-success`、`.text-danger`、`.text-warning`、`.text-info`、`.text-light`、`.text-dark`、`.text-body`、`.text-muted`、`.text-white`、`.text-black-50` 等。

**使用场景**

文本颜色类用于快速表达信息状态或层级关系。例如成功提示用绿色，错误提示用红色，次要说明用灰色，链接和重要操作使用主色。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文本颜色示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4 bg-light">
    <p class="text-primary">.text-primary 主色文本</p>
    <p class="text-secondary">.text-secondary 次要文本</p>
    <p class="text-success">.text-success 成功文本</p>
    <p class="text-danger">.text-danger 危险文本</p>
    <p class="text-warning">.text-warning 警告文本</p>
    <p class="text-info">.text-info 信息文本</p>
    <p class="text-dark">.text-dark 深色文本</p>
    <p class="text-muted">.text-muted 柔和文本</p>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

每个文本颜色类都会应用对应主题色的字体颜色。这些颜色与按钮、表格状态类的颜色保持一致，形成统一的视觉语言。`.text-muted` 为灰色，适合辅助说明；`.text-body` 为默认正文色，确保在不同主题下都能保持良好的对比度。

### 7.2 背景颜色

**概念说明**

背景颜色工具类命名格式为 `.bg-{color}`，例如 `.bg-primary`、`.bg-success`、`.bg-danger`、`.bg-warning`、`.bg-info`、`.bg-light`、`.bg-dark`、`.bg-white`、`.bg-transparent` 等。背景色通常会自动搭配合适的文字颜色，以保证可读性。

**使用场景**

背景颜色类适合用于卡片头部、提示条、徽章、标签、状态指示器等需要快速区分区域的场景。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>背景颜色示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <div class="p-3 mb-2 bg-primary text-white">.bg-primary</div>
    <div class="p-3 mb-2 bg-secondary text-white">.bg-secondary</div>
    <div class="p-3 mb-2 bg-success text-white">.bg-success</div>
    <div class="p-3 mb-2 bg-danger text-white">.bg-danger</div>
    <div class="p-3 mb-2 bg-warning text-dark">.bg-warning</div>
    <div class="p-3 mb-2 bg-info text-dark">.bg-info</div>
    <div class="p-3 mb-2 bg-light text-dark">.bg-light</div>
    <div class="p-3 mb-2 bg-dark text-white">.bg-dark</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.bg-primary` 为蓝色背景，`.bg-success` 为绿色背景，`.bg-danger` 为红色背景，`.bg-warning` 为黄色背景，`.bg-info` 为青色背景。深色背景通常搭配 `.text-white`，浅色背景搭配 `.text-dark`，以确保文字对比度符合可访问性要求。

### 7.3 背景渐变

**概念说明**

Bootstrap 5 默认情况下没有启用背景渐变，但可以通过 Sass 变量 `$enable-gradients` 开启。开启后，`.bg-gradient` 类会为元素添加从顶部到底部的半透明黑色渐变叠加效果，增强视觉层次感。

**使用场景**

背景渐变适合用于 hero 区域、卡片封面、 banner 背景等需要增加视觉深度的场景。在无法修改 Sass 变量的纯 CDN 项目中，可以使用自定义 CSS 实现类似效果。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>背景渐变示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .hero-gradient {
            background: linear-gradient(135deg, #0d6efd 0%, #6610f2 100%);
            color: white;
        }
    </style>
</head>
<body>
    <div class="container-fluid py-5 hero-gradient text-center">
        <h1>欢迎来到 Bootstrap 学习之旅</h1>
        <p class="lead">从零开始，掌握最流行的前端框架。</p>
        <button class="btn btn-light btn-lg">立即开始</button>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

示例中通过自定义 CSS 创建了一个从蓝色到紫色的渐变背景，覆盖整个 hero 区域。文字使用白色，按钮使用浅色，形成鲜明的对比。这种方式在 CDN 版本中最为灵活，可以根据品牌色自由调整渐变方向与颜色。

## 八、间距工具类

### 8.1 margin 与 padding

**概念说明**

Bootstrap 的间距工具类基于 4 的倍数进行设计，范围从 0 到 5，以及 auto。类名格式为 `{property}{sides}-{size}`，例如 `.mt-3` 表示 margin-top: 1rem，`.p-2` 表示 padding: 0.5rem，`.mx-auto` 表示水平方向自动外边距。 property 为 `m`（margin）或 `p`（padding），sides 可以是 `t`、`b`、`s`、`e`、`x`、`y` 或省略表示四个方向。

**使用场景**

间距工具类用于快速调整元素之间的距离，无需编写自定义 CSS。例如给卡片添加内边距 `.p-3`、给标题添加底部外边距 `.mb-4`、让块级元素水平居中 `.mx-auto`。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>间距工具类示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <div class="p-3 mb-4 bg-primary text-white">四周内边距 p-3，底部外边距 mb-4</div>
    <div class="px-5 py-2 bg-secondary text-white">水平内边距 px-5，垂直内边距 py-2</div>
    <div class="mt-3 ms-3 p-2 bg-success text-white">顶部外边距 mt-3，左侧外边距 ms-3</div>
    <div class="mx-auto p-3 bg-warning text-dark" style="width: 200px;">水平居中 mx-auto</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.p-3` 表示四个方向的内边距均为 1rem。`.px-5` 表示左右内边距为 3rem，`.py-2` 表示上下内边距为 0.5rem。`.mt-3` 表示顶部外边距 1rem，`.ms-3` 表示左侧外边距 1rem（Bootstrap 5 使用逻辑属性 `s` 表示 start，即左对齐语言中的左侧）。`.mx-auto` 会让元素在父容器中水平居中，但需要元素具有固定宽度。

### 8.2 响应式间距

**概念说明**

间距工具类同样支持响应式断点，格式为 `{property}{sides}-{breakpoint}-{size}`，例如 `.mt-md-5`、`.p-lg-4`。这允许开发者在不同屏幕尺寸下应用不同的间距值。

**使用场景**

响应式间距常用于移动端和桌面端的布局差异。例如，移动端标题与内容之间间距较小，桌面端则需要更大的留白。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>响应式间距示例</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
    <div class="p-2 p-md-4 p-lg-5 bg-info text-dark">
        这个盒子的内边距会根据屏幕宽度变化：<br>
        移动端 p-2（0.5rem），平板 p-md-4（1.5rem），桌面 p-lg-5（3rem）。
    </div>
    <div class="mt-2 mt-md-4 mt-lg-5 p-3 bg-light border">
        这个盒子的顶部外边距也会随屏幕宽度递增。
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

**效果解析**

`.p-2 p-md-4 p-lg-5` 表示在最小屏幕下内边距为 0.5rem，在 `md` 断点（≥768px）时增加到 1.5rem，在 `lg` 断点（≥992px）时增加到 3rem。这种渐进式的间距调整能够让页面在不同设备上都保持良好的呼吸感。

## 九、实战：登录与注册表单页

### 9.1 页面结构分析

**概念说明**

一个完整的登录与注册表单页通常包含品牌 Logo、表单标题、输入字段、复选框或链接、提交按钮等模块。使用 Bootstrap 的栅格系统可以将表单居中显示，使用卡片组件可以让表单具有明确的边界和阴影，使用表单验证类可以提供即时反馈。

**使用场景**

登录与注册页是绝大多数 Web 应用的入口页面，既要保证视觉简洁专业，又要确保表单可用性和无障碍性。

**完整 HTML 示例**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录与注册 - Bootstrap 实战</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .auth-card {
            max-width: 400px;
            margin: 0 auto;
        }
    </style>
</head>
<body class="d-flex align-items-center min-vh-100">
    <div class="container">
        <div class="card auth-card shadow">
            <div class="card-body p-4 p-md-5">
                <h2 class="text-center mb-4">欢迎登录</h2>
                <form novalidate>
                    <div class="mb-3">
                        <label for="loginEmail" class="form-label">邮箱地址</label>
                        <input type="email" class="form-control" id="loginEmail" placeholder="name@example.com" required>
                        <div class="invalid-feedback">请输入有效的邮箱地址</div>
                    </div>
                    <div class="mb-3">
                        <label for="loginPassword" class="form-label">密码</label>
                        <input type="password" class="form-control" id="loginPassword" placeholder="请输入密码" required minlength="6">
                        <div class="invalid-feedback">密码长度不能少于 6 位</div>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="rememberMe">
                        <label class="form-check-label" for="rememberMe">记住我</label>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-lg">登录</button>
                    </div>
                    <hr class="my-4">
                    <div class="text-center">
                        <p class="mb-1">还没有账号？<a href="#">立即注册</a></p>
                        <a href="#" class="text-decoration-none">忘记密码？</a>
                    </div>
                </form>
            </div>
        </div>

        <div class="card auth-card shadow mt-5">
            <div class="card-body p-4 p-md-5">
                <h2 class="text-center mb-4">注册账号</h2>
                <form novalidate>
                    <div class="mb-3">
                        <label for="registerUsername" class="form-label">用户名</label>
                        <input type="text" class="form-control" id="registerUsername" placeholder="请输入用户名" required>
                        <div class="invalid-feedback">用户名不能为空</div>
                    </div>
                    <div class="mb-3">
                        <label for="registerEmail" class="form-label">邮箱地址</label>
                        <input type="email" class="form-control" id="registerEmail" placeholder="name@example.com" required>
                        <div class="invalid-feedback">请输入有效的邮箱地址</div>
                    </div>
                    <div class="mb-3">
                        <label for="registerPassword" class="form-label">设置密码</label>
                        <input type="password" class="form-control" id="registerPassword" placeholder="请输入密码" required minlength="6">
                        <div class="invalid-feedback">密码长度不能少于 6 位</div>
                    </div>
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">确认密码</label>
                        <input type="password" class="form-control" id="confirmPassword" placeholder="请再次输入密码" required>
                        <div class="invalid-feedback">两次输入的密码不一致</div>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="agreeTerms" required>
                        <label class="form-check-label" for="agreeTerms">我已阅读并同意 <a href="#">用户协议</a></label>
                        <div class="invalid-feedback">请同意用户协议</div>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-success btn-lg">注册</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 9.2 效果解析

本实战页面采用了居中卡片布局，`min-vh-100` 和 `d-flex align-items-center` 让卡片在垂直方向上居中。卡片内部使用 `p-4 p-md-5` 实现响应式内边距，移动端紧凑、桌面端舒适。表单控件均使用 `.form-control` 和 `.form-label`，保证标签与输入框的对齐。提交按钮使用 `.d-grid` 实现块级显示，在移动端更易点击。

表单验证通过 HTML5 的 `required`、`minlength`、`type="email"` 等属性配合 Bootstrap 的 `.invalid-feedback` 类实现。虽然示例中没有编写 JavaScript，但在实际项目中，可以通过监听 `submit` 事件，为未通过验证的字段添加 `.is-invalid` 类，从而显示错误提示。登录表单中的“记住我”复选框和注册表单中的“用户协议”复选框分别使用了 `.form-check` 结构，确保选项可点击且样式统一。

链接使用了 Bootstrap 默认的链接样式，并通过 `.text-decoration-none` 去除了忘记密码链接的下划线，使其更符合现代 UI 设计。整个页面通过浅灰色背景 `.bg-light` 和白色卡片形成明暗对比，视觉层次清晰，用户可以迅速聚焦于表单内容。

## 十、本章小结

本章系统介绍了 Bootstrap 5.3.2 中与 CSS 样式和排版相关的核心知识点。首先在排版系统中学习了标题、段落、行内文本修饰、文本对齐与大小写、缩略语地址引用、列表以及代码预格式化文本的使用方法和适用场景。接着在表格样式部分掌握了基本表格、斑马线、边框与悬停、紧凑型、状态类以及响应式表格的实现技巧。表单控件部分覆盖了基本输入框、尺寸与禁用、复选框单选框、输入组和表单验证状态。按钮系统部分讲解了预定义按钮、轮廓按钮、尺寸与块级按钮、状态禁用以及按钮组。图片与图形部分则介绍了响应式图片、图片形状和图片对齐。

在辅助工具类中，我们学习了显示与隐藏、浮动与清除浮动、文本工具类以及屏幕阅读器专用类的使用。颜色与背景部分帮助读者快速为页面元素应用统一的配色方案。间距工具类则是日常开发中使用频率最高的工具之一，通过 margin 和 padding 的组合可以快速构建出舒适的页面留白。最后的登录与注册表单实战案例，将多个知识点串联起来，展示了如何构建一个结构清晰、视觉美观、交互友好的表单页面。

掌握这些内容后，读者已经能够使用 Bootstrap 独立完成大部分静态页面的样式搭建。后续章节将继续深入讲解 Bootstrap 的栅格系统、组件和 JavaScript 插件，帮助读者进一步提升前端开发能力。

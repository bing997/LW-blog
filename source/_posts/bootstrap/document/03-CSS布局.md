---
title: 03-CSS布局
date: 2024-08-15T09:25:12+08:00
tags:
    - bootstrap
    - 教程
categories: bootstrap
cover:  https://bing997.github.io/LW-blog/images/cover03.png
index_enable: true # 是否显示文章封面
aside_enable: true 
archives_enable: true 
position: both  # 封面显示的位置 三个值可配置left , right , both 
default_cover:   # 当没有设置cover时，默认的封面显示
sticky: false  # 设置为 true 即可置顶
description: "bootstrap"
---

## CSS布局

内容涵盖了CSS布局的基础知识和应用，包括排版、列表、代码、表格、按钮、图像和辅助类等内容。

### 排版

#### 标题
标题标签（h1-h6）：HTML提供了六个层次的标题标签，`<h1>` 为最高级标题，`<h6>` 为最低级标题。通过CSS可以控制标题的字体大小、颜色、对齐方式等样式。
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>标题示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <h1>h1 标题</h1>
    <h2>h2 标题</h2>
    <h3>h3 标题</h3>
    <h4>h4 标题</h4>
    <h5>h5 标题</h5>
    <h6>h6 标题</h6>
</body>
</html>
```

### 段落

段落标签（p）：用于定义文本段落，CSS可以用来调整段落的行高、对齐方式、缩进和间距等。
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>段落示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <p class="text-muted">Muted text</p>
    <p class="text-primary">Primary text</p>
    <p class="text-success">Success text</p>

</body>
</html>
```

### mark标签

`<mark>` 标签：用于标记或高亮文本，通常使用背景颜色突出显示。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>mark标签示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <p>这个文本包含<mark>高亮显示</mark>的内容。</p>
</body>
</html>
```

### 小号文本

`<small>` 标签：用于表示注释或次要的文本内容，通常字体较小。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>小号文本示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <p>这是一个普通段落。</p>
    <p><small>这是一个小号文本。</small></p>
</body>
</html>
```

### del和s标签

`<del>` 和 `<s>` 标签：用于表示删除的文本，通常会显示为带有删除线的文本。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>del 和 s 标签示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <p><del>这是一个删除文本。</del></p>
    <p><s>这是一个加删除线的文本。</s></p>
</body>
</html>
```

### ins和u标签

`<ins>` 和 `<u>` 标签：
+ `<ins>`：表示添加的文本，通常显示为带有下划线的文本。
+ `<u>`：表示需要下划线的文本，单纯用于样式。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>ins 和 u 标签示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <p><ins>这是一个下划线文本。</ins></p>
    <p><u>这是一个下划线文本。</u></p>
</body>
</html>
```

### strong和em标签

`<strong>` 和 `<em>` 标签：
+ `<strong>`：表示强调的重要内容，通常显示为粗体。
+ `<em>`：表示文本的语气或语调的强调，通常显示为斜体。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>strong 和 em 标签示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <p><strong>这是一个加粗文本。</strong></p>
    <p><em>这是一个斜体文本。</em></p>
</body>
</html>
```


### b和i标签

`<b>` 和 `<i>` 标签：
+ `<b>`：用于加粗文本，没有语义上的强调意义。
+ `<i>`：用于斜体文本，没有语义上的强调意义。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>b 和 i 标签示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <p><b>这是一个加粗文本。</b></p>
    <p><i>这是一个斜体文本。</i></p>
</body>
</html>
```


### 文本对齐方式
CSS 属性 text-align：用于设置文本的对齐方式，常见的对齐方式包括左对齐（left）、右对齐（right）、居中对齐（center）和两端对齐（justify）。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>文本对齐方式示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <div class="text-left border">左对齐文本</div>
    <div class="text-center border">居中对齐文本</div>
    <div class="text-right border">右对齐文本</div>
</body>
</html>
```


### 字母大小写
CSS 属性 text-transform：用于控制文本的大小写转换，如全部大写（uppercase）、全部小写（lowercase）和首字母大写（capitalize）。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>字母大小写示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <p class="text-lowercase">lowercase text</p>
    <p class="text-uppercase">UPPERCASE TEXT</p>
    <p class="text-capitalize">Capitalized text</p>
</body>
</html>
```


### 缩略语
`<abbr>` 标签：用于定义缩写或缩略语，并提供完整的解释文本，通常会在鼠标悬停时显示。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>缩略语示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <p>您可以使用 <abbr title="Hypertext Markup Language">HTML</abbr> 创建网页。</p>
    <abbr title="International Organization for Standardization">ISO</abbr>

</body>
</html>
```


### 地址
`<address>` 标签：用于标记联系信息或地址，通常显示为斜体文本。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>地址示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <address>
        <strong>公司名称</strong><br>
        1234 街道名称, 市, 国家<br>
        <abbr title="Phone">P:</abbr> (123) 456-7890
    </address>
</body>
</html>
```


### 引用
`<blockquote>` 和 `<q>` 标签：
+ `<blockquote>`：用于引用块级内容，通常会有左右缩进。
+ `<q>`：用于内联引用，通常会在文本周围添加引号。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>引用示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <blockquote class="blockquote">
        <p class="mb-0">这是一个引用。</p>
        <footer class="blockquote-footer">引用来源 <cite title="Source Title">来源标题</cite></footer>
    </p>
    </blockquote>
</body>
</html>
```


## 列表

### 无序列表和有序列表
+ 无序列表 `<ul>`：使用圆点或其他符号标记列表项。
+ 有序列表 `<ol>`：使用数字或字母标记列表项。

```html
<ul>
  <li>Item 1</li>
  <li>Item 2</li>
  <li>Item 3</li>
</ul>

<ol>
  <li>First item</li>
  <li>Second item</li>
  <li>Third item</li>
</ol>
```


### 无样式列表
无样式列表：通过移除默认的列表样式（list-style: none;）来创建无样式的列表，适用于导航栏等。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>无序列表和有序列表示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <h3>无序列表</h3>
    <ul>
        <li>项目 1</li>
        <li>项目 2</li>
        <li>项目 3</li>
    </ul>

    <h3>有序列表</h3>
    <ol>
        <li>项目 1</li>
        <li>项目 2</li>
        <li>项目 3</li>
    </ol>
</body>
</html>
```


### 内联列表
内联列表：将列表项显示为内联元素，通过设置 display: inline;，常用于水平菜单或导航栏。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>内联列表示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <h3>内联列表</h3>
    <ul class="list-inline">
        <li class="list-inline-item">项目 1</li>
        <li class="list-inline-item">项目 2</li>
        <li class="list-inline-item">项目 3</li>
    </ul>
</body>
</html>
```


### 描述列表
描述列表 `<dl>`：用于显示术语及其描述。由 `<dt>` 定义术语，`<dd>` 定义描述。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>描述列表示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <h3>描述列表</h3>
    <dl>
        <dt>术语 1</dt>
        <dd>描述 1</dd>
        <dt>术语 2</dt>
        <dd>描述 2</dd>
    </dl>
</body>
</html>
```


### 代码
`<code>` 标签：用于内联代码显示，通常显示为等宽字体。

`<pre>` 标签：用于预格式化文本，保留空格和换行，通常用于代码块。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>代码示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <h3>代码示例</h3>
    <p>这是一个 <code>&lt;code&gt;</code> 标签中的代码段。</p>
    <pre><code>这是一个预格式化的代码块。</code></pre>
</body>
</html>
```


## 表格
### 基本表格
表格结构：使用 `<table>` 创建表格，包含`<tr>`（表格行），`<th>`（表头单元格），`<td>`（数据单元格）。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>基本表格示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <h3>基本表格</h3>
    <table class="table">
        <thead>
            <tr>
                <th>#</th>
                <th>姓名</th>
                <th>年龄</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>张三</td>
                <td>28</td>
            </tr>
            <tr>
                <td>2</td>
                <td>李四</td>
                <td>32</td>
            </tr>
        </tbody>
    </table>
</body>
</html>
```


### 斑马线表格
斑马线效果：通过CSS设置奇数行和偶数行的背景色不同（nth-child 伪类）来实现。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>斑马线表格示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <h3>斑马线表格</h3>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>#</th>
                <th>姓名</th>
                <th>年龄</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>张三</td>
                <td>28</td>
            </tr>
            <tr>
                <td>2</td>
                <td>李四</td>
                <td>32</td>
            </tr>
        </tbody>
    </table>
</body>
</html>
```


### 带边框的表格
边框设置：通过 border 属性为表格及其单元格添加边框。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>带边框的表格示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <h3>带边框的表格</h3>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>#</th>
                <th>姓名</th>
                <th>年龄</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>张三</td>
                <td>28</td>
            </tr>
            <tr>
                <td>2</td>
                <td>李四</td>
                <td>32</td>
            </tr>
        </tbody>
    </table>
</body>
</html>
```


### 鼠标悬停高亮行
行高亮效果：通过 :hover 伪类设置当鼠标悬停时高亮显示整行。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>鼠标悬停高亮行示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <h3>鼠标悬停高亮行</h3>
    <table class="table table-hover">
        <thead>
            <tr>
                <th>#</th>
                <th>姓名</th>
                <th>年龄</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>张三</td>
                <td>28</td>
            </tr>
            <tr>
                <td>2</td>
                <td>李四</td>
                <td>32</td>
            </tr>
        </tbody>
    </table>
</body>
</html>

```


### 紧凑型表格
紧凑型表格：减少表格单元格的内边距和行高，适用于显示大量数据。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <title>紧凑型表格示例</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="container">
    <h3>紧凑型表格</h3>
    <table class="table table-sm">
        <thead>
            <tr>
                <th>#</th>
                <th>姓名</th>
                <th>年龄</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>张三</td>
                <td>28</td>
            </tr>
            <tr>
                <td>2</td>
                <td>李四</td>
                <td>32</td>
            </tr>
        </tbody>
    </table>
</body>
</html>

```


### 状态类
表格状态类：为表格行添加不同的状态类（如成功、警告、危险等）来标记不同的状态。

```html
<table class="table">
  <thead>
    <tr>
      <th>#</th>
      <th>Header 1</th>
      <th>Header 2</th>
    </tr>
  </thead>
  <tbody>
    <tr class="table-active">
      <td>1</td>
      <td>Active row</td>
      <td>Cell 2</td>
    </tr>
    <tr class="table-success">
      <td>2</td>
      <td>Success row</td>
      <td>Cell 2</td>
    </tr>
    <tr class="table-danger">
      <td>3</td>
      <td>Danger row</td>
      <td>Cell 2</td>
    </tr>
    <tr class="table-warning">
      <td>4</td>
      <td>Warning row</td>
      <td>Cell 2</td>
    </tr>
    <tr class="table-info">
      <td>5</td>
      <td>Info row</td>
      <td>Cell 2</td>
    </tr>
  </tbody>
</table>
```


### 响应式表格
响应式设计：通过CSS使表格在小屏幕设备上可以水平滚动显示。

```html
<div class="table-responsive">
  <table class="table">
    <thead>
      <tr>
        <th>#</th>
        <th>Header 1</th>
        <th>Header 2</th>
        <th>Header 3</th>
        <th>Header 4</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>Data 1</td>
        <td>Data 2</td>
        <td>Data 3</td>
        <td>Data 4</td>
      </tr>
      <tr>
        <td>2</td>
        <td>Data 5</td>
        <td>Data 6</td>
        <td>Data 7</td>
        <td>Data 8</td>
      </tr>
    </tbody>
  </table>
</div>
```


## 按钮

### 预定义按钮
按钮类：使用 Bootstrap 等框架提供的预定义按钮样式类（如 .btn-primary, .btn-secondary）来快速应用样式。

```html
<button type="button" class="btn btn-primary">Primary</button>
<button type="button" class="btn btn-secondary">Secondary</button>
<button type="button" class="btn btn-success">Success</button>
```


### 按钮尺寸
按钮大小：通过 .btn-lg, .btn-sm 等类调整按钮的尺寸。

```html
<button type="button" class="btn btn-primary btn-lg">Large Button</button>
<button type="button" class="btn btn-primary btn-sm">Small Button</button>
```


### 块级按钮
块级按钮：设置按钮为块级元素（display: block;），并使其占据父容器的全部宽度。

```html
<button type="button" class="btn btn-primary btn-block">Block-level Button</button>
```


### 按钮激活状态
激活状态：使用 .active 类标记按钮的激活状态。

```html
<button type="button" class="btn btn-primary active">Active Button</button>
```


### 按钮禁用状态
禁用状态：通过 disabled 属性或 .disabled 类设置按钮为禁用状态，禁止用户点击。

```html
<button type="button" class="btn btn-primary" disabled>Disabled Button</button>
```


### 按钮标签
标签按钮：在按钮上使用文本、图标或两者结合的标签来提供额外信息或功能提示。

```html
<a class="btn btn-primary" href="#" role="button">Link Button</a>
<button class="btn btn-primary" type="button">Button</button>
```


## 图像

### 响应式图像
响应式图像：使用 max-width: 100%; height: auto; 来确保图像在不同屏幕大小下保持良好的显示效果。

```html
<img src="https://via.placeholder.com/800x400" class="img-fluid" alt="Responsive image">
```


### 图像形状
图像形状：通过添加圆角、圆形或缩放的CSS类（如 .rounded, .rounded-circle）来改变图像的外观。

```html
<img src="https://via.placeholder.com/150" class="img-thumbnail" alt="Thumbnail image">
<img src="https://via.placeholder.com/150" class="rounded" alt="Rounded image">
<img src="https://via.placeholder.com/150" class="rounded-circle" alt="Circular image">
```


## 辅助类

### 情景文本颜色
文本颜色类：使用 `.text-success`, `.text-danger`, `.text-warning` 等类来快速设置文本的颜色。

```html
<p class="text-primary">Primary colored text</p>
<p class="text-secondary">Secondary colored text</p>
```


### 情景文本背景色
背景颜色类：使用 `.bg-primary`, `.bg-success` 等类为文本设置背景颜色。

```html
```


### 关闭按钮
关闭按钮：使用 `.close` 类创建带有×符号的关闭按钮，用于模态框、通知等。

```html
<button type="button" class="close" aria-label="Close">
  <span aria-hidden="true">&times;</span>
</button>
```
### 三角符号
三角符号：通过CSS生成上、下、左、右方向的三角符号，常用于下拉菜单和提示框。
使用 `.caret` 类创建下拉菜单的三角符号。

```html
<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
  Dropdown
  <span class="caret"></span>
</button>

```


### 快速浮动
浮动类：使用 `.float-left`, `.float-right`, `.float-none` 快速实现元素的左右浮动或取消浮动。

```html
<div class="float-left">Float Left</div>
<div class="float-right">Float Right</div>
```


### 块级居中显示
居中类：使用 `.mx-auto` 类将块级元素水平居中。

```html
<div class="mx-auto" style="width: 200px;">Centered block</div>
```


### 清除浮动
清除浮动：使用 `.clearfix` 类清除浮动，确保父元素正确包含浮动的子元素。

```html
<div class="clearfix">
  <div class="float-left">Left float</div>
  <div class="float-right">Right float</div>
</div>
```


### 显示或隐藏
显示控制：使用 `.d-none`, `..d-block`, `.d-inline-block` 等类来控制元素的显示或隐藏，这些类可以根据不同屏幕尺寸应用。

```html
<div class="d-none">This will not be displayed</div>
<div class="d-block">This will be displayed as a block</div>
```


### 屏幕阅读器和键盘焦点
辅助工具类：使用 `.sr-only` 类将元素隐藏但仍可被屏幕阅读器读取；使用 `.focus` 类为键盘焦点元素添加样式。

```html
<p class="sr-only">This text is hidden from view but accessible to screen readers.</p>
```


### 图像替换
图像替换技术：通过 `background-image` 替换文本内容或提供备用的图像，确保在图像加载失败时依然显示合适的内容。

```html
<img src="image.jpg" alt="Visible image">
<img src="image.jpg" class="sr-only" alt="Description for screen readers">
```


## 案例：个人简历

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人简历</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
    <style>
        .profile-header {
            text-align: center;
            margin-top: 20px;
        }
        .profile-header img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
        }
        .section-title {
            margin-top: 20px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
            font-size: 1.5rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile-header">
            <img src="https://via.placeholder.com/150" alt="Profile Picture">
            <h1>张三</h1>
            <p>前端开发工程师</p>
        </div>

        <div class="section-title">个人信息</div>
        <ul class="list-unstyled">
            <li><strong>电话:</strong> 123-456-7890</li>
            <li><strong>邮箱:</strong> zhangsan@example.com</li>
            <li><strong>地址:</strong> 北京市海淀区</li>
        </ul>

        <div class="section-title">教育经历</div>
        <ul class="list-unstyled">
            <li>
                <strong>清华大学</strong> - 计算机科学与技术 (2015 - 2019)
                <p>获得学士学位</p>
            </li>
            <li>
                <strong>北京大学</strong> - 计算机科学硕士 (2019 - 2021)
                <p>获得硕士学位</p>
            </li>
        </ul>

        <div class="section-title">工作经验</div>
        <ul class="list-unstyled">
            <li>
                <strong>某知名互联网公司</strong> - 前端开发工程师 (2021 - 现在)
                <p>负责公司官网的前端开发和维护，使用React和Bootstrap开发响应式网页。</p>
            </li>
            <li>
                <strong>某创业公司</strong> - 实习生 (2020 - 2021)
                <p>参与开发和测试公司内的前端应用，提升了对HTML、CSS和JavaScript的掌握。</p>
            </li>
        </ul>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
    <script src="https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js"></script>
</body>
</html>
```
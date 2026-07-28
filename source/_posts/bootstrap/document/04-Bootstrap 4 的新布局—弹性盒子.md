---
title: "04-Bootstrap 弹性盒子布局（Flexbox）"
date: 2024-08-21T04:00:00+08:00
tags:
    - bootstrap
    - 教程
categories: bootstrap
cover: /images/cover04.png
index_enable: true # 是否显示文章封面
aside_enable: true 
archives_enable: true 
position: both  # 封面显示的位置 三个值可配置left , right , both 
default_cover:   # 当没有设置cover时，默认的封面显示
sticky: false  # 设置为 true 即可置顶
description: "深入掌握 Bootstrap 4/5 的 Flexbox 工具类，包括方向、对齐、伸缩、换行与响应式控制。"
---

## 一、Flexbox 基础概念

### 1.1 什么是 Flexbox

弹性盒子布局（Flexible Box Layout，简称 Flexbox）是 CSS3 引入的一维布局模型。它的核心思想是：在一个容器中，让子元素能够按照设定的规则进行伸缩、排列和对齐，从而适应不同尺寸的屏幕。相比传统的浮动布局（float）和定位布局（position），Flexbox 提供了更直观、更强大的对齐与分布能力。

在 Bootstrap 4 和 Bootstrap 5 中，整个网格系统（Grid System）以及大量组件（如导航栏、按钮组、卡片、表单等）都建立在 Flexbox 之上。因此，掌握 Flexbox 工具类，是熟练使用 Bootstrap 进行现代响应式页面开发的关键一步。

### 1.2 核心术语

在学习 Bootstrap 的 Flexbox 工具类之前，必须先理解以下几个核心概念：

- **Flex 容器（Flex Container）**：被设置为 `display: flex` 或 `display: inline-flex` 的父元素。容器内的直接子元素会按照 Flexbox 规则进行布局。
- **Flex 项目（Flex Item）**：Flex 容器内的直接子元素。只有直接子元素会受 Flexbox 规则影响，孙元素不会。
- **主轴（Main Axis）**：Flex 项目排列的主要方向。默认情况下是水平方向，从左到右。
- **交叉轴（Cross Axis）**：与主轴垂直的方向。默认情况下是垂直方向，从上到下。
- **起始线与结束线**：在 Bootstrap 默认中文页面中，主轴起始端在左侧，结束端在右侧；交叉轴起始端在顶部，结束端在底部。

理解这些术语后，就能更容易地掌握 `justify-content`（主轴对齐）、`align-items`（交叉轴对齐）、`flex-direction`（主轴方向）等属性的含义。

为了更直观地理解主轴与交叉轴，可以想象一个水平排列的导航栏：主轴从左到右贯穿整个导航栏，决定了菜单项的排列顺序；交叉轴从上到下，决定了菜单项在垂直方向上的对齐位置。当你把导航栏改为垂直侧边栏时，主轴就变成了从上到下，交叉轴则变成了从左到右。这种方向的可变性，正是 Flexbox 强大灵活性的来源。

### 1.3 为什么 Bootstrap 选择 Flexbox

Bootstrap 4 是一个重要的版本转折点，它彻底放弃了基于浮动的网格系统，全面拥抱 Flexbox。主要原因包括：

- **更简单的垂直居中**：传统 CSS 中实现垂直居中往往需要多种技巧，而 Flexbox 只需一个 `align-items-center` 类。
- **更灵活的子元素分布**：`justify-content` 和 `align-content` 可以轻松实现等分、两端对齐、居中等常见需求。
- **更好的响应式支持**：通过断点前缀（如 `d-sm-flex`、`justify-content-md-center`），可以快速在不同屏幕尺寸下切换布局行为。
- **代码更简洁**：相比浮动布局需要清除浮动（clearfix），Flexbox 不需要额外处理高度塌陷问题。

### 1.4 Flexbox 与 CSS Grid 的协作关系

在学习 Flexbox 的过程中，初学者常常会把它与 CSS Grid 混淆。简单来说，Flexbox 是一维布局模型，它擅长处理单行或单列的排列问题；而 CSS Grid 是二维布局模型，可以同时控制行和列。两者并不是竞争关系，而是互补关系。

在 Bootstrap 5 中，网格系统底层虽然基于 Flexbox，但它主要解决的是页面大框架的二维排布问题；而 Flexbox 工具类则更适合处理组件内部的对齐与分布。例如，一个卡片列表的整体排列可以用 Grid 实现，而卡片内部标题、描述和按钮的对齐则应使用 Flexbox。理解这种分工，能够帮助你在实际项目中更合理地选择布局方案。

### 1.5 学习路径建议

学习 Bootstrap 的 Flexbox 工具类并不需要一次性记住所有类名。建议按照以下顺序逐步掌握：首先是启用 Flex 布局的 `.d-flex` 和 `.d-inline-flex`；其次是控制方向的 `.flex-row` 和 `.flex-column`；然后是对齐相关的 `.justify-content-*` 和 `.align-items-*`；最后是换行、伸缩和排序类。每学完一个类，都应在浏览器中实际运行示例代码，观察不同屏幕尺寸下的表现，这样记忆会更加深刻。

## 二、启用 Flex 布局

### 2.1 概念说明

在 Bootstrap 中，使用 `.d-flex` 或 `.d-inline-flex` 类即可将任意 HTML 元素设置为 Flex 容器。两者的区别在于：

- `.d-flex`：将元素设置为块级弹性容器，独占一行，宽度默认填满父容器。
- `.d-inline-flex`：将元素设置为行内弹性容器，宽度由内容决定，可以与其他行内元素并排显示。

一旦应用了这两个类之一，该元素的所有直接子元素就会自动成为 Flex 项目。

### 2.2 使用场景

- 当你希望一个父元素内部的子元素水平或垂直排列，并且需要精确控制对齐方式时，使用 `.d-flex`。
- 当你需要在一段文本或其他行内内容中插入一个弹性布局小区域，而不希望它独占一行时，使用 `.d-inline-flex`。

### 2.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>启用 Flex 布局</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">
    <h3 class="mb-4">块级 Flex 容器：d-flex</h3>
    <div class="d-flex p-3 bg-warning text-white rounded mb-4">
        <div class="p-2 bg-primary">Flex 项目 1</div>
        <div class="p-2 bg-success">Flex 项目 2</div>
        <div class="p-2 bg-danger">Flex 项目 3</div>
    </div>

    <h3 class="mb-4">行内 Flex 容器：d-inline-flex</h3>
    <div class="d-inline-flex p-3 bg-info text-white rounded me-2">
        <div class="p-2 bg-primary">行内 1</div>
        <div class="p-2 bg-success">行内 2</div>
    </div>
    <div class="d-inline-flex p-3 bg-info text-white rounded">
        <div class="p-2 bg-primary">行内 A</div>
        <div class="p-2 bg-success">行内 B</div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 2.4 效果解析

在上面的示例中，第一个容器使用了 `.d-flex`，因此黄色背景容器会独占一整行，三个子元素沿主轴（默认水平方向）依次排列。第二个和第三个容器使用了 `.d-inline-flex`，它们的宽度由内容决定，因此可以并排显示在同一行中。每个子元素由于成为 Flex 项目，会按照内容自动计算宽度，并且默认不会换行。

需要注意的是，`.d-flex` 只是开启 Flex 布局的入口，它本身不会改变元素的尺寸计算方式。如果你发现某个容器没有按预期排列，首先应检查是否正确添加了 `.d-flex` 或 `.d-inline-flex`。此外，只有直接子元素会成为 Flex 项目，孙元素不会自动继承 Flex 属性，这一点在嵌套布局中尤为重要。

## 三、主轴方向

### 3.1 概念说明

主轴方向决定了 Flex 项目的排列方向。Bootstrap 提供了以下四个方向类：

- `.flex-row`：默认值，项目沿水平方向从左到右排列。
- `.flex-row-reverse`：项目沿水平方向从右到左排列。
- `.flex-column`：项目沿垂直方向从上到下排列。
- `.flex-column-reverse`：项目沿垂直方向从下到上排列。

当方向为 `row` 时，主轴是水平的；当方向为 `column` 时，主轴是垂直的。这意味着 `justify-content` 在 row 模式下控制水平对齐，在 column 模式下控制垂直对齐。

### 3.2 使用场景

- 水平导航菜单、按钮组、卡片列表通常使用 `.flex-row`。
- 侧边栏的垂直菜单、步骤条、表单的垂直堆叠通常使用 `.flex-column`。
- 需要反转显示顺序但又不想改动 HTML 结构时，使用 `.flex-row-reverse` 或 `.flex-column-reverse`。

### 3.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>主轴方向</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">
    <h4>flex-row（从左到右）</h4>
    <div class="d-flex flex-row p-3 bg-warning text-white rounded mb-3">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
    </div>

    <h4>flex-row-reverse（从右到左）</h4>
    <div class="d-flex flex-row-reverse p-3 bg-warning text-white rounded mb-3">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
    </div>

    <h4>flex-column（从上到下）</h4>
    <div class="d-flex flex-column p-3 bg-warning text-white rounded mb-3">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
    </div>

    <h4>flex-column-reverse（从下到上）</h4>
    <div class="d-flex flex-column-reverse p-3 bg-warning text-white rounded">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 3.4 效果解析

在 `.flex-row` 中，三个子元素按照 HTML 中的书写顺序从左到右排列。在 `.flex-row-reverse` 中，虽然 HTML 结构没有变化，但视觉上项目 3 在最左侧，项目 1 在最右侧。在 `.flex-column` 中，三个子元素垂直堆叠，容器高度由内容决定。在 `.flex-column-reverse` 中，项目 3 显示在最上方，项目 1 显示在最下方。这种反转能力非常适合需要同时支持从左到右和从右到左语言（LTR/RTL）的国际化项目。

需要特别注意的是，当主轴方向变为 `.flex-column` 时，`justify-content-*` 控制的是垂直方向上的对齐，而 `align-items-*` 控制的是水平方向上的对齐。很多初学者会在方向改变后混淆这两个属性的作用，因此在使用过程中要时刻明确当前的主轴方向。

## 四、主轴对齐 justify-content

### 4.1 概念说明

`justify-content` 用于控制 Flex 项目在主轴上的对齐方式和空间分布。Bootstrap 提供了以下工具类：

- `.justify-content-start`：项目向主轴起始端对齐。
- `.justify-content-end`：项目向主轴结束端对齐。
- `.justify-content-center`：项目在主轴上居中对齐。
- `.justify-content-between`：项目均匀分布，首尾项目紧贴容器两端，中间项目等分剩余空间。
- `.justify-content-around`：每个项目两侧都有相等的外边距空间，因此两端空间是中间空间的一半。
- `.justify-content-evenly`：项目之间以及项目与容器边缘之间的空间完全相等。

### 4.2 使用场景

- 导航栏中 logo 靠左、菜单靠右，可以使用 `.justify-content-between`。
- 页面标题或按钮组需要水平居中，可以使用 `.justify-content-center`。
- 表单中的操作按钮需要右对齐，可以使用 `.justify-content-end`。
- 卡片底部需要等宽分布多个操作按钮，可以使用 `.justify-content-around` 或 `.justify-content-evenly`。

### 4.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>主轴对齐</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">
    <h4>justify-content-start</h4>
    <div class="d-flex justify-content-start mb-3 bg-warning text-white rounded">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
    </div>

    <h4>justify-content-center</h4>
    <div class="d-flex justify-content-center mb-3 bg-warning text-white rounded">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
    </div>

    <h4>justify-content-end</h4>
    <div class="d-flex justify-content-end mb-3 bg-warning text-white rounded">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
    </div>

    <h4>justify-content-between</h4>
    <div class="d-flex justify-content-between mb-3 bg-warning text-white rounded">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
    </div>

    <h4>justify-content-around</h4>
    <div class="d-flex justify-content-around mb-3 bg-warning text-white rounded">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
    </div>

    <h4>justify-content-evenly</h4>
    <div class="d-flex justify-content-evenly bg-warning text-white rounded">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 4.4 效果解析

`.justify-content-start` 下三个项目聚集在容器左侧，右侧留下大量空白。`.justify-content-center` 下三个项目在容器中间集中显示。`.justify-content-end` 下三个项目靠右对齐。`.justify-content-between` 下项目 1 紧贴左边缘，项目 3 紧贴右边缘，项目 2 正好位于中间。`.justify-content-around` 下每个项目左右都有相同的空白，因此最左侧和最右侧的空白只有中间空白的一半。`.justify-content-evenly` 下所有间隔完全相等，包括两端与边缘的距离。

在实际项目中，`.justify-content-between` 常用于导航栏，让 Logo 和菜单分别位于两端；`.justify-content-center` 常用于分页、模态框底部按钮等需要突出居中的场景；`.justify-content-evenly` 则适合按钮组或工具栏，让每个操作按钮都有均匀的呼吸空间。

## 五、交叉轴对齐 align-items 与 align-self

### 5.1 概念说明

`align-items` 用于控制所有 Flex 项目在交叉轴上的对齐方式。Bootstrap 提供的类包括：

- `.align-items-start`：项目向交叉轴起始端对齐。
- `.align-items-end`：项目向交叉轴结束端对齐。
- `.align-items-center`：项目在交叉轴上居中对齐。
- `.align-items-baseline`：项目按照文本基线对齐。
- `.align-items-stretch`：默认值，项目在交叉轴方向上拉伸以填满容器。

`align-self` 则用于覆盖单个项目的交叉轴对齐方式，优先级高于 `align-items`。可用的类与 `align-items` 类似，包括 `.align-self-start`、`.align-self-end`、`.align-self-center`、`.align-self-baseline`、`.align-self-stretch`。

### 5.2 使用场景

- 需要让一个卡片组中的所有卡片高度一致时，使用 `.align-items-stretch`。
- 需要在一个行内将某个按钮或图标垂直居中时，使用 `.align-items-center`。
- 需要让列表中的某一项单独置顶或置底时，使用 `.align-self-start` 或 `.align-self-end`。

### 5.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>交叉轴对齐</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .box { height: 120px; }
    </style>
</head>
<body class="container py-5">
    <h4>align-items-start</h4>
    <div class="d-flex align-items-start box mb-3 bg-warning text-white rounded">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
    </div>

    <h4>align-items-center</h4>
    <div class="d-flex align-items-center box mb-3 bg-warning text-white rounded">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
    </div>

    <h4>align-items-end</h4>
    <div class="d-flex align-items-end box mb-3 bg-warning text-white rounded">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
    </div>

    <h4>align-items-stretch</h4>
    <div class="d-flex align-items-stretch box mb-3 bg-warning text-white rounded">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
    </div>

    <h4>align-self 单独控制</h4>
    <div class="d-flex align-items-center box bg-warning text-white rounded">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success align-self-start">置顶</div>
        <div class="p-2 bg-danger align-self-end">置底</div>
        <div class="p-2 bg-info align-self-stretch">拉伸</div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 5.4 效果解析

由于容器设置了固定高度 `120px`，`.align-items-start` 下所有项目都位于黄色容器的顶部。`.align-items-center` 下所有项目在垂直方向上居中。`.align-items-end` 下所有项目位于底部。`.align-items-stretch` 下所有项目会拉伸到与容器相同的高度。在 `align-self` 的示例中，虽然父容器设置了 `.align-items-center`，但通过为不同子元素单独设置 `.align-self-start`、`.align-self-end`、`.align-self-stretch`，可以让它们脱离父级的对齐控制，实现更精细的布局效果。

`.align-items-baseline` 是一个比较特殊但实用的类，它会让所有项目按照文本基线对齐。当你在一行中混合显示不同字体大小或不同高度的元素时，使用基线对齐可以让文本底部保持在同一水平线上，避免出现视觉上的上下错位。

## 六、换行与内容对齐 align-content

### 6.1 概念说明

当 Flex 容器的主轴空间不足以容纳所有项目时，默认情况下项目会挤压在一行（或一列）中，不会自动换行。通过 `.flex-wrap` 类可以控制换行行为：

- `.flex-nowrap`：默认值，不换行。
- `.flex-wrap`：允许换行，项目按照主轴方向依次排列，超出后换到下一行。
- `.flex-wrap-reverse`：允许换行，但新行排列在旧行的上方。

当容器内存在多行（或多列）时，`align-content` 用于控制这些行（或列）在交叉轴上的分布方式。Bootstrap 提供的类包括：

- `.align-content-start`：多行向交叉轴起始端靠拢。
- `.align-content-end`：多行向交叉轴结束端靠拢。
- `.align-content-center`：多行在交叉轴上居中。
- `.align-content-between`：第一行置顶，最后一行置底，中间行均匀分布。
- `.align-content-around`：每行两侧都有相等的空白。
- `.align-content-stretch`：默认值，行拉伸以填满容器。

### 6.2 使用场景

- 商品列表、图片画廊需要在空间不足时自动换行，使用 `.flex-wrap`。
- 需要实现瀑布流或标签云效果时，使用 `.flex-wrap` 配合 `.justify-content-*`。
- 多行卡片布局需要在容器内垂直居中或等距分布时，使用 `.align-content-center` 或 `.align-content-between`。

### 6.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>换行与内容对齐</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">
    <h4>flex-wrap（自动换行）</h4>
    <div class="d-flex flex-wrap bg-warning text-white rounded mb-4" style="width: 300px;">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
        <div class="p-2 bg-info">项目 4</div>
        <div class="p-2 bg-dark">项目 5</div>
        <div class="p-2 bg-secondary">项目 6</div>
    </div>

    <h4>align-content-between</h4>
    <div class="d-flex flex-wrap align-content-between bg-warning text-white rounded mb-4" style="width: 300px; height: 200px;">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
        <div class="p-2 bg-info">项目 4</div>
        <div class="p-2 bg-dark">项目 5</div>
        <div class="p-2 bg-secondary">项目 6</div>
    </div>

    <h4>align-content-around</h4>
    <div class="d-flex flex-wrap align-content-around bg-warning text-white rounded" style="width: 300px; height: 200px;">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
        <div class="p-2 bg-info">项目 4</div>
        <div class="p-2 bg-dark">项目 5</div>
        <div class="p-2 bg-secondary">项目 6</div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 6.4 效果解析

在 `.flex-wrap` 示例中，容器宽度被限制为 `300px`，当六个项目无法在一行内完整显示时，会自动换到下一行。在 `.align-content-between` 示例中，由于容器高度固定为 `200px`，多行内容会垂直分布，第一行靠近顶部，最后一行靠近底部，中间行均匀分布剩余空间。`.align-content-around` 则让每行上下都有相等的空白，整体视觉上更加松散均匀。

另外，`.flex-wrap-reverse` 与 `.flex-wrap` 的区别在于新行的生成位置。使用 `.flex-wrap-reverse` 时，如果项目换行，新行会出现在旧行的上方，而不是下方。这个类在一些特殊的倒序瀑布流或聊天消息列表中可能会用到，但在常规布局中较少使用。

## 七、伸缩行为 flex-fill、grow、shrink

### 7.1 概念说明

Flexbox 的伸缩能力是其最强大的特性之一。Bootstrap 提供了以下工具类来控制项目的伸缩行为：

- `.flex-fill`：让所有设置了该类的项目均分容器的可用空间，相当于 `flex: 1 1 auto`。
- `.flex-grow-1`：项目在有剩余空间时会增长，占据尽可能多的空间。
- `.flex-grow-0`：默认值，项目不会主动增长。
- `.flex-shrink-1`：项目在空间不足时会收缩。
- `.flex-shrink-0`：项目不会收缩，即使空间不足也会保持原始大小。

理解这三个属性的关系非常重要：`flex-grow` 控制增长比例，`flex-shrink` 控制收缩比例，`flex-basis` 控制项目的基础大小。Bootstrap 的工具类是对这些原生属性的封装。

### 7.2 使用场景

- 标签页或按钮组需要等宽显示时，使用 `.flex-fill`。
- 希望某个侧边栏占据剩余空间而主内容保持固定宽度时，使用 `.flex-grow-1`。
- 希望某个图标或徽标不被压缩时，使用 `.flex-shrink-0`。

### 7.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>伸缩行为</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">
    <h4>flex-fill（等分剩余空间）</h4>
    <div class="d-flex bg-warning text-white rounded mb-4">
        <div class="flex-fill p-2 bg-primary">项目 1</div>
        <div class="flex-fill p-2 bg-success">项目 2</div>
        <div class="flex-fill p-2 bg-danger">项目 3</div>
    </div>

    <h4>flex-grow-1（某项目占据剩余空间）</h4>
    <div class="d-flex bg-warning text-white rounded mb-4">
        <div class="p-2 bg-primary">固定</div>
        <div class="p-2 flex-grow-1 bg-success">我会占据剩余空间</div>
        <div class="p-2 bg-danger">固定</div>
    </div>

    <h4>flex-shrink-0（禁止收缩）</h4>
    <div class="d-flex bg-warning text-white rounded" style="width: 200px;">
        <div class="p-2 flex-shrink-0 bg-primary" style="width: 150px;">我不收缩</div>
        <div class="p-2 bg-success">我会被压缩</div>
        <div class="p-2 bg-danger">我会被压缩</div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 7.4 效果解析

在 `.flex-fill` 示例中，三个项目会均分黄色容器的整个宽度，每个项目占据三分之一。在 `.flex-grow-1` 示例中，中间的项目会占据左右两个固定宽度项目之外的所有剩余空间，因此它会随着容器宽度变化而动态调整。在 `.flex-shrink-0` 示例中，容器宽度只有 `200px`，第一个项目设置了固定宽度 `150px` 并且禁止收缩，因此它会保持 `150px` 的宽度，而另外两个项目会被压缩到仅剩的内容空间。

这三个类的本质是对 `flex` 属性的封装。`.flex-fill` 实际上是 `flex: 1 1 auto`，表示项目可以增长也可以收缩，基础大小由内容决定。`.flex-grow-1` 是 `flex-grow: 1`，而 `.flex-shrink-0` 是 `flex-shrink: 0`。理解这些原生属性的含义，有助于你在 Bootstrap 工具类无法满足需求时，编写自定义的 CSS 进行补充。

## 八、排序 order

### 8.1 概念说明

`order` 属性允许我们改变 Flex 项目的视觉顺序，而不需要修改 HTML 结构。Bootstrap 提供了 `.order-*` 类，其中 `*` 可以是 `0` 到 `5` 的数字，还可以使用 `.order-first` 和 `.order-last`。

默认情况下，所有 Flex 项目的 `order` 值为 `0`，按照 HTML 中的书写顺序显示。数字越小，排列越靠前；数字越大，排列越靠后。`.order-first` 等价于 `order: -1`，`.order-last` 等价于 `order: 6`。

### 8.2 使用场景

- 在响应式布局中，移动端和桌面端需要不同的内容顺序时，使用 `.order-*` 配合断点前缀。
- 需要临时调整某个模块的显示优先级，但不想改变 DOM 结构时，使用 `.order-first` 或 `.order-last`。
- 实现新闻列表、商品详情页中不同屏幕下的图文交替布局。

### 8.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>排序 order</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">
    <h4>默认顺序</h4>
    <div class="d-flex bg-warning text-white rounded mb-4">
        <div class="p-2 bg-primary">HTML 第一</div>
        <div class="p-2 bg-success">HTML 第二</div>
        <div class="p-2 bg-danger">HTML 第三</div>
    </div>

    <h4>使用 order 调整顺序</h4>
    <div class="d-flex bg-warning text-white rounded mb-4">
        <div class="p-2 bg-primary order-3">HTML 第一，视觉第三</div>
        <div class="p-2 bg-success order-1">HTML 第二，视觉第一</div>
        <div class="p-2 bg-danger order-2">HTML 第三，视觉第二</div>
    </div>

    <h4>order-first 与 order-last</h4>
    <div class="d-flex bg-warning text-white rounded">
        <div class="p-2 bg-primary">默认</div>
        <div class="p-2 bg-success order-last">我到最后</div>
        <div class="p-2 bg-danger order-first">我到最前</div>
        <div class="p-2 bg-info">默认</div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 8.4 效果解析

在默认顺序示例中，三个项目按照 HTML 书写顺序依次显示。在第二个示例中，虽然 HTML 中第一个 div 是蓝色项目，但由于它设置了 `.order-3`，它会显示在第三位；绿色项目设置了 `.order-1`，显示在第一位；红色项目设置了 `.order-2`，显示在第二位。在第三个示例中，红色项目设置了 `.order-first`，因此它会被排到最前面；绿色项目设置了 `.order-last`，因此它会被排到最后面。

`order` 类也支持响应式断点前缀，例如 `.order-md-2`、`.order-lg-last`。这在图文混排布局中非常实用：在移动端可能希望图片位于文字上方，而在桌面端则希望图片位于文字左侧或右侧。通过响应式排序类，同一套 HTML 结构可以呈现完全不同的视觉层级。需要注意的是，`order` 只影响视觉顺序，不影响屏幕阅读器等辅助技术的读取顺序，因此不要用它来做语义化结构的替代方案。

## 九、响应式 Flexbox 类

### 9.1 概念说明

Bootstrap 的 Flexbox 工具类几乎都支持响应式断点前缀。可用的断点包括：

- `sm`：屏幕宽度大于等于 `576px`。
- `md`：屏幕宽度大于等于 `768px`。
- `lg`：屏幕宽度大于等于 `992px`。
- `xl`：屏幕宽度大于等于 `1200px`。
- `xxl`：屏幕宽度大于等于 `1400px`。

类的命名规则是：在基础类名前加上断点前缀和连字符。例如 `.justify-content-sm-center`、`.align-items-md-end`、`.flex-lg-row`、`.d-xl-flex` 等。没有断点前缀的类会在所有屏幕尺寸下生效，而带断点前缀的类只会在对应断点及以上生效。

Bootstrap 采用的是移动优先（Mobile First）的设计策略。这意味着你应该先为最小的屏幕编写基础样式，然后通过断点前缀逐步增强大屏幕下的布局表现。例如，`.flex-column flex-md-row` 表示默认情况下项目垂直排列，当屏幕宽度达到 `768px` 及以上时才切换为水平排列。这种从下到上的覆盖方式，可以让页面在各类设备上都获得良好的体验。

### 9.2 使用场景

- 移动端将导航项垂直堆叠，桌面端水平排列：`.flex-column flex-md-row`。
- 小屏幕下项目左对齐，大屏幕下居中：`.justify-content-start justify-content-md-center`。
- 移动端隐藏某个 Flex 容器，桌面端显示：`.d-none d-lg-flex`。

### 9.3 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>响应式 Flexbox</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">
    <h4>移动端垂直堆叠，桌面端水平排列</h4>
    <div class="d-flex flex-column flex-md-row bg-warning text-white rounded mb-4 p-2">
        <div class="p-2 bg-primary">首页</div>
        <div class="p-2 bg-success">产品</div>
        <div class="p-2 bg-danger">关于我们</div>
        <div class="p-2 bg-info">联系我们</div>
    </div>

    <h4>小屏幕左对齐，大屏幕居中</h4>
    <div class="d-flex justify-content-start justify-content-md-center bg-warning text-white rounded mb-4 p-2">
        <div class="p-2 bg-primary">项目 1</div>
        <div class="p-2 bg-success">项目 2</div>
        <div class="p-2 bg-danger">项目 3</div>
    </div>

    <h4>大屏幕才显示 Flex 容器</h4>
    <div class="d-none d-lg-flex bg-warning text-white rounded p-2">
        <div class="p-2 bg-primary">仅在大屏显示</div>
        <div class="p-2 bg-success">仅在大屏显示</div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 9.4 效果解析

在第一个示例中，`.flex-column` 使导航项在移动端垂直堆叠，而 `.flex-md-row` 在屏幕宽度达到 `768px` 及以上时使导航项水平排列。在第二个示例中，小屏幕下项目靠左对齐，达到中等屏幕宽度后自动变为居中对齐。在第三个示例中，`.d-none` 使容器默认隐藏，`.d-lg-flex` 在屏幕宽度达到 `992px` 及以上时才将其显示为 Flex 容器。这种响应式能力让同一套 HTML 结构可以适配手机、平板、笔记本和桌面显示器等多种设备。

响应式 Flexbox 类的组合非常灵活。例如，`.d-flex flex-column flex-md-row justify-content-center justify-content-md-between align-items-center` 这样一串类名，就能够同时控制容器在不同屏幕尺寸下的显示方式、方向、主轴对齐和交叉轴对齐。熟练掌握这些组合，可以让你在不编写任何自定义 CSS 的情况下完成大部分常见布局。

## 十、实战：响应式页头布局

### 10.1 场景描述

接下来通过一个完整的响应式页头布局案例，综合运用前面所学的 Flexbox 知识。该页头包含：左侧的 Logo、中间的导航菜单、右侧的用户操作按钮。在移动端，导航菜单垂直堆叠并居中显示；在桌面端，导航菜单水平排列，并通过 `.justify-content-between` 实现两端对齐。

### 10.2 完整 HTML 示例

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>响应式页头布局实战</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .header {
            min-height: 70px;
        }
    </style>
</head>
<body>
    <header class="container-fluid bg-light border-bottom">
        <div class="container">
            <div class="d-flex flex-column flex-md-row align-items-center justify-content-between header py-3">
                <!-- Logo -->
                <a href="#" class="d-flex align-items-center mb-3 mb-md-0 text-decoration-none">
                    <span class="fs-4 fw-bold text-primary">MyBrand</span>
                </a>

                <!-- 导航菜单 -->
                <nav class="d-flex flex-column flex-md-row align-items-center">
                    <a href="#" class="px-3 py-2 text-dark text-decoration-none">首页</a>
                    <a href="#" class="px-3 py-2 text-dark text-decoration-none">产品</a>
                    <a href="#" class="px-3 py-2 text-dark text-decoration-none">服务</a>
                    <a href="#" class="px-3 py-2 text-dark text-decoration-none">关于我们</a>
                </nav>

                <!-- 用户操作 -->
                <div class="d-flex flex-column flex-md-row align-items-center mt-3 mt-md-0">
                    <button class="btn btn-outline-primary me-md-2 mb-2 mb-md-0">登录</button>
                    <button class="btn btn-primary">注册</button>
                </div>
            </div>
        </div>
    </header>

    <main class="container py-5">
        <h1>欢迎来到 MyBrand</h1>
        <p class="lead">这是一个使用 Bootstrap 5 Flexbox 工具类构建的响应式页头示例。</p>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### 10.3 效果解析

在这个页头布局中，最外层容器使用了 `.d-flex` 开启 Flex 布局，并通过 `.flex-column flex-md-row` 实现移动端的垂直排列和桌面端的水平排列。`.align-items-center` 让所有子元素在交叉轴上居中对齐，确保 Logo、导航和按钮在桌面端高度一致。

`.justify-content-between` 将 Logo、导航和用户操作三部分在主轴上均匀分布：Logo 靠左，用户操作靠右，导航大致位于中间。为了避免移动端三个区域紧挨在一起，我们为 Logo 和用户操作区域分别添加了 `.mb-3 mb-md-0` 和 `.mt-3 mt-md-0`，使它们在移动端有适当的垂直间距，而在桌面端取消这些间距。

按钮组使用了 `.d-flex flex-column flex-md-row`，使登录和注册按钮在移动端垂直堆叠，在桌面端水平排列。`.me-md-2` 为桌面端的登录按钮添加了右侧外边距，而 `.mb-2 mb-md-0` 为移动端添加了底部外边距。

通过这个案例可以看到，Flexbox 工具类不仅可以单独使用，更可以组合起来解决真实项目中的复杂布局问题。你只需要记住几个核心类名，就能快速搭建出适配多种屏幕的界面结构。在实际开发中，建议先手绘出移动端和桌面端的布局草图，再决定每个断点下需要使用哪些 Flexbox 类，这样可以大大提高编码效率。

## 十一、本章小结

本章系统地介绍了 Bootstrap 4/5 中 Flexbox 工具类的核心概念与实际应用。主要内容包括：

- **Flexbox 基础概念**：理解了 Flex 容器、Flex 项目、主轴和交叉轴的区别，以及 Bootstrap 选择 Flexbox 作为布局基础的原因。
- **启用 Flex 布局**：通过 `.d-flex` 和 `.d-inline-flex` 将元素设置为弹性容器。
- **主轴方向**：使用 `.flex-row`、`.flex-row-reverse`、`.flex-column`、`.flex-column-reverse` 控制项目的排列方向。
- **主轴对齐**：使用 `.justify-content-*` 系列类控制项目在主轴上的分布方式。
- **交叉轴对齐**：使用 `.align-items-*` 控制整体交叉轴对齐，使用 `.align-self-*` 单独控制某个项目。
- **换行与内容对齐**：使用 `.flex-wrap` 控制换行，使用 `.align-content-*` 控制多行内容的分布。
- **伸缩行为**：使用 `.flex-fill`、`.flex-grow-*`、`.flex-shrink-*` 控制项目的伸缩能力。
- **排序**：使用 `.order-*`、`.order-first`、`.order-last` 调整项目的视觉顺序。
- **响应式 Flexbox 类**：通过断点前缀实现不同屏幕尺寸下的布局切换。
- **实战案例**：通过响应式页头布局，将多个 Flexbox 工具类组合使用，实现了一个可在手机和桌面端自适应的页面头部。

掌握这些工具类后，你可以高效地构建导航栏、卡片列表、表单布局、商品展示、侧边栏等常见前端组件。Flexbox 不仅是 Bootstrap 的核心布局技术，也是现代 CSS 开发中不可或缺的技能。

在学习过程中，建议读者遵循以下实践步骤：首先，熟记 `d-flex`、`justify-content-*`、`align-items-*`、`flex-wrap` 这几个最常用的类名；其次，通过浏览器开发者工具实时调整类名，观察布局变化；最后，尝试将多个类组合使用，完成一个完整的响应式组件。只有经过大量动手实践，才能真正做到灵活运用 Flexbox 工具类，写出既优雅又高效的响应式页面。

建议读者将本章的示例复制到本地进行实验，通过调整类名和窗口大小，深入理解每个工具类的实际效果。

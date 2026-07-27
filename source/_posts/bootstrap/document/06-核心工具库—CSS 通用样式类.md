---
title: 06-核心工具库—CSS 通用样式类
date: 2024-08-19T11:02:23+08:00
tags:
    - bootstrap
    - 教程
categories: bootstrap
cover:  https://bing997.github.io/LW-blog/images/cover06.png
index_enable: true # 是否显示文章封面
aside_enable: true 
archives_enable: true 
position: both  # 封面显示的位置 三个值可配置left , right , both 
default_cover:   # 当没有设置cover时，默认的封面显示
sticky: false  # 设置为 true 即可置顶
description: "bootstrap"
---

## CSS 通用样式类
### 文本处理

#### 文本对齐
通过 `.text-left`、`.text-center`、`.text-right` 和 `.text-justify` 类可以轻松控制文本的对齐方式。

```html
<p class="text-left">左对齐文本</p>
<p class="text-center">居中对齐文本</p>
<p class="text-right">右对齐文本</p>
<p class="text-justify">两端对齐文本</p>
```

#### 文本换行
使用 `.text-nowrap` 类防止文本换行，超出部分会出现滚动条。

```html
<p class="text-nowrap">这是一段不会自动换行的长文本。</p>
```

#### 粗细和斜体
使用`.font-weight-bold` 和 `.font-italic` 类分别实现加粗和斜体效果。

```html
<p class="font-weight-bold">这段文本是加粗的。</p>
<p class="font-italic">这段文本是斜体的。</p>
```

#### 其他一些文本类
Bootstrap 还提供了其他文本样式类，如 `.small` 用于缩小文本，`.mark` 用于标记文本等。

```html
<p class="small">这是缩小的文本。</p>
<p><mark>这段文本被标记了。</mark></p>
```

### 颜色

#### 文本颜色
使用 `.text-primary`、`.text-secondary`、`.text-success`、`.text-danger`、`.text-warning`、`.text-info`、`.text-light`、`.text-dark` 和 `.text-muted` 类来设置文本的颜色。

```html
<p class="text-primary">蓝色文本</p>
<p class="text-danger">红色文本</p>
<p class="text-success">绿色文本</p>
```


#### 链接文本颜色
使用 `.link-primary`、`.link-secondary` 等类来设置链接的文本颜色，同时保留链接的默认样式。

```html
<a href="#" class="link-primary">蓝色链接</a>
<a href="#" class="link-danger">红色链接</a>
```


#### 背景颜色
使用 `.bg-primary`、`.bg-secondary`、`.bg-success`、`.bg-danger`、`.bg-warning`、`.bg-info`、`.bg-light`、`.bg-dark` 和 `.bg-white` 类来设置元素的背景颜色。

```html
<div class="bg-primary text-white">蓝色背景</div>
<div class="bg-danger text-white">红色背景</div>
```

### 边框
#### 添加边框
使用 `.border` 类可以快速为元素添加边框，结合 `.border-top`、`.border-right`、`.border-bottom` 和 `.border-left` 可以单独控制某一边的边框。

```html
<div class="border">完整边框</div>
<div class="border-top">仅顶部边框</div>
```


#### 边框颜色
使用 `.border-primary`、`.border-secondary`、`.border-success`、`.border-danger` 等类可以为边框设置不同颜色。

```html
<div class="border border-primary">蓝色边框</div>
<div class="border border-danger">红色边框</div>
```


#### 圆角边框
用 `.rounded` 类来添加圆角，结合 `.rounded-sm`、`.rounded-lg` 可以设置不同的圆角大小。使用 `.rounded-circle` 可实现圆形边框，`.rounded-0` 则可以移除圆角。

```html
<div class="rounded">默认圆角</div>
<div class="rounded-circle">圆形边框</div>
<div class="rounded-0">无圆角</div>
```


### 宽度和高度

#### 相对于父元素
使用 `.w-25`、`.w-50`、`.w-75` 和 `.w-100` 来设置元素相对于父元素宽度的百分比，同样的 `.h-25`、`.h-50`、`.h-75` 和 `.h-100` 用于设置高度。

```html
<div class="w-50">相对于父元素50%宽度</div>
```

#### 相对于视口
使用 `.vw-100` 设置元素宽度为视口的 100%，同样的 `.vh-100` 用于设置高度。

```html
<div class="vh-100">占据整个视口高度</div>
```


### 边距
#### 边距的定义
使用 `.m-*` 类可以设置元素的外边距（margin），如 `.m-0` (无外边距), `.mt-3` (上边距 1rem), `.mx-auto` (水平居中) 等。

```html
<div class="m-3">四周边距1rem</div>
```


#### 响应式边距
使用响应式边距类，如 `.mt-md-5`，可以根据屏幕尺寸动态调整边距。

```html
<div class="mt-md-5">在中等及以上屏幕上有5rem上边距</div>
```

### 浮动
#### 实现浮动
使用 `.float-left`、`.float-right` 和 `.float-none` 类可以控制元素的浮动行为。

```html
<div class="float-left">左浮动</div>
<div class="float-right">右浮动</div>
```

#### 响应式浮动
使用响应式浮动类，如 `.float-md-right`，可以根据屏幕尺寸动态调整浮动方向。

```html
<div class="float-md-right">在中等及以上屏幕上右浮动</div>
```

### display 属性类
#### 实现display 属性
使用 `.d-block`、`.d-inline-block`、`.d-inline` 等类来控制元素的 display 属性。

```html
<span class="d-block">块级元素</span>
<span class="d-inline">内联元素</span>
```

#### 响应式的隐藏或显示元素
使用 `.d-none` 可以隐藏元素，并结合响应式类如 `.d-md-block`，可以根据屏幕尺寸控制元素的显示与隐藏。

```html
<div class="d-none d-md-block">仅在中等及以上屏幕上显示</div>
```


### 嵌入
使用 `.embed-responsive` 类和相应的子类（如 `.embed-responsive-16by9`）可以创建响应式的嵌入式内容，比如视频。

```html
<div class="embed-responsive embed-responsive-16by9">
  <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/your-video-id" allowfullscreen></iframe>
</div>
```


### 内容溢出
使用 `.text-truncate` 类可以使溢出的文本显示省略号（…），结合 `.overflow-auto`、`.overflow-hidden` 等类可以控制元素的溢出行为。

```html
<div class="text-truncate" style="width: 150px;">这是一个非常长的文本，将会被截断。</div>
```

### 定位
用 `.position-static`、`.position-relative`、`.position-absolute`、`.position-fixed` 和 `.position-sticky` 类来控制元素的定位方式。

```html
<div class="position-fixed" style="top: 0; right: 0;">固定在右上角的元素</div>
```

### 阴影
使用 `.shadow-sm`、`.shadow` 和 `.shadow-lg` 类可以为元素添加不同大小的阴影效果

```html
<div class="shadow-lg p-3 mb-5 bg-white rounded">大阴影效果</div>
```

### 关闭图标
使用 `.close` 类可以创建关闭图标，通常用于模态框或提示框的关闭按钮。

```html
<button type="button" class="close" aria-label="Close">
  <span aria-hidden="true">&times;</span>
</button>
```

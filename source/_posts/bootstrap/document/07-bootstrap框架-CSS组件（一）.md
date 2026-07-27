---
title: 07-bootstrap框架-CSS组件（一）
date: 2024-08-19T14:54:11+08:00
tags:
    - bootstrap
    - 教程
categories: bootstrap
cover:  https://bing997.github.io/LW-blog/images/cover07.png
index_enable: true # 是否显示文章封面
aside_enable: true 
archives_enable: true 
position: both  # 封面显示的位置 三个值可配置left , right , both 
default_cover:   # 当没有设置cover时，默认的封面显示
sticky: false  # 设置为 true 即可置顶
description: "bootstrap"
---
## CSS组件（一）

### 字体图标

#### 可用的字体图标
在Bootstrap中，使用字体图标是一种常见的方式来添加图标而无需使用图像文件。这些图标通常来自像 Font Awesome 这样的图标库，或者是自定义的图标集

#### 使用字体图标
使用 `<i>` 或 `<span>` 标签并添加相应的类名，如 `fa fa-icon-name` 或 `glyphicon glyphicon-icon-name`。

> 代码示例
```html
<i class="fa fa-home"></i> Home
<span class="glyphicon glyphicon-search"></span> Search
```

#### 字体图标实例
可以通过修改图标的大小、颜色等样式来实现定制化。通常可以使用 Bootstrap 的文本颜色类或自定义的 CSS 样式来修改图标的外观

>代码示例
```html
<button class="btn btn-primary">
  <i class="fa fa-thumbs-up"></i> Like
</button>
```


#### 定制字体图标
若需要使用自定义的图标集，可以使用服务如 IcoMoon 创建自定义的图标字体集。将生成的图标字体文件（通常是 .ttf, .woff, .svg, .eot 文件）及对应的 CSS 文件导入项目中，并使用相应的类名来调用这些图标。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>定制字体图标示例</title>
    <!-- 引入 Bootstrap 和自定义字体图标的 CSS 文件 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="path/to/your/custom-icons.css">
</head>
<body>

    <div class="container mt-5">
        <!-- 使用 Font Awesome 图标 -->
        <h2>使用 Font Awesome 图标</h2>
        <i class="fas fa-home fa-2x text-primary"></i> <!-- 蓝色的家图标 -->
        <i class="fas fa-user fa-2x text-warning"></i> <!-- 黄色的用户图标 -->
        <i class="fas fa-cog fa-2x text-danger"></i> <!-- 红色的设置图标 -->

        <hr>

        <!-- 使用自定义图标 -->
        <h2>使用自定义图标</h2>
        <i class="custom-icon custom-home fa-2x text-success"></i> <!-- 绿色的自定义家图标 -->
        <i class="custom-icon custom-user fa-2x text-info"></i> <!-- 青色的自定义用户图标 -->
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
```
> ont Awesome 图标使用: 使用 <i> 标签和 fa 系列的类名调用 Font Awesome 的预定义图标。通过添加 fa-2x 类来放大图标，使用 Bootstrap 的文本颜色类设置图标颜色。
自定义图标使用: 假设我们已经通过 IcoMoon 创建了自定义图标集，并在项目中引入了 custom-icons.css 文件。使用 `.custom-icon` 类来指定图标，并通过添加自定义的图标类（如 `.custom-home`, `.custom-user`）来显示相应的图标。


### 下拉菜单
Bootstrap 的下拉菜单组件非常强大且易于使用。它允许在用户交互时展示额外的内容，如菜单选项或操作。这些下拉菜单可以用于各种场景，如导航栏、按钮组等。

#### 基本用法
下拉菜单通常通过 `dropdown` 类和 `dropdown-toggle` 类来实现。下拉菜单的触发元素（如按钮）需要使用 `data-toggle="dropdown"` 属性来触发菜单显示。

> 代码示例
```html
<div class="dropdown">
    <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        Dropdown button
    </button>
    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
        <a class="dropdown-item" href="#">Action</a>
        <a class="dropdown-item" href="#">Another action</a>
        <a class="dropdown-item" href="#">Something else here</a>
    </div>
</div>
```


#### 对齐
下拉菜单可以使用 `.dropdown-menu-right` 类来右对齐菜单项，默认情况下下拉菜单是左对齐的。

> 代码示例
```html
<div class="dropdown">
    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButtonRight" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        Dropdown button
    </button>
    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButtonRight">
        <a class="dropdown-item" href="#">Action</a>
        <a class="dropdown-item" href="#">Another action</a>
        <a class="dropdown-item" href="#">Something else here</a>
    </div>
</div>
```

#### 标题和分割线
下拉菜单中可以添加标题和分割线来分隔菜单项。使用 `.dropdown-header` 和 `.dropdown-divider` 类来实现这些功能。

>代码示例
```html
<div class="dropdown">
    <button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButtonWithHeader" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        Dropdown button
    </button>
    <div class="dropdown-menu" aria-labelledby="dropdownMenuButtonWithHeader">
        <h6 class="dropdown-header">Header</h6>
        <a class="dropdown-item" href="#">Action</a>
        <a class="dropdown-item" href="#">Another action</a>
        <div class="dropdown-divider"></div>
        <a class="dropdown-item" href="#">Separated link</a>
    </div>
</div>
```


#### 菜单状态
下拉菜单项可以有不同的状态，如激活、禁用等。使用 `.active` 类来高亮显示激活项，使用 `.disabled` 类来禁用菜单项。

>代码示例
```html
<div class="dropdown">
    <button class="btn btn-danger dropdown-toggle" type="button" id="dropdownMenuButtonState" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        Dropdown button
    </button>
    <div class="dropdown-menu" aria-labelledby="dropdownMenuButtonState">
        <a class="dropdown-item active" href="#">Active item</a>
        <a class="dropdown-item" href="#">Another item</a>
        <a class="dropdown-item disabled" href="#" tabindex="-1" aria-disabled="true">Disabled item</a>
    </div>
</div>
```


### 按钮组
Bootstrap 提供了按钮组（Button Groups）组件，用于将多个按钮组合在一起。这对于创建多选操作、分组按钮等非常有用。按钮组可以水平或垂直排列，也可以在按钮之间添加间隔。

#### 基本按钮组
使用 `.btn-group` 类来创建一个按钮组。按钮组内的按钮会自动并排显示。

> 代码示例
```html
<div class="btn-group">
  <button type="button" class="btn btn-primary">Left</button>
  <button type="button" class="btn btn-primary">Middle</button>
  <button type="button" class="btn btn-primary">Right</button>
</div>
```


#### 按钮工具栏
使用 `.btn-toolbar` 类来创建按钮工具栏，可以将多个按钮组放在一起，并在它们之间添加间隔。

> 代码示例
```html
<div class="btn-toolbar">
  <div class="btn-group mr-2">
    <button type="button" class="btn btn-primary">1</button>
    <button type="button" class="btn btn-primary">2</button>
  </div>
  <div class="btn-group">
    <button type="button" class="btn btn-secondary">3</button>
    <button type="button" class="btn btn-secondary">4</button>
  </div>
</div>
```

#### 尺寸
使用 `.btn-group-sm` 和 `.btn-group-lg` 类来设置按钮组的大小。

> 代码示例
```html
<!-- 小尺寸按钮组 -->
<div class="btn-group btn-group-sm" role="group" aria-label="Small button group">
    <button type="button" class="btn btn-primary">Small 1</button>
    <button type="button" class="btn btn-primary">Small 2</button>
</div>

<!-- 大尺寸按钮组 -->
<div class="btn-group btn-group-lg" role="group" aria-label="Large button group">
    <button type="button" class="btn btn-primary">Large 1</button>
    <button type="button" class="btn btn-primary">Large 2</button>
</div>
```


#### 嵌套
可以在按钮组内部嵌套按钮组，创建更复杂的布局。

> 代码示例
```html
<div class="btn-group" role="group" aria-label="Nested button group">
    <button type="button" class="btn btn-primary">Button 1</button>
    <button type="button" class="btn btn-primary">Button 2</button>
    <div class="btn-group" role="group">
        <button type="button" class="btn btn-primary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Dropdown
        </button>
        <div class="dropdown-menu">
            <a class="dropdown-item" href="#">Action</a>
            <a class="dropdown-item" href="#">Another action</a>
        </div>
    </div>
</div>
```

#### 垂直的按钮组
使用 `.btn-group-vertical` 类可以创建垂直排列的按钮组。

> 代码示例
```html
<div class="btn-group-vertical" role="group" aria-label="Vertical button group">
    <button type="button" class="btn btn-secondary">Button 1</button>
    <button type="button" class="btn btn-secondary">Button 2</button>
    <button type="button" class="btn btn-secondary">Button 3</button>
</div>
```

#### 两端对齐的按钮组
使用 btn-group 和 btn-group-justified 类来创建在容器内两端对齐的按钮组。

> 代码示例
```html
<div class="btn-group btn-group-justified" role="group" aria-label="Justified button group">
    <button type="button" class="btn btn-primary">Left</button>
    <button type="button" class="btn btn-primary">Center</button>
    <button type="button" class="btn btn-primary">Right</button>
</div>
```


#### 按钮组代码示例
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bootstrap 按钮组示例</title>
    <!-- 引入 Bootstrap 的 CSS 文件 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

    <div class="container mt-5">
        <!-- 基本按钮组 -->
        <h3>基本按钮组</h3>
        <div class="btn-group mb-4" role="group" aria-label="Basic example">
            <button type="button" class="btn btn-primary">Button 1</button>
            <button type="button" class="btn btn-primary">Button 2</button>
            <button type="button" class="btn btn-primary">Button 3</button>
        </div>

        <!-- 按钮工具栏 -->
        <h3>按钮工具栏</h3>
        <div class="btn-toolbar mb-4" role="toolbar" aria-label="Toolbar with button groups">
            <div class="btn-group mr-2" role="group" aria-label="First group">
                <button type="button" class="btn btn-secondary">1</button>
                <button type="button" class="btn btn-secondary">2</button>
                <button type="button" class="btn btn-secondary">3</button>
            </div>
            <div class="btn-group mr-2" role="group" aria-label="Second group">
                <button type="button" class="btn btn-secondary">4</button>
                <button type="button" class="btn btn-secondary">5</button>
            </div>
            <div class="btn-group" role="group" aria-label="Third group">
                <button type="button" class="btn btn-secondary">6</button>
            </div>
        </div>

        <!-- 尺寸按钮组 -->
        <h3>尺寸按钮组</h3>
        <div class="btn-group btn-group-sm mb-4" role="group" aria-label="Small button group">
            <button type="button" class="btn btn-primary">Small 1</button>
            <button type="button" class="btn btn-primary">Small 2</button>
        </div>
        <div class="btn-group btn-group-lg mb-4" role="group" aria-label="Large button group">
            <button type="button" class="btn btn-primary">Large 1</button>
            <button type="button" class="btn btn-primary">Large 2</button>
        </div>

        <!-- 嵌套按钮组 -->
        <h3>嵌套按钮组</h3>
        <div class="btn-group mb-4" role="group" aria-label="Nested button group">
            <button type="button" class="btn btn-primary">Button 1</button>
            <button type="button" class="btn btn-primary">Button 2</button>
            <div class="btn-group" role="group">
                <button type="button" class="btn btn-primary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Dropdown
                </button>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="#">Action</a>
                    <a class="dropdown-item" href="#">Another action</a>
                </div>
            </div>
        </div>

        <!-- 垂直按钮组 -->
        <h3>垂直按钮组</h3>
        <div class="btn-group-vertical mb-4" role="group" aria-label="Vertical button group">
            <button type="button" class="btn btn-secondary">Button 1</button>
            <button type="button" class="btn btn-secondary">Button 2</button>
            <button type="button" class="btn btn-secondary">Button 3</button>
        </div>

        <!-- 两端对齐的按钮组 -->
        <h3>两端对齐的按钮组</h3>
        <div class="btn-group btn-group-justified mb-4" role="group" aria-label="Justified button group">
            <button type="button" class="btn btn-primary">Left</button>
            <button type="button" class="btn btn-primary">Center</button>
            <button type="button" class="btn btn-primary">Right</button>
        </div>
    </div>

    <!-- 引入 jQuery、Popper.js 和 Bootstrap 的 JavaScript 文件 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
```


### 按钮式弹出菜单
Bootstrap 的按钮式弹出菜单（Button Dropdowns）允许在按钮点击时显示下拉菜单。这种类型的下拉菜单通常与按钮一起使用，使得用户可以从一个按钮中选择不同的选项或执行不同的操作。

#### 单按钮下拉菜单
使用 `.btn-group` 和 `.dropdown-toggle` 类可以创建单个按钮触发的下拉菜单

```html
<div class="btn-group">
    <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        Dropdown
    </button>
    <div class="dropdown-menu">
        <a class="dropdown-item" href="#">Action</a>
        <a class="dropdown-item" href="#">Another action</a>
        <a class="dropdown-item" href="#">Something else here</a>
    </div>
</div>
```

#### 分裂式按钮下拉菜单
使用 `.btn-group` 结合 `.btn` 和 `.dropdown-toggle-split` 类创建分裂式按钮下拉菜单。

>代码示例
```html
<div class="btn-group">
  <button type="button" class="btn btn-primary">Action</button>
  <button type="button" class="btn btn-primary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown"></button>
  <div class="dropdown-menu">
    <a class="dropdown-item" href="#">Another action</a>
  </div>
</div>
```

#### 尺寸
 可以使用 `.btn-group-sm` 或 `.btn-group-lg` 类设置下拉菜单按钮的尺寸。

 ```html
 <!-- 小尺寸下拉菜单 -->
<div class="btn-group">
    <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        Small Dropdown
    </button>
    <div class="dropdown-menu">
        <a class="dropdown-item" href="#">Action</a>
        <a class="dropdown-item" href="#">Another action</a>
    </div>
</div>

<!-- 大尺寸下拉菜单 -->
<div class="btn-group">
    <button type="button" class="btn btn-primary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        Large Dropdown
    </button>
    <div class="dropdown-menu">
        <a class="dropdown-item" href="#">Action</a>
        <a class="dropdown-item" href="#">Another action</a>
    </div>
</div>
 ```


#### 向上弹出式菜单
使用 `.dropup` 类可以使下拉菜单向上弹出。

```html
<div class="btn-group dropup">
    <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        Dropup
    </button>
    <div class="dropdown-menu">
        <a class="dropdown-item" href="#">Action</a>
        <a class="dropdown-item" href="#">Another action</a>
        <a class="dropdown-item" href="#">Something else here</a>
    </div>
</div>
```


### 输入框组
Bootstrap 的输入框组（Input Groups）允许将文本框、按钮、下拉菜单等组件组合在一起。它们可以用于创建更复杂的输入形式，比如在输入框前后添加文本、图标或其他控件。

#### 基本实例
使用 `.input-group` 类可以将多个输入框或按钮组合在一起。

> 代码示例
```html
<div class="input-group">
  <div class="input-group-prepend">
    <span class="input-group-text">@</span>
  </div>
  <input type="text" class="form-control" placeholder="Username">
</div>
```


#### 尺寸
使用 `.input-group-sm` 或 `.input-group-lg` 类来调整输入框组的尺寸。

```html
<!-- 小尺寸输入框组 -->
<div class="input-group mb-3">
    <div class="input-group-prepend">
        <span class="input-group-text">@</span>
    </div>
    <input type="text" class="form-control form-control-sm" placeholder="Small">
</div>

<!-- 大尺寸输入框组 -->
<div class="input-group mb-3">
    <div class="input-group-prepend">
        <span class="input-group-text">@</span>
    </div>
    <input type="text" class="form-control form-control-lg" placeholder="Large">
</div>
```


#### 作为额外元素的复选框和单选按钮
可以将复选框或单选按钮作为输入框组的一部分，使用 `.input-group-prepend` 或 `.input-group-append` 类。

>代码示例
```html
<div class="input-group mb-3">
    <div class="input-group-prepend">
        <div class="input-group-text">
            <input type="checkbox" aria-label="Checkbox for following text input">
        </div>
    </div>
    <input type="text" class="form-control" placeholder="Check me out">
</div>

<div class="input-group mb-3">
    <div class="input-group-prepend">
        <div class="input-group-text">
            <input type="radio" aria-label="Radio button for following text input">
        </div>
    </div>
    <input type="text" class="form-control" placeholder="Radio button">
</div>
```


#### 作为额外元素的按钮
可以将按钮作为输入框组的一部分，使用 `.input-group-prepend` 或 `.input-group-append` 类。

```html
<div class="input-group mb-3">
    <input type="text" class="form-control" placeholder="Enter your email">
    <div class="input-group-append">
        <button class="btn btn-outline-secondary" type="button">Button</button>
    </div>
</div>
```

#### 作为额外元素的按钮式下拉菜单
可以将按钮式下拉菜单作为输入框组的一部分。

```html
<div class="input-group mb-3">
    <input type="text" class="form-control" placeholder="Enter your email">
    <div class="input-group-append">
        <div class="btn-group">
            <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Dropdown
            </button>
            <div class="dropdown-menu">
                <a class="dropdown-item" href="#">Action</a>
                <a class="dropdown-item" href="#">Another action</a>
                <a class="dropdown-item" href="#">Something else here</a>
            </div>
        </div>
    </div>
</div>
```

#### 作为额外元素的分裂式按钮下拉菜单
可以将分裂式按钮下拉菜单作为输入框组的一部分。

```html
<div class="input-group mb-3">
    <input type="text" class="form-control" placeholder="Enter your email">
    <div class="input-group-append">
        <div class="btn-group">
            <button type="button" class="btn btn-outline-secondary">Action</button>
            <button type="button" class="btn btn-outline-secondary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="sr-only">Toggle Dropdown</span>
            </button>
            <div class="dropdown-menu">
                <a class="dropdown-item" href="#">Action</a>
                <a class="dropdown-item" href="#">Another action</a>
                <a class="dropdown-item" href="#">Something else here</a>
            </div>
        </div>
    </div>
</div>
```

#### 作为额外元素的多个按钮
可以在输入框组中添加多个按钮。

```html
<div class="input-group mb-3">
    <input type="text" class="form-control" placeholder="Enter your email">
    <div class="input-group-append">
        <button class="btn btn-outline-secondary" type="button">Button 1</button>
        <button class="btn btn-outline-secondary" type="button">Button 2</button>
        <button class="btn btn-outline-secondary" type="button">Button 3</button>
    </div>
</div>
```

#### 输入框组代码示例
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bootstrap 输入框组示例</title>
    <!-- 引入 Bootstrap 的 CSS 文件 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

    <div class="container mt-5">
        <!-- 基本实例 -->
        <h3>基本实例</h3>
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">@</span>
            </div>
            <input type="text" class="form-control" placeholder="Username">
        </div>

        <!-- 尺寸 -->
        <h3>尺寸</h3>
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">@</span>
            </div>
            <input type="text" class="form-control form-control-sm" placeholder="Small">
        </div>
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">@</span>
            </div>
            <input type="text" class="form-control form-control-lg" placeholder="Large">
        </div>

        <!-- 作为额外元素的复选框和单选按钮 -->
        <h3>作为额外元素的复选框和单选按钮</h3>
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <div class="input-group-text">
                    <input type="checkbox" aria-label="Checkbox for following text input">
                </div>
            </div>
            <input type="text" class="form-control" placeholder="Check me out">
        </div>
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <div class="input-group-text">
                    <input type="radio" aria-label="Radio button for following text input">
                </div>
            </div>
            <input type="text" class="form-control" placeholder="Radio button">
        </div>

        <!-- 作为额外元素的按钮 -->
        <h3>作为额外元素的按钮</h3>
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="Enter your email">
            <div class="input-group-append">
                <button class="btn btn-outline-secondary" type="button">Button</button>
            </div>
        </div>

        <!-- 作为额外元素的按钮式下拉菜单 -->
        <h3>作为额外元素的按钮式下拉菜单</h3>
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="Enter your email">
            <div class="input-group-append">
                <div class="btn-group">
                    <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Dropdown
                    </button>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- 作为额外元素的分裂式按钮下拉菜单 -->
        <h3>作为额外元素的分裂式按钮下拉菜单</h3>
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="Enter your email">
            <div class="input-group-append">
                <div class="btn-group">
                    <button type="button" class="btn btn-outline-secondary">Action</button>
                    <button type="button" class="btn btn-outline-secondary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="sr-only">Toggle Dropdown</span>
                    </button>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- 作为额外元素的多个按钮 -->
        <h3>作为额外元素的多个按钮</h3>
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="Enter your email">
            <div class="input-group-append">
                <button class="btn btn-outline-secondary" type="button">Button 1</button>
                <button class="btn btn-outline-secondary" type="button">Button 2</button>
                <button class="btn btn-outline-secondary" type="button">Button 3</button>
            </div>
        </div>
    </div>

    <!-- 引入 jQuery、Popper.js 和 Bootstrap 的 JavaScript 文件 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
```


### 导航
Bootstrap 提供了一系列的导航组件，这些组件可以用来创建各种类型的导航条。它们可以用于网页的顶部或底部，或者在网页内部的特定部分。常见的导航组件包括选项卡导航、胶囊式导航、带下拉菜单的导航等。

#### 选项卡导航
使用 `.nav` 和 `.nav-tabs` 类创建选项卡式导航。

>代码示例
```html
<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" href="#">Active</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#">Link</a>
  </li>
</ul>
``` 

#### 胶囊式导航
使用 `.nav-pills` 类创建胶囊式导航。
```html
<ul class="nav nav-pills">
    <li class="nav-item">
        <a class="nav-link active" href="#">Active</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="#">Link</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="#">Another Link</a>
    </li>
    <li class="nav-item">
        <a class="nav-link disabled" href="#">Disabled</a>
    </li>
</ul>

```

#### 两端对齐的导航
通过使用 `ml-auto` 类将导航项右对齐。
```html
<ul class="nav">
    <li class="nav-item">
        <a class="nav-link active" href="#">Active</a>
    </li>
    <li class="nav-item ml-auto">
        <a class="nav-link" href="#">Aligned Right</a>
    </li>
</ul>
```

#### 禁用的链接
在导航项中使用 `.disabled` 类禁用链接。
```html
<ul class="nav">
    <li class="nav-item">
        <a class="nav-link disabled" href="#">Disabled</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="#">Active</a>
    </li>
</ul>
```

#### 带有下拉菜单的导航
可以在导航项中嵌入下拉菜单，使用 `.dropdown` 类。

>代码示例
```html
<ul class="nav nav-tabs">
  <li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Dropdown</a>
    <div class="dropdown-menu">
      <a class="dropdown-item" href="#">Action</a>
    </div>
  </li>
</ul>
```

#### 导航代码示例
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bootstrap 导航示例</title>
    <!-- 引入 Bootstrap 的 CSS 文件 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

    <div class="container mt-5">
        <!-- 选项卡导航 -->
        <h3>选项卡导航</h3>
        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class="nav-link active" href="#">Active</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Link</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Another Link</a>
            </li>
            <li class="nav-item">
                <a class="nav-link disabled" href="#">Disabled</a>
            </li>
        </ul>

        <!-- 胶囊式导航 -->
        <h3 class="mt-5">胶囊式导航</h3>
        <ul class="nav nav-pills">
            <li class="nav-item">
                <a class="nav-link active" href="#">Active</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Link</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Another Link</a>
            </li>
            <li class="nav-item">
                <a class="nav-link disabled" href="#">Disabled</a>
            </li>
        </ul>

        <!-- 两端对齐的导航 -->
        <h3 class="mt-5">两端对齐的导航</h3>
        <ul class="nav">
            <li class="nav-item">
                <a class="nav-link active" href="#">Active</a>
            </li>
            <li class="nav-item ml-auto">
                <a class="nav-link" href="#">Aligned Right</a>
            </li>
        </ul>

        <!-- 禁用的链接 -->
        <h3 class="mt-5">禁用的链接</h3>
        <ul class="nav">
            <li class="nav-item">
                <a class="nav-link disabled" href="#">Disabled</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Active</a>
            </li>
        </ul>

        <!-- 带有下拉菜单的导航 -->
        <h3 class="mt-5">带有下拉菜单的导航</h3>
        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class="nav-link active" href="#">Active</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Dropdown</a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="#">Action</a>
                    <a class="dropdown-item" href="#">Another action</a>
                    <a class="dropdown-item" href="#">Something else here</a>
                </div>
            </li>
        </ul>
    </div>

    <!-- 引入 jQuery、Popper.js 和 Bootstrap 的 JavaScript 文件 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
```

### 导航栏
Bootstrap 提供了一个功能强大且灵活的导航栏（Navbar）组件，它可以用于创建网站的主导航部分。导航栏支持响应式布局、不同颜色主题、固定在页面顶部或底部等多种功能。

#### 默认样式的导航栏
 导航栏使用 `.navbar` 类进行标记，可以选择不同颜色的背景和文本颜色。

> 代码示例
```html
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Features</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Pricing</a>
            </li>
            <li class="nav-item">
                <a class="nav-link disabled" href="#">Disabled</a>
            </li>
        </ul>
    </div>
</nav>
```

#### 品牌图标
使用 `.navbar-brand` 类可以添加品牌图标或文字。
```html
<nav class="navbar navbar-light bg-light">
    <a class="navbar-brand" href="#">
        <img src="https://via.placeholder.com/30" width="30" height="30" class="d-inline-block align-top" alt="">
        Bootstrap
    </a>
</nav>
```

#### 表单
可以在导航栏中添加表单，使用 `.form-inline` 类。
```html
<nav class="navbar navbar-light bg-light">
    <form class="form-inline">
        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
</nav>
```

#### 按钮
可以在导航栏中添加按钮，使用 `.btn` 类。
```html
<nav class="navbar navbar-light bg-light">
    <button class="btn btn-outline-primary" type="button">Button</button>
</nav>
```

#### 文本
使用 .`navbar-text` 类在导航栏中添加文本内容。
```html
<nav class="navbar navbar-light bg-light">
    <span class="navbar-text">
        Navbar text with an inline element
    </span>
</nav>
```

#### 非导航的链接
可以在导航栏中添加非导航的链接。
```html
<nav class="navbar navbar-light bg-light">
    <a class="navbar-brand" href="#">Brand</a>
    <a href="#" class="navbar-link">Link</a>
</nav>
```

#### 对齐方式
使用 `.ml-auto` 或 `.mr-auto` 类可以控制导航栏内容的对齐方式
```html
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">Brand</a>
    <div class="collapse navbar-collapse">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#">Right Aligned</a>
            </li>
        </ul>
    </div>
</nav>
```

#### 固定在顶部
 使用 `.fixed-top` 类可以将导航栏固定在页面顶部。
```html
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <a class="navbar-brand" href="#">Fixed top</a>
</nav>
```

#### 固定在底部
使用 `.fixed-bottom` 类可以将导航栏固定在页面底部。
```html
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-bottom">
    <a class="navbar-brand" href="#">Fixed bottom</a>
</nav>
```

#### 静止在顶部
使用 `.sticky-top` 类可以将导航栏静止在页面顶部，滚动时保持可见。
```html
<nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
    <a class="navbar-brand" href="#">Sticky top</a>
</nav>
```

#### 反色导航栏
使用 `.navbar-dark` 类创建反色的导航栏。
```html
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#">Dark Navbar</a>
</nav>
```

#### 响应式导航栏
使用 `.navbar-expand` 类可以使导航栏在不同屏幕尺寸上响应式展开或折叠。
```html
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">Responsive Navbar</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="#">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Link</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Contact</a>
            </li>
        </ul>
    </div>
</nav>
```

#### 路径导航
使用 `.breadcrumb` 类创建路径导航，用于展示页面路径。

> 代码示例
```html
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="#">Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Library</li>
  </ol>
</nav>
```

#### 导航栏代码示例
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bootstrap 导航栏示例</title>
    <!-- 引入 Bootstrap 的 CSS 文件 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

    <div class="container mt-5">
        <!-- 默认样式的导航栏 -->
        <h3>默认样式的导航栏</h3>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Navbar</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Pricing</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link disabled" href="#">Disabled</a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- 品牌图标 -->
        <h3 class="mt-5">品牌图标</h3>
        <nav class="navbar navbar-light bg-light">
            <a class="navbar-brand" href="#">
                <img src="https://via.placeholder.com/30" width="30" height="30" class="d-inline-block align-top" alt="">
                Bootstrap
            </a>
        </nav>

        <!-- 表单 -->
        <h3 class="mt-5">表单</h3>
        <nav class="navbar navbar-light bg-light">
            <form class="form-inline">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
        </nav>

        <!-- 按钮 -->
        <h3 class="mt-5">按钮</h3>
        <nav class="navbar navbar-light bg-light">
            <button class="btn btn-outline-primary" type="button">Button</button>
        </nav>

        <!-- 文本 -->
        <h3 class="mt-5">文本</h3>
        <nav class="navbar navbar-light bg-light">
            <span class="navbar-text">
                Navbar text with an inline element
            </span>
        </nav>

        <!-- 对齐方式 -->
        <h3 class="mt-5">对齐方式</h3>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Brand</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Right Aligned</a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- 固定在顶部 -->
        <h3 class="mt-5">固定在顶部</h3>
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <a class="navbar-brand" href="#">Fixed top</a>
        </nav>

        <div style="height: 200px;"></div>

        <!-- 固定在底部 -->
        <h3 class="mt-5">固定在底部</h3>
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-bottom">
            <a class="navbar-brand" href="#">Fixed bottom</a>
        </nav>

        <!-- 静止在顶部 -->
        <h3 class="mt-5">静止在顶部</h3>
        <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
            <a class="navbar-brand" href="#">Sticky top</a>
        </nav>

        <div style="height: 200px;"></div>

        <!-- 反色导航栏 -->
        <h3 class="mt-5">反色导航栏</h3>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="#">Dark Navbar</a>
        </nav>

        <!-- 响应式导航栏 -->
        <h3 class="mt-5">响应式导航栏</h3>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Responsive Navbar</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Link</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Contact</a>
                    </li>
                </ul>
            </div>
        </nav>

    </div>

    <!-- 引入 Bootstrap 的 JavaScript 文件 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
```


### 分页
Bootstrap 的分页组件用于在长列表中创建分页控制，使用户可以方便地浏览不同页的数据。分页组件提供了基本的样式和功能，可以很容易地集成到项目中。

#### 基本实例
使用 `.pagination` 类创建分页导航。

> 代码示例
```html
<nav aria-label="Page navigation example">
  <ul class="pagination">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>
```

#### 禁用和激活状态
可以为分页项添加 `.disabled` 或 `.active` 类来设置禁用或激活状态。
控制分页按钮的禁用和激活状态，以防用户点击不可用的按钮。
```html
<nav aria-label="Page navigation example">
  <ul class="pagination">
    <li class="page-item disabled">
      <a class="page-link" href="#" tabindex="-1" aria-disabled="true">&laquo;</a>
    </li>
    <li class="page-item active" aria-current="page">
      <span class="page-link">1 <span class="sr-only">(current)</span></span>
    </li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item">
      <a class="page-link" href="#">Next &raquo;</a>
    </li>
  </ul>
</nav>
```

#### 尺寸
使用 `.pagination-lg` 或 `.pagination-sm` 类设置分页的大小。
```html
<!-- 小型分页 -->
<nav aria-label="Page navigation example">
  <ul class="pagination pagination-sm">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>

<!-- 大型分页 -->
<nav aria-label="Page navigation example">
  <ul class="pagination pagination-lg">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>
```

### 翻页

#### 基本实例
使用 `.pager` 类创建翻页导航。

#### 对齐链接
使用 `.float-left` 和 `.float-right` 类对齐翻页链接。

#### 可选的禁用状态
可以为翻页项添加 `.disabled` 类设置禁用状态。

### 案例
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bootstrap 组件案例</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>

    <!-- 导航栏 -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#"><i class="fas fa-home"></i> Home</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#">Features</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Pricing</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
                        Dropdown
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                </li>
            </ul>
        </div>
    </nav>

    <!-- 路径导航 -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="#"><i class="fas fa-home"></i> Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Library</li>
        </ol>
    </nav>

    <div class="container">
        <!-- 按钮组 -->
        <div class="btn-group mb-3">
            <button type="button" class="btn btn-primary">Left</button>
            <button type="button" class="btn btn-primary">Middle</button>
            <button type="button" class="btn btn-primary">Right</button>
        </div>

        <!-- 按钮式弹出菜单 -->
        <div class="btn-group mb-3">
            <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                Dropdown button
            </button>
            <div class="dropdown-menu">
                <a class="dropdown-item" href="#">Action</a>
                <a class="dropdown-item" href="#">Another action</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">Separated link</a>
            </div>
        </div>

        <!-- 输入框组 -->
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">@</span>
            </div>
            <input type="text" class="form-control" placeholder="Username">
        </div>

        <!-- 分页 -->
        <nav aria-label="Page navigation example">
            <ul class="pagination">
                <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item"><a class="page-link" href="#">Next</a></li>
            </ul>
        </nav>

        <!-- 翻页 -->
        <nav aria-label="...">
            <ul class="pager">
                <li class="pager-item"><a class="pager-link" href="#">Previous</a></li>
                <li class="pager-item"><a class="pager-link" href="#">Next</a></li>
            </ul>
        </nav>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
```
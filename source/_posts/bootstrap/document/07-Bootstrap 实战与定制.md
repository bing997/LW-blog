---
title: 07-Bootstrap 实战与定制
date: 2024-08-21T01:00:00+08:00
tags:
    - bootstrap
    - 教程
categories: bootstrap
cover: /images/cover07.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: 通过 Sass 变量定制 Bootstrap 主题，并完成一个完整的企业官网响应式页面实战项目。
---

Bootstrap 是全球使用最广泛的前端 CSS 框架之一，它提供了丰富的组件、响应式栅格系统以及强大的工具类，能够帮助开发者快速构建现代化的网页。然而，在真实的企业级项目中，直接使用默认的 Bootstrap 样式往往会导致网站看起来“千篇一律”，难以体现品牌特色。因此，学习如何定制 Bootstrap 主题，并将其应用于完整的实战项目，是每一位前端开发者都必须掌握的核心技能。本章将从主题定制的原理出发，系统讲解如何通过 Sass 变量修改颜色、间距、字体等设计系统要素，如何按需引入组件以减小打包体积，最后通过一个完整的企业官网首页实战项目，将前面所学的知识融会贯通。

## 一、为什么要定制 Bootstrap

### 1.1 原理说明

Bootstrap 本质上是一套预定义好的 CSS 样式和 JavaScript 插件集合。它的核心设计理念是“约定优于配置”，通过统一的变量、混合宏（Mixin）和函数来生成大量样式规则。默认情况下，Bootstrap 使用一套经过精心设计但相对通用的配色、间距和字体方案。这种通用性虽然降低了上手门槛，却也带来了“千站一面”的问题。

定制 Bootstrap 的核心原理是：在编译 Bootstrap 源码之前，覆盖其内部的 Sass 变量。Bootstrap 的源码大量依赖变量（如 `$primary`、`$spacer`、`$font-family-base` 等），这些变量定义在 `scss/_variables.scss` 中。由于 Sass 支持变量覆盖，只要在导入 Bootstrap 主文件之前重新声明这些变量，最终生成的 CSS 就会使用我们自定义的值。这样既能保留 Bootstrap 完整的组件体系与响应式能力，又能让视觉风格完全符合企业品牌规范。

### 1.2 配置方法与代码示例

最常见的定制方式有两种：

1. **下载 Bootstrap 源码，手动修改后编译**：这种方式适合对源码有深度定制需求的团队，但维护成本较高。
2. **通过 npm 安装 Bootstrap，并创建自定义的 Sass 入口文件**：这是目前主流的方式，便于版本管理与自动化构建。

下面展示第二种方式的基础目录结构：

```
project/
├── node_modules/
│   └── bootstrap/
│       └── scss/
├── src/
│   └── scss/
│       ├── main.scss        # 自定义 Sass 入口
│       └── _custom.scss     # 覆盖 Bootstrap 变量
├── index.html
└── package.json
```

在 `src/scss/_custom.scss` 中覆盖变量：

```scss
// _custom.scss
$primary: #0d6efd;
$secondary: #6c757d;
$font-family-base: 'Microsoft YaHei', 'PingFang SC', sans-serif;
```

在 `src/scss/main.scss` 中先导入自定义变量，再导入 Bootstrap：

```scss
// main.scss
@import 'custom';
@import '~bootstrap/scss/bootstrap';
```

### 1.3 注意事项

- **变量覆盖必须在导入 Bootstrap 之前完成**。如果在 `@import '~bootstrap/scss/bootstrap';` 之后才修改变量，生成的 CSS 不会发生变化，因为此时 Bootstrap 已经使用了默认值。
- **不要直接修改 `node_modules/bootstrap/scss/_variables.scss`**。一旦升级 Bootstrap 版本，`node_modules` 会被重新安装，手动修改会丢失。
- **了解变量的默认值机制**。Bootstrap 大量变量使用 `!default` 标记，例如 `$primary: #0d6efd !default;`，这意味着只有变量未被定义时才会使用默认值，因此我们可以安全地提前覆盖。
- **保持版本一致性**。不同 Bootstrap 版本的变量名和默认值可能不同，升级前务必查阅官方迁移指南。

## 二、Bootstrap 的主题结构

### 2.1 原理说明

Bootstrap 5 的主题系统建立在 Sass 之上，主要由以下几个核心文件构成：

- **`scss/_variables.scss`**：存放全部设计令牌（Design Tokens），包括颜色、字体、间距、断点、组件参数等。这是定制 Bootstrap 时最需要关注的文件。
- **`scss/_maps.scss`**：定义颜色映射（maps），例如 `$theme-colors`、`$colors`、`$grays` 等。通过修改这些映射，可以一次性影响所有依赖它们的组件。
- **`scss/_root.scss`**：将部分 Sass 变量转换为 CSS 自定义属性（CSS Variables），方便在运行时使用 JS 动态调整。
- **`scss/_utilities.scss` 与 `scss/utilities/`**：定义工具类（如 `.text-primary`、`.p-3`、`.mt-5` 等）的生成规则。
- **`scss/bootstrap.scss`**：入口文件，按顺序导入所有基础文件、组件和工具类。

理解这些文件之间的关系，有助于我们在定制时做到有的放矢：如果只是改颜色，通常只需要覆盖变量和映射；如果要调整工具类范围，则需要修改 utilities 相关文件或配置。

### 2.2 配置方法与代码示例

打开 `node_modules/bootstrap/scss/bootstrap.scss`，可以看到其导入顺序：

```scss
// bootstrap.scss
@import 'functions';
@import 'variables';
@import 'maps';
@import 'mixins';
@import 'utilities';

// Layout & components
@import 'root';
@import 'reboot';
@import 'type';
@import 'images';
@import 'containers';
@import 'grid';
@import 'tables';
@import 'forms';
@import 'buttons';
// ... 更多组件
```

在自定义入口文件中，我们常常需要单独导入这些文件而不是一次性导入整个 `bootstrap.scss`，原因有两个：

1. 更精细地控制哪些组件参与编译。
2. 在某些文件导入之前插入我们自己的覆盖。

例如：

```scss
// main.scss
@import '~bootstrap/scss/functions';
@import '~bootstrap/scss/variables';
@import '~bootstrap/scss/maps';
@import '~bootstrap/scss/mixins';
@import '~bootstrap/scss/utilities';

// 在这里覆盖 utilities 映射
$utilities: map-merge(
  $utilities,
  (
    'width': (
      property: width,
      class: w,
      values: (
        25: 25%,
        50: 50%,
        75: 75%,
        100: 100%,
        auto: auto
      )
    )
  )
);

@import '~bootstrap/scss/root';
@import '~bootstrap/scss/reboot';
@import '~bootstrap/scss/type';
// ... 其他需要的组件
```

### 2.3 注意事项

- **导入顺序至关重要**。`functions`、`variables`、`maps`、`mixins`、`utilities` 这五个文件被称为“Bootstrap 的核心依赖”，很多组件文件内部都会引用它们。如果顺序错误，编译会报错。
- **CSS 自定义属性与 Sass 变量的区别**：`--bs-primary` 这类 CSS 变量通常由 `_root.scss` 根据 Sass 变量生成；Sass 变量在编译后消失，而 CSS 变量可以在浏览器控制台中实时修改。
- **映射合并要小心**。Sass 的 `map-merge` 会浅合并，如果覆盖的是深层嵌套对象，可能需要使用 `map-deep-get`/`map-deep-merge` 自定义函数，Bootstrap 提供了一些辅助函数在 `scss/_functions.scss` 中。

## 三、使用 Sass 变量定制

### 3.1 原理说明

Sass（Syntactically Awesome Style Sheets）是一种 CSS 预处理器，它在 CSS 语法基础上增加了变量、嵌套、混合宏、函数、继承等特性。Bootstrap 5 完全基于 Sass 构建，其源码中几乎没有硬编码的数值，所有视觉相关参数都通过变量定义。

Sass 变量有两种作用域：

1. **全局变量**：在文件根层级定义，可被后续导入的文件使用。
2. **局部变量**：在规则块或混合宏内部定义，作用域有限。

Bootstrap 使用 `!default` 标记为变量设置默认值。当我们在入口文件中提前声明同名变量时，Sass 会忽略 `!default` 默认值，从而使用我们的自定义值。

### 3.2 配置方法

#### 3.2.1 package.json 脚本

为了将 Sass 编译集成到开发工作流中，我们可以在 `package.json` 中定义脚本。下面是一个典型的配置示例：

```json
{
  "name": "bootstrap-custom-demo",
  "version": "1.0.0",
  "description": "Bootstrap 5 主题定制示例",
  "scripts": {
    "build:sass": "sass src/scss/main.scss dist/css/main.css --style=expanded",
    "build:sass:prod": "sass src/scss/main.scss dist/css/main.min.css --style=compressed --no-source-map",
    "watch:sass": "sass --watch src/scss/main.scss dist/css/main.css",
    "dev": "npm run watch:sass",
    "build": "npm run build:sass:prod"
  },
  "dependencies": {
    "bootstrap": "5.3.2"
  },
  "devDependencies": {
    "sass": "^1.69.0"
  }
}
```

执行 `npm run build:sass` 即可将 `src/scss/main.scss` 编译为 `dist/css/main.css`。

#### 3.2.2 Webpack 配置思路

在 Webpack 项目中，通常使用 `sass-loader`、`css-loader`、`mini-css-extract-plugin` 处理 Sass 文件。配置思路如下：

```js
// webpack.config.js
const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
  entry: './src/js/main.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'js/bundle.js'
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          {
            loader: 'sass-loader',
            options: {
              // 让 Sass 能够解析 node_modules 中的文件
              sassOptions: {
                includePaths: [path.resolve(__dirname, 'node_modules')]
              }
            }
          }
        ]
      }
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: 'css/[name].css'
    })
  ]
};
```

在 `src/js/main.js` 中引入 Sass 入口文件：

```js
import '../scss/main.scss';
import * as bootstrap from 'bootstrap';
```

#### 3.2.3 Vite 配置思路

Vite 原生支持 Sass，配置更加简洁。只需要安装 `sass` 依赖即可，无需额外 loader：

```js
// vite.config.js
import { defineConfig } from 'vite';
import path from 'path';

export default defineConfig({
  resolve: {
    alias: {
      '~bootstrap': path.resolve(__dirname, 'node_modules/bootstrap')
    }
  },
  css: {
    preprocessorOptions: {
      scss: {
        // 可以在这里注入全局变量或自动导入自定义文件
        additionalData: `@import "src/scss/custom";`
      }
    }
  }
});
```

在 `src/main.js` 中：

```js
import 'bootstrap';
import './scss/main.scss';
```

需要注意的是，如果已经在 `additionalData` 中注入了 `_custom.scss`，那么 `main.scss` 中就不需要再次 `@import 'custom';`，否则会导致重复导入。

### 3.3 完整代码示例：`_custom.scss`

下面是一份比较完整的 `_custom.scss` 示例，涵盖了颜色、间距、字体、边框、阴影、组件等多个维度的定制：

```scss
// src/scss/_custom.scss

// 1. 颜色系统
$primary:   #1a56db;
$secondary: #687280;
$success:   #0e9f6e;
$info:      #3f83f8;
$warning:   #f05252;
$danger:    #e02424;
$light:     #f3f4f6;
$dark:      #1f2937;

// 2. 灰阶
$gray-100: #f9fafb;
$gray-200: #f3f4f6;
$gray-300: #e5e7eb;
$gray-400: #d1d5db;
$gray-500: #9ca3af;
$gray-600: #6b7280;
$gray-700: #374151;
$gray-800: #1f2937;
$gray-900: #111827;

// 3. 字体系统
$font-family-sans-serif: 'Inter', 'Microsoft YaHei', 'PingFang SC', sans-serif;
$font-family-base:       $font-family-sans-serif;
$font-size-base:         1rem;
$font-size-lg:           $font-size-base * 1.125;
$font-size-sm:           $font-size-base * 0.875;
$line-height-base:       1.6;
$line-height-sm:         1.25;
$line-height-lg:         2;

// 4. 间距系统
$spacer: 1rem;
$spacers: (
  0: 0,
  1: $spacer * 0.25,
  2: $spacer * 0.5,
  3: $spacer,
  4: $spacer * 1.5,
  5: $spacer * 3,
  6: $spacer * 4,
  7: $spacer * 5,
  8: $spacer * 6,
  9: $spacer * 8
);

// 5. 圆角
$border-radius:    0.5rem;
$border-radius-sm: 0.25rem;
$border-radius-lg: 0.75rem;
$border-radius-xl: 1rem;

// 6. 阴影
$box-shadow:        0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
$box-shadow-sm:     0 1px 2px 0 rgba(0, 0, 0, 0.05);
$box-shadow-lg:     0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
$box-shadow-xl:     0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);

// 7. 容器最大宽度
$container-max-widths: (
  sm: 540px,
  md: 720px,
  lg: 960px,
  xl: 1140px,
  xxl: 1320px
);

// 8. 按钮
$btn-padding-y:         0.625rem;
$btn-padding-x:         1.25rem;
$btn-font-weight:       500;
$btn-border-radius:     $border-radius;
$btn-box-shadow:        $box-shadow-sm;
$btn-focus-box-shadow:  0 0 0 0.2rem rgba($primary, 0.25);

// 9. 导航栏
$navbar-padding-y:        1rem;
$navbar-nav-link-padding-x: 1rem;
$nav-link-font-weight:    500;
$navbar-dark-color:       rgba(255, 255, 255, 0.85);
$navbar-dark-hover-color: #ffffff;

// 10. 卡片
$card-border-width:        0;
$card-border-radius:       $border-radius-lg;
$card-box-shadow:          $box-shadow;
$card-spacer-y:            1.5rem;
$card-spacer-x:            1.5rem;
```

对应的 `main.scss`：

```scss
// src/scss/main.scss
@import 'custom';
@import '~bootstrap/scss/bootstrap';
```

### 3.4 注意事项

- **Sass 版本选择**：Bootstrap 5 官方推荐使用 Dart Sass。Node Sass 已被弃用，不建议在新项目中使用。
- **变量覆盖的粒度**：尽量只覆盖必要变量，避免一次性修改过多导致难以维护。
- **Source Map**：开发环境建议开启 source map，便于在浏览器开发者工具中定位到原始 Sass 文件；生产环境应关闭以减小体积。
- **构建产物体积**：完整引入 Bootstrap 所有组件和工具类会生成约 200KB 的 CSS（未压缩）。后续章节会讲解如何通过按需引入进一步减小体积。

## 四、修改颜色主题

### 4.1 原理说明

Bootstrap 5 的颜色系统分为三个层次：

1. **基础色板**：如 `$blue`、`$indigo`、`$purple`、`$pink`、`$red`、`$orange`、`$yellow`、`$green`、`$teal`、`$cyan`、`$white`、`$gray-*` 等。这些变量在 `_variables.scss` 中定义，是框架的“原材料”。
2. **主题色映射 `$theme-colors`**：这是一个 Sass Map，将语义化名称（`primary`、`secondary`、`success`、`info`、`warning`、`danger`、`light`、`dark`）映射到具体颜色值。大量组件（按钮、徽章、警告框、进度条、表单校验等）都基于该映射生成。
3. **通用颜色映射 `$colors`**：包含 `$blue`、`$indigo` 等名称的颜色映射，主要用于 `.text-*` 和 `.bg-*` 工具类。

修改主题色有两种方式：

- **直接覆盖语义变量**：例如 `$primary: #1a56db;`。Bootstrap 的 `$theme-colors` 默认引用这些变量，因此修改后映射会自动更新。
- **直接修改 `$theme-colors` 映射**：如果需要添加新的主题色（如 `accent`、`brand`），或者让某个语义色使用完全不同的颜色，可以直接重写整个 Map。

### 4.2 配置方法与代码示例

#### 方式一：覆盖基础变量

```scss
// _custom.scss
$primary:   #1d4ed8;
$secondary: #64748b;
$success:   #059669;
$info:      #2563eb;
$warning:   #d97706;
$danger:    #dc2626;
$light:     #f8fafc;
$dark:      #0f172a;

@import '~bootstrap/scss/bootstrap';
```

#### 方式二：修改主题色映射

如果希望新增一个品牌强调色 `accent`，可以这样写：

```scss
// _custom.scss
$primary: #1d4ed8;

// 引入 Bootstrap 变量后再修改 theme-colors
@import '~bootstrap/scss/functions';
@import '~bootstrap/scss/variables';

$custom-colors: (
  'accent': #7c3aed,
  'brand':  #db2777
);

$theme-colors: map-merge($theme-colors, $custom-colors);

@import '~bootstrap/scss/maps';
@import '~bootstrap/scss/mixins';
@import '~bootstrap/scss/utilities';

// 继续导入其余文件
@import '~bootstrap/scss/root';
@import '~bootstrap/scss/reboot';
// ...
```

这样，框架会自动生成 `.btn-accent`、`.bg-accent`、`.text-accent`、`.alert-accent` 等衍生类。

### 4.3 注意事项

- **颜色对比度**：修改主题色后，务必检查按钮、文字与背景的对比度是否符合 WCAG 无障碍标准。Bootstrap 会自动根据背景色亮度计算前景色（`color-contrast` 函数），但如果自定义颜色过于接近，可能导致文字难以辨认。
- **工具类同步**：如果只覆盖 `$primary` 变量，`.text-primary`、`.bg-primary` 会自动更新；但如果直接修改 `$theme-colors` 映射，需要确保 `maps` 文件在修改之后被正确导入，否则颜色工具类不会包含新增颜色。
- **CSS 变量一致性**：`_root.scss` 会读取 `$theme-colors` 和 `$colors` 生成 CSS 变量。如果在错误的位置修改映射，可能导致 `--bs-primary` 等 CSS 变量与 `.bg-primary` 类不一致。

## 五、自定义间距与字体

### 5.1 原理说明

Bootstrap 的间距系统基于 8pt 网格思想，以 `$spacer`（默认 1rem）为基准，通过乘法因子生成 `.m-1` 到 `.m-5`、`.p-1` 到 `.p-5` 等工具类。字体系统则通过 `$font-size-base`、`$font-family-base`、`$line-height-base` 等变量控制全局排版，并通过 `$h1-font-size` 到 `$h6-font-size` 控制标题尺寸。

在企业官网中，间距和字体往往是体现品牌气质的关键。过于紧凑的间距会让页面显得局促，过于疏松又会显得空洞；而字体的选择直接影响专业感和可读性。

### 5.2 配置方法与代码示例

#### 5.2.1 自定义间距

```scss
// _custom.scss
$spacer: 1rem;
$spacers: (
  0: 0,
  1: $spacer * 0.25,   // 4px
  2: $spacer * 0.5,    // 8px
  3: $spacer,          // 16px
  4: $spacer * 1.5,    // 24px
  5: $spacer * 3,      // 48px
  6: $spacer * 4,      // 64px
  7: $spacer * 5,      // 80px
  8: $spacer * 6,      // 96px
  9: $spacer * 8       // 128px
);

// 同时修改网格间隔
$grid-gutter-width: 1.5rem;
```

覆盖后，工具类 `.mt-6`、`.p-7`、`.gx-8` 等会自动生成。

#### 5.2.2 自定义字体

```scss
// _custom.scss
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

$font-family-sans-serif: 'Inter', system-ui, -apple-system, 'Segoe UI', 'Microsoft YaHei', sans-serif;
$font-family-base:       $font-family-sans-serif;
$font-family-monospace:  'Fira Code', 'Consolas', monospace;

$font-size-base:   1rem;
$font-size-lg:     $font-size-base * 1.125;
$font-size-sm:     $font-size-base * 0.875;

$h1-font-size: $font-size-base * 2.75;
$h2-font-size: $font-size-base * 2.25;
$h3-font-size: $font-size-base * 1.875;
$h4-font-size: $font-size-base * 1.5;
$h5-font-size: $font-size-base * 1.25;
$h6-font-size: $font-size-base;

$line-height-base: 1.7;
$line-height-sm:   1.25;
$line-height-lg:   2;

$headings-font-weight:   700;
$headings-line-height:   1.2;
$headings-margin-bottom: 1rem;

$lead-font-size:   $font-size-base * 1.25;
$lead-font-weight: 400;
```

### 5.3 注意事项

- **中文字体回退**：中文网页必须提供合适的中文字体回退栈，例如 `'Microsoft YaHei'`、`'PingFang SC'`、`'Noto Sans SC'`，否则 Windows 与 macOS 会分别使用不同的默认字体，导致排版差异。
- **Web 字体加载性能**：使用 Google Fonts 或自托管字体时，建议只加载需要的字重，并配合 `font-display: swap;` 防止 FOIT（Flash of Invisible Text）。
- **响应式字体**：Bootstrap 5 默认标题字号不是流式的。如果需要根据视口动态缩放，可以在 `_custom.scss` 中结合 CSS 的 `clamp()` 函数覆盖 `$h1-font-size` 等变量，例如 `$h1-font-size: clamp(1.75rem, 5vw, 2.75rem);`。
- **间距与栅格 gutter 的关系**：修改 `$spacer` 不会影响栅格系统的列间距，需要单独调整 `$grid-gutter-width`。

## 六、按需引入组件

### 6.1 原理说明

默认情况下，`@import '~bootstrap/scss/bootstrap';` 会导入全部 CSS 组件和工具类，其中很多在特定项目中并不会用到。对于性能敏感的项目，我们可以通过单独导入所需文件来显著减小最终 CSS 体积。

按需引入的核心思路是：

1. 导入 Bootstrap 核心依赖（functions、variables、maps、mixins、utilities）。
2. 导入基础样式（root、reboot、type、containers、grid）。
3. 按页面需要选择性导入组件（buttons、navbar、card、forms 等）。
4. 导入 utilities 生成文件，并按需调整 utilities 映射。

Bootstrap 5 的每个组件文件相对独立，只依赖核心文件，因此这种方式非常安全。

### 6.2 配置方法与代码示例

下面是一份典型的按需引入配置，适用于以“企业官网”为主的项目：

```scss
// src/scss/main.scss

// 1. 必须先导入核心依赖
@import '~bootstrap/scss/functions';
@import '~bootstrap/scss/variables';
@import '~bootstrap/scss/variables-dark'; // Bootstrap 5.3 新增暗色变量
@import '~bootstrap/scss/maps';
@import '~bootstrap/scss/mixins';
@import '~bootstrap/scss/utilities';

// 2. 自定义变量覆盖（必须放在核心依赖导入之后、组件导入之前）
$primary: #1a56db;
$font-family-base: 'Inter', 'Microsoft YaHei', sans-serif;
$spacers: (
  0: 0,
  1: 0.25rem,
  2: 0.5rem,
  3: 1rem,
  4: 1.5rem,
  5: 3rem
);

// 3. 布局与基础
@import '~bootstrap/scss/root';
@import '~bootstrap/scss/reboot';
@import '~bootstrap/scss/type';
@import '~bootstrap/scss/images';
@import '~bootstrap/scss/containers';
@import '~bootstrap/scss/grid';

// 4. 按需引入组件
@import '~bootstrap/scss/tables';
@import '~bootstrap/scss/forms';
@import '~bootstrap/scss/buttons';
@import '~bootstrap/scss/transitions';
@import '~bootstrap/scss/dropdown';
@import '~bootstrap/scss/nav';
@import '~bootstrap/scss/navbar';
@import '~bootstrap/scss/card';
@import '~bootstrap/scss/accordion';
@import '~bootstrap/scss/breadcrumb';
@import '~bootstrap/scss/pagination';
@import '~bootstrap/scss/badge';
@import '~bootstrap/scss/alert';
@import '~bootstrap/scss/progress';
@import '~bootstrap/scss/list-group';
@import '~bootstrap/scss/close';
@import '~bootstrap/scss/toasts';
@import '~bootstrap/scss/modal';
@import '~bootstrap/scss/tooltip';
@import '~bootstrap/scss/popover';
@import '~bootstrap/scss/carousel';
@import '~bootstrap/scss/spinners';
@import '~bootstrap/scss/offcanvas';
@import '~bootstrap/scss/placeholders';

// 5. 工具类
@import '~bootstrap/scss/helpers';
@import '~bootstrap/scss/utilities/api';
```

如果项目只需要导航栏、按钮、卡片和表单，可以进一步精简为：

```scss
@import '~bootstrap/scss/functions';
@import '~bootstrap/scss/variables';
@import '~bootstrap/scss/maps';
@import '~bootstrap/scss/mixins';
@import '~bootstrap/scss/utilities';

@import '~bootstrap/scss/root';
@import '~bootstrap/scss/reboot';
@import '~bootstrap/scss/type';
@import '~bootstrap/scss/containers';
@import '~bootstrap/scss/grid';

@import '~bootstrap/scss/forms';
@import '~bootstrap/scss/buttons';
@import '~bootstrap/scss/transitions';
@import '~bootstrap/scss/nav';
@import '~bootstrap/scss/navbar';
@import '~bootstrap/scss/card';

@import '~bootstrap/scss/helpers';
@import '~bootstrap/scss/utilities/api';
```

### 6.3 注意事项

- **依赖关系不可省略**：即使只使用 `.btn` 类，也需要导入 `root`、`reboot`、`mixins` 等基础文件，否则变量或 mixin 缺失会导致编译失败。
- **工具类必须最后导入**：`utilities/api` 负责根据 `$utilities` 映射生成所有工具类，必须在所有组件导入之后执行。
- **暗色模式变量**：Bootstrap 5.3 引入了 `_variables-dark.scss`。如果项目需要支持暗色模式，必须在 `variables` 之后、`maps` 之前导入；如果不需要，可以省略。
- **JavaScript 组件对应关系**：CSS 组件与 JS 插件通常成对出现（如 `modal.scss` 与 `Modal.js`）。如果只引入 CSS 文件而没有引入对应的 JS，交互功能不会生效。

## 七、实战：完整企业官网首页

### 7.1 原理说明

企业官网首页通常需要具备以下特征：

1. **清晰的品牌导航**：顶部固定导航栏，包含 Logo、菜单项和呼叫行动按钮。
2. **吸引注意的 Hero 区域**：大标题、副标题、主要行动按钮和辅助按钮，配合背景图或渐变。
3. **产品或服务特性介绍**：用图标加简短文字展示核心卖点。
4. **服务卡片**：以卡片形式展示具体服务内容，通常带有图标、标题、描述和链接。
5. **团队介绍**：展示核心团队成员头像、姓名、职位和社交链接。
6. **联系表单**：收集访客姓名、邮箱、主题和留言。
7. **页脚**：包含版权信息、快速链接、联系方式和社交媒体图标。

通过 Bootstrap 5 的栅格系统、组件和工具类，可以快速搭建上述所有模块，并保证在桌面端、平板和手机上都有良好的响应式表现。

### 7.2 完整代码示例

下面是基于 Bootstrap 5.3.2 CDN 的完整企业官网首页代码：

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>智云科技 - 企业数字化转型专家</title>
  <!-- Bootstrap 5.3.2 CSS CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
  <!-- 自定义样式 -->
  <style>
    :root {
      --bs-primary: #1a56db;
      --bs-primary-rgb: 26, 86, 219;
    }

    body {
      font-family: 'Inter', 'Microsoft YaHei', 'PingFang SC', sans-serif;
      line-height: 1.7;
    }

    .hero-section {
      background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 100%);
      color: #fff;
      padding: 120px 0 100px;
      position: relative;
      overflow: hidden;
    }

    .hero-section::before {
      content: '';
      position: absolute;
      top: -50%;
      right: -20%;
      width: 800px;
      height: 800px;
      background: radial-gradient(circle, rgba(59, 130, 246, 0.3) 0%, transparent 70%);
      pointer-events: none;
    }

    .section-title {
      font-weight: 700;
      margin-bottom: 1rem;
    }

    .section-subtitle {
      color: #6b7280;
      max-width: 600px;
      margin: 0 auto 3rem;
    }

    .feature-icon {
      width: 64px;
      height: 64px;
      border-radius: 16px;
      background: rgba(26, 86, 219, 0.1);
      color: var(--bs-primary);
      display: inline-flex;
      align-items: center;
      justify-content: center;
      font-size: 1.75rem;
      margin-bottom: 1rem;
    }

    .service-card {
      border: none;
      border-radius: 1rem;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      height: 100%;
    }

    .service-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
    }

    .team-card img {
      width: 120px;
      height: 120px;
      object-fit: cover;
      border-radius: 50%;
      margin: -60px auto 1rem;
      border: 4px solid #fff;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    }

    .contact-section {
      background-color: #f8fafc;
    }

    .footer {
      background-color: #0f172a;
      color: #cbd5e1;
      padding: 60px 0 30px;
    }

    .footer a {
      color: #cbd5e1;
      text-decoration: none;
    }

    .footer a:hover {
      color: #fff;
    }
  </style>
</head>
<body>

  <!-- 导航栏 -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand fw-bold" href="#">
        <i class="bi bi-cloud-check me-2"></i>智云科技
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto align-items-lg-center">
          <li class="nav-item"><a class="nav-link active" href="#home">首页</a></li>
          <li class="nav-item"><a class="nav-link" href="#features">特性</a></li>
          <li class="nav-item"><a class="nav-link" href="#services">服务</a></li>
          <li class="nav-item"><a class="nav-link" href="#team">团队</a></li>
          <li class="nav-item"><a class="nav-link" href="#contact">联系我们</a></li>
          <li class="nav-item ms-lg-3 mt-3 mt-lg-0">
            <a class="btn btn-primary" href="#contact">立即咨询</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Hero 区域 -->
  <section id="home" class="hero-section d-flex align-items-center">
    <div class="container position-relative">
      <div class="row align-items-center">
        <div class="col-lg-7">
          <span class="badge bg-primary bg-opacity-25 text-white mb-3 px-3 py-2">企业数字化转型专家</span>
          <h1 class="display-3 fw-bold mb-4">用技术驱动业务增长，让数字化更简单</h1>
          <p class="lead mb-5 opacity-75">智云科技致力于为企业提供一站式的云计算、大数据、人工智能与定制开发服务，助力传统行业实现高效、安全、可持续的数字化升级。</p>
          <div class="d-flex flex-wrap gap-3">
            <a href="#services" class="btn btn-primary btn-lg px-4">了解我们的服务</a>
            <a href="#contact" class="btn btn-outline-light btn-lg px-4">预约演示</a>
          </div>
        </div>
        <div class="col-lg-5 d-none d-lg-block">
          <img src="https://via.placeholder.com/500x400/1e3a8a/ffffff?text=Digital+Transformation" alt="数字化转型" class="img-fluid rounded-4 shadow-lg">
        </div>
      </div>
    </div>
  </section>

  <!-- 特性介绍 -->
  <section id="features" class="py-6">
    <div class="container py-5">
      <div class="text-center">
        <h2 class="section-title h1">为什么选择智云科技</h2>
        <p class="section-subtitle">我们拥有深厚的技术积累与丰富的行业经验，能够为企业提供真正可落地、可衡量的数字化解决方案。</p>
      </div>
      <div class="row g-4 mt-3">
        <div class="col-md-6 col-lg-3">
          <div class="text-center p-4">
            <div class="feature-icon"><i class="bi bi-lightning-charge"></i></div>
            <h5 class="fw-bold">高效交付</h5>
            <p class="text-muted mb-0">采用敏捷开发与 DevOps 实践，平均项目交付周期缩短 40%。</p>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="text-center p-4">
            <div class="feature-icon"><i class="bi bi-shield-check"></i></div>
            <h5 class="fw-bold">安全可靠</h5>
            <p class="text-muted mb-0">通过等保三级、ISO27001 认证，保障企业数据安全合规。</p>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="text-center p-4">
            <div class="feature-icon"><i class="bi bi-graph-up-arrow"></i></div>
            <h5 class="fw-bold">数据驱动</h5>
            <p class="text-muted mb-0">基于大数据与 AI 技术，帮助企业洞察业务趋势，科学决策。</p>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="text-center p-4">
            <div class="feature-icon"><i class="bi bi-headset"></i></div>
            <h5 class="fw-bold">全程陪伴</h5>
            <p class="text-muted mb-0">从需求调研到上线运维，提供 7×24 小时专业技术支持。</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- 服务卡片 -->
  <section id="services" class="py-6 bg-light">
    <div class="container py-5">
      <div class="text-center">
        <h2 class="section-title h1">我们的核心服务</h2>
        <p class="section-subtitle">覆盖企业数字化转型的关键环节，提供端到端的技术服务能力。</p>
      </div>
      <div class="row g-4 mt-3">
        <div class="col-md-6 col-lg-4">
          <div class="card service-card p-4">
            <div class="feature-icon"><i class="bi bi-cloud"></i></div>
            <h4 class="card-title fw-bold">云计算架构</h4>
            <p class="card-text text-muted">提供公有云、私有云、混合云架构设计与迁移服务，优化 IT 成本与弹性扩展能力。</p>
            <a href="#" class="btn btn-link text-primary text-decoration-none p-0">了解详情 <i class="bi bi-arrow-right"></i></a>
          </div>
        </div>
        <div class="col-md-6 col-lg-4">
          <div class="card service-card p-4">
            <div class="feature-icon"><i class="bi bi-code-square"></i></div>
            <h4 class="card-title fw-bold">定制软件开发</h4>
            <p class="card-text text-muted">根据业务场景定制 ERP、CRM、OA、电商平台等企业级应用系统。</p>
            <a href="#" class="btn btn-link text-primary text-decoration-none p-0">了解详情 <i class="bi bi-arrow-right"></i></a>
          </div>
        </div>
        <div class="col-md-6 col-lg-4">
          <div class="card service-card p-4">
            <div class="feature-icon"><i class="bi bi-cpu"></i></div>
            <h4 class="card-title fw-bold">人工智能应用</h4>
            <p class="card-text text-muted">基于机器学习与自然语言处理技术，构建智能客服、推荐系统、图像识别等 AI 应用。</p>
            <a href="#" class="btn btn-link text-primary text-decoration-none p-0">了解详情 <i class="bi bi-arrow-right"></i></a>
          </div>
        </div>
        <div class="col-md-6 col-lg-4">
          <div class="card service-card p-4">
            <div class="feature-icon"><i class="bi bi-bar-chart-line"></i></div>
            <h4 class="card-title fw-bold">大数据分析</h4>
            <p class="card-text text-muted">整合多源数据，搭建数据仓库与可视化大屏，助力企业实现精细化运营。</p>
            <a href="#" class="btn btn-link text-primary text-decoration-none p-0">了解详情 <i class="bi bi-arrow-right"></i></a>
          </div>
        </div>
        <div class="col-md-6 col-lg-4">
          <div class="card service-card p-4">
            <div class="feature-icon"><i class="bi bi-phone"></i></div>
            <h4 class="card-title fw-bold">移动端开发</h4>
            <p class="card-text text-muted">提供 iOS、Android、小程序、Flutter 跨平台开发服务，覆盖全终端用户。</p>
            <a href="#" class="btn btn-link text-primary text-decoration-none p-0">了解详情 <i class="bi bi-arrow-right"></i></a>
          </div>
        </div>
        <div class="col-md-6 col-lg-4">
          <div class="card service-card p-4">
            <div class="feature-icon"><i class="bi bi-shield-lock"></i></div>
            <h4 class="card-title fw-bold">安全合规咨询</h4>
            <p class="card-text text-muted">帮助企业建立信息安全体系，完成等级保护、数据合规与隐私保护建设。</p>
            <a href="#" class="btn btn-link text-primary text-decoration-none p-0">了解详情 <i class="bi bi-arrow-right"></i></a>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- 团队介绍 -->
  <section id="team" class="py-6">
    <div class="container py-5">
      <div class="text-center">
        <h2 class="section-title h1">核心团队</h2>
        <p class="section-subtitle">一支由资深架构师、全栈工程师和行业专家组成的专业团队。</p>
      </div>
      <div class="row g-4 mt-5">
        <div class="col-md-6 col-lg-3">
          <div class="card team-card text-center pt-5 mt-5 h-100 border-0 shadow-sm">
            <img src="https://via.placeholder.com/120/1a56db/ffffff?text=CEO" alt="张明远">
            <div class="card-body">
              <h5 class="card-title fw-bold mb-1">张明远</h5>
              <p class="text-primary small mb-3">创始人兼 CEO</p>
              <p class="card-text text-muted small">前知名互联网企业技术副总裁，拥有 15 年企业级产品研发经验。</p>
              <div class="d-flex justify-content-center gap-3 mt-3">
                <a href="#" class="text-muted"><i class="bi bi-linkedin"></i></a>
                <a href="#" class="text-muted"><i class="bi bi-envelope"></i></a>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="card team-card text-center pt-5 mt-5 h-100 border-0 shadow-sm">
            <img src="https://via.placeholder.com/120/1a56db/ffffff?text=CTO" alt="李思涵">
            <div class="card-body">
              <h5 class="card-title fw-bold mb-1">李思涵</h5>
              <p class="text-primary small mb-3">首席技术官</p>
              <p class="card-text text-muted small">云计算与分布式系统专家，曾主导多个千万级用户平台的架构设计。</p>
              <div class="d-flex justify-content-center gap-3 mt-3">
                <a href="#" class="text-muted"><i class="bi bi-linkedin"></i></a>
                <a href="#" class="text-muted"><i class="bi bi-envelope"></i></a>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="card team-card text-center pt-5 mt-5 h-100 border-0 shadow-sm">
            <img src="https://via.placeholder.com/120/1a56db/ffffff?text=PM" alt="王浩然">
            <div class="card-body">
              <h5 class="card-title fw-bold mb-1">王浩然</h5>
              <p class="text-primary small mb-3">产品总监</p>
              <p class="card-text text-muted small">深耕 B 端产品 10 年，擅长将复杂业务需求转化为易用的数字化产品。</p>
              <div class="d-flex justify-content-center gap-3 mt-3">
                <a href="#" class="text-muted"><i class="bi bi-linkedin"></i></a>
                <a href="#" class="text-muted"><i class="bi bi-envelope"></i></a>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="card team-card text-center pt-5 mt-5 h-100 border-0 shadow-sm">
            <img src="https://via.placeholder.com/120/1a56db/ffffff?text=DES" alt="赵雨桐">
            <div class="card-body">
              <h5 class="card-title fw-bold mb-1">赵雨桐</h5>
              <p class="text-primary small mb-3">设计总监</p>
              <p class="card-text text-muted small">专注用户体验与品牌设计，确保每个产品兼具美感与可用性。</p>
              <div class="d-flex justify-content-center gap-3 mt-3">
                <a href="#" class="text-muted"><i class="bi bi-linkedin"></i></a>
                <a href="#" class="text-muted"><i class="bi bi-envelope"></i></a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- 联系表单 -->
  <section id="contact" class="contact-section py-6">
    <div class="container py-5">
      <div class="row g-5 align-items-center">
        <div class="col-lg-5">
          <h2 class="section-title h1">联系我们</h2>
          <p class="text-muted mb-5">无论您有项目咨询、技术合作还是人才招聘需求，都欢迎与我们联系。</p>
          <ul class="list-unstyled">
            <li class="d-flex align-items-start mb-4">
              <i class="bi bi-geo-alt-fill text-primary fs-4 me-3"></i>
              <div>
                <h6 class="fw-bold mb-1">公司地址</h6>
                <p class="text-muted mb-0">北京市海淀区中关村软件园二期 8 号楼</p>
              </div>
            </li>
            <li class="d-flex align-items-start mb-4">
              <i class="bi bi-telephone-fill text-primary fs-4 me-3"></i>
              <div>
                <h6 class="fw-bold mb-1">联系电话</h6>
                <p class="text-muted mb-0">400-888-1234</p>
              </div>
            </li>
            <li class="d-flex align-items-start mb-4">
              <i class="bi bi-envelope-fill text-primary fs-4 me-3"></i>
              <div>
                <h6 class="fw-bold mb-1">电子邮箱</h6>
                <p class="text-muted mb-0">contact@zhiyuntech.com</p>
              </div>
            </li>
          </ul>
        </div>
        <div class="col-lg-7">
          <div class="card border-0 shadow-sm p-4">
            <form novalidate>
              <div class="row g-3">
                <div class="col-md-6">
                  <label for="name" class="form-label">您的姓名</label>
                  <input type="text" class="form-control" id="name" placeholder="请输入姓名" required>
                  <div class="invalid-feedback">请输入您的姓名</div>
                </div>
                <div class="col-md-6">
                  <label for="email" class="form-label">电子邮箱</label>
                  <input type="email" class="form-control" id="email" placeholder="name@company.com" required>
                  <div class="invalid-feedback">请输入有效的电子邮箱</div>
                </div>
                <div class="col-12">
                  <label for="subject" class="form-label">咨询主题</label>
                  <select class="form-select" id="subject" required>
                    <option selected disabled value="">请选择咨询主题</option>
                    <option value="cloud">云计算架构</option>
                    <option value="software">定制软件开发</option>
                    <option value="ai">人工智能应用</option>
                    <option value="data">大数据分析</option>
                    <option value="other">其他合作</option>
                  </select>
                  <div class="invalid-feedback">请选择一个咨询主题</div>
                </div>
                <div class="col-12">
                  <label for="message" class="form-label">留言内容</label>
                  <textarea class="form-control" id="message" rows="5" placeholder="请简要描述您的需求..." required></textarea>
                  <div class="invalid-feedback">请填写留言内容</div>
                </div>
                <div class="col-12">
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="" id="agree" required>
                    <label class="form-check-label" for="agree">我同意隐私政策与服务条款</label>
                    <div class="invalid-feedback">提交前请先同意相关条款</div>
                  </div>
                </div>
                <div class="col-12 d-grid">
                  <button class="btn btn-primary btn-lg" type="submit">提交留言</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- 页脚 -->
  <footer class="footer">
    <div class="container">
      <div class="row g-4">
        <div class="col-lg-4">
          <h5 class="text-white fw-bold mb-3"><i class="bi bi-cloud-check me-2"></i>智云科技</h5>
          <p class="mb-4">用技术驱动业务增长，让数字化更简单。我们专注于为企业提供领先的云计算、大数据与人工智能解决方案。</p>
          <div class="d-flex gap-3">
            <a href="#" class="fs-5"><i class="bi bi-wechat"></i></a>
            <a href="#" class="fs-5"><i class="bi bi-sina-weibo"></i></a>
            <a href="#" class="fs-5"><i class="bi bi-github"></i></a>
            <a href="#" class="fs-5"><i class="bi bi-linkedin"></i></a>
          </div>
        </div>
        <div class="col-6 col-lg-2">
          <h6 class="text-white fw-bold mb-3">快速链接</h6>
          <ul class="list-unstyled">
            <li class="mb-2"><a href="#home">首页</a></li>
            <li class="mb-2"><a href="#features">特性</a></li>
            <li class="mb-2"><a href="#services">服务</a></li>
            <li class="mb-2"><a href="#team">团队</a></li>
          </ul>
        </div>
        <div class="col-6 col-lg-2">
          <h6 class="text-white fw-bold mb-3">服务体系</h6>
          <ul class="list-unstyled">
            <li class="mb-2"><a href="#">云计算</a></li>
            <li class="mb-2"><a href="#">定制开发</a></li>
            <li class="mb-2"><a href="#">人工智能</a></li>
            <li class="mb-2"><a href="#">数据分析</a></li>
          </ul>
        </div>
        <div class="col-lg-4">
          <h6 class="text-white fw-bold mb-3">订阅动态</h6>
          <p class="small">订阅我们的邮件，获取最新技术资讯与行业洞察。</p>
          <form class="d-flex gap-2">
            <input type="email" class="form-control" placeholder="您的邮箱">
            <button type="submit" class="btn btn-primary flex-shrink-0">订阅</button>
          </form>
        </div>
      </div>
      <hr class="border-secondary my-4">
      <div class="d-flex flex-column flex-md-row justify-content-between align-items-center">
        <p class="mb-2 mb-md-0 small">&copy; 2024 智云科技（北京）有限公司 版权所有</p>
        <p class="mb-0 small">京 ICP 备 12345678 号</p>
      </div>
    </div>
  </footer>

  <!-- Bootstrap 5.3.2 JS Bundle CDN -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

  <!-- 表单校验示例脚本 -->
  <script>
    (function () {
      'use strict';
      const forms = document.querySelectorAll('form');
      Array.from(forms).forEach(function (form) {
        form.addEventListener('submit', function (event) {
          if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
          }
          form.classList.add('was-validated');
        }, false);
      });
    })();
  </script>
</body>
</html>
```

### 7.3 注意事项

- **导航栏固定后的内容遮挡**：使用 `fixed-top` 后，页面内容会被导航栏遮挡，需要为 Hero 区域或 body 设置足够的 `padding-top`。本示例中通过给 Hero 区域设置较大的 `padding` 来解决。
- **响应式图片**：所有图片建议使用 `img-fluid` 类，使其在不同屏幕宽度下自适应缩放。
- **表单校验**：Bootstrap 提供了基于 HTML5 表单验证的样式，通过给表单添加 `was-validated` 类即可触发 `:invalid`、`:valid` 样式。本示例的脚本实现了这一交互。
- **CDN 稳定性**：生产环境中建议将 Bootstrap 静态资源托管到自己的 CDN 或服务器上，避免第三方 CDN 故障影响页面加载。
- **可访问性**：导航链接应正确设置 `href` 锚点，图片应提供有意义的 `alt` 文本，表单元素应与 `<label>` 正确关联。

## 八、性能优化建议

### 8.1 原理说明

Bootstrap 虽然功能强大，但如果使用不当，也会带来性能问题。常见的性能瓶颈包括：

1. **CSS 体积过大**：完整引入 Bootstrap 会产生大量未使用的样式规则。
2. **JavaScript 体积过大**：`bootstrap.bundle.js` 包含了 Popper.js，虽然方便，但并非所有页面都需要全部插件。
3. **渲染阻塞**：CSS 文件默认会阻塞页面首次渲染；JS 文件如果放在头部且未加 `defer` 或 `async`，会阻塞 HTML 解析。
4. **图片资源未优化**：高清大图、未压缩的占位图会显著增加页面加载时间。

针对以上问题，我们可以从构建、资源加载、代码组织三个层面进行优化。

### 8.2 配置方法与代码示例

#### 8.2.1 按需编译 CSS

如本章第六节所述，通过只导入需要的组件文件，可以将 CSS 体积从约 200KB 降低到 50KB 以下（未压缩）。

#### 8.2.2 按需引入 JavaScript

在基于 ES Module 的项目中，不要直接 `import 'bootstrap'`，而是单独导入需要的插件：

```js
// src/js/main.js
import { Dropdown } from 'bootstrap';

// 初始化导航栏下拉菜单
document.querySelectorAll('[data-bs-toggle="dropdown"]')
  .forEach(dropdown => new Dropdown(dropdown));
```

如果需要多个插件，可以按需组合：

```js
import { Modal, Collapse, Tooltip } from 'bootstrap';
```

这样打包工具（如 Webpack、Vite、Rollup）会进行 Tree Shaking，移除未使用的 JS 代码。

#### 8.2.3 异步加载非关键 CSS

对于非首屏关键的 CSS，可以使用 `rel="preload"` 和 `onload` 进行异步加载：

```html
<link rel="preload" href="css/non-critical.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
<noscript><link rel="stylesheet" href="css/non-critical.css"></noscript>
```

#### 8.2.4 移除未使用的 CSS

对于无法通过按需引入完全消除的冗余样式，可以使用 PurgeCSS 或 UnCSS：

```js
// purgecss.config.js
module.exports = {
  content: ['./src/**/*.html', './src/**/*.js', './src/**/*.jsx', './src/**/*.vue'],
  css: ['./dist/css/main.css'],
  safelist: [
    // 动态类名需要手动保留
    'collapse',
    'collapse-show',
    'collapsing',
    'show',
    'fade',
    'modal-open'
  ]
};
```

执行：

```bash
npx purgecss --config purgecss.config.js --output dist/css/main.css
```

#### 8.2.5 压缩与缓存

生产环境应对 CSS 和 JS 进行 gzip/brotli 压缩，并通过文件名哈希实现长期缓存：

```json
{
  "scripts": {
    "build": "npm run build:sass:prod && npm run hash-assets",
    "hash-assets": "node scripts/hash-assets.js"
  }
}
```

### 8.3 注意事项

- **Tree Shaking 的前提**：只有当打包工具识别到 ES Module 语法时，Tree Shaking 才能生效。如果通过 `<script>` 标签直接引入 UMD 版本的 Bootstrap JS，则无法实现按需加载。
- **PurgeCSS 的误删风险**：Bootstrap 的一些类名是通过 JS 动态添加的（如 `modal-open`、`show`、`collapsing`），使用 PurgeCSS 时必须将这些类名加入 safelist。
- **预加载 CSS 的兼容性**：`rel="preload"` 在较老的浏览器中不被支持，需要提供 `<noscript>` 回退方案。
- **字体加载策略**：Web 字体可能导致布局偏移（CLS），建议设置合适的 `font-display` 策略，并为关键字体提供系统字体回退。

## 九、本章小结

本章系统介绍了 Bootstrap 5 的主题定制方法与完整企业官网首页的实战开发。我们首先阐述了定制 Bootstrap 的必要性：默认样式虽然通用，但难以体现品牌差异，而通过覆盖 Sass 变量可以在保留框架能力的同时实现视觉差异化。接着，我们深入讲解了 Bootstrap 的主题结构，包括 `_variables.scss`、`_maps.scss`、`_root.scss` 以及工具类生成机制之间的关系。

在使用 Sass 变量定制部分，我们展示了如何配置 `package.json` 脚本、Webpack 与 Vite 的 Sass 构建流程，并提供了一份涵盖颜色、灰阶、字体、间距、圆角、阴影、容器宽度、按钮、导航栏和卡片的 `_custom.scss` 完整示例。随后，我们分别讲解了如何修改颜色主题、自定义间距与字体，以及如何通过按需引入组件来优化构建体积。

实战环节通过一个名为“智云科技”的企业官网首页，将导航栏、Hero 区域、特性介绍、服务卡片、团队介绍、联系表单和页脚等模块串联起来，所有代码均基于 Bootstrap 5.3.2 CDN 实现，开发者可以直接复制运行并在此基础上进行二次开发。最后，我们从 CSS 按需编译、JS 按需引入、异步加载非关键资源、移除未使用 CSS、压缩与缓存等方面给出了性能优化建议。

掌握本章内容后，读者应该能够独立完成 Bootstrap 5 的主题定制工作，并根据项目需求灵活选择全量引入或按需引入策略，最终交付一个既符合品牌规范又具备良好性能的企业级响应式网站。

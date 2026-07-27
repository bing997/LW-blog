---
title: 10-Bootstrap 4 的新增组件—旋转器和卡片
date: 2024-08-20
categories:
  - bootstrap
tags:
  - bootstrap
  - 教程
---

## [](#Bootstrap-4-的新增组件—旋转器和卡片)Bootstrap 4 的新增组件—旋转器和卡片

### [](#旋转器特效)旋转器特效

#### [](#定义旋转器)定义旋转器

Bootstrap Spinner 是一种用来显示加载状态的动画组件。可以通过添加 `.spinner-border` 或 `.spinner-grow` 类来创建不同样式的旋转器。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;旋转器颜色&lt;/h3&gt;
&lt;div class=&quot;spinner-border text-primary&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-border text-secondary&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-border text-success&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-border text-danger&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-border text-warning&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-border text-info&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-border text-light&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-border text-dark&quot;&gt;&lt;/div&gt;
&lt;h3 class=&quot;my-4&quot;&gt;渐变缩放颜色&lt;/h3&gt;
&lt;div class=&quot;spinner-grow text-primary&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-grow text-secondary&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-grow text-success&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-grow text-danger&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-grow text-warning&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-grow text-info&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-grow text-light&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-grow text-dark&quot;&gt;&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#设计旋转器风格)设计旋转器风格

**颜色**：通过 `text-*` 类可以更改旋转器的颜色。

**大小**：通过添加 `.spinner-border-sm` 或使用 `style=&quot;width: 3rem; height: 3rem;&quot;` 自定义大小。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;设置旋转器的大小&lt;/h3&gt;
&lt;div class=&quot;spinner-border spinner-border-sm&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-grow spinner-grow-sm ml-5&quot;&gt;&lt;/div&gt;
&lt;hr&gt;
&lt;h2 class=&quot;mb-3&quot;&gt;自定义旋转器的大小&lt;/h2&gt;
&lt;div class=&quot;spinner-border&quot; style=&quot;width: 3rem;height: 3rem;&quot;&gt;&lt;/div&gt;
&lt;div class=&quot;spinner-grow ml-5&quot; style=&quot;width: 3rem;height: 3rem;&quot;&gt;&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#对齐旋转器)对齐旋转器

可以通过 Bootstrap 的 `text-center`, `d-flex`, `justify-content-center` 等类来控制旋转器的对齐方式。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;居中对齐&lt;/h3&gt;
&lt;div class=&quot;d-flex justify-content-center&quot;&gt;
 &lt;div class=&quot;spinner-border&quot;&gt;&lt;/div&gt;
&lt;/div&gt;
&lt;hr&gt;
&lt;h3 class=&quot;my-4&quot;&gt;右对齐&lt;/h3&gt;
&lt;div class=&quot;d-flex justify-content-center&quot;&gt;
 &lt;div class=&quot;spinner-border ml-auto&quot;&gt;&lt;/div&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

使用浮动设置右对齐

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;右对齐&lt;/h3&gt;
&lt;div class=&quot;clearfix&quot;&gt;
 &lt;div class=&quot;spinner-border float-right&quot;&gt;&lt;/div&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

使用文本类

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;居中对齐&lt;/h3&gt;
&lt;div class=&quot;text-center&quot;&gt;
 &lt;div class=&quot;spinner-border&quot;&gt;&lt;/div&gt;
&lt;/div&gt;
&lt;br&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;右对齐&lt;/h3&gt;
&lt;div class=&quot;text-right&quot;&gt;
 &lt;div class=&quot;spinner-border&quot;&gt;&lt;/div&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#按钮旋转器)按钮旋转器

可以将旋转器嵌入到按钮中，显示加载中的状态。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;按钮旋转器&lt;/h3&gt;
&lt;button class=&quot;btn btn-danger&quot; type=&quot;button&quot; disabled&gt;
 &lt;span class=&quot;spinner-border spinner-border-sm&quot;&gt;&lt;/span&gt;
&lt;/button&gt;
&lt;button class=&quot;btn btn-danger&quot; type=&quot;button&quot; disabled&gt;
 &lt;span class=&quot;spinner-border spinner-border-sm&quot;&gt;&lt;/span&gt;
 loading...
&lt;/button&gt;
&lt;hr&gt;
&lt;button class=&quot;btn btn-danger&quot; type=&quot;button&quot; disabled&gt;
 &lt;span class=&quot;spinner-grow spinner-grow-sm&quot;&gt;&lt;/span&gt;
&lt;/button&gt;
&lt;button class=&quot;btn btn-danger&quot; type=&quot;button&quot; disabled&gt;
 &lt;span class=&quot;spinner-grow spinner-grow-sm&quot;&gt;&lt;/span&gt;
 loading...
&lt;/button&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

### [](#卡片)卡片

#### [](#定义卡片)定义卡片

Card 是 Bootstrap 4 中的一个多功能组件，常用于显示内容块。基本的卡片由 .card 类定义。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;卡片&lt;/h3&gt;
&lt;div class=&quot;card&quot; style=&quot;width: 30rem&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;h5 class=&quot;card-title&quot;&gt;卡片标题&lt;/h5&gt;
 &lt;p class=&quot;card-text&quot;&gt;内容&lt;/p&gt;
 &lt;a href=&quot;#&quot; class=&quot;btn btn-primary&quot;&gt;链接按钮&lt;/a&gt;
 &lt;/div&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#卡片的内容类型)卡片的内容类型

卡片可以包含多种内容类型：标题、文本、列表、图片、链接等。

> 

卡片的主体

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;卡片的主题&lt;/h3&gt;
&lt;div class=&quot;card&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 这是卡片主题中的一些文本
 &lt;/div&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

卡片的标题、文本和链接

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;卡片的主题，文本和链接&lt;/h3&gt;
&lt;div class=&quot;card&quot; style=&quot;width: 18rem&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;h5 class=&quot;card-title&quot;&gt;卡片的标题&lt;/h5&gt;
 &lt;h6 class=&quot;card-subtitle mb-2 text-muted&quot;&gt;卡片的副标题&lt;/h6&gt;
 &lt;p class=&quot;card-text&quot;&gt;卡片包含标题，副标题，链接和文本内容。&lt;/p&gt;
 &lt;a href=&quot;#&quot; class=&quot;card-link&quot;&gt;卡片的链接1&lt;/a&gt;
 &lt;a href=&quot;#&quot; class=&quot;card-link&quot;&gt;卡片的链接2&lt;/a&gt;
 &lt;/div&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

卡片中的图像

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;卡片中的图像&lt;/h3&gt;
&lt;div class=&quot;card float-left&quot; style=&quot;width: 25rem&quot;&gt;
 &lt;img src=&quot;http://img2.imgtn.bdimg.com/it/u=3751153382,1396916542&amp;fm=26&amp;gp=0.jpg&quot; class=&quot;card-img-top&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;p class=&quot;card-text&quot;&gt;跳交际舞的青少年人物&lt;/p&gt;
 &lt;/div&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

列表组

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;列表组&lt;/h3&gt;
&lt;div class=&quot;card&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;新闻类别&lt;/div&gt;
 &lt;ul class=&quot;list-group list-group-flush&quot;&gt;
 &lt;li class=&quot;list-group-item&quot;&gt;新闻列表一&lt;/li&gt;
 &lt;li class=&quot;list-group-item&quot;&gt;新闻列表二&lt;/li&gt;
 &lt;li class=&quot;list-group-item&quot;&gt;新闻列表三&lt;/li&gt;
 &lt;/ul&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

页眉和页脚

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;页眉和页脚&lt;/h3&gt;
&lt;div class=&quot;card text-center&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;诗歌欣赏&lt;/div&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;h5 class=&quot;card-title&quot;&gt;菩萨蛮•人人尽说江南好&lt;/h5&gt;
 &lt;p class=&quot;card-text&quot;&gt;人人尽说江南好，游人只合江南老。春水碧于天，画船听雨眠。垆边人似月，皓腕凝霜雪。未老莫还乡，还乡须断肠。&lt;/p&gt;
 &lt;a href=&quot;#&quot; class=&quot;btn btn-primary&quot;&gt;诗歌分析&lt;/a&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card-footer&quot;&gt;作者：韦庄&lt;/div&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

使用网格控制

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;使用网格布局控制卡片的宽度&lt;/h3&gt;
&lt;div class=&quot;row&quot;&gt;
 &lt;div class=&quot;col-sm-6&quot;&gt;
 &lt;div class=&quot;card&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;头部&lt;/div&gt;
 &lt;div class=&quot;card-body&quot;&gt;主题&lt;/div&gt;
 &lt;div class=&quot;card-footer&quot;&gt;底部&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-sm-6&quot;&gt;
 &lt;div class=&quot;card&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;头部&lt;/div&gt;
 &lt;div class=&quot;card-body&quot;&gt;主题&lt;/div&gt;
 &lt;div class=&quot;card-footer&quot;&gt;底部&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#控制卡片的宽度)控制卡片的宽度

可以通过 style 属性直接控制卡片的宽度，或者使用 Bootstrap 的栅格系统来进行布局。

> 

使用宽度类控制

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;使用宽度类来控制卡片的宽度&lt;/h3&gt;
&lt;div class=&quot;card w-50 mb-3&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;卡片主题(w-50)&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card w-75 mb-3&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;卡片主题(w-75)&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card w-100 mb-3&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;卡片主题(w-100)&lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

使用css样式控制

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;使用css样式来控制卡片的宽度&lt;/h3&gt;
&lt;div class=&quot;card mb-3&quot; style=&quot;width: 15rem&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;卡片主题(15rem)&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card mb-3&quot; style=&quot;width: 30rem&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;卡片主题(30rem)&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card mb-3&quot; style=&quot;width: 45rem&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;卡片主题(45rem)&lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#文本对齐方式)文本对齐方式

通过 `text-center`, `text-left`, `text-right` 等类可以控制卡片内文本的对齐方式。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;文本的对齐方式&lt;/h3&gt;
&lt;h4&gt;居中对齐&lt;/h4&gt;
&lt;div class=&quot;card text-center&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;页眉&lt;/div&gt;
 &lt;div class=&quot;card-body&quot;&gt;卡片的主体&lt;/div&gt;
 &lt;div class=&quot;card-footer&quot;&gt;页脚&lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#添加导航)添加导航

可以在卡片内添加导航条，实现选项卡式的内容展示。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;添加标签导航&lt;/h3&gt;
&lt;div class=&quot;card&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;
 &lt;ul class=&quot;nav nav-tabs card-header-tabs&quot;&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a class=&quot;nav-link active&quot; id=&quot;home-table&quot; data-toggle=&quot;tab&quot; href=&quot;#nav1&quot;&gt;电影&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a class=&quot;nav-link&quot; id=&quot;profile-table&quot; data-toggle=&quot;tab&quot; href=&quot;#nav2&quot;&gt;电视剧&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a class=&quot;nav-link&quot; id=&quot;contact-table&quot; data-toggle=&quot;tab&quot; href=&quot;#nav3&quot;&gt;动漫&lt;/a&gt;
 &lt;/li&gt;
 &lt;/ul&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card-body tab-content&quot;&gt;
 &lt;div class=&quot;tab-pane fade show active&quot; id=&quot;nav1&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;h5 class=&quot;card-title&quot;&gt;电影&lt;/h5&gt;
 &lt;p class=&quot;card-text&quot;&gt;&lt;input type=&quot;text&quot; class=&quot;form-control&quot;&gt;&lt;/p&gt;
 &lt;a href=&quot;#&quot; class=&quot;btn btn-primary&quot;&gt;搜索&lt;/a&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;tab-pane fade show&quot; id=&quot;nav2&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;h5 class=&quot;card-title&quot;&gt;电视剧&lt;/h5&gt;
 &lt;p class=&quot;card-text&quot;&gt;&lt;input type=&quot;text&quot; class=&quot;form-control&quot;&gt;&lt;/p&gt;
 &lt;a href=&quot;#&quot; class=&quot;btn btn-primary&quot;&gt;搜索&lt;/a&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;tab-pane fade show&quot; id=&quot;nav3&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;h5 class=&quot;card-title&quot;&gt;动漫&lt;/h5&gt;
 &lt;p class=&quot;card-text&quot;&gt;&lt;input type=&quot;text&quot; class=&quot;form-control&quot;&gt;&lt;/p&gt;
 &lt;a href=&quot;#&quot; class=&quot;btn btn-primary&quot;&gt;搜索&lt;/a&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#图像背景)图像背景

卡片可以将图片作为背景，并叠加内容。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;图像背景&lt;/h3&gt;
&lt;div class=&quot;card bg-dark text-white&quot;&gt;
 &lt;img src=&quot;https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2311641753,3379985723&amp;fm=26&amp;gp=0.jpg&quot; alt=&quot;&quot; class=&quot;card-img&quot;&gt;
 &lt;div class=&quot;card-img-overlay&quot;&gt;
 &lt;h5 class=&quot;card-title&quot;&gt;雄鹰&lt;/h5&gt;
 &lt;p class=&quot;card-text&quot;&gt;相当雄鹰，不是为了自由飞翔的快乐，而是为了那份搏击蓝天的勇气。&lt;/p&gt;
 &lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#卡片风格)卡片风格

可以使用不同的类如 `.card-primary`, `.card-success` 等来改变卡片的风格。

> 

背景颜色

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;卡片的背景颜色&lt;/h3&gt;
&lt;div class=&quot;card text-white bg-primary mb-3&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;主卡标头&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card text-white bg-secondary mb-3&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;副卡标头&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card text-white bg-success mb-3&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;成功卡标头&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card text-white bg-danger mb-3&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;危险卡标头&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card text-white bg-warning mb-3&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;警告卡标头&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card text-white bg-info mb-3&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;信息卡标头&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card text-dark bg-light mb-3&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;光卡标头&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card text-white bg-dark mb-3&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;暗卡标头&lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

边框颜色

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;卡片的边框颜色&lt;/h3&gt;
&lt;div class=&quot;card border-primary mb-3&quot;&gt;
 &lt;div class=&quot;card-header text-primary&quot;&gt;Header&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card border-secondary mb-3&quot;&gt;
 &lt;div class=&quot;card-header text-secondary&quot;&gt;Header&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card border-success mb-3&quot;&gt;
 &lt;div class=&quot;card-header text-success&quot;&gt;Header&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card border-danger mb-3&quot;&gt;
 &lt;div class=&quot;card-header text-danger&quot;&gt;Header&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card border-warning mb-3&quot;&gt;
 &lt;div class=&quot;card-header text-warning&quot;&gt;Header&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card border-info mb-3&quot;&gt;
 &lt;div class=&quot;card-header text-info&quot;&gt;Header&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card border-light mb-3&quot;&gt;
 &lt;div class=&quot;card-header text-dark&quot;&gt;Header&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;card border-dark mb-3&quot;&gt;
 &lt;div class=&quot;card-header text-dark&quot;&gt;Header&lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

设计样式

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;设计样式&lt;/h3&gt;
&lt;div class=&quot;card border-success mb-3&quot; style=&quot;max-width: 25rem&quot;&gt;
 &lt;div class=&quot;card-header bg-transparent border-success text-center&quot;&gt;作文&lt;/div&gt;
 &lt;div class=&quot;card-body text-success&quot;&gt;
 &lt;h5 class=&quot;card-title&quot;&gt;雄鹰&lt;/h5&gt;
 &lt;p class=&quot;card-text&quot;&gt;对于雄鹰而言，天上的风再大，也只是锻炼翅膀的机会而已。&lt;/p&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card-footer bg-transparent border-success text-center&quot;&gt;小明&lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#卡片排版)卡片排版

可以通过栅格系统将卡片排版为多列布局，使用 .col 类来实现。

> 

卡片组

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;卡片组&lt;/h3&gt;
&lt;div class=&quot;card-group&quot;&gt;
 &lt;div class=&quot;card&quot;&gt;
 &lt;img src=&quot;https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3547718760,1213518458&amp;fm=26&amp;gp=0.jpg&quot; class=&quot;card-img-top&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;h5 class=&quot;card-title&quot;&gt;雄鹰&lt;/h5&gt;
 &lt;p class=&quot;card-text&quot;&gt;天空雄鹰，没人鼓掌，也在飞翔；深山野花，没人欣赏，也在芬芳。&lt;/p&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card-footer&quot;&gt;
 &lt;small&gt;卡片组中页脚会自动对齐&lt;/small&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card&quot;&gt;
 &lt;img src=&quot;https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3547718760,1213518458&amp;fm=26&amp;gp=0.jpg&quot; class=&quot;card-img-top&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;h5 class=&quot;card-title&quot;&gt;雄鹰&lt;/h5&gt;
 &lt;p class=&quot;card-text&quot;&gt;如果你想像雄鹰一样翱翔天空，那你就要和雄鹰一起飞翔，而不要与燕为伍。&lt;/p&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card-footer&quot;&gt;
 &lt;small&gt;卡片组中页脚会自动对齐&lt;/small&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card&quot;&gt;
 &lt;img src=&quot;https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3547718760,1213518458&amp;fm=26&amp;gp=0.jpg&quot; class=&quot;card-img-top&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;h5 class=&quot;card-title&quot;&gt;雄鹰&lt;/h5&gt;
 &lt;p class=&quot;card-text&quot;&gt;想要在知识的天空中摘星吉月，探索宝藏，就要像雄鹰那样顽强，搏击风云，振翅翱翔！&lt;/p&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card-footer&quot;&gt;
 &lt;small&gt;卡片组中页脚会自动对齐&lt;/small&gt;
 &lt;/div&gt;
 &lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

卡片阵列

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;卡片阵列&lt;/h3&gt;
&lt;div class=&quot;card-deck&quot;&gt;
 &lt;div class=&quot;card&quot;&gt;
 &lt;img src=&quot;https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3547718760,1213518458&amp;fm=26&amp;gp=0.jpg&quot; class=&quot;card-img-top&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;h5 class=&quot;card-title&quot;&gt;雄鹰&lt;/h5&gt;
 &lt;p class=&quot;card-text&quot;&gt;天空雄鹰，没人鼓掌，也在飞翔；深山野花，没人欣赏，也在芬芳。&lt;/p&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card-footer&quot;&gt;
 &lt;small&gt;卡片组中页脚会自动对齐&lt;/small&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card&quot;&gt;
 &lt;img src=&quot;https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3547718760,1213518458&amp;fm=26&amp;gp=0.jpg&quot; class=&quot;card-img-top&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;h5 class=&quot;card-title&quot;&gt;雄鹰&lt;/h5&gt;
 &lt;p class=&quot;card-text&quot;&gt;如果你想像雄鹰一样翱翔天空，那你就要和雄鹰一起飞翔，而不要与燕为伍。&lt;/p&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card-footer&quot;&gt;
 &lt;small&gt;卡片组中页脚会自动对齐&lt;/small&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card&quot;&gt;
 &lt;img src=&quot;https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3547718760,1213518458&amp;fm=26&amp;gp=0.jpg&quot; class=&quot;card-img-top&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;h5 class=&quot;card-title&quot;&gt;雄鹰&lt;/h5&gt;
 &lt;p class=&quot;card-text&quot;&gt;想要在知识的天空中摘星吉月，探索宝藏，就要像雄鹰那样顽强，搏击风云，振翅翱翔！&lt;/p&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card-footer&quot;&gt;
 &lt;small&gt;卡片组中页脚会自动对齐&lt;/small&gt;
 &lt;/div&gt;
 &lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

多列卡片浮动排版

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;卡片列&lt;/h3&gt;
&lt;div class=&quot;card-columns&quot;&gt;
 &lt;div class=&quot;card bg-primary p-3&quot;&gt;
 &lt;img src=&quot;https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2534506313,1688529724&amp;fm=26&amp;gp=0.jpg&quot; class=&quot;card-img-top&quot; alt=&quot;&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card bg-dark p-3&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592671136450&amp;di=383a697fe84e0bdf70bc5961d8f43a8d&amp;imgtype=0&amp;src=http%3A%2F%2Fa2.att.hudong.com%2F36%2F48%2F19300001357258133412489354717.jpg&quot; class=&quot;card-img-top&quot; alt=&quot;&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card bg-info p-3&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592671136450&amp;di=c16fcf8aa8f00aa885828746196ace9f&amp;imgtype=0&amp;src=http%3A%2F%2Fa0.att.hudong.com%2F56%2F12%2F01300000164151121576126282411.jpg&quot; class=&quot;card-img-top&quot; alt=&quot;&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card bg-light p-3&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592671136450&amp;di=ae7d1c3e776315c51f3655c1b7e4eff5&amp;imgtype=0&amp;src=http%3A%2F%2Fa0.att.hudong.com%2F64%2F76%2F20300001349415131407760417677.jpg&quot; class=&quot;card-img-top&quot; alt=&quot;&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card bg-warning p-3&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592671136450&amp;di=3a6fcd999f3061e01f55f1d73d8dc113&amp;imgtype=0&amp;src=http%3A%2F%2Fa0.att.hudong.com%2F27%2F10%2F01300000324235124757108108752.jpg&quot; class=&quot;card-img-top&quot; alt=&quot;&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card bg-danger p-3&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592671136449&amp;di=32cfa6d2775ae32d8f887c88133b039f&amp;imgtype=0&amp;src=http%3A%2F%2Fa3.att.hudong.com%2F68%2F61%2F300000839764127060614318218_950.jpg&quot; class=&quot;card-img-top&quot; alt=&quot;&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card bg-secondary p-3&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592671176807&amp;di=5a0cb0e2deb1773f78442d2444cfc86d&amp;imgtype=0&amp;src=http%3A%2F%2Fimg2.imgtn.bdimg.com%2Fit%2Fu%3D3984473917%2C238095211%26fm%3D214%26gp%3D0.jpg&quot; class=&quot;card-img-top&quot; alt=&quot;&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card bg-success p-3&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592671136449&amp;di=cb600a99414969d3743b96be8d2de659&amp;imgtype=0&amp;src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F5366d0160924ab1857f1cbae35fae6cd7a890b47.jpg&quot; class=&quot;card-img-top&quot; alt=&quot;&quot;&gt;
 &lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

### [](#案例实训1—仿云巴网站)案例实训1—仿云巴网站

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;
 &lt;style&gt;
 .color1&#123;
 color: #00adee;
 &#125;
 .size&#123;
 font-size: 20px;
 &#125;
 .line&#123;
 border-bottom: 2px solid #00adee;
 width: 100px;
 margin: auto;
 &#125;
 .card-header&#123;
 background: #00ceef;
 color: white;
 &#125;
 .color2&#123;
 background: #e4e4e4;
 color: #13082b;
 &#125;
 .card-body img&#123;
 margin-bottom: 30px;
 &#125;
 .card-body p&#123;
 font-size: 18px;
 &#125;
 .row h4&#123;
 font-weight: 900;
 &#125;
 .card&#123;
 min-height: 400px;
 &#125;
 .card&#123;
 transition: text-shadow 3s linear;
 &#125;
 .card:hover&#123;
 box-shadow: 3px 3px 20px 0 #a4b9b4,-3px -3px 20px 0 #a4b9b4;
 &#125;
 &lt;/style&gt;
&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h2 class=&quot;color1 text-center&quot;&gt;云巴示例和案例&lt;/h2&gt;
&lt;div class=&quot;line&quot;&gt;&lt;/div&gt;
&lt;p class=&quot;text-center my-2 size&quot;&gt;我们为移动应用以及智能设备开发提供后端服务，助你打造最佳实时应用&lt;/p&gt;
&lt;div class=&quot;row&quot;&gt;
 &lt;div class=&quot;col-md-4&quot;&gt;
 &lt;div class=&quot;card mb-4 text-center&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;&lt;h4&gt;视频直播互动&lt;/h4&gt;&lt;/div&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;img src=&quot;http://img5.imgtn.bdimg.com/it/u=2029597372,1520689243&amp;fm=26&amp;gp=0.jpg&quot; class=&quot;w-75&quot; alt=&quot;&quot;&gt;
 &lt;p class=&quot;card-text&quot;&gt;借助云巴的第三方直播互动技术，直播平台可快速实现弹幕，打赏，点赞，点爱心等直播互动功能。&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-md-4&quot;&gt;
 &lt;div class=&quot;card mb-4 text-center&quot;&gt;
 &lt;div class=&quot;card-header color2&quot;&gt;&lt;h4&gt;掌阅iReader&lt;/h4&gt;&lt;/div&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;img src=&quot;http://img5.imgtn.bdimg.com/it/u=3316554837,488915588&amp;fm=15&amp;gp=0.jpg&quot; class=&quot;w-75&quot; alt=&quot;&quot;&gt;
 &lt;p class=&quot;card-text&quot;&gt;用户量大对公司来说是一件好事，然而，巨大的用户量也给iReader后端处理带来了麻烦。&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-md-4&quot;&gt;
 &lt;div class=&quot;card mb-4 text-center&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;&lt;h4&gt;即时通信&lt;/h4&gt;&lt;/div&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;img src=&quot;http://img.ui.cn/data/file/9/5/4/702459.png&quot; class=&quot;w-75&quot; alt=&quot;&quot;&gt;
 &lt;p class=&quot;card-text&quot;&gt;随着移动互联网的发展，社交需求场景不再局限于qq,微信等个人聊天工具&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-md-4&quot;&gt;
 &lt;div class=&quot;card mb-4 text-center&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;&lt;h4&gt;共享单车&lt;/h4&gt;&lt;/div&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;img src=&quot;http://blog.mydrivers.com/img/20170904/s_caff385cee4f42d8ada305c6dbd559e2.png&quot; class=&quot;w-75&quot; alt=&quot;&quot;&gt;
 &lt;p class=&quot;card-text&quot;&gt;使用云巴SDK的云巴共享单车锁，采用GPS定位，用户可通过蓝牙+GPRS扫码开锁。&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-md-4&quot;&gt;
 &lt;div class=&quot;card mb-4 text-center&quot;&gt;
 &lt;div class=&quot;card-header color2&quot;&gt;&lt;h4&gt;智能门锁&lt;/h4&gt;&lt;/div&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;img src=&quot;http://y3.ifengimg.com/a/2015_33/dfc2be18ff87ffd.jpg&quot; class=&quot;w-75&quot; alt=&quot;&quot;&gt;
 &lt;p class=&quot;card-text&quot;&gt;云巴智能蓝牙门锁一站式解决方案。&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-md-4&quot;&gt;
 &lt;div class=&quot;card mb-4 text-center&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;&lt;h4&gt;智能车位锁&lt;/h4&gt;&lt;/div&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 &lt;img src=&quot;http://img2.imgtn.bdimg.com/it/u=432679038,2716987874&amp;fm=26&amp;gp=0.jpg&quot; class=&quot;w-75&quot; alt=&quot;&quot;&gt;
 &lt;p class=&quot;card-text&quot;&gt;云巴共享车位方案包含智能车位锁，APP开发，电子控制系统，提供一站式解决方案。&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

### [](#案例实训2—动态进度条及百分比数字显示)案例实训2—动态进度条及百分比数字显示

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Bootstrap 4的新增组件——旋转器和卡片&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;
 &lt;style&gt;
 body &#123;
 background: #efeeea;
 color: #757575;
 &#125;

 .wrapper &#123;
 width: 350px;
 margin: 200px auto;
 &#125;

 .wrapper .load-bar &#123;
 width: 100%;
 height: 25px;
 border-radius: 30px;
 background: #dcdbd7;
 position: relative;
 &#125;

 .wrapper .load-bar-inner &#123;
 height: 99%;
 width: 0;
 border-radius: inherit;
 position: relative;
 background: #c2d7ac;
 animation: loader 10s linear infinite;
 &#125;

 @keyframes loader &#123;
 from &#123;
 width: 0%;
 &#125;
 to &#123;
 width: 100%
 &#125;
 &#125;

 .wrapper #counter &#123;
 position: absolute;
 background: #eeeff3;
 background: linear-gradient(#eeeff3, #cbcbd3);
 padding: 5px 10px;
 border-radius: 0.4em;
 left: -25px;
 top: -50px;
 font-size: 12px;
 font-weight: bold;
 width: 44px;
 animation: counter 10s linear infinite;
 &#125;

 .wrapper #counter:after &#123;
 content: &quot;&quot;;
 position: absolute;
 width: 10px;
 height: 10px;
 background: #cbcbd3;
 transform: rotate(45deg);
 left: 50%;
 margin-left: -4px;
 bottom: -4px;
 border-radius: 0 0 3px 0;
 &#125;

 @keyframes counter &#123;
 from &#123;
 left: -25px
 &#125;
 to &#123;
 left: 323px
 &#125;
 &#125;

 .wrapper .load-bar:hover .load-bar-inner, .wrapper .load-bar:hover #counter &#123;
 animation-play-state: paused;
 &#125;
 .wrapper h1&#123;
 font-size: 28px;
 padding: 20px 0 8px 0;
 &#125;
 .wrapper p&#123;
 font-size: 13px;
 &#125;
 &lt;/style&gt;
&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;div class=&quot;wrapper&quot;&gt;
 &lt;div class=&quot;load-bar&quot;&gt;
 &lt;div class=&quot;load-bar-inner&quot;&gt;
 &lt;span id=&quot;counter&quot;&gt;&lt;/span&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;h1 class=&quot;text-center&quot;&gt;&lt;span class=&quot;spinner-border mr-4&quot;&gt;&lt;/span&gt;Loading...&lt;/h1&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 //定义定时器，0.1秒调用一次increment()方法
 var interval = setInterval(increment, 100);
 var current = 0;

 //定义increment()方法
 function increment() &#123;
 // 定时器每调用一次，自增一
 current ++;
 // 设置指示器的内容
 $(&#x27;#counter&#x27;).html(current + &#x27;%&#x27;);
 // 当current变量值为100时重置
 if (current == 100)&#123;current = 0;&#125;
 &#125;
 // 当鼠标悬浮在Load-bar上时，清除定时器
 $(&#x27;.load-bar&#x27;).mouseover(function () &#123;
 clearInterval(interval);
 &#125;)
 // 当鼠标移开load-bar时，启动定时器
 .mouseout(function () &#123;
 interval = setInterval(increment,100);
 &#125;)
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

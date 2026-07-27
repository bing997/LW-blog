---
title: 11-快速认识JavaScript 插件
date: 2024-08-20
categories:
  - bootstrap
tags:
  - bootstrap
  - 教程
---

## [](#快速认识JavaScript-插件)快速认识JavaScript 插件

### [](#插件概述)插件概述

#### [](#插件分类)插件分类

Bootstrap插件分为交互性组件（如模态框、警告框等）和导航性组件（如下拉菜单、标签页等）

#### [](#安装插件)安装插件

Bootstrap插件可以通过引入Bootstrap库来使用。通常在HTML文件的头部引入Bootstrap的CSS和JS文件。

#### [](#调用插件)调用插件

插件的调用可以通过数据属性（如data-bs-toggle）或JavaScript API来实现。

#### [](#事件)事件

每个Bootstrap插件都有相应的事件，可以使用这些事件来处理用户交互。

### [](#按钮)按钮

#### [](#切换状态)切换状态

使用Bootstrap的按钮组可以实现切换按钮的状态（如启用&#x2F;禁用）

&lt;!-- 切换按钮状态 --&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot; data-bs-toggle=&quot;button&quot; aria-pressed=&quot;false&quot; autocomplete=&quot;off&quot;&gt;
 单击切换
&lt;/button&gt;

#### [](#按钮式复选框和单选框)按钮式复选框和单选框

可以将按钮用作复选框或单选框，允许用户选择一个或多个选项。

> 

按钮式复选框1

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;复选框&lt;/h3&gt;
&lt;div class=&quot;btn-group&quot; data-toggle=&quot;buttons&quot;&gt;
 &lt;label class=&quot;btn btn-primary active&quot;&gt;
 &lt;input type=&quot;checkbox&quot; checked autocomplete=&quot;off&quot;&gt;复选框1
 &lt;/label&gt;
 &lt;label class=&quot;btn btn-primary&quot;&gt;
 &lt;input type=&quot;checkbox&quot; autocomplete=&quot;off&quot;&gt;复选框2
 &lt;/label&gt;
 &lt;label class=&quot;btn btn-primary&quot;&gt;
 &lt;input type=&quot;checkbox&quot; autocomplete=&quot;off&quot;&gt;复选框3
 &lt;/label&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

按钮式复选框2

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;复选框&lt;/h3&gt;
&lt;div class=&quot;btn-group btn-group-toggle&quot; data-toggle=&quot;buttons&quot;&gt;
 &lt;label class=&quot;btn btn-primary active&quot;&gt;
 &lt;input type=&quot;checkbox&quot; checked autocomplete=&quot;off&quot;&gt;复选框1
 &lt;/label&gt;
 &lt;label class=&quot;btn btn-primary&quot;&gt;
 &lt;input type=&quot;checkbox&quot; autocomplete=&quot;off&quot;&gt;复选框2
 &lt;/label&gt;
 &lt;label class=&quot;btn btn-primary&quot;&gt;
 &lt;input type=&quot;checkbox&quot; autocomplete=&quot;off&quot;&gt;复选框3
 &lt;/label&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

按钮式单选框1

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;单选框&lt;/h3&gt;
&lt;div class=&quot;btn-group&quot; data-toggle=&quot;buttons&quot;&gt;
 &lt;label class=&quot;btn btn-primary active&quot;&gt;
 &lt;input type=&quot;radio&quot; name=&quot;options&quot; id=&quot;option1&quot; checked autocomplete=&quot;off&quot;&gt;单选框1
 &lt;/label&gt;
 &lt;label class=&quot;btn btn-primary&quot;&gt;
 &lt;input type=&quot;radio&quot; name=&quot;options&quot; id=&quot;option2&quot; autocomplete=&quot;off&quot;&gt;单选框2
 &lt;/label&gt;
 &lt;label class=&quot;btn btn-primary&quot;&gt;
 &lt;input type=&quot;radio&quot; name=&quot;options&quot; id=&quot;option3&quot; autocomplete=&quot;off&quot;&gt;单选框3
 &lt;/label&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

按钮式单选框2

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;单选框&lt;/h3&gt;
&lt;div class=&quot;btn-group btn-group-toggle&quot; data-toggle=&quot;buttons&quot;&gt;
 &lt;label class=&quot;btn btn-primary active&quot;&gt;
 &lt;input type=&quot;radio&quot; name=&quot;options&quot; id=&quot;option1&quot; checked autocomplete=&quot;off&quot;&gt;单选框1
 &lt;/label&gt;
 &lt;label class=&quot;btn btn-primary&quot;&gt;
 &lt;input type=&quot;radio&quot; name=&quot;options&quot; id=&quot;option2&quot; autocomplete=&quot;off&quot;&gt;单选框2
 &lt;/label&gt;
 &lt;label class=&quot;btn btn-primary&quot;&gt;
 &lt;input type=&quot;radio&quot; name=&quot;options&quot; id=&quot;option3&quot; autocomplete=&quot;off&quot;&gt;单选框3
 &lt;/label&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

### [](#警告框)警告框

#### [](#关闭警告框)关闭警告框

警告框是用于向用户显示重要信息的组件。可以通过按钮或代码关闭警告框。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;div class=&quot;alert alert-warning fade show&quot;&gt;
 &lt;strong&gt;警告信息！&lt;/strong&gt;程序中出现一个语法问题。
 &lt;button type=&quot;button&quot; class=&quot;close&quot; data-dismiss=&quot;alert&quot;&gt;
 &lt;span&gt;&amp;times;&lt;/span&gt;
 &lt;/button&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#添加用户行为)添加用户行为

可以为警告框添加自定义事件处理，如在关闭时执行某些操作。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;div class=&quot;alert alert-warning fade show&quot;&gt;
 &lt;strong&gt;警告信息！&lt;/strong&gt;程序中出现一个语法问题。
 &lt;button type=&quot;button&quot; class=&quot;close&quot;&gt;
 &lt;span&gt;&amp;times;&lt;/span&gt;
 &lt;/button&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 $(&#x27;.alert&#x27;).click(function () &#123;
 $(&#x27;.alert&#x27;).alert(&#x27;close&#x27;)
 &#125;)
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

监听警告框示例

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;div class=&quot;alert alert-warning fade show&quot;&gt;
 &lt;strong&gt;警告信息！&lt;/strong&gt;程序中出现一个语法问题。
 &lt;button type=&quot;button&quot; class=&quot;close&quot;&gt;
 &lt;span&gt;&amp;times;&lt;/span&gt;
 &lt;/button&gt;
&lt;/div&gt;
&lt;!--模态框--&gt;
&lt;div class=&quot;modal&quot; id=&quot;Model-test&quot;&gt;
 &lt;div class=&quot;modal-dialog&quot;&gt;
 &lt;div class=&quot;modal-content&quot;&gt;
 &lt;div class=&quot;modal-header&quot;&gt;
 &lt;h5 class=&quot;modal-title&quot;&gt;提示&lt;/h5&gt;
 &lt;button type=&quot;button&quot; class=&quot;close&quot; data-dismiss=&quot;modal&quot;&gt;&amp;times;&lt;/button&gt;
 &lt;/div&gt;
 &lt;div class=&quot;modal-body&quot;&gt;你确定要关闭警告框吗？&lt;/div&gt;
 &lt;div class=&quot;modal-footer&quot;&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot; data-dismiss=&quot;modal&quot;&gt;是&lt;/button&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn btn-secondary&quot; data-dismiss=&quot;modal&quot;&gt;否&lt;/button&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 $(&#x27;.close&#x27;).click(function () &#123;
 $(this).alert(&#x27;close&#x27;)
 &#125;);
 $(&#x27;.alert&#x27;).on(&#x27;close.bs.alert&#x27;,function (e) &#123;
 $(&#x27;#Model-test&#x27;).modal();
 &#125;)
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

### [](#下拉菜单)下拉菜单

#### [](#调用下拉菜单)调用下拉菜单

下拉菜单允许用户从一组选项中选择一个。它可以通过数据属性或JavaScript API进行初始化。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;div class=&quot;dropdown&quot;&gt;
 &lt;button class=&quot;btn btn-primary dropdown-toggle&quot; data-toggle=&quot;dropdown&quot; type=&quot;button&quot;&gt;下拉菜单&lt;/button&gt;
 &lt;div class=&quot;dropdown-menu&quot;&gt;
 &lt;a href=&quot;#&quot; class=&quot;dropdown-item&quot;&gt;菜单项一&lt;/a&gt;
 &lt;a href=&quot;#&quot; class=&quot;dropdown-item&quot;&gt;菜单项二&lt;/a&gt;
 &lt;a href=&quot;#&quot; class=&quot;dropdown-item&quot;&gt;菜单项三&lt;/a&gt;
 &lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#JavaScript调用下拉菜单)JavaScript调用下拉菜单

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;div class=&quot;dropdown&quot;&gt;
 &lt;button class=&quot;btn btn-primary dropdown-toggle&quot; type=&quot;button&quot;&gt;下拉菜单&lt;/button&gt;
 &lt;div class=&quot;dropdown-menu&quot;&gt;
 &lt;a href=&quot;#&quot; class=&quot;dropdown-item&quot;&gt;菜单项一&lt;/a&gt;
 &lt;a href=&quot;#&quot; class=&quot;dropdown-item&quot;&gt;菜单项二&lt;/a&gt;
 &lt;a href=&quot;#&quot; class=&quot;dropdown-item&quot;&gt;菜单项三&lt;/a&gt;
 &lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 $(&#x27;.btn&#x27;).dropdown();
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#添加用户行为-1)添加用户行为

可以为下拉菜单添加事件监听器，以处理用户的选择或其他交互行为。

> 

data属性配置参数

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;div class=&quot;dropdown&quot;&gt;
 &lt;button class=&quot;btn btn-primary dropdown-toggle&quot; data-toggle=&quot;dropdown&quot; data-offset=&quot;50,30&quot; type=&quot;button&quot;&gt;下拉菜单&lt;/button&gt;
 &lt;div class=&quot;dropdown-menu&quot;&gt;
 &lt;a href=&quot;#&quot; class=&quot;dropdown-item&quot;&gt;菜单项一&lt;/a&gt;
 &lt;a href=&quot;#&quot; class=&quot;dropdown-item&quot;&gt;菜单项二&lt;/a&gt;
 &lt;a href=&quot;#&quot; class=&quot;dropdown-item&quot;&gt;菜单项三&lt;/a&gt;
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

另一种方式

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;div class=&quot;dropdown&quot; id=&quot;dropdown&quot;&gt;
 &lt;button class=&quot;btn btn-primary dropdown-toggle&quot; data-toggle=&quot;dropdown&quot; type=&quot;button&quot;&gt;下拉菜单&lt;/button&gt;
 &lt;div class=&quot;dropdown-menu&quot;&gt;
 &lt;a href=&quot;#&quot; class=&quot;dropdown-item&quot;&gt;菜单项一&lt;/a&gt;
 &lt;a href=&quot;#&quot; class=&quot;dropdown-item&quot;&gt;菜单项二&lt;/a&gt;
 &lt;a href=&quot;#&quot; class=&quot;dropdown-item&quot;&gt;菜单项三&lt;/a&gt;
 &lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 $(&#x27;#dropdown&#x27;).on(&#x27;show.bs.dropdown&#x27;,function () &#123;
 $(this).children(&#x27;[data-toggle=&quot;dropdown&quot;]&#x27;).html(&#x27;开始显示下拉菜单&#x27;)
 &#125;);
 $(&#x27;#dropdown&#x27;).on(&#x27;shown.bs.dropdown&#x27;,function () &#123;
 $(this).children(&#x27;[data-toggle=&quot;dropdown&quot;]&#x27;).html(&#x27;下拉菜单显示完成&#x27;)
 &#125;);
 $(&#x27;#dropdown&#x27;).on(&#x27;hide.bs.dropdown&#x27;,function () &#123;
 $(this).children(&#x27;[data-toggle=&quot;dropdown&quot;]&#x27;).html(&#x27;开始隐藏下拉菜单&#x27;)
 &#125;);
 $(&#x27;#dropdown&#x27;).on(&#x27;hidden.bs.dropdown&#x27;,function () &#123;
 $(this).children(&#x27;[data-toggle=&quot;dropdown&quot;]&#x27;).html(&#x27;下拉菜单隐藏完成&#x27;)
 &#125;)
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

### [](#模态框)模态框

#### [](#定义模态框)定义模态框

模态框是一个覆盖在页面上的对话框，用于显示重要信息或接受用户输入。

&lt;!-- 模态框 --&gt;
&lt;div class=&quot;modal fade&quot; id=&quot;exampleModal&quot; tabindex=&quot;-1&quot; aria-labelledby=&quot;exampleModalLabel&quot; aria-hidden=&quot;true&quot;&gt;
 &lt;div class=&quot;modal-dialog&quot;&gt;
 &lt;div class=&quot;modal-content&quot;&gt;
 &lt;div class=&quot;modal-header&quot;&gt;
 &lt;h5 class=&quot;modal-title&quot; id=&quot;exampleModalLabel&quot;&gt;模态框标题&lt;/h5&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn-close&quot; data-bs-dismiss=&quot;modal&quot; aria-label=&quot;Close&quot;&gt;&lt;/button&gt;
 &lt;/div&gt;
 &lt;div class=&quot;modal-body&quot;&gt;
 这里是模态框的内容。
 &lt;/div&gt;
 &lt;div class=&quot;modal-footer&quot;&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn btn-secondary&quot; data-bs-dismiss=&quot;modal&quot;&gt;关闭&lt;/button&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot;&gt;保存更改&lt;/button&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
&lt;/div&gt;

#### [](#模态框布局和样式)模态框布局和样式

模态框的布局和样式可以根据需求进行调整，如控制宽度、高度、背景透明度等。

> 

模态框垂直居中

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;模态框垂直居中&lt;/h3&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot; data-toggle=&quot;modal&quot; data-target=&quot;#Modal&quot;&gt;打开模态框&lt;/button&gt;
&lt;div class=&quot;modal fade&quot; id=&quot;Modal&quot;&gt;
 &lt;div class=&quot;modal-dialog modal-dialog-centered&quot;&gt;
 &lt;div class=&quot;modal-content&quot;&gt;
 &lt;div class=&quot;modal-header&quot;&gt;
 &lt;h5 class=&quot;modal-title&quot; id=&quot;modalTitle&quot;&gt;模态框标题&lt;/h5&gt;
 &lt;button type=&quot;button&quot; class=&quot;close&quot; data-dismiss=&quot;modal&quot;&gt;&lt;span&gt;&amp;times;&lt;/span&gt;&lt;/button&gt;
 &lt;/div&gt;
 &lt;div class=&quot;modal-body&quot;&gt;模态框正文&lt;/div&gt;
 &lt;div class=&quot;modal-footer&quot;&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn btn-secondary&quot; data-dismiss=&quot;modal&quot;&gt;关闭&lt;/button&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot;&gt;提交&lt;/button&gt;
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

> 

设置模态框大小

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;设置模态框大小&lt;/h3&gt;
&lt;!--大尺寸模态框--&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot; data-toggle=&quot;modal&quot; data-target=&quot;.example-modal-lg&quot;&gt;大尺寸模态框&lt;/button&gt;
&lt;div class=&quot;modal example-modal-lg&quot;&gt;
 &lt;div class=&quot;modal-dialog modal-lg&quot;&gt;
 &lt;div class=&quot;modal-content&quot;&gt;
 &lt;div class=&quot;modal-header&quot;&gt;
 &lt;h5 class=&quot;modal-title&quot;&gt;大尺寸模态框&lt;/h5&gt;
 &lt;button type=&quot;button&quot; class=&quot;close&quot; data-dismiss=&quot;modal&quot;&gt;&lt;span&gt;&amp;times;&lt;/span&gt;&lt;/button&gt;
 &lt;/div&gt;
 &lt;div class=&quot;modal-body&quot;&gt;模态框正文&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
&lt;/div&gt;
&lt;!--小尺寸模态框--&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot; data-toggle=&quot;modal&quot; data-target=&quot;.example-modal-sm&quot;&gt;小尺寸模态框&lt;/button&gt;
&lt;div class=&quot;modal example-modal-sm&quot;&gt;
 &lt;div class=&quot;modal-dialog modal-sm&quot;&gt;
 &lt;div class=&quot;modal-content&quot;&gt;
 &lt;div class=&quot;modal-header&quot;&gt;
 &lt;h5 class=&quot;modal-title&quot;&gt;小尺寸模态框&lt;/h5&gt;
 &lt;button type=&quot;button&quot; class=&quot;close&quot; data-dismiss=&quot;modal&quot;&gt;&lt;span&gt;&amp;times;&lt;/span&gt;&lt;/button&gt;
 &lt;/div&gt;
 &lt;div class=&quot;modal-body&quot;&gt;模态框正文&lt;/div&gt;
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

模态框网格

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;模态框网格&lt;/h3&gt;
&lt;!--大尺寸模态框--&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot; data-toggle=&quot;modal&quot; data-target=&quot;#Modal&quot;&gt;打开模态框&lt;/button&gt;
&lt;div class=&quot;modal&quot; id=&quot;Modal&quot;&gt;
 &lt;div class=&quot;modal-dialog modal-dialog-centered&quot;&gt;
 &lt;div class=&quot;modal-content&quot;&gt;
 &lt;div class=&quot;modal-header&quot;&gt;
 &lt;h5 class=&quot;modal-title&quot; id=&quot;modal-Title&quot;&gt;模态框网格&lt;/h5&gt;
 &lt;button type=&quot;button&quot; class=&quot;close&quot; data-dismiss=&quot;modal&quot;&gt;&lt;span&gt;&amp;times;&lt;/span&gt;&lt;/button&gt;
 &lt;/div&gt;
 &lt;div class=&quot;modal-body&quot;&gt;
 &lt;div class=&quot;container&quot;&gt;
 &lt;div class=&quot;row&quot;&gt;
 &lt;div class=&quot;col-md-4 bg-success text-white&quot;&gt;.col-md-4&lt;/div&gt;
 &lt;div class=&quot;col-md-4 ml-auto bg-success text-white&quot;&gt;.col-md-4 .ml-auto&lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;row&quot;&gt;
 &lt;div class=&quot;col-md-4 ml-md-auto bg-danger text-white&quot;&gt;.col-md-4 .ml-md-auto&lt;/div&gt;
 &lt;div class=&quot;col-md-4 ml-md-auto bg-danger text-white&quot;&gt;.col-md-4 .ml-md-auto&lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;row&quot;&gt;
 &lt;div class=&quot;col-auto mr-auto bg-warning&quot;&gt;.col-auto .mr-auto&lt;/div&gt;
 &lt;div class=&quot;col-auto bg-warning&quot;&gt;.col-auto&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;modal-footer&quot;&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn btn-secondary&quot; data-dismiss=&quot;modal&quot;&gt;关闭&lt;/button&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot;&gt;提交&lt;/button&gt;
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

> 

弹窗和工具提示

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;弹窗和工具提示&lt;/h3&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot; data-toggle=&quot;modal&quot; data-target=&quot;#Modal&quot;&gt;打开模态框&lt;/button&gt;
&lt;div class=&quot;modal&quot; id=&quot;Modal&quot;&gt;
 &lt;div class=&quot;modal-dialog modal-dialog-centered&quot;&gt;
 &lt;div class=&quot;modal-content&quot;&gt;
 &lt;div class=&quot;modal-header&quot;&gt;
 &lt;h5 class=&quot;modal-header&quot; id=&quot;modalTitle&quot;&gt;模态框标题&lt;/h5&gt;
 &lt;button class=&quot;close&quot; type=&quot;button&quot; data-dismiss&gt;&amp;times;&lt;/button&gt;
 &lt;/div&gt;
 &lt;div class=&quot;modal-body&quot;&gt;
 &lt;div class=&quot;modal-body&quot;&gt;
 &lt;h5&gt;弹窗&lt;/h5&gt;
 &lt;p&gt;单击这个&lt;a href=&quot;#&quot; role=&quot;button&quot; class=&quot;btn btn-secondary popover-test&quot; title=&quot;弹窗标题&quot;
 data-content=&quot;弹窗的主题内容&quot;&gt;button&lt;/a&gt;触发一个弹窗。&lt;/p&gt;
 &lt;hr&gt;
 &lt;h5&gt;工具提示&lt;/h5&gt;
 &lt;p&gt;鼠标指针悬浮 &lt;a href=&quot;#&quot; class=&quot;tooltip-test&quot; title=&quot;链接一&quot;&gt;链接一&lt;/a&gt;和 &lt;a href=&quot;#&quot; class=&quot;tooltip-test&quot;
 title=&quot;链接二&quot;&gt;链接二&lt;/a&gt;触发工具提示。&lt;/p&gt;
 &lt;/div&gt;

 &lt;/div&gt;
 &lt;div class=&quot;modal-footer&quot;&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn btn-secondary&quot; data-dismiss=&quot;modal&quot;&gt;关闭&lt;/button&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot;&gt;提交&lt;/button&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(document).ready(function () &#123;
 // 找到对应的属性类别，添加弹窗和工具箱提示
 $(&#x27;.popover-test&#x27;).popover();
 $(&#x27;.tooltip-test&#x27;).tooltip();
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#调用模态框)调用模态框

可以通过按钮或JavaScript调用模态框。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot;&gt;打开模态框&lt;/button&gt;
&lt;div class=&quot;modal&quot; id=&quot;Modal-test&quot;&gt;
 &lt;div class=&quot;modal-dialog modal-dialog-centered&quot;&gt;
 &lt;div class=&quot;modal-content&quot;&gt;
 &lt;div class=&quot;modal-header&quot;&gt;
 &lt;h5 class=&quot;modal-header&quot; id=&quot;modalTitle&quot;&gt;模态框标题&lt;/h5&gt;
 &lt;button class=&quot;close&quot; type=&quot;button&quot; data-dismiss&gt;&amp;times;&lt;/button&gt;
 &lt;/div&gt;
 &lt;div class=&quot;modal-body&quot;&gt;
 &lt;div class=&quot;modal-body&quot;&gt;
 &lt;h5&gt;弹窗&lt;/h5&gt;
 &lt;p&gt;单击这个&lt;a href=&quot;#&quot; role=&quot;button&quot; class=&quot;btn btn-secondary popover-test&quot; title=&quot;弹窗标题&quot;
 data-content=&quot;弹窗的主题内容&quot;&gt;button&lt;/a&gt;触发一个弹窗。&lt;/p&gt;
 &lt;hr&gt;
 &lt;h5&gt;工具提示&lt;/h5&gt;
 &lt;p&gt;鼠标指针悬浮 &lt;a href=&quot;#&quot; class=&quot;tooltip-test&quot; title=&quot;链接一&quot;&gt;链接一&lt;/a&gt;和 &lt;a href=&quot;#&quot; class=&quot;tooltip-test&quot;
 title=&quot;链接二&quot;&gt;链接二&lt;/a&gt;触发工具提示。&lt;/p&gt;
 &lt;/div&gt;

 &lt;/div&gt;
 &lt;div class=&quot;modal-footer&quot;&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn btn-secondary&quot; data-dismiss=&quot;modal&quot;&gt;关闭&lt;/button&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot;&gt;提交&lt;/button&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 $(&#x27;.btn&#x27;).click(function () &#123;
 $(&#x27;#Modal-test&#x27;).modal();
 &#125;)
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#添加用户行为-2)添加用户行为

为模态框添加事件处理程序，以控制模态框的打开、关闭和交互行为。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot; data-target=&quot;#Modal-test&quot; data-toggle=&quot;modal&quot; data-backdrop=&quot;false&quot; data-keyboard=&quot;false&quot;&gt;打开模态框&lt;/button&gt;
&lt;div class=&quot;modal&quot; id=&quot;Modal-test&quot;&gt;
 &lt;div class=&quot;modal-dialog&quot;&gt;
 &lt;div class=&quot;modal-content&quot;&gt;
 &lt;div class=&quot;modal-header&quot;&gt;
 &lt;h5 class=&quot;modal-title&quot; id=&quot;modalTitle&quot;&gt;模态框标题&lt;/h5&gt;
 &lt;button class=&quot;close&quot; type=&quot;button&quot; data-dismiss=&quot;modal&quot;&gt;&amp;times;&lt;/button&gt;
 &lt;/div&gt;
 &lt;div class=&quot;modal-body&quot;&gt;模态框正文&lt;/div&gt;
 &lt;div class=&quot;modal-footer&quot;&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn btn-secondary&quot; data-dismiss=&quot;modal&quot;&gt;关闭&lt;/button&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot;&gt;保存&lt;/button&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 $(&#x27;#Modal-test&#x27;).on(&#x27;shown.bs.modal&#x27;,function () &#123;
 alert(&#x27;模态框显示完成&#x27;)
 &#125;);
 $(&#x27;#Modal-test&#x27;).on(&#x27;hidden.bs.modal&#x27;,function () &#123;
 alert(&#x27;模态框隐藏完成&#x27;)
 &#125;)
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

### [](#标签页)标签页

#### [](#定义标签页)定义标签页

标签页是一个分隔内容的组件，用户可以点击不同的标签来切换显示的内容。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;ul class=&quot;nav nav-tabs&quot;&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a href=&quot;#image1&quot; class=&quot;nav-link active&quot; data-toggle=&quot;tab&quot;&gt;图片1&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a href=&quot;#image2&quot; class=&quot;nav-link&quot; data-toggle=&quot;tab&quot;&gt;图片2&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a href=&quot;#image3&quot; class=&quot;nav-link&quot; data-toggle=&quot;tab&quot;&gt;图片3&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;dropdown nav-item&quot;&gt;
 &lt;a href=&quot;#&quot; class=&quot;nav-link dropdown-toggle&quot; data-toggle=&quot;dropdown&quot;&gt;更多内容&lt;/a&gt;
 &lt;ul class=&quot;dropdown-menu&quot;&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a href=&quot;#image4&quot; class=&quot;nav-link&quot; data-toggle=&quot;tab&quot;&gt;图片4&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a href=&quot;#image5&quot; class=&quot;nav-link&quot; data-toggle=&quot;tab&quot;&gt;图片5&lt;/a&gt;
 &lt;/li&gt;
 &lt;/ul&gt;
 &lt;/li&gt;
&lt;/ul&gt;
&lt;div class=&quot;tab-content&quot;&gt;
 &lt;div class=&quot;tab-pane fade show active&quot; id=&quot;image1&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592749924880&amp;di=19fd00107dc5c64270ef73dfd76b4ec8&amp;imgtype=0&amp;src=http%3A%2F%2Fimg4.imgtn.bdimg.com%2Fit%2Fu%3D1395559124%2C844098142%26fm%3D214%26gp%3D0.jpg&quot; class=&quot;img-fluid&quot; alt=&quot;&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;tab-pane fade&quot; id=&quot;image2&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592749924370&amp;di=1da7874065e4d65389ccd0ff1a713640&amp;imgtype=0&amp;src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Ff%2F06%2Fa8fb69593e.jpg&quot; class=&quot;img-fluid&quot; alt=&quot;&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;tab-pane fade&quot; id=&quot;image3&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592749924370&amp;di=8281d924f58a1427d0c2a2f0d7c3fa2e&amp;imgtype=0&amp;src=http%3A%2F%2Fimage.namedq.com%2Fuploads%2F20180910%2F14%2F1536559984-tVZOCYoUAs.jpg&quot; class=&quot;img-fluid&quot; alt=&quot;&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;tab-pane fade&quot; id=&quot;image4&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592749924370&amp;di=d0aafa1bf9b2173ebf22306121eb42a0&amp;imgtype=0&amp;src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F201705%2F08%2F20170508080655_NfQWE.jpeg&quot; class=&quot;img-fluid&quot; alt=&quot;&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;tab-pane fade&quot; id=&quot;image5&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592749992877&amp;di=0a4b48f7019defdfd40ef1f651d5cae8&amp;imgtype=0&amp;src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D2899500456%2C1238079701%26fm%3D214%26gp%3D0.jpg&quot; class=&quot;img-fluid&quot; alt=&quot;&quot;&gt;
 &lt;/div&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#添加用户行为-3)添加用户行为

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;ul class=&quot;nav nav-tabs&quot; id=&quot;myTab&quot;&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a href=&quot;#image1&quot; class=&quot;nav-link active&quot; data-toggle=&quot;tab&quot;&gt;图片1&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a href=&quot;#image2&quot; class=&quot;nav-link&quot; data-toggle=&quot;tab&quot;&gt;图片2&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a href=&quot;#image3&quot; class=&quot;nav-link&quot; data-toggle=&quot;tab&quot;&gt;图片3&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;dropdown nav-item&quot;&gt;
 &lt;a href=&quot;#&quot; class=&quot;nav-link dropdown-toggle&quot; data-toggle=&quot;dropdown&quot;&gt;更多内容&lt;/a&gt;
 &lt;ul class=&quot;dropdown-menu&quot;&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a href=&quot;#image4&quot; class=&quot;nav-link&quot; data-toggle=&quot;tab&quot;&gt;图片4&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a href=&quot;#image5&quot; class=&quot;nav-link&quot; data-toggle=&quot;tab&quot;&gt;图片5&lt;/a&gt;
 &lt;/li&gt;
 &lt;/ul&gt;
 &lt;/li&gt;
&lt;/ul&gt;
&lt;div class=&quot;tab-content&quot;&gt;
 &lt;div class=&quot;tab-pane fade show active&quot; id=&quot;image1&quot;&gt;图片1&lt;/div&gt;
 &lt;div class=&quot;tab-pane fade show&quot; id=&quot;image2&quot;&gt;图片2&lt;/div&gt;
 &lt;div class=&quot;tab-pane fade show&quot; id=&quot;image3&quot;&gt;图片3&lt;/div&gt;
 &lt;div class=&quot;tab-pane fade show&quot; id=&quot;image4&quot;&gt;图片4&lt;/div&gt;
 &lt;div class=&quot;tab-pane fade show&quot; id=&quot;image5&quot;&gt;图片5&lt;/div&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 $(&#x27;#myTab a&#x27;).on(&#x27;click&#x27;,function (e) &#123;
 e.preventDefault();
 $(this).tab(&#x27;show&#x27;);
 &#125;);
 $(&#x27;#myTab a&#x27;).on(&#x27;show.bs.tab&#x27;,function (e) &#123;
 alert(&#x27;旧的选项卡；&#x27; + e.relatedTarget);
 alert(&#x27;将被激活的选项卡：&#x27; + e.target);
 &#125;)
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

### [](#案例实训1—仿淘宝抢红包)案例实训1—仿淘宝抢红包

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;
 &lt;style&gt;
 .del&#123;
 border: 2px solid white!important;
 padding: 3px 8px 5px !important;
 border-radius: 50%;
 display: inline-block;
 right: 2px;
 top: 2px;
 background: #F72943!important;
 &#125;
 .redWars&#123;
 border: 1px solid white!important;
 padding: 15px 26px !important;
 border-radius: 50%;
 font-size: 40px;
 color: #F72943;
 background: yellow;
 display: inline-block;
 position: absolute;
 left: 105px;
 top: 260px;
 &#125;
 &lt;/style&gt;
&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;div class=&quot;modal fade&quot; id=&quot;myModal&quot;&gt;
 &lt;div class=&quot;modal-dialog modal-dialog-centered&quot; role=&quot;document&quot; style=&quot;width: 300px;&quot;&gt;
 &lt;div class=&quot;modal-content&quot;&gt;
 &lt;div class=&quot;modal-header&quot;&gt;
 &lt;button class=&quot;close del&quot; type=&quot;button&quot; data-dismiss=&quot;modal&quot;&gt;&amp;times;&lt;/button&gt;
 &lt;/div&gt;
 &lt;div class=&quot;modal-body&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592753747124&amp;di=742a4c7e7baba2dddd61ed368ff19881&amp;imgtype=0&amp;src=http%3A%2F%2Fbpic.588ku.com%2Fback_pic%2F05%2F74%2F81%2F035bd561660d4a9.jpg%2521r650%2Ffw%2F800&quot; class=&quot;img-fluid rounded&quot; alt=&quot;&quot;&gt;
 &lt;a href=&quot;#&quot; class=&quot;btn redWars&quot;&gt;抢&lt;/a&gt;
 &lt;/div&gt;

 &lt;/div&gt;
 &lt;/div&gt;
&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 $(&#x27;#myModal&#x27;).modal(&#x27;show&#x27;);
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

### [](#案例实训2—仿京东商品推荐区)案例实训2—仿京东商品推荐区

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;快速认识JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;
 &lt;style&gt;
 .custom .active&#123;
 border-radius: 0!important;
 background: #ff5774!important;
 &#125;
 .color1&#123;
 color: #FF4466;
 &#125;
 .color2&#123;
 color: #ff9797;
 &#125;
 .value&#123;
 font-size: 0.8rem;
 &#125;
 &lt;/style&gt;
&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3&gt;热销精品&lt;small class=&quot;ml-2 text-muted&quot;&gt;HOT&lt;/small&gt;&lt;/h3&gt;
&lt;ul class=&quot;nav nav-pills d-flex custom&quot;&gt;
 &lt;li class=&quot;nav-item border flex-fill text-center&quot;&gt;
 &lt;a href=&quot;#image1&quot; class=&quot;nav-link active&quot; data-toggle=&quot;tab&quot;&gt;裤装&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;nav-item border flex-fill text-center&quot;&gt;
 &lt;a href=&quot;#image2&quot; class=&quot;nav-link&quot; data-toggle=&quot;tab&quot;&gt;上衣&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;nav-item border flex-fill text-center&quot;&gt;
 &lt;a href=&quot;#image3&quot; class=&quot;nav-link&quot; data-toggle=&quot;tab&quot;&gt;裙子&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;nav-item border flex-fill text-center&quot;&gt;
 &lt;a href=&quot;#image4&quot; class=&quot;nav-link&quot; data-toggle=&quot;tab&quot;&gt;衬衫&lt;/a&gt;
 &lt;/li&gt;
&lt;/ul&gt;
&lt;div class=&quot;tab-content&quot;&gt;
 &lt;div class=&quot;tab-pane fade show active&quot; id=&quot;image1&quot;&gt;
 &lt;div class=&quot;row no-gutters&quot;&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;http://img11.360buyimg.com/n7/jfs/t1/100426/23/398/359161/5dabfd4dE281cad64/fdb059a7fd24e21d.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/96711/33/6971/107464/5df797fcE6bafe5ad/b164384642dac605.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/125902/22/4541/232758/5eddf729E83f05163/90d8baaa3cfc1938.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/143314/40/1074/267496/5eec846eEb9b6bce5/20d91f1c58737441.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img12.360buyimg.com/n7/jfs/t1/130673/1/2572/166108/5eec1c9fE122ff56f/ee7678ab000ec2fa.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img13.360buyimg.com/n7/jfs/t1/135489/34/2650/181821/5eed6589E9893eab0/ceb95fc3b99abe2d.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img12.360buyimg.com/n7/jfs/t1/33878/31/8726/151487/5cc7118dE74968f9e/932be243397081cd.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img14.360buyimg.com/n7/jfs/t1/101336/38/6885/169735/5df7a30dEff8aad5f/44b12c05f5f43bfe.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;tab-pane fade&quot; id=&quot;image2&quot;&gt;
 &lt;div class=&quot;row no-gutters&quot;&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;http://img11.360buyimg.com/n7/jfs/t1/100426/23/398/359161/5dabfd4dE281cad64/fdb059a7fd24e21d.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/96711/33/6971/107464/5df797fcE6bafe5ad/b164384642dac605.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/125902/22/4541/232758/5eddf729E83f05163/90d8baaa3cfc1938.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/143314/40/1074/267496/5eec846eEb9b6bce5/20d91f1c58737441.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img12.360buyimg.com/n7/jfs/t1/130673/1/2572/166108/5eec1c9fE122ff56f/ee7678ab000ec2fa.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img13.360buyimg.com/n7/jfs/t1/135489/34/2650/181821/5eed6589E9893eab0/ceb95fc3b99abe2d.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img12.360buyimg.com/n7/jfs/t1/33878/31/8726/151487/5cc7118dE74968f9e/932be243397081cd.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img14.360buyimg.com/n7/jfs/t1/101336/38/6885/169735/5df7a30dEff8aad5f/44b12c05f5f43bfe.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;tab-pane fade&quot; id=&quot;image3&quot;&gt;
 &lt;div class=&quot;row no-gutters&quot;&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;http://img11.360buyimg.com/n7/jfs/t1/100426/23/398/359161/5dabfd4dE281cad64/fdb059a7fd24e21d.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/96711/33/6971/107464/5df797fcE6bafe5ad/b164384642dac605.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/125902/22/4541/232758/5eddf729E83f05163/90d8baaa3cfc1938.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/143314/40/1074/267496/5eec846eEb9b6bce5/20d91f1c58737441.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img12.360buyimg.com/n7/jfs/t1/130673/1/2572/166108/5eec1c9fE122ff56f/ee7678ab000ec2fa.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img13.360buyimg.com/n7/jfs/t1/135489/34/2650/181821/5eed6589E9893eab0/ceb95fc3b99abe2d.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img12.360buyimg.com/n7/jfs/t1/33878/31/8726/151487/5cc7118dE74968f9e/932be243397081cd.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img14.360buyimg.com/n7/jfs/t1/101336/38/6885/169735/5df7a30dEff8aad5f/44b12c05f5f43bfe.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;tab-pane fade&quot; id=&quot;image4&quot;&gt;
 &lt;div class=&quot;row no-gutters&quot;&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;http://img11.360buyimg.com/n7/jfs/t1/100426/23/398/359161/5dabfd4dE281cad64/fdb059a7fd24e21d.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/96711/33/6971/107464/5df797fcE6bafe5ad/b164384642dac605.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/125902/22/4541/232758/5eddf729E83f05163/90d8baaa3cfc1938.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/143314/40/1074/267496/5eec846eEb9b6bce5/20d91f1c58737441.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img12.360buyimg.com/n7/jfs/t1/130673/1/2572/166108/5eec1c9fE122ff56f/ee7678ab000ec2fa.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img13.360buyimg.com/n7/jfs/t1/135489/34/2650/181821/5eed6589E9893eab0/ceb95fc3b99abe2d.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img12.360buyimg.com/n7/jfs/t1/33878/31/8726/151487/5cc7118dE74968f9e/932be243397081cd.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3 p-3 border&quot;&gt;
 &lt;img src=&quot;//img14.360buyimg.com/n7/jfs/t1/101336/38/6885/169735/5df7a30dEff8aad5f/44b12c05f5f43bfe.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;
 &lt;p class=&quot;my-2 value text-center&quot;&gt;夏季新款韩版修身时尚淑女装&lt;/p&gt;
 &lt;div class=&quot;row text-center&quot;&gt;
 &lt;div class=&quot;col-6 border-right value color1&quot;&gt;￥89&lt;/div&gt;
 &lt;div class=&quot;col-6 value&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;text-dark&quot;&gt;&lt;i class=&quot;fa fa-weixin mr-1 color2&quot;&gt;&lt;/i&gt;208评价&lt;/a&gt;&lt;/div&gt;
 &lt;/div&gt;
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

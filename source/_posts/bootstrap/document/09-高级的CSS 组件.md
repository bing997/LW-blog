---
title: 09-高级的CSS 组件
date: 2024-08-21
categories:
  - bootstrap
tags:
  - bootstrap
  - 教程
---

## [](#高级的CSS组件)高级的CSS组件

### [](#表单)表单

#### [](#定义表单控件)定义表单控件

Bootstrap 表单控件用于创建交互式元素。常见控件包括输入框、选择框、复选框和单选按钮等。
使用 `.form-control` 类来设置文本框、文本区域、选择框等表单控件的样式。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h2 class=&quot;mb-4&quot;&gt;表单组示例&lt;/h2&gt;
&lt;form&gt;
 &lt;div class=&quot;form-group&quot;&gt;
 &lt;label for=&quot;formGroup1&quot;&gt;姓名&lt;/label&gt;
 &lt;input type=&quot;text&quot; class=&quot;form-control&quot; id=&quot;formGroup1&quot; placeholder=&quot;Name&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-group&quot;&gt;
 &lt;label for=&quot;formGroup2&quot;&gt;密码&lt;/label&gt;
 &lt;input type=&quot;password&quot; class=&quot;form-control&quot; id=&quot;formGroup2&quot; placeholder=&quot;PassWord&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-group&quot;&gt;
 &lt;label for=&quot;controlFile1&quot;&gt;文件选择&lt;/label&gt;
 &lt;input type=&quot;file&quot; class=&quot;form-control-file&quot; id=&quot;controlFile1&quot;&gt;

 &lt;/div&gt;
&lt;/form&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

设置表单控件的大小

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h2 class=&quot;mb-4&quot;&gt;设置表单控件的大小&lt;/h2&gt;
&lt;form&gt;
 &lt;input type=&quot;text&quot; class=&quot;form-control form-control-lg&quot; placeholder=&quot;大尺寸（form-control-lg）&quot;&gt;&lt;br&gt;
 &lt;input type=&quot;text&quot; class=&quot;form-control&quot; placeholder=&quot;默认大小&quot;&gt;&lt;br&gt;
 &lt;input type=&quot;text&quot; class=&quot;form-control form-control-sm&quot; placeholder=&quot;小尺寸（form-control-sm）&quot;&gt;
&lt;/form&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

设置表单控件只读

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h2 class=&quot;mb-4&quot;&gt;设置表单控件只读&lt;/h2&gt;
&lt;form&gt;
 &lt;input type=&quot;text&quot; class=&quot;form-control&quot; placeholder=&quot;只读表单&quot; readonly&gt;
&lt;/form&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

设置只读纯文本

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h2 class=&quot;mb-4&quot;&gt;设置表单控件只读&lt;/h2&gt;
&lt;form&gt;
 &lt;div class=&quot;form-group row&quot;&gt;
 &lt;label for=&quot;email&quot; class=&quot;col-sm-2 col-form-label&quot;&gt;邮箱&lt;/label&gt;
 &lt;div class=&quot;col-sm-10&quot;&gt;
 &lt;input type=&quot;text&quot; readonly class=&quot;form-control-plaintext&quot; id=&quot;email&quot; value=&quot;email@example.com&quot;&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-group row&quot;&gt;
 &lt;label for=&quot;password&quot; class=&quot;col-sm-2 col-form-label&quot;&gt;密码&lt;/label&gt;
 &lt;div class=&quot;col-sm-10&quot;&gt;
 &lt;input type=&quot;password&quot; class=&quot;form-control&quot; id=&quot;password&quot; placeholder=&quot;PassWord&quot;&gt;
 &lt;/div&gt;
 &lt;/div&gt;
&lt;/form&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

范围输入

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h2 class=&quot;mb-4&quot;&gt;范围输入&lt;/h2&gt;
&lt;form&gt;
 &lt;input type=&quot;range&quot; class=&quot;form-control-range&quot;&gt;
&lt;/form&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#设计单选按钮-复选框布局和样式)设计单选按钮&#x2F; 复选框布局和样式

> 

复选框和单选按钮–垂直堆叠方式

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h2 class=&quot;mb-4&quot;&gt;复选框和单选按钮--默认堆叠方式&lt;/h2&gt;
&lt;h5&gt;选择你喜欢吃的水果&lt;/h5&gt;
&lt;form&gt;
 &lt;p&gt;只能选择一种的水果&lt;/p&gt;
 &lt;div class=&quot;form-check&quot;&gt;
 &lt;input type=&quot;radio&quot; class=&quot;form-check-input&quot; name=&quot;fruits&quot; id=&quot;fruit1&quot;&gt;
 &lt;label for=&quot;fruit1&quot; class=&quot;form-check-label&quot;&gt;香瓜&lt;/label&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-check&quot;&gt;
 &lt;input type=&quot;radio&quot; class=&quot;form-check-input&quot; name=&quot;fruits&quot; id=&quot;fruit2&quot;&gt;
 &lt;label for=&quot;fruit2&quot; class=&quot;form-check-label&quot;&gt;哈密瓜&lt;/label&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-check&quot;&gt;
 &lt;input type=&quot;radio&quot; class=&quot;form-check-input&quot; name=&quot;fruits&quot; id=&quot;fruit3&quot; disabled&gt;
 &lt;label for=&quot;fruit3&quot; class=&quot;form-check-label&quot;&gt;西瓜（禁选）&lt;/label&gt;
 &lt;/div&gt;
&lt;/form&gt;
&lt;form&gt;
 &lt;p class=&quot;mt-4&quot;&gt;可以多选的水果&lt;/p&gt;
 &lt;div class=&quot;form-check&quot;&gt;
 &lt;input type=&quot;checkbox&quot; class=&quot;form-check-input&quot; name=&quot;fruits&quot; id=&quot;fruit4&quot;&gt;
 &lt;label for=&quot;fruit4&quot; class=&quot;form-check-label&quot;&gt;苹果&lt;/label&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-check&quot;&gt;
 &lt;input type=&quot;checkbox&quot; class=&quot;form-check-input&quot; name=&quot;fruits&quot; id=&quot;fruit5&quot;&gt;
 &lt;label for=&quot;fruit5&quot; class=&quot;form-check-label&quot;&gt;香蕉&lt;/label&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-check&quot;&gt;
 &lt;input type=&quot;checkbox&quot; class=&quot;form-check-input&quot; name=&quot;fruits&quot; id=&quot;fruit6&quot; disabled&gt;
 &lt;label for=&quot;fruit6&quot; class=&quot;form-check-label&quot;&gt;菠萝(禁选)&lt;/label&gt;
 &lt;/div&gt;
&lt;/form&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

复选框和单选按钮–水平堆叠方式

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h2 class=&quot;mb-4&quot;&gt;复选框和单选按钮--默认堆叠方式&lt;/h2&gt;
&lt;h5&gt;选择你喜欢吃的水果&lt;/h5&gt;
&lt;form&gt;
 &lt;p&gt;只能选择一种的水果&lt;/p&gt;
 &lt;div class=&quot;form-check form-check-inline&quot;&gt;
 &lt;input type=&quot;radio&quot; class=&quot;form-check-input&quot; name=&quot;fruits&quot; id=&quot;fruit1&quot;&gt;
 &lt;label for=&quot;fruit1&quot; class=&quot;form-check-label&quot;&gt;香瓜&lt;/label&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-check form-check-inline&quot;&gt;
 &lt;input type=&quot;radio&quot; class=&quot;form-check-input&quot; name=&quot;fruits&quot; id=&quot;fruit2&quot;&gt;
 &lt;label for=&quot;fruit2&quot; class=&quot;form-check-label&quot;&gt;哈密瓜&lt;/label&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-check form-check-inline&quot;&gt;
 &lt;input type=&quot;radio&quot; class=&quot;form-check-input&quot; name=&quot;fruits&quot; id=&quot;fruit3&quot; disabled&gt;
 &lt;label for=&quot;fruit3&quot; class=&quot;form-check-label&quot;&gt;西瓜（禁选）&lt;/label&gt;
 &lt;/div&gt;
&lt;/form&gt;
&lt;form&gt;
 &lt;p class=&quot;mt-4&quot;&gt;可以多选的水果&lt;/p&gt;
 &lt;div class=&quot;form-check form-check-inline&quot;&gt;
 &lt;input type=&quot;checkbox&quot; class=&quot;form-check-input&quot; name=&quot;fruits&quot; id=&quot;fruit4&quot;&gt;
 &lt;label for=&quot;fruit4&quot; class=&quot;form-check-label&quot;&gt;苹果&lt;/label&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-check form-check-inline&quot;&gt;
 &lt;input type=&quot;checkbox&quot; class=&quot;form-check-input&quot; name=&quot;fruits&quot; id=&quot;fruit5&quot;&gt;
 &lt;label for=&quot;fruit5&quot; class=&quot;form-check-label&quot;&gt;香蕉&lt;/label&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-check form-check-inline&quot;&gt;
 &lt;input type=&quot;checkbox&quot; class=&quot;form-check-input&quot; name=&quot;fruits&quot; id=&quot;fruit6&quot; disabled&gt;
 &lt;label for=&quot;fruit6&quot; class=&quot;form-check-label&quot;&gt;菠萝(禁选)&lt;/label&gt;
 &lt;/div&gt;
&lt;/form&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#表单布局风格)表单布局风格

表单布局风格是指在表单中排列标签、输入框、按钮等控件的方式，以实现不同的视觉效果和用户体验。

Bootstrap 提供了几种常见的表单布局方式：

[](#水平表单布局-Horizontal-Form)水平表单布局 (Horizontal Form)

- **水平布局**：布局是指标签与输入框在同一行排列。使用 `.form-horizontal` 类结合栅格系统（Grid System）来实现水平布局。通常，标签会占用部分列宽，输入框占用剩余列宽。
&lt;form class=&quot;form-horizontal&quot;&gt;
 &lt;div class=&quot;form-group row&quot;&gt;
 &lt;label for=&quot;inputEmail3&quot; class=&quot;col-sm-2 col-form-label&quot;&gt;Email&lt;/label&gt;
 &lt;div class=&quot;col-sm-10&quot;&gt;
 &lt;input type=&quot;email&quot; class=&quot;form-control&quot; id=&quot;inputEmail3&quot; placeholder=&quot;Email&quot;&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-group row&quot;&gt;
 &lt;label for=&quot;inputPassword3&quot; class=&quot;col-sm-2 col-form-label&quot;&gt;Password&lt;/label&gt;
 &lt;div class=&quot;col-sm-10&quot;&gt;
 &lt;input type=&quot;password&quot; class=&quot;form-control&quot; id=&quot;inputPassword3&quot; placeholder=&quot;Password&quot;&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-group row&quot;&gt;
 &lt;div class=&quot;col-sm-10 offset-sm-2&quot;&gt;
 &lt;button type=&quot;submit&quot; class=&quot;btn btn-primary&quot;&gt;Sign in&lt;/button&gt;
 &lt;/div&gt;
 &lt;/div&gt;
&lt;/form&gt;

> 

关键点：
`.form-group` 包裹每一组标签和输入框。
使用 .row 类包裹每一组表单控件，实现栅格布局。
label 标签使用 `.col-form-label` 类，设置为同一行。

[](#垂直表单布局-Vertical-Form)垂直表单布局 (Vertical Form)

- **垂直表单**：垂直布局是指标签与输入框在不同的行中垂直排列，这是最常见的表单布局方式。
&lt;form&gt;
 &lt;div class=&quot;form-group&quot;&gt;
 &lt;label for=&quot;exampleInputEmail1&quot;&gt;Email address&lt;/label&gt;
 &lt;input type=&quot;email&quot; class=&quot;form-control&quot; id=&quot;exampleInputEmail1&quot; placeholder=&quot;Enter email&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-group&quot;&gt;
 &lt;label for=&quot;exampleInputPassword1&quot;&gt;Password&lt;/label&gt;
 &lt;input type=&quot;password&quot; class=&quot;form-control&quot; id=&quot;exampleInputPassword1&quot; placeholder=&quot;Password&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-group form-check&quot;&gt;
 &lt;input type=&quot;checkbox&quot; class=&quot;form-check-input&quot; id=&quot;exampleCheck1&quot;&gt;
 &lt;label class=&quot;form-check-label&quot; for=&quot;exampleCheck1&quot;&gt;Check me out&lt;/label&gt;
 &lt;/div&gt;
 &lt;button type=&quot;submit&quot; class=&quot;btn btn-primary&quot;&gt;Submit&lt;/button&gt;
&lt;/form&gt;

> 

关键点：
每个表单控件独占一行，标签位于输入框上方。
这种布局简单明了，适合移动端设备。

[](#内联表单布局-Inline-Form)内联表单布局 (Inline Form)

- **内联表单**:内联表单布局是指表单控件水平排列，适合用于搜索框、登录框等较短的表单。
&lt;form class=&quot;form-inline&quot;&gt;
 &lt;label class=&quot;sr-only&quot; for=&quot;inlineFormInputName2&quot;&gt;Name&lt;/label&gt;
 &lt;input type=&quot;text&quot; class=&quot;form-control mb-2 mr-sm-2&quot; id=&quot;inlineFormInputName2&quot; placeholder=&quot;Jane Doe&quot;&gt;
 
 &lt;label class=&quot;sr-only&quot; for=&quot;inlineFormInputGroupUsername2&quot;&gt;Username&lt;/label&gt;
 &lt;div class=&quot;input-group mb-2 mr-sm-2&quot;&gt;
 &lt;div class=&quot;input-group-prepend&quot;&gt;
 &lt;div class=&quot;input-group-text&quot;&gt;@&lt;/div&gt;
 &lt;/div&gt;
 &lt;input type=&quot;text&quot; class=&quot;form-control&quot; id=&quot;inlineFormInputGroupUsername2&quot; placeholder=&quot;Username&quot;&gt;
 &lt;/div&gt;
 
 &lt;button type=&quot;submit&quot; class=&quot;btn btn-primary mb-2&quot;&gt;Submit&lt;/button&gt;
&lt;/form&gt;

> 

关键点：
使用 `.form-inline` 类，表单控件会自动排列在同一行。
内联表单布局适合放在导航栏或其他紧凑空间中。

#### [](#帮助文本)帮助文本

帮助文本通常用于表单控件的说明，使用 `.form-text` 类来实现。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;帮助文本&lt;/h3&gt;
&lt;form&gt;
 &lt;div class=&quot;form-group row&quot;&gt;
 &lt;label for=&quot;password&quot;&gt;密码&lt;/label&gt;
 &lt;input type=&quot;password&quot; id=&quot;password&quot; class=&quot;form-control&quot;&gt;
 &lt;small class=&quot;form-text text-muted&quot;&gt;
 密码必须有8-18个字符，包含字母和数字，并且不能包含空格，特殊字符或表情符号。
 &lt;/small&gt;
 &lt;/div&gt;
&lt;/form&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#禁用表单)禁用表单

表单或表单控件可以通过 `disabled` 属性进行禁用。禁用后的控件无法进行用户输入。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;禁用表单&lt;/h3&gt;
&lt;form&gt;
 &lt;fieldset disabled&gt;
 &lt;div class=&quot;form-group&quot;&gt;
 &lt;label for=&quot;textInput&quot;&gt;禁用表单&lt;/label&gt;
 &lt;input type=&quot;text&quot; id=&quot;textInput&quot; class=&quot;form-control&quot; placeholder=&quot;Disabled input&quot;&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-group&quot;&gt;
 &lt;label for=&quot;testSelect&quot;&gt;禁用选择菜单&lt;/label&gt;
 &lt;select id=&quot;testSelect&quot; class=&quot;form-control&quot;&gt;
 &lt;option&gt;Disabled select&lt;/option&gt;
 &lt;/select&gt;
 &lt;/div&gt;
 &lt;div class=&quot;form-group&quot;&gt;
 &lt;div class=&quot;form-check&quot;&gt;
 &lt;input type=&quot;checkbox&quot; class=&quot;form-check-input&quot; id=&quot;testCheck&quot;&gt;
 &lt;label for=&quot;testCheck&quot; class=&quot;form-check-label&quot;&gt;禁用复选框&lt;/label&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;button type=&quot;submit&quot; class=&quot;btn btn-primary&quot;&gt;提交&lt;/button&gt;
 &lt;/fieldset&gt;
&lt;/form&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

### [](#列表组)列表组

列表组是一个常用的 Bootstrap 组件，用于显示一系列内容，比如菜单、导航、评论列表等。它能够以清晰的层级和视觉效果展示内容。

#### [](#定义列表组)定义列表组

列表组使用 `.list-group` 类来创建。每个列表项使用 `.list-group-item` 类来定义。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;列表组&lt;/h3&gt;
&lt;ul class=&quot;list-group&quot;&gt;
 &lt;li class=&quot;list-group-item list-group-item-action&quot;&gt;全心全力 见心见行&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-action&quot;&gt;同心同德 启帆远航&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-action&quot;&gt;同心同行 共创未来&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-action&quot;&gt;激情闪耀 共创辉煌&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-action&quot;&gt;超越梦想 再创辉煌&lt;/li&gt;
&lt;/ul&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#设计列表组的风格样式)设计列表组的风格样式
[](#激活状态和禁用状态：)激活状态和禁用状态：

- `.active` 类用于标记当前激活的列表项。

- `.disabled` 类用于禁用某个列表项。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;激活和禁用状态&lt;/h3&gt;
&lt;ul class=&quot;list-group&quot;&gt;
 &lt;li class=&quot;list-group-item list-group-item-action active&quot;&gt;全心全力 见心见行(激活状态)&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-action&quot;&gt;同心同德 启帆远航&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-action disabled&quot;&gt;同心同行 共创未来(禁用状态)&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-action&quot;&gt;激情闪耀 共创辉煌&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-action&quot;&gt;超越梦想 再创辉煌&lt;/li&gt;
&lt;/ul&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

[](#去除边框和圆角)去除边框和圆角

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;去除边框和圆角&lt;/h3&gt;
&lt;ul class=&quot;list-group list-group-flush&quot;&gt;
 &lt;li class=&quot;list-group-item list-group-item-action&quot;&gt;全心全力 见心见行&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-action&quot;&gt;同心同德 启帆远航&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-action&quot;&gt;同心同行 共创未来&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-action&quot;&gt;激情闪耀 共创辉煌&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-action&quot;&gt;超越梦想 再创辉煌&lt;/li&gt;
&lt;/ul&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

[](#列表项的背景颜色：)列表项的背景颜色：

通过 `.list-group-item-*` 类来设置不同的背景颜色，如 `.list-group-item-primary`、`.list-group-item-success` 等。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;背景和文字颜色&lt;/h3&gt;
&lt;ul class=&quot;list-group list-group-flush&quot;&gt;
 &lt;li class=&quot;list-group-item list-group-item-primary&quot;&gt;全心全力 见心见行&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-secondary&quot;&gt;同心同德 启帆远航&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-success&quot;&gt;同心同行 共创未来&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-danger&quot;&gt;激情闪耀 共创辉煌&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-warning&quot;&gt;超越梦想 再创辉煌&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-info&quot;&gt;飞跃巅峰 纵横四海&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-light&quot;&gt;融合梦想 努力超越&lt;/li&gt;
 &lt;li class=&quot;list-group-item list-group-item-dark&quot;&gt;超越第一 实现梦想&lt;/li&gt;
&lt;/ul&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

[](#可点击列表项)可点击列表项

通过将 `&lt;li&gt;` 替换为 `&lt;a&gt;` 或 `&lt;button&gt;` 标签，并添加 `.list-group-item-action` 类，可以使列表项变为可点击状态，类似于链接或按钮。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;添加徽章&lt;/h3&gt;
&lt;h5&gt;每句口号支持的人数&lt;/h5&gt;
&lt;ul class=&quot;list-group&quot;&gt;
 &lt;li class=&quot;list-group-item d-flex justify-content-between align-items-center&quot;&gt;全心全力 见心见行
 &lt;span class=&quot;badge badge-primary badge-pill&quot;&gt;30&lt;/span&gt;&lt;/li&gt;
 &lt;li class=&quot;list-group-item d-flex justify-content-between align-items-center&quot;&gt;超越梦想 再创辉煌
 &lt;span class=&quot;badge badge-primary badge-pill&quot;&gt;50&lt;/span&gt;&lt;/li&gt;
 &lt;li class=&quot;list-group-item d-flex justify-content-between align-items-center&quot;&gt;超越第一 实现梦想
 &lt;span class=&quot;badge badge-primary badge-pill&quot;&gt;20&lt;/span&gt;&lt;/li&gt;

&lt;/ul&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#定制内容)定制内容

复杂的列表项：可以在列表项中嵌入更多内容，如标题、文本、徽章等，以实现更复杂的布局。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;定制内容&lt;/h3&gt;
&lt;h5&gt;招聘信息&lt;/h5&gt;
&lt;div class=&quot;list-group&quot;&gt;
 &lt;a href=&quot;#&quot; class=&quot;list-group-item list-group-item-action active&quot;&gt;
 &lt;div class=&quot;d-flex w-100 justify-content-between&quot;&gt;
 &lt;h5 class=&quot;mb-1&quot;&gt;公司名称&lt;/h5&gt;
 &lt;small&gt;发布时间&lt;/small&gt;
 &lt;/div&gt;
 &lt;p class=&quot;mb-1&quot;&gt;描述&lt;/p&gt;
 &lt;p&gt;薪资&lt;/p&gt;
 &lt;/a&gt;
 &lt;a href=&quot;#&quot; class=&quot;list-group-item list-group-item-action&quot;&gt;
 &lt;div class=&quot;d-flex w-100 justify-content-between&quot;&gt;
 &lt;h5 class=&quot;mb-1&quot;&gt;顺畅建筑有限公司&lt;/h5&gt;
 &lt;small class=&quot;text-muted&quot;&gt;一天前&lt;/small&gt;
 &lt;/div&gt;
 &lt;p class=&quot;mb-1&quot;&gt;公司在全国各地都有项目，现招一位项目经理，工作地点在新疆。。。&lt;/p&gt;
 &lt;p&gt;10-15k&lt;/p&gt;
 &lt;/a&gt;
 &lt;a href=&quot;#&quot; class=&quot;list-group-item list-group-item-action&quot;&gt;
 &lt;div class=&quot;d-flex w-100 justify-content-between&quot;&gt;
 &lt;h5 class=&quot;mb-1&quot;&gt;梦想网络有限公司&lt;/h5&gt;
 &lt;small class=&quot;text-muted&quot;&gt;一天前&lt;/small&gt;
 &lt;/div&gt;
 &lt;p class=&quot;mb-1&quot;&gt;本公司位于北京，现招一位web前端工程师，要求有两年以上工作经验。。。&lt;/p&gt;
 &lt;p&gt;8-12k&lt;/p&gt;
 &lt;/a&gt;

&lt;/div&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

### [](#面包屑)面包屑

面包屑导航是一种用户界面元素，通常用于显示用户在网站或应用程序中的位置路径。它提供了层次结构的上下文，并允许用户轻松地返回到上一层或更高层级的页面。

#### [](#定义面包屑)定义面包屑

面包屑在 Bootstrap 中使用 `.breadcrumb` 类来创建。每个导航项使用 `&lt;li&gt;` 元素，并带有 `.breadcrumb-item` 类。最后一个项通常代表当前页面，使用 `.active` 类标记。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;面包屑&lt;/h3&gt;
&lt;nav aria-label=&quot;breadcrumb&quot;&gt;
 &lt;ol class=&quot;breadcrumb&quot;&gt;
 &lt;li class=&quot;breadcrumb-item active&quot;&gt;首页&lt;/li&gt;
 &lt;/ol&gt;
&lt;/nav&gt;
&lt;nav aria-label=&quot;breadcrumb&quot;&gt;
 &lt;ol class=&quot;breadcrumb&quot;&gt;
 &lt;li class=&quot;breadcrumb-item&quot;&gt;&lt;a href=&quot;#&quot;&gt;首页&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;breadcrumb-item active&quot;&gt;图书馆&lt;/li&gt;
 &lt;/ol&gt;
&lt;/nav&gt;
&lt;nav aria-label=&quot;breadcrumb&quot;&gt;
 &lt;ol class=&quot;breadcrumb&quot;&gt;
 &lt;li class=&quot;breadcrumb-item&quot;&gt;&lt;a href=&quot;#&quot;&gt;首页&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;breadcrumb-item&quot;&gt;&lt;a href=&quot;#&quot;&gt;图书馆&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;breadcrumb-item active&quot;&gt;工程类&lt;/li&gt;
 &lt;/ol&gt;
&lt;/nav&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

关键点：
`.breadcrumb` 类用于定义整个面包屑导航的容器。
`.breadcrumb-item` 类用于定义每个面包屑导航项。
`.active` 类用于标记当前页面所在的导航项。

#### [](#设计分隔符)设计分隔符

**默认分隔符**：在 Bootstrap 中，面包屑导航项之间的默认分隔符是斜杠 (&#x2F;)。这个分隔符可以通过 CSS 自定义。

**自定义分隔符**：如果你想要更改分隔符，可以使用 CSS。比如，将分隔符改为 &gt;：

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;
 &lt;style&gt;
 .breadcrumb-item + .breadcrumb-item::before&#123;
 display: inline-block;
 padding-right: 0.5rem;
 color: #6c757d;
 content: &#x27;&gt;&#x27;;
 &#125;
 &lt;/style&gt;
&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;面包屑&lt;/h3&gt;
&lt;nav aria-label=&quot;breadcrumb&quot;&gt;
 &lt;ol class=&quot;breadcrumb&quot;&gt;
 &lt;li class=&quot;breadcrumb-item active&quot;&gt;首页&lt;/li&gt;
 &lt;/ol&gt;
&lt;/nav&gt;
&lt;nav aria-label=&quot;breadcrumb&quot;&gt;
 &lt;ol class=&quot;breadcrumb&quot;&gt;
 &lt;li class=&quot;breadcrumb-item&quot;&gt;&lt;a href=&quot;#&quot;&gt;首页&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;breadcrumb-item active&quot;&gt;图书馆&lt;/li&gt;
 &lt;/ol&gt;
&lt;/nav&gt;
&lt;nav aria-label=&quot;breadcrumb&quot;&gt;
 &lt;ol class=&quot;breadcrumb&quot;&gt;
 &lt;li class=&quot;breadcrumb-item&quot;&gt;&lt;a href=&quot;#&quot;&gt;首页&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;breadcrumb-item&quot;&gt;&lt;a href=&quot;#&quot;&gt;图书馆&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;breadcrumb-item active&quot;&gt;工程类&lt;/li&gt;
 &lt;/ol&gt;
&lt;/nav&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

### [](#分页)分页

分页（pagination）是用于指示一系列相关的内容存在于多个页面中的组件

#### [](#定义分页)定义分页

分页是一种导航方法，用于将大量内容分成多个页面，以便用户可以轻松浏览。通常用于长列表、搜索结果或文章目录等。分页组件通常包含页码链接、”上一页” 和 “下一页” 按钮等，允许用户在内容中快速跳转。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;
&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;定义分页&lt;/h3&gt;
&lt;ul class=&quot;pagination&quot;&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;首页&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;上一页&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;1&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;2&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;3&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;4&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;5&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;下一页&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;尾页&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#使用图标)使用图标

在分页中使用图标可以让用户界面更直观和友好。Bootstrap 提供了使用 Font Awesome 或 Bootstrap Icons 等图标库的方式来增强分页导航的视觉效果。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;
&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;使用图标&lt;/h3&gt;
&lt;ul class=&quot;pagination&quot;&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;首页&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;&lt;span&gt;&amp;laquo;&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;1&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;2&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;3&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;4&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;5&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;&lt;span&gt;&amp;raquo;&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;尾页&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#设计分页风格)设计分页风格

在设计分页时，除了功能外，风格也是非常重要的。不同的分页风格可以为用户带来不同的使用体验。Bootstrap 提供了几种分页样式，但你也可以通过自定义 CSS 来设计独特的分页风格。

[](#默认风格)默认风格

这是 Bootstrap 提供的默认分页样式，简洁而常见。

&lt;ul class=&quot;pagination&quot;&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a class=&quot;page-link&quot; href=&quot;#&quot;&gt;1&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a class=&quot;page-link&quot; href=&quot;#&quot;&gt;2&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a class=&quot;page-link&quot; href=&quot;#&quot;&gt;3&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;

[](#大小变化)大小变化

Bootstrap 允许你通过添加 `pagination-lg` 或 `pagination-sm` 类来更改分页组件的大小。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;
&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;设置大小&lt;/h3&gt;
&lt;!--大号分页样式--&gt;
&lt;ul class=&quot;pagination pagination-lg&quot;&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;首页&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;&lt;span&gt;&amp;laquo;&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;1&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;2&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;3&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;4&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;5&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;&lt;span&gt;&amp;raquo;&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;尾页&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;!--默认分页样式--&gt;
&lt;ul class=&quot;pagination&quot;&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;首页&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;&lt;span&gt;&amp;laquo;&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;1&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;2&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;3&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;4&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;5&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;&lt;span&gt;&amp;raquo;&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;尾页&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;!--小号分页样式--&gt;
&lt;ul class=&quot;pagination pagination-sm&quot;&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;首页&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;&lt;span&gt;&amp;laquo;&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;1&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;2&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;3&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;4&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;5&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;&lt;span&gt;&amp;raquo;&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;尾页&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

[](#激活和禁用)激活和禁用

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;
&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;激活和禁用分页项&lt;/h3&gt;
&lt;ul class=&quot;pagination&quot;&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;首页&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;&lt;span&gt;&amp;laquo;&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;1&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item active&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;2&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;3&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;4&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item disabled&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;5&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;&lt;span&gt;&amp;raquo;&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;尾页&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

[](#对齐方式)对齐方式

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;高级的CSS组件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;
&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;居中对齐&lt;/h3&gt;
&lt;ul class=&quot;pagination mb-5 justify-content-center&quot;&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;首页&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;&lt;span&gt;&amp;laquo;&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;1&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item active&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;2&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;3&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;4&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item disabled&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;5&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;&lt;span&gt;&amp;raquo;&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;尾页&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;右对齐&lt;/h3&gt;
&lt;ul class=&quot;pagination justify-content-end&quot;&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;首页&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;&lt;span&gt;&amp;laquo;&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;1&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item active&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;2&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;3&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;4&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item disabled&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;5&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;&lt;span&gt;&amp;raquo;&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
 &lt;li class=&quot;page-item&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;page-link&quot;&gt;尾页&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

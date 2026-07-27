---
title: 12-深入精通JavaScript 插件
date: 2024-08-20
categories:
  - bootstrap
tags:
  - bootstrap
  - 教程
---

## [](#深入精通JavaScript-插件)深入精通JavaScript 插件

### [](#折叠)折叠

#### [](#定义折叠)定义折叠

折叠是指将内容隐藏起来，只显示一部分内容或标题。

在Bootstrap中，折叠功能常用于折叠面板、手风琴效果等。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Container&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h2 class=&quot;mb-4&quot;&gt;定义折叠&lt;/h2&gt;
&lt;p&gt;
 &lt;a href=&quot;#collapse&quot; class=&quot;btn btn-primary&quot; data-toggle=&quot;collapse&quot;&gt;&amp;lt;a&amp;gt;触发折叠&lt;/a&gt;
 &lt;button class=&quot;btn btn-danger&quot; type=&quot;button&quot; data-toggle=&quot;collapse&quot; data-target=&quot;#collapse1&quot;&gt;&amp;lt;button&amp;gt;触发折叠&lt;/button&gt;
&lt;/p&gt;
&lt;div class=&quot;collapsing&quot; id=&quot;collapse&quot;&gt;
 &lt;div class=&quot;card card-body&quot;&gt;
 这是&amp;lt;a&amp;gt;触发的折叠内容
 &lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;collapsing&quot; id=&quot;collapse1&quot;&gt;
 &lt;div class=&quot;card card-body&quot;&gt;
 这是&amp;lt;button&amp;gt;触发的折叠内容
 &lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#控制多目标)控制多目标

使用数据属性或JavaScript API可以控制多个目标的折叠状态。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Container&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;一个触发器切换多个目标&lt;/h3&gt;
&lt;p&gt;
 &lt;button class=&quot;btn btn-primary&quot; type=&quot;button&quot; data-toggle=&quot;collapse&quot; data-target=&quot;.multi-collapse&quot;&gt;切换下面两个目标&lt;/button&gt;
&lt;/p&gt;
&lt;div class=&quot;collapse multi-collapse&quot;&gt;
 &lt;div class=&quot;card card-body&quot;&gt;折叠内容一&lt;/div&gt;
&lt;/div&gt;
&lt;div class=&quot;collapse multi-collapse&quot;&gt;
 &lt;div class=&quot;card card-body&quot;&gt;折叠内容二&lt;/div&gt;
&lt;/div&gt;
&lt;hr class=&quot;my-4&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;多个触发器切换一个目标&lt;/h3&gt;
&lt;p&gt;
 &lt;button class=&quot;btn btn-primary&quot; type=&quot;button&quot; data-toggle=&quot;collapse&quot; data-target=&quot;#multi-collapse&quot;&gt;触发器1&lt;/button&gt;
 &lt;button class=&quot;btn btn-primary&quot; type=&quot;button&quot; data-toggle=&quot;collapse&quot; data-target=&quot;#multi-collapse&quot;&gt;触发器2&lt;/button&gt;
&lt;/p&gt;
&lt;div class=&quot;collapse&quot; id=&quot;multi-collapse&quot;&gt;
 &lt;div class=&quot;card card-body&quot;&gt;
 多个触发器触发的内容
 &lt;/div&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#设计手风琴效果)设计手风琴效果

手风琴效果是一种特定的折叠效果，只有一个面板可以展开，其它面板自动折叠。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Container&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h2 class=&quot;mb-4&quot;&gt;手风琴示例&lt;/h2&gt;
&lt;h4&gt;个人简历&lt;/h4&gt;
&lt;div id=&quot;Example&quot;&gt;
 &lt;div class=&quot;card&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;
 &lt;button class=&quot;btn btn-link&quot; type=&quot;button&quot; data-toggle=&quot;collapse&quot; data-target=&quot;#one&quot;&gt;教育经历&lt;/button&gt;
 &lt;/div&gt;
 &lt;div id=&quot;one&quot; class=&quot;collapse show&quot; data-parent=&quot;#Example&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 毕业于加利福尼亚大学，学习的专业为计算机科学与技术。
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;
 &lt;button class=&quot;btn btn-link collapsed&quot; type=&quot;button&quot; data-toggle=&quot;collapse&quot; data-target=&quot;#two&quot;&gt;工作经验&lt;/button&gt;
 &lt;/div&gt;
 &lt;div id=&quot;two&quot; class=&quot;collapse show&quot; data-parent=&quot;#Example&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 做过一年的软件开发
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;card&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;
 &lt;button class=&quot;btn btn-link collapsed&quot; type=&quot;button&quot; data-toggle=&quot;collapse&quot; data-target=&quot;#three&quot;&gt;教育经历&lt;/button&gt;
 &lt;/div&gt;
 &lt;div id=&quot;three&quot; class=&quot;collapse show&quot; data-parent=&quot;#Example&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 篮球，足球，街舞，表演
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

#### [](#调用折叠)调用折叠

使用JavaScript或数据属性（如data-bs-toggle&#x3D;”collapse”）调用折叠效果。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Container&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;折叠事件&lt;/h3&gt;
&lt;div class=&quot;accordion&quot; id=&quot;accordionExample&quot;&gt;
 &lt;div class=&quot;card&quot;&gt;
 &lt;div class=&quot;card-header&quot;&gt;
 &lt;button class=&quot;btn btn-link&quot; type=&quot;button&quot; data-toggle=&quot;collapse&quot; data-target=&quot;#one&quot;&gt;折叠&lt;/button&gt;
 &lt;/div&gt;
 &lt;div id=&quot;one&quot; class=&quot;collapse&quot;&gt;
 &lt;div class=&quot;card-body&quot;&gt;
 折叠的内容
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
 $(&#x27;.collapse&#x27;).on(&#x27;shown.bs.collapse&#x27;,function () &#123;
 $(&#x27;body&#x27;).css(&#x27;background&#x27;,&#x27;#36ee23&#x27;);
 $(&#x27;[data-toggle=&quot;collapse&quot;]&#x27;).html(&#x27;折叠内容显示完成&#x27;)
 &#125;);
 $(&#x27;.collapse&#x27;).on(&#x27;hidden.bs.collapse&#x27;,function () &#123;
 $(&#x27;body&#x27;).css(&#x27;background&#x27;,&#x27;#fdff62&#x27;);
 $(&#x27;[data-toggle=&quot;collapse&quot;]&#x27;).html(&#x27;折叠内容隐藏完成&#x27;)
 &#125;)
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#添加用户行为)添加用户行为

可以使用事件监听器来添加自定义的用户行为，如点击展开&#x2F;折叠。

### [](#工具提示)工具提示

#### [](#定义工具提示)定义工具提示

工具提示是一种用户界面元素，用于显示附加信息。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
	&lt;head&gt;
		&lt;meta charset=&quot;UTF-8&quot;&gt;
		&lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
		&lt;title&gt;Container&lt;/title&gt;
		&lt;!-- Bootstrap核心css文件--&gt;
		&lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

	&lt;/head&gt;
	&lt;body class=&quot;container&quot;&gt;
		&lt;h2 class=&quot;mb-5&quot;&gt;定义工具提示&lt;/h2&gt;
		&lt;button type=&quot;button&quot; class=&quot;btn btn-secondary&quot; data-toggle=&quot;tooltip&quot; data-placement=&quot;top&quot;
			title=&quot;Tooltip on top&quot;&gt;
			Tooltip on top
		&lt;/button&gt;
		&lt;button type=&quot;button&quot; class=&quot;btn btn-secondary&quot; data-toggle=&quot;tooltip&quot; data-placement=&quot;right&quot;
			title=&quot;Tooltip on right&quot;&gt;
			Tooltip on right
		&lt;/button&gt;
		&lt;button type=&quot;button&quot; class=&quot;btn btn-secondary&quot; data-toggle=&quot;tooltip&quot; data-placement=&quot;bottom&quot;
			title=&quot;Tooltip on bottom&quot;&gt;
			Tooltip on bottom
		&lt;/button&gt;
		&lt;button type=&quot;button&quot; class=&quot;btn btn-secondary&quot; data-toggle=&quot;tooltip&quot; data-placement=&quot;left&quot;
			title=&quot;Tooltip on left&quot;&gt;
			Tooltip on left
		&lt;/button&gt;
		&lt;!--引入js文件--&gt;
		&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
		&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
		&lt;!--Bootstrap核心JavaScript文件--&gt;
		&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
		&lt;script&gt;
			$(function() &#123;
				// 使用data-toggle属性触发工具提示
				$(&#x27;[data-toggle=&quot;tooltip&quot;]&#x27;).tooltip();
			&#125;)
		&lt;/script&gt;
	&lt;/body&gt;
&lt;/html&gt;

#### [](#工具提示方向)工具提示方向

工具提示可以在不同的方向上显示，如顶部、底部、左侧或右侧。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Container&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h2 class=&quot;mb-5&quot;&gt;工具提示方向&lt;/h2&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-lg btn-danger ml-5&quot; data-toggle=&quot;tooltip&quot; data-placement=&quot;left&quot; data-trigger=&quot;click&quot; title=&quot;工具提示&quot;&gt;向左&lt;/button&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-lg btn-danger ml-5&quot; data-toggle=&quot;tooltip&quot; data-placement=&quot;right&quot; data-trigger=&quot;click&quot; title=&quot;工具提示&quot;&gt;向右&lt;/button&gt;
&lt;div class=&quot;my-5&quot;&gt;
 &lt;hr&gt;&lt;/div&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-lg btn-danger ml-5&quot; data-toggle=&quot;tooltip&quot; data-placement=&quot;top&quot; data-trigger=&quot;click&quot; title=&quot;工具提示&quot;&gt;向上&lt;/button&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-lg btn-danger ml-5&quot; data-toggle=&quot;tooltip&quot; data-placement=&quot;bottom&quot; data-trigger=&quot;click&quot; title=&quot;工具提示&quot;&gt;向下&lt;/button&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 // 使用data-toggle属性触发工具提示
 $(&#x27;[data-toggle=&quot;tooltip&quot;]&#x27;).tooltip();
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#调用工具提示)调用工具提示

使用data-bs-toggle&#x3D;”tooltip”和data-bs-placement来调用工具提示。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Container&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h2 class=&quot;mb-5&quot;&gt;添加自定义HTML&lt;/h2&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-danger&quot; data-html=&quot;true&quot; data-toggle=&quot;tooltip&quot; title=&quot;&lt;em&gt;&lt;b&gt;工具提示&lt;/b&gt;&lt;/em&gt;&lt;u&gt;添加&lt;/u&gt;&lt;b&gt;HTML&lt;/b&gt;&quot;&gt;工具提示添加自定义的HTML&lt;/button&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 // 使用data-toggle属性触发工具提示
 $(&#x27;[data-toggle=&quot;tooltip&quot;]&#x27;).tooltip();
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#添加用户行为-1)添加用户行为

通过JavaScript API或事件来触发工具提示的显示或隐藏。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;Container&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h2 class=&quot;mb-5&quot;&gt;工具提示事件&lt;/h2&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-info ml-5&quot; data-toggle=&quot;myTooltip&quot; id=&quot;myTooltip&quot;&gt;工具提示&lt;/button&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 $(&#x27;#myTooltip&#x27;).tooltip(&#123;
 title:&#x27;工具提示&#x27;,
 trigger:&#x27;click&#x27;,
 &#125;);
 $(&#x27;#myTooltip&#x27;).on(&#x27;show.bs.tooltip&#x27;,function () &#123;
 alert(&#x27;show.bs.tooltip&#x27;);
 $(this).removeClass(&#x27;btn-info&#x27;).addClass(&#x27;btn-primary&#x27;)
 &#125;);
 $(&#x27;#myTooltip&#x27;).on(&#x27;inserted.bs.tooltip&#x27;,function () &#123;
 alert(&#x27;inserted.bs.tooltip&#x27;);
 $(this).removeClass(&#x27;btn-primary&#x27;).addClass(&#x27;btn-danger&#x27;)
 &#125;);
 $(&#x27;#myTooltip&#x27;).on(&#x27;shown.bs.tooltip&#x27;,function () &#123;
 alert(&#x27;shown.bs.tooltip&#x27;);
 $(this).removeClass(&#x27;btn-danger&#x27;).addClass(&#x27;btn-info&#x27;)
 &#125;);
 $(&#x27;#myTooltip&#x27;).on(&#x27;hide.bs.tooltip&#x27;,function () &#123;
 alert(&#x27;hide.bs.tooltip&#x27;);
 $(this).removeClass(&#x27;btn-info&#x27;).addClass(&#x27;btn-success&#x27;)
 &#125;);
 $(&#x27;#myTooltip&#x27;).on(&#x27;hidden.bs.tooltip&#x27;,function () &#123;
 alert(&#x27;hidden.bs.tooltip&#x27;);
 $(this).removeClass(&#x27;btn-success&#x27;).addClass(&#x27;btn-info&#x27;)
 &#125;);
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

### [](#弹窗)弹窗

#### [](#定义弹窗)定义弹窗

弹窗是一种用于显示重要信息的模态窗口。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;深入精通JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;span data-toggle=&quot;popover&quot; title=&quot;弹窗标题&quot; data-content=&quot;弹窗内容&quot;&gt;
 &lt;button type=&quot;button&quot; class=&quot;btn btn-primary&quot;&gt;禁用按钮&lt;/button&gt;
&lt;/span&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 $(&#x27;[data-toggle=&quot;popover&quot;]&#x27;).popover();
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#弹窗方向)弹窗方向

弹窗通常在屏幕中央显示，但可以根据需求调整其位置。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;深入精通JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-5&quot;&gt;弹窗方向&lt;/h3&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-lg btn-danger ml-5&quot; data-toggle=&quot;popover&quot; data-placement=&quot;left&quot; title=&quot;弹窗标题&quot; data-content=&quot;弹窗内容&quot;&gt;向左&lt;/button&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-lg btn-danger ml-5&quot; data-toggle=&quot;popover&quot; data-placement=&quot;right&quot; title=&quot;弹窗标题&quot; data-content=&quot;弹窗内容&quot;&gt;向右&lt;/button&gt;
&lt;div class=&quot;my-5&quot;&gt;
 &lt;hr&gt;&lt;/div&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-lg btn-danger ml-5&quot; data-toggle=&quot;popover&quot; data-placement=&quot;top&quot; title=&quot;弹窗标题&quot; data-content=&quot;弹窗内容&quot;&gt;向上&lt;/button&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-lg btn-danger ml-5&quot; data-toggle=&quot;popover&quot; data-placement=&quot;bottom&quot; title=&quot;弹窗标题&quot; data-content=&quot;弹窗内容&quot;&gt;向下&lt;/button&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 $(&#x27;[data-toggle=&quot;popover&quot;]&#x27;).popover();
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#调用弹窗)调用弹窗

使用data-bs-toggle&#x3D;”modal”来调用弹窗，或使用JavaScript API进行操作。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;深入精通JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-5&quot;&gt;调用弹窗&lt;/h3&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-lg btn-danger ml-5&quot; data-toggle=&quot;popover&quot;&gt;弹窗&lt;/button&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 $(&#x27;[data-toggle=&quot;popover&quot;]&#x27;).popover(&#123;
 animation:true,
 html:true,
 offset:&#x27;200px&#x27;,
 title:&#x27;展翅飞翔的鹰&#x27;,
 content:&#x27;&lt;img src=&quot;https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1492166545,3998677836&amp;fm=26&amp;gp=0.jpg&quot; class=&quot;img-fluid&quot;&gt;&#x27;,
 trigger:&#x27;click&#x27;,
 delay:&#123;show:1000,hide:1000&#125;
 &#125;);
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#添加用户行为-2)添加用户行为

可以通过JavaScript事件来控制弹窗的显示、隐藏和交互。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;深入精通JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-5&quot;&gt;弹窗事件&lt;/h3&gt;
&lt;button type=&quot;button&quot; class=&quot;btn btn-info ml-5&quot; data-toggle=&quot;popover&quot; id=&quot;myPopover&quot;&gt;弹窗&lt;/button&gt;
&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 $(&#x27;#myPopover&#x27;).popover(&#123;
 title:&#x27;弹窗标题&#x27;,
 content:&#x27;弹窗内容&#x27;,
 trigger:&#x27;click&#x27;,
 &#125;);
 $(&#x27;#myPopover&#x27;).on(&#x27;show.bs.popover&#x27;,function () &#123;
 $(this).removeClass(&#x27;btn-info&#x27;).addClass(&#x27;btn-primary&#x27;);
 alert(&#x27;show.bs.popover&#x27;);
 &#125;);
 $(&#x27;#myPopover&#x27;).on(&#x27;inserted.bs.popover&#x27;,function () &#123;
 $(this).removeClass(&#x27;btn-primary&#x27;).addClass(&#x27;btn-danger&#x27;);
 alert(&#x27;inserted.bs.popover&#x27;);
 &#125;);
 $(&#x27;#myPopover&#x27;).on(&#x27;shown.bs.popover&#x27;,function () &#123;
 $(this).removeClass(&#x27;btn-danger&#x27;).addClass(&#x27;btn-info&#x27;);
 alert(&#x27;shown.bs.popover&#x27;);
 &#125;);
 $(&#x27;#myPopover&#x27;).on(&#x27;hide.bs.popover&#x27;,function () &#123;
 $(this).removeClass(&#x27;btn-info&#x27;).addClass(&#x27;btn-success&#x27;);
 alert(&#x27;hide.bs.popover&#x27;);
 &#125;);
 $(&#x27;#myPopover&#x27;).on(&#x27;hidden.bs.popover&#x27;,function () &#123;
 $(this).removeClass(&#x27;btn-success&#x27;).addClass(&#x27;btn-info&#x27;);
 alert(&#x27;hidden.bs.popover&#x27;);
 &#125;);
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

### [](#轮播)轮播

#### [](#定义轮播)定义轮播

轮播是一种可以自动切换内容的组件，常用于图片或内容的展示。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;深入精通JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;轮播效果&lt;/h3&gt;
&lt;div id=&quot;Carousel&quot; class=&quot;carousel slide&quot; data-ride=&quot;carousel&quot;&gt;
 &lt;!-- 标示图标--&gt;
 &lt;ol class=&quot;carousel-indicators&quot;&gt;
 &lt;li data-target=&quot;#Carousel&quot; data-slide-to=&quot;0&quot; class=&quot;active&quot;&gt;&lt;/li&gt;
 &lt;li data-target=&quot;#Carousel&quot; data-slide-to=&quot;1&quot;&gt;&lt;/li&gt;
 &lt;li data-target=&quot;#Carousel&quot; data-slide-to=&quot;2&quot;&gt;&lt;/li&gt;
 &lt;/ol&gt;
 &lt;!-- 幻灯片--&gt;
 &lt;div class=&quot;carousel-inner&quot;&gt;
 &lt;div class=&quot;carousel-item active&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592817812355&amp;di=3a9244ab51fcabd4a4ee4ebf6ae5df83&amp;imgtype=0&amp;src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D3609981743%2C3469269943%26fm%3D214%26gp%3D0.jpg&quot; class=&quot;d-block w-100&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;h5&gt;图片一&lt;/h5&gt;
 &lt;p&gt;说明文字&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;carousel-item&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592817810044&amp;di=b8ba750c6befb9ad8fbee4a2aedc032e&amp;imgtype=0&amp;src=http%3A%2F%2Fa1.att.hudong.com%2F81%2F71%2F01300000164151121808718718556.jpg&quot; class=&quot;d-block w-100&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;h5&gt;图片二&lt;/h5&gt;
 &lt;p&gt;说明文字&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;carousel-item&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592817810043&amp;di=6dbace02185a6f316a11b790e70fd5e9&amp;imgtype=0&amp;src=http%3A%2F%2Fa2.att.hudong.com%2F48%2F85%2F01300000190639122695850379005.jpg&quot; class=&quot;d-block w-100&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;h5&gt;图片三&lt;/h5&gt;
 &lt;p&gt;说明文字&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;!-- 按钮控制--&gt;
 &lt;a href=&quot;#Carousel&quot; class=&quot;carousel-control-prev&quot; data-slide=&quot;prev&quot;&gt;
 &lt;span class=&quot;carousel-control-prev-icon&quot;&gt;&lt;/span&gt;
 &lt;/a&gt;
 &lt;a href=&quot;#Carousel&quot; class=&quot;carousel-control-next&quot; data-slide=&quot;prev&quot;&gt;
 &lt;span class=&quot;carousel-control-next-icon&quot;&gt;&lt;/span&gt;
 &lt;/a&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;

&lt;/body&gt;
&lt;/html&gt;

#### [](#设计轮播风格)设计轮播风格

可以自定义轮播的样式和过渡效果。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;深入精通JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;交叉淡入淡出效果&lt;/h3&gt;
&lt;div id=&quot;Carousel&quot; class=&quot;carousel slide carousel-fade w-50&quot; data-ride=&quot;carousel&quot;&gt;
 &lt;!-- 标示图标--&gt;
 &lt;ol class=&quot;carousel-indicators&quot;&gt;
 &lt;li data-target=&quot;#Carousel&quot; data-slide-to=&quot;0&quot; class=&quot;active&quot;&gt;&lt;/li&gt;
 &lt;li data-target=&quot;#Carousel&quot; data-slide-to=&quot;1&quot;&gt;&lt;/li&gt;
 &lt;li data-target=&quot;#Carousel&quot; data-slide-to=&quot;2&quot;&gt;&lt;/li&gt;
 &lt;/ol&gt;
 &lt;!-- 幻灯片--&gt;
 &lt;div class=&quot;carousel-inner&quot;&gt;
 &lt;div class=&quot;carousel-item active&quot; data-interval=&quot;1000&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592817812355&amp;di=3a9244ab51fcabd4a4ee4ebf6ae5df83&amp;imgtype=0&amp;src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D3609981743%2C3469269943%26fm%3D214%26gp%3D0.jpg&quot; class=&quot;d-block w-100&quot; style=&quot;height: 600px&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;h5&gt;图片一&lt;/h5&gt;
 &lt;p class=&quot;text-danger&quot;&gt;说明文字&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;carousel-item&quot; data-interval=&quot;1000&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592817810044&amp;di=b8ba750c6befb9ad8fbee4a2aedc032e&amp;imgtype=0&amp;src=http%3A%2F%2Fa1.att.hudong.com%2F81%2F71%2F01300000164151121808718718556.jpg&quot; class=&quot;d-block w-100&quot; style=&quot;height: 600px&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;h5&gt;图片二&lt;/h5&gt;
 &lt;p class=&quot;text-danger&quot;&gt;说明文字&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;carousel-item&quot; data-interval=&quot;1000&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592817810043&amp;di=6dbace02185a6f316a11b790e70fd5e9&amp;imgtype=0&amp;src=http%3A%2F%2Fa2.att.hudong.com%2F48%2F85%2F01300000190639122695850379005.jpg&quot; class=&quot;d-block w-100&quot; style=&quot;height: 600px&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;h5&gt;图片三&lt;/h5&gt;
 &lt;p class=&quot;text-danger&quot;&gt;说明文字&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;!-- 按钮控制--&gt;
 &lt;a href=&quot;#Carousel&quot; class=&quot;carousel-control-prev&quot; data-slide=&quot;prev&quot;&gt;
 &lt;span class=&quot;carousel-control-prev-icon&quot;&gt;&lt;/span&gt;
 &lt;/a&gt;
 &lt;a href=&quot;#Carousel&quot; class=&quot;carousel-control-next&quot; data-slide=&quot;prev&quot;&gt;
 &lt;span class=&quot;carousel-control-next-icon&quot;&gt;&lt;/span&gt;
 &lt;/a&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;

&lt;/body&gt;
&lt;/html&gt;

#### [](#调用轮播)调用轮播

使用data-bs-ride&#x3D;”carousel”来初始化轮播组件。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;深入精通JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;

&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;轮播事件&lt;/h3&gt;
&lt;div id=&quot;Carousel&quot; class=&quot;carousel slide carousel-fade w-50&quot; data-ride=&quot;carousel&quot;&gt;
 &lt;!-- 标示图标--&gt;
 &lt;ol class=&quot;carousel-indicators&quot;&gt;
 &lt;li data-target=&quot;#Carousel&quot; data-slide-to=&quot;0&quot; class=&quot;active&quot;&gt;&lt;/li&gt;
 &lt;li data-target=&quot;#Carousel&quot; data-slide-to=&quot;1&quot;&gt;&lt;/li&gt;
 &lt;li data-target=&quot;#Carousel&quot; data-slide-to=&quot;2&quot;&gt;&lt;/li&gt;
 &lt;/ol&gt;
 &lt;!-- 幻灯片--&gt;
 &lt;div class=&quot;carousel-inner&quot;&gt;
 &lt;div class=&quot;carousel-item active&quot; data-interval=&quot;1000&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592817812355&amp;di=3a9244ab51fcabd4a4ee4ebf6ae5df83&amp;imgtype=0&amp;src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D3609981743%2C3469269943%26fm%3D214%26gp%3D0.jpg&quot; class=&quot;d-block w-100&quot; style=&quot;height: 600px&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;h5&gt;图片一&lt;/h5&gt;
 &lt;p&gt;说明文字&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;carousel-item&quot; data-interval=&quot;1000&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592817810044&amp;di=b8ba750c6befb9ad8fbee4a2aedc032e&amp;imgtype=0&amp;src=http%3A%2F%2Fa1.att.hudong.com%2F81%2F71%2F01300000164151121808718718556.jpg&quot; class=&quot;d-block w-100&quot; style=&quot;height: 600px&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;h5&gt;图片二&lt;/h5&gt;
 &lt;p&gt;说明文字&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;carousel-item&quot; data-interval=&quot;1000&quot;&gt;
 &lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592817810043&amp;di=6dbace02185a6f316a11b790e70fd5e9&amp;imgtype=0&amp;src=http%3A%2F%2Fa2.att.hudong.com%2F48%2F85%2F01300000190639122695850379005.jpg&quot; class=&quot;d-block w-100&quot; style=&quot;height: 600px&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;h5&gt;图片三&lt;/h5&gt;
 &lt;p&gt;说明文字&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;!-- 按钮控制--&gt;
 &lt;a href=&quot;#Carousel&quot; class=&quot;carousel-control-prev&quot; data-slide=&quot;prev&quot;&gt;
 &lt;span class=&quot;carousel-control-prev-icon&quot;&gt;&lt;/span&gt;
 &lt;/a&gt;
 &lt;a href=&quot;#Carousel&quot; class=&quot;carousel-control-next&quot; data-slide=&quot;prev&quot;&gt;
 &lt;span class=&quot;carousel-control-next-icon&quot;&gt;&lt;/span&gt;
 &lt;/a&gt;
&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 $(&#x27;.carousel&#x27;).on(&#x27;slide.bs.carousel&#x27;,function (e) &#123;
 e.target.style.border=&#x27;solid 10px #FF1493&#x27;;
 &#125;);
 $(&#x27;.carousel&#x27;).on(&#x27;slid.bs.carousel&#x27;,function (e) &#123;
 e.target.style.border=&#x27;solid 10px #9C9C9C&#x27;;
 &#125;)
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

### [](#滚动监听)滚动监听

#### [](#定义滚动监听)定义滚动监听

滚动监听是一种用于在用户滚动页面时触发特定行为的功能。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;renderer&quot; content=&quot;webkit&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;深入精通JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;
 &lt;style&gt;
 .Scrollspy &#123;
 width: 500px;
 height: 400px;
 overflow: scroll;
 &#125;
 &lt;/style&gt;
&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;nav id=&quot;navbar&quot; class=&quot;navbar navbar-light bg-light&quot;&gt;
 &lt;ul class=&quot;nav nav-pills&quot;&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a href=&quot;#list1&quot; class=&quot;nav-link&quot;&gt;列表1&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a href=&quot;#list2&quot; class=&quot;nav-link&quot;&gt;列表2&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;nav-item dropdown&quot;&gt;
 &lt;a class=&quot;nav-link dropdown-toggle&quot; data-toggle=&quot;dropdown&quot; href=&quot;#&quot;&gt;下拉菜单&lt;/a&gt;
 &lt;div class=&quot;dropdown-menu&quot;&gt;
 &lt;a href=&quot;#menu1&quot; class=&quot;dropdown-item&quot;&gt;菜单1&lt;/a&gt;
 &lt;a href=&quot;#menu2&quot; class=&quot;dropdown-item&quot;&gt;菜单2&lt;/a&gt;
 &lt;a href=&quot;#menu3&quot; class=&quot;dropdown-item&quot;&gt;菜单3&lt;/a&gt;
 &lt;/div&gt;
 &lt;/li&gt;
 &lt;/ul&gt;
&lt;/nav&gt;
&lt;div data-spy=&quot;scroll&quot; data-target=&quot;#navbar&quot; data-offset=&quot;80&quot; class=&quot;Scrollspy&quot;&gt;
 &lt;h4 id=&quot;list1&quot;&gt;列表1&lt;/h4&gt;
 &lt;p&gt;&lt;img src=&quot;https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1816366408,1729518576&amp;fm=26&amp;gp=0.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;&lt;/p&gt;
 &lt;h4 id=&quot;list2&quot;&gt;列表2&lt;/h4&gt;
 &lt;p&gt;&lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592841048969&amp;di=6bda4d1b34aa657368850d661b49f948&amp;imgtype=0&amp;src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20190508%2F17%2F1557307364-SJENtIuizm.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;&lt;/p&gt;
 &lt;h4 id=&quot;menu1&quot;&gt;菜单1&lt;/h4&gt;
 &lt;p&gt;&lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592841048969&amp;di=ddcf6d9c187a8485f7b1c4d2d02bd2aa&amp;imgtype=0&amp;src=http%3A%2F%2Fimage.huahuibk.com%2Fuploads%2F20190130%2F19%2F1548848720-ETVQwCkWqG.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;&lt;/p&gt;
 &lt;h4 id=&quot;menu2&quot;&gt;菜单2&lt;/h4&gt;
 &lt;p&gt;&lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592841048969&amp;di=fef15d53553ce8c72a7e4178ff970988&amp;imgtype=0&amp;src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20180830%2F22%2F1535637788-yPpZcnIXbh.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;&lt;/p&gt;
 &lt;h4 id=&quot;menu3&quot;&gt;菜单3&lt;/h4&gt;
 &lt;p&gt;&lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592841048968&amp;di=e3c3e328e1d2ff857dfc291e36b1794c&amp;imgtype=0&amp;src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20190508%2F16%2F1557305155-IeLDpTwbPZ.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;&lt;/p&gt;

&lt;/div&gt;

&lt;!--引入js文件--&gt;
&lt;script src=&quot;https://code.jquery.com/jquery-3.3.1.slim.min.js&quot;&gt;&lt;/script&gt;
&lt;script src=&quot;https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js&quot;&gt;&lt;/script&gt;
&lt;!--Bootstrap核心JavaScript文件--&gt;
&lt;script src=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/js/bootstrap.min.js&quot;&gt;&lt;/script&gt;
&lt;script&gt;
 $(function () &#123;
 $(&#x27;body&#x27;).on(&#x27;activate.bs.scrollspy&#x27;,function (e) &#123;
 $(&#x27;body&#x27;).css(&#x27;background&#x27;,&#x27;yellow&#x27;)
 &#125;)
 &#125;)
&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

#### [](#调用滚动监听)调用滚动监听

使用window.onscroll事件或第三方库来监听滚动事件。

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;深入精通JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;
 &lt;style&gt;
 .Scrollspy &#123;
 width: 500px;
 height: 500px;
 overflow: scroll;
 &#125;
 &lt;/style&gt;
&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h3 class=&quot;mb-4&quot;&gt;列表组示例&lt;/h3&gt;
&lt;div class=&quot;row&quot;&gt;
 &lt;div class=&quot;col-3&quot;&gt;
 &lt;div id=&quot;list&quot; class=&quot;list-group&quot;&gt;
 &lt;a href=&quot;#list-item-1&quot; class=&quot;list-group-item list-group-item-action&quot;&gt;Item 1&lt;/a&gt;
 &lt;a href=&quot;#list-item-2&quot; class=&quot;list-group-item list-group-item-action&quot;&gt;Item 2&lt;/a&gt;
 &lt;a href=&quot;#list-item-3&quot; class=&quot;list-group-item list-group-item-action&quot;&gt;Item 3&lt;/a&gt;
 &lt;a href=&quot;#list-item-4&quot; class=&quot;list-group-item list-group-item-action&quot;&gt;Item 4&lt;/a&gt;
 &lt;a href=&quot;#list-item-5&quot; class=&quot;list-group-item list-group-item-action&quot;&gt;Item 5&lt;/a&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-9&quot;&gt;
 &lt;div data-spy=&quot;scroll&quot; data-target=&quot;#list&quot; data-offset=&quot;0&quot; class=&quot;Scrollspy&quot;&gt;
 &lt;h4 id=&quot;list-item-1&quot;&gt;Item 1&lt;/h4&gt;
 &lt;p&gt;&lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592838590989&amp;di=3b26fd142d85a57c35be1a1a195e8d6e&amp;imgtype=0&amp;src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F0%2F579724e59c09f.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;&lt;/p&gt;
 &lt;h4 id=&quot;list-item-2&quot;&gt;Item 2&lt;/h4&gt;
 &lt;p&gt;&lt;img src=&quot;https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1592838542645&amp;di=0aaa7145cc7a0e193d446c5c421e2b2d&amp;imgtype=0&amp;src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1212%2F17%2Fc2%2F16677046_1355737208957.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;&lt;/p&gt;
 &lt;h4 id=&quot;list-item-3&quot;&gt;Item 3&lt;/h4&gt;
 &lt;p&gt;&lt;img src=&quot;https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3446717444,2037982531&amp;fm=26&amp;gp=0.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;&lt;/p&gt;
 &lt;h4 id=&quot;list-item-4&quot;&gt;Item 4&lt;/h4&gt;
 &lt;p&gt;&lt;img src=&quot;https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3513235684,2788458109&amp;fm=26&amp;gp=0.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;&lt;/p&gt;
 &lt;h4 id=&quot;list-item-5&quot;&gt;Item 5&lt;/h4&gt;
 &lt;p&gt;&lt;img src=&quot;https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=213101828,1173125753&amp;fm=26&amp;gp=0.jpg&quot; alt=&quot;&quot; class=&quot;img-fluid&quot;&gt;&lt;/p&gt;
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

### [](#实战实训1—设计折叠搜索框)实战实训1—设计折叠搜索框

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;深入精通JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;../fontawesome-free-5.13.1-web/css/all.css&quot;&gt;
 &lt;style&gt;
 i &#123;
 border: 1px solid black;
 border-radius: 50%;
 padding: 5px;
 &#125;

 i:hover &#123;
 background: #00aa88;
 color: white;
 &#125;
 &lt;/style&gt;
&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;nav class=&quot;navbar navbar-expand-md navbar-light bg-light mt-3&quot;&gt;
 &lt;a href=&quot;#&quot; class=&quot;navbar-brand&quot;&gt;LOGO&lt;/a&gt;
 &lt;button class=&quot;navbar-toggler&quot; type=&quot;button&quot; data-toggle=&quot;collapse&quot; data-target=&quot;#navbarContent&quot;&gt;
 &lt;span class=&quot;navbar-toggler-icon&quot;&gt;&lt;/span&gt;
 &lt;/button&gt;
 &lt;div class=&quot;collapse navbar-collapse&quot; id=&quot;navbarContent&quot;&gt;
 &lt;ul class=&quot;navbar-nav mr-auto&quot;&gt;
 &lt;li class=&quot;nav-item active&quot;&gt;
 &lt;a href=&quot;#&quot; class=&quot;nav-link&quot;&gt;首页&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a href=&quot;#&quot; class=&quot;nav-link&quot;&gt;关于我们&lt;/a&gt;
 &lt;/li&gt;
 &lt;li class=&quot;nav-item&quot;&gt;
 &lt;a href=&quot;#&quot; class=&quot;nav-link&quot;&gt;联系我们&lt;/a&gt;
 &lt;/li&gt;
 &lt;/ul&gt;
 &lt;div&gt;
 &lt;a href=&quot;#&quot;&gt;&lt;i class=&quot;fa fa-shopping-cart mr-3&quot;&gt;&lt;/i&gt;&lt;/a&gt;
 &lt;a href=&quot;#&quot; data-toggle=&quot;collapse&quot; data-target=&quot;#collapseExample&quot;&gt;&lt;i class=&quot;fa fa-search&quot;&gt;&lt;/i&gt;&lt;/a&gt;
 &lt;/div&gt;

 &lt;/div&gt;
&lt;/nav&gt;
&lt;div class=&quot;d-flex justify-content-end mr-3 mt-1&quot;&gt;
 &lt;div class=&quot;collapse&quot; id=&quot;collapseExample&quot;&gt;
 &lt;div class=&quot;form-group form-inline&quot;&gt;
 &lt;input type=&quot;search&quot; class=&quot;form-control mr-2&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;btn btn-primary&quot;&gt;搜索&lt;/a&gt;
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

### [](#实战实训2—仿小米内容展示)实战实训2—仿小米内容展示

&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;en&quot;&gt;
&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot;&gt;
 &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width,initial-scale=1,shrink-to-fit=no&quot;&gt;
 &lt;title&gt;深入精通JavaScript插件&lt;/title&gt;
 &lt;!-- Bootstrap核心css文件--&gt;
 &lt;link rel=&quot;stylesheet&quot; href=&quot;https://cdn.bootcss.com/twitter-bootstrap/4.4.1/css/bootstrap.min.css&quot;&gt;
 &lt;style&gt;
 body&#123;
 min-width: 992px;
 &#125;
 .carousel-indicators li&#123;
 width: 8px;
 height: 8px;
 border-radius: 50%;
 margin-left: 15px;
 &#125;
 .col-3:hover&#123;
 transform: translateY(-5px);
 &#125;
 &lt;/style&gt;
&lt;/head&gt;
&lt;body class=&quot;container&quot;&gt;
&lt;h4 class=&quot;mb-4&quot;&gt;内容展示&lt;/h4&gt;
&lt;div class=&quot;row&quot;&gt;
 &lt;div class=&quot;col-3&quot;&gt;
 &lt;div id=&quot;Carousel&quot; class=&quot;carousel slide&quot; data-ride=&quot;carousel&quot;&gt;
 &lt;ol class=&quot;carousel-indicators&quot;&gt;
 &lt;li data-target=&quot;#Carousel&quot; data-slide-to=&quot;0&quot; class=&quot;active&quot;&gt;&lt;/li&gt;
 &lt;li data-target=&quot;#Carousel&quot; data-slide-to=&quot;1&quot;&gt;&lt;/li&gt;
 &lt;li data-target=&quot;#Carousel&quot; data-slide-to=&quot;2&quot;&gt;&lt;/li&gt;
 &lt;/ol&gt;
 &lt;div class=&quot;carousel-inner&quot;&gt;
 &lt;div class=&quot;carousel-item active&quot;&gt;
 &lt;img src=&quot;//img12.360buyimg.com/n7/jfs/t1/130673/1/2572/166108/5eec1c9fE122ff56f/ee7678ab000ec2fa.jpg&quot; class=&quot;d-block w-100&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;p class=&quot;text-danger&quot;&gt;女士服装&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;carousel-item&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/143961/23/279/89997/5edf26d9E50f655c9/0182ab8049f3c884.jpg&quot; class=&quot;d-block w-100&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;p class=&quot;text-danger&quot;&gt;女士服装&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;carousel-item&quot;&gt;
 &lt;img src=&quot;//img14.360buyimg.com/n7/jfs/t1/107890/24/12556/188366/5e993588Ece609b77/e840b11255d10d71.jpg&quot; class=&quot;d-block w-100&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;p class=&quot;text-danger&quot;&gt;女士服装&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;a href=&quot;#Carousel&quot; class=&quot;carousel-control-prev&quot; data-slide=&quot;prev&quot;&gt;&lt;span class=&quot;carousel-control-prev-icon&quot;&gt;&lt;/span&gt;&lt;/a&gt;
 &lt;a href=&quot;#Carousel&quot; class=&quot;carousel-control-next&quot; data-slide=&quot;prev&quot;&gt;&lt;span class=&quot;carousel-control-next-icon&quot;&gt;&lt;/span&gt;&lt;/a&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3&quot;&gt;
 &lt;div id=&quot;Carousel1&quot; class=&quot;carousel slide&quot; data-ride=&quot;carousel&quot;&gt;
 &lt;ol class=&quot;carousel-indicators&quot;&gt;
 &lt;li data-target=&quot;#Carousel1&quot; data-slide-to=&quot;0&quot; class=&quot;active&quot;&gt;&lt;/li&gt;
 &lt;li data-target=&quot;#Carousel1&quot; data-slide-to=&quot;1&quot;&gt;&lt;/li&gt;
 &lt;li data-target=&quot;#Carousel1&quot; data-slide-to=&quot;2&quot;&gt;&lt;/li&gt;
 &lt;/ol&gt;
 &lt;div class=&quot;carousel-inner&quot;&gt;
 &lt;div class=&quot;carousel-item active&quot;&gt;
 &lt;img src=&quot;//img12.360buyimg.com/n7/jfs/t1/130673/1/2572/166108/5eec1c9fE122ff56f/ee7678ab000ec2fa.jpg&quot; class=&quot;d-block w-100&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;p class=&quot;text-danger&quot;&gt;女士服装&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;carousel-item&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/143961/23/279/89997/5edf26d9E50f655c9/0182ab8049f3c884.jpg&quot; class=&quot;d-block w-100&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;p class=&quot;text-danger&quot;&gt;女士服装&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;carousel-item&quot;&gt;
 &lt;img src=&quot;//img14.360buyimg.com/n7/jfs/t1/107890/24/12556/188366/5e993588Ece609b77/e840b11255d10d71.jpg&quot; class=&quot;d-block w-100&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;p class=&quot;text-danger&quot;&gt;女士服装&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;a href=&quot;#Carousel1&quot; class=&quot;carousel-control-prev&quot; data-slide=&quot;prev&quot;&gt;&lt;span class=&quot;carousel-control-prev-icon&quot;&gt;&lt;/span&gt;&lt;/a&gt;
 &lt;a href=&quot;#Carousel1&quot; class=&quot;carousel-control-next&quot; data-slide=&quot;prev&quot;&gt;&lt;span class=&quot;carousel-control-next-icon&quot;&gt;&lt;/span&gt;&lt;/a&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3&quot;&gt;
 &lt;div id=&quot;Carousel2&quot; class=&quot;carousel slide&quot; data-ride=&quot;carousel&quot;&gt;
 &lt;ol class=&quot;carousel-indicators&quot;&gt;
 &lt;li data-target=&quot;#Carousel2&quot; data-slide-to=&quot;0&quot; class=&quot;active&quot;&gt;&lt;/li&gt;
 &lt;li data-target=&quot;#Carousel2&quot; data-slide-to=&quot;1&quot;&gt;&lt;/li&gt;
 &lt;li data-target=&quot;#Carousel2&quot; data-slide-to=&quot;2&quot;&gt;&lt;/li&gt;
 &lt;/ol&gt;
 &lt;div class=&quot;carousel-inner&quot;&gt;
 &lt;div class=&quot;carousel-item active&quot;&gt;
 &lt;img src=&quot;//img12.360buyimg.com/n7/jfs/t1/130673/1/2572/166108/5eec1c9fE122ff56f/ee7678ab000ec2fa.jpg&quot; class=&quot;d-block w-100&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;p class=&quot;text-danger&quot;&gt;女士服装&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;carousel-item&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/143961/23/279/89997/5edf26d9E50f655c9/0182ab8049f3c884.jpg&quot; class=&quot;d-block w-100&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;p class=&quot;text-danger&quot;&gt;女士服装&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;carousel-item&quot;&gt;
 &lt;img src=&quot;//img14.360buyimg.com/n7/jfs/t1/107890/24/12556/188366/5e993588Ece609b77/e840b11255d10d71.jpg&quot; class=&quot;d-block w-100&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;p class=&quot;text-danger&quot;&gt;女士服装&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;a href=&quot;#Carousel2&quot; class=&quot;carousel-control-prev&quot; data-slide=&quot;prev&quot;&gt;&lt;span class=&quot;carousel-control-prev-icon&quot;&gt;&lt;/span&gt;&lt;/a&gt;
 &lt;a href=&quot;#Carousel2&quot; class=&quot;carousel-control-next&quot; data-slide=&quot;prev&quot;&gt;&lt;span class=&quot;carousel-control-next-icon&quot;&gt;&lt;/span&gt;&lt;/a&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;col-3&quot;&gt;
 &lt;div id=&quot;Carousel3&quot; class=&quot;carousel slide&quot; data-ride=&quot;carousel&quot;&gt;
 &lt;ol class=&quot;carousel-indicators&quot;&gt;
 &lt;li data-target=&quot;#Carousel3&quot; data-slide-to=&quot;0&quot; class=&quot;active&quot;&gt;&lt;/li&gt;
 &lt;li data-target=&quot;#Carousel3&quot; data-slide-to=&quot;1&quot;&gt;&lt;/li&gt;
 &lt;li data-target=&quot;#Carousel3&quot; data-slide-to=&quot;2&quot;&gt;&lt;/li&gt;
 &lt;/ol&gt;
 &lt;div class=&quot;carousel-inner&quot;&gt;
 &lt;div class=&quot;carousel-item active&quot;&gt;
 &lt;img src=&quot;//img12.360buyimg.com/n7/jfs/t1/130673/1/2572/166108/5eec1c9fE122ff56f/ee7678ab000ec2fa.jpg&quot; class=&quot;d-block w-100&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;p class=&quot;text-danger&quot;&gt;女士服装&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;carousel-item&quot;&gt;
 &lt;img src=&quot;//img11.360buyimg.com/n7/jfs/t1/143961/23/279/89997/5edf26d9E50f655c9/0182ab8049f3c884.jpg&quot; class=&quot;d-block w-100&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;p class=&quot;text-danger&quot;&gt;女士服装&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;div class=&quot;carousel-item&quot;&gt;
 &lt;img src=&quot;//img14.360buyimg.com/n7/jfs/t1/107890/24/12556/188366/5e993588Ece609b77/e840b11255d10d71.jpg&quot; class=&quot;d-block w-100&quot; alt=&quot;&quot;&gt;
 &lt;div class=&quot;carousel-caption&quot;&gt;
 &lt;p class=&quot;text-danger&quot;&gt;女士服装&lt;/p&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;/div&gt;
 &lt;a href=&quot;#Carousel3&quot; class=&quot;carousel-control-prev&quot; data-slide=&quot;prev&quot;&gt;&lt;span class=&quot;carousel-control-prev-icon&quot;&gt;&lt;/span&gt;&lt;/a&gt;
 &lt;a href=&quot;#Carousel3&quot; class=&quot;carousel-control-next&quot; data-slide=&quot;prev&quot;&gt;&lt;span class=&quot;carousel-control-next-icon&quot;&gt;&lt;/span&gt;&lt;/a&gt;
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

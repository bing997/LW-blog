---
title: 【Vue】基础系列（二）模板语法 - 插值语法 - 指令语法
date: 2024-08-22
categories:
  - Vue
tags:
  - Vue
  - 教程
---

## [](#Vue-基础系列-二)Vue-基础系列(二)

Vue有很多模板语法特别好用，就是在HTML中写一些Vue定义的一些模板语法，可以快速的展现数据，绑定方法等。这也就是Vue上手很快的原因之一。

### [](#模板的理解)模板的理解

模板就是动态html页面，这里面包含了一些js语法代码

Vue的模板语法分为两种，分别是：

- 【**插值语法**】双大括号表达式 （“Mustache”语法）【一个】

- 【**指令语法**】指令（以v-开头的自定义标签属性）【很多】

#### [](#插值语法：)插值语法：

- **功能**：用于解析标签体内容，向页面输出数据

- **写法**：`&#123;&#123;xxx&#125;&#125;`，xxx是js表达式，且可以直接读取到data中的所有属性，可以调用对象的方法

- **备注**：里面写**js表达式**：有返回值的js代码，而不是**js语句**

#### [](#指令语法：)指令语法：

- **功能**：用于解析标签（包括：标签属性、标签体内容、绑定事件…..）

- **举例**：`v-bind:href=&quot;xxx&quot;` 或 简写为 `:href=&quot;xxx&quot;`，xxx同样要写js表达式，且可以直接读取到data中的所有属性

- **备注**：Vue中有很多的指令，且形式都是：`v-????`

&lt;!DOCTYPE html&gt;
&lt;html&gt;
	&lt;head&gt;
		&lt;meta charset=&quot;UTF-8&quot; /&gt;
		&lt;title&gt;模板语法&lt;/title&gt;
		&lt;!-- 引入Vue --&gt;
		&lt;script type=&quot;text/javascript&quot; src=&quot;../js/vue.js&quot;&gt;&lt;/script&gt;
	&lt;/head&gt;
	&lt;body&gt;
		
		&lt;!-- 准备好一个容器--&gt;
		&lt;div id=&quot;root&quot;&gt;
			&lt;h1&gt;插值语法&lt;/h1&gt;
			&lt;h3&gt;你好，&#123;&#123;name&#125;&#125;&lt;/h3&gt;
			&lt;hr/&gt;
			&lt;h1&gt;指令语法&lt;/h1&gt;
			&lt;a v-bind:href=&quot;school.url.toUpperCase()&quot; x=&quot;hello&quot;&gt;点我去&#123;&#123;school.name&#125;&#125;学习1&lt;/a&gt;
			&lt;a :href=&quot;school.url&quot; x=&quot;hello&quot;&gt;点我去&#123;&#123;school.name&#125;&#125;学习2&lt;/a&gt;
		&lt;/div&gt;
	&lt;/body&gt;

	&lt;script type=&quot;text/javascript&quot;&gt;
		Vue.config.productionTip = false //阻止 vue 在启动时生成生产提示。

		new Vue(&#123;
			el:&#x27;#root&#x27;,
			data:&#123;
				name:&#x27;jack&#x27;,
				school:&#123;
					name:&#x27;百度&#x27;,
					url:&#x27;https://www.baidu.com&#x27;,
				&#125;
			&#125;
		&#125;)
	&lt;/script&gt;
&lt;/html&gt;

### [](#指令语法：强制数据绑定-v-bind)指令语法：强制数据绑定 v-bind:

> 

功能：指定变化的属性值

完整写法

v-bind:xxx=&#x27;yyy&#x27; // yyy会作为表达式解析执行

简洁写法

:xxx=&#x27;yyy&#x27;

#### [](#单向数据绑定)单向数据绑定

**语法**：`v-bind:href =&quot;xxx&quot;` 或简写为 `:href =&quot;xxx&quot;`

**特点**：数据只能从 data 流向页面

#### [](#双向数据绑定-指令-v-model)双向数据绑定 指令 v-model

**语法**：`v-mode:value=&quot;xxx&quot;` 或简写为 `v-model=&quot;xxx&quot;`

**特点**：数据不仅能从 data 流向页面，还能从页面流向 data

### [](#指令语法：绑定事件监听-v-on)指令语法：绑定事件监听 v-on:

> 

功能：绑定指定事件名的回调函数

完整写法

v-on:click=&#x27;xxx&#x27;
v-on:keyup=&#x27;xxx(参数)&#x27;
v-on:keyup.enter=&#x27;xxx&#x27;

简洁写法

@click=&#x27;xxx&#x27;
@keyup=&#x27;xxx&#x27;
@keyup.enter=&#x27;xxx&#x27;

### [](#v-text与v-html)v-text与v-html

在Vue.js中，`v-text`和`v-html`都是用于更新DOM元素内容的指令，但它们的用途和行为有所不同

#### [](#v-text)v-text

**功能**：`v-text`指令用于将文本内容插入到DOM元素中，并且会覆盖元素中的所有现有内容。与插值语法的区别：`v-text`会替换掉节点中的内容，`&#123;&#123;xx&#125;&#125;`则不会。

**安全性**：`v-text`会自动对插入的内容进行HTML转义，防止XSS攻击。

> 

示例代码

&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
 &lt;title&gt;Vue v-text Example&lt;/title&gt;
 &lt;script src=&quot;https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
 &lt;div id=&quot;app&quot;&gt;
 &lt;p v-text=&quot;message&quot;&gt;&lt;/p&gt;
 &lt;/div&gt;

 &lt;script&gt;
 new Vue(&#123;
 el: &#x27;#app&#x27;,
 data: &#123;
 message: &#x27;&lt;strong&gt;Hello Vue!&lt;/strong&gt;&#x27;
 &#125;
 &#125;);
 &lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

解释：`v-text=&quot;message&quot;`将message的数据绑定到`&lt;p&gt;`元素中，并以纯文本形式显示内容，即使message包含HTML标签也会被转义为文本。

> 

渲染结果：

&lt;p&gt;&amp;lt;strong&amp;gt;Hello Vue!&amp;lt;/strong&amp;gt;&lt;/p&gt;

#### [](#v-html)v-html

**功能**：`v-html`指令用于将HTML内容插入到DOM元素中，并且会覆盖元素中的所有现有内容。

**安全性**：`v-html`不会对插入的内容进行HTML转义，因此它会**直接渲染HTML标签**。这意味着，如果插入的内容来自不受信任的源，可能会引发XSS攻击风险。因此，在使用`v-html`时要非常小心，确保插入的HTML内容是安全的。

> 

示例代码

&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
 &lt;title&gt;Vue v-html Example&lt;/title&gt;
 &lt;script src=&quot;https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
 &lt;div id=&quot;app&quot;&gt;
 &lt;p v-html=&quot;message&quot;&gt;&lt;/p&gt;
 &lt;/div&gt;

 &lt;script&gt;
 new Vue(&#123;
 el: &#x27;#app&#x27;,
 data: &#123;
 message: &#x27;&lt;strong&gt;Hello Vue!&lt;/strong&gt;&#x27;
 &#125;
 &#125;);
 &lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

解释：`v-html=&quot;message&quot;`将message的数据绑定到`&lt;p&gt;`元素中，并将其作为HTML内容渲染。HTML标签在内容中会被正常解析并显示为HTML。

&lt;p&gt;&lt;strong&gt;Hello Vue!&lt;/strong&gt;&lt;/p&gt;

#### [](#区别总结)区别总结

`v-text`：用于插入纯文本内容，自动进行HTML转义，安全性较高。
`v-html`：用于插入HTML内容，不进行转义，直接渲染HTML标签，需注意潜在的安全风险。

> 

在选择使用`v-text`或`v-html`时，考虑到安全性，通常建议尽可能使用`v-text`，只有在确实需要动态插入和渲染HTML内容时才使用`v-html`，并确保插入的内容是安全的。

### [](#条件渲染指令)条件渲染指令

在Vue.js中，条件渲染指令用于根据表达式的结果动态地控制DOM元素的显示或隐藏。主要的条件渲染指令有 `v-if`、`v-else-if`、`v-else` 和 `v-show`。

#### [](#v-if-指令)v-if 指令

**功能**：`v-if` 指令用于根据表达式的布尔值决定是否在DOM中渲染元素。如果表达式为 true，则渲染该元素；否则移除该元素及其子元素。

**性能**：`v-if` 是“真正的”条件渲染，因为在条件为 false 时，Vue 不会渲染元素和子元素，因此在性能上比 `v-show` 更节省资源，尤其是在切换频率较低的场景中。

> 

示例代码

&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
 &lt;title&gt;Vue v-if Example&lt;/title&gt;
 &lt;script src=&quot;https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
 &lt;div id=&quot;app&quot;&gt;
 &lt;p v-if=&quot;isVisible&quot;&gt;This text is conditionally rendered.&lt;/p&gt;
 &lt;/div&gt;

 &lt;script&gt;
 new Vue(&#123;
 el: &#x27;#app&#x27;,
 data: &#123;
 isVisible: true
 &#125;
 &#125;);
 &lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

解释：当 `isVisible` 为 true 时，`&lt;p&gt;` 元素会被渲染；当 `isVisible` 为 false 时，该元素会从DOM中移除。

#### [](#v-else-if-指令)v-else-if 指令

**功能**：`v-else-if` 是 `v-if` 的延伸，用于添加多个条件。如果前面的 `v-if` 或 `v-else-if` 条件不满足，而当前条件满足时，该元素会被渲染。

> 

示例代码

&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
 &lt;title&gt;Vue v-else-if Example&lt;/title&gt;
 &lt;script src=&quot;https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
 &lt;div id=&quot;app&quot;&gt;
 &lt;p v-if=&quot;type === &#x27;A&#x27;&quot;&gt;Type A&lt;/p&gt;
 &lt;p v-else-if=&quot;type === &#x27;B&#x27;&quot;&gt;Type B&lt;/p&gt;
 &lt;p v-else-if=&quot;type === &#x27;C&#x27;&quot;&gt;Type C&lt;/p&gt;
 &lt;/div&gt;

 &lt;script&gt;
 new Vue(&#123;
 el: &#x27;#app&#x27;,
 data: &#123;
 type: &#x27;B&#x27;
 &#125;
 &#125;);
 &lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

解释：当 type 为 ‘B’ 时，`&lt;p&gt;` 元素显示 “Type B”；若 type 为 ‘A’ 或 ‘C’，则显示对应内容。

#### [](#v-else-指令)v-else 指令

**功能**：`v-else` 指令用于在前面的 `v-if` 和 `v-else-if` 条件都不满足时渲染元素。

> 

示例代码

&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
 &lt;title&gt;Vue v-else Example&lt;/title&gt;
 &lt;script src=&quot;https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
 &lt;div id=&quot;app&quot;&gt;
 &lt;p v-if=&quot;type === &#x27;A&#x27;&quot;&gt;Type A&lt;/p&gt;
 &lt;p v-else-if=&quot;type === &#x27;B&#x27;&quot;&gt;Type B&lt;/p&gt;
 &lt;p v-else&gt;Type C&lt;/p&gt;
 &lt;/div&gt;

 &lt;script&gt;
 new Vue(&#123;
 el: &#x27;#app&#x27;,
 data: &#123;
 type: &#x27;C&#x27;
 &#125;
 &#125;);
 &lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

解释：当 type 既不是 ‘A’ 也不是 ‘B’ 时，`&lt;p&gt;` 元素显示 “Type C”。

#### [](#v-show-指令)v-show 指令

**功能**：`v-show` 指令也用于条件渲染，但与 `v-if` 不同的是，`v-show` 仅控制元素的 display CSS 属性（显示或隐藏），**不会从DOM中移除元素**。

> 

示例代码

&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
 &lt;title&gt;Vue v-show Example&lt;/title&gt;
 &lt;script src=&quot;https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
 &lt;div id=&quot;app&quot;&gt;
 &lt;p v-show=&quot;isVisible&quot;&gt;This text is conditionally shown.&lt;/p&gt;
 &lt;/div&gt;

 &lt;script&gt;
 new Vue(&#123;
 el: &#x27;#app&#x27;,
 data: &#123;
 isVisible: true
 &#125;
 &#125;);
 &lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

解释：当 isVisible 为 true 时，`&lt;p&gt;` 元素显示；当 isVisible 为 false 时，`&lt;p&gt;` 元素隐藏（display: none;），但仍然保留在DOM中。

#### [](#v-if-vs-v-show)v-if vs v-show

`v-if`：适合在需要条件切换频率较低的场景中使用，因为它会在条件为 false 时移除元素，节省性能。

`v-show`：适合在需要频繁切换显示的场景中使用，因为它仅切换 display 属性，不涉及DOM元素的移除和重建，切换速度较快。

> 

使用`v-if`的时候，元素可能无法获取到，而使用`v-show`一定可以获取到

### [](#总结)总结

- `v-text` : 更新元素的 textContent

- `v-html` : 更新元素的 innerHTML

- `v-if` : 如果为true, 当前标签才会输出到页面

- `v-else`: 如果为false, 当前标签才会输出到页面

- `v-show` : 通过控制display样式来控制显示&#x2F;隐藏

- `v-for` : 遍历数组&#x2F;对象

- `v-on` : 绑定事件监听, 一般简写为@

- `v-bind` : 强制绑定解析表达式, 可以省略v-bind

- `v-model` : 双向数据绑定

- `ref` : 为某个元素注册一个唯一标识, vue对象通过$refs属性访问这个元素对象

- `v-cloak` : 使用它防止闪现表达式, 与css配合: [v-cloak] { display: none }

### [](#事件修饰符)事件修饰符

`.stop`：阻止事件冒泡。例如，`@click.stop`会阻止点击事件继续向上冒泡到父元素。

`.prevent`：阻止默认事件。例如，`@submit.prevent`会阻止表单的提交行为。

`.capture`：使用事件捕获模式而不是冒泡模式。默认情况下，事件是在冒泡阶段触发的，使用`.capture`修饰符可以改变为捕获阶段触发。

`.self`：只有当事件的目标是当前元素本身时才触发事件处理程序。如果事件冒泡到了目标元素的子元素，事件处理程序将不会被触发。

`.once`：事件只会触发一次，即使在同一个元素上多次触发该事件。

`.passive`：指示浏览器不应该阻止事件的默认行为。这对于滚动事件等性能敏感的事件非常有用。

---
title: 【Vue】基础系列（六）事件处理 - 绑定监听 - 事件修饰符 - 按键修饰符
date: 2024-08-26
categories:
  - Vue
tags:
  - Vue
  - 教程
---

## [](#事件处理)事件处理

在 Vue.js 中，事件处理是响应用户交互的核心功能之一。通过绑定事件监听器、使用事件修饰符和按键修饰符，可以轻松实现灵活的交互逻辑。

### [](#绑定监听)绑定监听

在 Vue 中，通过 v-on 指令或其缩写 @ 来绑定事件监听器。例如：

&lt;button @click=&quot;handleClick&quot;&gt;点击我&lt;/button&gt;

在这个例子中，当用户点击按钮时，会触发 handleClick 方法。

methods: &#123;
 handleClick() &#123;
 alert(&#x27;按钮被点击了&#x27;);
 &#125;
&#125;

#### [](#事件的基本使用：)事件的基本使用：

- 使用 `v-on:xxx` 或 `@xxx` 绑定事件，其中`xxx`是事件名；

例如：`v-on:click` 或 `@click`

- 事件的回调需要配置在`methods`对象中，最终会在`vm`上

- `methods`中配置的函数，不要用箭头函数！否则`this`就不是`vm`了

- `methods`中配置的函数，都是被`Vue`所管理的函数，`this`的指向是`vm` 或 组件实例对象；

- `@click=&quot;demo&quot;` 和 `@click=&quot;demo($event)&quot;` 效果一致，但后者可以传参；

事件对象 默认事件形参: `event` 隐含属性对象: `$event`

- `$event` 就是当前触发事件的元素，即使不传 `$event`，在回调函数中也可以使用 `event` 这个参数。

v-on:xxx=&quot;fun&quot;
@xxx=&quot;fun&quot;
@xxx=&quot;fun(参数)&quot;

> 

示例代码

&lt;body&gt;
 &lt;div id=&quot;demo&quot;&gt;
 &lt;h1&gt;1. 绑定监听&lt;/h1&gt;
 &lt;button @click=&quot;test1&quot;&gt;test1&lt;/button&gt;
 &lt;button @click=&quot;test2(&#x27;abc&#x27;)&quot;&gt;test2&lt;/button&gt;
 &lt;button @click=&quot;test3&quot;&gt;test3&lt;/button&gt;
 &lt;button @click=&quot;test4(123, $event)&quot;&gt;test4&lt;/button&gt;
 &lt;/div&gt;
 &lt;script src=&quot;https://cdn.bootcdn.net/ajax/libs/vue/2.6.12/vue.js&quot;&gt;&lt;/script&gt;

 &lt;script&gt;
 new Vue(&#123;
 el: &quot;#demo&quot;,
 data: &#123;&#125;,
 methods: &#123;
 test1() &#123;
 alert(&quot;hahah&quot;);
 &#125;,
 test2(msg) &#123;
 alert(msg);
 &#125;,
 test3(event) &#123;
 alert(event.target.innerHTML);
 &#125;,
 test4(number, event) &#123;
 alert(number + &#x27;---&#x27; + event.target.innerHTML);
 &#125;
 &#125;
 &#125;)
 &lt;/script&gt;
&lt;/body&gt;

![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2b7990465aa44db2bc3bf1330c856f0c~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

### [](#事件修饰符)事件修饰符

事件修饰符允许你修改事件处理程序的默认行为。这些修饰符包括 `.stop`, `.prevent`, `.capture`, `.self`, `.once` 等。

- `prevent`：阻止默认事件（常用）；`event.preventDefault()`

- `stop`：阻止事件冒泡（常用）；`event.stopPropagation()`

- `once`：事件只触发一次（常用）；

- `capture`：使用事件的捕获模式；

- `self`：只有`event.target`是当前操作的元素时才触发事件； 

- `passive`：事件的默认行为立即执行，无需等待事件回调执行完毕；

&lt;!DOCTYPE html&gt;
&lt;html&gt;
	&lt;head&gt;
		&lt;meta charset=&quot;UTF-8&quot; /&gt;
		&lt;title&gt;事件修饰符&lt;/title&gt;
		&lt;!-- 引入Vue --&gt;
		&lt;script type=&quot;text/javascript&quot; src=&quot;../js/vue.js&quot;&gt;&lt;/script&gt;
		&lt;style&gt;
			*&#123;
				margin-top: 20px;
			&#125;
			.demo1&#123;
				height: 50px;
				background-color: skyblue;
			&#125;
			.box1&#123;
				padding: 5px;
				background-color: skyblue;
			&#125;
			.box2&#123;
				padding: 5px;
				background-color: orange;
			&#125;
			.list&#123;
				width: 200px;
				height: 200px;
				background-color: peru;
				overflow: auto;
			&#125;
			li&#123;
				height: 100px;
			&#125;
		&lt;/style&gt;
	&lt;/head&gt;
	&lt;body&gt;
		&lt;!-- 
				Vue中的事件修饰符：
						1.prevent：阻止默认事件（常用）；
						2.stop：阻止事件冒泡（常用）；
						3.once：事件只触发一次（常用）；
						4.capture：使用事件的捕获模式；
						5.self：只有event.target是当前操作的元素时才触发事件；
						6.passive：事件的默认行为立即执行，无需等待事件回调执行完毕；
		--&gt;
		&lt;!-- 准备好一个容器--&gt;
		&lt;div id=&quot;root&quot;&gt;
			&lt;h2&gt;欢迎来到&#123;&#123;name&#125;&#125;学习&lt;/h2&gt;
			&lt;!-- 阻止默认事件（常用） --&gt;
			&lt;a href=&quot;http://www.baidu.com&quot; @click.prevent=&quot;showInfo&quot;&gt;点我提示信息&lt;/a&gt;

			&lt;!-- 阻止事件冒泡（常用） 这将阻止点击事件冒泡到父元素。--&gt;
			&lt;div class=&quot;demo1&quot; @click=&quot;showInfo&quot;&gt;
				&lt;button @click.stop=&quot;showInfo&quot;&gt;点我提示信息&lt;/button&gt;
				&lt;!-- 修饰符可以连续写 --&gt;
				&lt;!-- &lt;a href=&quot;http://www.atguigu.com&quot; @click.prevent.stop=&quot;showInfo&quot;&gt;点我提示信息&lt;/a&gt; --&gt;
			&lt;/div&gt;

			&lt;!-- 事件只触发一次（常用） --&gt;
			&lt;button @click.once=&quot;showInfo&quot;&gt;点我提示信息&lt;/button&gt;

			&lt;!-- 使用事件的捕获模式 --&gt;
			&lt;div class=&quot;box1&quot; @click.capture=&quot;showMsg(1)&quot;&gt;
				div1
				&lt;div class=&quot;box2&quot; @click=&quot;showMsg(2)&quot;&gt;
					div2
				&lt;/div&gt;
			&lt;/div&gt;

			&lt;!-- 只有event.target是当前操作的元素时才触发事件； --&gt;
			&lt;div class=&quot;demo1&quot; @click.self=&quot;showInfo&quot;&gt;
				&lt;button @click=&quot;showInfo&quot;&gt;点我提示信息&lt;/button&gt;
			&lt;/div&gt;

			&lt;!-- 事件的默认行为立即执行，无需等待事件回调执行完毕； --&gt;
			&lt;ul @wheel.passive=&quot;demo&quot; class=&quot;list&quot;&gt;
				&lt;li&gt;1&lt;/li&gt;
				&lt;li&gt;2&lt;/li&gt;
				&lt;li&gt;3&lt;/li&gt;
				&lt;li&gt;4&lt;/li&gt;
			&lt;/ul&gt;

		&lt;/div&gt;
	&lt;/body&gt;

	&lt;script type=&quot;text/javascript&quot;&gt;
		Vue.config.productionTip = false //阻止 vue 在启动时生成生产提示。

		new Vue(&#123;
			el:&#x27;#root&#x27;,
			data:&#123;
				name:&#x27;super&#x27;
			&#125;,
			methods:&#123;
				showInfo(e)&#123;
					alert(&#x27;同学你好！&#x27;)
					// console.log(e.target)
				&#125;,
				showMsg(msg)&#123;
					console.log(msg)
				&#125;,
				demo()&#123;
					for (let i = 0; i &lt; 100000; i++) &#123;
						console.log(&#x27;#&#x27;)
					&#125;
					console.log(&#x27;累坏了&#x27;)
				&#125;
			&#125;
		&#125;)
	&lt;/script&gt;
&lt;/html&gt;

### [](#按键修饰符)按键修饰符

Vue 提供了按键修饰符，用于监听键盘事件，并指定响应的按键。这些修饰符包括 `.enter`, `.tab`, `.delete`, `.esc`, `.space`, `.up`, `.down`, `.left`, `.right` 等。

#### [](#Vue中常用的按键别名：)Vue中常用的按键别名：

回车 =&gt; enter
删除 =&gt; delete (捕获“删除”和“退格”键)
退出 =&gt; esc
空格 =&gt; space
换行 =&gt; tab (特殊，必须配合keydown去使用)
上 =&gt; up
下 =&gt; down
左 =&gt; left
右 =&gt; right

Vue未提供别名的按键，可以使用按键原始的key值去绑定，但注意要转为kebab-case（短横线命名）

系统修饰键（用法特殊）：`ctrl`、`alt`、`shift`、`meta`

- 配合`keyup`使用：按下修饰键的同时，再按下其他键，随后释放其他键，事件才被触发。

- 配合`keydown`使用：正常触发事件。

也可以使用keyCode去指定具体的按键（不推荐）

`Vue.config.keyCodes.自定义键名 = 键码`，可以去定制按键别名

&lt;!-- 任何按键按下都会触发回调函数 --&gt;
&lt;textarea @keyup=&quot;testKeyup&quot;&gt;&lt;/textarea&gt;

&lt;!-- 下面的两种写法效果是一致的 --&gt;
&lt;!-- 使用按键码，回车键的keyCode是13 --&gt;
&lt;textarea @keyup.13=&quot;testKeyup&quot;&gt;&lt;/textarea&gt;

&lt;!-- 使用按键修饰符，因为回车键比较常用，所以vue为他设置了名称，可以直接使用enter来代替 --&gt;
&lt;textarea @keyup.enter=&quot;testKeyup&quot;&gt;&lt;/textarea&gt;

> 

示例代码

&lt;body&gt;
 &lt;div id=&quot;demo&quot;&gt;
 &lt;h1&gt;3. 按键修饰符&lt;/h1&gt;
 &lt;input type=&quot;text&quot; @keyup.13=&quot;test8&quot;&gt;
 &lt;input type=&quot;text&quot; @keyup.enter=&quot;test8&quot;&gt;
 &lt;/div&gt;

 &lt;script src=&quot;https://cdn.bootcdn.net/ajax/libs/vue/2.6.12/vue.js&quot;&gt;&lt;/script&gt;

 &lt;script&gt;
 new Vue(&#123;
 el: &quot;#demo&quot;,
 data: &#123;&#125;,
 methods: &#123;
 test8(event) &#123;
 // if(event.keyCode===13)&#123; // 原来的做法
 // alert(event.target.value);
 // &#125;
 alert(event.target.value);
 &#125;
 &#125;
 &#125;)
 &lt;/script&gt;
&lt;/body&gt;

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/74c3c96ab4264998b56a57a76720ceef~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

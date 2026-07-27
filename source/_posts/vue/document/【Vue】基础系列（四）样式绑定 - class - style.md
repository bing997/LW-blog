---
title: 【Vue】基础系列（四）样式绑定 - class - style
date: 2024-08-26
categories:
  - Vue
tags:
  - Vue
  - 教程
---

## [](#样式绑定)样式绑定

在应用界面中, 某个(些)元素的样式是变化的，class&#x2F;style 绑定就是专门用来实现动态样式效果的技术

### [](#class-绑定)class 绑定

:class=&#x27;xxx&#x27; // xxx可以是字符串、对象、数组。

#### [](#字符串)字符串

表达式是字符串: `&#39;classA&#39;`

> 

适用于：类名不确定，要动态获取

&lt;!DOCTYPE html&gt;
&lt;html&gt;

&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot; /&gt;
 &lt;title&gt;绑定样式&lt;/title&gt;
 &lt;style&gt;
 .basic &#123;
 width: 400px;
 height: 100px;
 border: 1px solid black;
 &#125;

 .happy &#123;
 border: 4px solid red;
 ;
 background-color: rgba(255, 255, 0, 0.644);
 background: linear-gradient(30deg, yellow, pink, orange, yellow);
 &#125;

 .sad &#123;
 border: 4px dashed rgb(2, 197, 2);
 background-color: gray;
 &#125;

 .normal &#123;
 background-color: skyblue;
 &#125;

 &lt;/style&gt;
 &lt;script src=&quot;https://cdn.bootcdn.net/ajax/libs/vue/2.6.12/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;

&lt;body&gt;

 &lt;!-- 准备好一个容器--&gt;
 &lt;div id=&quot;root&quot;&gt;
 &lt;!-- 绑定class样式--字符串写法，适用于：样式的类名不确定，需要动态指定 --&gt;
 &lt;div class=&quot;basic&quot; :class=&quot;mood&quot; @click=&quot;changeMood&quot;&gt;&#123;&#123;name&#125;&#125;&lt;/div&gt;
 &lt;/div&gt;
&lt;/body&gt;

&lt;script type=&quot;text/javascript&quot;&gt;
 Vue.config.productionTip = false

 const vm = new Vue(&#123;
 el: &#x27;#root&#x27;,
 data: &#123;
 name: &#x27;YK菌&#x27;,
 mood: &#x27;normal&#x27;
 &#125;,
 methods: &#123;
 changeMood() &#123;
 const arr = [&#x27;happy&#x27;, &#x27;sad&#x27;, &#x27;normal&#x27;]
 const index = Math.floor(Math.random() * 3)
 this.mood = arr[index]
 &#125;
 &#125;,
 &#125;)
&lt;/script&gt;

&lt;/html&gt;

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4eee1a78fed3496881944df62afe04ee~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

#### [](#对象)对象

表达式是对象: `&#123;classA:isA, classB: isB&#125;`

> 

适用于：要绑定多个样式，个数不确定，名字也不确定

对象语法用于根据条件添加或移除类名。**对象的键是类名，值是布尔值**，布尔值为 true 时应用该类名，为 false 时移除该类名。

&lt;div v-bind:class=&quot;&#123; active: isActive, &#x27;text-danger&#x27;: hasError &#125;&quot;&gt;&lt;/div&gt;

> 

在上面的例子中，如果 `isActive` 为 true，`active` 类将被添加到 div 中。同样，如果 `hasError` 为 true，`text-danger` 类将被添加。

&lt;!DOCTYPE html&gt;
&lt;html&gt;

&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot; /&gt;
 &lt;title&gt;绑定样式&lt;/title&gt;
 &lt;style&gt;
 .basic &#123;
 width: 400px;
 height: 100px;
 border: 1px solid black;
 &#125;

 .yk1 &#123;
 background-color: yellowgreen;
 &#125;

 .yk2 &#123;
 font-size: 30px;
 text-shadow: 2px 2px 10px red;
 &#125;

 .yk3 &#123;
 border-radius: 20px;
 &#125;
 &lt;/style&gt;
 &lt;script src=&quot;https://cdn.bootcdn.net/ajax/libs/vue/2.6.12/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;

&lt;body&gt;

 &lt;!-- 准备好一个容器--&gt;
 &lt;div id=&quot;root&quot;&gt;
 &lt;!-- 绑定class样式--数组写法，适用于：要绑定的样式个数不确定、名字也不确定 --&gt;
 &lt;div class=&quot;basic&quot; :class=&quot;classArr&quot;&gt;&#123;&#123;name&#125;&#125;&lt;/div&gt; &lt;br /&gt;&lt;br /&gt;
 &lt;/div&gt;
&lt;/body&gt;

&lt;script type=&quot;text/javascript&quot;&gt;
 Vue.config.productionTip = false

 const vm = new Vue(&#123;
 el: &#x27;#root&#x27;,
 data: &#123;
 name: &#x27;YK菌&#x27;,
 classArr: [&#x27;yk1&#x27;, &#x27;yk2&#x27;, &#x27;yk3&#x27;]
 &#125;,
 &#125;)
&lt;/script&gt;

&lt;/html&gt;

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/238e4af4135a497abf87f2a97e585a9a~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

#### [](#数组)数组

表达式是数组: `[&#39;classA&#39;, &#39;classB&#39;]`

> 

适用于：要绑定多个样式，个数确定，名字也确定，但不确定用不用

&lt;!DOCTYPE html&gt;
&lt;html&gt;

&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot; /&gt;
 &lt;title&gt;绑定样式&lt;/title&gt;
 &lt;style&gt;
 .basic &#123;
 width: 400px;
 height: 100px;
 border: 1px solid black;
 &#125;

 .yk1 &#123;
 background-color: yellowgreen;
 &#125;

 .yk2 &#123;
 font-size: 30px;
 text-shadow: 2px 2px 10px red;
 &#125;

 .yk3 &#123;
 border-radius: 20px;
 &#125;
 &lt;/style&gt;
 &lt;script src=&quot;https://cdn.bootcdn.net/ajax/libs/vue/2.6.12/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;

&lt;body&gt;

 &lt;!-- 准备好一个容器--&gt;
 &lt;div id=&quot;root&quot;&gt;
 &lt;!-- 绑定class样式--对象写法，适用于：要绑定的样式个数确定、名字也确定，但要动态决定用不用 --&gt;
 &lt;div class=&quot;basic&quot; :class=&quot;classObj&quot;&gt;&#123;&#123;name&#125;&#125;&lt;/div&gt;
 &lt;/div&gt;
&lt;/body&gt;

&lt;script type=&quot;text/javascript&quot;&gt;
 Vue.config.productionTip = false

 const vm = new Vue(&#123;
 el: &#x27;#root&#x27;,
 data: &#123;
 name: &#x27;YK菌&#x27;,
 classObj: &#123;
 yk1: true,
 yk2: false,
 yk3: true
 &#125;
 &#125;
 &#125;)
&lt;/script&gt;

&lt;/html&gt;

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/46d37ebc7911496bae1830d76ac93250~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

### [](#style-绑定)style 绑定

:style=&quot;&#123; color: activeColor, fontSize: fontSize + &#x27;px&#x27; &#125;&quot;

> 

其中 `activeColor`&#x2F;`fontSize` 是 data 属性

:style=&quot;&#123;fontSize: xxx&#125;&quot;其中xxx是动态值。
:style=&quot;[a,b]&quot;其中a、b是样式对象。

#### [](#对象-1)对象

&lt;!DOCTYPE html&gt;
&lt;html&gt;

&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot; /&gt;
 &lt;title&gt;绑定样式&lt;/title&gt;
 &lt;style&gt;
 .basic &#123;
 width: 400px;
 height: 100px;
 border: 1px solid black;
 &#125;
 &lt;/style&gt;
 &lt;script src=&quot;https://cdn.bootcdn.net/ajax/libs/vue/2.6.12/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;

&lt;body&gt;

 &lt;!-- 准备好一个容器--&gt;
 &lt;div id=&quot;root&quot;&gt;

 &lt;!-- 绑定style样式--对象写法 --&gt;
 &lt;div class=&quot;basic&quot; :style=&quot;styleObj, styleObj2&quot;&gt;&#123;&#123;name&#125;&#125;&lt;/div&gt;

 &lt;/div&gt;
&lt;/body&gt;

&lt;script type=&quot;text/javascript&quot;&gt;
 Vue.config.productionTip = false

 const vm = new Vue(&#123;
 el: &#x27;#root&#x27;,
 data: &#123;
 name: &#x27;YK菌&#x27;,
 styleObj: &#123;
 fontSize: &#x27;40px&#x27;,
 color: &#x27;red&#x27;,
 &#125;,
 styleObj2: &#123;
 backgroundColor: &#x27;orange&#x27;
 &#125;,
 &#125;,
 &#125;)
&lt;/script&gt;

&lt;/html&gt;

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1790eb8f0f2d424d85a9b9f2c2e3a6b8~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

#### [](#数组-1)数组

&lt;!DOCTYPE html&gt;
&lt;html&gt;

&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot; /&gt;
 &lt;title&gt;绑定样式&lt;/title&gt;
 &lt;style&gt;
 .basic &#123;
 width: 400px;
 height: 100px;
 border: 1px solid black;
 &#125;
 &lt;/style&gt;
 &lt;script src=&quot;https://cdn.bootcdn.net/ajax/libs/vue/2.6.12/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;

&lt;body&gt;

 &lt;!-- 准备好一个容器--&gt;
 &lt;div id=&quot;root&quot;&gt;

 &lt;!-- 绑定style样式--数组写法 --&gt;
 &lt;div class=&quot;basic&quot; :style=&quot;styleArr&quot;&gt;&#123;&#123;name&#125;&#125;&lt;/div&gt;

 &lt;/div&gt;
&lt;/body&gt;

&lt;script type=&quot;text/javascript&quot;&gt;
 Vue.config.productionTip = false

 const vm = new Vue(&#123;
 el: &#x27;#root&#x27;,
 data: &#123;
 name: &#x27;YK菌&#x27;,
 styleArr: [&#123;
 fontSize: &#x27;40px&#x27;,
 color: &#x27;blue&#x27;,
 &#125;,
 &#123;
 backgroundColor: &#x27;gray&#x27;
 &#125;
 ]
 &#125;,
 &#125;)
&lt;/script&gt;

&lt;/html&gt;

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/7cafcd03c94f4f8b95956e9d935c68c5~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

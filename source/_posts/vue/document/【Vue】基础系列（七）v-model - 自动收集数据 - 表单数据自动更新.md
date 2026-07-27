---
title: 【Vue】基础系列（七）v-model - 自动收集数据 - 表单数据自动更新
date: 2024-08-26
categories:
  - Vue
tags:
  - Vue
  - 教程
---

## [](#v-model-收集数据)v-model 收集数据

`v-model` 是 Vue.js 提供的一个非常强大的双向数据绑定指令，主要用于表单控件中，实现数据的自动收集和同步更新。它在处理表单输入时极大地简化了开发过程。

### [](#使用v-model-双向数据绑定-自动收集数据)使用v-model(双向数据绑定)自动收集数据

`v-model` 可以用于各种表单元素，如 `&lt;input&gt;`, `&lt;textarea&gt;`, `&lt;select&gt;`，并且会根据元素类型自动选用合适的绑定方式。

- v-model的三个修饰符

`lazy`：失去焦点再收集数据

- `number`：输入字符串转为有效的数字

- `trim`：输入首尾空格过滤

#### [](#text)text

&lt;input type=&quot;text&quot; v-model=&quot;message&quot;&gt;

new Vue(&#123;
 el: &#x27;#app&#x27;,
 data: &#123;
 message: &#x27;&#x27;
 &#125;
&#125;);

> 

当用户在输入框中输入内容时，`message` 数据会自动更新。

> 

示例代码

&lt;!DOCTYPE html&gt;
&lt;html&gt;

&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot; /&gt;
 &lt;title&gt;收集表单数据&lt;/title&gt;
 &lt;script src=&quot;https://cdn.bootcdn.net/ajax/libs/vue/2.6.12/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;

&lt;body&gt;
 &lt;!-- 
 收集表单数据：
 若：&lt;input type=&quot;text&quot;/&gt;，则v-model收集的是value值，用户输入的就是value值。
 --&gt;
 &lt;!-- 准备好一个容器--&gt;
 &lt;div id=&quot;root&quot;&gt;
 &lt;form @submit.prevent=&quot;demo&quot;&gt;
 账号：&lt;input type=&quot;text&quot; v-model.trim=&quot;userInfo.account&quot;&gt; &lt;br /&gt;&lt;br /&gt;
 密码：&lt;input type=&quot;password&quot; v-model=&quot;userInfo.password&quot;&gt; &lt;br /&gt;&lt;br /&gt;
 年龄：&lt;input type=&quot;number&quot; v-model.number=&quot;userInfo.age&quot;&gt; &lt;br /&gt;&lt;br /&gt;
 &lt;button&gt;提交&lt;/button&gt;
 &lt;/form&gt;
 &lt;/div&gt;
&lt;/body&gt;

&lt;script type=&quot;text/javascript&quot;&gt;
 Vue.config.productionTip = false

 new Vue(&#123;
 el: &#x27;#root&#x27;,
 data: &#123;
 userInfo: &#123;
 account: &#x27;&#x27;,
 password: &#x27;&#x27;,
 age: 18
 &#125;
 &#125;
 &#125;)
&lt;/script&gt;

&lt;/html&gt;

![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e0d54330c7674aaebb740bf3a8bb6510~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

#### [](#textarea)textarea

&lt;textarea v-model=&quot;message&quot;&gt;&lt;/textarea&gt;

> 

`v-model` 也适用于 `&lt;textarea&gt;`，效果与 `&lt;input&gt;` 类似。

#### [](#radio)radio

`&lt;input type=&quot;radio&quot;/&gt;`，则v-model收集的是value值，且要给标签配置value值。

&lt;input type=&quot;radio&quot; v-model=&quot;picked&quot; value=&quot;Option 1&quot;&gt;
&lt;input type=&quot;radio&quot; v-model=&quot;picked&quot; value=&quot;Option 2&quot;&gt;
&lt;p&gt;选中的选项: &#123;&#123; picked &#125;&#125;&lt;/p&gt;

> 

当用户选择不同的选项时，picked 会自动更新为对应的 value 值。

> 

示例代码

&lt;!DOCTYPE html&gt;
&lt;html&gt;

&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot; /&gt;
 &lt;title&gt;收集表单数据&lt;/title&gt;
 &lt;script src=&quot;https://cdn.bootcdn.net/ajax/libs/vue/2.6.12/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;

&lt;body&gt;
 &lt;!-- 
 收集表单数据：
 若：&lt;input type=&quot;radio&quot;/&gt;，则v-model收集的是value值，且要给标签配置value值。

 --&gt;
 &lt;!-- 准备好一个容器--&gt;
 &lt;div id=&quot;root&quot;&gt;
 &lt;form @submit.prevent=&quot;demo&quot;&gt;
 账号：&lt;input type=&quot;text&quot; v-model.trim=&quot;userInfo.account&quot;&gt; &lt;br /&gt;&lt;br /&gt;
 密码：&lt;input type=&quot;password&quot; v-model=&quot;userInfo.password&quot;&gt; &lt;br /&gt;&lt;br /&gt;
 年龄：&lt;input type=&quot;number&quot; v-model.number=&quot;userInfo.age&quot;&gt; &lt;br /&gt;&lt;br /&gt;
 性别：
 男&lt;input type=&quot;radio&quot; name=&quot;sex&quot; v-model=&quot;userInfo.sex&quot; value=&quot;male&quot;&gt;
 女&lt;input type=&quot;radio&quot; name=&quot;sex&quot; v-model=&quot;userInfo.sex&quot; value=&quot;female&quot;&gt; &lt;br /&gt;&lt;br /&gt;
 &lt;button&gt;提交&lt;/button&gt;
 &lt;/form&gt;
 &lt;/div&gt;
&lt;/body&gt;

&lt;script type=&quot;text/javascript&quot;&gt;
 Vue.config.productionTip = false

 new Vue(&#123;
 el: &#x27;#root&#x27;,
 data: &#123;
 userInfo: &#123;
 account: &#x27;&#x27;,
 password: &#x27;&#x27;,
 age: 18,
 sex: &#x27;female&#x27;
 &#125;
 &#125;
 &#125;)
&lt;/script&gt;

&lt;/html&gt;

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a3380a04284a4310a0a98e2a7ec3c167~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

#### [](#checkbox)checkbox

`&lt;input type=&quot;checkbox&quot;/&gt;`

&lt;input type=&quot;checkbox&quot; v-model=&quot;isChecked&quot;&gt;
&lt;p&gt;复选框状态: &#123;&#123; isChecked &#125;&#125;&lt;/p&gt;

> 

`isChecked` 会根据复选框的勾选状态自动更新为 `true` 或 `false`。

&lt;input type=&quot;checkbox&quot; v-model=&quot;checkedNames&quot; value=&quot;Jack&quot;&gt;
&lt;input type=&quot;checkbox&quot; v-model=&quot;checkedNames&quot; value=&quot;John&quot;&gt;
&lt;input type=&quot;checkbox&quot; v-model=&quot;checkedNames&quot; value=&quot;Mike&quot;&gt;
&lt;p&gt;选中的名字: &#123;&#123; checkedNames &#125;&#125;&lt;/p&gt;

> 

`checkedNames` 是一个数组，包含所有被选中的选项。

没有配置`input`的`value`属性，那么收集的就是`checked`（勾选 or 未勾选，是布尔值）

配置`input`的`value`属性:

- `v-model`的初始值是非数组，那么收集的就是`checked`（勾选 or 未勾选，是布尔值）

- `v-model`的初始值是数组，那么收集的的就是`value`组成的数组！！！

> 

示例代码

&lt;!DOCTYPE html&gt;
&lt;html&gt;

&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot; /&gt;
 &lt;title&gt;收集表单数据&lt;/title&gt;
 &lt;script src=&quot;https://cdn.bootcdn.net/ajax/libs/vue/2.6.12/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;

&lt;body&gt;
 &lt;!-- 
 收集表单数据：
 若：&lt;input type=&quot;text&quot;/&gt;，则v-model收集的是value值，用户输入的就是value值。
 若：&lt;input type=&quot;radio&quot;/&gt;，则v-model收集的是value值，且要给标签配置value值。
 若：&lt;input type=&quot;checkbox&quot;/&gt;
 1.没有配置input的value属性，那么收集的就是checked（勾选 or 未勾选，是布尔值）
 2.配置input的value属性:
 (1)v-model的初始值是非数组，那么收集的就是checked（勾选 or 未勾选，是布尔值）
 (2)v-model的初始值是数组，那么收集的的就是value组成的数组
 备注：v-model的三个修饰符：
 lazy：失去焦点再收集数据
 number：输入字符串转为有效的数字
 trim：输入首尾空格过滤
 --&gt;
 &lt;!-- 准备好一个容器--&gt;
 &lt;div id=&quot;root&quot;&gt;
 &lt;form @submit.prevent=&quot;demo&quot;&gt;
 账号：&lt;input type=&quot;text&quot; v-model.trim=&quot;userInfo.account&quot;&gt; &lt;br /&gt;&lt;br /&gt;
 密码：&lt;input type=&quot;password&quot; v-model=&quot;userInfo.password&quot;&gt; &lt;br /&gt;&lt;br /&gt;
 年龄：&lt;input type=&quot;number&quot; v-model.number=&quot;userInfo.age&quot;&gt; &lt;br /&gt;&lt;br /&gt;
 性别：
 男&lt;input type=&quot;radio&quot; name=&quot;sex&quot; v-model=&quot;userInfo.sex&quot; value=&quot;male&quot;&gt;
 女&lt;input type=&quot;radio&quot; name=&quot;sex&quot; v-model=&quot;userInfo.sex&quot; value=&quot;female&quot;&gt; &lt;br /&gt;&lt;br /&gt;
 爱好：
 学习&lt;input type=&quot;checkbox&quot; v-model=&quot;userInfo.hobby&quot; value=&quot;study&quot;&gt;
 打游戏&lt;input type=&quot;checkbox&quot; v-model=&quot;userInfo.hobby&quot; value=&quot;game&quot;&gt;
 吃饭&lt;input type=&quot;checkbox&quot; v-model=&quot;userInfo.hobby&quot; value=&quot;eat&quot;&gt;
 &lt;br /&gt;&lt;br /&gt;
 所属校区
 &lt;select v-model=&quot;userInfo.city&quot;&gt;
 &lt;option value=&quot;&quot;&gt;请选择校区&lt;/option&gt;
 &lt;option value=&quot;beijing&quot;&gt;北京&lt;/option&gt;
 &lt;option value=&quot;shanghai&quot;&gt;上海&lt;/option&gt;
 &lt;option value=&quot;shenzhen&quot;&gt;深圳&lt;/option&gt;
 &lt;option value=&quot;wuhan&quot;&gt;武汉&lt;/option&gt;
 &lt;/select&gt;
 &lt;br /&gt;&lt;br /&gt;
 其他信息：
 &lt;textarea v-model.lazy=&quot;userInfo.other&quot;&gt;&lt;/textarea&gt; &lt;br /&gt;&lt;br /&gt;
 &lt;input type=&quot;checkbox&quot; v-model=&quot;userInfo.agree&quot;&gt;阅读并接受&lt;a href=&quot;http://www.atguigu.com&quot;&gt;《用户协议》&lt;/a&gt;
 &lt;button&gt;提交&lt;/button&gt;
 &lt;/form&gt;
 &lt;/div&gt;
&lt;/body&gt;

&lt;script type=&quot;text/javascript&quot;&gt;
 Vue.config.productionTip = false

 new Vue(&#123;
 el: &#x27;#root&#x27;,
 data: &#123;
 userInfo: &#123;
 account: &#x27;&#x27;,
 password: &#x27;&#x27;,
 age: 18,
 sex: &#x27;female&#x27;,
 hobby: [],
 city: &#x27;beijing&#x27;,
 other: &#x27;&#x27;,
 agree: &#x27;&#x27;
 &#125;
 &#125;,
 methods: &#123;
 demo() &#123;
 console.log(JSON.stringify(this.userInfo))
 &#125;
 &#125;
 &#125;)
&lt;/script&gt;

&lt;/html&gt;

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/87d52db0789345b7889646226a69c1da~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

### [](#v-model-的原理与自动收集数据)v-model 的原理与自动收集数据

`v-model` 实现了表单控件的双向数据绑定，这意味着数据的改变会自动反映在视图上，用户的输入也会自动更新到数据中。

#### [](#双向绑定的工作原理)双向绑定的工作原理:

- **绑定输入事件**：当用户输入内容时，`v-model` 会监听 `input`, `change`, `blur` 等事件，并将最新的值更新到 `Vue` 实例的 `data` 中。

- **视图更新**：当 `data` 中的值发生变化时，`Vue` 的响应式系统会自动更新视图中的值，使之与数据保持同步。

#### [](#表单数据的自动更新)表单数据的自动更新

通过 `v-model`，Vue 可以自动处理表单元素的数据绑定，使得表单数据与应用数据模型保持一致。

组合使用 v-model:

在复杂表单中，你可以为每个输入元素使用 `v-model` 来绑定数据，从而简化数据收集和表单提交的过程。

&lt;div id=&quot;app&quot;&gt;
 &lt;form @submit.prevent=&quot;submitForm&quot;&gt;
 &lt;label for=&quot;name&quot;&gt;名字:&lt;/label&gt;
 &lt;input type=&quot;text&quot; v-model=&quot;formData.name&quot; id=&quot;name&quot;&gt;

 &lt;label for=&quot;age&quot;&gt;年龄:&lt;/label&gt;
 &lt;input type=&quot;number&quot; v-model=&quot;formData.age&quot; id=&quot;age&quot;&gt;

 &lt;label for=&quot;gender&quot;&gt;性别:&lt;/label&gt;
 &lt;select v-model=&quot;formData.gender&quot; id=&quot;gender&quot;&gt;
 &lt;option value=&quot;male&quot;&gt;男&lt;/option&gt;
 &lt;option value=&quot;female&quot;&gt;女&lt;/option&gt;
 &lt;/select&gt;

 &lt;button type=&quot;submit&quot;&gt;提交&lt;/button&gt;
 &lt;/form&gt;

 &lt;p&gt;提交的数据: &#123;&#123; formData &#125;&#125;&lt;/p&gt;
&lt;/div&gt;

&lt;script&gt;
 new Vue(&#123;
 el: &#x27;#app&#x27;,
 data: &#123;
 formData: &#123;
 name: &#x27;&#x27;,
 age: null,
 gender: &#x27;&#x27;
 &#125;
 &#125;,
 methods: &#123;
 submitForm() &#123;
 console.log(this.formData);
 alert(&#x27;表单已提交&#x27;);
 &#125;
 &#125;
 &#125;);
&lt;/script&gt;

> 

在这个例子中，`formData` 中的每个字段都与表单输入元素绑定，表单数据会自动收集，并在提交时打印到控制台。

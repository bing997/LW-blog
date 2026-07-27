---
title: 【Vue】基础系列（三）计算属性与监视属性
date: 2024-08-23
categories:
  - Vue
tags:
  - Vue
  - 教程
---

### [](#数据代理)数据代理

在Vue.js中，**数据代理是Vue实现响应式数据的核心机制之一**。它通过使用JavaScript的**Object.defineProperty**（在Vue 3中则是Proxy）来拦截对对象属性的访问和修改，从而实现数据和视图的双向绑定。这使得开发者可以更方便地使用简洁的语法来访问和操作数据，而Vue会自动更新相应的视图。

#### [](#数据代理的概念)数据代理的概念

数据代理的核心是将**组件的data对象中的属性代理到Vue实例上**。这意味着你可以通过`this.propertyName`直接访问和修改data中的属性，而Vue会自动更新视图。

#### [](#数据代理的实现原理)数据代理的实现原理

在Vue 2中，数据代理是通过`Object.defineProperty`实现的。Vue在实例化时，会遍历data对象中的所有属性，并为每个属性设置`getter`和`setter`。当你访问或修改这些属性时，Vue会自动触发相应的DOM更新。

#### [](#数据代理的使用)数据代理的使用

> 

示例代码

&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
 &lt;title&gt;Vue Data Proxy Example&lt;/title&gt;
 &lt;script src=&quot;https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
 &lt;div id=&quot;app&quot;&gt;
 &lt;p&gt;Message: &#123;&#123; message &#125;&#125;&lt;/p&gt;
 &lt;input v-model=&quot;message&quot; placeholder=&quot;Edit message&quot;&gt;
 &lt;/div&gt;

 &lt;script&gt;
 new Vue(&#123;
 el: &#x27;#app&#x27;,
 data: &#123;
 message: &#x27;Hello Vue!&#x27;
 &#125;
 &#125;);
 &lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;

> 

解释：在这个示例中，`message` 是定义在 data 对象中的属性。通过Vue的数据代理机制，你可以直接通过 `&#123;&#123; message &#125;&#125;` 访问它，或者通过 `v-model` 绑定到输入框上进行修改。
Vue会自动代理data中的`message`属性，使得你可以通过`this.message`来访问它，并在视图中使用`&#123;&#123; message &#125;&#125;`绑定进行显示。

#### [](#数据代理的工作流程)数据代理的工作流程

当你在模板中引用`&#123;&#123; message &#125;&#125;`时，Vue实际上是访问了`this.message`，并通过数据代理机制去data对象中获取对应的值。

当你在输入框中输入新内容时，`v-model`指令会触发`message`属性的`setter`，Vue捕捉到这个变化后，会重新渲染与message相关的部分视图。

#### [](#数据代理的好处)数据代理的好处

- 简洁性：你可以通过简洁的语法（例如this.message）直接访问数据，而不需要每次都通过`data`对象。

- 响应性：数据代理使得数据与视图之间的双向绑定更加直观和简单，Vue会自动处理数据变化引起的视图更新。

- 可维护性：通过数据代理，你可以将数据与视图的逻辑清晰地分离，代码更易于维护和理解。

## [](#计算属性与监视属性)计算属性与监视属性

在Vue.js中，计算属性（computed properties）和监视属性（watchers）是两种常用的**响应式特性**，用于在**数据发生变化时自动更新页面的内容**。它们虽然在功能上有相似之处，但适用于不同的场景。

### [](#计算属性（Computed-Properties）)计算属性（Computed Properties）

#### [](#功能)功能

**计算属性**是基于已存在的响应式数据计算出一个新值的属性。它会根据依赖的数据自动更新，并且有缓存机制，只有当依赖的数据发生变化时才会重新计算。

计算属性适合用于**基于其他数据动态计算出新值**的场景，比如对数据进行格式化、合并、筛选等操作。

#### [](#特点)特点

**缓存**：计算属性的结果会被缓存，直到它的依赖发生变化。这使得它在性能上比直接在模板中使用复杂表达式更优。

**简洁**：计算属性通常以`getter`和`setter`形式定义，`getter`用于获取计算值，`setter`用于响应用户的输入或其他操作。

> 

插值语法示例代码

&lt;!DOCTYPE html&gt;
&lt;html&gt;
	&lt;head&gt;
		&lt;meta charset=&quot;UTF-8&quot; /&gt;
		&lt;title&gt;姓名案例_插值语法实现&lt;/title&gt;
		&lt;!-- 引入Vue --&gt;
		&lt;script type=&quot;text/javascript&quot; src=&quot;../js/vue.js&quot;&gt;&lt;/script&gt;
	&lt;/head&gt;
	&lt;body&gt;
		&lt;!-- 准备好一个容器--&gt;
		&lt;div id=&quot;root&quot;&gt;
			姓：&lt;input type=&quot;text&quot; v-model=&quot;firstName&quot;&gt; &lt;br/&gt;&lt;br/&gt;
			名：&lt;input type=&quot;text&quot; v-model=&quot;lastName&quot;&gt; &lt;br/&gt;&lt;br/&gt;
			全名：&lt;span&gt;&#123;&#123;firstName&#125;&#125;-&#123;&#123;lastName&#125;&#125;&lt;/span&gt;
		&lt;/div&gt;
	&lt;/body&gt;

	&lt;script type=&quot;text/javascript&quot;&gt;
		Vue.config.productionTip = false //阻止 vue 在启动时生成生产提示。
		new Vue(&#123;
			el:&#x27;#root&#x27;,
			data:&#123;
				firstName:&#x27;张&#x27;,
				lastName:&#x27;三&#x27;
			&#125;
		&#125;)
	&lt;/script&gt;
&lt;/html&gt;

> 

methods实现示例代码

&lt;!DOCTYPE html&gt;
&lt;html&gt;
	&lt;head&gt;
		&lt;meta charset=&quot;UTF-8&quot; /&gt;
		&lt;title&gt;姓名案例_methods实现&lt;/title&gt;
		&lt;!-- 引入Vue --&gt;
		&lt;script type=&quot;text/javascript&quot; src=&quot;../js/vue.js&quot;&gt;&lt;/script&gt;
	&lt;/head&gt;
	&lt;body&gt;
		&lt;!-- 准备好一个容器--&gt;
		&lt;div id=&quot;root&quot;&gt;
			姓：&lt;input type=&quot;text&quot; v-model=&quot;firstName&quot;&gt; &lt;br/&gt;&lt;br/&gt;
			名：&lt;input type=&quot;text&quot; v-model=&quot;lastName&quot;&gt; &lt;br/&gt;&lt;br/&gt;
			全名：&lt;span&gt;&#123;&#123;fullName()&#125;&#125;&lt;/span&gt;
		&lt;/div&gt;
	&lt;/body&gt;

	&lt;script type=&quot;text/javascript&quot;&gt;
		Vue.config.productionTip = false //阻止 vue 在启动时生成生产提示。
		new Vue(&#123;
			el:&#x27;#root&#x27;,
			data:&#123;
				firstName:&#x27;张&#x27;,
				lastName:&#x27;三&#x27;
			&#125;,
			methods: &#123;
				fullName()&#123;
					console.log(&#x27;@---fullName&#x27;)
					return this.firstName + &#x27;-&#x27; + this.lastName
				&#125;
			&#125;,
		&#125;)
	&lt;/script&gt;
&lt;/html&gt;

> 

计算属性实现示例代码

&lt;!DOCTYPE html&gt;
&lt;html&gt;
	&lt;head&gt;
		&lt;meta charset=&quot;UTF-8&quot; /&gt;
		&lt;title&gt;姓名案例_计算属性实现&lt;/title&gt;
		&lt;!-- 引入Vue --&gt;
		&lt;script type=&quot;text/javascript&quot; src=&quot;../js/vue.js&quot;&gt;&lt;/script&gt;
	&lt;/head&gt;
	&lt;body&gt;
		&lt;!-- 准备好一个容器--&gt;
		&lt;div id=&quot;root&quot;&gt;
			姓：&lt;input type=&quot;text&quot; v-model=&quot;firstName&quot;&gt; &lt;br/&gt;&lt;br/&gt;
			名：&lt;input type=&quot;text&quot; v-model=&quot;lastName&quot;&gt; &lt;br/&gt;&lt;br/&gt;
			测试：&lt;input type=&quot;text&quot; v-model=&quot;x&quot;&gt; &lt;br/&gt;&lt;br/&gt;
			全名：&lt;span&gt;&#123;&#123;fullName&#125;&#125;&lt;/span&gt; &lt;br/&gt;&lt;br/&gt;
			&lt;!-- 全名：&lt;span&gt;&#123;&#123;fullName&#125;&#125;&lt;/span&gt; &lt;br/&gt;&lt;br/&gt;
			全名：&lt;span&gt;&#123;&#123;fullName&#125;&#125;&lt;/span&gt; &lt;br/&gt;&lt;br/&gt;
			全名：&lt;span&gt;&#123;&#123;fullName&#125;&#125;&lt;/span&gt; --&gt;
		&lt;/div&gt;
	&lt;/body&gt;

	&lt;script type=&quot;text/javascript&quot;&gt;
		Vue.config.productionTip = false //阻止 vue 在启动时生成生产提示。
		const vm = new Vue(&#123;
			el:&#x27;#root&#x27;,
			data:&#123;
				firstName:&#x27;张&#x27;,
				lastName:&#x27;三&#x27;,
				x:&#x27;你好&#x27;
			&#125;,
			methods: &#123;
				demo()&#123;
					
				&#125;
			&#125;,
			computed:&#123;
				fullName:&#123;
					//get有什么作用？当有人读取fullName时，get就会被调用，且返回值就作为fullName的值
					//get什么时候调用？1.初次读取fullName时。2.所依赖的数据发生变化时。
					get()&#123;
						console.log(&#x27;get被调用了&#x27;)
						// console.log(this) //此处的this是vm
						return this.firstName + &#x27;-&#x27; + this.lastName
					&#125;,
					//set什么时候调用? 当fullName被修改时。
					set(value)&#123;
						console.log(&#x27;set&#x27;,value)
						const arr = value.split(&#x27;-&#x27;)
						this.firstName = arr[0]
						this.lastName = arr[1]
					&#125;
				&#125;
			&#125;
		&#125;)
	&lt;/script&gt;
&lt;/html&gt;

> 

解释：fullName 是一个计算属性，它通过 firstName 和 lastName 动态计算得出。如果用户输入一个新的全名，它也会自动更新 firstName 和 lastName。

> 

计算属性实现简写

&lt;!DOCTYPE html&gt;
&lt;html&gt;
	&lt;head&gt;
		&lt;meta charset=&quot;UTF-8&quot; /&gt;
		&lt;title&gt;姓名案例_计算属性实现&lt;/title&gt;
		&lt;!-- 引入Vue --&gt;
		&lt;script type=&quot;text/javascript&quot; src=&quot;../js/vue.js&quot;&gt;&lt;/script&gt;
	&lt;/head&gt;
	&lt;body&gt;
		&lt;!-- 准备好一个容器--&gt;
		&lt;div id=&quot;root&quot;&gt;
			姓：&lt;input type=&quot;text&quot; v-model=&quot;firstName&quot;&gt; &lt;br/&gt;&lt;br/&gt;
			名：&lt;input type=&quot;text&quot; v-model=&quot;lastName&quot;&gt; &lt;br/&gt;&lt;br/&gt;
			全名：&lt;span&gt;&#123;&#123;fullName&#125;&#125;&lt;/span&gt; &lt;br/&gt;&lt;br/&gt;
		&lt;/div&gt;
	&lt;/body&gt;

	&lt;script type=&quot;text/javascript&quot;&gt;
		Vue.config.productionTip = false //阻止 vue 在启动时生成生产提示。

		const vm = new Vue(&#123;
			el:&#x27;#root&#x27;,
			data:&#123;
				firstName:&#x27;张&#x27;,
				lastName:&#x27;三&#x27;,
			&#125;,
			computed:&#123;
				//完整写法
				/* fullName:&#123;
					get()&#123;
						console.log(&#x27;get被调用了&#x27;)
						return this.firstName + &#x27;-&#x27; + this.lastName
					&#125;,
					set(value)&#123;
						console.log(&#x27;set&#x27;,value)
						const arr = value.split(&#x27;-&#x27;)
						this.firstName = arr[0]
						this.lastName = arr[1]
					&#125;
				&#125; */
				//简写
				fullName()&#123;
					console.log(&#x27;get被调用了&#x27;)
					return this.firstName + &#x27;-&#x27; + this.lastName
				&#125;
			&#125;
		&#125;)
	&lt;/script&gt;
&lt;/html&gt;

#### [](#原理)原理

底层借助了`Objcet.defineproperty`方法提供的`getter`和`setter`。

#### [](#get函数什么时候执行？)get函数什么时候执行？

- 初次读取时会执行一次。

- 当依赖的数据发生改变时会被再次调用。

#### [](#优势)优势

与methods实现相比，内部有**缓存机制（复用）**，效率更高，调试方便。

> 

计算属性最终会出现在vm上，直接读取使用即可。
 如果计算属性要被修改，那必须写`set`函数去响应修改，且`set`中要引起计算时依赖的数据发生改变。

### [](#监视属性（Watchers）)监视属性（Watchers）

#### [](#功能-1)功能

监视属性用于**监听某个数据属性的变化**，并在其变化时执行回调函数。适合用于执行异步操作或在数据变化时需要执行复杂逻辑的场景。

#### [](#特点-1)特点

**灵活性**：可以监听单个数据属性的变化，也可以监听多个数据属性，甚至可以使用深度监听（deep）来监控对象内部的变化。

**无缓存**：与计算属性不同，监视属性没有缓存机制，每次数据变化都会触发回调。

#### [](#语法：)语法：

- new Vue时传入watch配置

- 通过vm.$watch监视

> 

天气案例示例代码(计算属性)

&lt;!DOCTYPE html&gt;
&lt;html&gt;
	&lt;head&gt;
		&lt;meta charset=&quot;UTF-8&quot; /&gt;
		&lt;title&gt;天气案例&lt;/title&gt;
		&lt;!-- 引入Vue --&gt;
		&lt;script type=&quot;text/javascript&quot; src=&quot;../js/vue.js&quot;&gt;&lt;/script&gt;
	&lt;/head&gt;
	&lt;body&gt;
		&lt;!-- 准备好一个容器--&gt;
		&lt;div id=&quot;root&quot;&gt;
			&lt;h2&gt;今天天气很&#123;&#123;info&#125;&#125;&lt;/h2&gt;
			&lt;!-- 绑定事件的时候：@xxx=&quot;yyy&quot; yyy可以写一些简单的语句 --&gt;
			&lt;!-- &lt;button @click=&quot;isHot = !isHot&quot;&gt;切换天气&lt;/button&gt; --&gt;
			&lt;button @click=&quot;changeWeather&quot;&gt;切换天气&lt;/button&gt;
		&lt;/div&gt;
	&lt;/body&gt;

	&lt;script type=&quot;text/javascript&quot;&gt;
		Vue.config.productionTip = false //阻止 vue 在启动时生成生产提示。
		
		const vm = new Vue(&#123;
			el:&#x27;#root&#x27;,
			data:&#123;
				isHot:true,
			&#125;,
			computed:&#123;
				info()&#123;
					return this.isHot ? &#x27;炎热&#x27; : &#x27;凉爽&#x27;
				&#125;
			&#125;,
			methods: &#123;
				changeWeather()&#123;
					this.isHot = !this.isHot
				&#125;
			&#125;,
		&#125;)
	&lt;/script&gt;
&lt;/html&gt;

> 

天气案例示例代码(监视属性)

&lt;!DOCTYPE html&gt;
&lt;html&gt;
	&lt;head&gt;
		&lt;meta charset=&quot;UTF-8&quot; /&gt;
		&lt;title&gt;天气案例_监视属性&lt;/title&gt;
		&lt;!-- 引入Vue --&gt;
		&lt;script type=&quot;text/javascript&quot; src=&quot;../js/vue.js&quot;&gt;&lt;/script&gt;
	&lt;/head&gt;
	&lt;body&gt;
		&lt;!-- 
				监视属性watch：
					1.当被监视的属性变化时, 回调函数自动调用, 进行相关操作
					2.监视的属性必须存在，才能进行监视！！
					3.监视的两种写法：
							(1).new Vue时传入watch配置
							(2).通过vm.$watch监视
		 --&gt;
		&lt;!-- 准备好一个容器--&gt;
		&lt;div id=&quot;root&quot;&gt;
			&lt;h2&gt;今天天气很&#123;&#123;info&#125;&#125;&lt;/h2&gt;
			&lt;button @click=&quot;changeWeather&quot;&gt;切换天气&lt;/button&gt;
		&lt;/div&gt;
	&lt;/body&gt;

	&lt;script type=&quot;text/javascript&quot;&gt;
		Vue.config.productionTip = false //阻止 vue 在启动时生成生产提示。
		
		const vm = new Vue(&#123;
			el:&#x27;#root&#x27;,
			data:&#123;
				isHot:true,
			&#125;,
			computed:&#123;
				info()&#123;
					return this.isHot ? &#x27;炎热&#x27; : &#x27;凉爽&#x27;
				&#125;
			&#125;,
			methods: &#123;
				changeWeather()&#123;
					this.isHot = !this.isHot
				&#125;
			&#125;,
			/* watch:&#123;
				isHot:&#123;
					immediate:true, //初始化时让handler调用一下
					//handler什么时候调用？当isHot发生改变时。
					handler(newValue,oldValue)&#123;
						console.log(&#x27;isHot被修改了&#x27;,newValue,oldValue)
					&#125;
				&#125;
			&#125; */
		&#125;)

		vm.$watch(&#x27;isHot&#x27;,&#123;
			immediate:true, //初始化时让handler调用一下
			//handler什么时候调用？当isHot发生改变时。
			handler(newValue,oldValue)&#123;
				console.log(&#x27;isHot被修改了&#x27;,newValue,oldValue)
			&#125;
		&#125;)
	&lt;/script&gt;
&lt;/html&gt;

#### [](#深度监视)深度监视

- Vue中的watch默认不监测对象内部值的改变（一层）。

- 配置deep:true可以监测对象内部值改变（多层）。

> 

备注：(1).Vue自身可以监测对象内部值的改变，但Vue提供的watch默认不可以！(2).使用watch时根据数据的具体结构，决定是否采用深度监视。

&lt;!DOCTYPE html&gt;
&lt;html&gt;
	&lt;head&gt;
		&lt;meta charset=&quot;UTF-8&quot; /&gt;
		&lt;title&gt;天气案例_深度监视&lt;/title&gt;
		&lt;!-- 引入Vue --&gt;
		&lt;script type=&quot;text/javascript&quot; src=&quot;../js/vue.js&quot;&gt;&lt;/script&gt;
	&lt;/head&gt;
	&lt;body&gt;
		&lt;!-- 准备好一个容器--&gt;
		&lt;div id=&quot;root&quot;&gt;
			&lt;h2&gt;今天天气很&#123;&#123;info&#125;&#125;&lt;/h2&gt;
			&lt;button @click=&quot;changeWeather&quot;&gt;切换天气&lt;/button&gt;
			&lt;hr/&gt;
			&lt;h3&gt;a的值是:&#123;&#123;numbers.a&#125;&#125;&lt;/h3&gt;
			&lt;button @click=&quot;numbers.a++&quot;&gt;点我让a+1&lt;/button&gt;
			&lt;h3&gt;b的值是:&#123;&#123;numbers.b&#125;&#125;&lt;/h3&gt;
			&lt;button @click=&quot;numbers.b++&quot;&gt;点我让b+1&lt;/button&gt;
			&lt;button @click=&quot;numbers = &#123;a:666,b:888&#125;&quot;&gt;彻底替换掉numbers&lt;/button&gt;
			&#123;&#123;numbers.c.d.e&#125;&#125;
		&lt;/div&gt;
	&lt;/body&gt;

	&lt;script type=&quot;text/javascript&quot;&gt;
		Vue.config.productionTip = false //阻止 vue 在启动时生成生产提示。
		
		const vm = new Vue(&#123;
			el:&#x27;#root&#x27;,
			data:&#123;
				isHot:true,
				numbers:&#123;
					a:1,
					b:1,
					c:&#123;
						d:&#123;
							e:100
						&#125;
					&#125;
				&#125;
			&#125;,
			computed:&#123;
				info()&#123;
					return this.isHot ? &#x27;炎热&#x27; : &#x27;凉爽&#x27;
				&#125;
			&#125;,
			methods: &#123;
				changeWeather()&#123;
					this.isHot = !this.isHot
				&#125;
			&#125;,
			watch:&#123;
				isHot:&#123;
					// immediate:true, //初始化时让handler调用一下
					//handler什么时候调用？当isHot发生改变时。
					handler(newValue,oldValue)&#123;
						console.log(&#x27;isHot被修改了&#x27;,newValue,oldValue)
					&#125;
				&#125;,
				//监视多级结构中某个属性的变化
				/* &#x27;numbers.a&#x27;:&#123;
					handler()&#123;
						console.log(&#x27;a被改变了&#x27;)
					&#125;
				&#125; */
				//监视多级结构中所有属性的变化
				numbers:&#123;
					deep:true,
					handler()&#123;
						console.log(&#x27;numbers改变了&#x27;)
					&#125;
				&#125;
			&#125;
		&#125;)

	&lt;/script&gt;
&lt;/html&gt;

#### [](#监视属性简写)监视属性简写

&lt;!DOCTYPE html&gt;
&lt;html&gt;
	&lt;head&gt;
		&lt;meta charset=&quot;UTF-8&quot; /&gt;
		&lt;title&gt;天气案例_监视属性_简写&lt;/title&gt;
		&lt;!-- 引入Vue --&gt;
		&lt;script type=&quot;text/javascript&quot; src=&quot;../js/vue.js&quot;&gt;&lt;/script&gt;
	&lt;/head&gt;
	&lt;body&gt;
		&lt;!-- 准备好一个容器--&gt;
		&lt;div id=&quot;root&quot;&gt;
			&lt;h2&gt;今天天气很&#123;&#123;info&#125;&#125;&lt;/h2&gt;
			&lt;button @click=&quot;changeWeather&quot;&gt;切换天气&lt;/button&gt;
		&lt;/div&gt;
	&lt;/body&gt;

	&lt;script type=&quot;text/javascript&quot;&gt;
		Vue.config.productionTip = false //阻止 vue 在启动时生成生产提示。
		
		const vm = new Vue(&#123;
			el:&#x27;#root&#x27;,
			data:&#123;
				isHot:true,
			&#125;,
			computed:&#123;
				info()&#123;
					return this.isHot ? &#x27;炎热&#x27; : &#x27;凉爽&#x27;
				&#125;
			&#125;,
			methods: &#123;
				changeWeather()&#123;
					this.isHot = !this.isHot
				&#125;
			&#125;,
			watch:&#123;
				//正常写法
				/* isHot:&#123;
					// immediate:true, //初始化时让handler调用一下
					// deep:true,//深度监视
					handler(newValue,oldValue)&#123;
						console.log(&#x27;isHot被修改了&#x27;,newValue,oldValue)
					&#125;
				&#125;, */
				//简写
				/* isHot(newValue,oldValue)&#123;
					console.log(&#x27;isHot被修改了&#x27;,newValue,oldValue,this)
				&#125; */
			&#125;
		&#125;)

		//正常写法
		/* vm.$watch(&#x27;isHot&#x27;,&#123;
			immediate:true, //初始化时让handler调用一下
			deep:true,//深度监视
			handler(newValue,oldValue)&#123;
				console.log(&#x27;isHot被修改了&#x27;,newValue,oldValue)
			&#125;
		&#125;) */

		//简写
		/* vm.$watch(&#x27;isHot&#x27;,(newValue,oldValue)=&gt;&#123;
			console.log(&#x27;isHot被修改了&#x27;,newValue,oldValue,this)
		&#125;) */

	&lt;/script&gt;
&lt;/html&gt;

### [](#计算属性-vs-监视属性)计算属性 vs 监视属性

1.computed能完成的功能，watch都可以完成。

2.watch能完成的功能，computed不一定能完成，例如：watch可以进行异步操作。

两个重要的小原则：

- 所被Vue管理的函数，最好写成普通函数，这样this的指向才是vm 或 组件实例对象

- 所有不被Vue所管理的函数（定时器的回调函数、ajax的回调函数等、Promise的回调函数），最好写成箭头函数，这样this的指向才是vm 或 组件实例对象

> 

计算属性变量在computed中定义，监视属性监听的是已经在 data 中定义的变量, 当该变量变化时，会触发 watch 中的方法.

> 

computed 具有缓存功能，可以监听对象某个具体属性。watch可以进行深度监听，监听对象的变化

> 

计算属性是声明式的描述一个值依赖了其他值，依赖的值改变后重新计算结果更新DOM。监视属性的是定义的变量，当定义的值发生变化时，执行相对应的函数

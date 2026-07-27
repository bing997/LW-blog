---
title: 【Vue】基础系列（五）列表渲染v-for、key的原理、删除替换、过滤与排序
date: 2024-08-26
categories:
  - Vue
tags:
  - Vue
  - 教程
---

## [](#列表渲染)列表渲染

在 Vue.js 中，列表渲染是一个常用的功能，通常通过 `v-for` 指令来实现

### [](#列表显示)列表显示

`v-for` 指令用于遍历数组或对象，并生成一组相应的 DOM 元素。例如：

&lt;ul&gt;
 &lt;li v-for=&quot;item in items&quot; :key=&quot;item.id&quot;&gt;&#123;&#123; item.name &#125;&#125;&lt;/li&gt;
&lt;/ul&gt;

> 

在这个例子中，`v-for` 遍历 `items` 数组，每个 `item` 的内容被插入到 li 元素中。每个列表项提供一个唯一的key属性，key应该是独一无二的，比如一个字符串或数字类型的ID

v-for 指令

- 用于展示列表数据

- 语法：`v-for=&quot;(item, index) in xxx&quot; :key=&quot;yyy&quot;`

- 可遍历：数组、对象、字符串（用的很少）、指定次数（用的很少）

数组: `(item, index)`

- 对象: `(value, key)`

- 字符串：`(char, index)`

- 数字：`(number, index)`

&lt;!DOCTYPE html&gt;
&lt;html&gt;
	&lt;head&gt;
		&lt;meta charset=&quot;UTF-8&quot; /&gt;
		&lt;title&gt;基本列表&lt;/title&gt;
		&lt;script type=&quot;text/javascript&quot; src=&quot;../js/vue.js&quot;&gt;&lt;/script&gt;
	&lt;/head&gt;
	&lt;body&gt;
		&lt;!-- 准备好一个容器--&gt;
		&lt;div id=&quot;root&quot;&gt;
			&lt;!-- 遍历数组 --&gt;
			&lt;h2&gt;人员列表（遍历数组）&lt;/h2&gt;
			&lt;ul&gt;
				&lt;li v-for=&quot;(p,index) of persons&quot; :key=&quot;index&quot;&gt;
					&#123;&#123;p.name&#125;&#125;-&#123;&#123;p.age&#125;&#125;
				&lt;/li&gt;
			&lt;/ul&gt;

			&lt;!-- 遍历对象 --&gt;
			&lt;h2&gt;汽车信息（遍历对象）&lt;/h2&gt;
			&lt;ul&gt;
				&lt;li v-for=&quot;(value,k) of car&quot; :key=&quot;k&quot;&gt;
					&#123;&#123;k&#125;&#125;-&#123;&#123;value&#125;&#125;
				&lt;/li&gt;
			&lt;/ul&gt;

			&lt;!-- 遍历字符串 --&gt;
			&lt;h2&gt;测试遍历字符串（用得少）&lt;/h2&gt;
			&lt;ul&gt;
				&lt;li v-for=&quot;(char,index) of str&quot; :key=&quot;index&quot;&gt;
					&#123;&#123;char&#125;&#125;-&#123;&#123;index&#125;&#125;
				&lt;/li&gt;
			&lt;/ul&gt;
			
			&lt;!-- 遍历指定次数 --&gt;
			&lt;h2&gt;测试遍历指定次数（用得少）&lt;/h2&gt;
			&lt;ul&gt;
				&lt;li v-for=&quot;(number,index) of 5&quot; :key=&quot;index&quot;&gt;
					&#123;&#123;index&#125;&#125;-&#123;&#123;number&#125;&#125;
				&lt;/li&gt;
			&lt;/ul&gt;
		&lt;/div&gt;

		&lt;script type=&quot;text/javascript&quot;&gt;
			Vue.config.productionTip = false
			
			new Vue(&#123;
				el:&#x27;#root&#x27;,
				data:&#123;
					persons:[
						&#123;id:&#x27;001&#x27;,name:&#x27;张三&#x27;,age:18&#125;,
						&#123;id:&#x27;002&#x27;,name:&#x27;李四&#x27;,age:19&#125;,
						&#123;id:&#x27;003&#x27;,name:&#x27;王五&#x27;,age:20&#125;
					],
					car:&#123;
						name:&#x27;奥迪A8&#x27;,
						price:&#x27;70万&#x27;,
						color:&#x27;黑色&#x27;
					&#125;,
					str:&#x27;hello&#x27;
				&#125;
			&#125;)
		&lt;/script&gt;
&lt;/html&gt;

### [](#key的原理)key的原理

#### [](#虚拟DOM中key的作用：)虚拟DOM中key的作用：

> 

key是虚拟DOM对象的标识，当数据发生变化时，Vue会根据【新数据】生成【新的虚拟DOM】, 随后Vue进行【新虚拟DOM】与【旧虚拟DOM】的差异比较，比较规则如下：

#### [](#对比规则：)对比规则：

- 旧虚拟DOM中找到了与新虚拟DOM相同的`key`：

若虚拟DOM中内容没变, 直接使用之前的真实DOM

- 若虚拟DOM中内容变了, 则生成新的真实DOM，随后替换掉页面中之前的真实DOM

- 旧虚拟DOM中未找到与新虚拟DOM相同的`key`创建新的真实DOM，随后渲染到到页面。

#### [](#用index作为key可能会引发的问题：)用`index`作为`key`可能会引发的问题：

- 若对数据进行：逆序添加、逆序删除等破坏顺序操作: 会产生没有必要的真实DOM更新 &#x3D;&#x3D;&gt; 界面效果没问题, 但效率低

- 如果结构中还包含输入类的DOM： 会产生错误DOM更新 &#x3D;&#x3D;&gt; 界面有问题

#### [](#开发中如何选择key)开发中如何选择`key`:

- 最好使用每条数据的唯一标识作为`key`, 比如id、手机号、身份证号、学号等唯一值。

- 如果不存在对数据的逆序添加、逆序删除等破坏顺序操作，仅用于渲染列表用于展示，使用`index`作为`key`是没有问题的。

### [](#Vue监视数据的原理)Vue监视数据的原理

vue会监视data中所有层次的数据。

如何监测对象中的数据？

> 

通过setter实现监视，且要在new Vue时就传入要监测的数据。

- 对象中后追加的属性，Vue默认不做响应式处理

- 如需给后添加的属性做响应式，请使用如下API：`Vue.set(target，propertyName/index，value)` 或 `vm.$set(target，propertyName/index，value)`

如何监测数组中的数据？ 通过包裹数组更新元素的方法实现，本质就是做了两件事：
+　调用原生对应的方法对数组进行更新。

- 重新解析模板，进而更新页面。

在Vue修改数组中的某个元素一定要用如下方法：

- 使用这些API: `push()`、`pop()`、`shift()`、`unshift()`、`splice()`、`sort()`、`reverse()`

- `Vue.set()` 或 `vm.$set()`

> 

特别注意：`Vue.set()` 和 `vm.$set()` 不能给 `vm` 或 `vm` 的根数据对象 添加属性！！！

&lt;!DOCTYPE html&gt;
&lt;html&gt;

&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot; /&gt;
 &lt;title&gt;总结数据监视&lt;/title&gt;
 &lt;style&gt;
 button &#123;
 margin-top: 10px;
 &#125;
 &lt;/style&gt;
 &lt;!-- 引入Vue --&gt;
 &lt;script type=&quot;text/javascript&quot; src=&quot;../js/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;

&lt;body&gt;
 &lt;!--

 --&gt;
 &lt;!-- 准备好一个容器--&gt;
 &lt;div id=&quot;root&quot;&gt;
 &lt;h1&gt;学生信息&lt;/h1&gt;
 &lt;button @click=&quot;student.age++&quot;&gt;年龄+1岁&lt;/button&gt; &lt;br /&gt;
 &lt;button @click=&quot;addSex&quot;&gt;添加性别属性，默认值：男&lt;/button&gt; &lt;br /&gt;
 &lt;button @click=&quot;student.sex = &#x27;未知&#x27; &quot;&gt;修改性别&lt;/button&gt; &lt;br /&gt;
 &lt;button @click=&quot;addFriend&quot;&gt;在列表首位添加一个朋友&lt;/button&gt; &lt;br /&gt;
 &lt;button @click=&quot;updateFirstFriendName&quot;&gt;修改第一个朋友的名字为：张三&lt;/button&gt; &lt;br /&gt;
 &lt;button @click=&quot;addHobby&quot;&gt;添加一个爱好&lt;/button&gt; &lt;br /&gt;
 &lt;button @click=&quot;updateHobby&quot;&gt;修改第一个爱好为：开车&lt;/button&gt; &lt;br /&gt;
 &lt;button @click=&quot;removeSmoke&quot;&gt;过滤掉爱好中的抽烟&lt;/button&gt; &lt;br /&gt;
 &lt;h3&gt;姓名：&#123;&#123;student.name&#125;&#125;&lt;/h3&gt;
 &lt;h3&gt;年龄：&#123;&#123;student.age&#125;&#125;&lt;/h3&gt;
 &lt;h3 v-if=&quot;student.sex&quot;&gt;性别：&#123;&#123;student.sex&#125;&#125;&lt;/h3&gt;
 &lt;h3&gt;爱好：&lt;/h3&gt;
 &lt;ul&gt;
 &lt;li v-for=&quot;(h,index) in student.hobby&quot; :key=&quot;index&quot;&gt;
 &#123;&#123;h&#125;&#125;
 &lt;/li&gt;
 &lt;/ul&gt;
 &lt;h3&gt;朋友们：&lt;/h3&gt;
 &lt;ul&gt;
 &lt;li v-for=&quot;(f,index) in student.friends&quot; :key=&quot;index&quot;&gt;
 &#123;&#123;f.name&#125;&#125;--&#123;&#123;f.age&#125;&#125;
 &lt;/li&gt;
 &lt;/ul&gt;
 &lt;/div&gt;
&lt;/body&gt;

&lt;script type=&quot;text/javascript&quot;&gt;
 Vue.config.productionTip = false //阻止 vue 在启动时生成生产提示。

 const vm = new Vue(&#123;
 el: &#x27;#root&#x27;,
 data: &#123;
 student: &#123;
 name: &#x27;tom&#x27;,
 age: 18,
 hobby: [&#x27;抽烟&#x27;, &#x27;喝酒&#x27;, &#x27;烫头&#x27;],
 friends: [&#123;
 name: &#x27;jerry&#x27;,
 age: 35
 &#125;,
 &#123;
 name: &#x27;tony&#x27;,
 age: 36
 &#125;
 ]
 &#125;
 &#125;,
 methods: &#123;
 addSex() &#123;
 // Vue.set(this.student,&#x27;sex&#x27;,&#x27;男&#x27;)
 this.$set(this.student, &#x27;sex&#x27;, &#x27;男&#x27;)
 &#125;,
 addFriend() &#123;
 this.student.friends.unshift(&#123;
 name: &#x27;jack&#x27;,
 age: 70
 &#125;)
 &#125;,
 updateFirstFriendName() &#123;
 this.student.friends[0].name = &#x27;张三&#x27;
 &#125;,
 addHobby() &#123;
 this.student.hobby.push(&#x27;学习&#x27;)
 &#125;,
 updateHobby() &#123;
 // this.student.hobby.splice(0,1,&#x27;开车&#x27;)
 // Vue.set(this.student.hobby,0,&#x27;开车&#x27;)
 this.$set(this.student.hobby, 0, &#x27;开车&#x27;)
 &#125;,
 removeSmoke() &#123;
 this.student.hobby = this.student.hobby.filter((h) =&gt; &#123;
 return h !== &#x27;抽烟&#x27;
 &#125;)
 &#125;
 &#125;
 &#125;)
&lt;/script&gt;

&lt;/html&gt;

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c58c0e8fc9ac407c9126b171d7362ca4~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

### [](#数组更新检测)数组更新检测

Vue 重写了数组中的一系列改变数组内部数据的方法（先调用原生，再更新界面）

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b00184c5443b4f8d981fb822d80066d3~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

this.persons[index] = newP;
//并没有改变persons本身，数组内部发生了变化，但是没有调用变异方法，vue不会更新界面

也可以替换item

相比之下，也有非变更方法，例如 `filter()`、`concat()` 和 `slice()`。它们不会变更原始数组，而总是返回一个新数组。当使用非变更方法时，可以用新数组替换旧数组。

let fpersons = persons.filter(
 p =&gt; p.name.includes(searchName)
)

&lt;body&gt;
 &lt;div id=&quot;demo&quot;&gt;
 &lt;h2&gt;测试：v-for遍历数组&lt;/h2&gt;
 &lt;ul&gt;
 &lt;li v-for=&quot;(p, index) in persons&quot; :key=&quot;index&quot;&gt;
 &#123;&#123;index&#125;&#125;---&#123;&#123;p.name&#125;&#125;---&#123;&#123;p.age&#125;&#125;
 &lt;button @click=&quot;deleteP(index)&quot;&gt;删除&lt;/button&gt;
 &lt;button @click=&quot;updateP(index, &#123;name:&#x27;Cat&#x27;, age: 20&#125;)&quot;&gt;更新&lt;/button&gt;
 &lt;/li&gt;
 &lt;/ul&gt;

 &lt;h2&gt;测试：v-for遍历对象&lt;/h2&gt;
 &lt;ul&gt;
 &lt;li v-for=&quot;(value, key) in persons[1]&quot; :key=&quot;key&quot;&gt;
 &#123;&#123;value&#125;&#125;---&#123;&#123;key&#125;&#125;
 &lt;/li&gt;
 &lt;/ul&gt;

 &lt;/div&gt;

 &lt;script src=&quot;../js/vue.js&quot;&gt;&lt;/script&gt;
 &lt;script&gt;
 // Vue本身只是监视了persons的改变，没有监视数组内部数据的改变
 // Vue 重写了数组中的一系列改变数组内部数据的方法（先调用原生，再更新界面）
 new Vue(&#123;
 el: &#x27;#demo&#x27;,
 data: &#123;
 persons: [&#123;
 name: &#x27;Tom&#x27;,
 age: 18
 &#125;,
 &#123;
 name: &#x27;Jack&#x27;,
 age: 19
 &#125;,
 &#123;
 name: &#x27;Marry&#x27;,
 age: 16
 &#125;,
 &#123;
 name: &#x27;Rose&#x27;,
 age: 12
 &#125;,
 ]
 &#125;,
 methods: &#123;
 deleteP(index) &#123;
 // 删除persons中指定idnex的p（有数据绑定）
 this.persons.splice(index, 1);
 &#125;,
 updateP(index, newP) &#123;
 // this.persons[index] = newP; //数据（数组内部）变了，界面没有变化（没有数据绑定）
 //并没有改变persons本身，数组内部发生了变化，但是没有调用变异方法，vue不会更新界面
 // this.persons = [] //界面有变化，改变了persons
 this.persons.splice(index, 1, newP);
 &#125;
 &#125;
 &#125;)
 &lt;/script&gt;
&lt;/body&gt;

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2547c14f20d84f8ab5124403c8dda069~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

### [](#过滤与排序)过滤与排序

过滤操作

可以使用watch也可以使用计算属性，使用计算属性更加简单方便一点

&lt;!DOCTYPE html&gt;
&lt;html&gt;

&lt;head&gt;
 &lt;meta charset=&quot;UTF-8&quot; /&gt;
 &lt;title&gt;列表过滤&lt;/title&gt;
 &lt;script type=&quot;text/javascript&quot; src=&quot;../js/vue.js&quot;&gt;&lt;/script&gt;
&lt;/head&gt;

&lt;body&gt;
 &lt;!-- 准备好一个容器--&gt;
 &lt;div id=&quot;root&quot;&gt;
 &lt;h2&gt;人员列表&lt;/h2&gt;
 &lt;input type=&quot;text&quot; placeholder=&quot;请输入名字&quot; v-model=&quot;keyWord&quot;&gt;
 &lt;ul&gt;
 &lt;li v-for=&quot;(p,index) of filPerons&quot; :key=&quot;index&quot;&gt;
 &#123;&#123;p.name&#125;&#125;-&#123;&#123;p.age&#125;&#125;-&#123;&#123;p.sex&#125;&#125;
 &lt;/li&gt;
 &lt;/ul&gt;
 &lt;/div&gt;

 &lt;script type=&quot;text/javascript&quot;&gt;
 Vue.config.productionTip = false

 //用watch实现
 //#region 
 /* new Vue(&#123;
 el:&#x27;#root&#x27;,
 data:&#123;
 keyWord:&#x27;&#x27;,
 persons:[
 &#123;id:&#x27;001&#x27;,name:&#x27;马冬梅&#x27;,age:19,sex:&#x27;女&#x27;&#125;,
 &#123;id:&#x27;002&#x27;,name:&#x27;周冬雨&#x27;,age:20,sex:&#x27;女&#x27;&#125;,
 &#123;id:&#x27;003&#x27;,name:&#x27;周杰伦&#x27;,age:21,sex:&#x27;男&#x27;&#125;,
 &#123;id:&#x27;004&#x27;,name:&#x27;温兆伦&#x27;,age:22,sex:&#x27;男&#x27;&#125;
 ],
 filPerons:[]
 &#125;,
 watch:&#123;
 keyWord:&#123;
 immediate:true,
 handler(val)&#123;
 this.filPerons = this.persons.filter((p)=&gt;&#123;
 return p.name.indexOf(val) !== -1
 &#125;)
 &#125;
 &#125;
 &#125;
 &#125;) */
 //#endregion

 //用computed实现
 new Vue(&#123;
 el: &#x27;#root&#x27;,
 data: &#123;
 keyWord: &#x27;&#x27;,
 persons: [&#123;
 id: &#x27;001&#x27;,
 name: &#x27;马冬梅&#x27;,
 age: 19,
 sex: &#x27;女&#x27;
 &#125;,
 &#123;
 id: &#x27;002&#x27;,
 name: &#x27;周冬雨&#x27;,
 age: 20,
 sex: &#x27;女&#x27;
 &#125;,
 &#123;
 id: &#x27;003&#x27;,
 name: &#x27;周杰伦&#x27;,
 age: 21,
 sex: &#x27;男&#x27;
 &#125;,
 &#123;
 id: &#x27;004&#x27;,
 name: &#x27;温兆伦&#x27;,
 age: 22,
 sex: &#x27;男&#x27;
 &#125;
 ]
 &#125;,
 computed: &#123;
 filPerons() &#123;
 return this.persons.filter((p) =&gt; &#123;
 return p.name.indexOf(this.keyWord) !== -1
 &#125;)
 &#125;
 &#125;
 &#125;)
 &lt;/script&gt;

&lt;/html&gt;

排序操作

computed:&#123;
 filPerons()&#123;
 const arr = this.persons.filter((p)=&gt;&#123;
 return p.name.indexOf(this.keyWord) !== -1
 &#125;)
 //判断一下是否需要排序
 if(this.sortType)&#123;
 arr.sort((p1,p2)=&gt;&#123;
 return this.sortType === 1 ? p2.age-p1.age : p1.age-p2.age
 &#125;)
 &#125;
 return arr
 &#125;
&#125;

> 

例子

&lt;body&gt;
 &lt;div id=&quot;test&quot;&gt;
 &lt;input type=&quot;text&quot; v-model=&quot;searchName&quot;&gt;
 &lt;ul&gt;
 &lt;li v-for=&quot;(p, index) in filterPersons&quot; :key=&quot;index&quot;&gt;
 &#123;&#123;index&#125;&#125;---&#123;&#123;p.name&#125;&#125;---&#123;&#123;p.age&#125;&#125;
 &lt;/li&gt;
 &lt;/ul&gt;
 &lt;button @click=&quot;setOrderType(1)&quot;&gt;年龄升序&lt;/button&gt;
 &lt;button @click=&quot;setOrderType(2)&quot;&gt;年龄降序&lt;/button&gt;
 &lt;button @click=&quot;setOrderType(0)&quot;&gt;还原顺序&lt;/button&gt;
 &lt;/div&gt;

 &lt;script src=&quot;../js/vue.js&quot;&gt;&lt;/script&gt;

 &lt;script&gt;
 new Vue(&#123;
 el: &#x27;#test&#x27;,
 data: &#123;
 searchName: &#x27;&#x27;,
 orderType: 0, //0代表原本， 1代表升序， 2代表降序
 persons: [&#123;
 name: &#x27;Tom&#x27;,
 age: 10
 &#125;,
 &#123;
 name: &#x27;Jack&#x27;,
 age: 16
 &#125;,
 &#123;
 name: &#x27;Rose&#x27;,
 age: 12
 &#125;,
 &#123;
 name: &#x27;Aka&#x27;,
 age: 18
 &#125;
 ]
 &#125;,
 computed: &#123;
 filterPersons() &#123;
 // 1. 取出相关数据
 const &#123;
 searchName,
 persons,
 orderType
 &#125; = this; // 解构赋值

 let fPersons;

 // 2. 对persons进行过滤
 fPersons = persons.filter(p =&gt; p.name.indexOf(searchName) !== -1);

 // 3. 排序
 if (orderType !== 0) &#123;
 fPersons.sort(function (p1, p2) &#123; // 返回负数p1在前，返回正数p2在前
 if (orderType === 2) &#123;
 return p2.age - p1.age; // 降序
 &#125; else &#123;
 return p1.age - p2.age; // 升序
 &#125;
 &#125;)
 &#125;
 return fPersons;
 &#125;
 &#125;,
 methods: &#123;
 setOrderType(orderType) &#123;
 this.orderType = orderType;
 &#125;
 &#125;
 &#125;)
 &lt;/script&gt;
&lt;/body&gt;

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b738000369ee4b88bb1aafd216064946~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp)

---
title: 01-Vue.js基础入门
date: 2024-10-02T00:00:00+08:00
tags:
    - vue
    - 教程
    - 基础入门
categories: vue
cover: /images/cover_vue.png
index_enable: true
aside_enable: true
archives_enable: true
position: both
default_cover:
sticky: false
description: "Vue.js 基础入门教程，涵盖创建应用、模板语法、响应式数据、指令系统、事件处理等核心概念，每个知识点配有实战案例。"
---

## 一、创建 Vue 应用

### 1.1 使用 createApp

Vue 3 使用 `createApp` 创建应用实例：

```javascript
// main.js
import { createApp } from 'vue'
import App from './App.vue'

const app = createApp(App)
app.mount('#app')
```

### 1.2 应用配置

```javascript
const app = createApp(App)

// 全局配置
app.config.errorHandler = (err) => {
  console.error('全局错误:', err)
}

// 注册全局组件
app.component('GlobalButton', {
  template: '<button>全局按钮</button>'
})

// 注册全局指令
app.directive('focus', {
  mounted(el) {
    el.focus()
  }
})

// 提供全局属性
app.provide('globalMessage', '全局消息')

app.mount('#app')
```

### 1.3 实战案例：创建一个简单计数器

```vue
<!-- Counter.vue -->
<template>
  <div class="counter">
    <h2>计数器</h2>
    <p>当前值: {{ count }}</p>
    <div class="buttons">
      <button @click="decrement">-</button>
      <button @click="reset">重置</button>
      <button @click="increment">+</button>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const count = ref(0)

function increment() {
  count.value++
}

function decrement() {
  count.value--
}

function reset() {
  count.value = 0
}
</script>

<style scoped>
.counter {
  text-align: center;
  padding: 20px;
}

.buttons button {
  margin: 5px;
  padding: 8px 16px;
}
</style>
```

---

## 二、模板语法

### 2.1 文本插值

```vue
<template>
  <!-- 双大括号语法 -->
  <p>{{ message }}</p>

  <!-- 支持 JavaScript 表达式 -->
  <p>{{ number + 1 }}</p>
  <p>{{ ok ? 'YES' : 'NO' }}</p>
  <p>{{ message.split('').reverse().join('') }}</p>
</template>

<script setup>
const message = 'Hello Vue 3!'
const number = 10
const ok = true
</script>
```

### 2.2 原始 HTML

```vue
<template>
  <!-- 使用 v-html 渲染原始 HTML -->
  <div v-html="rawHtml"></div>
</template>

<script setup>
const rawHtml = '<strong style="color: red;">红色粗体文字</strong>'
</script>
```

> ⚠️ **安全警告**：在网站上动态渲染任意 HTML 是非常危险的，容易导致 XSS 攻击。只对可信内容使用 HTML 插值。

### 2.3 属性绑定

```vue
<template>
  <!-- 动态绑定属性 -->
  <div v-bind:id="dynamicId"></div>
  <button :disabled="isDisabled">按钮</button>

  <!-- 绑定多个属性 -->
  <input v-bind="objectOfAttrs">

  <!-- 动态属性名 -->
  <button :[attributeName]="value">动态属性</button>
</template>

<script setup>
const dynamicId = 'my-id'
const isDisabled = true
const objectOfAttrs = {
  id: 'container',
  class: 'wrapper',
  style: 'color: blue;'
}
const attributeName = 'title'
const value = '提示文本'
</script>
```

### 2.4 实战案例：动态样式卡片

```vue
<template>
  <div class="card" :style="cardStyle">
    <h3>{{ title }}</h3>
    <p>{{ content }}</p>
    <button @click="changeTheme">切换主题</button>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const title = ref('动态卡片')
const content = ref('这是一个可以动态切换主题的卡片组件')
const themeIndex = ref(0)

const themes = [
  { bg: '#fff', color: '#333', border: '#ddd' },
  { bg: '#2c3e50', color: '#fff', border: '#42b983' },
  { bg: '#f39c12', color: '#fff', border: '#e67e22' }
]

const cardStyle = computed(() => {
  const theme = themes[themeIndex.value]
  return {
    backgroundColor: theme.bg,
    color: theme.color,
    border: `2px solid ${theme.border}`
  }
})

function changeTheme() {
  themeIndex.value = (themeIndex.value + 1) % themes.length
}
</script>

<style scoped>
.card {
  padding: 20px;
  border-radius: 8px;
  max-width: 300px;
  transition: all 0.3s ease;
}

.card button {
  margin-top: 10px;
  padding: 8px 16px;
  cursor: pointer;
}
</style>
```

---

## 三、响应式数据

### 3.1 ref 基础

`ref` 用于创建响应式数据：

```vue
<template>
  <p>{{ message }}</p>
  <button @click="updateMessage">修改消息</button>
</template>

<script setup>
import { ref } from 'vue'

// 创建响应式引用
const message = ref('Hello!')

// 在 script 中需要使用 .value 访问
function updateMessage() {
  message.value = 'Updated!'
}

console.log(message.value) // 'Hello!'
</script>
```

### 3.2 reactive 对象

`reactive` 用于创建响应式对象：

```vue
<template>
  <p>姓名: {{ user.name }}</p>
  <p>年龄: {{ user.age }}</p>
  <button @click="growUp">长大一岁</button>
</template>

<script setup>
import { reactive } from 'vue'

// 创建响应式对象
const user = reactive({
  name: '张三',
  age: 25,
  profile: {
    email: 'zhangsan@example.com'
  }
})

function growUp() {
  user.age++ // 直接访问属性，不需要 .value
}

console.log(user.age) // 25
</script>
```

### 3.3 ref vs reactive 对比

| 特性 | ref | reactive |
|------|-----|----------|
| 适用类型 | 任意类型 | 对象/数组 |
| 访问方式 | `.value` | 直接访问 |
| 解构 | 保持响应式 | 丢失响应式 |
| 替换整体 | 可以 | 不可以 |
| TypeScript | 泛型推断更好 | 类型推断稍弱 |

```vue
<script setup>
import { ref, reactive } from 'vue'

// ref 示例
const count = ref(0)
const user = ref({ name: '张三' })

// 可以整体替换
user.value = { name: '李四' }

// reactive 示例
const state = reactive({
  count: 0,
  user: { name: '张三' }
})

// 不能整体替换，但可以修改属性
state.count++
state.user.name = '李四'

// 解构会丢失响应式
const { count: reactiveCount } = state // 不是响应式！
</script>
```

### 3.4 实战案例：购物车

```vue
<template>
  <div class="cart">
    <h2>购物车</h2>

    <!-- 商品列表 -->
    <div class="product-list">
      <div v-for="item in cart.items" :key="item.id" class="product-item">
        <span>{{ item.name }}</span>
        <span>¥{{ item.price }}</span>
        <div class="quantity">
          <button @click="decreaseQuantity(item)">-</button>
          <span>{{ item.quantity }}</span>
          <button @click="increaseQuantity(item)">+</button>
        </div>
        <button @click="removeItem(item.id)" class="remove">删除</button>
      </div>
    </div>

    <!-- 统计信息 -->
    <div class="summary">
      <p>总数量: {{ totalCount }}</p>
      <p>总价: ¥{{ totalPrice.toFixed(2) }}</p>
    </div>

    <button @click="clearCart" v-if="cart.items.length > 0">清空购物车</button>
  </div>
</template>

<script setup>
import { reactive, computed } from 'vue'

const cart = reactive({
  items: [
    { id: 1, name: 'iPhone 15', price: 7999, quantity: 1 },
    { id: 2, name: 'MacBook Pro', price: 14999, quantity: 2 },
    { id: 3, name: 'AirPods Pro', price: 1899, quantity: 1 }
  ]
})

// 计算属性：总数量
const totalCount = computed(() => {
  return cart.items.reduce((sum, item) => sum + item.quantity, 0)
})

// 计算属性：总价
const totalPrice = computed(() => {
  return cart.items.reduce((sum, item) => sum + item.price * item.quantity, 0)
})

function increaseQuantity(item) {
  item.quantity++
}

function decreaseQuantity(item) {
  if (item.quantity > 1) {
    item.quantity--
  }
}

function removeItem(id) {
  const index = cart.items.findIndex(item => item.id === id)
  if (index > -1) {
    cart.items.splice(index, 1)
  }
}

function clearCart() {
  cart.items = []
}
</script>

<style scoped>
.cart {
  max-width: 600px;
  margin: 20px auto;
  padding: 20px;
  border: 1px solid #eee;
  border-radius: 8px;
}

.product-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 0;
  border-bottom: 1px solid #eee;
}

.quantity {
  display: flex;
  align-items: center;
  gap: 8px;
}

.quantity button {
  width: 24px;
  height: 24px;
}

.remove {
  background: #ff4d4f;
  color: white;
  border: none;
  padding: 4px 12px;
  cursor: pointer;
}

.summary {
  margin-top: 20px;
  padding: 10px;
  background: #f5f5f5;
}
</style>
```

---

## 四、指令系统

### 4.1 条件渲染 v-if / v-else

```vue
<template>
  <!-- v-if 会真正销毁和重建元素 -->
  <div v-if="type === 'A'">类型 A</div>
  <div v-else-if="type === 'B'">类型 B</div>
  <div v-else>其他类型</div>

  <!-- v-show 只是切换 display 样式 -->
  <div v-show="isVisible">可显示/隐藏</div>

  <button @click="toggle">切换</button>
</template>

<script setup>
import { ref } from 'vue'

const type = ref('A')
const isVisible = ref(true)

function toggle() {
  isVisible.value = !isVisible.value
  type.value = type.value === 'A' ? 'B' : 'A'
}
</script>
```

### 4.2 列表渲染 v-for

```vue
<template>
  <!-- 遍历数组 -->
  <ul>
    <li v-for="item in items" :key="item.id">
      {{ item.name }}
    </li>
  </ul>

  <!-- 遍历对象 -->
  <ul>
    <li v-for="(value, key) in object" :key="key">
      {{ key }}: {{ value }}
    </li>
  </ul>

  <!-- 使用索引 -->
  <ul>
    <li v-for="(item, index) in items" :key="item.id">
      {{ index }} - {{ item.name }}
    </li>
  </ul>
</template>

<script setup>
const items = [
  { id: 1, name: 'Apple' },
  { id: 2, name: 'Banana' },
  { id: 3, name: 'Orange' }
]

const object = {
  name: 'Vue',
  version: '3',
  author: 'Evan You'
}
</script>
```

### 4.3 其他常用指令

```vue
<template>
  <!-- v-bind 缩写 -->
  <img :src="imageSrc" :alt="imageAlt">

  <!-- v-on 缩写 -->
  <button @click="handleClick">点击</button>

  <!-- v-model 双向绑定 -->
  <input v-model="inputText">
  <textarea v-model="textareaValue"></textarea>
  <select v-model="selected">
    <option value="a">A</option>
    <option value="b">B</option>
  </select>

  <!-- v-slot 缩写 -->
  <ChildComponent>
    <template #header>
      <h1>标题</h1>
    </template>
  </ChildComponent>

  <!-- v-once 只渲染一次 -->
  <span v-once>{{ neverChange }}</span>

  <!-- v-pre 跳过编译 -->
  <span v-pre>{{ this will not be compiled }}</span>

  <!-- v-memo 缓存子树 -->
  <div v-memo="[value]">
    {{ value }}
  </div>
</template>
```

### 4.4 实战案例：可过滤的列表

```vue
<template>
  <div class="filterable-list">
    <input
      v-model="searchQuery"
      placeholder="搜索..."
      class="search-input"
    >

    <select v-model="sortBy" class="sort-select">
      <option value="name">按名称排序</option>
      <option value="price">按价格排序</option>
      <option value="stock">按库存排序</option>
    </select>

    <ul class="product-list">
      <li v-for="product in filteredProducts" :key="product.id" class="product-item">
        <span class="name">{{ product.name }}</span>
        <span class="price">¥{{ product.price }}</span>
        <span class="stock" :class="{ 'low-stock': product.stock < 10 }">
          库存: {{ product.stock }}
        </span>
      </li>
    </ul>

    <p v-if="filteredProducts.length === 0">没有找到匹配的商品</p>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const searchQuery = ref('')
const sortBy = ref('name')

const products = ref([
  { id: 1, name: 'iPhone 15 Pro', price: 8999, stock: 50 },
  { id: 2, name: 'MacBook Air M2', price: 9499, stock: 30 },
  { id: 3, name: 'AirPods Pro 2', price: 1899, stock: 8 },
  { id: 4, name: 'iPad Pro', price: 6799, stock: 20 },
  { id: 5, name: 'Apple Watch', price: 2999, stock: 5 }
])

const filteredProducts = computed(() => {
  let result = products.value.filter(product =>
    product.name.toLowerCase().includes(searchQuery.value.toLowerCase())
  )

  // 排序
  result.sort((a, b) => {
    if (sortBy.value === 'name') {
      return a.name.localeCompare(b.name)
    } else if (sortBy.value === 'price') {
      return a.price - b.price
    } else {
      return a.stock - b.stock
    }
  })

  return result
})
</script>

<style scoped>
.filterable-list {
  max-width: 600px;
  margin: 20px auto;
}

.search-input, .sort-select {
  padding: 8px 12px;
  margin-right: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.product-list {
  list-style: none;
  padding: 0;
}

.product-item {
  display: flex;
  justify-content: space-between;
  padding: 12px;
  border-bottom: 1px solid #eee;
}

.low-stock {
  color: #ff4d4f;
  font-weight: bold;
}
</style>
```

---

## 五、事件处理

### 5.1 内联事件处理器

```vue
<template>
  <!-- 内联语句 -->
  <button @click="count++">增加 {{ count }}</button>

  <!-- 访问事件对象 -->
  <button @click="handleClick($event)">点击</button>

  <!-- 传递参数 -->
  <button @click="say('hello')">Say hello</button>
  <button @click="say('hello', $event)">Say hello with event</button>
</template>

<script setup>
import { ref } from 'vue'

const count = ref(0)

function handleClick(event) {
  console.log(event.target.tagName) // BUTTON
}

function say(message, event) {
  console.log(message)
  if (event) {
    console.log(event.target)
  }
}
</script>
```

### 5.2 事件修饰符

```vue
<template>
  <!-- 阻止默认行为 -->
  <form @submit.prevent="onSubmit">
    <button type="submit">提交</button>
  </form>

  <!-- 阻止事件冒泡 -->
  <div @click="onDivClick">
    <button @click.stop="onButtonClick">按钮</button>
  </div>

  <!-- 事件只触发一次 -->
  <button @click.once="onOnceClick">只触发一次</button>

  <!-- 捕获模式 -->
  <div @click.capture="onCapture">
    <button @click="onBubble">测试捕获</button>
  </div>

  <!-- 只当事件在该元素本身触发时触发 -->
  <div @click.self="onSelf">
    <button @click="onButton">按钮</button>
  </div>

  <!-- 链式修饰符 -->
  <form @submit.prevent.stop="onSubmit"></form>
</template>
```

### 5.3 按键修饰符

```vue
<template>
  <!-- 按键修饰符 -->
  <input @keyup.enter="onEnter">
  <input @keyup.tab="onTab">
  <input @keyup.delete="onDelete">
  <input @keyup.esc="onEsc">
  <input @keyup.space="onSpace">
  <input @keyup.up="onUp">
  <input @keyup.down="onDown">
  <input @keyup.left="onLeft">
  <input @keyup.right="onRight">

  <!-- 系统修饰符 -->
  <input @keyup.ctrl="onCtrl">
  <input @keyup.alt="onAlt">
  <input @keyup.shift="onShift">
  <input @keyup.meta="onMeta"> <!-- Mac 的 Command 键 -->

  <!-- 组合使用 -->
  <input @keyup.ctrl.enter="onCtrlEnter">
  <input @click.ctrl="onClickCtrl">

  <!-- exact 修饰符 -->
  <button @click.ctrl.exact="onCtrlOnly">只有 Ctrl</button>
  <button @click.exact="onExact">没有任何修饰键</button>
</template>
```

### 5.4 实战案例：表单提交

```vue
<template>
  <form @submit.prevent="handleSubmit" class="form">
    <h2>用户注册</h2>

    <div class="form-group">
      <label>用户名:</label>
      <input
        v-model="form.username"
        @keyup.enter="focusEmail"
        placeholder="按 Enter 跳转到邮箱"
        required
      >
    </div>

    <div class="form-group">
      <label>邮箱:</label>
      <input
        ref="emailInput"
        v-model="form.email"
        type="email"
        @keyup.enter="focusPassword"
        placeholder="按 Enter 跳转到密码"
        required
      >
    </div>

    <div class="form-group">
      <label>密码:</label>
      <input
        ref="passwordInput"
        v-model="form.password"
        type="password"
        @keyup.enter="handleSubmit"
        placeholder="按 Enter 提交"
        required
      >
    </div>

    <div class="form-group">
      <label>
        <input type="checkbox" v-model="form.agree" required>
        同意用户协议
      </label>
    </div>

    <button type="submit" :disabled="!form.agree">注册</button>
    <button type="button" @click.ctrl="resetForm">Ctrl + 点击重置</button>
  </form>
</template>

<script setup>
import { ref, reactive } from 'vue'

const emailInput = ref(null)
const passwordInput = ref(null)

const form = reactive({
  username: '',
  email: '',
  password: '',
  agree: false
})

function focusEmail() {
  emailInput.value.focus()
}

function focusPassword() {
  passwordInput.value.focus()
}

function handleSubmit() {
  if (!form.agree) {
    alert('请同意用户协议')
    return
  }

  console.log('提交表单:', form)
  alert('注册成功！')
}

function resetForm() {
  form.username = ''
  form.email = ''
  form.password = ''
  form.agree = false
}
</script>

<style scoped>
.form {
  max-width: 400px;
  margin: 20px auto;
  padding: 20px;
  border: 1px solid #eee;
  border-radius: 8px;
}

.form-group {
  margin-bottom: 15px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
}

.form-group input {
  width: 100%;
  padding: 8px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

button {
  margin-right: 10px;
  padding: 8px 16px;
  cursor: pointer;
}

button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}
</style>
```

---

## 六、计算属性与侦听器

### 6.1 计算属性 computed

```vue
<template>
  <p>原价: {{ price }}</p>
  <p>折扣价: {{ discountedPrice }}</p>
  <p>最终价格: {{ formatPrice(discountedPrice) }}</p>
</template>

<script setup>
import { ref, computed } from 'vue'

const price = ref(100)

// 计算属性（有缓存）
const discountedPrice = computed(() => {
  return price.value * 0.8
})

// 可写计算属性
const fullName = computed({
  get() {
    return firstName.value + ' ' + lastName.value
  },
  set(newValue) {
    [firstName.value, lastName.value] = newValue.split(' ')
  }
})

function formatPrice(value) {
  return '¥' + value.toFixed(2)
}
</script>
```

### 6.2 侦听器 watch

```vue
<template>
  <input v-model="searchQuery" placeholder="搜索...">
  <p>搜索结果: {{ searchResult }}</p>
</template>

<script setup>
import { ref, watch } from 'vue'

const searchQuery = ref('')
const searchResult = ref('')

// 侦听单个 ref
watch(searchQuery, (newValue, oldValue) => {
  console.log(`搜索词从 "${oldValue}" 变为 "${newValue}"`)

  // 模拟异步搜索
  setTimeout(() => {
    searchResult.value = `搜索 "${newValue}" 的结果...`
  }, 500)
})

// 立即执行
watch(searchQuery, (newValue) => {
  // ...
}, { immediate: true })

// 深度侦听对象
const user = ref({ name: '张三', age: 25 })
watch(user, (newValue) => {
  console.log('user 发生变化:', newValue)
}, { deep: true })
</script>
```

### 6.3 watchEffect

```vue
<script setup>
import { ref, watchEffect } from 'vue'

const count = ref(0)
const name = ref('Vue')

// 自动追踪依赖
watchEffect(() => {
  console.log(`count 是 ${count.value}, name 是 ${name.value}`)
  // 只要 count 或 name 变化，就会重新执行
})

// 停止侦听
const stop = watchEffect(() => {
  /* ... */
})

// 调用 stop() 可以停止侦听
</script>
```

### 6.4 实战案例：实时搜索

```vue
<template>
  <div class="search-demo">
    <input
      v-model="searchQuery"
      placeholder="输入搜索关键词..."
      class="search-input"
    >

    <div v-if="isLoading" class="loading">搜索中...</div>

    <div v-else>
      <h3>搜索结果 ({{ results.length }})</h3>
      <ul v-if="results.length > 0">
        <li v-for="item in results" :key="item.id">
          {{ item.name }} - {{ item.category }}
        </li>
      </ul>
      <p v-else-if="searchQuery && !isLoading">没有找到匹配结果</p>
    </div>

    <div class="history" v-if="searchHistory.length > 0">
      <h4>搜索历史:</h4>
      <span
        v-for="term in searchHistory"
        :key="term"
        @click="searchQuery = term"
        class="history-item"
      >
        {{ term }}
      </span>
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'

const searchQuery = ref('')
const results = ref([])
const isLoading = ref(false)
const searchHistory = ref([])

// 模拟数据库
const database = [
  { id: 1, name: 'iPhone 15 Pro', category: '手机' },
  { id: 2, name: 'MacBook Pro', category: '电脑' },
  { id: 3, name: 'AirPods Pro', category: '配件' },
  { id: 4, name: 'iPad Air', category: '平板' },
  { id: 5, name: 'Apple Watch', category: '手表' },
  { id: 6, name: 'Mac mini', category: '电脑' },
  { id: 7, name: 'iMac', category: '电脑' }
]

// 防抖函数
function debounce(fn, delay) {
  let timer = null
  return function(...args) {
    if (timer) clearTimeout(timer)
    timer = setTimeout(() => {
      fn.apply(this, args)
    }, delay)
  }
}

// 模拟搜索API
function searchAPI(query) {
  return new Promise((resolve) => {
    setTimeout(() => {
      const filtered = database.filter(item =>
        item.name.toLowerCase().includes(query.toLowerCase())
      )
      resolve(filtered)
    }, 300)
  })
}

// 侦听搜索词变化（带防抖）
watch(searchQuery, debounce(async (newQuery) => {
  if (!newQuery.trim()) {
    results.value = []
    return
  }

  isLoading.value = true

  try {
    results.value = await searchAPI(newQuery)

    // 添加到搜索历史
    if (!searchHistory.value.includes(newQuery)) {
      searchHistory.value.unshift(newQuery)
      if (searchHistory.value.length > 5) {
        searchHistory.value.pop()
      }
    }
  } finally {
    isLoading.value = false
  }
}, 500))
</script>

<style scoped>
.search-demo {
  max-width: 600px;
  margin: 20px auto;
}

.search-input {
  width: 100%;
  padding: 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 16px;
}

.loading {
  color: #666;
  padding: 20px;
}

.history-item {
  display: inline-block;
  margin: 5px;
  padding: 4px 12px;
  background: #f0f0f0;
  border-radius: 12px;
  cursor: pointer;
}

.history-item:hover {
  background: #e0e0e0;
}
</style>
```

---

> 💡 **小结**：本章介绍了 Vue.js 的核心基础语法，包括创建应用、模板语法、响应式数据、指令系统和事件处理。每个知识点都配有实战案例，建议动手实践加深理解。
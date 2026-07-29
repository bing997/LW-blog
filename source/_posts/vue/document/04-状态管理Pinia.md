---
title: Vue.js状态管理Pinia
date: 2024-10-05 10:00:00
tags:
  - Vue.js
  - Pinia
  - 状态管理
  - Store
categories: vue
cover: /images/cover_vue.png
---

# Vue.js 状态管理 Pinia

## 一、Pinia 简介

### 1.1 什么是 Pinia

Pinia 是 Vue.js 的专属状态管理库,它允许你跨组件或页面共享状态。Pinia 于 2021 年成为 Vue.js 官方的状态管理库,取代了 Vuex。

**Pinia 的优势:**

- 支持 Vue 2 和 Vue 3
- 完整的 TypeScript 支持
- 轻量级,压缩后体积仅 1KB
- 移除了 mutations,简化了 API
- 支持 Vue DevTools
- 模块化设计,无需嵌套模块
- 支持服务端渲染

### 1.2 安装 Pinia

```bash
npm install pinia
# 或
yarn add pinia
# 或
pnpm add pinia
```

### 1.3 基本配置

```javascript
// main.js
import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'

const app = createApp(App)
const pinia = createPinia()

app.use(pinia)
app.mount('#app')
```

---

## 二、定义 Store

### 2.1 Option Store 风格

```javascript
// stores/counter.js
import { defineStore } from 'pinia'

export const useCounterStore = defineStore('counter', {
  // state
  state: () => ({
    count: 0,
    name: 'My Counter'
  }),
  
  // getters
  getters: {
    doubleCount: (state) => state.count * 2,
    
    doubleCountPlusOne() {
      // 使用 this 访问其他 getter
      return this.doubleCount + 1
    }
  },
  
  // actions
  actions: {
    increment() {
      this.count++
    },
    
    decrement() {
      this.count--
    },
    
    async fetchCount() {
      const response = await fetch('/api/count')
      const data = await response.json()
      this.count = data.count
    }
  }
})
```

### 2.2 Setup Store 风格

```javascript
// stores/counter.js
import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

export const useCounterStore = defineStore('counter', () => {
  // state
  const count = ref(0)
  const name = ref('My Counter')
  
  // getters
  const doubleCount = computed(() => count.value * 2)
  const doubleCountPlusOne = computed(() => doubleCount.value + 1)
  
  // actions
  function increment() {
    count.value++
  }
  
  function decrement() {
    count.value--
  }
  
  async function fetchCount() {
    const response = await fetch('/api/count')
    const data = await response.json()
    count.value = data.count
  }
  
  return {
    count,
    name,
    doubleCount,
    doubleCountPlusOne,
    increment,
    decrement,
    fetchCount
  }
})
```

**实践练习1**: 创建一个用户状态管理 Store

```javascript
// stores/user.js
import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', {
  state: () => ({
    user: null,
    token: null,
    isLoggedIn: false,
    loading: false,
    error: null
  }),
  
  getters: {
    userId: (state) => state.user?.id,
    userName: (state) => state.user?.name || '未登录',
    userAvatar: (state) => state.user?.avatar || '/default-avatar.png',
    isAdmin: (state) => state.user?.role === 'admin',
    hasPermission: (state) => (permission) => {
      return state.user?.permissions?.includes(permission)
    }
  },
  
  actions: {
    async login(credentials) {
      this.loading = true
      this.error = null
      
      try {
        const response = await fetch('/api/login', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(credentials)
        })
        
        if (!response.ok) throw new Error('登录失败')
        
        const data = await response.json()
        this.user = data.user
        this.token = data.token
        this.isLoggedIn = true
        
        // 保存 token
        localStorage.setItem('token', data.token)
        
        return data
      } catch (error) {
        this.error = error.message
        throw error
      } finally {
        this.loading = false
      }
    },
    
    async logout() {
      try {
        await fetch('/api/logout', {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${this.token}`
          }
        })
      } finally {
        this.user = null
        this.token = null
        this.isLoggedIn = false
        localStorage.removeItem('token')
      }
    },
    
    async fetchUser() {
      const token = localStorage.getItem('token')
      if (!token) return
      
      this.token = token
      
      try {
        const response = await fetch('/api/user', {
          headers: {
            'Authorization': `Bearer ${token}`
          }
        })
        
        if (response.ok) {
          const data = await response.json()
          this.user = data.user
          this.isLoggedIn = true
        }
      } catch (error) {
        console.error('获取用户信息失败:', error)
      }
    },
    
    updateProfile(profile) {
      if (this.user) {
        this.user = { ...this.user, ...profile }
      }
    }
  }
})
```

---

## 三、使用 Store

### 3.1 在组件中使用

```vue
<template>
  <div class="counter">
    <h2>{{ counter.name }}</h2>
    <p>Count: {{ counter.count }}</p>
    <p>Double: {{ counter.doubleCount }}</p>
    
    <button @click="counter.increment">+</button>
    <button @click="counter.decrement">-</button>
  </div>
</template>

<script>
import { useCounterStore } from '@/stores/counter'

export default {
  setup() {
    const counter = useCounterStore()
    
    // 可以直接访问 state
    console.log(counter.count)
    
    // 可以调用 action
    counter.increment()
    
    return { counter }
  }
}
</script>
```

### 3.2 解构 Store

```vue
<script>
import { storeToRefs } from 'pinia'
import { useCounterStore } from '@/stores/counter'

export default {
  setup() {
    const store = useCounterStore()
    
    // ❌ 这不会工作,因为响应性会丢失
    // const { count, doubleCount } = store
    
    // ✅ 正确方式:使用 storeToRefs
    const { count, doubleCount } = storeToRefs(store)
    
    // Actions 不需要 storeToRefs
    const { increment, decrement } = store
    
    return { count, doubleCount, increment, decrement }
  }
}
</script>
```

### 3.3 直接修改 State

```vue
<script>
import { useCounterStore } from '@/stores/counter'

export default {
  setup() {
    const store = useCounterStore()
    
    // 直接修改
    store.count++
    
    // 批量修改
    store.$patch({
      count: store.count + 10,
      name: 'New Name'
    })
    
    // 使用函数批量修改
    store.$patch((state) => {
      state.count++
      state.name = 'Patched Name'
    })
    
    // 重置状态
    store.$reset()
    
    return { store }
  }
}
</script>
```

**实践练习2**: 创建一个购物车 Store

```javascript
// stores/cart.js
import { defineStore } from 'pinia'

export const useCartStore = defineStore('cart', {
  state: () => ({
    items: [],
    checkoutPending: false
  }),
  
  getters: {
    // 商品总数
    itemsCount: (state) => state.items.reduce((sum, item) => sum + item.quantity, 0),
    
    // 总价
    totalPrice: (state) => {
      return state.items.reduce((total, item) => {
        return total + item.price * item.quantity
      }, 0)
    },
    
    // 格式化总价
    formattedTotalPrice() {
      return `¥${this.totalPrice.toFixed(2)}`
    },
    
    // 检查商品是否在购物车中
    hasItem: (state) => (productId) => {
      return state.items.some(item => item.productId === productId)
    },
    
    // 获取商品数量
    getItemQuantity: (state) => (productId) => {
      const item = state.items.find(item => item.productId === productId)
      return item ? item.quantity : 0
    }
  },
  
  actions: {
    addItem(product, quantity = 1) {
      const existingItem = this.items.find(item => item.productId === product.id)
      
      if (existingItem) {
        existingItem.quantity += quantity
      } else {
        this.items.push({
          productId: product.id,
          name: product.name,
          price: product.price,
          image: product.image,
          quantity
        })
      }
    },
    
    removeItem(productId) {
      const index = this.items.findIndex(item => item.productId === productId)
      if (index > -1) {
        this.items.splice(index, 1)
      }
    },
    
    updateQuantity(productId, quantity) {
      const item = this.items.find(item => item.productId === productId)
      if (item) {
        if (quantity <= 0) {
          this.removeItem(productId)
        } else {
          item.quantity = quantity
        }
      }
    },
    
    clearCart() {
      this.items = []
    },
    
    async checkout(shippingInfo) {
      this.checkoutPending = true
      
      try {
        const response = await fetch('/api/orders', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            items: this.items,
            shipping: shippingInfo
          })
        })
        
        if (!response.ok) throw new Error('Checkout failed')
        
        const order = await response.json()
        this.clearCart()
        
        return order
      } finally {
        this.checkoutPending = false
      }
    }
  }
})
```

```vue
<!-- Cart.vue -->
<template>
  <div class="cart">
    <h2>购物车</h2>
    
    <div v-if="cart.itemsCount === 0" class="empty">
      购物车是空的
    </div>
    
    <div v-else class="cart-items">
      <div v-for="item in cart.items" :key="item.productId" class="cart-item">
        <img :src="item.image" :alt="item.name" />
        <div class="item-info">
          <h3>{{ item.name }}</h3>
          <p class="price">¥{{ item.price }}</p>
        </div>
        <div class="quantity-control">
          <button @click="cart.updateQuantity(item.productId, item.quantity - 1)">-</button>
          <span>{{ item.quantity }}</span>
          <button @click="cart.updateQuantity(item.productId, item.quantity + 1)">+</button>
        </div>
        <button @click="cart.removeItem(item.productId)" class="remove-btn">删除</button>
      </div>
    </div>
    
    <div class="cart-summary" v-if="cart.itemsCount > 0">
      <p>商品总数: {{ cart.itemsCount }}</p>
      <p class="total">总价: {{ cart.formattedTotalPrice }}</p>
      <button @click="checkout" :disabled="cart.checkoutPending">
        结算
      </button>
    </div>
  </div>
</template>

<script>
import { useCartStore } from '@/stores/cart'

export default {
  setup() {
    const cart = useCartStore()
    
    const checkout = async () => {
      try {
        const order = await cart.checkout({
          address: '详细地址',
          phone: '13800138000'
        })
        console.log('订单创建成功:', order)
      } catch (error) {
        console.error('结算失败:', error)
      }
    }
    
    return { cart, checkout }
  }
}
</script>
```

---

## 四、组合式函数

### 4.1 在 Store 中使用其他 Store

```javascript
// stores/user.js
import { defineStore } from 'pinia'
import { useCartStore } from './cart'

export const useUserStore = defineStore('user', {
  state: () => ({
    user: null,
    isLoggedIn: false
  }),
  
  actions: {
    async logout() {
      const cartStore = useCartStore()
      
      // 清除购物车
      cartStore.clearCart()
      
      // 退出登录
      await fetch('/api/logout', { method: 'POST' })
      
      this.user = null
      this.isLoggedIn = false
    }
  }
})
```

### 4.2 使用组合式函数

```javascript
// stores/composables/useCartCalculations.js
import { computed } from 'vue'
import { useCartStore } from '@/stores/cart'
import { useUserStore } from '@/stores/user'

export function useCartCalculations() {
  const cartStore = useCartStore()
  const userStore = useUserStore()
  
  const discount = computed(() => {
    if (!userStore.user) return 0
    
    // VIP 用户 10% 折扣
    if (userStore.user.level === 'vip') {
      return cartStore.totalPrice * 0.1
    }
    
    return 0
  })
  
  const finalPrice = computed(() => {
    return cartStore.totalPrice - discount.value
  })
  
  return {
    discount,
    finalPrice
  }
}
```

---

## 五、State 持久化

### 5.1 手动持久化

```javascript
// stores/user.js
import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', {
  state: () => ({
    user: JSON.parse(localStorage.getItem('user') || 'null'),
    token: localStorage.getItem('token') || null
  }),
  
  actions: {
    login(userData, token) {
      this.user = userData
      this.token = token
      
      // 持久化到 localStorage
      localStorage.setItem('user', JSON.stringify(userData))
      localStorage.setItem('token', token)
    },
    
    logout() {
      this.user = null
      this.token = null
      
      // 清除 localStorage
      localStorage.removeItem('user')
      localStorage.removeItem('token')
    }
  }
})
```

### 5.2 使用 pinia-plugin-persistedstate

```bash
npm install pinia-plugin-persistedstate
```

```javascript
// main.js
import { createApp } from 'vue'
import { createPinia } from 'pinia'
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate'
import App from './App.vue'

const app = createApp(App)
const pinia = createPinia()

pinia.use(piniaPluginPersistedstate)

app.use(pinia)
app.mount('#app')
```

```javascript
// stores/user.js
export const useUserStore = defineStore('user', {
  state: () => ({
    user: null,
    token: null
  }),
  
  persist: {
    key: 'my-user-store',
    storage: localStorage,
    paths: ['user', 'token']
  }
})
```

---

## 六、插件系统

### 6.1 创建 Pinia 插件

```javascript
// plugins/pinia/logger.js
export function PiniaLogger({ store }) {
  // 监听所有状态变化
  store.$onAction(({ name, args, after, onError }) => {
    const startTime = Date.now()
    console.log(`[Pinia] Action ${name} started with args:`, args)
    
    after((result) => {
      console.log(`[Pinia] Action ${name} finished in ${Date.now() - startTime}ms`)
      console.log('Result:', result)
    })
    
    onError((error) => {
      console.error(`[Pinia] Action ${name} failed:`, error)
    })
  })
  
  // 监听状态变化
  store.$subscribe((mutation, state) => {
    console.log('[Pinia] State changed:', mutation.type)
    console.log('New state:', state)
  })
}
```

```javascript
// main.js
import { createApp } from 'vue'
import { createPinia } from 'pinia'
import { PiniaLogger } from './plugins/pinia/logger'
import App from './App.vue'

const app = createApp(App)
const pinia = createPinia()

// 使用插件
pinia.use(PiniaLogger)

app.use(pinia)
app.mount('#app')
```

### 6.2 全局属性插件

```javascript
// plugins/pina/global.js
export function GlobalPropertiesPlugin({ store }) {
  // 为所有 store 添加全局属性
  store.globalProp = '这是一个全局属性'
  
  // 添加全局方法
  store.reset = function() {
    store.$reset()
    console.log(`${store.$id} has been reset`)
  }
}
```

---

## 七、TypeScript 支持

### 7.1 定义类型化的 Store

```typescript
// stores/user.ts
import { defineStore } from 'pinia'

interface User {
  id: number
  name: string
  email: string
  role: 'admin' | 'user'
  permissions: string[]
}

interface UserState {
  user: User | null
  token: string | null
  isLoggedIn: boolean
}

export const useUserStore = defineStore('user', {
  state: (): UserState => ({
    user: null,
    token: null,
    isLoggedIn: false
  }),
  
  getters: {
    userId: (state) => state.user?.id,
    userName: (state) => state.user?.name || '未登录',
    isAdmin: (state) => state.user?.role === 'admin',
    
    hasPermission: (state) => {
      return (permission: string): boolean => {
        return state.user?.permissions.includes(permission) ?? false
      }
    }
  },
  
  actions: {
    async login(credentials: { email: string; password: string }) {
      const response = await fetch('/api/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(credentials)
      })
      
      const data = await response.json()
      this.user = data.user
      this.token = data.token
      this.isLoggedIn = true
    },
    
    logout() {
      this.user = null
      this.token = null
      this.isLoggedIn = false
    }
  }
})
```

### 7.2 在组件中使用

```vue
<script setup lang="ts">
import { useUserStore } from '@/stores/user'
import { storeToRefs } from 'pinia'

const userStore = useUserStore()

// 类型推断
const { user, isLoggedIn } = storeToRefs(userStore)
const { login, logout } = userStore

// 使用 getter
const isAdmin = userStore.isAdmin

// 使用带参数的 getter
const canEdit = userStore.hasPermission('edit')
</script>
```

---

## 八、最佳实践

### 8.1 Store 组织结构

```
src/
  stores/
    index.js          # Pinia 实例
    user.js           # 用户状态
    cart.js           # 购物车状态
    products.js       # 商品状态
    ui.js             # UI 状态(侧边栏、模态框等)
    composables/      # 组合式函数
      useCartCalculations.js
```

### 8.2 命名规范

```javascript
// Store 文件名:小驼峰
// stores/userProfile.js

// Store 实例名:use 前缀 + Store 后缀
export const useUserProfileStore = defineStore('userProfile', {
  // ...
})

// 在组件中使用
const userProfileStore = useUserProfileStore()
```

### 8.3 避免直接访问其他 Store

```javascript
// ❌ 不好的做法
export const useCartStore = defineStore('cart', {
  actions: {
    checkout() {
      const userStore = useUserStore() // 直接在 action 中使用
      // ...
    }
  }
})

// ✅ 好的做法:通过参数传递
export const useCartStore = defineStore('cart', {
  actions: {
    async checkout(userId) {
      // ...
    }
  }
})

// 在组件中
const cartStore = useCartStore()
const userStore = useUserStore()
await cartStore.checkout(userStore.userId)
```

**实践练习3**: 创建一个待办事项应用 Store

```javascript
// stores/todos.js
import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export const useTodosStore = defineStore('todos', () => {
  // State
  const todos = ref([])
  const filter = ref('all') // all, active, completed
  const loading = ref(false)
  
  // Getters
  const filteredTodos = computed(() => {
    switch (filter.value) {
      case 'active':
        return todos.value.filter(todo => !todo.completed)
      case 'completed':
        return todos.value.filter(todo => todo.completed)
      default:
        return todos.value
    }
  })
  
  const totalTodos = computed(() => todos.value.length)
  const activeTodos = computed(() => todos.value.filter(t => !t.completed).length)
  const completedTodos = computed(() => todos.value.filter(t => t.completed).length)
  
  // Actions
  function addTodo(title) {
    const todo = {
      id: Date.now(),
      title,
      completed: false,
      createdAt: new Date().toISOString()
    }
    todos.value.unshift(todo)
    saveToStorage()
  }
  
  function removeTodo(id) {
    const index = todos.value.findIndex(t => t.id === id)
    if (index > -1) {
      todos.value.splice(index, 1)
      saveToStorage()
    }
  }
  
  function toggleTodo(id) {
    const todo = todos.value.find(t => t.id === id)
    if (todo) {
      todo.completed = !todo.completed
      saveToStorage()
    }
  }
  
  function updateTodoTitle(id, title) {
    const todo = todos.value.find(t => t.id === id)
    if (todo) {
      todo.title = title
      saveToStorage()
    }
  }
  
  function clearCompleted() {
    todos.value = todos.value.filter(t => !t.completed)
    saveToStorage()
  }
  
  function setFilter(newFilter) {
    filter.value = newFilter
  }
  
  function saveToStorage() {
    localStorage.setItem('todos', JSON.stringify(todos.value))
  }
  
  function loadFromStorage() {
    const saved = localStorage.getItem('todos')
    if (saved) {
      todos.value = JSON.parse(saved)
    }
  }
  
  // 初始化时加载
  loadFromStorage()
  
  return {
    // State
    todos,
    filter,
    loading,
    
    // Getters
    filteredTodos,
    totalTodos,
    activeTodos,
    completedTodos,
    
    // Actions
    addTodo,
    removeTodo,
    toggleTodo,
    updateTodoTitle,
    clearCompleted,
    setFilter,
    loadFromStorage
  }
})
```

```vue
<!-- TodoApp.vue -->
<template>
  <div class="todo-app">
    <h1>待办事项</h1>
    
    <!-- 添加待办 -->
    <div class="add-todo">
      <input
        v-model="newTodo"
        @keyup.enter="addTodo"
        placeholder="添加待办事项..."
      />
      <button @click="addTodo">添加</button>
    </div>
    
    <!-- 过滤器 -->
    <div class="filters">
      <button
        :class="{ active: filter === 'all' }"
        @click="setFilter('all')"
      >
        全部 ({{ totalTodos }})
      </button>
      <button
        :class="{ active: filter === 'active' }"
        @click="setFilter('active')"
      >
        待完成 ({{ activeTodos }})
      </button>
      <button
        :class="{ active: filter === 'completed' }"
        @click="setFilter('completed')"
      >
        已完成 ({{ completedTodos }})
      </button>
    </div>
    
    <!-- 待办列表 -->
    <ul class="todo-list">
      <li
        v-for="todo in filteredTodos"
        :key="todo.id"
        :class="{ completed: todo.completed }"
      >
        <input
          type="checkbox"
          :checked="todo.completed"
          @change="toggleTodo(todo.id)"
        />
        <span>{{ todo.title }}</span>
        <button @click="removeTodo(todo.id)">删除</button>
      </li>
    </ul>
    
    <!-- 清除已完成 -->
    <button
      v-if="completedTodos > 0"
      @click="clearCompleted"
      class="clear-completed"
    >
      清除已完成 ({{ completedTodos }})
    </button>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useTodosStore } from '@/stores/todos'
import { storeToRefs } from 'pinia'

const todosStore = useTodosStore()
const { filteredTodos, totalTodos, activeTodos, completedTodos, filter } = storeToRefs(todosStore)
const { addTodo: addTodoAction, removeTodo, toggleTodo, clearCompleted, setFilter } = todosStore

const newTodo = ref('')

function addTodo() {
  if (newTodo.value.trim()) {
    addTodoAction(newTodo.value.trim())
    newTodo.value = ''
  }
}
</script>

<style scoped>
.todo-app {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
}

.todo-list li {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px;
  border-bottom: 1px solid #eee;
}

.todo-list li.completed span {
  text-decoration: line-through;
  color: #999;
}

.filters {
  margin: 20px 0;
  display: flex;
  gap: 10px;
}

.filters button.active {
  background: #1890ff;
  color: white;
}
</style>
```

---

## 总结

Pinia 是 Vue.js 的现代状态管理解决方案,主要特点:

1. **简单直观**: API 简洁,易于理解和使用
2. **类型安全**: 完整的 TypeScript 支持
3. **模块化**: 每个 Store 独立,无需嵌套
4. **DevTools**: 集成 Vue DevTools,调试方便
5. **轻量级**: 体积小,性能优秀

通过 Pinia,可以有效管理应用的复杂状态,提高代码的可维护性。

## 扩展阅读

- [Pinia 官方文档](https://pinia.vuejs.org/zh/)
- [Pinia GitHub](https://github.com/vuejs/pinia)
- [Pinia vs Vuex](https://pinia.vuejs.org/zh/introduction.html#为什么你应该使用-pinia)
- [Pinia 插件](https://pinia.vuejs.org/zh/plugins/)
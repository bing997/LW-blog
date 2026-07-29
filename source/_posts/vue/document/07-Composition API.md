---
title: Vue.js Composition API
date: 2024-10-08 10:00:00
tags:
  - Vue.js
  - Composition API
  - ref
  - reactive
  - 组合式函数
categories: vue
cover: /images/cover_vue.png
---

# Vue.js Composition API

## 一、Composition API 简介

### 1.1 什么是 Composition API

Composition API 是 Vue 3 引入的一组新的 API,用于编写组件逻辑。与 Options API 相比,Composition API 提供了更灵活的代码组织方式和更好的逻辑复用能力。

### 1.2 为什么使用 Composition API

**更好的逻辑复用**
- 提取和复用组件逻辑更简单
- 避免 mixin 的命名冲突问题

**更好的类型推断**
- 对 TypeScript 支持更友好
- 更好的 IDE 智能提示

**更灵活的代码组织**
- 可以按功能组织代码
- 相关的逻辑可以放在一起

**更小的生产包体积**
- Tree-shaking 更友好
- 未使用的 API 不会被打包

---

## 二、响应式基础

### 2.1 ref

`ref` 用于创建响应式的基本数据类型。

```vue
<script setup>
import { ref } from 'vue'

// 创建响应式变量
const count = ref(0)
const message = ref('Hello Vue 3')
const user = ref({ name: '张三', age: 25 })

// 访问和修改值
console.log(count.value) // 0
count.value++ // 修改值

// 在模板中自动解包,不需要 .value
</script>

<template>
  <div>
    <p>Count: {{ count }}</p>
    <button @click="count++">增加</button>
    
    <p>Message: {{ message }}</p>
    <input v-model="message" />
    
    <p>User: {{ user.name }}, {{ user.age }}</p>
  </div>
</template>
```

### 2.2 reactive

`reactive` 用于创建响应式的对象或数组。

```vue
<script setup>
import { reactive } from 'vue'

// 创建响应式对象
const state = reactive({
  count: 0,
  message: 'Hello',
  user: {
    name: '张三',
    age: 25
  }
})

// 创建响应式数组
const list = reactive([1, 2, 3, 4, 5])

// 直接访问,不需要 .value
console.log(state.count) // 0
state.count++

// 添加新属性
state.email = 'zhangsan@example.com'

// 删除属性
delete state.message
</script>

<template>
  <div>
    <p>Count: {{ state.count }}</p>
    <p>User: {{ state.user.name }}</p>
  </div>
</template>
```

### 2.3 ref vs reactive

```vue
<script setup>
import { ref, reactive, isRef, isReactive } from 'vue'

// ref - 适合基本类型
const count = ref(0)
const name = ref('张三')

// reactive - 适合对象和数组
const state = reactive({
  count: 0,
  name: '张三'
})

// 对比

// ref
// - 可以用于任何类型的值
// - 访问时需要 .value
// - 可以被替换(整个对象)
// - 更容易传递(可以解构)

// reactive
// - 只能用于对象类型
// - 访问时不需要 .value
// - 不能被替换(解构会失去响应性)
// - 更适合复杂对象

// 示例:ref 可以被替换
const userRef = ref({ name: '张三' })
userRef.value = { name: '李四' } // ✅ 响应性保持

// 示例:reactive 不能被替换
const userReactive = reactive({ name: '张三' })
userReactive = { name: '李四' } // ❌ 失去响应性

// 示例:reactive 解构会失去响应性
const { name } = state // ❌ name 不是响应式的

// 解决方案:使用 toRefs
import { toRefs } from 'vue'
const { name } = toRefs(state) // ✅ name 是响应式的
</script>
```

**实践练习1**: 创建一个计数器,理解 ref 和 reactive 的区别

```vue
<template>
  <div class="counter-demo">
    <h2>使用 ref</h2>
    <p>Count: {{ countRef }}</p>
    <button @click="countRef++">增加</button>
    <button @click="resetRef">重置</button>
    
    <h2>使用 reactive</h2>
    <p>Count: {{ stateReactive.count }}</p>
    <button @click="stateReactive.count++">增加</button>
    <button @click="resetReactive">重置</button>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'

// 使用 ref
const countRef = ref(0)

const resetRef = () => {
  countRef.value = 0
}

// 使用 reactive
const stateReactive = reactive({
  count: 0,
  name: '计数器'
})

const resetReactive = () => {
  stateReactive.count = 0
}
</script>
```

---

## 三、计算属性

### 3.1 computed

```vue
<script setup>
import { ref, computed } from 'vue'

const firstName = ref('张')
const lastName = ref('三')

// 计算属性(只读)
const fullName = computed(() => {
  return `${firstName.value}${lastName.value}`
})

// 计算属性(可写)
const fullNameWritable = computed({
  get() {
    return `${firstName.value}${lastName.value}`
  },
  set(newValue) {
    const [first, last] = newValue.split('')
    firstName.value = first
    lastName.value = last
  }
})

// 计算属性的性能优化
const expensiveList = computed(() => {
  console.log('计算中...')
  return Array.from({ length: 1000 }, (_, i) => i * 2)
})
</script>

<template>
  <div>
    <p>Full Name: {{ fullName }}</p>
    <input v-model="fullNameWritable" />
  </div>
</template>
```

### 3.2 计算属性的依赖追踪

```vue
<script setup>
import { ref, computed } from 'vue'

const price = ref(100)
const quantity = ref(2)
const discount = ref(0.1)

// 计算属性会自动追踪依赖
const total = computed(() => {
  console.log('重新计算 total')
  return price.value * quantity.value * (1 - discount.value)
})

// 只有当依赖的值改变时才会重新计算
// 多次访问 total.value 只会计算一次
console.log(total.value)
console.log(total.value)
console.log(total.value)
</script>
```

---

## 四、生命周期钩子

### 4.1 Composition API 中的生命周期

```vue
<script setup>
import {
  onBeforeMount,
  onMounted,
  onBeforeUpdate,
  onUpdated,
  onBeforeUnmount,
  onUnmounted,
  onErrorCaptured
} from 'vue'

// 创建阶段
// 没有 beforeCreate 和 created,直接在 setup 中编写

// 挂载阶段
onBeforeMount(() => {
  console.log('组件挂载前')
})

onMounted(() => {
  console.log('组件挂载后')
  // DOM 操作、第三方库初始化、发送请求
})

// 更新阶段
onBeforeUpdate(() => {
  console.log('组件更新前')
})

onUpdated(() => {
  console.log('组件更新后')
  // 避免在此修改状态,可能导致无限循环
})

// 卸载阶段
onBeforeUnmount(() => {
  console.log('组件卸载前')
  // 清理定时器、取消订阅
})

onUnmounted(() => {
  console.log('组件卸载后')
})

// 错误捕获
onErrorCaptured((err, instance, info) => {
  console.error('捕获到错误:', err)
  console.log('组件实例:', instance)
  console.log('错误信息:', info)
  
  // 返回 false 阻止错误继续传播
  return false
})
</script>
```

### 4.2 实际应用场景

```vue
<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const width = ref(window.innerWidth)
const height = ref(window.innerHeight)

const handleResize = () => {
  width.value = window.innerWidth
  height.value = window.innerHeight
}

// 挂载时添加事件监听
onMounted(() => {
  window.addEventListener('resize', handleResize)
})

// 卸载时移除事件监听
onUnmounted(() => {
  window.removeEventListener('resize', handleResize)
})
</script>

<template>
  <p>窗口尺寸: {{ width }} x {{ height }}</p>
</template>
```

---

## 五、组合式函数(Composables)

### 5.1 什么是组合式函数

组合式函数是利用 Vue 的组合式 API 来封装和复用有状态逻辑的函数。它类似于 React 的自定义 Hooks。

### 5.2 创建组合式函数

```javascript
// composables/useMouse.js
import { ref, onMounted, onUnmounted } from 'vue'

export function useMouse() {
  const x = ref(0)
  const y = ref(0)
  
  const update = (e) => {
    x.value = e.pageX
    y.value = e.pageY
  }
  
  onMounted(() => {
    window.addEventListener('mousemove', update)
  })
  
  onUnmounted(() => {
    window.removeEventListener('mousemove', update)
  })
  
  return { x, y }
}
```

```vue
<!-- MouseTracker.vue -->
<template>
  <div>
    <p>鼠标位置: {{ x }}, {{ y }}</p>
  </div>
</template>

<script setup>
import { useMouse } from '@/composables/useMouse'

const { x, y } = useMouse()
</script>
```

**实践练习2**: 创建常用组合式函数集合

```javascript
// composables/useCounter.js
import { ref, computed } from 'vue'

export function useCounter(initialValue = 0) {
  const count = ref(initialValue)
  
  const increment = () => count.value++
  const decrement = () => count.value--
  const reset = () => count.value = initialValue
  
  const double = computed(() => count.value * 2)
  
  return {
    count,
    increment,
    decrement,
    reset,
    double
  }
}
```

```javascript
// composables/useLocalStorage.js
import { ref, watch } from 'vue'

export function useLocalStorage(key, defaultValue) {
  // 从 localStorage 读取初始值
  const value = ref(
    JSON.parse(localStorage.getItem(key)) || defaultValue
  )
  
  // 监听变化并保存到 localStorage
  watch(value, (newValue) => {
    localStorage.setItem(key, JSON.stringify(newValue))
  }, { deep: true })
  
  return value
}
```

```javascript
// composables/useFetch.js
import { ref, toValue } from 'vue'

export function useFetch(url) {
  const data = ref(null)
  const error = ref(null)
  const loading = ref(true)
  
  const fetchData = async () => {
    loading.value = true
    error.value = null
    
    try {
      const response = await fetch(toValue(url))
      if (!response.ok) throw new Error('请求失败')
      data.value = await response.json()
    } catch (e) {
      error.value = e
    } finally {
      loading.value = false
    }
  }
  
  // 立即执行
  fetchData()
  
  return {
    data,
    error,
    loading,
    refetch: fetchData
  }
}
```

```javascript
// composables/useDebounce.js
import { ref, watch } from 'vue'

export function useDebounce(value, delay = 500) {
  const debouncedValue = ref(value.value)
  let timeout
  
  watch(value, (newValue) => {
    clearTimeout(timeout)
    timeout = setTimeout(() => {
      debouncedValue.value = newValue
    }, delay)
  })
  
  return debouncedValue
}
```

```javascript
// composables/useToggle.js
import { ref } from 'vue'

export function useToggle(initialValue = false) {
  const value = ref(initialValue)
  
  const toggle = () => {
    value.value = !value.value
  }
  
  const setTrue = () => {
    value.value = true
  }
  
  const setFalse = () => {
    value.value = false
  }
  
  return {
    value,
    toggle,
    setTrue,
    setFalse
  }
}
```

```javascript
// composables/useClickOutside.js
import { onMounted, onUnmounted } from 'vue'

export function useClickOutside(elementRef, callback) {
  const handleClick = (event) => {
    if (
      elementRef.value &&
      !elementRef.value.contains(event.target)
    ) {
      callback(event)
    }
  }
  
  onMounted(() => {
    document.addEventListener('click', handleClick)
  })
  
  onUnmounted(() => {
    document.removeEventListener('click', handleClick)
  })
}
```

---

## 六、watch 和 watchEffect

### 6.1 watch

```vue
<script setup>
import { ref, watch } from 'vue'

const count = ref(0)
const name = ref('张三')

// 监听单个 ref
watch(count, (newValue, oldValue) => {
  console.log(`count 从 ${oldValue} 变为 ${newValue}`)
})

// 监听多个 ref
watch([count, name], ([newCount, newName], [oldCount, oldName]) => {
  console.log(`count: ${oldCount} -> ${newCount}`)
  console.log(`name: ${oldName} -> ${newName}`)
})

// 监听对象的某个属性
const user = ref({
  name: '张三',
  age: 25
})

watch(
  () => user.value.age,
  (newAge, oldAge) => {
    console.log(`age: ${oldAge} -> ${newAge}`)
  }
)

// 监听 reactive 对象
import { reactive } from 'vue'

const state = reactive({
  count: 0,
  name: '张三'
})

// 监听整个对象
watch(
  () => state,
  (newState, oldState) => {
    console.log('state changed')
  },
  { deep: true }
)

// 监听特定属性
watch(
  () => state.count,
  (newCount, oldCount) => {
    console.log(`count: ${oldCount} -> ${newCount}`)
  }
)

// 选项
watch(count, (newCount) => {
  console.log('count changed:', newCount)
}, {
  immediate: true, // 立即执行一次
  deep: true,      // 深度监听
  flush: 'post'    // 在 DOM 更新后执行
})

// 停止监听
const stop = watch(count, (newCount) => {
  console.log('count:', newCount)
})

// 调用 stop() 停止监听
</script>
```

### 6.2 watchEffect

```vue
<script setup>
import { ref, watchEffect } from 'vue'

const count = ref(0)
const name = ref('张三')

// 自动追踪依赖
watchEffect(() => {
  console.log(`count: ${count.value}, name: ${name.value}`)
})

// 停止监听
const stop = watchEffect(() => {
  console.log(count.value)
})

// 清理副作用
watchEffect((onCleanup) => {
  const timer = setInterval(() => {
    console.log('timer')
  }, 1000)
  
  onCleanup(() => {
    clearInterval(timer)
  })
})
</script>
```

### 6.3 watch vs watchEffect

```vue
<script setup>
import { ref, watch, watchEffect } from 'vue'

const count = ref(0)

// watchEffect - 自动追踪依赖,立即执行
watchEffect(() => {
  console.log(`count: ${count.value}`)
})

// watch - 显式指定依赖,惰性执行
watch(count, (newCount) => {
  console.log(`count changed to: ${newCount}`)
})

// 使用场景
// watchEffect: 当你需要自动追踪依赖时
// watch: 当你需要访问旧值或精确控制依赖时
</script>
```

**实践练习3**: 创建一个搜索组件,使用 watch 实现防抖

```vue
<template>
  <div>
    <input
      v-model="searchText"
      placeholder="搜索..."
    />
    <div v-if="loading">搜索中...</div>
    <div v-else>
      <p v-for="result in results" :key="result.id">
        {{ result.name }}
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'

const searchText = ref('')
const results = ref([])
const loading = ref(false)

let timeout = null

watch(searchText, (newValue) => {
  // 清除之前的定时器
  clearTimeout(timeout)
  
  if (!newValue.trim()) {
    results.value = []
    return
  }
  
  // 设置新的定时器(防抖)
  timeout = setTimeout(async () => {
    loading.value = true
    
    try {
      const response = await fetch(`/api/search?q=${newValue}`)
      results.value = await response.json()
    } catch (error) {
      console.error('搜索失败:', error)
    } finally {
      loading.value = false
    }
  }, 500)
})
</script>
```

---

## 七、模板引用

### 7.1 使用 ref 获取 DOM 元素

```vue
<template>
  <div>
    <input ref="inputRef" />
    <button @click="focusInput">聚焦</button>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const inputRef = ref(null)

const focusInput = () => {
  inputRef.value.focus()
}

onMounted(() => {
  inputRef.value.focus()
})
</script>
```

### 7.2 组件引用

```vue
<template>
  <div>
    <ChildComponent ref="childRef" />
    <button @click="callChildMethod">调用子组件方法</button>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import ChildComponent from './ChildComponent.vue'

const childRef = ref(null)

const callChildMethod = () => {
  childRef.value.someMethod()
}
</script>
```

```vue
<!-- ChildComponent.vue -->
<script setup>
const someMethod = () => {
  console.log('子组件方法被调用')
}

// 暴露给父组件
defineExpose({
  someMethod
})
</script>
```

### 7.3 v-for 中的 ref

```vue
<template>
  <div>
    <div
      v-for="item in list"
      :key="item.id"
      :ref="(el) => setItemRef(el, item.id)"
    >
      {{ item.name }}
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const list = ref([
  { id: 1, name: 'Item 1' },
  { id: 2, name: 'Item 2' },
  { id: 3, name: 'Item 3' }
])

const itemRefs = ref({})

const setItemRef = (el, id) => {
  if (el) {
    itemRefs.value[id] = el
  }
}
</script>
```

---

## 八、最佳实践

### 8.1 组合式函数命名规范

```javascript
// ✅ 好的命名:use 前缀
export function useMouse() { }
export function useCounter() { }
export function useFetch() { }

// ❌ 不好的命名
export function mouse() { }
export function getCounter() { }
export function createFetch() { }
```

### 8.2 组合式函数返回值

```javascript
// ✅ 返回响应式引用
export function useCounter() {
  const count = ref(0)
  const increment = () => count.value++
  
  return {
    count,
    increment
  }
}

// ✅ 返回只读的响应式对象
export function useMouse() {
  const x = ref(0)
  const y = ref(0)
  
  return {
    x,
    y
  }
}

// ✅ 返回函数用于操作
export function useToggle() {
  const value = ref(false)
  
  const toggle = () => value.value = !value.value
  
  return {
    value,
    toggle
  }
}
```

### 8.3 组合式函数的参数

```javascript
// ✅ 接受响应式值
export function useFetch(url) {
  // url 可以是 ref 或 reactive 的值
  // 使用 toValue 解包
  const data = ref(null)
  
  watchEffect(async () => {
    data.value = await fetch(toValue(url)).then(r => r.json())
  })
  
  return { data }
}

// 使用
const url = ref('/api/users')
const { data } = useFetch(url)

// 或者
const { data } = useFetch('/api/users')
```

### 8.4 避免在组合式函数中直接修改 props

```vue
<script setup>
// ❌ 不要这样做
export function useCounter(props) {
  const count = ref(props.initialValue)
  
  const increment = () => {
    count.value++
  }
  
  return { count, increment }
}

// ✅ 应该这样做
export function useCounter(initialValue) {
  const count = ref(initialValue)
  
  const increment = () => {
    count.value++
  }
  
  return { count, increment }
}

// 使用
const { count, increment } = useCounter(0)
</script>
```

---

## 九、实战案例

### 9.1 用户状态管理

```javascript
// composables/useAuth.js
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'

const user = ref(null)
const token = ref(localStorage.getItem('token'))
const loading = ref(false)

export function useAuth() {
  const router = useRouter()
  
  const isLoggedIn = computed(() => !!user.value && !!token.value)
  
  const login = async (credentials) => {
    loading.value = true
    
    try {
      const response = await fetch('/api/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(credentials)
      })
      
      const data = await response.json()
      
      user.value = data.user
      token.value = data.token
      localStorage.setItem('token', data.token)
      
      return data
    } finally {
      loading.value = false
    }
  }
  
  const logout = async () => {
    await fetch('/api/logout', { method: 'POST' })
    
    user.value = null
    token.value = null
    localStorage.removeItem('token')
    
    router.push('/login')
  }
  
  const fetchUser = async () => {
    if (!token.value) return
    
    try {
      const response = await fetch('/api/user', {
        headers: { 'Authorization': `Bearer ${token.value}` }
      })
      
      if (response.ok) {
        user.value = await response.json()
      }
    } catch (error) {
      console.error('获取用户失败:', error)
    }
  }
  
  return {
    user,
    token,
    loading,
    isLoggedIn,
    login,
    logout,
    fetchUser
  }
}
```

### 9.2 分页组件

```javascript
// composables/usePagination.js
import { ref, computed } from 'vue'

export function usePagination(fetchFn, pageSize = 10) {
  const items = ref([])
  const currentPage = ref(1)
  const totalItems = ref(0)
  const totalPages = ref(0)
  const loading = ref(false)
  const error = ref(null)
  
  const hasNextPage = computed(() => currentPage.value < totalPages.value)
  const hasPrevPage = computed(() => currentPage.value > 1)
  
  const fetchPage = async (page = 1) => {
    loading.value = true
    error.value = null
    
    try {
      const response = await fetchFn({
        page,
        pageSize
      })
      
      items.value = response.data
      totalItems.value = response.total
      totalPages.value = Math.ceil(response.total / pageSize)
      currentPage.value = page
    } catch (e) {
      error.value = e
    } finally {
      loading.value = false
    }
  }
  
  const nextPage = () => {
    if (hasNextPage.value) {
      fetchPage(currentPage.value + 1)
    }
  }
  
  const prevPage = () => {
    if (hasPrevPage.value) {
      fetchPage(currentPage.value - 1)
    }
  }
  
  const goToPage = (page) => {
    if (page >= 1 && page <= totalPages.value) {
      fetchPage(page)
    }
  }
  
  const refresh = () => {
    fetchPage(currentPage.value)
  }
  
  // 初始加载
  fetchPage(1)
  
  return {
    items,
    currentPage,
    totalItems,
    totalPages,
    loading,
    error,
    hasNextPage,
    hasPrevPage,
    nextPage,
    prevPage,
    goToPage,
    refresh
  }
}
```

---

## 总结

Composition API 是 Vue 3 的核心特性,掌握以下关键点:

1. **响应式系统**: 理解 ref 和 reactive 的区别和使用场景
2. **计算属性**: 合理使用 computed 进行性能优化
3. **生命周期**: 在正确的钩子中执行正确的操作
4. **组合式函数**: 封装和复用有状态逻辑
5. **watch/watchEffect**: 灵活监听和响应状态变化
6. **最佳实践**: 遵循命名和结构规范

通过 Composition API,可以编写出更清晰、更易维护的 Vue 应用。

## 扩展阅读

- [Vue.js 官方文档 - Composition API](https://cn.vuejs.org/guide/extras/composition-api-faq.html)
- [Vue.js 官方文档 - 响应式基础](https://cn.vuejs.org/guide/essentials/reactivity-fundamentals.html)
- [Vue.js 官方文档 - 组合式函数](https://cn.vuejs.org/guide/reusability/composables.html)
- [Vue.js 官方文档 - 生命周期](https://cn.vuejs.org/guide/essentials/lifecycle.html)
---
title: Vue Router路由管理
date: 2024-10-04 10:00:00
tags:
  - Vue.js
  - Vue Router
  - 路由
  - 导航守卫
categories: vue
cover: /images/cover_vue.png
---

# Vue Router 路由管理

## 一、Vue Router 基础

### 1.1 什么是 Vue Router

Vue Router 是 Vue.js 的官方路由管理器,它深度集成于 Vue.js 核心,让构建单页面应用变得轻而易举。主要功能包括:

- 嵌套路由映射
- 动态路由选择
- 模块化、基于组件的路由配置
- 导航控制
- HTML5 history 模式或 hash 模式

### 1.2 安装与配置

#### 安装

```bash
npm install vue-router@4
```

#### 基本配置

```javascript
// router/index.js
import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import About from '../views/About.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/about',
    name: 'About',
    component: About
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
```

```javascript
// main.js
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

const app = createApp(App)
app.use(router)
app.mount('#app')
```

```vue
<!-- App.vue -->
<template>
  <div id="app">
    <nav>
      <router-link to="/">首页</router-link> |
      <router-link to="/about">关于</router-link>
    </nav>
    <router-view />
  </div>
</template>
```

**实践练习1**: 搭建一个包含首页、产品列表和产品详情的基础路由系统

```javascript
// router/index.js
import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('../views/Home.vue'),
    meta: {
      title: '首页'
    }
  },
  {
    path: '/products',
    name: 'Products',
    component: () => import('../views/Products.vue'),
    meta: {
      title: '产品列表'
    }
  },
  {
    path: '/products/:id',
    name: 'ProductDetail',
    component: () => import('../views/ProductDetail.vue'),
    meta: {
      title: '产品详情'
    }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior(to, from, savedPosition) {
    // 滚动到顶部
    return { top: 0 }
  }
})

export default router
```

---

## 二、嵌套路由

### 2.1 基本嵌套路由

```javascript
// router/index.js
const routes = [
  {
    path: '/user/:id',
    component: User,
    children: [
      {
        // 当 /user/:id/profile 匹配成功
        path: 'profile',
        component: UserProfile
      },
      {
        // 当 /user/:id/posts 匹配成功
        path: 'posts',
        component: UserPosts
      }
    ]
  }
]
```

```vue
<!-- User.vue -->
<template>
  <div class="user">
    <h2>用户中心</h2>
    <router-view />
  </div>
</template>
```

### 2.2 多级嵌套

```javascript
const routes = [
  {
    path: '/admin',
    component: Admin,
    children: [
      {
        path: 'dashboard',
        component: Dashboard
      },
      {
        path: 'users',
        component: UserManagement,
        children: [
          {
            path: 'list',
            component: UserList
          },
          {
            path: 'create',
            component: CreateUser
          },
          {
            path: 'edit/:id',
            component: EditUser
          }
        ]
      },
      {
        path: 'settings',
        component: Settings
      }
    ]
  }
]
```

```vue
<!-- Admin.vue -->
<template>
  <div class="admin-layout">
    <aside class="sidebar">
      <nav>
        <router-link to="/admin/dashboard">仪表盘</router-link>
        <router-link to="/admin/users/list">用户管理</router-link>
        <router-link to="/admin/settings">系统设置</router-link>
      </nav>
    </aside>
    <main class="content">
      <router-view />
    </main>
  </div>
</template>

<style scoped>
.admin-layout {
  display: flex;
  height: 100vh;
}

.sidebar {
  width: 200px;
  background: #f5f5f5;
  padding: 20px;
}

.content {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
}
</style>
```

**实践练习2**: 创建一个电商后台管理系统路由结构

```javascript
// router/admin.js
const adminRoutes = [
  {
    path: '/admin',
    component: () => import('../views/admin/Layout.vue'),
    redirect: '/admin/dashboard',
    meta: { requiresAuth: true },
    children: [
      {
        path: 'dashboard',
        name: 'AdminDashboard',
        component: () => import('../views/admin/Dashboard.vue'),
        meta: { title: '仪表盘', icon: 'dashboard' }
      },
      {
        path: 'orders',
        name: 'Orders',
        component: () => import('../views/admin/Orders.vue'),
        meta: { title: '订单管理', icon: 'orders' },
        children: [
          {
            path: 'list',
            name: 'OrderList',
            component: () => import('../views/admin/orders/OrderList.vue')
          },
          {
            path: 'detail/:orderId',
            name: 'OrderDetail',
            component: () => import('../views/admin/orders/OrderDetail.vue')
          }
        ]
      },
      {
        path: 'products',
        name: 'Products',
        component: { render: () => h('router-view') },
        meta: { title: '商品管理', icon: 'products' },
        redirect: '/admin/products/list',
        children: [
          {
            path: 'list',
            name: 'ProductList',
            component: () => import('../views/admin/products/ProductList.vue')
          },
          {
            path: 'create',
            name: 'CreateProduct',
            component: () => import('../views/admin/products/ProductForm.vue')
          },
          {
            path: 'edit/:id',
            name: 'EditProduct',
            component: () => import('../views/admin/products/ProductForm.vue')
          },
          {
            path: 'categories',
            name: 'ProductCategories',
            component: () => import('../views/admin/products/Categories.vue')
          }
        ]
      },
      {
        path: 'users',
        name: 'Users',
        component: () => import('../views/admin/Users.vue'),
        meta: { title: '用户管理', icon: 'users' }
      },
      {
        path: 'settings',
        name: 'Settings',
        component: () => import('../views/admin/Settings.vue'),
        meta: { title: '系统设置', icon: 'settings' }
      }
    ]
  }
]
```

---

## 三、动态路由

### 3.1 动态路由参数

```javascript
const routes = [
  {
    path: '/user/:id',
    component: User
  },
  {
    path: '/user/:id/posts/:postId?',
    component: UserPost
  }
]
```

```vue
<!-- User.vue -->
<script>
export default {
  created() {
    // 获取路由参数
    console.log(this.$route.params.id)
    
    // 监听路由参数变化
    this.$watch(
      () => this.$route.params.id,
      (newId, oldId) => {
        this.loadUser(newId)
      }
    )
  },
  methods: {
    loadUser(id) {
      // 加载用户数据
    }
  }
}
</script>
```

### 3.2 捕获所有路由

```javascript
const routes = [
  // 匹配所有路径
  {
    path: '/:pathMatch(.*)*',
    component: NotFound
  },
  
  // 匹配以 `/user-` 开头的所有路径
  {
    path: '/user-:afterUser(.*)',
    redirect: (to) => {
      return { path: '/user/' + to.params.afterUser }
    }
  }
]
```

### 3.3 路由参数验证

```javascript
const routes = [
  {
    path: '/users/:id',
    component: UserDetail,
    props: true,
    beforeEnter: (to) => {
      // 验证 id 是否为数字
      if (!/^\d+$/.test(to.params.id)) {
        return false // 拒绝导航
      }
    }
  }
]
```

**实践练习3**: 创建一个博客文章路由,支持多种参数格式

```javascript
const routes = [
  {
    path: '/blog',
    component: BlogLayout,
    children: [
      {
        path: '',
        name: 'BlogList',
        component: () => import('../views/blog/BlogList.vue')
      },
      {
        // 支持多种格式: /blog/123 或 //blog/my-article-slug
        path: ':idOrSlug',
        name: 'BlogDetail',
        component: () => import('../views/blog/BlogDetail.vue'),
        props: (route) => ({
          id: /^\d+$/.test(route.params.idOrSlug) 
            ? parseInt(route.params.idOrSlug) 
            : null,
          slug: /^\d+$/.test(route.params.idOrSlug) 
            ? null 
            : route.params.idOrSlug
        })
      },
      {
        path: 'category/:category',
        name: 'BlogCategory',
        component: () => import('../views/blog/BlogList.vue'),
        props: true
      },
      {
        path: 'tag/:tag',
        name: 'BlogTag',
        component: () => import('../views/blog/BlogList.vue'),
        props: true
      }
    ]
  }
]
```

---

## 四、编程式导航

### 4.1 router.push()

```vue
<script>
export default {
  methods: {
    navigateToUser(id) {
      // 字符串路径
      this.$router.push('/users/' + id)
      
      // 对象形式
      this.$router.push({ path: '/users/' + id })
      
      // 命名路由
      this.$router.push({ name: 'User', params: { id } })
      
      // 带查询参数
      this.$router.push({ 
        path: '/search', 
        query: { q: 'vue' } 
      })
      
      // 带哈希
      this.$router.push({ 
        path: '/users', 
        hash: '#section1' 
      })
    }
  }
}
</script>
```

### 4.2 router.replace()

不会向 history 添加新记录:

```vue
<script>
export default {
  methods: {
    replaceRoute() {
      this.$router.replace({ name: 'Home' })
      
      // 或者在 router-link 上使用
      // <router-link to="/" replace>
    }
  }
}
</script>
```

### 4.3 router.go()

```vue
<script>
export default {
  methods: {
    goBack() {
      this.$router.go(-1) // 后退一页
    },
    goForward() {
      this.$router.go(1) // 前进一页
    }
  }
}
</script>
```

**实践练习4**: 创建一个搜索页面,实现搜索历史记录功能

```vue
<!-- Search.vue -->
<template>
  <div class="search-page">
    <div class="search-box">
      <input
        v-model="keyword"
        @keyup.enter="search"
        placeholder="搜索..."
      />
      <button @click="search">搜索</button>
    </div>
    
    <div class="search-history">
      <h3>搜索历史</h3>
      <ul>
        <li v-for="(item, index) in searchHistory" :key="index">
          <a @click="searchFromHistory(item)">{{ item }}</a>
          <button @click="removeHistory(index)">×</button>
        </li>
      </ul>
      <button v-if="searchHistory.length" @click="clearHistory">
        清空历史
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Search',
  data() {
    return {
      keyword: '',
      searchHistory: []
    }
  },
  
  created() {
    // 从路由参数恢复搜索关键词
    if (this.$route.query.q) {
      this.keyword = this.$route.query.q
      this.loadSearchResults()
    }
    
    // 从 localStorage 加载搜索历史
    const history = localStorage.getItem('searchHistory')
    if (history) {
      this.searchHistory = JSON.parse(history)
    }
  },
  
  methods: {
    search() {
      if (!this.keyword.trim()) return
      
      // 添加到搜索历史
      this.addToHistory(this.keyword)
      
      // 使用 replace 避免产生过多历史记录
      this.$router.replace({
        path: '/search',
        query: { q: this.keyword }
      })
      
      this.loadSearchResults()
    },
    
    searchFromHistory(keyword) {
      this.keyword = keyword
      this.$router.push({
        path: '/search',
        query: { q: keyword }
      })
      this.loadSearchResults()
    },
    
    addToHistory(keyword) {
      // 移除重复项
      this.searchHistory = this.searchHistory.filter(k => k !== keyword)
      // 添加到开头
      this.searchHistory.unshift(keyword)
      // 限制最多 10 条
      if (this.searchHistory.length > 10) {
        this.searchHistory.pop()
      }
      // 保存到 localStorage
      localStorage.setItem('searchHistory', JSON.stringify(this.searchHistory))
    },
    
    removeHistory(index) {
      this.searchHistory.splice(index, 1)
      localStorage.setItem('searchHistory', JSON.stringify(this.searchHistory))
    },
    
    clearHistory() {
      this.searchHistory = []
      localStorage.removeItem('searchHistory')
    },
    
    loadSearchResults() {
      // 加载搜索结果
      console.log('搜索:', this.keyword)
    }
  }
}
</script>
```

---

## 五、导航守卫

### 5.1 全局前置守卫

```javascript
// router/index.js
import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '../stores/auth'

const router = createRouter({
  history: createWebHistory(),
  routes
})

// 全局前置守卫
router.beforeEach((to, from) => {
  // 设置页面标题
  document.title = to.meta.title || 'Vue App'
  
  const authStore = useAuthStore()
  
  // 需要登录的页面
  if (to.meta.requiresAuth && !authStore.isLoggedIn) {
    // 保存目标路由,登录后重定向
    return {
      path: '/login',
      query: { redirect: to.fullPath }
    }
  }
  
  // 已登录用户访问登录页
  if (to.path === '/login' && authStore.isLoggedIn) {
    return { path: '/' }
  }
  
  // 允许导航
  return true
})

export default router
```

### 5.2 全局后置钩子

```javascript
router.afterEach((to, from) => {
  // 发送页面浏览统计
  analytics.logPageView(to.fullPath)
  
  // 滚动到页面顶部
  window.scrollTo(0, 0)
})
```

### 5.3 路由独享守卫

```javascript
const routes = [
  {
    path: '/admin',
    component: Admin,
    beforeEnter: (to, from) => {
      const authStore = useAuthStore()
      
      // 检查管理员权限
      if (!authStore.isAdmin) {
        return { path: '/403' }
      }
      
      return true
    }
  }
]
```

### 5.4 组件内守卫

```vue
<script>
export default {
  data() {
    return {
      user: null,
      saved: true // 是否已保存
    }
  },
  
  async beforeRouteEnter(to, from, next) {
    // 在渲染该组件的对应路由被验证前调用
    // 此时组件实例还没被创建,无法访问 this
    const user = await fetchUser(to.params.id)
    next(vm => {
      // 通过回调访问组件实例
      vm.user = user
    })
  },
  
  beforeRouteUpdate(to, from) {
    // 在当前路由改变,但是该组件被复用时调用
    // 例如从 /users/1 到 /users/2
    this.loadUser(to.params.id)
  },
  
  beforeRouteLeave(to, from) {
    // 导航离开该组件的对应路由时调用
    if (!this.saved) {
      const answer = window.confirm(
        '数据未保存,确定要离开吗?'
      )
      if (!answer) return false
    }
  },
  
  methods: {
    async loadUser(id) {
      this.user = await fetchUser(id)
    }
  }
}
</script>
```

**实践练习5**: 实现一个完整的权限控制系统

```javascript
// router/permissions.js
import { useAuthStore } from '@/stores/auth'

// 权限检查函数
function checkPermission(to) {
  const authStore = useAuthStore()
  const { requiresAuth, roles, permissions } = to.meta
  
  // 不需要登录
  if (!requiresAuth) {
    return true
  }
  
  // 未登录
  if (!authStore.isLoggedIn) {
    return {
      path: '/login',
      query: { redirect: to.fullPath }
    }
  }
  
  // 检查角色
  if (roles && !roles.some(role => authStore.user.roles.includes(role))) {
    return { path: '/403' }
  }
  
  // 检查权限
  if (permissions && !permissions.some(p => authStore.hasPermission(p))) {
    return { path: '/403' }
  }
  
  return true
}

// 设置路由守卫
export function setupRouterGuards(router) {
  // 全局前置守卫
  router.beforeEach(async (to, from) => {
    // 显示加载状态
    const loadingStore = useLoadingStore()
    loadingStore.show()
    
    // 检查权限
    return checkPermission(to)
  })
  
  // 全局后置钩子
  router.afterEach((to, from) => {
    // 隐藏加载状态
    const loadingStore = useLoadingStore()
    loadingStore.hide()
    
    // 设置页面标题
    if (to.meta.title) {
      document.title = `${to.meta.title} - Vue Admin`
    }
    
    // 页面统计
    trackPageView(to)
  })
  
  // 错误处理
  router.onError((error) => {
    console.error('路由错误:', error)
    // 跳转到错误页面
    router.push('/error')
  })
}
```

```javascript
// router/index.js
import { createRouter, createWebHistory } from 'vue-router'
import { setupRouterGuards } from './permissions'

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/Login.vue'),
    meta: { title: '登录' }
  },
  {
    path: '/',
    component: () => import('@/layouts/MainLayout.vue'),
    meta: { requiresAuth: true },
    children: [
      {
        path: '',
        name: 'Dashboard',
        component: () => import('@/views/Dashboard.vue'),
        meta: { title: '仪表盘' }
      },
      {
        path: 'users',
        name: 'Users',
        component: () => import('@/views/Users.vue'),
        meta: { 
          title: '用户管理',
          requiresAuth: true,
          roles: ['admin'],
          permissions: ['user:view']
        }
      },
      {
        path: 'settings',
        name: 'Settings',
        component: () => import('@/views/Settings.vue'),
        meta: { 
          title: '系统设置',
          requiresAuth: true,
          roles: ['admin', 'manager']
        }
      }
    ]
  },
  {
    path: '/403',
    name: 'Forbidden',
    component: () => import('@/views/errors/Forbidden.vue'),
    meta: { title: '无权限' }
  },
  {
    path: '/:pathMatch(.*)*',
    name: 'NotFound',
    component: () => import('@/views/errors/NotFound.vue'),
    meta: { title: '页面未找到' }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// 设置路由守卫
setupRouterGuards(router)

export default router
```

---

## 六、命名视图与路由

### 6.1 命名视图

```vue
<!-- Layout.vue -->
<template>
  <div class="layout">
    <router-view name="header" />
    <router-view name="sidebar" />
    <router-view />
    <router-view name="footer" />
  </div>
</template>
```

```javascript
const routes = [
  {
    path: '/',
    components: {
      default: Home,
      header: Header,
      sidebar: Sidebar,
      footer: Footer
    }
  }
]
```

### 6.2 路由元信息

```javascript
const routes = [
  {
    path: '/admin',
    component: Admin,
    meta: {
      requiresAuth: true,
      title: '管理员面板',
      roles: ['admin'],
      breadcrumb: [
        { title: '首页', path: '/' },
        { title: '管理员面板' }
      ]
    }
  }
]
```

```vue
<script>
export default {
  computed: {
    routeMeta() {
      return this.$route.meta
    }
  }
}
</script>
```

### 6.3 路由懒加载

```javascript
const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import(/* webpackChunkName: "home" */ '../views/Home.vue')
  },
  {
    path: '/about',
    name: 'About',
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  },
  {
    path: '/admin',
    component: () => import(/* webpackChunkName: "admin" */ '../views/admin/Layout.vue'),
    children: [
      {
        path: 'dashboard',
        component: () => import(/* webpackChunkName: "admin" */ '../views/admin/Dashboard.vue')
      }
    ]
  }
]
```

---

## 七、路由过渡效果

### 7.1 基本过渡

```vue
<template>
  <router-view v-slot="{ Component }">
    <transition name="fade" mode="out-in">
      <component :is="Component" />
    </transition>
  </router-view>
</template>

<style>
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s ease;
}
.fade-enter-from, .fade-leave-to {
  opacity: 0;
}
</style>
```

### 7.2 基于路由的动态过渡

```vue
<template>
  <router-view v-slot="{ Component, route }">
    <transition :name="route.meta.transition || 'fade'" mode="out-in">
      <component :is="Component" :key="route.path" />
    </transition>
  </router-view>
</template>

<style>
.slide-left-enter-active,
.slide-left-leave-active,
.slide-right-enter-active,
.slide-right-leave-active {
  transition: transform 0.3s ease;
}

.slide-left-enter-from {
  transform: translateX(100%);
}

.slide-left-leave-to {
  transform: translateX(-100%);
}

.slide-right-enter-from {
  transform: translateX(-100%);
}

.slide-right-leave-to {
  transform: translateX(100%);
}
</style>
```

---

## 八、实战案例:电商应用路由配置

```javascript
// router/shop.js
import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    component: () => import('@/layouts/ShopLayout.vue'),
    children: [
      {
        path: '',
        name: 'Home',
        component: () => import('@/views/shop/Home.vue'),
        meta: { title: '首页' }
      },
      {
        path: 'products',
        name: 'ProductList',
        component: () => import('@/views/shop/ProductList.vue'),
        meta: { title: '商品列表' }
      },
      {
        path: 'product/:id',
        name: 'ProductDetail',
        component: () => import('@/views/shop/ProductDetail.vue'),
        meta: { title: '商品详情' },
        props: true
      },
      {
        path: 'cart',
        name: 'Cart',
        component: () => import('@/views/shop/Cart.vue'),
        meta: { title: '购物车' }
      },
      {
        path: 'checkout',
        name: 'Checkout',
        component: () => import('@/views/shop/Checkout.vue'),
        meta: { 
          title: '结算',
          requiresAuth: true
        }
      },
      {
        path: 'user',
        component: () => import('@/layouts/UserLayout.vue'),
        meta: { requiresAuth: true },
        children: [
          {
            path: 'profile',
            name: 'UserProfile',
            component: () => import('@/views/user/Profile.vue'),
            meta: { title: '个人中心' }
          },
          {
            path: 'orders',
            name: 'UserOrders',
            component: () => import('@/views/user/Orders.vue'),
            meta: { title: '我的订单' }
          },
          {
            path: 'order/:orderId',
            name: 'OrderDetail',
            component: () => import('@/views/user/OrderDetail.vue'),
            meta: { title: '订单详情' },
            props: true
          },
          {
            path: 'favorites',
            name: 'Favorites',
            component: () => import('@/views/user/Favorites.vue'),
            meta: { title: '我的收藏' }
          }
        ]
      }
    ]
  },
  
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/auth/Login.vue'),
    meta: { title: '登录' }
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('@/views/auth/Register.vue'),
    meta: { title: '注册' }
  },
  
  {
    path: '/:pathMatch(.*)*',
    name: 'NotFound',
    component: () => import('@/views/errors/NotFound.vue'),
    meta: { title: '页面未找到' }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else if (to.hash) {
      return { el: to.hash, behavior: 'smooth' }
    } else {
      return { top: 0, behavior: 'smooth' }
    }
  }
})

export default router
```

---

## 总结

Vue Router 是构建单页面应用的基石,掌握以下关键点:

1. **路由配置**: 理解路由的基本配置和路由模式
2. **嵌套路由**: 实现复杂的应用路由结构
3. **动态路由**: 灵活处理路由参数
4. **编程式导航**: 在代码中控制路由跳转
5. **导航守卫**: 实现权限控制和路由拦截

通过合理使用 Vue Router,可以构建出流畅、安全的单页面应用。

## 扩展阅读

- [Vue Router 官方文档](https://router.vuejs.org/zh/)
- [Vue Router 动态路由匹配](https://router.vuejs.org/zh/guide/essentials/dynamic-matching.html)
- [Vue Router 导航守卫](https://router.vuejs.org/zh/guide/advanced/navigation-guards.html)
- [Vue Router 路由懒加载](https://router.vuejs.org/zh/guide/advanced/lazy-loading.html)
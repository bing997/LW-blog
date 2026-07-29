---
title: Vue.js网络请求Axios
date: 2024-10-07 10:00:00
tags:
  - Vue.js
  - Axios
  - HTTP请求
  - 拦截器
  - Token
categories: vue
cover: /images/cover_vue.png
---

# Vue.js 网络请求 Axios

## 一、Axios 简介

### 1.1 什么是 Axios

Axios 是一个基于 Promise 的 HTTP 客户端,可以用于浏览器和 Node.js。它具有以下特点:

- 支持 Promise API
- 拦截请求和响应
- 转换请求数据和响应数据
- 取消请求
- 自动转换 JSON 数据
- 客户端支持防御 XSRF

### 1.2 安装 Axios

```bash
npm install axios
# 或
yarn add axios
# 或
pnpm add axios
```

---

## 二、Axios 基本配置

### 2.1 创建 Axios 实例

```javascript
// utils/request.js
import axios from 'axios'

// 创建 axios 实例
const service = axios.create({
  baseURL: process.env.VUE_APP_BASE_API || 'http://localhost:3000/api',
  timeout: 10000, // 请求超时时间
  headers: {
    'Content-Type': 'application/json;charset=UTF-8'
  }
})

export default service
```

### 2.2 配置项详解

```javascript
// 完整配置示例
const instance = axios.create({
  // 基础 URL
  baseURL: 'https://api.example.com',
  
  // 请求超时时间(毫秒)
  timeout: 10000,
  
  // 自定义请求头
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer token'
  },
  
  // 响应数据格式
  responseType: 'json', // 'arraybuffer', 'blob', 'document', 'json', 'text', 'stream'
  
  // 响应编码
  responseEncoding: 'utf8',
  
  // 是否携带 Cookie
  withCredentials: false,
  
  // 请求参数序列化
  paramsSerializer: function(params) {
    return Qs.stringify(params, { arrayFormat: 'brackets' })
  },
  
  // 上传进度
  onUploadProgress: function(progressEvent) {
    const percentCompleted = Math.round(
      (progressEvent.loaded * 100) / progressEvent.total
    )
    console.log(`上传进度: ${percentCompleted}%`)
  },
  
  // 下载进度
  onDownloadProgress: function(progressEvent) {
    const percentCompleted = Math.round(
      (progressEvent.loaded * 100) / progressEvent.total
    )
    console.log(`下载进度: ${percentCompleted}%`)
  }
})
```

---

## 三、请求拦截器

### 3.1 请求拦截器

```javascript
// utils/request.js
import axios from 'axios'
import { useUserStore } from '@/stores/user'

const service = axios.create({
  baseURL: process.env.VUE_APP_BASE_API,
  timeout: 10000
})

// 请求拦截器
service.interceptors.request.use(
  config => {
    const userStore = useUserStore()
    
    // 添加 token 到请求头
    if (userStore.token) {
      config.headers['Authorization'] = `Bearer ${userStore.token}`
    }
    
    // 添加请求时间戳(防止缓存)
    if (config.method === 'get') {
      config.params = {
        ...config.params,
        _t: Date.now()
      }
    }
    
    console.log('Request:', config)
    return config
  },
  error => {
    console.error('Request Error:', error)
    return Promise.reject(error)
  }
)

export default service
```

### 3.2 响应拦截器

```javascript
// utils/request.js

// 响应拦截器
service.interceptors.response.use(
  response => {
    const res = response.data
    
    // 根据业务状态码处理
    if (res.code !== 200) {
      console.error('Response Error:', res.message || 'Error')
      
      // 处理特定错误码
      if (res.code === 401) {
        // Token 过期
        const userStore = useUserStore()
        userStore.logout()
        location.reload()
      }
      
      return Promise.reject(new Error(res.message || 'Error'))
    }
    
    return res
  },
  error => {
    console.error('Response Error:', error)
    
    // 处理 HTTP 状态码错误
    if (error.response) {
      const status = error.response.status
      
      switch (status) {
        case 400:
          error.message = '请求错误'
          break
        case 401:
          error.message = '未授权,请登录'
          // 跳转到登录页
          router.push('/login')
          break
        case 403:
          error.message = '拒绝访问'
          break
        case 404:
          error.message = '请求地址不存在'
          break
        case 408:
          error.message = '请求超时'
          break
        case 500:
          error.message = '服务器内部错误'
          break
        case 501:
          error.message = '服务未实现'
          break
        case 502:
          error.message = '网关错误'
          break
        case 503:
          error.message = '服务不可用'
          break
        case 504:
          error.message = '网关超时'
          break
        case 505:
          error.message = 'HTTP版本不受支持'
          break
        default:
          error.message = `连接错误 ${status}`
      }
    } else if (error.request) {
      error.message = '服务器未响应'
    } else {
      error.message = '请求配置错误'
    }
    
    return Promise.reject(error)
  }
)
```

---

## 四、API 模块化

### 4.1 组织 API 文件

```
src/
  api/
    index.js       # 统一导出
    user.js        # 用户相关 API
    product.js     # 商品相关 API
    order.js       # 订单相关 API
```

### 4.2 封装 API 方法

```javascript
// api/user.js
import request from '@/utils/request'

// 用户登录
export function login(data) {
  return request({
    url: '/auth/login',
    method: 'post',
    data
  })
}

// 用户注册
export function register(data) {
  return request({
    url: '/auth/register',
    method: 'post',
    data
  })
}

// 获取用户信息
export function getUserInfo() {
  return request({
    url: '/user/info',
    method: 'get'
  })
}

// 更新用户信息
export function updateUserInfo(data) {
  return request({
    url: '/user/info',
    method: 'put',
    data
  })
}

// 上传头像
export function uploadAvatar(file) {
  const formData = new FormData()
  formData.append('avatar', file)
  
  return request({
    url: '/user/avatar',
    method: 'post',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}
```

```javascript
// api/product.js
import request from '@/utils/request'

// 获取商品列表
export function getProducts(params) {
  return request({
    url: '/products',
    method: 'get',
    params
  })
}

// 获取商品详情
export function getProductDetail(id) {
  return request({
    url: `/products/${id}`,
    method: 'get'
  })
}

// 搜索商品
export function searchProducts(keyword) {
  return request({
    url: '/products/search',
    method: 'get',
    params: { keyword }
  })
}

// 获取商品分类
export function getCategories() {
  return request({
    url: '/products/categories',
    method: 'get'
  })
}
```

```javascript
// api/index.js
export * from './user'
export * from './product'
export * from './order'
```

---

## 五、在组件中使用

### 5.1 基本使用

```vue
<template>
  <div>
    <div v-if="loading">加载中...</div>
    <div v-else-if="error">{{ error }}</div>
    <div v-else>
      <div v-for="product in products" :key="product.id">
        {{ product.name }} - ¥{{ product.price }}
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import { getProducts } from '@/api/product'

export default {
  setup() {
    const products = ref([])
    const loading = ref(false)
    const error = ref(null)
    
    const loadProducts = async () => {
      loading.value = true
      error.value = null
      
      try {
        const response = await getProducts({
          page: 1,
          limit: 10
        })
        products.value = response.data
      } catch (e) {
        error.value = e.message
      } finally {
        loading.value = false
      }
    }
    
    onMounted(() => {
      loadProducts()
    })
    
    return {
      products,
      loading,
      error
    }
  }
}
</script>
```

### 5.2 使用 async/await

```vue
<script>
import { getProducts, getProductDetail } from '@/api/product'

export default {
  async setup() {
    // 并行请求
    const [productsRes, categoriesRes] = await Promise.all([
      getProducts({ page: 1 }),
      getCategories()
    ])
    
    return {
      products: productsRes.data,
      categories: categoriesRes.data
    }
  }
}
</script>
```

**实践练习1**: 创建一个完整的 API 请求封装

```javascript
// utils/request.js
import axios from 'axios'
import { ElMessage } from 'element-plus'
import { useUserStore } from '@/stores/user'
import router from '@/router'

// 是否正在刷新 token
let isRefreshing = false
// 重试请求队列
let retryQueue = []

// 创建 axios 实例
const service = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL,
  timeout: 30000,
  headers: {
    'Content-Type': 'application/json;charset=UTF-8'
  }
})

// 请求拦截器
service.interceptors.request.use(
  config => {
    const userStore = useUserStore()
    
    // 添加 token
    if (userStore.token) {
      config.headers['Authorization'] = `Bearer ${userStore.token}`
    }
    
    // 添加设备信息
    config.headers['X-Device-Type'] = navigator.userAgent
    
    return config
  },
  error => {
    console.error('Request error:', error)
    return Promise.reject(error)
  }
)

// 响应拦截器
service.interceptors.response.use(
  response => {
    const res = response.data
    
    // 二进制数据直接返回
    if (response.config.responseType === 'blob') {
      return response
    }
    
    // 业务错误处理
    if (res.code && res.code !== 200) {
      // Token 过期
      if (res.code === 401) {
        return handleTokenExpired(response.config)
      }
      
      // 其他错误
      ElMessage.error(res.message || '请求失败')
      return Promise.reject(new Error(res.message || '请求失败'))
    }
    
    return res
  },
  async error => {
    const { response, config } = error
    
    if (!response) {
      ElMessage.error('网络连接失败,请检查网络')
      return Promise.reject(error)
    }
    
    const { status } = response
    
    // Token 过期
    if (status === 401) {
      return handleTokenExpired(config)
    }
    
    // 其他 HTTP 错误
    const errorMessage = getErrorMessage(status)
    ElMessage.error(errorMessage)
    
    return Promise.reject(error)
  }
)

// 处理 Token 过期
async function handleTokenExpired(config) {
  const userStore = useUserStore()
  
  // 如果正在刷新 token,将请求加入队列
  if (isRefreshing) {
    return new Promise((resolve) => {
      retryQueue.push(() => {
        resolve(service(config))
      })
    })
  }
  
  isRefreshing = true
  
  try {
    // 刷新 token
    const refreshToken = userStore.refreshToken
    const response = await axios.post('/auth/refresh', {
      refreshToken
    })
    
    const { token, refreshToken: newRefreshToken } = response.data
    
    // 更新 token
    userStore.setToken(token, newRefreshToken)
    
    // 重试队列中的请求
    retryQueue.forEach(callback => callback())
    retryQueue = []
    
    // 重试当前请求
    return service(config)
  } catch (error) {
    // 刷新失败,退出登录
    userStore.logout()
    router.push('/login')
    return Promise.reject(error)
  } finally {
    isRefreshing = false
  }
}

// 获取错误消息
function getErrorMessage(status) {
  const messages = {
    400: '请求参数错误',
    401: '未授权,请重新登录',
    403: '拒绝访问',
    404: '请求资源不存在',
    405: '请求方法不允许',
    408: '请求超时',
    500: '服务器内部错误',
    502: '网关错误',
    503: '服务不可用',
    504: '网关超时'
  }
  
  return messages[status] || `请求失败 (${status})`
}

export default service
```

---

## 六、高级功能

### 6.1 请求取消

```javascript
// utils/request.js

// 存储所有请求
const pendingRequests = new Map()

// 生成请求 key
function generateRequestKey(config) {
  const { method, url, params, data } = config
  return [method, url, JSON.stringify(params), JSON.stringify(data)].join('&')
}

// 添加请求到 Map
function addPendingRequest(config) {
  const requestKey = generateRequestKey(config)
  
  if (pendingRequests.has(requestKey)) {
    // 取消之前的请求
    const cancel = pendingRequests.get(requestKey)
    cancel && cancel('取消重复请求')
  }
  
  config.cancelToken = new axios.CancelToken(cancel => {
    pendingRequests.set(requestKey, cancel)
  })
}

// 移除请求
function removePendingRequest(config) {
  const requestKey = generateRequestKey(config)
  
  if (pendingRequests.has(requestKey)) {
    pendingRequests.delete(requestKey)
  }
}

// 请求拦截器
service.interceptors.request.use(
  config => {
    // 取消重复请求
    addPendingRequest(config)
    
    // ... 其他逻辑
    
    return config
  }
)

// 响应拦截器
service.interceptors.response.use(
  response => {
    // 移除请求
    removePendingRequest(response.config)
    
    return response
  },
  error => {
    // 移除请求
    if (error.config) {
      removePendingRequest(error.config)
    }
    
    return Promise.reject(error)
  }
)

// 取消所有请求
export function cancelAllRequests() {
  pendingRequests.forEach(cancel => {
    cancel && cancel('取消所有请求')
  })
  pendingRequests.clear()
}
```

### 6.2 请求重试

```javascript
// utils/request.js

// 重试配置
const retryConfig = {
  retries: 3, // 重试次数
  retryDelay: 1000, // 重试延迟
  retryCondition: (error) => {
    // 重试条件
    return !error.response || error.response.status >= 500
  }
}

// 响应拦截器
service.interceptors.response.use(
  response => response,
  async error => {
    const { config } = error
    
    // 如果没有配置重试,直接返回错误
    if (!config || !config.retries) {
      return Promise.reject(error)
    }
    
    // 设置重试次数
    config.__retryCount = config.__retryCount || 0
    
    // 检查是否可以重试
    if (config.__retryCount >= config.retries) {
      return Promise.reject(error)
    }
    
    // 检查重试条件
    if (!retryConfig.retryCondition(error)) {
      return Promise.reject(error)
    }
    
    config.__retryCount += 1
    
    // 延迟重试
    await new Promise(resolve => {
      setTimeout(resolve, config.retryDelay || retryConfig.retryDelay)
    })
    
    // 重新发起请求
    return service(config)
  }
)
```

### 6.3 数据缓存

```javascript
// utils/cache.js
class RequestCache {
  constructor(maxAge = 5 * 60 * 1000) { // 默认缓存 5 分钟
    this.cache = new Map()
    this.maxAge = maxAge
  }
  
  get(key) {
    const item = this.cache.get(key)
    
    if (!item) return null
    
    // 检查是否过期
    if (Date.now() - item.timestamp > this.maxAge) {
      this.cache.delete(key)
      return null
    }
    
    return item.data
  }
  
  set(key, data) {
    this.cache.set(key, {
      data,
      timestamp: Date.now()
    })
  }
  
  clear() {
    this.cache.clear()
  }
  
  delete(key) {
    this.cache.delete(key)
  }
}

export const requestCache = new RequestCache()
```

```javascript
// api/product.js
import request from '@/utils/request'
import { requestCache } from '@/utils/cache'

export function getProducts(params) {
  const cacheKey = `products_${JSON.stringify(params)}`
  
  // 检查缓存
  const cachedData = requestCache.get(cacheKey)
  if (cachedData) {
    return Promise.resolve(cachedData)
  }
  
  return request({
    url: '/products',
    method: 'get',
    params
  }).then(response => {
    // 设置缓存
    requestCache.set(cacheKey, response)
    return response
  })
}
```

---

## 七、文件上传下载

### 7.1 文件上传

```javascript
// api/upload.js
import request from '@/utils/request'

// 上传单个文件
export function uploadFile(file, onProgress) {
  const formData = new FormData()
  formData.append('file', file)
  
  return request({
    url: '/upload',
    method: 'post',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data'
    },
    onUploadProgress: (progressEvent) => {
      if (onProgress) {
        const percent = Math.round(
          (progressEvent.loaded * 100) / progressEvent.total
        )
        onProgress(percent)
      }
    }
  })
}

// 上传多个文件
export function uploadFiles(files, onProgress) {
  const formData = new FormData()
  
  files.forEach(file => {
    formData.append('files', file)
  })
  
  return request({
    url: '/upload/multiple',
    method: 'post',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data'
    },
    onUploadProgress: (progressEvent) => {
      if (onProgress) {
        const percent = Math.round(
          (progressEvent.loaded * 100) / progressEvent.total
        )
        onProgress(percent)
      }
    }
  })
}

// 分片上传
export async function uploadChunk(file, chunkSize = 5 * 1024 * 1024) {
  const chunks = Math.ceil(file.size / chunkSize)
  const fileId = Date.now()
  
  for (let i = 0; i < chunks; i++) {
    const start = i * chunkSize
    const end = Math.min(file.size, start + chunkSize)
    const chunk = file.slice(start, end)
    
    const formData = new FormData()
    formData.append('file', chunk)
    formData.append('fileId', fileId)
    formData.append('chunkIndex', i)
    formData.append('chunkTotal', chunks)
    formData.append('fileName', file.name)
    
    await request({
      url: '/upload/chunk',
      method: 'post',
      data: formData,
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })
  }
  
  // 合并分片
  return request({
    url: '/upload/merge',
    method: 'post',
    data: {
      fileId,
      fileName: file.name,
      chunkTotal: chunks
    }
  })
}
```

```vue
<!-- FileUpload.vue -->
<template>
  <div class="file-upload">
    <input
      ref="fileInput"
      type="file"
      @change="handleFileChange"
      multiple
    />
    
    <div v-if="uploadProgress > 0">
      上传进度: {{ uploadProgress }}%
      <div class="progress-bar">
        <div 
          class="progress" 
          :style="{ width: uploadProgress + '%' }"
        ></div>
      </div>
    </div>
    
    <div v-if="uploadedFiles.length">
      已上传文件:
      <ul>
        <li v-for="file in uploadedFiles" :key="file.name">
          {{ file.name }}
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'
import { uploadFiles } from '@/api/upload'

export default {
  setup() {
    const fileInput = ref(null)
    const uploadProgress = ref(0)
    const uploadedFiles = ref([])
    
    const handleFileChange = async (event) => {
      const files = event.target.files
      
      if (!files.length) return
      
      uploadProgress.value = 0
      
      try {
        const response = await uploadFiles(files, (percent) => {
          uploadProgress.value = percent
        })
        
        uploadedFiles.value = response.data
        
        console.log('上传成功')
      } catch (error) {
        console.error('上传失败:', error)
      }
    }
    
    return {
      fileInput,
      uploadProgress,
      uploadedFiles,
      handleFileChange
    }
  }
}
</script>
```

### 7.2 文件下载

```javascript
// api/download.js
import request from '@/utils/request'

// 下载文件
export function downloadFile(url, filename) {
  return request({
    url,
    method: 'get',
    responseType: 'blob'
  }).then(response => {
    const blob = new Blob([response.data])
    const link = document.createElement('a')
    link.href = URL.createObjectURL(blob)
    link.download = filename
    link.click()
    URL.revokeObjectURL(link.href)
  })
}

// 下载文件(带进度)
export function downloadFileWithProgress(url, filename, onProgress) {
  return request({
    url,
    method: 'get',
    responseType: 'blob',
    onDownloadProgress: (progressEvent) => {
      if (onProgress) {
        const percent = Math.round(
          (progressEvent.loaded * 100) / progressEvent.total
        )
        onProgress(percent)
      }
    }
  }).then(response => {
    const blob = new Blob([response.data])
    const link = document.createElement('a')
    link.href = URL.createObjectURL(blob)
    link.download = filename
    link.click()
    URL.revokeObjectURL(link.href)
  })
}
```

---

## 八、最佳实践

### 8.1 错误处理

```javascript
// utils/errorHandler.js
export class ApiError extends Error {
  constructor(message, code, data) {
    super(message)
    this.name = 'ApiError'
    this.code = code
    this.data = data
  }
}

export function handleApiError(error) {
  // 网络错误
  if (!error.response) {
    return new ApiError('网络连接失败', 'NETWORK_ERROR')
  }
  
  // 服务器错误
  const { status, data } = error.response
  
  switch (status) {
    case 400:
      return new ApiError('请求参数错误', 'BAD_REQUEST', data)
    case 401:
      return new ApiError('未授权访问', 'UNAUTHORIZED', data)
    case 403:
      return new ApiError('拒绝访问', 'FORBIDDEN', data)
    case 404:
      return new ApiError('资源不存在', 'NOT_FOUND', data)
    case 500:
      return new ApiError('服务器错误', 'SERVER_ERROR', data)
    default:
      return new ApiError('未知错误', 'UNKNOWN_ERROR', data)
  }
}
```

### 8.2 Loading 管理

```javascript
// composables/useRequest.js
import { ref } from 'vue'

export function useRequest(requestFn) {
  const loading = ref(false)
  const error = ref(null)
  const data = ref(null)
  
  const execute = async (...args) => {
    loading.value = true
    error.value = null
    
    try {
      const result = await requestFn(...args)
      data.value = result
      return result
    } catch (e) {
      error.value = e
      throw e
    } finally {
      loading.value = false
    }
  }
  
  return {
    loading,
    error,
    data,
    execute
  }
}
```

```vue
<template>
  <div>
    <button @click="loadData" :disabled="loading">
      {{ loading ? '加载中...' : '加载数据' }}
    </button>
    
    <div v-if="error">{{ error.message }}</div>
    <div v-else-if="data">
      {{ data }}
    </div>
  </div>
</template>

<script>
import { useRequest } from '@/composables/useRequest'
import { getProducts } from '@/api/product'

export default {
  setup() {
    const { loading, error, data, execute } = useRequest(getProducts)
    
    const loadData = () => {
      execute({ page: 1, limit: 10 })
    }
    
    return {
      loading,
      error,
      data,
      loadData
    }
  }
}
</script>
```

---

## 总结

Axios 是 Vue.js 项目中最常用的 HTTP 客户端,掌握以下关键点:

1. **拦截器**: 统一处理请求和响应
2. **错误处理**: 友好的错误提示和处理
3. **Token 刷新**: 实现无感刷新 Token
4. **请求取消**: 避免重复请求
5. **文件处理**: 上传和下载文件
6. **性能优化**: 缓存、重试等策略

通过合理使用 Axios,可以构建出稳定、高效的网络请求层。

## 扩展阅读

- [Axios 官方文档](https://axios-http.com/zh/docs/intro)
- [Axios 中文文档](https://www.axios-http.cn/)
- [Axios GitHub](https://github.com/axios/axios)
- [HTTP 状态码](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Status)
import axios from 'axios'
import { Message } from 'element-ui'
import { getToken, removeToken } from './auth'
import { generateSign } from './sign'
import router from '@/router'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'

// 创建axios实例
const service = axios.create({
  baseURL: process.env.VUE_APP_BASE_API,
  timeout: Number(process.env.VUE_APP_TIMEOUT) || 10000
})

// 请求拦截器
service.interceptors.request.use(
  config => {
    // 显示进度条
    NProgress.start()

    // 生成签名
    const signInfo = generateSign(config.data)
    config.headers.appId = signInfo.appId
    config.headers.time = signInfo.time
    config.headers.guid = signInfo.guid
    config.headers.sign = signInfo.sign

    // 添加Token
    const token = getToken()
    if (token) {
      config.headers.Authorization = 'Bearer ' + token
    }

    return config
  },
  error => {
    console.error('Request Error:', error)
    NProgress.done()
    return Promise.reject(error)
  }
)

// 响应拦截器
service.interceptors.response.use(
  response => {
    NProgress.done()

    const res = response.data

    // 如果Success为false，说明业务逻辑错误
    if (res.Success === false) {
      Message({
        message: res.Msg || '请求失败',
        type: 'error',
        duration: 3000
      })
      return Promise.reject(new Error(res.Msg || '请求失败'))
    }

    return res
  },
  error => {
    NProgress.done()

    let message = '网络错误'

    if (error.response) {
      const { status } = error.response

      switch (status) {
        case 400:
          message = '请求参数错误'
          break
        case 401:
          message = '未授权，请重新登录'
          removeToken()
          router.push('/login')
          break
        case 403:
          message = '拒绝访问'
          break
        case 404:
          message = '请求资源不存在'
          break
        case 500:
          message = '服务器内部错误'
          break
        case 502:
          message = '网关错误'
          break
        case 503:
          message = '服务不可用'
          break
        default:
          message = `请求错误: ${status}`
      }
    } else if (error.message) {
      if (error.message.includes('timeout')) {
        message = '请求超时'
      } else if (error.message.includes('Network Error')) {
        message = '网络连接失败'
      }
    }

    Message({
      message,
      type: 'error',
      duration: 3000
    })

    return Promise.reject(error)
  }
)

export default service

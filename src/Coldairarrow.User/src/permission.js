import router from './router'
import store from './store'
import { Message } from 'element-ui'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import { getToken } from '@/utils/auth'

NProgress.configure({ showSpinner: false })

// 白名单：不需要登录即可访问的路由
const whiteList = ['/', '/articles', '/article', '/category', '/archive', '/about', '/login', '/register', '/404']

router.beforeEach(async (to, from, next) => {
  NProgress.start()

  // 设置页面标题
  const title = to.meta.title || process.env.VUE_APP_TITLE
  document.title = `${title} - ${process.env.VUE_APP_TITLE}`

  const hasToken = getToken()

  if (hasToken) {
    // 已登录
    if (to.path === '/login' || to.path === '/register') {
      // 已登录，访问登录/注册页，重定向到首页
      next({ path: '/' })
      NProgress.done()
    } else {
      // 检查是否已获取用户信息
      const hasUserInfo = store.getters.userInfo

      if (hasUserInfo) {
        next()
      } else {
        try {
          // 获取用户信息
          await store.dispatch('user/getUserInfo')
          next()
        } catch (error) {
          // 获取用户信息失败，清除Token并跳转登录
          await store.dispatch('user/logout')
          Message.error('获取用户信息失败，请重新登录')
          next(`/login?redirect=${to.path}`)
          NProgress.done()
        }
      }
    }
  } else {
    // 未登录
    // 检查路由是否在白名单或者是白名单路径的子路径
    const isWhitelisted = whiteList.some(path => {
      if (path === to.path) return true
      if (to.path.startsWith(path + '/')) return true
      return false
    })

    if (isWhitelisted || !to.meta.requiresAuth) {
      next()
    } else {
      // 需要登录，跳转到登录页
      next(`/login?redirect=${to.path}`)
      NProgress.done()
    }
  }
})
router.afterEach(() => {
  NProgress.done()
})

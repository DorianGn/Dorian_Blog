import Vue from 'vue'
import VueRouter from 'vue-router'
import DefaultLayout from '@/layouts/DefaultLayout.vue'
import { getToken } from '@/utils/auth'

Vue.use(VueRouter)

const originalPush = VueRouter.prototype.push
const originalReplace = VueRouter.prototype.replace

VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => {
    if (err.name === 'NavigationDuplicated' ||
        err.name === 'NavigationCancelled' ||
        err.name === 'NavigationRedirected') {
      return err
    }
    throw err
  })
}

VueRouter.prototype.replace = function replace(location) {
  return originalReplace.call(this, location).catch(err => {
    if (err.name === 'NavigationDuplicated' ||
        err.name === 'NavigationCancelled' ||
        err.name === 'NavigationRedirected') {
      return err
    }
    throw err
  })
}

const routes = [
  {
    path: '/',
    component: DefaultLayout,
    children: [
      {
        path: '',
        name: 'Home',
        component: () => import('@/views/Home/Index.vue'),
        meta: { title: '首页' }
      },
      {
        path: 'articles',
        name: 'ArticleList',
        component: () => import('@/views/Article/List.vue'),
        meta: { title: '文章' }
      },
      {
        path: 'article/:id',
        name: 'ArticleDetail',
        component: () => import('@/views/Article/Detail.vue'),
        meta: { title: '文章详情' }
      },
      {
        path: 'about',
        name: 'About',
        component: () => import('@/views/About/Index.vue'),
        meta: { title: '关于' }
      },
      {
        path: 'archive',
        name: 'Archive',
        component: () => import('@/views/Archive/Index.vue'),
        meta: { title: '归档' }
      },
      {
        path: 'profile',
        name: 'Profile',
        component: () => import('@/views/User/Profile.vue'),
        meta: { title: '个人中心', requiresAuth: true }
      }
    ]
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/User/Login.vue'),
    meta: { title: '登录' }
  },
  {
    path: '/register',
    redirect: to => {
      return { path: '/login', query: { mode: 'register' } }
    }
  },
  {
    path: '/404',
    name: 'NotFound',
    component: () => import('@/views/Error/404.vue'),
    meta: { title: '404' }
  },
  {
    path: '*',
    redirect: '/404'
  }
]

const router = new VueRouter({
  mode: 'hash',
  base: process.env.BASE_URL,
  routes,
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { x: 0, y: 0 }
    }
  }
})

// 路由守卫
router.beforeEach((to, from, next) => {
  document.title = to.meta.title || '我的博客'

  if (to.meta.requiresAuth) {
    const token = getToken()
    if (!token) {
      next({
        path: '/login',
        query: { redirect: to.fullPath }
      })
    } else {
      next()
    }
  } else {
    next()
  }
})

export default router

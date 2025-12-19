import Vue from 'vue'
import VueRouter from 'vue-router'
import DefaultLayout from '@/layouts/DefaultLayout.vue'

Vue.use(VueRouter)

const originalPush = VueRouter.prototype.push
const originalReplace = VueRouter.prototype.replace

VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => {
    if (err.name !== 'NavigationDuplicated') throw err
  })
}

VueRouter.prototype.replace = function replace(location) {
  return originalReplace.call(this, location).catch(err => {
    if (err.name !== 'NavigationDuplicated') throw err
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
      }
      // 注意：如果要添加更多路由，在上面的 } 后面加逗号，例如：
      // {
      //   path: 'articles',
      //   name: 'ArticleList',
      //   component: () => import('@/views/Article/List.vue'),
      //   meta: { title: '文章列表' }
      // }
    ] // ← children 数组闭合，不能注释
  }, // ← 第一个路由对象闭合，不能注释
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
  // {
  //   path: '/profile',
  //   name: 'Profile',
  //   component: () => import('@/views/User/Profile.vue'),
  //   meta: { title: '个人中心', requiresAuth: true }
  // },
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
    const token = localStorage.getItem('token')
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

// eslint-disable-next-line
import { UserLayout, PageView } from '@/layouts'

/**
 * 基础路由
 * @type { *[] }
 */
export const constantRouterMap = [
  {
    path: '/Home/Login',
    name: 'Login',
    component: () => import('@/views/Home/Login'),
    hidden: true
  },
  {
    path:'/personalSpace',
    name:'personalSpace',
    component:() => import('@/components/tools/PersonalSpace.vue'),
    hidden:true
  },
  {
    path: '/404',
    component: () => import('@/views/exception/404')
  }
]

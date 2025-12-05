import { login, getUserInfo } from '@/api/user'
import { setToken, getToken, removeToken } from '@/utils/auth'

const state = {
  token: getToken(),
  userInfo: null,
  isLogin: !!getToken()
}

const mutations = {
  SET_TOKEN (state, token) {
    state.token = token
    state.isLogin = !!token
  },
  SET_USER_INFO (state, userInfo) {
    state.userInfo = userInfo
  },
  LOGOUT (state) {
    state.token = ''
    state.userInfo = null
    state.isLogin = false
  }
}

const actions = {
  // 登录
  async login ({ commit }, loginForm) {
    const res = await login(loginForm)
    if (res.Success) {
      const token = res.Data
      commit('SET_TOKEN', token)
      setToken(token)
      return true
    } else {
      throw new Error(res.Msg)
    }
  },

  // 获取用户信息
  async getUserInfo ({ commit }) {
    const res = await getUserInfo()
    if (res.Success) {
      commit('SET_USER_INFO', res.Data)
      return res.Data
    } else {
      throw new Error(res.Msg)
    }
  },

  // 登出
  logout ({ commit }) {
    commit('LOGOUT')
    removeToken()
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

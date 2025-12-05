import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import user from './modules/user'
import app from './modules/app'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    user,
    app
  },
  plugins: [
    createPersistedState({
      storage: window.localStorage,
      paths: ['user.token', 'user.userInfo']
    })
  ],
  getters: {
    token: state => state.user.token,
    isLogin: state => state.user.isLogin,
    userInfo: state => state.user.userInfo,
    sidebar: state => state.app.sidebar,
    device: state => state.app.device
  }
})

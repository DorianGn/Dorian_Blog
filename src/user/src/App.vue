<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'App',
  computed: {
    ...mapGetters(['isLogin', 'userInfo'])
  },
  created() {
    // 如果已登录但没有用户信息，获取用户信息
    if (this.isLogin && !this.userInfo) {
      this.$store.dispatch('user/getUserInfo').catch(() => {
        // 获取失败（可能 token 过期），退出登录
        this.$store.dispatch('user/logout')
      })
    }
  }
}
</script>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
</style>

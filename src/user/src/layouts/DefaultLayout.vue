<template>
  <div class="default-layout">
    <!-- 顶部导航 -->
    <app-header />

    <!-- 主要内容 -->
    <main class="main-content">
      <router-view />
    </main>

    <!-- 底部 -->
    <app-footer />

    <!-- 返回顶部 -->
    <el-backtop :bottom="50" :right="50" />
  </div>
</template>

<script>
import AppHeader from './Header.vue'
import AppFooter from './Footer.vue'

export default {
  name: 'DefaultLayout',
  components: {
    AppHeader,
    AppFooter
  }
}
</script>

<style lang="scss" scoped>
.default-layout {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.main-content {
  flex: 1;
  min-height: calc(100vh - 120px);
}
</style>

<template>
  <div class="error-page">
    <div class="error-content">
      <h1 class="error-code">404</h1>
      <h2 class="error-title">页面未找到</h2>
      <p class="error-message">抱歉，您访问的页面不存在</p>
      <el-button type="primary" @click="goHome">返回首页</el-button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'NotFound',
  methods: {
    goHome () {
      this.$router.push('/')
    }
  }
}
</script>

<style lang="scss" scoped>
.error-page {
  min-height: calc(100vh - 120px);
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f5f7fa;
}

.error-content {
  text-align: center;

  .error-code {
    font-size: 120px;
    font-weight: bold;
    color: #409eff;
    margin-bottom: 20px;
  }

  .error-title {
    font-size: 32px;
    color: #333;
    margin-bottom: 15px;
  }

  .error-message {
    font-size: 16px;
    color: #666;
    margin-bottom: 30px;
  }
}
</style>

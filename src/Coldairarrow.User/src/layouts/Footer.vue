<template>
  <footer class="app-footer">
    <div class="container">
      <div class="footer-content">
        <p class="copyright">
          © 2024 {{ appTitle }}. All Rights Reserved.
        </p>
        <div class="footer-links">
          <a href="#">隐私政策</a>
          <span>|</span>
          <a href="#">使用条款</a>
          <span>|</span>
          <a href="#">联系我们</a>
        </div>
      </div>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'AppFooter',
  data () {
    return {
      appTitle: process.env.VUE_APP_TITLE
    }
  }
}
</script>

<style lang="scss" scoped>
.app-footer {
  background: #2c3e50;
  color: #fff;
  padding: 30px 0;
  margin-top: 50px;

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 15px;
  }

  .footer-content {
    text-align: center;

    .copyright {
      margin-bottom: 10px;
      font-size: 14px;
      opacity: 0.8;
    }

    .footer-links {
      font-size: 13px;
      opacity: 0.7;

      a {
        color: #fff;
        text-decoration: none;
        margin: 0 10px;

        &:hover {
          text-decoration: underline;
        }
      }

      span {
        margin: 0 5px;
      }
    }
  }
}
</style>

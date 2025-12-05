<template>
  <header class="app-header">
    <div class="container">
      <div class="header-content">
        <!-- Logo -->
        <div class="logo" @click="goHome">
          <i class="el-icon-reading"></i>
          <span>{{ appTitle }}</span>
        </div>

        <!-- 导航菜单 -->
        <nav class="nav-menu">
          <router-link to="/" class="nav-item" exact>首页</router-link>
          <router-link to="/articles" class="nav-item">文章</router-link>
          <router-link to="/archive" class="nav-item">归档</router-link>
          <router-link to="/about" class="nav-item">关于</router-link>
        </nav>

        <!-- 搜索框 -->
        <div class="search-box">
          <el-input v-model="searchKeyword" placeholder="搜索文章..." prefix-icon="el-icon-search" size="small"
            @keyup.enter.native="handleSearch">
          </el-input>
        </div>

        <!-- 用户菜单 -->
        <div class="user-menu">
          <template v-if="isLogin">
            <el-dropdown @command="handleCommand">
              <span class="user-info">
                <el-avatar :size="32" :src="userInfo.Avatar">
                  {{ userInfo.UserName ? userInfo.UserName[0] : 'U' }}
                </el-avatar>
                <span class="username">{{ userInfo.UserName }}</span>
              </span>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item command="profile">
                  <i class="el-icon-user"></i> 个人中心
                </el-dropdown-item>
                <el-dropdown-item command="logout" divided>
                  <i class="el-icon-switch-button"></i> 退出登录
                </el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </template>
          <template v-else>
            <el-button size="small" @click="goLogin">登录</el-button>
            <el-button type="primary" size="small" @click="goRegister">注册</el-button>
          </template>
        </div>
      </div>
    </div>
  </header>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'AppHeader',
  data () {
    return {
      searchKeyword: '',
      appTitle: process.env.VUE_APP_TITLE
    }
  },
  computed: {
    ...mapGetters(['isLogin', 'userInfo'])
  },
  methods: {
    goHome () {
      this.$router.push('/')
    },
    goLogin () {
      this.$router.push('/login')
    },
    goRegister () {
      this.$router.push('/register')
    },
    handleSearch () {
      if (this.searchKeyword.trim()) {
        this.$router.push({
          path: '/articles',
          query: { keyword: this.searchKeyword }
        })
      }
    },
    handleCommand (command) {
      if (command === 'profile') {
        this.$router.push('/profile')
      } else if (command === 'logout') {
        this.$confirm('确定要退出登录吗?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$store.dispatch('user/logout')
          this.$message.success('已退出登录')
          this.$router.push('/')
        }).catch(() => { })
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.app-header {
  background: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  z-index: 100;

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 15px;
  }

  .header-content {
    height: 60px;
    display: flex;
    align-items: center;
    gap: 30px;
  }

  .logo {
    font-size: 20px;
    font-weight: bold;
    color: #409eff;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 8px;

    i {
      font-size: 24px;
    }
  }

  .nav-menu {
    display: flex;
    gap: 20px;

    .nav-item {
      color: #333;
      text-decoration: none;
      font-size: 15px;
      padding: 5px 10px;
      border-radius: 4px;
      transition: all 0.3s;

      &:hover {
        color: #409eff;
        background: #ecf5ff;
      }

      &.router-link-active {
        color: #409eff;
        font-weight: 500;
      }
    }
  }

  .search-box {
    flex: 1;
    max-width: 300px;
  }

  .user-menu {
    display: flex;
    gap: 10px;
    align-items: center;

    .user-info {
      display: flex;
      align-items: center;
      gap: 8px;
      cursor: pointer;

      .username {
        font-size: 14px;
        color: #333;
      }
    }
  }
}

@media (max-width: 768px) {
  .app-header {
    .header-content {
      gap: 15px;
    }

    .nav-menu {
      display: none;
    }

    .search-box {
      max-width: 150px;
    }
  }
}
</style>

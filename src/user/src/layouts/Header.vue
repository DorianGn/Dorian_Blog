<template>
  <header class="app-header">
    <div class="header-content">
      <!-- Logo -->
      <div class="logo-section">
        <div class="logo" @click="goHome">
          <div class="logo-icon-wrapper">
            <svg class="globe-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="1.5"/>
              <ellipse cx="12" cy="12" rx="4" ry="10" stroke="currentColor" stroke-width="1.5"/>
              <path d="M2 12h20" stroke="currentColor" stroke-width="1.5"/>
              <path d="M4 7h16M4 17h16" stroke="currentColor" stroke-width="1.5"/>
            </svg>
          </div>
          <div class="logo-text">
            <span class="site-name">OnlyBlog</span>
            <p class="tagline">分享技术、记录生活</p>
          </div>
        </div>
      </div>

      <!-- 导航菜单 - 居中 -->
      <nav class="nav-menu">
        <router-link to="/" class="nav-item" exact>
          <svg class="nav-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2V9z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M9 22V12h6v10" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
          <span>首页</span>
        </router-link>
        <router-link to="/articles" class="nav-item">
          <svg class="nav-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8l-6-6z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M14 2v6h6M16 13H8M16 17H8M10 9H8" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
          <span>技术文章</span>
        </router-link>
        <router-link to="/archive" class="nav-item">
          <svg class="nav-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <rect x="3" y="3" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.5"/>
            <rect x="14" y="3" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.5"/>
            <rect x="3" y="14" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.5"/>
            <rect x="14" y="14" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.5"/>
          </svg>
          <span>项目展示</span>
        </router-link>
        <router-link to="/about" class="nav-item">
          <svg class="nav-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M14.7 6.3a1 1 0 000 1.4l1.6 1.6a1 1 0 001.4 0l3.77-3.77a6 6 0 01-7.94 7.94l-6.91 6.91a2.12 2.12 0 01-3-3l6.91-6.91a6 6 0 017.94-7.94l-3.76 3.76z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
          <span>工具推荐</span>
        </router-link>
      </nav>

      <!-- 右侧区域 -->
      <div class="header-right">
        <!-- 搜索框 -->
        <div class="search-box">
          <div class="search-input-wrapper">
            <svg class="search-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <circle cx="11" cy="11" r="8" stroke="currentColor" stroke-width="1.5"/>
              <path d="M21 21l-4.35-4.35" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
            </svg>
            <input
              v-model="searchKeyword"
              type="text"
              placeholder="搜索文章..."
              @keyup.enter="handleSearch"
            />
          </div>
        </div>

        <!-- 用户菜单 -->
        <div class="user-menu">
          <template v-if="isLogin && userInfo">
            <el-dropdown @command="handleCommand">
              <div class="user-info">
                <div class="user-avatar">
                  <el-avatar :size="32" :src="userInfo.Avatar">
                    {{ avatarText }}
                  </el-avatar>
                </div>
                <span class="username">{{ userInfo.RealName || userInfo.UserName }}</span>
                <svg class="arrow-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M6 9l6 6 6-6" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
              </div>
              <el-dropdown-menu slot="dropdown" class="user-dropdown">
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
            <button class="login-btn" @click="goLogin">登录</button>
            <button class="register-btn" @click="goRegister">注册</button>
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
      appTitle: process.env.VUE_APP_TITLE || 'Blog'
    }
  },
  computed: {
    ...mapGetters(['isLogin', 'userInfo']),
    avatarText() {
      if (!this.userInfo) return 'U'
      return (this.userInfo.RealName || this.userInfo.UserName || 'U').charAt(0).toUpperCase()
    }
  },
  methods: {
    goHome () {
      this.$router.push('/')
    },
    goLogin () {
      this.$router.push('/login')
    },
    goRegister () {
      this.$router.push({ path: '/login', query: { mode: 'register' } })
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
// 样式变量
$primary-color: #5b6ee1;
$text-primary: #333333;
$text-secondary: #555555;
$text-muted: #999999;
$border-color: #e8e8e8;

.app-header {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
  background: #ffffff;
  border-bottom: 1px solid $border-color;

  .header-content {
    max-width: 1400px;
    margin: 0 auto;
    padding: 0 40px;
    height: 72px;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
}

// Logo 区域
.logo-section {
  flex: 1;

  .logo {
    display: inline-flex;
    align-items: center;
    gap: 14px;
    cursor: pointer;
    transition: opacity 0.3s;

    &:hover {
      opacity: 0.8;
    }

    .logo-icon-wrapper {
      width: 40px;
      height: 40px;
      display: flex;
      align-items: center;
      justify-content: center;

      .globe-icon {
        width: 36px;
        height: 36px;
        color: $primary-color;
      }
    }

    .logo-text {
      .site-name {
        font-size: 22px;
        font-weight: 700;
        color: $text-primary;
        display: block;
        line-height: 1.2;
      }

      .tagline {
        font-size: 12px;
        color: $text-muted;
        margin: 4px 0 0 0;
      }
    }
  }
}

// 导航菜单 - 居中
.nav-menu {
  display: flex;
  align-items: center;
  gap: 8px;

  .nav-item {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 10px 22px;
    color: $text-secondary;
    text-decoration: none;
    font-size: 15px;
    font-weight: 500;
    border-radius: 8px;
    transition: all 0.25s ease;

    .nav-icon {
      width: 18px;
      height: 18px;
      flex-shrink: 0;
    }

    &:hover {
      color: $primary-color;
    }

    &.router-link-active,
    &.router-link-exact-active {
      color: $primary-color;
      font-weight: 600;
    }
  }
}

// 右侧区域
.header-right {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 20px;
}

// 搜索框
.search-box {
  .search-input-wrapper {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 8px 16px;
    background: #f5f5f5;
    border: 1px solid transparent;
    border-radius: 20px;
    transition: all 0.3s;

    &:focus-within {
      background: #ffffff;
      border-color: $primary-color;
      box-shadow: 0 0 0 3px rgba(91, 110, 225, 0.1);
    }

    .search-icon {
      width: 16px;
      height: 16px;
      color: $text-muted;
      flex-shrink: 0;
    }

    input {
      width: 140px;
      border: none;
      background: transparent;
      outline: none;
      font-size: 14px;
      color: $text-primary;

      &::placeholder {
        color: $text-muted;
      }
    }
  }
}

// 用户菜单
.user-menu {
  display: flex;
  align-items: center;
  gap: 12px;

  .user-info {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 6px 12px 6px 6px;
    background: #f5f5f5;
    border: 1px solid transparent;
    border-radius: 24px;
    cursor: pointer;
    transition: all 0.3s;

    &:hover {
      background: #eeeeee;
    }

    .user-avatar {
      ::v-deep .el-avatar {
        background: $primary-color;
        font-weight: 600;
        font-size: 14px;
      }
    }

    .username {
      font-size: 14px;
      font-weight: 500;
      color: $text-primary;
      max-width: 100px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .arrow-icon {
      width: 14px;
      height: 14px;
      color: $text-muted;
      transition: transform 0.3s;
    }
  }

  .login-btn,
  .register-btn {
    padding: 8px 20px;
    font-size: 14px;
    font-weight: 500;
    border-radius: 20px;
    cursor: pointer;
    transition: all 0.3s;
  }

  .login-btn {
    background: #f5f5f5;
    border: 1px solid $border-color;
    color: $text-secondary;

    &:hover {
      background: #eeeeee;
      color: $primary-color;
      border-color: $primary-color;
    }
  }

  .register-btn {
    background: $primary-color;
    border: none;
    color: white;

    &:hover {
      background: darken($primary-color, 8%);
      transform: translateY(-1px);
      box-shadow: 0 4px 12px rgba(91, 110, 225, 0.4);
    }
  }
}

// 响应式设计
@media (max-width: 1200px) {
  .app-header .header-content {
    padding: 0 24px;
  }

  .nav-menu .nav-item {
    padding: 10px 16px;
  }

  .search-box .search-input-wrapper input {
    width: 120px;
  }
}

@media (max-width: 1024px) {
  .nav-menu {
    gap: 4px;

    .nav-item {
      padding: 10px 12px;

      span {
        display: none;
      }

      .nav-icon {
        width: 20px;
        height: 20px;
      }
    }
  }

  .search-box .search-input-wrapper input {
    width: 100px;
  }
}

@media (max-width: 768px) {
  .app-header .header-content {
    height: 60px;
    padding: 0 16px;
  }

  .logo-section .logo {
    .logo-icon-wrapper {
      width: 36px;
      height: 36px;

      .globe-icon {
        width: 32px;
        height: 32px;
      }
    }

    .logo-text {
      .site-name {
        font-size: 18px;
      }

      .tagline {
        display: none;
      }
    }
  }

  .nav-menu {
    gap: 2px;

    .nav-item {
      padding: 8px 10px;
    }
  }

  .search-box {
    display: none;
  }

  .user-menu {
    .username {
      display: none;
    }

    .login-btn,
    .register-btn {
      padding: 6px 14px;
      font-size: 13px;
    }
  }
}
</style>

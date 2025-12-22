<template>
  <div class="about-container">
    <!-- 背景动态效果 -->
    <div class="background-animation">
      <div class="background-image"></div>
      <div class="particles-container">
        <div class="particle" v-for="(particle, index) in particles" :key="index" :style="particle.style">
        </div>
      </div>
      <div class="floating-shapes">
        <div class="shape shape-1"></div>
        <div class="shape shape-2"></div>
        <div class="shape shape-3"></div>
        <div class="shape shape-4"></div>
        <div class="shape shape-5"></div>
      </div>
    </div>

    <!-- 主要内容区域 -->
    <main class="main-content">
      <!-- Hero 区域 -->
      <section class="hero-section">
        <div class="hero-content">
          <div class="hero-text">
            <h1 class="hero-title">
              <span class="title-line">关于</span>
              <span class="title-line accent">我</span>
            </h1>
            <p class="hero-subtitle">
              探索技术，热爱生活，记录成长的点滴
            </p>

            <!-- 社交链接 -->
            <div class="hero-actions">
              <a href="https://github.com/DorianGn" target="_blank" class="primary-btn">
                <svg class="btn-icon" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M12 0C5.37 0 0 5.37 0 12c0 5.31 3.435 9.795 8.205 11.385.6.105.825-.255.825-.57 0-.285-.015-1.23-.015-2.235-3.015.555-3.795-.735-4.035-1.41-.135-.345-.72-1.41-1.23-1.695-.42-.225-1.02-.78-.015-.795.945-.015 1.62.87 1.845 1.23 1.08 1.815 2.805 1.305 3.495.99.105-.78.42-1.305.765-1.605-2.67-.3-5.46-1.335-5.46-5.925 0-1.305.465-2.385 1.23-3.225-.12-.3-.54-1.53.12-3.18 0 0 1.005-.315 3.3 1.23.96-.27 1.98-.405 3-.405s2.04.135 3 .405c2.295-1.56 3.3-1.23 3.3-1.23.66 1.65.24 2.88.12 3.18.765.84 1.23 1.905 1.23 3.225 0 4.605-2.805 5.625-5.475 5.925.435.375.81 1.095.81 2.22 0 1.605-.015 2.895-.015 3.3 0 .315.225.69.825.57A12.02 12.02 0 0024 12c0-6.63-5.37-12-12-12z"/>
                </svg>
                <span>GitHub</span>
              </a>
              <a href="mailto:zhansfai@163.com" class="secondary-btn">
                <svg class="btn-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                  <polyline points="22,6 12,13 2,6"/>
                </svg>
                <span>联系我</span>
              </a>
            </div>
          </div>

          <!-- 右侧头像装饰 -->
          <div class="hero-visual">
            <div class="avatar-container">
              <div class="avatar-ring"></div>
              <div class="avatar-wrapper">
                <img src="@/assets/images/tou.jpg" alt="avatar" @error="handleAvatarError">
                <div class="avatar-fallback" v-if="avatarError">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                    <circle cx="12" cy="8" r="4"/>
                    <path d="M4 20c0-4 4-6 8-6s8 2 8 6"/>
                  </svg>
                </div>
              </div>
              <span class="orbit-icon icon-a">◇</span>
              <span class="orbit-icon icon-b">○</span>
              <span class="orbit-icon icon-c">☆</span>
              <span class="orbit-icon icon-d">△</span>
            </div>
          </div>
        </div>
      </section>

      <!-- 个人简介卡片 -->
      <section class="profile-section">
        <div class="profile-card glass-card">
          <div class="profile-header">
            <h2 class="profile-name">{{ siteName }}</h2>
            <p class="profile-title">全栈开发者 / 技术爱好者</p>
          </div>
          <div class="profile-bio">
            <p>热爱技术，专注于 Web 开发领域。喜欢探索新技术，分享学习心得。</p>
            <p>本站记录着我在技术学习和生活中的点滴感悟，希望能与你一起成长。</p>
          </div>
        </div>
      </section>

      <!-- 内容网格 -->
      <div class="content-grid">
        <!-- 左侧内容 -->
        <div class="left-content">
          <!-- 关于本站 -->
          <section class="info-card glass-card">
            <div class="card-header">
              <svg class="header-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="12" cy="12" r="10"/>
                <path d="M12 16v-4M12 8h.01"/>
              </svg>
              <h3>关于本站</h3>
            </div>
            <div class="card-content">
              <p>欢迎来到我的个人博客！这里记录着我在技术学习和生活中的点滴感悟。</p>
              <ul class="feature-list">
                <li>
                  <span class="feature-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8l-6-6z"/>
                      <path d="M14 2v6h6M16 13H8M16 17H8M10 9H8"/>
                    </svg>
                  </span>
                  技术文章与学习笔记
                </li>
                <li>
                  <span class="feature-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/>
                    </svg>
                  </span>
                  项目开发经验总结
                </li>
                <li>
                  <span class="feature-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <path d="M20.84 4.61a5.5 5.5 0 00-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 00-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 000-7.78z"/>
                    </svg>
                  </span>
                  生活感悟与随笔
                </li>
              </ul>
            </div>
          </section>

          <!-- 技术栈 -->
          <section class="info-card glass-card">
            <div class="card-header">
              <svg class="header-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="16 18 22 12 16 6"/>
                <polyline points="8 6 2 12 8 18"/>
              </svg>
              <h3>技术栈</h3>
            </div>
            <div class="card-content">
              <div class="tech-grid">
                <div class="tech-category">
                  <h4>前端</h4>
                  <div class="tech-tags">
                    <span class="tech-tag">Vue.js</span>
                    <span class="tech-tag">Element UI</span>
                    <span class="tech-tag">JavaScript</span>
                    <span class="tech-tag">HTML/CSS</span>
                    <span class="tech-tag">SCSS</span>
                  </div>
                </div>
                <div class="tech-category">
                  <h4>后端</h4>
                  <div class="tech-tags">
                    <span class="tech-tag">.NET Core</span>
                    <span class="tech-tag">C#</span>
                    <span class="tech-tag">RESTful API</span>
                  </div>
                </div>
                <div class="tech-category">
                  <h4>数据库 & 工具</h4>
                  <div class="tech-tags">
                    <span class="tech-tag">SQL Server</span>
                    <span class="tech-tag">Git</span>
                    <span class="tech-tag">VS Code</span>
                  </div>
                </div>
              </div>
            </div>
          </section>

          <!-- 联系方式 -->
          <section class="info-card glass-card">
            <div class="card-header">
              <svg class="header-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M21 11.5a8.38 8.38 0 01-.9 3.8 8.5 8.5 0 01-7.6 4.7 8.38 8.38 0 01-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 01-.9-3.8 8.5 8.5 0 014.7-7.6 8.38 8.38 0 013.8-.9h.5a8.48 8.48 0 018 8v.5z"/>
              </svg>
              <h3>联系我</h3>
            </div>
            <div class="card-content">
              <p>如果你有任何问题或建议，欢迎通过以下方式联系我：</p>
              <div class="contact-list">
                <a href="mailto:zhansfai@163.com" class="contact-item">
                  <span class="contact-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                      <polyline points="22,6 12,13 2,6"/>
                    </svg>
                  </span>
                  <span class="contact-text">zhansfai@163.com</span>
                </a>
                <a href="https://github.com/DorianGn" target="_blank" class="contact-item">
                  <span class="contact-icon">
                    <svg viewBox="0 0 24 24" fill="currentColor">
                      <path d="M12 0C5.37 0 0 5.37 0 12c0 5.31 3.435 9.795 8.205 11.385.6.105.825-.255.825-.57 0-.285-.015-1.23-.015-2.235-3.015.555-3.795-.735-4.035-1.41-.135-.345-.72-1.41-1.23-1.695-.42-.225-1.02-.78-.015-.795.945-.015 1.62.87 1.845 1.23 1.08 1.815 2.805 1.305 3.495.99.105-.78.42-1.305.765-1.605-2.67-.3-5.46-1.335-5.46-5.925 0-1.305.465-2.385 1.23-3.225-.12-.3-.54-1.53.12-3.18 0 0 1.005-.315 3.3 1.23.96-.27 1.98-.405 3-.405s2.04.135 3 .405c2.295-1.56 3.3-1.23 3.3-1.23.66 1.65.24 2.88.12 3.18.765.84 1.23 1.905 1.23 3.225 0 4.605-2.805 5.625-5.475 5.925.435.375.81 1.095.81 2.22 0 1.605-.015 2.895-.015 3.3 0 .315.225.69.825.57A12.02 12.02 0 0024 12c0-6.63-5.37-12-12-12z"/>
                    </svg>
                  </span>
                  <span class="contact-text">github.com/DorianGn</span>
                </a>
              </div>
            </div>
          </section>
        </div>

        <!-- 右侧边栏 -->
        <div class="right-sidebar">
          <!-- 站点统计 -->
          <div class="sidebar-card glass-card">
            <div class="card-header">
              <svg class="header-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M18 20V10M12 20V4M6 20v-6"/>
              </svg>
              <span>站点统计</span>
            </div>
            <div class="stats-grid">
              <div class="stat-item">
                <div class="stat-value">
                  <span v-if="statsLoading" class="loading-placeholder"></span>
                  <span v-else>{{ stats.articleCount }}</span>
                </div>
                <div class="stat-label">文章数</div>
              </div>
              <div class="stat-item">
                <div class="stat-value">
                  <span v-if="statsLoading" class="loading-placeholder"></span>
                  <span v-else>{{ stats.categoryCount }}</span>
                </div>
                <div class="stat-label">分类数</div>
              </div>
              <div class="stat-item">
                <div class="stat-value">
                  <span v-if="statsLoading" class="loading-placeholder"></span>
                  <span v-else>{{ formatNumber(stats.totalViews) }}</span>
                </div>
                <div class="stat-label">总访问</div>
              </div>
              <div class="stat-item">
                <div class="stat-value">
                  <span v-if="statsLoading" class="loading-placeholder"></span>
                  <span v-else>{{ formatNumber(stats.totalLikes) }}</span>
                </div>
                <div class="stat-label">获得点赞</div>
              </div>
            </div>
          </div>

          <!-- 最新文章 -->
          <div class="sidebar-card glass-card">
            <div class="card-header">
              <svg class="header-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8l-6-6z"/>
                <path d="M14 2v6h6M16 13H8M16 17H8M10 9H8"/>
              </svg>
              <span>最新文章</span>
            </div>
            <div v-loading="articlesLoading" class="recent-articles">
              <div
                v-for="article in recentArticles"
                :key="article.Id"
                class="article-item"
                @click="goToArticle(article.Id)"
              >
                <span class="article-title">{{ article.Title }}</span>
                <span class="article-date">{{ formatTime(article.CreateTime) }}</span>
              </div>
              <div v-if="!articlesLoading && recentArticles.length === 0" class="empty-tip">
                暂无文章
              </div>
            </div>
          </div>

          <!-- 快速链接 -->
          <div class="sidebar-card glass-card">
            <div class="card-header">
              <svg class="header-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M10 13a5 5 0 007.54.54l3-3a5 5 0 00-7.07-7.07l-1.72 1.71"/>
                <path d="M14 11a5 5 0 00-7.54-.54l-3 3a5 5 0 007.07 7.07l1.71-1.71"/>
              </svg>
              <span>快速链接</span>
            </div>
            <div class="quick-links">
              <router-link to="/" class="quick-link">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z"/>
                  <polyline points="9 22 9 12 15 12 15 22"/>
                </svg>
                首页
              </router-link>
              <router-link to="/articles" class="quick-link">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8l-6-6z"/>
                  <path d="M14 2v6h6"/>
                </svg>
                文章
              </router-link>
              <router-link to="/archive" class="quick-link">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <rect x="3" y="4" width="18" height="18" rx="2"/>
                  <path d="M16 2v4M8 2v4M3 10h18"/>
                </svg>
                归档
              </router-link>
            </div>
          </div>
        </div>
      </div>
    </main>

    <!-- 底部 -->
    <footer class="blog-footer">
      <div class="footer-content glass-card">
        <div class="footer-left">
          <div class="footer-logo">
            <svg class="logo-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="1.5"/>
              <ellipse cx="12" cy="12" rx="4" ry="10" stroke="currentColor" stroke-width="1.5"/>
              <path d="M2 12h20" stroke="currentColor" stroke-width="1.5"/>
              <path d="M4 7h16M4 17h16" stroke="currentColor" stroke-width="1.5"/>
            </svg>
            <span>OnlyBlog</span>
          </div>
          <p class="footer-text">© 2025 OnlyBlog. All rights reserved.</p>
        </div>

        <div class="footer-links">
          <router-link to="/" class="footer-link">首页</router-link>
          <router-link to="/articles" class="footer-link">文章</router-link>
          <router-link to="/archive" class="footer-link">归档</router-link>
        </div>
      </div>
    </footer>
  </div>
</template>

<script>
import { getArticleList } from '@/api/article'
import { getCategoryList } from '@/api/category'

export default {
  name: 'AboutPage',
  data() {
    return {
      siteName: process.env.VUE_APP_TITLE || 'OnlyBlog',
      avatarError: false,
      statsLoading: true,
      articlesLoading: true,
      stats: {
        articleCount: 0,
        categoryCount: 0,
        totalViews: 0,
        totalLikes: 0
      },
      recentArticles: [],
      particles: []
    }
  },
  created() {
    this.generateParticles()
    this.init()
  },
  methods: {
    generateParticles() {
      this.particles = Array.from({ length: 50 }, () => ({
        style: {
          left: Math.random() * 100 + '%',
          top: Math.random() * 100 + '%',
          animationDelay: Math.random() * 20 + 's',
          animationDuration: (Math.random() * 10 + 10) + 's'
        }
      }))
    },

    async init() {
      await Promise.all([
        this.fetchStats(),
        this.fetchRecentArticles()
      ])
    },

    async fetchStats() {
      this.statsLoading = true
      try {
        const [articleRes, categoryRes] = await Promise.all([
          getArticleList({ pageIndex: 1, pageRows: 100 }),
          getCategoryList()
        ])

        const articles = articleRes.Data || []
        let totalViews = 0
        let totalLikes = 0

        articles.forEach(article => {
          totalViews += article.ViewCount || 0
          totalLikes += article.LikeCount || 0
        })

        this.stats = {
          articleCount: articleRes.Total || 0,
          categoryCount: (categoryRes.Data || []).length,
          totalViews,
          totalLikes
        }
      } catch (error) {
        console.error('获取统计数据失败:', error)
      } finally {
        this.statsLoading = false
      }
    },

    async fetchRecentArticles() {
      this.articlesLoading = true
      try {
        const res = await getArticleList({
          pageIndex: 1,
          pageRows: 5
        })
        this.recentArticles = res.Data || []
      } catch (error) {
        console.error('获取最新文章失败:', error)
      } finally {
        this.articlesLoading = false
      }
    },

    handleAvatarError() {
      this.avatarError = true
    },

    goToArticle(id) {
      this.$router.push(`/article/${id}`)
    },

    formatNumber(num) {
      if (num >= 10000) {
        return (num / 10000).toFixed(1) + 'w'
      } else if (num >= 1000) {
        return (num / 1000).toFixed(1) + 'K'
      }
      return num.toString()
    },

    formatTime(timeStr) {
      if (!timeStr) return '-'
      try {
        const date = new Date(timeStr)
        const now = new Date()
        const diffTime = now - date
        const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24))

        if (diffDays === 0) {
          return '今天'
        } else if (diffDays === 1) {
          return '昨天'
        } else if (diffDays < 7) {
          return `${diffDays}天前`
        } else {
          return date.toLocaleDateString()
        }
      } catch (error) {
        return timeStr.split(' ')[0]
      }
    }
  }
}
</script>

<style lang="scss" scoped>
// 样式变量
$primary-color: #5b6ee1;
$primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
$glass-bg: rgba(255, 255, 255, 0.7);
$glass-border: rgba(102, 126, 234, 0.15);
$glass-shadow: 0 8px 32px rgba(102, 126, 234, 0.1);
$text-primary: #333333;
$text-secondary: #666666;
$text-muted: #999999;

// 毛玻璃效果
.glass-card {
  background: $glass-bg;
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid $glass-border;
  box-shadow: $glass-shadow;
  border-radius: 16px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);

  &:hover {
    background: rgba(255, 255, 255, 0.85);
    border-color: rgba(102, 126, 234, 0.25);
    box-shadow: 0 12px 48px rgba(102, 126, 234, 0.15);
  }
}

.about-container {
  min-height: 100vh;
  background: #ffffff;
  position: relative;
  overflow-x: hidden;
}

// 背景动画效果
.background-animation {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  pointer-events: none;
  z-index: 0;

  .background-image {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.03) 0%, rgba(118, 75, 162, 0.03) 100%);
    z-index: 1;
  }

  .particles-container {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 2;

    .particle {
      position: absolute;
      width: 4px;
      height: 4px;
      background: radial-gradient(circle, rgba(102, 126, 234, 0.6) 0%, rgba(118, 75, 162, 0.4) 50%, transparent 100%);
      border-radius: 50%;
      animation: float-particle linear infinite;

      &:nth-child(2n) {
        width: 3px;
        height: 3px;
        background: radial-gradient(circle, rgba(240, 147, 251, 0.5) 0%, rgba(102, 126, 234, 0.3) 50%, transparent 100%);
      }

      &:nth-child(3n) {
        width: 2px;
        height: 2px;
        background: radial-gradient(circle, rgba(118, 75, 162, 0.4) 0%, rgba(195, 207, 226, 0.2) 50%, transparent 100%);
      }
    }
  }

  .floating-shapes {
    position: relative;
    width: 100%;
    height: 100%;
    z-index: 3;

    .shape {
      position: absolute;
      background: radial-gradient(circle, rgba(102, 126, 234, 0.08) 0%, transparent 70%);
      border-radius: 50%;

      &.shape-1 {
        width: 400px;
        height: 400px;
        top: -100px;
        right: -50px;
        animation: float 15s ease-in-out infinite;
      }

      &.shape-2 {
        width: 300px;
        height: 300px;
        top: 50%;
        right: 10%;
        animation: float 20s ease-in-out infinite reverse;
      }

      &.shape-3 {
        width: 200px;
        height: 200px;
        bottom: 30%;
        left: 5%;
        animation: float 18s ease-in-out infinite;
      }

      &.shape-4 {
        width: 150px;
        height: 150px;
        top: 40%;
        left: 15%;
        animation: float 12s ease-in-out infinite reverse;
      }

      &.shape-5 {
        width: 100px;
        height: 100px;
        bottom: 20%;
        right: 25%;
        animation: float 25s ease-in-out infinite;
      }
    }
  }
}

// 主内容区域
.main-content {
  position: relative;
  z-index: 10;
  padding-top: 72px;
}

// Hero 区域
.hero-section {
  padding: 60px 0 40px;

  .hero-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 40px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 60px;
  }

  .hero-text {
    flex: 1;
    max-width: 600px;

    .hero-title {
      font-size: 48px;
      font-weight: 800;
      line-height: 1.2;
      margin-bottom: 16px;

      .title-line {
        display: block;
        color: $text-primary;

        &.accent {
          background: $primary-gradient;
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
          background-clip: text;
        }
      }
    }

    .hero-subtitle {
      font-size: 18px;
      color: $text-secondary;
      margin-bottom: 40px;
      line-height: 1.6;
    }

    .hero-actions {
      display: flex;
      gap: 24px;
      align-items: center;

      .btn-icon {
        width: 18px;
        height: 18px;
      }

      .primary-btn {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 14px 28px;
        font-size: 15px;
        font-weight: 600;
        background: $text-primary;
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        text-decoration: none;
        transition: all 0.3s;

        &:hover {
          background: #1a1a1a;
          transform: translateY(-2px);
          box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
        }
      }

      .secondary-btn {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 14px 20px;
        font-size: 15px;
        font-weight: 500;
        color: $primary-color;
        text-decoration: none;
        background: transparent;
        border: none;
        cursor: pointer;
        transition: all 0.3s;

        &:hover {
          color: darken($primary-color, 10%);
        }
      }
    }
  }

  .hero-visual {
    flex-shrink: 0;

    .avatar-container {
      position: relative;
      width: 280px;
      height: 280px;

      .avatar-ring {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 200px;
        height: 200px;
        border: 3px solid rgba(102, 126, 234, 0.2);
        border-radius: 50%;
        transform: translate(-50%, -50%);
        animation: rotate-slow 20s linear infinite;
      }

      .avatar-wrapper {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 160px;
        height: 160px;
        border-radius: 50%;
        transform: translate(-50%, -50%);
        overflow: hidden;
        box-shadow:
          0 20px 60px rgba(91, 110, 225, 0.2),
          0 10px 30px rgba(0, 0, 0, 0.1);
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

        img {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }

        .avatar-fallback {
          width: 100%;
          height: 100%;
          display: flex;
          align-items: center;
          justify-content: center;

          svg {
            width: 60%;
            height: 60%;
            color: rgba(255, 255, 255, 0.8);
          }
        }
      }

      .orbit-icon {
        position: absolute;
        color: rgba(91, 110, 225, 0.35);
        font-size: 14px;
        animation: float-gentle 4s ease-in-out infinite;

        &.icon-a { top: 8%; left: 25%; animation-delay: 0s; }
        &.icon-b { top: 5%; right: 30%; animation-delay: 0.5s; }
        &.icon-c { bottom: 25%; right: 10%; animation-delay: 1s; }
        &.icon-d { bottom: 30%; left: 15%; animation-delay: 1.5s; }
      }
    }
  }
}

// 个人简介区域
.profile-section {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 40px 40px;

  .profile-card {
    padding: 40px;
    text-align: center;

    .profile-header {
      margin-bottom: 24px;

      .profile-name {
        font-size: 28px;
        font-weight: 700;
        color: $text-primary;
        margin-bottom: 8px;
      }

      .profile-title {
        font-size: 16px;
        color: $primary-color;
        font-weight: 500;
      }
    }

    .profile-bio {
      max-width: 600px;
      margin: 0 auto;

      p {
        font-size: 15px;
        color: $text-secondary;
        line-height: 1.8;
        margin-bottom: 12px;

        &:last-child {
          margin-bottom: 0;
        }
      }
    }
  }
}

// 内容网格
.content-grid {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 40px 80px;
  display: flex;
  gap: 40px;
}

.left-content {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.right-sidebar {
  width: 320px;
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  gap: 24px;
}

// 信息卡片
.info-card {
  padding: 28px;

  .card-header {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 20px;
    padding-bottom: 16px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.06);

    .header-icon {
      width: 22px;
      height: 22px;
      color: $primary-color;
    }

    h3 {
      font-size: 18px;
      font-weight: 600;
      color: $text-primary;
      margin: 0;
    }
  }

  .card-content {
    p {
      font-size: 14px;
      color: $text-secondary;
      line-height: 1.8;
      margin-bottom: 16px;
    }
  }
}

// 特性列表
.feature-list {
  list-style: none;
  padding: 0;
  margin: 0;

  li {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 0;
    font-size: 14px;
    color: $text-primary;
    border-bottom: 1px solid rgba(0, 0, 0, 0.04);

    &:last-child {
      border-bottom: none;
    }

    .feature-icon {
      width: 36px;
      height: 36px;
      background: rgba(91, 110, 225, 0.1);
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;

      svg {
        width: 18px;
        height: 18px;
        color: $primary-color;
      }
    }
  }
}

// 技术栈
.tech-grid {
  display: flex;
  flex-direction: column;
  gap: 20px;

  .tech-category {
    h4 {
      font-size: 13px;
      font-weight: 600;
      color: $text-muted;
      margin-bottom: 12px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .tech-tags {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
    }

    .tech-tag {
      padding: 8px 16px;
      background: rgba(255, 255, 255, 0.8);
      border: 1px solid rgba(102, 126, 234, 0.15);
      border-radius: 20px;
      font-size: 13px;
      color: $text-secondary;
      transition: all 0.3s;

      &:hover {
        background: $primary-gradient;
        border-color: transparent;
        color: white;
        transform: translateY(-2px);
      }
    }
  }
}

// 联系列表
.contact-list {
  display: flex;
  flex-direction: column;
  gap: 12px;

  .contact-item {
    display: flex;
    align-items: center;
    gap: 14px;
    padding: 14px 16px;
    background: rgba(255, 255, 255, 0.6);
    border: 1px solid rgba(102, 126, 234, 0.1);
    border-radius: 12px;
    text-decoration: none;
    transition: all 0.3s;

    &:hover {
      background: rgba(91, 110, 225, 0.08);
      border-color: rgba(91, 110, 225, 0.2);
      transform: translateX(4px);

      .contact-text {
        color: $primary-color;
      }
    }

    .contact-icon {
      width: 36px;
      height: 36px;
      background: rgba(91, 110, 225, 0.1);
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;

      svg {
        width: 18px;
        height: 18px;
        color: $primary-color;
      }
    }

    .contact-text {
      font-size: 14px;
      color: $text-primary;
      transition: color 0.3s;
    }
  }
}

// 侧边栏卡片
.sidebar-card {
  padding: 20px;

  .card-header {
    font-weight: 600;
    font-size: 16px;
    color: $text-primary;
    padding-bottom: 16px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.06);
    margin-bottom: 16px;
    display: flex;
    align-items: center;
    gap: 10px;

    .header-icon {
      width: 20px;
      height: 20px;
      color: $primary-color;
    }
  }

  .empty-tip {
    text-align: center;
    color: $text-muted;
    padding: 20px 0;
    font-size: 14px;
  }
}

// 统计网格
.stats-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;

  .stat-item {
    text-align: center;
    padding: 16px 12px;
    background: rgba(255, 255, 255, 0.5);
    border-radius: 12px;
    transition: all 0.3s;

    &:hover {
      background: rgba(91, 110, 225, 0.08);
    }

    .stat-value {
      font-size: 24px;
      font-weight: 700;
      color: $primary-color;
      margin-bottom: 4px;
    }

    .stat-label {
      font-size: 12px;
      color: $text-muted;
    }
  }
}

// 最新文章
.recent-articles {
  .article-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    padding: 12px 0;
    border-bottom: 1px solid rgba(0, 0, 0, 0.04);
    cursor: pointer;
    transition: all 0.3s;

    &:last-child {
      border-bottom: none;
    }

    &:hover {
      padding-left: 8px;

      .article-title {
        color: $primary-color;
      }
    }

    .article-title {
      flex: 1;
      font-size: 14px;
      color: $text-primary;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      transition: color 0.3s;
    }

    .article-date {
      font-size: 12px;
      color: $text-muted;
      flex-shrink: 0;
    }
  }
}

// 快速链接
.quick-links {
  display: flex;
  flex-direction: column;
  gap: 8px;

  .quick-link {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 16px;
    background: rgba(255, 255, 255, 0.5);
    border-radius: 10px;
    text-decoration: none;
    font-size: 14px;
    color: $text-primary;
    transition: all 0.3s;

    svg {
      width: 18px;
      height: 18px;
      color: $text-muted;
      transition: color 0.3s;
    }

    &:hover {
      background: rgba(91, 110, 225, 0.1);
      color: $primary-color;
      transform: translateX(4px);

      svg {
        color: $primary-color;
      }
    }
  }
}

// 加载占位符
.loading-placeholder {
  display: inline-block;
  width: 32px;
  height: 20px;
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 400% 100%;
  border-radius: 4px;
  animation: shimmer 1.4s ease infinite;
}

// 底部
.blog-footer {
  padding: 40px 40px;
  margin-top: 40px;

  .footer-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 24px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .footer-left {
    .footer-logo {
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: 18px;
      font-weight: 600;
      color: $text-primary;
      margin-bottom: 8px;

      .logo-icon {
        width: 24px;
        height: 24px;
        color: $primary-color;
      }
    }

    .footer-text {
      font-size: 13px;
      color: $text-muted;
      margin: 0;
    }
  }

  .footer-links {
    display: flex;
    gap: 32px;

    .footer-link {
      font-size: 14px;
      color: $text-secondary;
      text-decoration: none;
      transition: color 0.3s;

      &:hover {
        color: $primary-color;
      }
    }
  }
}

// 动画
@keyframes float {
  0%, 100% {
    transform: translateY(0px) rotate(0deg);
  }
  33% {
    transform: translateY(-20px) rotate(2deg);
  }
  66% {
    transform: translateY(-10px) rotate(-2deg);
  }
}

@keyframes float-particle {
  0% {
    transform: translateY(100vh) translateX(0px);
    opacity: 0;
  }
  10% {
    opacity: 1;
  }
  90% {
    opacity: 1;
  }
  100% {
    transform: translateY(-100px) translateX(100px);
    opacity: 0;
  }
}

@keyframes float-gentle {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-10px);
  }
}

@keyframes rotate-slow {
  from {
    transform: translate(-50%, -50%) rotate(0deg);
  }
  to {
    transform: translate(-50%, -50%) rotate(360deg);
  }
}

@keyframes shimmer {
  0% {
    background-position: -400px 0;
  }
  100% {
    background-position: 400px 0;
  }
}

// 响应式设计
@media (max-width: 1024px) {
  .hero-section .hero-content {
    flex-direction: column;
    text-align: center;
    gap: 40px;
  }

  .hero-section .hero-text {
    max-width: 100%;

    .hero-actions {
      justify-content: center;
    }
  }

  .content-grid {
    flex-direction: column;
  }

  .right-sidebar {
    width: 100%;
    flex-direction: row;
    flex-wrap: wrap;

    .sidebar-card {
      flex: 1;
      min-width: 280px;
    }
  }
}

@media (max-width: 768px) {
  .hero-section {
    padding: 40px 0 30px;

    .hero-content {
      padding: 0 20px;
    }

    .hero-text {
      .hero-title {
        font-size: 36px;
      }

      .hero-actions {
        flex-direction: column;
        gap: 16px;

        .primary-btn,
        .secondary-btn {
          width: 100%;
          justify-content: center;
        }
      }
    }

    .hero-visual .avatar-container {
      width: 200px;
      height: 200px;

      .avatar-ring {
        width: 140px;
        height: 140px;
      }

      .avatar-wrapper {
        width: 110px;
        height: 110px;
      }
    }
  }

  .profile-section {
    padding: 0 20px 24px;

    .profile-card {
      padding: 24px;

      .profile-header .profile-name {
        font-size: 22px;
      }
    }
  }

  .content-grid {
    padding: 0 20px 60px;
  }

  .info-card {
    padding: 20px;
  }

  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .blog-footer {
    padding: 40px 20px;

    .footer-content {
      flex-direction: column;
      gap: 24px;
      text-align: center;
      padding: 24px 20px;
    }
  }
}
</style>

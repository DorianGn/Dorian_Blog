<template>
  <div class="home-container">
    <!-- 背景动态效果 - 保留粒子 -->
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
              <span class="title-line">欢迎来到</span>
              <span class="title-line accent">Dorian Blog</span>
            </h1>
            <p class="hero-subtitle">
              探索技术的边界，记录成长的足迹
            </p>

            <!-- 统计数据 - 简洁横向排列 -->
            <div class="hero-stats">
              <div class="stat-item" v-for="(stat, index) in stats" :key="index">
                <div class="stat-value">
                  <span v-if="statsLoading" class="loading-placeholder"></span>
                  <span v-else>{{ stat.value }}</span>
                </div>
                <div class="stat-label">{{ stat.label }}</div>
              </div>
            </div>

            <!-- 操作按钮 -->
            <div class="hero-actions">
              <button class="primary-btn" @click="scrollToContent">
                <svg class="btn-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <circle cx="11" cy="11" r="8" stroke="currentColor" stroke-width="2" />
                  <path d="M21 21l-4.35-4.35" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                </svg>
                <span>开始探索</span>
              </button>
              <router-link to="/about" class="secondary-btn">
                <svg class="btn-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path
                    d="M21 11.5a8.38 8.38 0 01-.9 3.8 8.5 8.5 0 01-7.6 4.7 8.38 8.38 0 01-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 01-.9-3.8 8.5 8.5 0 014.7-7.6 8.38 8.38 0 013.8-.9h.5a8.48 8.48 0 018 8v.5z"
                    stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                </svg>
                <span>与我交流</span>
              </router-link>
            </div>
          </div>

          <!-- 右侧装饰球体 -->
          <div class="hero-visual">
            <div class="visual-container">
              <div class="central-orb"></div>
              <div class="orb-glow"></div>
              <!-- 漂浮的小图标 -->
              <span class="orbit-icon icon-a">◇</span>
              <span class="orbit-icon icon-b">○</span>
              <span class="orbit-icon icon-c">☆</span>
              <span class="orbit-icon icon-d">△</span>
              <span class="orbit-icon icon-e">◇</span>
              <span class="orbit-icon icon-f">○</span>
            </div>
          </div>
        </div>
      </section>

      <!-- 精选内容区域 -->
      <section class="featured-section" id="featured-content">
        <div class="section-header">
          <h2 class="section-title">精选内容</h2>
          <p class="section-subtitle">发现更多精彩内容</p>
        </div>

        <!-- 轮播图 -->
        <div v-if="loadingTop || topArticles.length > 0" class="banner-wrapper glass-card">
          <div v-if="loadingTop" class="banner-loading">
            <div class="loading-spinner"></div>
          </div>
          <el-carousel v-else height="360px" indicator-position="outside" arrow="hover">
            <el-carousel-item v-for="article in topArticles" :key="article.Id">
              <div class="banner-item" :style="getBannerStyle(article)" @click="goToArticle(article.Id)">
                <div class="banner-overlay"></div>
                <div class="banner-content">
                  <div class="banner-tag" v-if="article.IsTop">
                    <i class="el-icon-star-on"></i> 置顶
                  </div>
                  <h2 class="banner-title">{{ article.Title }}</h2>
                  <p v-if="article.Summary" class="banner-summary">{{ article.Summary }}</p>
                  <div class="banner-meta">
                    <span><i class="el-icon-view"></i> {{ article.ViewCount }}</span>
                    <span><i class="el-icon-star-off"></i> {{ article.LikeCount }}</span>
                    <span><i class="el-icon-chat-line-square"></i> {{ article.CommentCount }}</span>
                  </div>
                </div>
              </div>
            </el-carousel-item>
          </el-carousel>
        </div>

        <!-- 功能卡片区域 -->
        <div class="feature-cards">
          <div class="feature-card glass-card" @click="$router.push('/articles')">
            <h3 class="card-title">技术文章</h3>
            <p class="card-desc">分享前端开发、后端技术、数据库优化等方面的技术文章和实战经验</p>
            <div class="card-tags">
              <span class="tag primary">{{ recommendArticles.length || 0 }}篇精选</span>
              <span class="tag secondary">持续更新</span>
            </div>
          </div>
          <div class="feature-card glass-card" @click="$router.push('/archive')">
            <h3 class="card-title">归档</h3>
            <p class="card-desc">按时间轴浏览所有文章，回顾技术成长的足迹与历程</p>
            <div class="card-tags">
              <span class="tag primary">{{ total || 0 }}篇文章</span>
              <span class="tag secondary">时间线</span>
            </div>
          </div>
          <div class="feature-card glass-card" @click="$router.push('/about')">
            <h3 class="card-title">关于</h3>
            <p class="card-desc">了解博主、本站技术栈以及联系方式</p>
            <div class="card-tags">
              <span class="tag primary">个人简介</span>
              <span class="tag secondary">联系我</span>
            </div>
          </div>
        </div>

        <div class="explore-more">
          <router-link to="/articles" class="explore-link">
            探索更多 <span class="arrow">→</span>
          </router-link>
        </div>
      </section>

      <!-- 内容网格 -->
      <div class="content-grid">
        <!-- 左侧：文章列表 -->
        <div class="left-content">
          <!-- 推荐文章 -->
          <section v-if="loadingRecommend || recommendArticles.length > 0" class="article-section">
            <div class="section-header-inline">
              <h3 class="section-title-small">
                <svg class="title-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <polygon
                    points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"
                    stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                </svg>
                推荐文章
              </h3>
            </div>
            <div v-if="loadingRecommend" class="article-grid">
              <div v-for="n in 3" :key="n" class="article-card glass-card skeleton-card">
                <div class="article-cover skeleton-cover"></div>
                <div class="article-content">
                  <div class="skeleton-title"></div>
                  <div class="skeleton-text"></div>
                  <div class="skeleton-text short"></div>
                </div>
              </div>
            </div>
            <div v-else class="article-grid">
              <div v-for="article in recommendArticles" :key="article.Id" class="article-card glass-card"
                @click="goToArticle(article.Id)">
                <div class="article-cover">
                  <img v-if="article.CoverImage" :src="article.CoverImage" :alt="article.Title"
                    @error="handleImageError" />
                  <div v-else class="default-cover">
                    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8l-6-6z" stroke="currentColor"
                        stroke-width="1.5" />
                      <path d="M14 2v6h6M16 13H8M16 17H8M10 9H8" stroke="currentColor" stroke-width="1.5" />
                    </svg>
                  </div>
                  <div v-if="article.IsRecommend" class="featured-badge">推荐</div>
                </div>
                <div class="article-content">
                  <h3 class="article-title">{{ article.Title }}</h3>
                  <p class="article-summary">{{ article.Summary || '暂无摘要' }}</p>
                  <div class="article-stats">
                    <span class="stat"><i class="el-icon-view"></i> {{ article.ViewCount || 0 }}</span>
                    <span class="stat"><i class="el-icon-star-off"></i> {{ article.LikeCount || 0 }}</span>
                    <span class="publish-time">{{ formatTime(article.CreateTime) }}</span>
                  </div>
                </div>
              </div>
            </div>
          </section>

          <!-- 最新文章 -->
          <section class="article-section">
            <div class="section-header-inline">
              <h3 class="section-title-small">
                <svg class="title-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8l-6-6z" stroke="currentColor"
                    stroke-width="2" />
                  <path d="M14 2v6h6M16 13H8M16 17H8M10 9H8" stroke="currentColor" stroke-width="2" />
                </svg>
                最新文章
              </h3>
              <router-link to="/articles" class="more-link">
                查看更多 <span class="arrow">→</span>
              </router-link>
            </div>

            <div v-loading="loading" class="article-list">
              <div v-for="article in latestArticles" :key="article.Id" class="article-list-item glass-card"
                @click="goToArticle(article.Id)">
                <div class="article-thumb" v-if="article.CoverImage">
                  <img :src="article.CoverImage" :alt="article.Title" @error="handleImageError" />
                </div>
                <div class="article-info">
                  <h4 class="article-title">{{ article.Title }}</h4>
                  <p class="article-summary">{{ article.Summary || '暂无摘要' }}</p>
                  <div class="article-meta">
                    <span class="meta-item"><i class="el-icon-view"></i> {{ article.ViewCount }}</span>
                    <span class="meta-item"><i class="el-icon-star-off"></i> {{ article.LikeCount }}</span>
                    <span class="meta-item"><i class="el-icon-time"></i> {{ formatTime(article.CreateTime) }}</span>
                  </div>
                </div>
              </div>
            </div>

            <div v-if="!loading && latestArticles.length === 0" class="empty-state glass-card">
              <svg class="empty-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8l-6-6z" stroke="currentColor"
                  stroke-width="1.5" />
                <path d="M14 2v6h6" stroke="currentColor" stroke-width="1.5" />
              </svg>
              <h3>暂无文章</h3>
              <p>还没有发布任何文章</p>
            </div>

            <!-- 分页 -->
            <div v-if="total > pageSize" class="pagination-wrapper">
              <el-pagination background layout="prev, pager, next" :total="total" :page-size="pageSize"
                :current-page.sync="currentPage" @current-change="handlePageChange">
              </el-pagination>
            </div>
          </section>
        </div>

        <!-- 右侧：侧边栏 -->
        <div class="right-sidebar">
          <!-- 热门文章 -->
          <div class="sidebar-card glass-card">
            <div class="card-header">
              <svg class="header-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M8.21 13.89L7 23l5-3 5 3-1.21-9.12" stroke="currentColor" stroke-width="2"
                  stroke-linecap="round" stroke-linejoin="round" />
                <circle cx="12" cy="8" r="7" stroke="currentColor" stroke-width="2" />
              </svg>
              热门文章
            </div>
            <div v-loading="loadingHot" class="hot-articles">
              <div v-for="(article, index) in hotArticles" :key="article.Id" class="hot-article-item"
                @click="goToArticle(article.Id)">
                <span class="rank" :class="'rank-' + (index + 1)">{{ index + 1 }}</span>
                <span class="title">{{ article.Title }}</span>
                <span class="views"><i class="el-icon-view"></i> {{ article.ViewCount }}</span>
              </div>
              <div v-if="!loadingHot && hotArticles.length === 0" class="empty-tip">
                暂无数据
              </div>
            </div>
          </div>

          <!-- 分类 -->
          <div class="sidebar-card glass-card">
            <div class="card-header">
              <svg class="header-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M22 19a2 2 0 01-2 2H4a2 2 0 01-2-2V5a2 2 0 012-2h5l2 3h9a2 2 0 012 2v11z" stroke="currentColor"
                  stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
              </svg>
              文章分类
            </div>
            <div v-loading="loadingCategories" class="categories">
              <div v-for="category in categories" :key="category.Id" class="category-item"
                @click="goToCategory(category.Id)">
                <span class="name">{{ category.Name }}</span>
                <span class="count">{{ category.ArticleCount }}</span>
              </div>
              <div v-if="!loadingCategories && categories.length === 0" class="empty-tip">
                暂无分类
              </div>
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
              <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="1.5" />
              <ellipse cx="12" cy="12" rx="4" ry="10" stroke="currentColor" stroke-width="1.5" />
              <path d="M2 12h20" stroke="currentColor" stroke-width="1.5" />
              <path d="M4 7h16M4 17h16" stroke="currentColor" stroke-width="1.5" />
            </svg>
            <span>OnlyBlog</span>
          </div>
          <p class="footer-text">© 2025 OnlyBlog. All rights reserved.</p>
        </div>

        <div class="footer-links">
          <a href="#" class="footer-link">隐私政策</a>
          <a href="#" class="footer-link">使用条款</a>
          <a href="#" class="footer-link">网站地图</a>
        </div>
      </div>
    </footer>
  </div>
</template>

<script>
import {
  getArticleList,
  getTopArticles,
  getRecommendArticles,
  getHotArticles
} from '@/api/article'
import { getCategoryList } from '@/api/category'

export default {
  name: 'HomePage',
  data() {
    return {
      topArticles: [],
      recommendArticles: [],
      latestArticles: [],
      hotArticles: [],
      categories: [],
      currentPage: 1,
      pageSize: 10,
      total: 0,
      loading: false,
      loadingTop: true,
      loadingRecommend: true,
      loadingHot: false,
      loadingCategories: false,
      statsLoading: true,

      // 统计数据
      stats: [
        { value: '0', label: '技术文章' },
        { value: '0', label: '文章分类' },
        { value: '0', label: '总访问' },
        { value: '0', label: '获得点赞' }
      ],

      // 粒子样式
      particles: []
    }
  },
  created() {
    this.generateParticles()
    this.init()
  },
  methods: {
    // 生成粒子
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
        this.fetchTopArticles(),
        this.fetchRecommendArticles(),
        this.fetchLatestArticles(),
        this.fetchHotArticles(),
        this.fetchCategories()
      ])
      this.updateStats()
    },

    updateStats() {
      this.statsLoading = false
      const allStats = this.calculateAllStats()
      this.stats = [
        { value: this.total.toString(), label: '技术文章' },
        { value: this.categories.length.toString(), label: '文章分类' },
        { value: this.formatNumber(allStats.views), label: '总访问' },
        { value: this.formatNumber(allStats.likes), label: '获得点赞' }
      ]
    },

    calculateAllStats() {
      const seen = new Set()
      let views = 0
      let likes = 0
      let comments = 0

      const allArticles = [
        ...this.topArticles,
        ...this.recommendArticles,
        ...this.latestArticles,
        ...this.hotArticles
      ]

      allArticles.forEach(article => {
        if (!seen.has(article.Id)) {
          seen.add(article.Id)
          views += article.ViewCount || 0
          likes += article.LikeCount || 0
          comments += article.CommentCount || 0
        }
      })

      return { views, likes, comments }
    },

    formatNumber(num) {
      if (num >= 10000) {
        return (num / 10000).toFixed(1) + 'w'
      } else if (num >= 1000) {
        return (num / 1000).toFixed(1) + 'K'
      }
      return num.toString()
    },

    async fetchTopArticles() {
      this.loadingTop = true
      try {
        const res = await getTopArticles()
        this.topArticles = res.Data || []
      } catch (error) {
        console.error('获取置顶文章失败:', error)
      } finally {
        this.loadingTop = false
      }
    },

    async fetchRecommendArticles() {
      this.loadingRecommend = true
      try {
        const res = await getRecommendArticles(6)
        this.recommendArticles = res.Data || []
      } catch (error) {
        console.error('获取推荐文章失败:', error)
      } finally {
        this.loadingRecommend = false
      }
    },

    async fetchLatestArticles() {
      this.loading = true
      try {
        const res = await getArticleList({
          pageIndex: this.currentPage,
          pageRows: this.pageSize
        })
        this.latestArticles = res.Data || []
        this.total = res.Total || 0
      } catch (error) {
        console.error('获取最新文章失败:', error)
        this.$message.error('获取文章列表失败')
      } finally {
        this.loading = false
      }
    },

    async fetchHotArticles() {
      this.loadingHot = true
      try {
        const res = await getHotArticles(8)
        this.hotArticles = res.Data || []
      } catch (error) {
        console.error('获取热门文章失败:', error)
      } finally {
        this.loadingHot = false
      }
    },

    async fetchCategories() {
      this.loadingCategories = true
      try {
        const res = await getCategoryList()
        this.categories = res.Data || []
      } catch (error) {
        console.error('获取分类失败:', error)
      } finally {
        this.loadingCategories = false
      }
    },

    getBannerStyle(article) {
      if (article.CoverImage) {
        return {
          backgroundImage: `url(${article.CoverImage})`
        }
      }
      return {
        background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)'
      }
    },

    goToArticle(id) {
      this.$router.push(`/article/${id}`)
    },

    goToCategory(id) {
      this.$router.push(`/articles?category=${id}`)
    },

    handlePageChange(page) {
      this.currentPage = page
      this.fetchLatestArticles()
      window.scrollTo({ top: 0, behavior: 'smooth' })
    },

    scrollToContent() {
      const el = document.getElementById('featured-content')
      if (el) {
        el.scrollIntoView({ behavior: 'smooth', block: 'start' })
      }
    },

    handleImageError(e) {
      e.target.style.display = 'none'
      const parent = e.target.parentElement
      if (parent && !parent.querySelector('.default-cover')) {
        const defaultCover = document.createElement('div')
        defaultCover.className = 'default-cover'
        defaultCover.innerHTML = '<i class="el-icon-picture-outline"></i>'
        parent.appendChild(defaultCover)
      }
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
    transform: translateY(-2px);
  }
}

.home-container {
  min-height: 100vh;
  background: #ffffff;
  position: relative;
  overflow-x: hidden;
}

// 背景动画效果 - 保留粒子
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
  padding: 80px 0 100px;

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
      font-size: 52px;
      font-weight: 800;
      line-height: 1.2;
      margin-bottom: 20px;

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
      margin-bottom: 48px;
      line-height: 1.6;
    }

    // 统计数据 - 简洁横向排列
    .hero-stats {
      display: flex;
      gap: 48px;
      margin-bottom: 48px;

      .stat-item {
        .stat-value {
          font-size: 32px;
          font-weight: 700;
          color: $text-primary;
          line-height: 1;
          margin-bottom: 8px;
        }

        .stat-label {
          font-size: 14px;
          color: $text-muted;
        }
      }
    }

    // 操作按钮
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

  // 右侧装饰球体
  // 右侧装饰球体 - 只需要修改这部分样式
  .hero-visual {
    flex-shrink: 0;

    .visual-container {
      position: relative;
      width: 320px;
      height: 320px;

      // 白色球体
      .central-orb {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 180px;
        height: 180px;
        background: linear-gradient(180deg, #ffffff 0%, #f8f9ff 100%);
        border-radius: 50%;
        transform: translate(-50%, -50%);
        box-shadow:
          0 30px 80px rgba(91, 110, 225, 0.15),
          0 10px 30px rgba(0, 0, 0, 0.05),
          inset 0 -30px 60px rgba(91, 110, 225, 0.06);
        animation: pulse-gentle 4s ease-in-out infinite;
      }

      // 外层淡紫色光晕
      .orb-glow {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 280px;
        height: 280px;
        background: radial-gradient(circle, rgba(91, 110, 225, 0.1) 0%, transparent 70%);
        border-radius: 50%;
        transform: translate(-50%, -50%);
        z-index: -1;
      }

      // 漂浮的小图标
      .orbit-icon {
        position: absolute;
        color: rgba(91, 110, 225, 0.35);
        font-size: 14px;
        animation: float-gentle 4s ease-in-out infinite;

        &.icon-a {
          top: 8%;
          left: 25%;
          animation-delay: 0s;
        }

        &.icon-b {
          top: 5%;
          right: 30%;
          animation-delay: 0.5s;
        }

        &.icon-c {
          top: 35%;
          right: 5%;
          animation-delay: 1s;
        }

        &.icon-d {
          bottom: 20%;
          right: 15%;
          animation-delay: 1.5s;
        }

        &.icon-e {
          bottom: 30%;
          left: 8%;
          animation-delay: 2s;
        }

        &.icon-f {
          top: 55%;
          left: 5%;
          animation-delay: 2.5s;
        }
      }
    }
  }

  // 动画
  @keyframes pulse-gentle {

    0%,
    100% {
      transform: translate(-50%, -50%) scale(1);
      box-shadow:
        0 30px 80px rgba(91, 110, 225, 0.15),
        0 10px 30px rgba(0, 0, 0, 0.05),
        inset 0 -30px 60px rgba(91, 110, 225, 0.06);
    }

    50% {
      transform: translate(-50%, -50%) scale(1.02);
      box-shadow:
        0 35px 90px rgba(91, 110, 225, 0.18),
        0 12px 35px rgba(0, 0, 0, 0.06),
        inset 0 -30px 60px rgba(91, 110, 225, 0.08);
    }
  }
}

// 精选内容区域
.featured-section {
  padding: 80px 0;

  .section-header {
    text-align: center;
    margin-bottom: 48px;

    .section-title {
      font-size: 36px;
      font-weight: 700;
      color: $text-primary;
      margin-bottom: 12px;
    }

    .section-subtitle {
      font-size: 16px;
      color: $text-secondary;
    }
  }

  // 轮播图
  .banner-wrapper {
    max-width: 1000px;
    margin: 0 auto 60px;
    padding: 16px;
    overflow: hidden;

    .banner-loading {
      height: 360px;
      display: flex;
      align-items: center;
      justify-content: center;

      .loading-spinner {
        width: 40px;
        height: 40px;
        border: 3px solid rgba(91, 110, 225, 0.2);
        border-top-color: $primary-color;
        border-radius: 50%;
        animation: spin 1s linear infinite;
      }
    }

    .banner-item {
      width: 100%;
      height: 360px;
      background-size: cover;
      background-position: center;
      position: relative;
      cursor: pointer;
      border-radius: 12px;
      overflow: hidden;

      .banner-overlay {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(to bottom, rgba(0, 0, 0, 0.1), rgba(0, 0, 0, 0.6));
      }

      .banner-content {
        position: absolute;
        bottom: 40px;
        left: 40px;
        right: 40px;
        color: #fff;
        z-index: 1;

        .banner-tag {
          display: inline-flex;
          align-items: center;
          gap: 4px;
          background: rgba(255, 165, 0, 0.9);
          padding: 4px 10px;
          border-radius: 12px;
          font-size: 12px;
          margin-bottom: 12px;
        }

        .banner-title {
          font-size: 26px;
          font-weight: bold;
          margin-bottom: 12px;
          line-height: 1.3;
        }

        .banner-summary {
          font-size: 15px;
          margin-bottom: 12px;
          opacity: 0.9;
          display: -webkit-box;
          -webkit-box-orient: vertical;
          overflow: hidden;
        }

        .banner-meta {
          display: flex;
          gap: 20px;
          font-size: 14px;

          span {
            display: flex;
            align-items: center;
            gap: 4px;
          }
        }
      }
    }

    ::v-deep .el-carousel__indicators--outside {
      margin-top: 16px;

      .el-carousel__indicator--horizontal button {
        width: 24px;
        height: 4px;
        border-radius: 2px;
        background: rgba(102, 126, 234, 0.2);
        opacity: 1;
      }

      .el-carousel__indicator--horizontal.is-active button {
        background: $primary-color;
      }
    }
  }

  // 功能卡片
  .feature-cards {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 40px;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 32px;
  }

  .feature-card {
    padding: 32px;
    cursor: pointer;

    .card-title {
      font-size: 22px;
      font-weight: 700;
      color: $text-primary;
      margin-bottom: 16px;
    }

    .card-desc {
      font-size: 14px;
      color: $text-secondary;
      line-height: 1.7;
      margin-bottom: 24px;
    }

    .card-tags {
      display: flex;
      gap: 12px;

      .tag {
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 500;

        &.primary {
          background: rgba(91, 110, 225, 0.15);
          color: $primary-color;
        }

        &.secondary {
          background: rgba(102, 102, 102, 0.08);
          color: $text-muted;
        }
      }
    }
  }

  .explore-more {
    text-align: center;
    margin-top: 48px;

    .explore-link {
      font-size: 15px;
      color: $text-secondary;
      text-decoration: none;
      transition: color 0.3s;

      .arrow {
        display: inline-block;
        transition: transform 0.3s;
      }

      &:hover {
        color: $primary-color;

        .arrow {
          transform: translateX(4px);
        }
      }
    }
  }
}

// 内容网格
.content-grid {
  max-width: 1200px;
  margin: 0 auto;
  padding: 60px 40px 80px;
  display: flex;
  gap: 40px;
}

.left-content {
  flex: 1;
  min-width: 0;
}

.right-sidebar {
  width: 300px;
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  gap: 24px;
}

// 文章区块
.article-section {
  margin-bottom: 48px;

  .section-header-inline {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 24px;

    .section-title-small {
      font-size: 20px;
      font-weight: 600;
      color: $text-primary;
      display: flex;
      align-items: center;
      gap: 10px;

      .title-icon {
        width: 22px;
        height: 22px;
        color: $primary-color;
      }
    }

    .more-link {
      font-size: 14px;
      color: $text-secondary;
      text-decoration: none;
      display: flex;
      align-items: center;
      gap: 4px;
      transition: color 0.3s;

      .arrow {
        transition: transform 0.3s;
      }

      &:hover {
        color: $primary-color;

        .arrow {
          transform: translateX(4px);
        }
      }
    }
  }

  .article-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 24px;
  }

  .article-list {
    display: flex;
    flex-direction: column;
    gap: 16px;
  }
}

// 文章卡片
.article-card {
  overflow: hidden;
  cursor: pointer;

  &.skeleton-card {
    pointer-events: none;
  }

  .article-cover {
    height: 160px;
    overflow: hidden;
    position: relative;
    border-radius: 12px 12px 0 0;

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.3s;
    }

    .default-cover {
      width: 100%;
      height: 100%;
      background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
      display: flex;
      align-items: center;
      justify-content: center;

      svg {
        width: 48px;
        height: 48px;
        color: rgba(91, 110, 225, 0.4);
      }
    }

    .featured-badge {
      position: absolute;
      top: 12px;
      left: 12px;
      background: $primary-color;
      color: white;
      padding: 4px 10px;
      border-radius: 12px;
      font-size: 12px;
      font-weight: 500;
    }

    .skeleton-cover {
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, #f0f0f0 25%, #e8e8e8 50%, #f0f0f0 75%);
      background-size: 400% 100%;
      animation: shimmer 1.4s ease infinite;
    }
  }

  .article-content {
    padding: 20px;

    .article-title {
      font-size: 16px;
      font-weight: 600;
      color: $text-primary;
      margin-bottom: 8px;
      line-height: 1.4;
      display: -webkit-box;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .article-summary {
      font-size: 13px;
      color: $text-secondary;
      line-height: 1.6;
      margin-bottom: 16px;
      display: -webkit-box;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .article-stats {
      display: flex;
      align-items: center;
      justify-content: space-between;

      .stat {
        font-size: 12px;
        color: $text-muted;
        display: flex;
        align-items: center;
        gap: 4px;
      }

      .publish-time {
        font-size: 12px;
        color: $text-muted;
      }
    }

    .skeleton-title {
      height: 18px;
      background: linear-gradient(90deg, #f0f0f0 25%, #e8e8e8 50%, #f0f0f0 75%);
      background-size: 400% 100%;
      border-radius: 4px;
      margin-bottom: 12px;
      animation: shimmer 1.4s ease infinite;
    }

    .skeleton-text {
      height: 14px;
      background: linear-gradient(90deg, #f0f0f0 25%, #e8e8e8 50%, #f0f0f0 75%);
      background-size: 400% 100%;
      border-radius: 4px;
      margin-bottom: 8px;
      animation: shimmer 1.4s ease infinite;

      &.short {
        width: 60%;
      }
    }
  }

  &:hover {
    .article-cover img {
      transform: scale(1.05);
    }
  }
}

// 文章列表项
.article-list-item {
  display: flex;
  gap: 20px;
  padding: 20px;
  cursor: pointer;

  .article-thumb {
    width: 180px;
    height: 120px;
    border-radius: 10px;
    overflow: hidden;
    flex-shrink: 0;

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.3s;
    }
  }

  .article-info {
    flex: 1;
    display: flex;
    flex-direction: column;

    .article-title {
      font-size: 17px;
      font-weight: 600;
      color: $text-primary;
      margin-bottom: 8px;
      line-height: 1.4;
    }

    .article-summary {
      font-size: 14px;
      color: $text-secondary;
      line-height: 1.6;
      margin-bottom: auto;
      display: -webkit-box;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .article-meta {
      display: flex;
      gap: 20px;
      margin-top: 12px;

      .meta-item {
        font-size: 13px;
        color: $text-muted;
        display: flex;
        align-items: center;
        gap: 4px;
      }
    }
  }

  &:hover {
    .article-thumb img {
      transform: scale(1.05);
    }
  }
}

// 空状态
.empty-state {
  padding: 60px 40px;
  text-align: center;

  .empty-icon {
    width: 64px;
    height: 64px;
    color: $text-muted;
    margin-bottom: 20px;
  }

  h3 {
    font-size: 18px;
    color: $text-primary;
    margin-bottom: 8px;
  }

  p {
    color: $text-secondary;
    font-size: 14px;
  }
}

// 分页
.pagination-wrapper {
  margin-top: 32px;
  text-align: center;

  ::v-deep .el-pagination {

    .btn-prev,
    .btn-next,
    .el-pager li {
      background: $glass-bg;
      backdrop-filter: blur(10px);
      border: 1px solid $glass-border;
      border-radius: 8px;

      &:hover {
        color: $primary-color;
        border-color: rgba(91, 110, 225, 0.3);
      }

      &.active {
        background: $primary-gradient;
        border-color: transparent;
        color: white;
      }
    }
  }
}

// 侧边栏
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

// 热门文章
.hot-articles {
  .hot-article-item {
    display: flex;
    align-items: center;
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

      .title {
        color: $primary-color;
      }
    }

    .rank {
      width: 22px;
      height: 22px;
      line-height: 22px;
      text-align: center;
      font-size: 12px;
      font-weight: bold;
      background: #f0f0f0;
      color: $text-muted;
      border-radius: 4px;
      flex-shrink: 0;

      &.rank-1 {
        background: linear-gradient(135deg, #ff6b6b, #ff8a80);
        color: #fff;
      }

      &.rank-2 {
        background: linear-gradient(135deg, #ffa502, #ffb74d);
        color: #fff;
      }

      &.rank-3 {
        background: linear-gradient(135deg, #ffd43b, #ffe082);
        color: #fff;
      }
    }

    .title {
      flex: 1;
      font-size: 14px;
      color: $text-primary;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      transition: color 0.3s;
    }

    .views {
      font-size: 12px;
      color: $text-muted;
      flex-shrink: 0;
    }
  }
}

// 分类列表
.categories {
  .category-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 12px;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s;

    &:hover {
      background: rgba(91, 110, 225, 0.08);

      .name {
        color: $primary-color;
      }
    }

    .name {
      font-size: 14px;
      color: $text-primary;
      transition: color 0.3s;
    }

    .count {
      font-size: 12px;
      color: $text-muted;
      background: rgba(0, 0, 0, 0.04);
      padding: 2px 8px;
      border-radius: 10px;
    }
  }
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

  0%,
  100% {
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

  0%,
  100% {
    transform: translateY(0);
  }

  50% {
    transform: translateY(-10px);
  }
}

@keyframes pulse-gentle {

  0%,
  100% {
    transform: translate(-50%, -50%) scale(1);
    box-shadow: 0 20px 60px rgba(91, 110, 225, 0.2), inset 0 -20px 40px rgba(91, 110, 225, 0.08);
  }

  50% {
    transform: translate(-50%, -50%) scale(1.03);
    box-shadow: 0 25px 70px rgba(91, 110, 225, 0.25), inset 0 -20px 40px rgba(91, 110, 225, 0.1);
  }
}

@keyframes spin {
  from {
    transform: rotate(0deg);
  }

  to {
    transform: rotate(360deg);
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

.loading-placeholder {
  display: inline-block;
  width: 40px;
  height: 24px;
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 400% 100%;
  border-radius: 4px;
  animation: shimmer 1.4s ease infinite;
}

// 响应式设计
@media (max-width: 1024px) {
  .hero-section .hero-content {
    flex-direction: column;
    text-align: center;
    gap: 48px;
  }

  .hero-section .hero-text {
    max-width: 100%;

    .hero-stats {
      justify-content: center;
    }

    .hero-actions {
      justify-content: center;
    }
  }

  .featured-section .feature-cards {
    grid-template-columns: 1fr;
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
    padding: 60px 0 80px;

    .hero-content {
      padding: 0 20px;
    }

    .hero-text {
      .hero-title {
        font-size: 36px;
      }

      .hero-stats {
        flex-wrap: wrap;
        gap: 24px;

        .stat-item {
          min-width: 80px;

          .stat-value {
            font-size: 24px;
          }
        }
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

    .hero-visual .visual-container {
      width: 240px;
      height: 240px;

      .central-orb {
        width: 120px;
        height: 120px;
      }
    }
  }

  .featured-section {
    padding: 60px 0;

    .banner-wrapper {
      margin: 0 20px 40px;
    }

    .feature-cards {
      padding: 0 20px;
    }
  }

  .content-grid {
    padding: 40px 20px;
  }

  .article-list-item {
    flex-direction: column;

    .article-thumb {
      width: 100%;
      height: 160px;
    }
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

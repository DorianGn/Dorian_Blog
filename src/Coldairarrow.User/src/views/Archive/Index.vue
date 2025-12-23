<template>
  <div class="archive-container">
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
              <span class="title-line">文章</span>
              <span class="title-line accent">归档</span>
            </h1>
            <p class="hero-subtitle">
              时光荏苒，记录成长的每一步
            </p>

            <!-- 统计数据 -->
            <div class="hero-stats">
              <div class="stat-item">
                <div class="stat-value">{{ total }}</div>
                <div class="stat-label">篇文章</div>
              </div>
              <div class="stat-item">
                <div class="stat-value">{{ yearCount }}</div>
                <div class="stat-label">年记录</div>
              </div>
              <div class="stat-item">
                <div class="stat-value">{{ categoryCount }}</div>
                <div class="stat-label">个分类</div>
              </div>
            </div>
          </div>

          <!-- 右侧装饰 -->
          <div class="hero-visual">
            <div class="visual-container">
              <div class="central-orb"></div>
              <div class="orb-glow"></div>
              <span class="orbit-icon icon-a">◇</span>
              <span class="orbit-icon icon-b">○</span>
              <span class="orbit-icon icon-c">☆</span>
              <span class="orbit-icon icon-d">△</span>
            </div>
          </div>
        </div>
      </section>

      <!-- 搜索和筛选区域 -->
      <section class="filter-section">
        <div class="filter-wrapper glass-card">
          <div class="search-box">
            <i class="el-icon-search"></i>
            <input
              v-model="searchKeyword"
              type="text"
              placeholder="搜索文章..."
              @input="handleSearch"
            />
          </div>
          <div class="filter-tags">
            <span
              class="filter-tag"
              :class="{ active: selectedCategory === '' }"
              @click="filterByCategory('')"
            >全部</span>
            <span
              v-for="category in categories"
              :key="category.Id"
              class="filter-tag"
              :class="{ active: selectedCategory === category.Id }"
              @click="filterByCategory(category.Id)"
            >{{ category.Name }}</span>
          </div>
        </div>
      </section>

      <!-- 时间线内容 -->
      <section class="timeline-section">
        <div v-loading="loading" class="timeline-wrapper">
          <div v-for="group in filteredGroups" :key="group.year" class="year-group">
            <div class="year-header glass-card">
              <h2 class="year-title">{{ group.year }}</h2>
              <span class="year-count">{{ getYearArticleCount(group) }} 篇文章</span>
            </div>

            <div class="months-container">
              <div v-for="month in group.months" :key="month.month" class="month-group">
                <div class="month-header">
                  <span class="month-icon">
                    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <rect x="3" y="4" width="18" height="18" rx="2" stroke="currentColor" stroke-width="2"/>
                      <path d="M16 2v4M8 2v4M3 10h18" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                    </svg>
                  </span>
                  <span class="month-title">{{ month.month }}月</span>
                  <span class="month-count">{{ month.articles.length }} 篇</span>
                </div>

                <div class="article-list">
                  <div
                    v-for="article in month.articles"
                    :key="article.Id"
                    class="article-item glass-card"
                    @click="goToArticle(article.Id)">
                    <div class="article-date">
                      <span class="day">{{ formatDay(article.PublishTime || article.CreateTime) }}</span>
                    </div>
                    <div class="article-info">
                      <h3 class="article-title">{{ article.Title }}</h3>
                      <p v-if="article.Summary" class="article-summary">{{ article.Summary }}</p>
                      <div class="article-meta">
                        <span v-if="article.CategoryName" class="meta-tag category">
                          <i class="el-icon-folder"></i> {{ article.CategoryName }}
                        </span>
                        <span class="meta-tag views">
                          <i class="el-icon-view"></i> {{ article.ViewCount || 0 }}
                        </span>
                        <span class="meta-tag likes">
                          <i class="el-icon-star-off"></i> {{ article.LikeCount || 0 }}
                        </span>
                      </div>
                    </div>
                    <div class="article-arrow">
                      <i class="el-icon-arrow-right"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div v-if="!loading && filteredGroups.length === 0" class="empty-state glass-card">
            <svg class="empty-icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8l-6-6z" stroke="currentColor" stroke-width="1.5"/>
              <path d="M14 2v6h6" stroke="currentColor" stroke-width="1.5"/>
            </svg>
            <h3>暂无文章</h3>
            <p>{{ searchKeyword ? '未找到匹配的文章' : '还没有发布任何文章' }}</p>
          </div>
        </div>
      </section>
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
          <router-link to="/about" class="footer-link">关于</router-link>
        </div>
      </div>
    </footer>
  </div>
</template>

<script>
import { getArticleList } from '@/api/article'
import { getCategoryList } from '@/api/category'

export default {
  name: 'ArchivePage',
  data() {
    return {
      articles: [],
      categories: [],
      loading: false,
      total: 0,
      searchKeyword: '',
      selectedCategory: '',
      particles: []
    }
  },
  computed: {
    archiveGroups() {
      const groups = {}

      this.articles.forEach(article => {
        const date = new Date(article.PublishTime || article.CreateTime)
        const year = date.getFullYear()
        const month = date.getMonth() + 1

        if (!groups[year]) {
          groups[year] = {}
        }
        if (!groups[year][month]) {
          groups[year][month] = []
        }
        groups[year][month].push(article)
      })

      return Object.keys(groups)
        .sort((a, b) => b - a)
        .map(year => ({
          year,
          months: Object.keys(groups[year])
            .sort((a, b) => b - a)
            .map(month => ({
              month,
              articles: groups[year][month]
            }))
        }))
    },
    filteredGroups() {
      if (!this.searchKeyword && !this.selectedCategory) {
        return this.archiveGroups
      }

      const keyword = this.searchKeyword.toLowerCase()
      const result = []

      this.archiveGroups.forEach(yearGroup => {
        const filteredMonths = []

        yearGroup.months.forEach(monthGroup => {
          const filteredArticles = monthGroup.articles.filter(article => {
            const matchKeyword = !keyword ||
              article.Title.toLowerCase().includes(keyword) ||
              (article.Summary && article.Summary.toLowerCase().includes(keyword))
            const matchCategory = !this.selectedCategory ||
              article.CategoryId === this.selectedCategory
            return matchKeyword && matchCategory
          })

          if (filteredArticles.length > 0) {
            filteredMonths.push({
              month: monthGroup.month,
              articles: filteredArticles
            })
          }
        })

        if (filteredMonths.length > 0) {
          result.push({
            year: yearGroup.year,
            months: filteredMonths
          })
        }
      })

      return result
    },
    yearCount() {
      return this.archiveGroups.length
    },
    categoryCount() {
      return this.categories.length
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
        this.fetchArticles(),
        this.fetchCategories()
      ])
    },

    async fetchArticles() {
      this.loading = true
      try {
        const res = await getArticleList({
          pageIndex: 1,
          pageRows: 500
        })
        this.articles = res.Data || []
        this.total = res.Total || 0
      } catch (error) {
        console.error('获取文章列表失败:', error)
      } finally {
        this.loading = false
      }
    },

    async fetchCategories() {
      try {
        const res = await getCategoryList()
        this.categories = res.Data || []
      } catch (error) {
        console.error('获取分类失败:', error)
      }
    },

    formatDay(date) {
      if (!date) return ''
      const d = new Date(date)
      return String(d.getDate()).padStart(2, '0')
    },

    goToArticle(id) {
      this.$router.push(`/article/${id}`)
    },

    handleSearch() {
      // 搜索时自动过滤
    },

    filterByCategory(categoryId) {
      this.selectedCategory = categoryId
    },

    getYearArticleCount(yearGroup) {
      return yearGroup.months.reduce((sum, month) => sum + month.articles.length, 0)
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

.archive-container {
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
  padding: 60px 0 80px;

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

    .hero-stats {
      display: flex;
      gap: 48px;

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
  }

  .hero-visual {
    flex-shrink: 0;

    .visual-container {
      position: relative;
      width: 280px;
      height: 280px;

      .central-orb {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 150px;
        height: 150px;
        background: linear-gradient(180deg, #ffffff 0%, #f8f9ff 100%);
        border-radius: 50%;
        transform: translate(-50%, -50%);
        box-shadow:
          0 30px 80px rgba(91, 110, 225, 0.15),
          0 10px 30px rgba(0, 0, 0, 0.05),
          inset 0 -30px 60px rgba(91, 110, 225, 0.06);
        animation: pulse-gentle 4s ease-in-out infinite;
      }

      .orb-glow {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 240px;
        height: 240px;
        background: radial-gradient(circle, rgba(91, 110, 225, 0.1) 0%, transparent 70%);
        border-radius: 50%;
        transform: translate(-50%, -50%);
        z-index: -1;
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

// 筛选区域
.filter-section {
  max-width: 1000px;
  margin: 0 auto;
  padding: 0 40px 40px;

  .filter-wrapper {
    padding: 24px 32px;
    display: flex;
    align-items: center;
    gap: 24px;
    flex-wrap: wrap;
  }

  .search-box {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 20px;
    background: rgba(255, 255, 255, 0.8);
    border: 1px solid rgba(102, 126, 234, 0.1);
    border-radius: 12px;
    min-width: 280px;

    i {
      color: $text-muted;
      font-size: 16px;
    }

    input {
      flex: 1;
      border: none;
      background: transparent;
      font-size: 14px;
      color: $text-primary;
      outline: none;

      &::placeholder {
        color: $text-muted;
      }
    }
  }

  .filter-tags {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
    flex: 1;

    .filter-tag {
      padding: 8px 18px;
      background: rgba(255, 255, 255, 0.6);
      border: 1px solid rgba(102, 126, 234, 0.1);
      border-radius: 20px;
      font-size: 13px;
      color: $text-secondary;
      cursor: pointer;
      transition: all 0.3s;

      &:hover {
        background: rgba(91, 110, 225, 0.1);
        border-color: rgba(91, 110, 225, 0.2);
        color: $primary-color;
      }

      &.active {
        background: $primary-gradient;
        border-color: transparent;
        color: white;
      }
    }
  }
}

// 时间线区域
.timeline-section {
  max-width: 1000px;
  margin: 0 auto;
  padding: 0 40px 80px;
}

.timeline-wrapper {
  position: relative;

  &::before {
    content: '';
    position: absolute;
    left: 24px;
    top: 60px;
    bottom: 60px;
    width: 2px;
    background: linear-gradient(to bottom, rgba(102, 126, 234, 0.3), rgba(118, 75, 162, 0.3));
    border-radius: 1px;
  }
}

.year-group {
  margin-bottom: 48px;
  position: relative;

  .year-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 20px 32px;
    margin-bottom: 24px;
    position: relative;

    &::before {
      content: '';
      position: absolute;
      left: -16px;
      top: 50%;
      transform: translateY(-50%);
      width: 16px;
      height: 16px;
      background: $primary-gradient;
      border-radius: 50%;
      border: 3px solid #fff;
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.3);
    }

    .year-title {
      font-size: 28px;
      font-weight: 700;
      color: $text-primary;
      margin: 0;
    }

    .year-count {
      font-size: 14px;
      color: $text-muted;
      background: rgba(102, 126, 234, 0.1);
      padding: 6px 14px;
      border-radius: 20px;
    }
  }
}

.months-container {
  padding-left: 48px;
}

.month-group {
  margin-bottom: 32px;

  .month-header {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 16px;
    padding-left: 12px;

    .month-icon {
      width: 20px;
      height: 20px;
      color: $primary-color;

      svg {
        width: 100%;
        height: 100%;
      }
    }

    .month-title {
      font-size: 16px;
      font-weight: 600;
      color: $text-primary;
    }

    .month-count {
      font-size: 12px;
      color: $text-muted;
    }
  }
}

.article-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.article-item {
  display: flex;
  align-items: center;
  gap: 20px;
  padding: 20px 24px;
  cursor: pointer;

  &:hover {
    transform: translateX(4px);

    .article-arrow {
      opacity: 1;
      transform: translateX(0);
    }

    .article-title {
      color: $primary-color;
    }
  }

  .article-date {
    flex-shrink: 0;
    width: 48px;
    height: 48px;
    background: $primary-gradient;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;

    .day {
      font-size: 18px;
      font-weight: 700;
      color: white;
    }
  }

  .article-info {
    flex: 1;
    min-width: 0;

    .article-title {
      font-size: 16px;
      font-weight: 600;
      color: $text-primary;
      margin-bottom: 6px;
      transition: color 0.3s;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .article-summary {
      font-size: 13px;
      color: $text-secondary;
      margin-bottom: 8px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .article-meta {
      display: flex;
      gap: 16px;

      .meta-tag {
        font-size: 12px;
        color: $text-muted;
        display: flex;
        align-items: center;
        gap: 4px;

        i {
          font-size: 12px;
        }

        &.category {
          color: $primary-color;
        }
      }
    }
  }

  .article-arrow {
    flex-shrink: 0;
    color: $text-muted;
    opacity: 0;
    transform: translateX(-8px);
    transition: all 0.3s;
  }
}

// 空状态
.empty-state {
  padding: 80px 40px;
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

@keyframes pulse-gentle {
  0%, 100% {
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

// 响应式设计
@media (max-width: 1024px) {
  .hero-section .hero-content {
    flex-direction: column;
    text-align: center;
    gap: 40px;
  }

  .hero-section .hero-text {
    max-width: 100%;

    .hero-stats {
      justify-content: center;
    }
  }
}

@media (max-width: 768px) {
  .hero-section {
    padding: 40px 0 60px;

    .hero-content {
      padding: 0 20px;
    }

    .hero-text {
      .hero-title {
        font-size: 36px;
      }

      .hero-stats {
        gap: 32px;

        .stat-item .stat-value {
          font-size: 24px;
        }
      }
    }

    .hero-visual .visual-container {
      width: 200px;
      height: 200px;

      .central-orb {
        width: 100px;
        height: 100px;
      }
    }
  }

  .filter-section {
    padding: 0 20px 24px;

    .filter-wrapper {
      padding: 16px 20px;
      flex-direction: column;
      align-items: stretch;
    }

    .search-box {
      min-width: auto;
    }
  }

  .timeline-section {
    padding: 0 20px 60px;
  }

  .timeline-wrapper::before {
    left: 12px;
  }

  .year-group .year-header {
    padding: 16px 20px;
    margin-left: 24px;

    &::before {
      left: -32px;
      width: 12px;
      height: 12px;
    }

    .year-title {
      font-size: 22px;
    }
  }

  .months-container {
    padding-left: 32px;
  }

  .article-item {
    padding: 16px;
    flex-wrap: wrap;

    .article-date {
      width: 40px;
      height: 40px;

      .day {
        font-size: 14px;
      }
    }

    .article-info {
      .article-summary {
        display: none;
      }
    }

    .article-arrow {
      display: none;
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

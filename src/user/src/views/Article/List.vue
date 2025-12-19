<template>
  <div class="articles-container">
    <!-- 背景动态效果 -->
    <div class="background-animation">
      <div class="background-image"></div>
      <div class="particles-container">
        <div class="particle" v-for="n in 30" :key="n"
             :style="{
               left: Math.random() * 100 + '%',
               top: Math.random() * 100 + '%',
               animationDelay: Math.random() * 20 + 's',
               animationDuration: (Math.random() * 10 + 10) + 's'
             }">
        </div>
      </div>
    </div>

    <!-- 页头 -->
    <section class="page-header">
      <div class="header-content">
        <h1 class="page-title">
          <span class="title-icon">
            <i class="el-icon-document"></i>
          </span>
          文章列表
        </h1>
        <p class="page-desc">共 {{ total }} 篇文章，记录技术成长的点点滴滴</p>
      </div>
    </section>

    <!-- 主要内容区域 -->
    <main class="main-content">
      <div class="content-container">
        <!-- 筛选栏 -->
        <div class="filter-section glass-card">
          <div class="filter-row">
            <div class="category-filter">
              <span class="filter-label">
                <i class="el-icon-folder"></i> 分类筛选
              </span>
              <div class="filter-tags">
                <span
                  class="filter-tag"
                  :class="{ active: !currentCategory }"
                  @click="selectCategory(null)">
                  <i class="el-icon-s-grid"></i> 全部
                </span>
                <span
                  v-for="cat in categories"
                  :key="cat.Id"
                  class="filter-tag"
                  :class="{ active: currentCategory === cat.Id }"
                  @click="selectCategory(cat.Id)">
                  {{ cat.Name }}
                </span>
              </div>
            </div>
            <div class="search-box">
              <div class="search-input-wrapper">
                <i class="el-icon-search"></i>
                <input
                  v-model="keyword"
                  type="text"
                  placeholder="搜索文章..."
                  @keyup.enter="handleSearch">
                <button class="search-btn" @click="handleSearch">
                  搜索
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- 文章列表 -->
        <div class="articles-section">
          <div v-loading="loading" class="article-grid">
            <div
              v-for="article in articles"
              :key="article.Id"
              class="article-card glass-card"
              @click="goToArticle(article.Id)">
              <div class="article-cover">
                <img v-if="article.CoverImage" :src="article.CoverImage" :alt="article.Title" />
                <div v-else class="default-cover">
                  <i class="el-icon-document"></i>
                </div>
                <div class="article-badges">
                  <span v-if="article.IsTop" class="badge badge-top">
                    <i class="el-icon-top"></i> 置顶
                  </span>
                  <span v-if="article.IsRecommend" class="badge badge-recommend">
                    <i class="el-icon-star-on"></i> 推荐
                  </span>
                </div>
                <div class="category-badge" v-if="article.CategoryName">
                  {{ article.CategoryName }}
                </div>
              </div>
              <div class="article-body">
                <h3 class="article-title">{{ article.Title }}</h3>
                <p class="article-summary">{{ article.Summary || '暂无摘要' }}</p>
                <div class="article-footer">
                  <div class="article-stats">
                    <span class="stat">
                      <i class="el-icon-view"></i>
                      {{ article.ViewCount || 0 }}
                    </span>
                    <span class="stat">
                      <i class="el-icon-star-off"></i>
                      {{ article.LikeCount || 0 }}
                    </span>
                    <span class="stat">
                      <i class="el-icon-chat-dot-round"></i>
                      {{ article.CommentCount || 0 }}
                    </span>
                  </div>
                  <div class="article-time">
                    <i class="el-icon-time"></i>
                    {{ formatTime(article.CreateTime) }}
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- 空状态 -->
          <div v-if="!loading && articles.length === 0" class="empty-state glass-card">
            <div class="empty-content">
              <i class="el-icon-document empty-icon"></i>
              <h3>暂无文章</h3>
              <p v-if="keyword">没有找到与"{{ keyword }}"相关的文章</p>
              <p v-else-if="currentCategory">该分类下暂无文章</p>
              <p v-else>还没有发布任何文章</p>
              <button v-if="keyword || currentCategory" class="reset-btn" @click="resetFilters">
                <i class="el-icon-refresh"></i> 重置筛选
              </button>
            </div>
          </div>

          <!-- 分页 -->
          <div v-if="total > pageSize" class="pagination-wrapper">
            <el-pagination
              background
              layout="prev, pager, next, total"
              :total="total"
              :page-size="pageSize"
              :current-page.sync="currentPage"
              @current-change="handlePageChange">
            </el-pagination>
          </div>
        </div>
      </div>
    </main>

    <!-- 底部 -->
    <footer class="blog-footer">
      <div class="footer-content glass-card">
        <div class="footer-left">
          <div class="footer-logo">
            <i class="el-icon-s-home"></i>
            <span>知识博客</span>
          </div>
          <p class="footer-text">&copy; 2025 All rights reserved.</p>
        </div>

        <div class="footer-links">
          <router-link to="/" class="footer-link">首页</router-link>
          <router-link to="/articles" class="footer-link">文章</router-link>
          <router-link to="/archive" class="footer-link">归档</router-link>
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
  name: 'ArticleList',
  data() {
    return {
      articles: [],
      categories: [],
      loading: false,
      currentPage: 1,
      pageSize: 12,
      total: 0,
      keyword: '',
      currentCategory: null,
      Math: Math
    }
  },
  created() {
    this.init()
  },
  watch: {
    '$route.query': {
      handler(query) {
        if (query.category) {
          this.currentCategory = query.category
          this.fetchArticles()
        }
      },
      immediate: true
    }
  },
  methods: {
    async init() {
      await this.fetchCategories()
      this.fetchArticles()
    },

    async fetchCategories() {
      try {
        const res = await getCategoryList()
        this.categories = res.Data || []
      } catch (error) {
        console.error('获取分类失败:', error)
      }
    },

    async fetchArticles() {
      this.loading = true
      try {
        const res = await getArticleList({
          pageIndex: this.currentPage,
          pageRows: this.pageSize,
          keyword: this.keyword,
          condition: this.keyword ? 'Title' : '',
          categoryId: this.currentCategory
        })
        this.articles = res.Data || []
        this.total = res.Total || 0
      } catch (error) {
        console.error('获取文章列表失败:', error)
      } finally {
        this.loading = false
      }
    },

    selectCategory(categoryId) {
      this.currentCategory = categoryId
      this.currentPage = 1
      this.fetchArticles()
    },

    handleSearch() {
      this.currentPage = 1
      this.fetchArticles()
    },

    handlePageChange(page) {
      this.currentPage = page
      this.fetchArticles()
      window.scrollTo({ top: 0, behavior: 'smooth' })
    },

    resetFilters() {
      this.keyword = ''
      this.currentCategory = null
      this.currentPage = 1
      this.fetchArticles()
    },

    goToArticle(id) {
      this.$router.push(`/article/${id}`)
    },

    formatTime(timeStr) {
      if (!timeStr) return '-'
      try {
        const date = new Date(timeStr)
        return date.toLocaleDateString('zh-CN', {
          year: 'numeric',
          month: 'long',
          day: 'numeric'
        })
      } catch (error) {
        return timeStr.split(' ')[0]
      }
    }
  }
}
</script>

<style lang="scss" scoped>
// 全局样式变量
$primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
$glass-bg: rgba(255, 255, 255, 0.6);
$glass-border: rgba(102, 126, 234, 0.15);
$glass-shadow: 0 8px 32px rgba(102, 126, 234, 0.1);
$text-primary: rgba(51, 51, 51, 0.9);
$text-secondary: rgba(102, 102, 102, 0.8);
$text-muted: rgba(153, 153, 153, 0.7);

// 玻璃形态样式
.glass-card {
  background: $glass-bg;
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid $glass-border;
  box-shadow: $glass-shadow;
  border-radius: 16px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);

  &:hover {
    background: rgba(255, 255, 255, 0.7);
    border-color: rgba(102, 126, 234, 0.25);
    box-shadow: 0 12px 48px rgba(102, 126, 234, 0.15);
  }
}

.articles-container {
  min-height: 100vh;
  background: #ffffff;
  position: relative;
  overflow-x: hidden;
}

// 背景动画
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
      background: radial-gradient(circle, rgba(102, 126, 234, 0.5) 0%, transparent 70%);
      border-radius: 50%;
      animation: float-particle linear infinite;

      &:nth-child(2n) {
        width: 3px;
        height: 3px;
      }

      &:nth-child(3n) {
        width: 2px;
        height: 2px;
      }
    }
  }
}

// 页头
.page-header {
  position: relative;
  z-index: 10;
  padding: 120px 40px 40px; // 70px header + spacing
  text-align: center;

  .header-content {
    max-width: 800px;
    margin: 0 auto;
    padding: 40px;
    background: $glass-bg;
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border: 1px solid $glass-border;
    box-shadow: $glass-shadow;
    border-radius: 20px;
  }

  .page-title {
    font-size: 36px;
    font-weight: 700;
    margin-bottom: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 16px;
    color: $text-primary;

    .title-icon {
      width: 56px;
      height: 56px;
      background: $primary-gradient;
      border-radius: 14px;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 0 4px 16px rgba(102, 126, 234, 0.3);

      i {
        font-size: 26px;
        color: white;
      }
    }
  }

  .page-desc {
    font-size: 15px;
    color: $text-secondary;
    margin: 0;
  }
}

// 主要内容
.main-content {
  position: relative;
  z-index: 10;
  padding: 40px 0;
}

.content-container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 40px;
}

// 筛选栏
.filter-section {
  padding: 24px;
  margin-bottom: 40px;
  margin-top: -40px;

  .filter-row {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 24px;
    flex-wrap: wrap;
  }

  .category-filter {
    flex: 1;

    .filter-label {
      display: flex;
      align-items: center;
      gap: 6px;
      font-size: 14px;
      font-weight: 600;
      color: $text-primary;
      margin-bottom: 12px;

      i {
        color: #667eea;
      }
    }

    .filter-tags {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
    }

    .filter-tag {
      padding: 8px 16px;
      border-radius: 20px;
      font-size: 14px;
      color: $text-secondary;
      background: rgba(0, 0, 0, 0.04);
      cursor: pointer;
      transition: all 0.3s;
      display: flex;
      align-items: center;
      gap: 4px;

      &:hover {
        background: rgba(102, 126, 234, 0.1);
        color: #667eea;
      }

      &.active {
        background: $primary-gradient;
        color: #fff;
      }
    }
  }

  .search-box {
    flex-shrink: 0;

    .search-input-wrapper {
      display: flex;
      align-items: center;
      gap: 12px;
      background: rgba(0, 0, 0, 0.04);
      border-radius: 24px;
      padding: 4px 4px 4px 16px;
      transition: all 0.3s;

      &:focus-within {
        background: rgba(102, 126, 234, 0.08);
        box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.2);
      }

      i {
        color: $text-muted;
        font-size: 16px;
      }

      input {
        border: none;
        background: transparent;
        outline: none;
        width: 180px;
        font-size: 14px;
        color: $text-primary;

        &::placeholder {
          color: $text-muted;
        }
      }

      .search-btn {
        padding: 8px 20px;
        background: $primary-gradient;
        color: #fff;
        border: none;
        border-radius: 20px;
        font-size: 14px;
        cursor: pointer;
        transition: all 0.3s;

        &:hover {
          transform: scale(1.02);
          box-shadow: 0 4px 16px rgba(102, 126, 234, 0.4);
        }
      }
    }
  }
}

// 文章网格
.articles-section {
  .article-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
    gap: 28px;
    min-height: 200px;
  }
}

// 文章卡片
.article-card {
  cursor: pointer;
  overflow: hidden;

  &:hover {
    transform: translateY(-4px);

    .article-cover img {
      transform: scale(1.08);
    }
  }

  .article-cover {
    position: relative;
    height: 200px;
    overflow: hidden;
    border-radius: 12px 12px 0 0;

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.4s ease;
    }

    .default-cover {
      width: 100%;
      height: 100%;
      background: $primary-gradient;
      display: flex;
      align-items: center;
      justify-content: center;

      i {
        font-size: 56px;
        color: white;
        opacity: 0.6;
      }
    }

    .article-badges {
      position: absolute;
      top: 12px;
      left: 12px;
      display: flex;
      gap: 8px;

      .badge {
        padding: 4px 10px;
        border-radius: 12px;
        font-size: 12px;
        display: flex;
        align-items: center;
        gap: 4px;

        &.badge-top {
          background: rgba(245, 108, 108, 0.9);
          color: white;
        }

        &.badge-recommend {
          background: rgba(255, 165, 0, 0.9);
          color: white;
        }
      }
    }

    .category-badge {
      position: absolute;
      bottom: 12px;
      right: 12px;
      padding: 6px 12px;
      background: rgba(0, 0, 0, 0.6);
      backdrop-filter: blur(10px);
      color: white;
      border-radius: 12px;
      font-size: 12px;
    }
  }

  .article-body {
    padding: 20px;

    .article-title {
      font-size: 18px;
      font-weight: 600;
      color: $text-primary;
      margin-bottom: 10px;
      line-height: 1.5;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .article-summary {
      font-size: 14px;
      color: $text-secondary;
      line-height: 1.7;
      margin-bottom: 16px;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .article-footer {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding-top: 12px;
      border-top: 1px solid rgba(0, 0, 0, 0.04);

      .article-stats {
        display: flex;
        gap: 16px;

        .stat {
          font-size: 13px;
          color: $text-muted;
          display: flex;
          align-items: center;
          gap: 4px;

          i {
            font-size: 14px;
          }
        }
      }

      .article-time {
        font-size: 12px;
        color: $text-muted;
        display: flex;
        align-items: center;
        gap: 4px;
      }
    }
  }
}

// 空状态
.empty-state {
  padding: 80px 40px;
  text-align: center;

  .empty-content {
    max-width: 400px;
    margin: 0 auto;

    .empty-icon {
      font-size: 72px;
      color: $text-muted;
      margin-bottom: 24px;
    }

    h3 {
      font-size: 22px;
      color: $text-primary;
      margin-bottom: 12px;
    }

    p {
      color: $text-secondary;
      margin-bottom: 24px;
    }

    .reset-btn {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 12px 24px;
      background: $primary-gradient;
      color: white;
      border: none;
      border-radius: 24px;
      font-size: 14px;
      cursor: pointer;
      transition: all 0.3s;

      &:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 24px rgba(102, 126, 234, 0.4);
      }
    }
  }
}

// 分页
.pagination-wrapper {
  margin-top: 48px;
  text-align: center;

  ::v-deep .el-pagination {
    .btn-prev, .btn-next, .el-pager li {
      background: $glass-bg;
      backdrop-filter: blur(10px);
      border: 1px solid $glass-border;
      border-radius: 8px;
      min-width: 36px;
      height: 36px;
      line-height: 36px;

      &:hover {
        background: rgba(102, 126, 234, 0.1);
        border-color: #667eea;
        color: #667eea;
      }

      &.active {
        background: $primary-gradient;
        border-color: transparent;
        color: white;
      }
    }

    .el-pagination__total {
      color: $text-secondary;
    }
  }
}

// 底部
.blog-footer {
  padding: 40px 0;
  margin-top: 60px;

  .footer-content {
    max-width: 1400px;
    margin: 0 auto;
    padding: 24px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;

    .footer-left {
      .footer-logo {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 18px;
        font-weight: 600;
        color: $text-primary;
        margin-bottom: 8px;

        i {
          font-size: 20px;
          color: #667eea;
        }
      }

      .footer-text {
        font-size: 14px;
        color: $text-secondary;
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
        transition: color 0.3s ease;

        &:hover {
          color: #667eea;
        }
      }
    }
  }
}

// 动画
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
    transform: translateY(-100px) translateX(50px);
    opacity: 0;
  }
}

// 响应式设计
@media (max-width: 1024px) {
  .page-header {
    padding: 100px 20px 30px;

    .header-content {
      padding: 30px;
    }

    .page-title {
      font-size: 28px;
    }
  }

  .content-container {
    padding: 0 20px;
  }

  .filter-section {
    .filter-row {
      flex-direction: column;
    }

    .search-box {
      width: 100%;

      .search-input-wrapper {
        width: 100%;

        input {
          flex: 1;
          width: auto;
        }
      }
    }
  }

  .article-grid {
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  }
}

@media (max-width: 768px) {
  .page-header {
    padding: 90px 16px 24px;

    .header-content {
      padding: 24px;
    }

    .page-title {
      font-size: 24px;
      flex-direction: column;
      gap: 12px;

      .title-icon {
        width: 48px;
        height: 48px;

        i {
          font-size: 22px;
        }
      }
    }
  }

  .article-grid {
    grid-template-columns: 1fr;
  }

  .footer-content {
    padding: 24px 20px;
    flex-direction: column;
    gap: 20px;
    text-align: center;
  }
}
</style>

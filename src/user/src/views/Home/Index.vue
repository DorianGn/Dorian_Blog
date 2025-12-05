<template>
  <div class="home-page">
    <!-- 轮播图 -->
    <section v-if="topArticles.length > 0" class="banner-section">
      <el-carousel height="400px" indicator-position="inside">
        <el-carousel-item v-for="article in topArticles" :key="article.Id">
          <div
            class="banner-item"
            :style="getBannerStyle(article)"
            @click="goToArticle(article.Id)">
            <div class="banner-overlay"></div>
            <div class="banner-content">
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
    </section>

    <!-- 主要内容 -->
    <div class="main-container">
      <div class="content-wrapper">
        <!-- 左侧：文章列表 -->
        <div class="left-content">
          <!-- 推荐文章 -->
          <section v-if="recommendArticles.length > 0" class="article-section">
            <div class="section-header">
              <h3 class="section-title">
                <i class="el-icon-star-on"></i> 推荐文章
              </h3>
            </div>
            <div class="article-grid">
              <article-card
                v-for="article in recommendArticles"
                :key="article.Id"
                :article="article"
              />
            </div>
          </section>

          <!-- 最新文章 -->
          <section class="article-section">
            <div class="section-header">
              <h3 class="section-title">
                <i class="el-icon-document"></i> 最新文章
              </h3>
              <router-link to="/articles" class="more-link">
                查看更多 <i class="el-icon-arrow-right"></i>
              </router-link>
            </div>

            <div v-loading="loading" class="article-list">
              <article-card
                v-for="article in latestArticles"
                :key="article.Id"
                :article="article"
              />
            </div>

            <div v-if="!loading && latestArticles.length === 0" class="empty-state">
              <el-empty description="暂无文章"></el-empty>
            </div>

            <!-- 分页 -->
            <div v-if="total > pageSize" class="pagination-wrapper">
              <el-pagination
                background
                layout="prev, pager, next"
                :total="total"
                :page-size="pageSize"
                :current-page.sync="currentPage"
                @current-change="handlePageChange">
              </el-pagination>
            </div>
          </section>
        </div>

        <!-- 右侧：侧边栏 -->
        <div class="right-sidebar">
          <!-- 热门文章 -->
          <el-card class="sidebar-card">
            <div slot="header" class="card-header">
              <i class="el-icon-trophy"></i> 热门文章
            </div>
            <div v-loading="loadingHot" class="hot-articles">
              <div
                v-for="(article, index) in hotArticles"
                :key="article.Id"
                class="hot-article-item"
                @click="goToArticle(article.Id)">
                <span class="rank" :class="'rank-' + (index + 1)">{{ index + 1 }}</span>
                <span class="title">{{ article.Title }}</span>
                <span class="views">{{ article.ViewCount }}</span>
              </div>
              <div v-if="!loadingHot && hotArticles.length === 0" class="empty-tip">
                暂无数据
              </div>
            </div>
          </el-card>

          <!-- 分类 -->
          <el-card class="sidebar-card">
            <div slot="header" class="card-header">
              <i class="el-icon-folder"></i> 文章分类
            </div>
            <div v-loading="loadingCategories" class="categories">
              <div
                v-for="category in categories"
                :key="category.Id"
                class="category-item"
                @click="goToCategory(category.Id)">
                <i class="el-icon-folder-opened"></i>
                <span class="name">{{ category.Name }}</span>
                <span class="count">({{ category.ArticleCount }})</span>
              </div>
              <div v-if="!loadingCategories && categories.length === 0" class="empty-tip">
                暂无分类
              </div>
            </div>
          </el-card>
        </div>
      </div>
    </div>
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
import ArticleCard from '@/components/Article/ArticleCard.vue'

export default {
  name: 'HomePage',
  components: {
    ArticleCard
  },
  data () {
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
      loadingHot: false,
      loadingCategories: false
    }
  },
  created () {
    this.init()
  },
  methods: {
    async init () {
      await Promise.all([
        this.fetchTopArticles(),
        this.fetchRecommendArticles(),
        this.fetchLatestArticles(),
        this.fetchHotArticles(),
        this.fetchCategories()
      ])
    },

    // 获取置顶文章
    async fetchTopArticles () {
      try {
        const res = await getTopArticles()
        this.topArticles = res.Data || []
      } catch (error) {
        console.error('获取置顶文章失败:', error)
      }
    },

    // 获取推荐文章
    async fetchRecommendArticles () {
      try {
        const res = await getRecommendArticles(6)
        this.recommendArticles = res.Data || []
      } catch (error) {
        console.error('获取推荐文章失败:', error)
      }
    },

    // 获取最新文章
    async fetchLatestArticles () {
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

    // 获取热门文章
    async fetchHotArticles () {
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

    // 获取分类
    async fetchCategories () {
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

    // 获取轮播图样式
    getBannerStyle (article) {
      if (article.CoverImage) {
        return {
          backgroundImage: `url(${article.CoverImage})`
        }
      }
      return {
        background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)'
      }
    },

    // 跳转到文章详情
    goToArticle (id) {
      this.$router.push(`/article/${id}`)
    },

    // 跳转到分类
    goToCategory (id) {
      this.$router.push(`/category/${id}`)
    },

    // 分页变化
    handlePageChange (page) {
      this.currentPage = page
      this.fetchLatestArticles()
      window.scrollTo({ top: 0, behavior: 'smooth' })
    }
  }
}
</script>

<style lang="scss" scoped>
.home-page {
  min-height: 100vh;
  background: #f5f7fa;
}

// 轮播图
.banner-section {
  width: 100%;

  .banner-item {
    width: 100%;
    height: 400px;
    background-size: cover;
    background-position: center;
    position: relative;
    cursor: pointer;

    .banner-overlay {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(to bottom, rgba(0,0,0,0.3), rgba(0,0,0,0.7));
    }

    .banner-content {
      position: absolute;
      bottom: 60px;
      left: 50%;
      transform: translateX(-50%);
      width: 1200px;
      max-width: 90%;
      color: #fff;
      z-index: 1;

      .banner-title {
        font-size: 32px;
        font-weight: bold;
        margin-bottom: 15px;
      }

      .banner-summary {
        font-size: 16px;
        margin-bottom: 15px;
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
          i {
            margin-right: 5px;
          }
        }
      }
    }
  }
}

// 主要内容区
.main-container {
  max-width: 1200px;
  margin: 30px auto;
  padding: 0 15px;
}

.content-wrapper {
  display: flex;
  gap: 30px;
}

.left-content {
  flex: 1;
  min-width: 0;
}

.right-sidebar {
  width: 320px;
  flex-shrink: 0;
}

// 文章区块
.article-section {
  background: #fff;
  border-radius: 8px;
  padding: 25px;
  margin-bottom: 25px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.05);

  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 2px solid #f0f0f0;

    .section-title {
      font-size: 20px;
      font-weight: bold;
      color: #333;

      i {
        margin-right: 8px;
        color: #409eff;
      }
    }

    .more-link {
      color: #409eff;
      font-size: 14px;
      text-decoration: none;

      &:hover {
        color: #66b1ff;
      }
    }
  }

  .article-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 20px;
  }

  .article-list {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }

  .empty-state {
    padding: 40px 0;
  }
}

.pagination-wrapper {
  margin-top: 30px;
  text-align: center;
}

// 侧边栏
.sidebar-card {
  margin-bottom: 20px;

  .card-header {
    font-weight: bold;
    font-size: 16px;

    i {
      margin-right: 6px;
      color: #409eff;
    }
  }

  .empty-tip {
    text-align: center;
    color: #999;
    padding: 20px 0;
    font-size: 14px;
  }
}

// 热门文章
.hot-articles {
  .hot-article-item {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 12px 0;
    border-bottom: 1px solid #f0f0f0;
    cursor: pointer;
    transition: all 0.3s;

    &:last-child {
      border-bottom: none;
    }

    &:hover {
      background: #f5f7fa;
      padding-left: 5px;

      .title {
        color: #409eff;
      }
    }

    .rank {
      width: 20px;
      height: 20px;
      line-height: 20px;
      text-align: center;
      font-size: 12px;
      font-weight: bold;
      background: #f0f0f0;
      color: #999;
      border-radius: 2px;
      flex-shrink: 0;

      &.rank-1 {
        background: #f56c6c;
        color: #fff;
      }

      &.rank-2 {
        background: #ff9800;
        color: #fff;
      }

      &.rank-3 {
        background: #ffc107;
        color: #fff;
      }
    }

    .title {
      flex: 1;
      font-size: 14px;
      color: #333;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .views {
      font-size: 12px;
      color: #999;
      flex-shrink: 0;
    }
  }
}

// 分类列表
.categories {
  display: flex;
  flex-direction: column;
  gap: 8px;

  .category-item {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 10px;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.3s;

    &:hover {
      background: #ecf5ff;
      color: #409eff;
    }

    i {
      font-size: 16px;
    }

    .name {
      flex: 1;
      font-size: 14px;
    }

    .count {
      font-size: 12px;
      color: #999;
    }
  }
}

// 响应式
@media (max-width: 1024px) {
  .content-wrapper {
    flex-direction: column;
  }

  .right-sidebar {
    width: 100%;
  }

  .article-grid {
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  }
}

@media (max-width: 768px) {
  .banner-content {
    .banner-title {
      font-size: 24px;
    }

    .banner-summary {
      font-size: 14px;
    }
  }

  .article-grid {
    grid-template-columns: 1fr;
  }
}
</style>

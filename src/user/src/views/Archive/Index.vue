<template>
  <div class="archive-page">
    <div class="page-header">
      <h1 class="page-title">归档</h1>
      <p class="page-desc">共 {{ total }} 篇文章</p>
    </div>

    <div class="main-container">
      <div v-loading="loading" class="timeline">
        <div v-for="group in archiveGroups" :key="group.year" class="year-group">
          <h2 class="year-title">{{ group.year }}</h2>

          <div v-for="month in group.months" :key="month.month" class="month-group">
            <h3 class="month-title">{{ month.month }}月</h3>

            <div class="article-list">
              <div
                v-for="article in month.articles"
                :key="article.Id"
                class="article-item"
                @click="goToArticle(article.Id)">
                <span class="date">{{ formatDay(article.PublishTime || article.CreatedTime) }}</span>
                <span class="title">{{ article.Title }}</span>
                <el-tag v-if="article.CategoryName" size="mini" effect="plain">
                  {{ article.CategoryName }}
                </el-tag>
              </div>
            </div>
          </div>
        </div>

        <div v-if="!loading && archiveGroups.length === 0" class="empty-state">
          <el-empty description="暂无文章"></el-empty>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getArticleList } from '@/api/article'

export default {
  name: 'ArchivePage',
  data() {
    return {
      articles: [],
      loading: false,
      total: 0
    }
  },
  computed: {
    archiveGroups() {
      const groups = {}

      this.articles.forEach(article => {
        const date = new Date(article.PublishTime || article.CreatedTime)
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

      // 转换为数组并排序
      const result = Object.keys(groups)
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

      return result
    }
  },
  created() {
    this.fetchArticles()
  },
  methods: {
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

    formatDay(date) {
      if (!date) return ''
      const d = new Date(date)
      return String(d.getDate()).padStart(2, '0')
    },

    goToArticle(id) {
      this.$router.push(`/article/${id}`)
    }
  }
}
</script>

<style lang="scss" scoped>
.archive-page {
  min-height: 100vh;
  background: #fafafa;
}

.page-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 60px 20px;
  text-align: center;
  color: #fff;

  .page-title {
    font-size: 32px;
    font-weight: 500;
    margin-bottom: 10px;
  }

  .page-desc {
    font-size: 14px;
    opacity: 0.8;
  }
}

.main-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 40px 20px;
}

.timeline {
  position: relative;
  padding-left: 30px;

  &::before {
    content: '';
    position: absolute;
    left: 6px;
    top: 0;
    bottom: 0;
    width: 2px;
    background: #e0e0e0;
  }
}

.year-group {
  margin-bottom: 40px;
}

.year-title {
  position: relative;
  font-size: 24px;
  font-weight: 600;
  color: #333;
  margin-bottom: 20px;

  &::before {
    content: '';
    position: absolute;
    left: -30px;
    top: 50%;
    transform: translateY(-50%);
    width: 14px;
    height: 14px;
    background: #667eea;
    border-radius: 50%;
    border: 3px solid #fff;
    box-shadow: 0 0 0 2px #667eea;
  }
}

.month-group {
  margin-bottom: 24px;
}

.month-title {
  font-size: 16px;
  font-weight: 500;
  color: #666;
  margin-bottom: 12px;
  padding-left: 10px;
}

.article-list {
  background: #fff;
  border-radius: 8px;
  overflow: hidden;
}

.article-item {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 14px 20px;
  cursor: pointer;
  transition: background 0.2s;
  border-bottom: 1px solid #f5f5f5;

  &:last-child {
    border-bottom: none;
  }

  &:hover {
    background: #f9f9f9;

    .title {
      color: #667eea;
    }
  }

  .date {
    width: 28px;
    height: 28px;
    line-height: 28px;
    text-align: center;
    background: #f0f0f0;
    border-radius: 4px;
    font-size: 13px;
    color: #666;
    flex-shrink: 0;
  }

  .title {
    flex: 1;
    font-size: 15px;
    color: #333;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    transition: color 0.2s;
  }
}

.empty-state {
  padding: 80px 0;
}

@media (max-width: 600px) {
  .page-header {
    padding: 40px 20px;

    .page-title {
      font-size: 24px;
    }
  }

  .timeline {
    padding-left: 20px;

    &::before {
      left: 4px;
    }
  }

  .year-title::before {
    left: -20px;
    width: 10px;
    height: 10px;
  }

  .article-item {
    padding: 12px 16px;
    gap: 12px;

    .title {
      font-size: 14px;
    }

    .el-tag {
      display: none;
    }
  }
}
</style>

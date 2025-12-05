<template>
  <div class="article-card" @click="goToDetail">
    <!-- 封面图 -->
    <div v-if="article.CoverImage" class="card-cover">
      <img :src="article.CoverImage" :alt="article.Title" loading="lazy" />
    </div>

    <!-- 内容 -->
    <div class="card-content">
      <!-- 标题 -->
      <h3 class="card-title">{{ article.Title }}</h3>

      <!-- 摘要 -->
      <p v-if="article.Summary" class="card-summary">{{ article.Summary }}</p>

      <!-- 元信息 -->
      <div class="card-meta">
        <span class="meta-item">
          <i class="el-icon-user"></i>
          {{ article.AuthorName || '佚名' }}
        </span>
        <span class="meta-item">
          <i class="el-icon-time"></i>
          {{ formatDate(article.PublishTime || article.CreatedTime) }}
        </span>
        <span class="meta-item">
          <i class="el-icon-view"></i>
          {{ article.ViewCount }}
        </span>
      </div>

      <!-- 标签 -->
      <div v-if="article.CategoryName" class="card-tags">
        <el-tag size="mini" type="primary">{{ article.CategoryName }}</el-tag>
        <el-tag v-if="article.IsTop === 1" size="mini" type="danger">置顶</el-tag>
        <el-tag v-if="article.IsRecommend === 1" size="mini" type="warning">推荐</el-tag>
      </div>
    </div>
  </div>
</template>

<script>
import { formatDate } from '@/utils/date'

export default {
  name: 'ArticleCard',
  props: {
    article: {
      type: Object,
      required: true
    }
  },
  methods: {
    formatDate (date) {
      return formatDate(date)
    },
    goToDetail () {
      this.$router.push(`/article/${this.article.Id}`)
    }
  }
}
</script>

<style lang="scss" scoped>
.article-card {
  background: #fff;
  border-radius: 8px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.3s;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);

  &:hover {
    transform: translateY(-4px);
    box-shadow: 0 4px 16px rgba(0,0,0,0.1);

    .card-title {
      color: #409eff;
    }
  }

  .card-cover {
    width: 100%;
    height: 200px;
    overflow: hidden;
    background: #f5f7fa;

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.3s;
    }
  }

  &:hover .card-cover img {
    transform: scale(1.05);
  }

  .card-content {
    padding: 20px;
  }

  .card-title {
    font-size: 18px;
    font-weight: bold;
    color: #333;
    margin-bottom: 12px;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    overflow: hidden;
    line-height: 1.4;
    transition: color 0.3s;
  }

  .card-summary {
    font-size: 14px;
    color: #666;
    line-height: 1.6;
    margin-bottom: 15px;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }

  .card-meta {
    display: flex;
    gap: 15px;
    font-size: 13px;
    color: #999;
    margin-bottom: 12px;

    .meta-item {
      display: flex;
      align-items: center;
      gap: 4px;

      i {
        font-size: 14px;
      }
    }
  }

  .card-tags {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
  }
}
</style>

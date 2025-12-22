<template>
  <div class="statistics-page">
    <!-- 核心数据统计 -->
    <a-row :gutter="16">
      <a-col :sm="24" :md="12" :xl="6" :style="{ marginBottom: '16px' }">
        <a-card :loading="loading" :bordered="false" class="stat-card">
          <a-statistic
            title="文章总数"
            :value="statistics.ArticleCount"
            :value-style="{ color: '#1890ff', fontWeight: 600 }">
            <template slot="prefix">
              <a-icon type="file-text" />
            </template>
          </a-statistic>
          <div class="stat-footer">
            今日新增 <span class="highlight">{{ statistics.TodayArticleCount }}</span> 篇
          </div>
        </a-card>
      </a-col>
      <a-col :sm="24" :md="12" :xl="6" :style="{ marginBottom: '16px' }">
        <a-card :loading="loading" :bordered="false" class="stat-card">
          <a-statistic
            title="总阅读量"
            :value="statistics.TotalViews"
            :value-style="{ color: '#52c41a', fontWeight: 600 }">
            <template slot="prefix">
              <a-icon type="eye" />
            </template>
          </a-statistic>
          <div class="stat-footer">
            平均阅读 <span class="highlight green">{{ statistics.ArticleCount > 0 ? Math.round(statistics.TotalViews / statistics.ArticleCount) : 0 }}</span> 次/篇
          </div>
        </a-card>
      </a-col>
      <a-col :sm="24" :md="12" :xl="6" :style="{ marginBottom: '16px' }">
        <a-card :loading="loading" :bordered="false" class="stat-card">
          <a-statistic
            title="评论总数"
            :value="statistics.CommentCount"
            :value-style="{ color: '#722ed1', fontWeight: 600 }">
            <template slot="prefix">
              <a-icon type="message" />
            </template>
          </a-statistic>
          <div class="stat-footer">
            今日新增 <span class="highlight purple">{{ statistics.TodayCommentCount }}</span> 条
          </div>
        </a-card>
      </a-col>
      <a-col :sm="24" :md="12" :xl="6" :style="{ marginBottom: '16px' }">
        <a-card :loading="loading" :bordered="false" class="stat-card">
          <a-statistic
            title="点赞总数"
            :value="statistics.LikeCount"
            :value-style="{ color: '#f5222d', fontWeight: 600 }">
            <template slot="prefix">
              <a-icon type="heart" />
            </template>
          </a-statistic>
          <div class="stat-footer">
            今日新增 <span class="highlight red">{{ statistics.TodayLikeCount }}</span> 个
          </div>
        </a-card>
      </a-col>
    </a-row>

    <!-- 更多统计数据 -->
    <a-row :gutter="16">
      <a-col :sm="24" :md="12" :xl="6" :style="{ marginBottom: '16px' }">
        <a-card :loading="loading" :bordered="false" class="stat-card">
          <a-statistic
            title="用户总数"
            :value="statistics.UserCount"
            :value-style="{ color: '#13c2c2', fontWeight: 600 }">
            <template slot="prefix">
              <a-icon type="user" />
            </template>
          </a-statistic>
          <div class="stat-footer">
            <a-icon type="team" style="margin-right: 4px;" /> 系统用户
          </div>
        </a-card>
      </a-col>
      <a-col :sm="24" :md="12" :xl="6" :style="{ marginBottom: '16px' }">
        <a-card :loading="loading" :bordered="false" class="stat-card">
          <a-statistic
            title="分类数量"
            :value="statistics.CategoryCount"
            :value-style="{ color: '#fa8c16', fontWeight: 600 }">
            <template slot="prefix">
              <a-icon type="folder" />
            </template>
          </a-statistic>
          <div class="stat-footer">
            <a-icon type="appstore" style="margin-right: 4px;" /> 内容分类
          </div>
        </a-card>
      </a-col>
      <a-col :sm="24" :md="12" :xl="6" :style="{ marginBottom: '16px' }">
        <a-card :loading="loading" :bordered="false" class="stat-card">
          <a-statistic
            title="本周文章"
            :value="statistics.WeekArticleCount"
            :value-style="{ color: '#2f54eb', fontWeight: 600 }">
            <template slot="prefix">
              <a-icon type="calendar" />
            </template>
          </a-statistic>
          <div class="stat-footer">
            <a-icon type="rise" style="margin-right: 4px;" /> 周统计
          </div>
        </a-card>
      </a-col>
      <a-col :sm="24" :md="12" :xl="6" :style="{ marginBottom: '16px' }">
        <a-card :loading="loading" :bordered="false" class="stat-card">
          <a-statistic
            title="本月文章"
            :value="statistics.MonthArticleCount"
            :value-style="{ color: '#eb2f96', fontWeight: 600 }">
            <template slot="prefix">
              <a-icon type="schedule" />
            </template>
          </a-statistic>
          <div class="stat-footer">
            <a-icon type="bar-chart" style="margin-right: 4px;" /> 月统计
          </div>
        </a-card>
      </a-col>
    </a-row>

    <!-- 文章排行榜 -->
    <a-row :gutter="16" style="margin-top: 8px;">
      <!-- 访问量最高 -->
      <a-col :sm="24" :md="12" :xl="8" :style="{ marginBottom: '16px' }">
        <a-card :bordered="false" :loading="loading">
          <template slot="title">
            <a-icon type="eye" style="color: #1890ff; margin-right: 8px;" />
            访问量排行
          </template>
          <div class="article-rank-list">
            <div
              v-for="(item, index) in statistics.MostViewedArticles"
              :key="item.Id"
              class="rank-item"
              @click="goToArticle(item.Id)">
              <span class="rank-num" :class="getRankClass(index)">{{ index + 1 }}</span>
              <div class="rank-info">
                <div class="rank-title" :title="item.Title">{{ item.Title }}</div>
                <div class="rank-meta">
                  <span><a-icon type="eye" /> {{ item.ViewCount }}</span>
                  <span><a-icon type="folder" /> {{ item.CategoryName }}</span>
                </div>
              </div>
            </div>
            <a-empty v-if="!statistics.MostViewedArticles || statistics.MostViewedArticles.length === 0" description="暂无数据" />
          </div>
        </a-card>
      </a-col>

      <!-- 点赞最多 -->
      <a-col :sm="24" :md="12" :xl="8" :style="{ marginBottom: '16px' }">
        <a-card :bordered="false" :loading="loading">
          <template slot="title">
            <a-icon type="heart" style="color: #f5222d; margin-right: 8px;" />
            点赞排行
          </template>
          <div class="article-rank-list">
            <div
              v-for="(item, index) in statistics.MostLikedArticles"
              :key="item.Id"
              class="rank-item"
              @click="goToArticle(item.Id)">
              <span class="rank-num" :class="getRankClass(index)">{{ index + 1 }}</span>
              <div class="rank-info">
                <div class="rank-title" :title="item.Title">{{ item.Title }}</div>
                <div class="rank-meta">
                  <span><a-icon type="heart" /> {{ item.LikeCount }}</span>
                  <span><a-icon type="folder" /> {{ item.CategoryName }}</span>
                </div>
              </div>
            </div>
            <a-empty v-if="!statistics.MostLikedArticles || statistics.MostLikedArticles.length === 0" description="暂无数据" />
          </div>
        </a-card>
      </a-col>

      <!-- 评论最多 -->
      <a-col :sm="24" :md="12" :xl="8" :style="{ marginBottom: '16px' }">
        <a-card :bordered="false" :loading="loading">
          <template slot="title">
            <a-icon type="message" style="color: #52c41a; margin-right: 8px;" />
            评论排行
          </template>
          <div class="article-rank-list">
            <div
              v-for="(item, index) in statistics.MostCommentedArticles"
              :key="item.Id"
              class="rank-item"
              @click="goToArticle(item.Id)">
              <span class="rank-num" :class="getRankClass(index)">{{ index + 1 }}</span>
              <div class="rank-info">
                <div class="rank-title" :title="item.Title">{{ item.Title }}</div>
                <div class="rank-meta">
                  <span><a-icon type="message" /> {{ item.CommentCount }}</span>
                  <span><a-icon type="folder" /> {{ item.CategoryName }}</span>
                </div>
              </div>
            </div>
            <a-empty v-if="!statistics.MostCommentedArticles || statistics.MostCommentedArticles.length === 0" description="暂无数据" />
          </div>
        </a-card>
      </a-col>
    </a-row>

    <!-- 热门文章（本周/本月切换） -->
    <a-row :gutter="16">
      <a-col :sm="24" :md="24" :style="{ marginBottom: '16px' }">
        <a-card :bordered="false" :loading="loading">
          <template slot="title">
            <a-icon type="fire" style="color: #fa541c; margin-right: 8px;" />
            热门文章
          </template>
          <template slot="extra">
            <a-radio-group v-model="hotArticleType" size="small" button-style="solid">
              <a-radio-button value="week">本周</a-radio-button>
              <a-radio-button value="month">本月</a-radio-button>
            </a-radio-group>
          </template>
          <div class="article-rank-list">
            <div
              v-for="(item, index) in currentHotArticles"
              :key="item.Id"
              class="rank-item"
              @click="goToArticle(item.Id)">
              <span class="rank-num" :class="getRankClass(index)">{{ index + 1 }}</span>
              <div class="rank-info">
                <div class="rank-title" :title="item.Title">{{ item.Title }}</div>
                <div class="rank-meta">
                  <span><a-icon type="eye" /> {{ item.ViewCount }}</span>
                  <span><a-icon type="heart" /> {{ item.LikeCount }}</span>
                  <span><a-icon type="message" /> {{ item.CommentCount }}</span>
                  <span><a-icon type="user" /> {{ item.AuthorName }}</span>
                </div>
              </div>
            </div>
            <a-empty v-if="!currentHotArticles || currentHotArticles.length === 0" :description="hotArticleType === 'week' ? '本周暂无热门文章' : '本月暂无热门文章'" />
          </div>
        </a-card>
      </a-col>
    </a-row>

    <!-- 今日新增文章 -->
    <a-card :bordered="false" :loading="loading" style="margin-bottom: 16px;">
      <template slot="title">
        <a-icon type="edit" style="color: #1890ff; margin-right: 8px;" />
        今日新增文章
      </template>
      <template slot="extra">
        <a-tag color="green">今日 {{ statistics.TodayArticleCount }} 篇</a-tag>
      </template>
      <a-table
        v-if="statistics.TodayArticles && statistics.TodayArticles.length > 0"
        :columns="todayArticleColumns"
        :dataSource="statistics.TodayArticles"
        :pagination="false"
        rowKey="Id"
        size="middle">
        <template slot="articleTitle" slot-scope="text, record">
          <a @click="goToArticle(record.Id)">{{ text }}</a>
        </template>
        <template slot="createdTime" slot-scope="text">
          {{ formatTime(text) }}
        </template>
      </a-table>
      <a-empty v-else description="今日暂无新增文章" />
    </a-card>
  </div>
</template>

<script>
import { Axios } from '@/utils/plugin/axios-plugin'

export default {
  data () {
    return {
      loading: true,
      hotArticleType: 'week',
      statistics: {
        ArticleCount: 0,
        CommentCount: 0,
        LikeCount: 0,
        UserCount: 0,
        TotalViews: 0,
        CategoryCount: 0,
        TodayArticleCount: 0,
        TodayCommentCount: 0,
        TodayLikeCount: 0,
        WeekArticleCount: 0,
        MonthArticleCount: 0,
        TodayArticles: [],
        WeekHotArticles: [],
        MonthHotArticles: [],
        MostLikedArticles: [],
        MostViewedArticles: [],
        MostCommentedArticles: []
      },
      todayArticleColumns: [
        { title: '标题', dataIndex: 'Title', scopedSlots: { customRender: 'articleTitle' }, ellipsis: true },
        { title: '作者', dataIndex: 'AuthorName', width: 100 },
        { title: '分类', dataIndex: 'CategoryName', width: 100 },
        { title: '阅读', dataIndex: 'ViewCount', width: 80 },
        { title: '点赞', dataIndex: 'LikeCount', width: 80 },
        { title: '评论', dataIndex: 'CommentCount', width: 80 },
        { title: '发布时间', dataIndex: 'CreatedTime', width: 160, scopedSlots: { customRender: 'createdTime' } }
      ]
    }
  },
  computed: {
    currentHotArticles () {
      return this.hotArticleType === 'week'
        ? this.statistics.WeekHotArticles
        : this.statistics.MonthHotArticles
    }
  },
  created () {
    this.fetchStatistics()
  },
  methods: {
    async fetchStatistics () {
      this.loading = true
      try {
        const res = await Axios.post('/Blog_Manage/Blog_Statistics/GetStatistics')
        if (res.Success && res.Data) {
          this.statistics = res.Data
        }
      } catch (error) {
        console.error('获取统计数据失败:', error)
        this.$message.error('获取统计数据失败')
      } finally {
        this.loading = false
      }
    },
    formatTime (dateStr) {
      if (!dateStr) return ''
      const date = new Date(dateStr)
      const year = date.getFullYear()
      const month = String(date.getMonth() + 1).padStart(2, '0')
      const day = String(date.getDate()).padStart(2, '0')
      const hours = String(date.getHours()).padStart(2, '0')
      const minutes = String(date.getMinutes()).padStart(2, '0')
      return `${year}-${month}-${day} ${hours}:${minutes}`
    },
    getRankClass (index) {
      if (index === 0) return 'rank-first'
      if (index === 1) return 'rank-second'
      if (index === 2) return 'rank-third'
      return ''
    },
    goTo (path) {
      this.$router.push(path)
    },
    goToArticle (id) {
      // 在新窗口打开用户端文章详情页
      window.open(`http://localhost:8080/#/article/${id}`, '_blank')
    }
  }
}
</script>

<style lang="less" scoped>
.statistics-page {
  padding: 0;
}

.stat-card {
  .ant-statistic {
    .ant-statistic-title {
      font-size: 14px;
      color: rgba(0, 0, 0, 0.45);
      margin-bottom: 8px;
    }

    .ant-statistic-content {
      font-size: 28px;

      .ant-statistic-content-prefix {
        margin-right: 8px;
        font-size: 20px;
      }
    }
  }

  .stat-footer {
    margin-top: 12px;
    padding-top: 12px;
    border-top: 1px solid #f0f0f0;
    font-size: 13px;
    color: rgba(0, 0, 0, 0.45);

    .highlight {
      color: #1890ff;
      font-weight: 600;

      &.green {
        color: #52c41a;
      }

      &.purple {
        color: #722ed1;
      }

      &.red {
        color: #f5222d;
      }
    }
  }
}

.article-rank-list {
  .rank-item {
    display: flex;
    align-items: flex-start;
    padding: 12px 0;
    border-bottom: 1px solid #f0f0f0;
    cursor: pointer;
    transition: all 0.3s;

    &:last-child {
      border-bottom: none;
    }

    &:hover {
      background-color: #fafafa;
      margin: 0 -24px;
      padding: 12px 24px;

      .rank-title {
        color: #1890ff;
      }
    }

    .rank-num {
      width: 24px;
      height: 24px;
      line-height: 24px;
      text-align: center;
      border-radius: 4px;
      font-size: 12px;
      font-weight: 600;
      background: #f0f0f0;
      color: #666;
      flex-shrink: 0;
      margin-right: 12px;

      &.rank-first {
        background: linear-gradient(135deg, #ffd700 0%, #ffb300 100%);
        color: #fff;
      }

      &.rank-second {
        background: linear-gradient(135deg, #c0c0c0 0%, #a0a0a0 100%);
        color: #fff;
      }

      &.rank-third {
        background: linear-gradient(135deg, #cd7f32 0%, #a56628 100%);
        color: #fff;
      }
    }

    .rank-info {
      flex: 1;
      min-width: 0;

      .rank-title {
        font-size: 14px;
        color: rgba(0, 0, 0, 0.85);
        margin-bottom: 6px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        transition: color 0.3s;
      }

      .rank-meta {
        font-size: 12px;
        color: rgba(0, 0, 0, 0.45);
        display: flex;
        gap: 12px;

        span {
          display: flex;
          align-items: center;
          gap: 4px;
        }
      }
    }
  }
}
</style>

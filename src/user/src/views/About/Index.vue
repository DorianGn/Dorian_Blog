<template>
  <div class="about-page">
    <div class="page-header">
      <h1 class="page-title">关于</h1>
    </div>

    <div class="main-container">
      <!-- 个人介绍 -->
      <section class="about-section">
        <div class="profile-card">
          <div class="avatar">
            <img src="@/assets/images/tou.jpg" alt="avatar" @error="handleAvatarError">
          </div>
          <h2 class="name">{{ siteName }}</h2>
          <p class="bio">一个热爱技术的开发者</p>
          <div class="social-links">
            <a href="https://github.com/DorianGn" target="_blank" class="social-link">
              <i class="el-icon-link"></i> GitHub
            </a>
            <a href="https://mail.163.com/js6/main.jsp?sid=YLEwzoRfVqQsRDFBpvHyrbpzSLsOQlBN&df=mail163_letter#module=welcome.WelcomeModule%7C%7B%7D" class="social-link">
              <i class="el-icon-message"></i> Email
            </a>
          </div>
        </div>
      </section>

      <!-- 关于本站 -->
      <section class="about-section">
        <h3 class="section-title">关于本站</h3>
        <div class="section-content">
          <p>欢迎来到我的个人博客！这里记录着我在技术学习和生活中的点滴感悟。</p>
          <p>本站主要分享以下内容：</p>
          <ul>
            <li>技术文章与学习笔记</li>
            <li>项目开发经验总结</li>
            <li>生活感悟与随笔</li>
          </ul>
        </div>
      </section>

      <!-- 技术栈 -->
      <section class="about-section">
        <h3 class="section-title">技术栈</h3>
        <div class="tech-stack">
          <span class="tech-tag">Vue.js</span>
          <span class="tech-tag">Element UI</span>
          <span class="tech-tag">.NET Core</span>
          <span class="tech-tag">SQL Server</span>
          <span class="tech-tag">JavaScript</span>
          <span class="tech-tag">HTML/CSS</span>
        </div>
      </section>

      <!-- 统计信息 -->
      <section class="about-section">
        <h3 class="section-title">站点统计</h3>
        <div class="stats-grid">
          <div class="stat-item">
            <div class="stat-value">{{ stats.articleCount }}</div>
            <div class="stat-label">文章数</div>
          </div>
          <div class="stat-item">
            <div class="stat-value">{{ stats.categoryCount }}</div>
            <div class="stat-label">分类数</div>
          </div>
          <div class="stat-item">
            <div class="stat-value">{{ stats.totalViews }}</div>
            <div class="stat-label">总访问</div>
          </div>
        </div>
      </section>

      <!-- 联系方式 -->
      <section class="about-section">
        <h3 class="section-title">联系我</h3>
        <div class="section-content">
          <p>如果你有任何问题或建议，欢迎通过以下方式联系我：</p>
          <ul class="contact-list">
            <li><i class="el-icon-message"></i> 邮箱:zhansfai@163.com</li>
            <li><i class="el-icon-link"></i> https://github.com/DorianGn</li>
          </ul>
        </div>
      </section>
    </div>
  </div>
</template>

<script>
import { getArticleList } from '@/api/article'
import { getCategoryList } from '@/api/category'

export default {
  name: 'AboutPage',
  data() {
    return {
      siteName: process.env.VUE_APP_TITLE || '我的博客',
      stats: {
        articleCount: 0,
        categoryCount: 0,
        totalViews: 0
      }
    }
  },
  created() {
    this.fetchStats()
  },
  methods: {
    async fetchStats() {
      try {
        const [articleRes, categoryRes] = await Promise.all([
          getArticleList({ pageIndex: 1, pageRows: 1 }),
          getCategoryList()
        ])
        this.stats.articleCount = articleRes.Total || 0
        this.stats.categoryCount = (categoryRes.Data || []).length
        this.stats.totalViews = this.stats.articleCount * 100
      } catch (error) {
        console.error('获取统计数据失败:', error)
      }
    },
    handleAvatarError(e) {
      e.target.style.display = 'none'
    }
  }
}
</script>

<style lang="scss" scoped>
.about-page {
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
  }
}

.main-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 40px 20px;
}

.about-section {
  background: #fff;
  border-radius: 8px;
  padding: 30px;
  margin-bottom: 20px;

  .section-title {
    font-size: 18px;
    font-weight: 500;
    color: #333;
    margin-bottom: 20px;
    padding-bottom: 12px;
    border-bottom: 1px solid #eee;
  }

  .section-content {
    color: #555;
    line-height: 1.8;

    p {
      margin-bottom: 12px;
    }

    ul {
      padding-left: 20px;
      margin: 12px 0;

      li {
        margin-bottom: 8px;
      }
    }
  }
}

// 个人卡片
.profile-card {
  text-align: center;

  .avatar {
    width: 100px;
    height: 100px;
    margin: 0 auto 20px;
    border-radius: 50%;
    overflow: hidden;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    display: flex;
    align-items: center;
    justify-content: center;

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  }

  .name {
    font-size: 22px;
    font-weight: 500;
    color: #333;
    margin-bottom: 8px;
  }

  .bio {
    color: #888;
    font-size: 14px;
    margin-bottom: 20px;
  }

  .social-links {
    display: flex;
    justify-content: center;
    gap: 20px;
  }

  .social-link {
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 8px 16px;
    background: #f5f5f5;
    border-radius: 20px;
    color: #666;
    text-decoration: none;
    font-size: 14px;
    transition: all 0.2s;

    &:hover {
      background: #333;
      color: #fff;
    }
  }
}

// 技术栈
.tech-stack {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;

  .tech-tag {
    padding: 8px 18px;
    background: #f5f5f5;
    border-radius: 20px;
    font-size: 14px;
    color: #555;
    transition: all 0.2s;

    &:hover {
      background: #667eea;
      color: #fff;
    }
  }
}

// 统计
.stats-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
  text-align: center;

  .stat-item {
    padding: 20px;
    background: #f9f9f9;
    border-radius: 8px;
  }

  .stat-value {
    font-size: 28px;
    font-weight: 600;
    color: #667eea;
    margin-bottom: 8px;
  }

  .stat-label {
    font-size: 14px;
    color: #888;
  }
}

// 联系方式
.contact-list {
  list-style: none;
  padding: 0;

  li {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 10px 0;
    color: #555;

    i {
      color: #667eea;
    }
  }
}

@media (max-width: 600px) {
  .page-header {
    padding: 40px 20px;

    .page-title {
      font-size: 24px;
    }
  }

  .stats-grid {
    grid-template-columns: 1fr;
  }

  .profile-card .social-links {
    flex-direction: column;
    align-items: center;
  }
}
</style>

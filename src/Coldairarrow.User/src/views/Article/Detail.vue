<template>
  <div class="article-detail-container">
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

    <!-- 加载状态 -->
    <div v-if="loading" class="loading-state">
      <div class="loading-content glass-card">
        <i class="el-icon-loading loading-icon"></i>
        <p>正在加载文章...</p>
      </div>
    </div>

    <!-- 文章不存在 -->
    <div v-else-if="!article" class="not-found-state">
      <div class="not-found-content glass-card">
        <i class="el-icon-warning-outline not-found-icon"></i>
        <h2>文章不存在</h2>
        <p>您访问的文章可能已被删除或不存在</p>
        <button class="back-btn" @click="$router.push('/')">
          <i class="el-icon-house"></i> 返回首页
        </button>
      </div>
    </div>

    <!-- 文章内容 -->
    <main v-else class="main-content">
      <div class="content-layout">
        <!-- 主体内容 -->
        <div class="article-main">
          <!-- 文章头部 -->
          <header class="article-header glass-card">
            <div class="header-top">
              <button class="back-link" @click="$router.back()">
                <i class="el-icon-arrow-left"></i>
                <span>返回</span>
              </button>
              <div class="category-badge" v-if="article.CategoryName">
                <i class="el-icon-folder"></i>
                {{ article.CategoryName }}
              </div>
            </div>

            <h1 class="article-title">{{ article.Title }}</h1>

            <div class="article-meta">
              <div class="meta-item author">
                <div class="author-avatar">
                  <img v-if="article.AuthorAvatar" :src="article.AuthorAvatar" :alt="article.AuthorName" class="avatar-img" />
                  <span v-else class="avatar-text">{{ (article.AuthorName || '匿').charAt(0) }}</span>
                </div>
                <span class="author-name">{{ article.AuthorName || '匿名' }}</span>
              </div>
              <div class="meta-item">
                <i class="el-icon-time"></i>
                <span>{{ formatDate(article.PublishTime || article.CreatedTime) }}</span>
              </div>
              <div class="meta-item">
                <i class="el-icon-view"></i>
                <span>{{ article.ViewCount || 0 }} 阅读</span>
              </div>
              <div class="meta-item">
                <i class="el-icon-star-off"></i>
                <span>{{ article.LikeCount || 0 }} 点赞</span>
              </div>
            </div>

            <!-- 封面图 -->
            <div v-if="article.CoverImage" class="article-cover">
              <img :src="article.CoverImage" :alt="article.Title">
            </div>
          </header>

          <!-- 文章正文 -->
          <article class="article-body glass-card">
            <div class="article-content" v-html="article.Content"></div>

            <!-- 文章底部操作 -->
            <footer class="article-actions">
              <button
                class="action-btn like-btn"
                :class="{ active: isLiked }"
                @click="handleLike">
                <i :class="isLiked ? 'el-icon-star-on' : 'el-icon-star-off'"></i>
                <span>{{ isLiked ? '已点赞' : '点赞' }}</span>
                <span class="count">{{ article.LikeCount || 0 }}</span>
              </button>
              <button class="action-btn comment-btn" @click="scrollToComments">
                <i class="el-icon-chat-dot-round"></i>
                <span>评论</span>
                <span class="count">{{ comments.length }}</span>
              </button>
              <button class="action-btn share-btn" @click="handleShare">
                <i class="el-icon-share"></i>
                <span>分享</span>
              </button>
            </footer>
          </article>

          <!-- 评论区 -->
          <section ref="commentSection" class="comment-section glass-card">
            <div class="section-header">
              <h3 class="section-title">
                <i class="el-icon-chat-line-round"></i>
                评论 <span class="comment-count">({{ comments.length }})</span>
              </h3>
            </div>

            <!-- 发表评论 -->
            <div v-if="isLogin" class="comment-form">
              <div class="form-header">
                <div class="user-avatar">
                  <img v-if="userInfo?.Avatar" :src="userInfo.Avatar" :alt="userInfo.UserName" class="avatar-img" />
                  <span v-else class="avatar-text">{{ (userInfo?.UserName || '我').charAt(0) }}</span>
                </div>
                <span class="form-label">
                  {{ replyTo ? `回复 @${replyTo.UserName}` : '发表评论' }}
                </span>
              </div>
              <div class="form-body">
                <textarea
                  v-model="commentContent"
                  :placeholder="replyTo ? `回复 @${replyTo.UserName}...` : '写下你的想法...'"
                  maxlength="500"
                  rows="4"></textarea>
                <div class="form-footer">
                  <span class="char-count">{{ commentContent.length }}/500</span>
                  <div class="form-actions">
                    <button v-if="replyTo" class="cancel-btn" @click="cancelReply">取消</button>
                    <button class="submit-btn" :disabled="!commentContent.trim() || submitting" @click="submitComment">
                      <i v-if="submitting" class="el-icon-loading"></i>
                      <span>{{ submitting ? '发布中...' : '发布评论' }}</span>
                    </button>
                  </div>
                </div>
              </div>
            </div>
            <div v-else class="login-tip">
              <i class="el-icon-user"></i>
              <span>请先</span>
              <router-link to="/login">登录</router-link>
              <span>后参与评论</span>
            </div>

            <!-- 评论列表 -->
            <div v-loading="loadingComments" class="comment-list">
              <!-- 父评论 -->
              <div v-for="parent in rootComments" :key="parent.Id" class="comment-thread">
                <!-- 父评论项 -->
                <div class="comment-item parent-comment">
                  <div class="comment-avatar">
                    <img v-if="parent.UserAvatar" :src="parent.UserAvatar" :alt="parent.UserName" class="avatar-img" />
                    <span v-else class="avatar-text">{{ (parent.UserName || '匿').charAt(0) }}</span>
                  </div>
                  <div class="comment-content">
                    <div class="comment-header">
                      <span class="comment-user">{{ parent.UserName || '匿名用户' }}</span>
                    </div>
                    <div class="comment-text" v-html="parent.Content"></div>
                    <div class="comment-footer">
                      <span class="comment-time">{{ formatDate(parent.CreatedTime) }}</span>
                      <div class="comment-actions">
                        <button class="action-link reply-link" @click="setReplyTo(parent)">
                          <i class="el-icon-chat-dot-square"></i> 回复
                        </button>
                        <button
                          v-if="canDeleteComment(parent)"
                          class="action-link delete-link"
                          @click="handleDeleteComment(parent)">
                          <i class="el-icon-delete"></i> 删除
                        </button>
                      </div>
                    </div>

                    <!-- 子评论列表 -->
                    <div v-if="getChildComments(parent.Id).length > 0" class="child-comments">
                      <div
                        v-for="child in getVisibleChildren(parent.Id)"
                        :key="child.Id"
                        class="comment-item child-comment">
                        <div class="comment-avatar small">
                          <img v-if="child.UserAvatar" :src="child.UserAvatar" :alt="child.UserName" class="avatar-img" />
                          <span v-else class="avatar-text">{{ (child.UserName || '匿').charAt(0) }}</span>
                        </div>
                        <div class="comment-content">
                          <div class="comment-header">
                            <span class="comment-user">{{ child.UserName || '匿名用户' }}</span>
                            <span v-if="child.ReplyToUserName" class="reply-info">
                              回复 <span class="reply-user">@{{ child.ReplyToUserName }}</span>
                            </span>
                          </div>
                          <div class="comment-text" v-html="child.Content"></div>
                          <div class="comment-footer">
                            <span class="comment-time">{{ formatDate(child.CreatedTime) }}</span>
                            <div class="comment-actions">
                              <button class="action-link reply-link" @click="setReplyTo(child, parent)">
                                <i class="el-icon-chat-dot-square"></i> 回复
                              </button>
                              <button
                                v-if="canDeleteComment(child)"
                                class="action-link delete-link"
                                @click="handleDeleteComment(child)">
                                <i class="el-icon-delete"></i> 删除
                              </button>
                            </div>
                          </div>
                        </div>
                      </div>
                      <!-- 展开更多按钮 -->
                      <div
                        v-if="getChildComments(parent.Id).length > 3 && !expandedComments[parent.Id]"
                        class="expand-more"
                        @click="toggleExpand(parent.Id)">
                        <i class="el-icon-arrow-down"></i>
                        展开更多回复 ({{ getChildComments(parent.Id).length - 3 }}条)
                      </div>
                      <div
                        v-if="expandedComments[parent.Id] && getChildComments(parent.Id).length > 3"
                        class="expand-more"
                        @click="toggleExpand(parent.Id)">
                        <i class="el-icon-arrow-up"></i>
                        收起回复
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div v-if="!loadingComments && comments.length === 0" class="no-comments">
                <i class="el-icon-chat-line-square"></i>
                <p>暂无评论，快来抢沙发吧~</p>
              </div>
            </div>
          </section>
        </div>

        <!-- 右侧边栏 -->
        <aside class="article-sidebar">
          <!-- 文章目录 -->
          <div class="sidebar-card glass-card toc-card">
            <div class="card-header">
              <i class="el-icon-notebook-2"></i>
              <span>文章目录</span>
            </div>
            <div class="toc-content">
              <p class="toc-empty">暂无目录</p>
            </div>
          </div>

          <!-- 相关文章 -->
          <div class="sidebar-card glass-card">
            <div class="card-header">
              <i class="el-icon-document"></i>
              <span>相关文章</span>
            </div>
            <div v-loading="loadingRelated" class="related-list">
              <div
                v-for="item in relatedArticles"
                :key="item.Id"
                class="related-item"
                @click="goToArticle(item.Id)">
                <div class="related-cover" v-if="item.CoverImage">
                  <img :src="item.CoverImage" :alt="item.Title" />
                </div>
                <div class="related-info">
                  <h4 class="related-title">{{ item.Title }}</h4>
                  <div class="related-meta">
                    <span><i class="el-icon-view"></i> {{ item.ViewCount || 0 }}</span>
                  </div>
                </div>
              </div>
              <div v-if="!loadingRelated && relatedArticles.length === 0" class="empty-tip">
                <i class="el-icon-folder-opened"></i>
                <p>暂无相关文章</p>
              </div>
            </div>
          </div>
        </aside>
      </div>
    </main>

    <!-- 底部 -->
    <footer class="blog-footer" v-if="article">
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
import { getArticleDetail, getArticleList, incrementViewCount } from '@/api/article'
import { getCommentList, addComment, deleteComment } from '@/api/component'
import { likeArticle, unlikeArticle, checkLikeStatus } from '@/api/like'
import { mapGetters } from 'vuex'

export default {
  name: 'ArticleDetail',
  data() {
    return {
      article: null,
      loading: true,
      comments: [],
      loadingComments: false,
      relatedArticles: [],
      loadingRelated: false,
      isLiked: false,
      likeId: null,
      commentContent: '',
      submitting: false,
      replyTo: null,
      replyToParent: null,
      expandedComments: {},
      Math: Math
    }
  },
  computed: {
    ...mapGetters('user', ['isLogin', 'userInfo']),
    // 获取所有父评论（没有 ParentId 的评论）
    rootComments() {
      return this.comments.filter(c => !c.ParentId)
    }
  },
  watch: {
    '$route.params.id': {
      immediate: true,
      handler(id) {
        if (id) {
          this.loadArticle(id)
        }
      }
    }
  },
  methods: {
    async loadArticle(id) {
      this.loading = true
      this.article = null

      try {
        const res = await getArticleDetail(id)
        if (res.Success && res.Data) {
          this.article = res.Data
          document.title = this.article.Title + ' - 博客'

          // 增加阅读量
          this.incrementView(id)

          // 并行加载其他数据
          this.loadComments()
          this.loadRelatedArticles()
          if (this.isLogin) {
            this.checkLikeStatus()
          }
        }
      } catch (error) {
        console.error('获取文章详情失败:', error)
      } finally {
        this.loading = false
      }
    },

    async incrementView(id) {
      try {
        const res = await incrementViewCount(id)
        if (res.Success && this.article) {
          // 更新本地显示的阅读量
          this.article.ViewCount = res.Data
        }
      } catch (error) {
        console.error('增加阅读量失败:', error)
      }
    },

    async loadComments() {
      this.loadingComments = true
      try {
        const res = await getCommentList(this.article.Id)
        this.comments = res.Data || []
      } catch (error) {
        console.error('获取评论失败:', error)
      } finally {
        this.loadingComments = false
      }
    },

    async loadRelatedArticles() {
      if (!this.article.CategoryId) return

      this.loadingRelated = true
      try {
        const res = await getArticleList({
          pageIndex: 1,
          pageRows: 5,
          categoryId: this.article.CategoryId
        })
        // 排除当前文章
        this.relatedArticles = (res.Data || []).filter(a => a.Id !== this.article.Id)
      } catch (error) {
        console.error('获取相关文章失败:', error)
      } finally {
        this.loadingRelated = false
      }
    },

    async checkLikeStatus() {
      try {
        const res = await checkLikeStatus(this.article.Id)
        if (res.Success && res.Data) {
          this.isLiked = true
          this.likeId = res.Data.Id
        } else {
          this.isLiked = false
          this.likeId = null
        }
      } catch (error) {
        console.error('检查点赞状态失败:', error)
      }
    },

    async handleLike() {
      if (!this.isLogin) {
        this.$message.warning('请先登录')
        this.$router.push({ path: '/login', query: { redirect: this.$route.fullPath } })
        return
      }

      try {
        if (this.isLiked) {
          await unlikeArticle(this.likeId)
          this.isLiked = false
          this.likeId = null
          this.article.LikeCount = Math.max(0, (this.article.LikeCount || 1) - 1)
        } else {
          const res = await likeArticle(this.article.Id)
          if (res.Success) {
            this.isLiked = true
            this.likeId = res.Data
            this.article.LikeCount = (this.article.LikeCount || 0) + 1
          }
        }
      } catch (error) {
        console.error('点赞操作失败:', error)
      }
    },

    handleShare() {
      if (navigator.clipboard) {
        navigator.clipboard.writeText(window.location.href)
        this.$message.success('链接已复制到剪贴板')
      } else {
        this.$message.info('请手动复制浏览器地址栏链接')
      }
    },

    setReplyTo(comment, parent = null) {
      if (!this.isLogin) {
        this.$message.warning('请先登录')
        return
      }
      this.replyTo = comment
      // 如果是回复子评论，记录其父评论
      this.replyToParent = parent || (comment.ParentId ? this.comments.find(c => c.Id === comment.ParentId) : comment)
    },

    cancelReply() {
      this.replyTo = null
      this.replyToParent = null
    },

    // 获取某个父评论的所有子评论
    getChildComments(parentId) {
      return this.comments.filter(c => c.ParentId === parentId)
    },

    // 获取可见的子评论（根据展开状态）
    getVisibleChildren(parentId) {
      const children = this.getChildComments(parentId)
      if (this.expandedComments[parentId]) {
        return children
      }
      return children.slice(0, 3)
    },

    // 切换展开/收起状态
    toggleExpand(parentId) {
      this.$set(this.expandedComments, parentId, !this.expandedComments[parentId])
    },

    async submitComment() {
      if (!this.commentContent.trim()) {
        this.$message.warning('请输入评论内容')
        return
      }

      this.submitting = true
      try {
        const data = {
          articleId: this.article.Id,
          content: this.commentContent.trim(),
          // 回复时，parentId 始终为父评论的 ID
          parentId: this.replyToParent?.Id || null,
          replyToUserId: this.replyTo?.UserId || null
        }
        const res = await addComment(data)
        if (res.Success) {
          this.$message.success('评论成功')
          this.commentContent = ''
          this.replyTo = null
          this.replyToParent = null
          this.loadComments()
          this.article.CommentCount = (this.article.CommentCount || 0) + 1
        }
      } catch (error) {
        console.error('发表评论失败:', error)
      } finally {
        this.submitting = false
      }
    },

    canDeleteComment(comment) {
      return this.isLogin && this.userInfo && comment.UserId === this.userInfo.Id
    },

    async handleDeleteComment(comment) {
      try {
        await this.$confirm('确定删除这条评论吗？', '提示', {
          type: 'warning'
        })
        await deleteComment(comment.Id)
        this.$message.success('删除成功')
        this.loadComments()
        this.article.CommentCount = Math.max(0, (this.article.CommentCount || 1) - 1)
      } catch (error) {
        if (error !== 'cancel') {
          console.error('删除评论失败:', error)
        }
      }
    },

    scrollToComments() {
      this.$refs.commentSection?.scrollIntoView({ behavior: 'smooth' })
    },

    goToArticle(id) {
      this.$router.push(`/article/${id}`)
    },

    formatDate(date) {
      if (!date) return ''
      const d = new Date(date)
      const now = new Date()
      const diff = now - d

      if (diff < 60000) return '刚刚'
      if (diff < 3600000) return Math.floor(diff / 60000) + '分钟前'
      if (diff < 86400000) return Math.floor(diff / 3600000) + '小时前'
      if (diff < 2592000000) return Math.floor(diff / 86400000) + '天前'

      const year = d.getFullYear()
      const month = String(d.getMonth() + 1).padStart(2, '0')
      const day = String(d.getDate()).padStart(2, '0')
      return `${year}-${month}-${day}`
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
}

.article-detail-container {
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
    }
  }
}

// 加载状态
.loading-state,
.not-found-state {
  position: relative;
  z-index: 10;
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 110px 40px 40px; // 70px header + spacing
}

.loading-content,
.not-found-content {
  padding: 60px 80px;
  text-align: center;

  .loading-icon,
  .not-found-icon {
    font-size: 56px;
    color: #667eea;
    margin-bottom: 20px;
  }

  p {
    color: $text-secondary;
    font-size: 16px;
    margin: 0;
  }

  h2 {
    font-size: 24px;
    color: $text-primary;
    margin-bottom: 12px;
  }

  .back-btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 12px 28px;
    background: $primary-gradient;
    color: white;
    border: none;
    border-radius: 24px;
    font-size: 15px;
    cursor: pointer;
    margin-top: 24px;
    transition: all 0.3s;

    &:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 24px rgba(102, 126, 234, 0.4);
    }
  }
}

// 主内容
.main-content {
  position: relative;
  z-index: 10;
  padding: 110px 0 60px; // 70px header + 40px top padding
}

.content-layout {
  max-width: 1300px;
  margin: 0 auto;
  padding: 0 40px;
  display: flex;
  gap: 32px;
}

.article-main {
  flex: 1;
  min-width: 0;
}

.article-sidebar {
  width: 320px;
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  gap: 24px;
  position: sticky;
  top: 40px;
  align-self: flex-start;
}

// 文章头部
.article-header {
  padding: 32px;
  margin-bottom: 24px;

  .header-top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 24px;

    .back-link {
      display: flex;
      align-items: center;
      gap: 6px;
      color: $text-secondary;
      background: none;
      border: none;
      font-size: 14px;
      cursor: pointer;
      padding: 8px 16px;
      border-radius: 20px;
      transition: all 0.3s;

      &:hover {
        background: rgba(102, 126, 234, 0.1);
        color: #667eea;
      }
    }

    .category-badge {
      display: flex;
      align-items: center;
      gap: 6px;
      padding: 6px 14px;
      background: rgba(102, 126, 234, 0.1);
      color: #667eea;
      border-radius: 16px;
      font-size: 13px;
    }
  }

  .article-title {
    font-size: 32px;
    font-weight: 700;
    color: $text-primary;
    line-height: 1.4;
    margin-bottom: 24px;
  }

  .article-meta {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    padding-bottom: 24px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.06);

    .meta-item {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 14px;
      color: $text-secondary;

      i {
        font-size: 16px;
        color: $text-muted;
      }

      &.author {
        .author-avatar {
          width: 32px;
          height: 32px;
          border-radius: 50%;
          background: $primary-gradient;
          color: white;
          display: flex;
          align-items: center;
          justify-content: center;
          font-size: 14px;
          font-weight: 500;
          overflow: hidden;

          .avatar-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
          }

          .avatar-text {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            height: 100%;
          }
        }

        .author-name {
          font-weight: 500;
          color: $text-primary;
        }
      }
    }
  }

  .article-cover {
    margin-top: 24px;
    border-radius: 12px;
    overflow: hidden;

    img {
      width: 100%;
      max-height: 400px;
      object-fit: cover;
    }
  }
}

// 文章正文
.article-body {
  padding: 40px;
  margin-bottom: 24px;

  .article-content {
    font-size: 16px;
    line-height: 1.9;
    color: $text-primary;

    ::v-deep {
      img {
        max-width: 100%;
        border-radius: 8px;
        margin: 16px 0;
      }

      p {
        margin-bottom: 18px;
      }

      h1, h2, h3, h4, h5, h6 {
        margin: 32px 0 16px;
        font-weight: 600;
        color: $text-primary;
      }

      h1 { font-size: 28px; }
      h2 { font-size: 24px; }
      h3 { font-size: 20px; }

      pre {
        background: rgba(102, 126, 234, 0.05);
        padding: 20px;
        border-radius: 12px;
        overflow-x: auto;
        margin: 20px 0;
        border: 1px solid $glass-border;
      }

      code {
        background: rgba(102, 126, 234, 0.08);
        padding: 3px 8px;
        border-radius: 4px;
        font-family: 'Fira Code', Consolas, Monaco, monospace;
        font-size: 14px;
      }

      blockquote {
        border-left: 4px solid #667eea;
        padding: 16px 20px;
        margin: 20px 0;
        background: rgba(102, 126, 234, 0.05);
        border-radius: 0 8px 8px 0;
        color: $text-secondary;
      }

      a {
        color: #667eea;
        text-decoration: none;

        &:hover {
          text-decoration: underline;
        }
      }

      ul, ol {
        padding-left: 24px;
        margin-bottom: 16px;

        li {
          margin-bottom: 8px;
        }
      }

      table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;

        th, td {
          padding: 12px;
          border: 1px solid $glass-border;
          text-align: left;
        }

        th {
          background: rgba(102, 126, 234, 0.05);
          font-weight: 600;
        }
      }
    }
  }

  .article-actions {
    display: flex;
    justify-content: center;
    gap: 20px;
    padding-top: 32px;
    margin-top: 40px;
    border-top: 1px solid rgba(0, 0, 0, 0.06);

    .action-btn {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 12px 24px;
      border: 1px solid $glass-border;
      border-radius: 24px;
      background: $glass-bg;
      color: $text-secondary;
      font-size: 14px;
      cursor: pointer;
      transition: all 0.3s;

      i {
        font-size: 18px;
      }

      .count {
        padding-left: 8px;
        border-left: 1px solid rgba(0, 0, 0, 0.08);
        margin-left: 4px;
      }

      &:hover {
        border-color: #667eea;
        color: #667eea;
        background: rgba(102, 126, 234, 0.05);
      }

      &.like-btn.active {
        border-color: #f56c6c;
        color: #f56c6c;
        background: rgba(245, 108, 108, 0.08);
      }
    }
  }
}

// 评论区
.comment-section {
  padding: 32px;

  .section-header {
    margin-bottom: 24px;

    .section-title {
      font-size: 18px;
      font-weight: 600;
      color: $text-primary;
      display: flex;
      align-items: center;
      gap: 8px;

      i {
        color: #667eea;
      }

      .comment-count {
        font-weight: 400;
        color: $text-muted;
      }
    }
  }

  .comment-form {
    margin-bottom: 32px;

    .form-header {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 12px;

      .user-avatar {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background: $primary-gradient;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
        overflow: hidden;

        .avatar-img {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }

        .avatar-text {
          display: flex;
          align-items: center;
          justify-content: center;
          width: 100%;
          height: 100%;
        }
      }

      .form-label {
        font-size: 14px;
        color: $text-primary;
        font-weight: 500;
      }
    }

    .form-body {
      textarea {
        width: 100%;
        padding: 16px;
        border: 1px solid $glass-border;
        border-radius: 12px;
        background: rgba(255, 255, 255, 0.8);
        font-size: 14px;
        line-height: 1.6;
        resize: vertical;
        outline: none;
        transition: all 0.3s;

        &:focus {
          border-color: #667eea;
          box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        &::placeholder {
          color: $text-muted;
        }
      }

      .form-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 12px;

        .char-count {
          font-size: 12px;
          color: $text-muted;
        }

        .form-actions {
          display: flex;
          gap: 12px;

          .cancel-btn {
            padding: 8px 20px;
            border: 1px solid $glass-border;
            border-radius: 20px;
            background: white;
            color: $text-secondary;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;

            &:hover {
              border-color: #667eea;
              color: #667eea;
            }
          }

          .submit-btn {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 8px 24px;
            border: none;
            border-radius: 20px;
            background: $primary-gradient;
            color: white;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;

            &:hover:not(:disabled) {
              transform: translateY(-1px);
              box-shadow: 0 4px 16px rgba(102, 126, 234, 0.4);
            }

            &:disabled {
              opacity: 0.6;
              cursor: not-allowed;
            }
          }
        }
      }
    }
  }

  .login-tip {
    padding: 24px;
    text-align: center;
    background: rgba(102, 126, 234, 0.05);
    border-radius: 12px;
    color: $text-secondary;
    font-size: 14px;
    margin-bottom: 24px;

    i {
      margin-right: 8px;
      color: #667eea;
    }

    a {
      color: #667eea;
      text-decoration: none;
      font-weight: 500;
      margin: 0 4px;

      &:hover {
        text-decoration: underline;
      }
    }
  }

  .comment-list {
    .comment-thread {
      border-bottom: 1px solid rgba(0, 0, 0, 0.04);

      &:last-child {
        border-bottom: none;
      }
    }

    .comment-item {
      display: flex;
      gap: 16px;
      padding: 20px 0;

      &.parent-comment {
        padding-bottom: 12px;
      }

      &.child-comment {
        padding: 12px 0;
        border-bottom: none;
      }

      .comment-avatar {
        width: 44px;
        height: 44px;
        border-radius: 50%;
        background: $primary-gradient;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 16px;
        flex-shrink: 0;
        overflow: hidden;

        &.small {
          width: 32px;
          height: 32px;
          font-size: 12px;
        }

        .avatar-img {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }

        .avatar-text {
          display: flex;
          align-items: center;
          justify-content: center;
          width: 100%;
          height: 100%;
        }
      }

      .comment-content {
        flex: 1;
        min-width: 0;

        .comment-header {
          margin-bottom: 8px;

          .comment-user {
            font-weight: 500;
            color: $text-primary;
            font-size: 14px;
          }

          .reply-info {
            font-size: 13px;
            color: $text-muted;
            margin-left: 8px;

            .reply-user {
              color: #667eea;
            }
          }
        }

        .comment-text {
          font-size: 14px;
          color: $text-secondary;
          line-height: 1.7;
          word-break: break-word;
        }

        .comment-footer {
          display: flex;
          align-items: center;
          gap: 20px;
          margin-top: 12px;

          .comment-time {
            font-size: 12px;
            color: $text-muted;
          }

          .comment-actions {
            display: flex;
            gap: 16px;

            .action-link {
              display: flex;
              align-items: center;
              gap: 4px;
              background: none;
              border: none;
              font-size: 12px;
              color: $text-muted;
              cursor: pointer;
              padding: 0;
              transition: color 0.3s;

              &:hover {
                color: #667eea;
              }

              &.delete-link:hover {
                color: #f56c6c;
              }
            }
          }
        }

        // 子评论区域
        .child-comments {
          margin-top: 12px;
          padding-left: 8px;
          border-left: 2px solid rgba(102, 126, 234, 0.15);
          margin-left: 4px;
        }

        // 展开更多按钮
        .expand-more {
          display: flex;
          align-items: center;
          gap: 6px;
          padding: 10px 0;
          font-size: 13px;
          color: #667eea;
          cursor: pointer;
          transition: all 0.3s;

          i {
            font-size: 14px;
            transition: transform 0.3s;
          }

          &:hover {
            color: #764ba2;

            i {
              transform: translateY(2px);
            }
          }
        }
      }
    }

    .no-comments {
      text-align: center;
      padding: 48px 0;
      color: $text-muted;

      i {
        font-size: 48px;
        margin-bottom: 16px;
        display: block;
      }

      p {
        margin: 0;
        font-size: 14px;
      }
    }
  }
}

// 侧边栏
.sidebar-card {
  padding: 20px;

  .card-header {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 15px;
    font-weight: 600;
    color: $text-primary;
    padding-bottom: 16px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.06);
    margin-bottom: 16px;

    i {
      color: #667eea;
    }
  }

  .toc-content {
    .toc-empty {
      text-align: center;
      color: $text-muted;
      font-size: 13px;
      padding: 20px 0;
    }
  }

  .related-list {
    .related-item {
      display: flex;
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

        .related-title {
          color: #667eea;
        }
      }

      .related-cover {
        width: 60px;
        height: 45px;
        border-radius: 6px;
        overflow: hidden;
        flex-shrink: 0;

        img {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }
      }

      .related-info {
        flex: 1;
        min-width: 0;

        .related-title {
          font-size: 13px;
          color: $text-primary;
          line-height: 1.4;
          margin-bottom: 6px;
          display: -webkit-box;
          -webkit-box-orient: vertical;
          overflow: hidden;
          transition: color 0.3s;
        }

        .related-meta {
          font-size: 11px;
          color: $text-muted;
          display: flex;
          align-items: center;
          gap: 4px;
        }
      }
    }

    .empty-tip {
      text-align: center;
      padding: 24px 0;
      color: $text-muted;

      i {
        font-size: 32px;
        margin-bottom: 8px;
        display: block;
      }

      p {
        margin: 0;
        font-size: 13px;
      }
    }
  }
}

// 底部
.blog-footer {
  padding: 40px 0;
  margin-top: 40px;

  .footer-content {
    max-width: 1300px;
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
@media (max-width: 1100px) {
  .content-layout {
    flex-direction: column;
  }

  .article-sidebar {
    width: 100%;
    position: static;
    flex-direction: row;
    flex-wrap: wrap;

    .sidebar-card {
      flex: 1;
      min-width: 280px;
    }
  }
}

@media (max-width: 768px) {
  .content-layout {
    padding: 0 20px;
  }

  .article-header {
    padding: 24px;

    .article-title {
      font-size: 24px;
    }

    .article-meta {
      flex-direction: column;
      gap: 12px;
    }
  }

  .article-body {
    padding: 24px;

    .article-actions {
      flex-wrap: wrap;

      .action-btn {
        flex: 1;
        justify-content: center;
        min-width: 100px;
      }
    }
  }

  .comment-section {
    padding: 24px;
  }

  .article-sidebar {
    flex-direction: column;

    .sidebar-card {
      min-width: 100%;
    }
  }

  .footer-content {
    padding: 24px 20px;
    flex-direction: column;
    gap: 20px;
    text-align: center;
  }
}
</style>

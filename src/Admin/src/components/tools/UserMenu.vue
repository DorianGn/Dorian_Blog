<template>
  <div class="user-wrapper">
    <div class="content-box">
      
      <!-- <a href="https://pro.loacg.com/docs/getting-started" target="_blank">
        <span class="action">
          <a-icon type="question-circle-o"></a-icon>
        </span>
      </a> -->
      <!-- <notice-icon class="action" /> -->
      <a-dropdown>
        <span class="action ant-dropdown-link user-dropdown-menu">
          <a-avatar size="small" icon="user" />
          <span>{{ op().UserName }}</span>
        </span>
        <a-menu slot="overlay" class="user-dropdown-menu-wrapper">
          <a-menu-item key="1">
            <a href="javascript:;" @click="handleChangePwd()">
              <a-icon type="lock" />
              <span>修改密码</span>
            </a>
            <change-pwd-form ref="changePwd"></change-pwd-form>
          </a-menu-item>
          <a-menu-divider />
          <a-menu-item key="3">
            <a href="javascript:;" @click="handleLogout()">
              <a-icon type="logout" />
              <span>退出登录</span>
            </a>
          </a-menu-item>
        </a-menu>
      </a-dropdown>
      <span class="action" @click="handleOpenSetting" title="个性化设置">
        <a-icon type="setting" />
      </span>
    </div>
  </div>
</template>

<script>
// import NoticeIcon from '@/components/NoticeIcon'
// import { mapActions, mapGetters } from 'vuex'
import OperatorCache from '@/utils/cache/OperatorCache'
import TokenCache from '@/utils/cache/TokenCache'
import ChangePwdForm from './ChangePwdForm'

export default {
  name: 'UserMenu',
  components: {
    // NoticeIcon
    ChangePwdForm
  },
  methods: {
    op () {
      return OperatorCache.info
    },
    // ...mapActions(['Logout']),
    // ...mapGetters(['nickname', 'avatar']),
    handleLogout () {
      const that = this

      this.$confirm({
        title: '提示',
        content: '真的要注销登录吗 ?',
        onOk () {
          TokenCache.deleteToken()
          OperatorCache.clear()
          location.reload()
          // that.$router.push({ path: '/user/login' })
        }
      })
    },
    handleChangePwd () {
      this.$refs.changePwd.open()
    },
    handleOpenSetting () {
      this.$emit('openSetting')
    }
  }
}
</script>
<style lang="less" scoped>
.user-wrapper {
  display: flex;
  align-items: center;
  height: 100%;
  .content-box {
    display: flex;
    align-items: center;
    gap: 16px; // 修改 4️⃣：按钮间距
    .action {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      transition: all 0.3s;
      font-size: 16px;
      padding: 4px 8px;
      border-radius: 2px;
      &:hover {
        background-color: rgba(0, 0, 0, 0.1);
        color: #1890ff;
      }
      i {
        margin-right: 0;
      }
    }
    .user-dropdown-menu {
      i {
        margin-right: 8px;
      }
      span {
        margin-left: 4px;
      }
    }
  }
}
</style>
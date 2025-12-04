<template>
  <div :class="prefixCls">
    <!-- 搜索框 -->
    <div style="margin-bottom: 16px;">
      <a-input-search
        v-model="searchText"
        placeholder="搜索图标名称..."
        allow-clear
        @change="handleSearch">
        <a-icon slot="prefix" type="search" />
      </a-input-search>
      
      <!-- 当前选中的图标 -->
      <div v-if="selectedIcon" style="
        margin-top: 12px;
        padding: 12px;
        background: #f0f5ff;
        border: 1px solid #adc6ff;
        border-radius: 4px;
        display: flex;
        align-items: center;
        justify-content: space-between;
      ">
        <div style="display: flex; align-items: center; gap: 12px;">
          <a-icon :type="selectedIcon" :style="{ fontSize: '24px', color: '#1890ff' }" />
          <span style="color: #1890ff; font-weight: 500;">{{ selectedIcon }}</span>
        </div>
        <a-tag color="blue">已选中</a-tag>
      </div>
    </div>

    <!-- 图标分类标签页 -->
    <a-tabs v-model="currentTab" @change="handleTabChange" :animated="false">
      <a-tab-pane v-for="v in icons" :tab="v.title" :key="v.key">
        <!-- 过滤后的图标列表 -->
        <div v-if="getFilteredIcons(v.icons).length > 0">
          <ul>
            <li 
              v-for="(icon, key) in getFilteredIcons(v.icons)" 
              :key="`${v.key}-${key}`" 
              :class="{ 'active': selectedIcon == icon }"
              :title="icon"
              @click="handleSelectedIcon(icon)">
              <a-icon :type="icon" :style="{ fontSize: '28px' }" />
            </li>
          </ul>
        </div>
        <!-- 无搜索结果提示 -->
        <div v-else style="
          text-align: center;
          padding: 40px;
          color: #999;
        ">
          <a-icon type="inbox" :style="{ fontSize: '48px', marginBottom: '16px' }" />
          <div>未找到匹配的图标</div>
        </div>
      </a-tab-pane>
    </a-tabs>
  </div>
</template>

<script>
import icons from './icons'

export default {
  name: 'IconSelect',
  props: {
    prefixCls: {
      type: String,
      default: 'ant-pro-icon-selector'
    },
    value: {
      type: String
    }
  },
  data() {
    return {
      selectedIcon: this.value || '',
      currentTab: 'directional',
      searchText: '',  // 搜索文本
      icons
    }
  },
  watch: {
    value(val) {
      this.selectedIcon = val
      this.autoSwitchTab()
    }
  },
  created() {
    if (this.value) {
      this.autoSwitchTab()
    }
  },
  methods: {
    handleSelectedIcon(icon) {
      this.selectedIcon = icon
      this.$emit('change', icon)
      this.$emit('input', icon)  // 支持 v-model
    },
    handleTabChange(activeKey) {
      this.currentTab = activeKey
    },
    handleSearch() {
      // 搜索时自动切换到有结果的标签页
      if (this.searchText) {
        for (const item of this.icons) {
          const filtered = this.getFilteredIcons(item.icons)
          if (filtered.length > 0) {
            this.currentTab = item.key
            break
          }
        }
      }
    },
    // 根据搜索文本过滤图标
    getFilteredIcons(iconList) {
      if (!this.searchText) {
        return iconList
      }
      const searchLower = this.searchText.toLowerCase()
      return iconList.filter(icon => icon.toLowerCase().includes(searchLower))
    },
    autoSwitchTab() {
      icons.some(item => item.icons.some(icon => icon === this.value) && (this.currentTab = item.key))
    }
  }
}
</script>

<style lang="less" scoped>
@import "../index.less";

.ant-pro-icon-selector {
  :deep(.ant-tabs-nav-wrap) {
    padding: 0;
  }
  
  :deep(.ant-tabs-bar) {
    margin-bottom: 12px;
  }
}

ul {
  list-style: none;
  padding: 8px;
  margin: 0;
  overflow-y: auto;
  max-height: 320px;
  background: #fafafa;
  border-radius: 4px;
  border: 1px solid #f0f0f0;

  li {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 50px;
    height: 50px;
    margin: 4px;
    border-radius: 6px;
    border: 2px solid transparent;
    background: #fff;
    cursor: pointer;
    transition: all 0.3s ease;
    position: relative;

    &:hover {
      color: #1890ff;
      background: #e6f7ff;
      border-color: #91d5ff;
      transform: translateY(-2px);
      box-shadow: 0 2px 8px rgba(24, 144, 255, 0.2);
    }

    &.active {
      color: #fff;
      background: linear-gradient(135deg, #1890ff 0%, #096dd9 100%);
      border-color: #1890ff;
      box-shadow: 0 4px 12px rgba(24, 144, 255, 0.4);
      
      &::after {
        content: '✓';
        position: absolute;
        top: 2px;
        right: 2px;
        width: 16px;
        height: 16px;
        background: #52c41a;
        border-radius: 50%;
        font-size: 12px;
        line-height: 16px;
        text-align: center;
        color: #fff;
      }
      
      &:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(24, 144, 255, 0.5);
      }
    }
  }
}

// 滚动条样式
ul::-webkit-scrollbar {
  width: 8px;
}

ul::-webkit-scrollbar-track {
  background: #f0f0f0;
  border-radius: 4px;
}

ul::-webkit-scrollbar-thumb {
  background: #bfbfbf;
  border-radius: 4px;
  
  &:hover {
    background: #999;
  }
}
</style>

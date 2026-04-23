<template>
  <view class="container">
    <view class="header">
      <text class="title">CRM 数字化中心</text>
      <text class="subtitle">欢迎回来，今日数据概览</text>
    </view>
    
    <view class="stats-grid">
      <view class="stat-card">
        <text class="stat-value">128</text>
        <text class="stat-label">今日新增客户</text>
      </view>
      <view class="stat-card">
        <text class="stat-value">45</text>
        <text class="stat-label">进行中计划</text>
      </view>
      <view class="stat-card">
        <text class="stat-value">8,920</text>
        <text class="stat-label">营销总曝光</text>
      </view>
      <view class="stat-card">
        <text class="stat-value">¥12.5k</text>
        <text class="stat-label">预计收益</text>
      </view>
    </view>
    
    <view class="section">
      <view class="section-header">
        <text class="section-title">快捷入口</text>
      </view>
      <view class="menu-list">
        <view class="menu-item" @click="navTo('/pages/marketing/overview')">
          <text class="menu-text">营销概览</text>
          <text class="menu-icon">></text>
        </view>
        <view class="menu-item" @click="navTo('/pages/customer/list')">
          <text class="menu-text">客户列表</text>
          <text class="menu-icon">></text>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup>
const navTo = (url) => {
  uni.navigateTo({ url })
}
</script>

<style lang="scss">
.container {
  padding: 30rpx;
  background-color: #f8fafc;
  min-height: 100vh;
}

.header {
  margin-bottom: 40rpx;
  .title {
    font-size: 48rpx;
    font-weight: bold;
    color: #1e293b;
    display: block;
  }
  .subtitle {
    font-size: 28rpx;
    color: #64748b;
    margin-top: 10rpx;
    display: block;
  }
}

.stats-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20rpx;
  margin-bottom: 40rpx;
}

.stat-card {
  background: #ffffff;
  padding: 30rpx;
  border-radius: 16rpx;
  box-shadow: 0 4rpx 6rpx -1rpx rgba(0, 0, 0, 0.1);
  .stat-value {
    font-size: 40rpx;
    font-weight: 700;
    color: #2563eb;
    display: block;
  }
  .stat-label {
    font-size: 24rpx;
    color: #64748b;
    margin-top: 8rpx;
    display: block;
  }
}

.section {
  background: #ffffff;
  border-radius: 16rpx;
  padding: 20rpx;
  .section-header {
    padding: 10rpx 10rpx 20rpx;
    border-bottom: 1px solid #f1f5f9;
    .section-title {
      font-size: 32rpx;
      font-weight: 600;
      color: #334155;
    }
  }
}

.menu-list {
  .menu-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 30rpx 10rpx;
    border-bottom: 1px solid #f8fafc;
    &:last-child {
      border-bottom: none;
    }
    .menu-text {
      font-size: 28rpx;
      color: #475569;
    }
    .menu-icon {
      color: #cbd5e1;
      font-size: 32rpx;
    }
  }
}
</style>

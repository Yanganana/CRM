<template>
  <view class="container">
    <view class="header">
      <text class="title">营销计划</text>
      <text class="add-btn">+</text>
    </view>
    
    <view class="tabs">
      <text class="tab active">全部</text>
      <text class="tab">待执行</text>
      <text class="tab">进行中</text>
      <text class="tab">已完成</text>
    </view>
    
    <view class="plan-list">
      <view class="plan-card" v-for="i in 3" :key="i">
        <view class="card-header">
          <text class="plan-type">短信营销</text>
          <text class="plan-time">2024-05-01 开始</text>
        </view>
        <view class="card-body">
          <text class="plan-title">劳动节全量客户关怀计划</text>
          <view class="progress-bar">
            <view class="progress-inner" :style="{width: (30 * i) + '%'}"></view>
          </view>
          <view class="card-footer">
            <text class="status">进行中</text>
            <text class="stats">已覆盖 {{1000 * i}} 人</text>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<style lang="scss">
.container {
  padding: 30rpx;
  background: #f8fafc;
  min-height: 100vh;
}
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30rpx;
  .title {
    font-size: 40rpx;
    font-weight: bold;
  }
  .add-btn {
    font-size: 50rpx;
    color: #2563eb;
  }
}
.tabs {
  display: flex;
  margin-bottom: 30rpx;
  .tab {
    font-size: 26rpx;
    color: #64748b;
    margin-right: 40rpx;
    padding-bottom: 10rpx;
    &.active {
      color: #2563eb;
      font-weight: bold;
      border-bottom: 4rpx solid #2563eb;
    }
  }
}
.plan-card {
  background: #fff;
  border-radius: 20rpx;
  padding: 30rpx;
  margin-bottom: 20rpx;
  .card-header {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20rpx;
    .plan-type {
      font-size: 22rpx;
      color: #3b82f6;
      background: #eff6ff;
      padding: 4rpx 12rpx;
      border-radius: 6rpx;
    }
    .plan-time {
      font-size: 22rpx;
      color: #94a3b8;
    }
  }
  .plan-title {
    font-size: 30rpx;
    font-weight: 600;
    color: #1e293b;
    display: block;
    margin-bottom: 20rpx;
  }
  .progress-bar {
    height: 12rpx;
    background: #f1f5f9;
    border-radius: 6rpx;
    overflow: hidden;
    margin-bottom: 20rpx;
    .progress-inner {
      height: 100%;
      background: #2563eb;
      border-radius: 6rpx;
    }
  }
  .card-footer {
    display: flex;
    justify-content: space-between;
    .status {
      font-size: 24rpx;
      color: #2563eb;
    }
    .stats {
      font-size: 24rpx;
      color: #64748b;
    }
  }
}
</style>

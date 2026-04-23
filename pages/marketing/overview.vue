<template>
  <view class="container">
    <view class="header">
      <text class="title">营销概览</text>
    </view>
    
    <view class="chart-section">
      <view class="chart-card">
        <text class="chart-title">转化趋势</text>
        <view class="placeholder-chart">
          <!-- 实际开发中可以使用 uCharts 或 echarts -->
          <view class="bar" style="height: 60%"></view>
          <view class="bar" style="height: 80%"></view>
          <view class="bar" style="height: 40%"></view>
          <view class="bar" style="height: 90%"></view>
          <view class="bar" style="height: 70%"></view>
        </view>
      </view>
    </view>

    <view class="list-section">
      <view class="section-title">活跃活动</text>
      <view class="activity-card" v-for="i in 3" :key="i">
        <view class="activity-info">
          <text class="activity-name">夏季营销大促 #0{{i}}</text>
          <text class="activity-status">进行中</text>
        </view>
        <text class="activity-desc">覆盖范围：华东地区 | 参与人数：1,200+</text>
      </view>
    </view>
  </view>
</template>

<style lang="scss">
.container {
  padding: 30rpx;
}
.header {
  margin-bottom: 30rpx;
  .title {
    font-size: 40rpx;
    font-weight: bold;
  }
}
.chart-card {
  background: #fff;
  border-radius: 20rpx;
  padding: 30rpx;
  margin-bottom: 40rpx;
  .chart-title {
    font-size: 30rpx;
    font-weight: 600;
    margin-bottom: 20rpx;
    display: block;
  }
}
.placeholder-chart {
  height: 200rpx;
  display: flex;
  align-items: flex-end;
  justify-content: space-around;
  background: #f1f5f9;
  border-radius: 10rpx;
  padding: 20rpx;
  .bar {
    width: 40rpx;
    background: #3b82f6;
    border-radius: 6rpx 6rpx 0 0;
  }
}
.section-title {
  font-size: 32rpx;
  font-weight: 600;
  margin-bottom: 20rpx;
  display: block;
}
.activity-card {
  background: #fff;
  padding: 30rpx;
  border-radius: 16rpx;
  margin-bottom: 20rpx;
  .activity-info {
    display: flex;
    justify-content: space-between;
    margin-bottom: 10rpx;
    .activity-name {
      font-size: 28rpx;
      font-weight: 600;
    }
    .activity-status {
      font-size: 22rpx;
      color: #10b981;
      background: #ecfdf5;
      padding: 4rpx 12rpx;
      border-radius: 20rpx;
    }
  }
  .activity-desc {
    font-size: 24rpx;
    color: #64748b;
  }
}
</style>

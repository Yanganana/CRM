<template>
  <view class="container">
    <view class="profile-card">
      <view class="header">
        <view class="avatar">U</view>
        <view class="main-info">
          <text class="name">客户姓名</text>
          <text class="id">ID: 8829310</text>
        </view>
      </view>
      
      <view class="tags">
        <text class="tag">优质客户</text>
        <text class="tag">复购率高</text>
        <text class="tag">高客单价</text>
      </view>
    </view>
    
    <view class="detail-list">
      <view class="item">
        <text class="label">手机号码</text>
        <text class="value">138 0000 0000</text>
      </view>
      <view class="item">
        <text class="label">加入时间</text>
        <text class="value">2024-01-15</text>
      </view>
      <view class="item">
        <text class="label">总消费额</text>
        <text class="value">¥ 12,800.00</text>
      </view>
      <view class="item">
        <text class="label">最后跟进</text>
        <text class="value">2024-04-20 14:30</text>
      </view>
    </view>
    
    <button class="follow-btn">新增跟进记录</button>
  </view>
</template>

<style lang="scss">
.container {
  padding: 30rpx;
  background: #f8fafc;
  min-height: 100vh;
}
.profile-card {
  background: linear-gradient(135deg, #2563eb, #3b82f6);
  padding: 40rpx;
  border-radius: 24rpx;
  color: #fff;
  margin-bottom: 30rpx;
  .header {
    display: flex;
    align-items: center;
    .avatar {
      width: 100rpx;
      height: 100rpx;
      background: rgba(255, 255, 255, 0.2);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 40rpx;
      font-weight: bold;
    }
    .main-info {
      margin-left: 30rpx;
      .name {
        font-size: 36rpx;
        font-weight: 600;
        display: block;
      }
      .id {
        font-size: 24rpx;
        opacity: 0.8;
      }
    }
  }
  .tags {
    margin-top: 30rpx;
    display: flex;
    flex-wrap: wrap;
    gap: 15rpx;
    .tag {
      font-size: 20rpx;
      background: rgba(255, 255, 255, 0.15);
      padding: 6rpx 16rpx;
      border-radius: 30rpx;
    }
  }
}
.detail-list {
  background: #fff;
  border-radius: 20rpx;
  padding: 10rpx 30rpx;
  .item {
    display: flex;
    justify-content: space-between;
    padding: 30rpx 0;
    border-bottom: 1px solid #f1f5f9;
    &:last-child {
      border-bottom: none;
    }
    .label {
      font-size: 28rpx;
      color: #64748b;
    }
    .value {
      font-size: 28rpx;
      color: #1e293b;
      font-weight: 500;
    }
  }
}
.follow-btn {
  margin-top: 60rpx;
  background: #2563eb;
  color: #fff;
  border-radius: 50rpx;
  font-size: 30rpx;
  padding: 10rpx 0;
}
</style>

<template>
  <view class="container">
    <view class="search-bar">
      <icon type="search" size="14" color="#94a3b8" />
      <input type="text" placeholder="搜索客户姓名或手机号" />
    </view>
    
    <scroll-view scroll-y class="list-view">
      <view class="customer-item" v-for="i in 10" :key="i" @click="goDetail">
        <view class="avatar">{{String.fromCharCode(65 + i)}}</view>
        <view class="info">
          <view class="top">
            <text class="name">客户姓名 {{i}}</text>
            <text class="tag">高级会员</text>
          </view>
          <text class="phone">138 **** 000{{i}}</text>
        </view>
        <text class="arrow">></text>
      </view>
    </scroll-view>
  </view>
</template>

<script setup>
const goDetail = () => {
  uni.navigateTo({ url: '/pages/customer/detail' })
}
</script>

<style lang="scss">
.container {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background: #f8fafc;
}
.search-bar {
  background: #fff;
  margin: 20rpx;
  padding: 15rpx 30rpx;
  border-radius: 40rpx;
  display: flex;
  align-items: center;
  input {
    margin-left: 15rpx;
    font-size: 26rpx;
    flex: 1;
  }
}
.list-view {
  flex: 1;
  padding: 0 20rpx;
}
.customer-item {
  background: #fff;
  padding: 24rpx;
  border-radius: 16rpx;
  margin-bottom: 16rpx;
  display: flex;
  align-items: center;
  .avatar {
    width: 80rpx;
    height: 80rpx;
    background: #e2e8f0;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #475569;
    font-weight: bold;
  }
  .info {
    flex: 1;
    margin-left: 20rpx;
    .top {
      display: flex;
      align-items: center;
      .name {
        font-size: 30rpx;
        font-weight: 600;
        color: #1e293b;
      }
      .tag {
        font-size: 20rpx;
        background: #fef3c7;
        color: #d97706;
        padding: 2rpx 10rpx;
        border-radius: 6rpx;
        margin-left: 10rpx;
      }
    }
    .phone {
      font-size: 24rpx;
      color: #64748b;
      margin-top: 4rpx;
      display: block;
    }
  }
  .arrow {
    color: #cbd5e1;
  }
}
</style>

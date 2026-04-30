<template>
  <div class="page-grid">
    <div class="stats-grid stats-grid-4">
      <div class="stat-card">
        <span class="stat-title">待分派</span>
        <strong>0</strong>
      </div>
      <div class="stat-card">
        <span class="stat-title">待抢单</span>
        <strong>0</strong>
      </div>
      <div class="stat-card">
        <span class="stat-title">处理中</span>
        <strong>0</strong>
      </div>
      <div class="stat-card">
        <span class="stat-title">超时预警</span>
        <strong>0</strong>
      </div>
    </div>
    <PagePlaceholder
      title="服务台作业台首页"
      description="这里预留给服务台成员查看队列概况和快捷操作。"
      :modules="['工作台概览', '个人待办', '组内队列', 'SLA 风险摘要']"
    />
  </div>
</template>

<script setup>
import PagePlaceholder from "../../components/PagePlaceholder.vue";
</script>

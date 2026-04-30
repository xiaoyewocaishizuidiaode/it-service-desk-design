<template>
  <div class="page-grid">
    <div class="stats-grid stats-grid-3">
      <div class="stat-card">
        <span class="stat-title">我的申请</span>
        <strong>0</strong>
      </div>
      <div class="stat-card">
        <span class="stat-title">待确认</span>
        <strong>0</strong>
      </div>
      <div class="stat-card">
        <span class="stat-title">知识命中</span>
        <strong>0</strong>
      </div>
    </div>
    <PagePlaceholder
      title="员工门户首页"
      description="这里预留给员工工作台概览、快捷入口和知识推荐。"
      :modules="['我的待办概览', '快捷提单入口', '热门知识推荐', '最近申请记录']"
    />
  </div>
</template>

<script setup>
import PagePlaceholder from "../../components/PagePlaceholder.vue";
</script>

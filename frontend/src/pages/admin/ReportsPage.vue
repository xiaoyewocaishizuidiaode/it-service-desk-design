<template>
  <PagePlaceholder
    title="统计报表"
    description="这里预留给工单量、时效、知识命中率和人员工作量统计。"
    :modules="['概览看板', '时效统计', '分类分布', '人员工作量']"
  />
</template>

<script setup>
import PagePlaceholder from "../../components/PagePlaceholder.vue";
</script>

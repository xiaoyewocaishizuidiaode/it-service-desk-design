<template>
  <PagePlaceholder
    title="我已审批"
    description="这里预留给审批人查看历史审批记录。"
    :modules="['审批历史列表', '按结果筛选', '按系统筛选', '审批详情跳转']"
  />
</template>

<script setup>
import PagePlaceholder from "../../components/PagePlaceholder.vue";
</script>

<template>
  <PagePlaceholder
    title="待我审批"
    description="这里预留给直属主管和系统负责人处理待审批工单。"
    :modules="['审批待办列表', '快速通过/驳回', '风险信息展示', '审批意见输入']"
  />
</template>

<script setup>
import PagePlaceholder from "../../components/PagePlaceholder.vue";
</script>

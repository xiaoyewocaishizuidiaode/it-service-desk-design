<template>
  <PagePlaceholder
    title="超时预警"
    description="这里预留给服务台查看 SLA 风险和超时工单。"
    :modules="['响应超时', '解决超时', '告警级别', '催办与升级']"
  />
</template>

<script setup>
import PagePlaceholder from "../../components/PagePlaceholder.vue";
</script>

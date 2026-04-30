<template>
  <PagePlaceholder
    title="SLA 规则"
    description="这里预留给不同优先级的响应和解决时限配置。"
    :modules="['优先级规则', '响应时限', '解决时限', '告警策略']"
  />
</template>

<script setup>
import PagePlaceholder from "../../components/PagePlaceholder.vue";
</script>

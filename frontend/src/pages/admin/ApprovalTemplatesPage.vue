<template>
  <PagePlaceholder
    title="审批模板"
    description="这里预留给按系统敏感级别和权限类型配置审批链。"
    :modules="['模板列表', '节点配置', '审批角色', '启停控制']"
  />
</template>

<script setup>
import PagePlaceholder from "../../components/PagePlaceholder.vue";
</script>

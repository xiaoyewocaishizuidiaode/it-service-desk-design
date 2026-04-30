<template>
  <PagePlaceholder
    title="部门管理"
    description="这里预留给组织架构、部门树和负责人维护。"
    :modules="['部门树', '负责人维护', '层级关系', '同步标识']"
  />
</template>

<script setup>
import PagePlaceholder from "../../components/PagePlaceholder.vue";
</script>

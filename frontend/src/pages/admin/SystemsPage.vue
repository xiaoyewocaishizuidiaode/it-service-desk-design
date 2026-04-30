<template>
  <PagePlaceholder
    title="系统与权限"
    description="这里预留给目标系统、权限项和敏感级别配置。"
    :modules="['系统目录', '权限项维护', '敏感级别', '系统归属组']"
  />
</template>

<script setup>
import PagePlaceholder from "../../components/PagePlaceholder.vue";
</script>

<template>
  <PagePlaceholder
    title="发起申请"
    description="这里预留给账号与权限申请表单，以及提单前知识拦截。"
    :modules="['目标系统选择', '权限类型选择', '申请原因输入', '知识命中拦截', '附件上传']"
  />
</template>

<script setup>
import PagePlaceholder from "../../components/PagePlaceholder.vue";
</script>

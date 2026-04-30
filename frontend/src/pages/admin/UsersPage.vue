<template>
  <PagePlaceholder
    title="用户管理"
    description="这里预留给平台管理员维护员工、主管和服务台成员。"
    :modules="['用户列表', '角色分配', '状态启停', '主管关系维护']"
  />
</template>

<script setup>
import PagePlaceholder from "../../components/PagePlaceholder.vue";
</script>

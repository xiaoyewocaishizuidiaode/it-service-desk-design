<template>
  <div class="app-shell">
    <aside class="app-sider">
      <div class="brand-block">
        <h1>企业 IT 服务台</h1>
        <p>Vue 3 网页端空页面骨架</p>
      </div>
      <nav class="nav-sections">
        <section v-for="section in menuSections" :key="section.key" class="nav-section">
          <h2>{{ section.label }}</h2>
          <RouterLink
            v-for="item in section.children"
            :key="item.path"
            :to="item.path"
            class="nav-link"
            :class="{ active: route.path === item.path }"
          >
            {{ item.label }}
          </RouterLink>
        </section>
      </nav>
    </aside>
    <main class="app-main">
      <header class="app-header">
        <span>当前只搭页面骨架，具体业务逻辑留空</span>
      </header>
      <section class="app-content">
        <RouterView />
      </section>
    </main>
  </div>
</template>

<script setup>
import { RouterLink, RouterView, useRoute } from "vue-router";

const route = useRoute();

const menuSections = [
  {
    key: "portal",
    label: "员工门户",
    children: [
      { path: "/portal/home", label: "门户首页" },
      { path: "/portal/create", label: "发起申请" },
      { path: "/portal/my-tickets", label: "我的申请" },
      { path: "/portal/pending-confirm", label: "待确认" }
    ]
  },
  {
    key: "approval",
    label: "审批中心",
    children: [
      { path: "/approval/pending", label: "待我审批" },
      { path: "/approval/history", label: "我已审批" },
      { path: "/approval/detail", label: "审批详情" }
    ]
  },
  {
    key: "service-desk",
    label: "服务台作业台",
    children: [
      { path: "/service-desk/home", label: "作业台首页" },
      { path: "/service-desk/pending-assign", label: "待分派" },
      { path: "/service-desk/queue", label: "待抢单" },
      { path: "/service-desk/in-progress", label: "我的处理中" },
      { path: "/service-desk/alerts", label: "超时预警" },
      { path: "/service-desk/detail", label: "工单详情" }
    ]
  },
  {
    key: "admin",
    label: "管理后台",
    children: [
      { path: "/admin/users", label: "用户管理" },
      { path: "/admin/departments", label: "部门管理" },
      { path: "/admin/systems", label: "系统与权限" },
      { path: "/admin/approval-templates", label: "审批模板" },
      { path: "/admin/sla-policies", label: "SLA 规则" },
      { path: "/admin/knowledge", label: "知识库" },
      { path: "/admin/reports", label: "统计报表" },
      { path: "/admin/audit-logs", label: "审计日志" }
    ]
  }
];
</script>

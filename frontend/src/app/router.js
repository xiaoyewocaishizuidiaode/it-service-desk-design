import { createRouter, createWebHistory } from "vue-router";
import ApprovalTemplatesPage from "../pages/admin/ApprovalTemplatesPage.vue";
import AuditLogsPage from "../pages/admin/AuditLogsPage.vue";
import DepartmentsPage from "../pages/admin/DepartmentsPage.vue";
import KnowledgeAdminPage from "../pages/admin/KnowledgeAdminPage.vue";
import ReportsPage from "../pages/admin/ReportsPage.vue";
import SlaPoliciesPage from "../pages/admin/SlaPoliciesPage.vue";
import SystemsPage from "../pages/admin/SystemsPage.vue";
import UsersPage from "../pages/admin/UsersPage.vue";
import ApprovalDetailPage from "../pages/approval/ApprovalDetailPage.vue";
import ApprovalHistoryPage from "../pages/approval/ApprovalHistoryPage.vue";
import PendingApprovalsPage from "../pages/approval/PendingApprovalsPage.vue";
import CreateTicketPage from "../pages/portal/CreateTicketPage.vue";
import MyTicketsPage from "../pages/portal/MyTicketsPage.vue";
import PendingConfirmPage from "../pages/portal/PendingConfirmPage.vue";
import PortalHomePage from "../pages/portal/PortalHomePage.vue";
import MyInProgressPage from "../pages/service-desk/MyInProgressPage.vue";
import PendingAssignPage from "../pages/service-desk/PendingAssignPage.vue";
import QueuePage from "../pages/service-desk/QueuePage.vue";
import ServiceDeskAlertsPage from "../pages/service-desk/ServiceDeskAlertsPage.vue";
import ServiceDeskDetailPage from "../pages/service-desk/ServiceDeskDetailPage.vue";
import ServiceDeskHomePage from "../pages/service-desk/ServiceDeskHomePage.vue";

const routes = [
  { path: "/", redirect: "/portal/home" },
  { path: "/portal/home", component: PortalHomePage },
  { path: "/portal/create", component: CreateTicketPage },
  { path: "/portal/my-tickets", component: MyTicketsPage },
  { path: "/portal/pending-confirm", component: PendingConfirmPage },
  { path: "/approval/pending", component: PendingApprovalsPage },
  { path: "/approval/history", component: ApprovalHistoryPage },
  { path: "/approval/detail", component: ApprovalDetailPage },
  { path: "/service-desk/home", component: ServiceDeskHomePage },
  { path: "/service-desk/pending-assign", component: PendingAssignPage },
  { path: "/service-desk/queue", component: QueuePage },
  { path: "/service-desk/in-progress", component: MyInProgressPage },
  { path: "/service-desk/alerts", component: ServiceDeskAlertsPage },
  { path: "/service-desk/detail", component: ServiceDeskDetailPage },
  { path: "/admin/users", component: UsersPage },
  { path: "/admin/departments", component: DepartmentsPage },
  { path: "/admin/systems", component: SystemsPage },
  { path: "/admin/approval-templates", component: ApprovalTemplatesPage },
  { path: "/admin/sla-policies", component: SlaPoliciesPage },
  { path: "/admin/knowledge", component: KnowledgeAdminPage },
  { path: "/admin/reports", component: ReportsPage },
  { path: "/admin/audit-logs", component: AuditLogsPage }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;

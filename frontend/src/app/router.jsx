import { createBrowserRouter, Navigate, RouterProvider } from "react-router-dom";
import { AppShell } from "../components/AppShell.jsx";
import { AuditLogsPage } from "../pages/admin/AuditLogsPage.jsx";
import { ApprovalTemplatesPage } from "../pages/admin/ApprovalTemplatesPage.jsx";
import { DepartmentsPage } from "../pages/admin/DepartmentsPage.jsx";
import { KnowledgeAdminPage } from "../pages/admin/KnowledgeAdminPage.jsx";
import { ReportsPage } from "../pages/admin/ReportsPage.jsx";
import { SlaPoliciesPage } from "../pages/admin/SlaPoliciesPage.jsx";
import { SystemsPage } from "../pages/admin/SystemsPage.jsx";
import { UsersPage } from "../pages/admin/UsersPage.jsx";
import { ApprovalDetailPage } from "../pages/approval/ApprovalDetailPage.jsx";
import { ApprovalHistoryPage } from "../pages/approval/ApprovalHistoryPage.jsx";
import { PendingApprovalsPage } from "../pages/approval/PendingApprovalsPage.jsx";
import { CreateTicketPage } from "../pages/portal/CreateTicketPage.jsx";
import { MyTicketsPage } from "../pages/portal/MyTicketsPage.jsx";
import { PendingConfirmPage } from "../pages/portal/PendingConfirmPage.jsx";
import { PortalHomePage } from "../pages/portal/PortalHomePage.jsx";
import { QueuePage } from "../pages/service-desk/QueuePage.jsx";
import { ServiceDeskAlertsPage } from "../pages/service-desk/ServiceDeskAlertsPage.jsx";
import { ServiceDeskDetailPage } from "../pages/service-desk/ServiceDeskDetailPage.jsx";
import { ServiceDeskHomePage } from "../pages/service-desk/ServiceDeskHomePage.jsx";
import { MyInProgressPage } from "../pages/service-desk/MyInProgressPage.jsx";
import { PendingAssignPage } from "../pages/service-desk/PendingAssignPage.jsx";

const router = createBrowserRouter([
  {
    path: "/",
    element: <AppShell />,
    children: [
      { index: true, element: <Navigate to="/portal/home" replace /> },
      { path: "portal/home", element: <PortalHomePage /> },
      { path: "portal/create", element: <CreateTicketPage /> },
      { path: "portal/my-tickets", element: <MyTicketsPage /> },
      { path: "portal/pending-confirm", element: <PendingConfirmPage /> },
      { path: "approval/pending", element: <PendingApprovalsPage /> },
      { path: "approval/history", element: <ApprovalHistoryPage /> },
      { path: "approval/detail", element: <ApprovalDetailPage /> },
      { path: "service-desk/home", element: <ServiceDeskHomePage /> },
      { path: "service-desk/pending-assign", element: <PendingAssignPage /> },
      { path: "service-desk/queue", element: <QueuePage /> },
      { path: "service-desk/in-progress", element: <MyInProgressPage /> },
      { path: "service-desk/alerts", element: <ServiceDeskAlertsPage /> },
      { path: "service-desk/detail", element: <ServiceDeskDetailPage /> },
      { path: "admin/users", element: <UsersPage /> },
      { path: "admin/departments", element: <DepartmentsPage /> },
      { path: "admin/systems", element: <SystemsPage /> },
      { path: "admin/approval-templates", element: <ApprovalTemplatesPage /> },
      { path: "admin/sla-policies", element: <SlaPoliciesPage /> },
      { path: "admin/knowledge", element: <KnowledgeAdminPage /> },
      { path: "admin/reports", element: <ReportsPage /> },
      { path: "admin/audit-logs", element: <AuditLogsPage /> }
    ]
  }
]);

export function AppRouter() {
  return <RouterProvider router={router} />;
}

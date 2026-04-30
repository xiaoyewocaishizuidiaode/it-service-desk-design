import { Layout, Menu, Typography } from "antd";
import { Link, Outlet, useLocation } from "react-router-dom";

const { Header, Content, Sider } = Layout;

const menuItems = [
  {
    key: "portal",
    label: "员工门户",
    children: [
      { key: "/portal/home", label: <Link to="/portal/home">门户首页</Link> },
      { key: "/portal/create", label: <Link to="/portal/create">发起申请</Link> },
      { key: "/portal/my-tickets", label: <Link to="/portal/my-tickets">我的申请</Link> },
      { key: "/portal/pending-confirm", label: <Link to="/portal/pending-confirm">待确认</Link> }
    ]
  },
  {
    key: "approval",
    label: "审批中心",
    children: [
      { key: "/approval/pending", label: <Link to="/approval/pending">待我审批</Link> },
      { key: "/approval/history", label: <Link to="/approval/history">我已审批</Link> },
      { key: "/approval/detail", label: <Link to="/approval/detail">审批详情</Link> }
    ]
  },
  {
    key: "service-desk",
    label: "服务台作业台",
    children: [
      { key: "/service-desk/home", label: <Link to="/service-desk/home">作业台首页</Link> },
      { key: "/service-desk/pending-assign", label: <Link to="/service-desk/pending-assign">待分派</Link> },
      { key: "/service-desk/queue", label: <Link to="/service-desk/queue">待抢单</Link> },
      { key: "/service-desk/in-progress", label: <Link to="/service-desk/in-progress">我的处理中</Link> },
      { key: "/service-desk/alerts", label: <Link to="/service-desk/alerts">超时预警</Link> },
      { key: "/service-desk/detail", label: <Link to="/service-desk/detail">工单详情</Link> }
    ]
  },
  {
    key: "admin",
    label: "管理后台",
    children: [
      { key: "/admin/users", label: <Link to="/admin/users">用户管理</Link> },
      { key: "/admin/departments", label: <Link to="/admin/departments">部门管理</Link> },
      { key: "/admin/systems", label: <Link to="/admin/systems">系统与权限</Link> },
      { key: "/admin/approval-templates", label: <Link to="/admin/approval-templates">审批模板</Link> },
      { key: "/admin/sla-policies", label: <Link to="/admin/sla-policies">SLA 规则</Link> },
      { key: "/admin/knowledge", label: <Link to="/admin/knowledge">知识库</Link> },
      { key: "/admin/reports", label: <Link to="/admin/reports">统计报表</Link> },
      { key: "/admin/audit-logs", label: <Link to="/admin/audit-logs">审计日志</Link> }
    ]
  }
];

const openKeys = {
  "/portal": "portal",
  "/approval": "approval",
  "/service-desk": "service-desk",
  "/admin": "admin"
};

export function AppShell() {
  const location = useLocation();
  const rootKey = Object.keys(openKeys).find((prefix) => location.pathname.startsWith(prefix));

  return (
    <Layout className="app-shell">
      <Sider width={260} theme="light" className="app-sider">
        <div className="brand-block">
          <Typography.Title level={4}>企业 IT 服务台</Typography.Title>
          <Typography.Paragraph>JS 前端空页面骨架</Typography.Paragraph>
        </div>
        <Menu
          mode="inline"
          selectedKeys={[location.pathname]}
          defaultOpenKeys={rootKey ? [openKeys[rootKey]] : ["portal"]}
          items={menuItems}
        />
      </Sider>
      <Layout>
        <Header className="app-header">
          <Typography.Text>当前只搭页面骨架，具体业务逻辑留空</Typography.Text>
        </Header>
        <Content className="app-content">
          <Outlet />
        </Content>
      </Layout>
    </Layout>
  );
}

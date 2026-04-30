import { Card, Col, Row, Statistic } from "antd";
import { PagePlaceholder } from "../../components/PagePlaceholder.jsx";

export function PortalHomePage() {
  return (
    <div className="page-grid">
      <Row gutter={[16, 16]}>
        <Col xs={24} md={8}>
          <Card><Statistic title="我的申请" value={0} /></Card>
        </Col>
        <Col xs={24} md={8}>
          <Card><Statistic title="待确认" value={0} /></Card>
        </Col>
        <Col xs={24} md={8}>
          <Card><Statistic title="知识命中" value={0} /></Card>
        </Col>
      </Row>
      <PagePlaceholder
        title="员工门户首页"
        description="这里预留给员工工作台概览、快捷入口和知识推荐。"
        modules={["我的待办概览", "快捷提单入口", "热门知识推荐", "最近申请记录"]}
      />
    </div>
  );
}

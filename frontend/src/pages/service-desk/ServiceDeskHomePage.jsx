import { Card, Col, Row, Statistic } from "antd";
import { PagePlaceholder } from "../../components/PagePlaceholder.jsx";

export function ServiceDeskHomePage() {
  return (
    <div className="page-grid">
      <Row gutter={[16, 16]}>
        <Col xs={24} md={6}>
          <Card><Statistic title="待分派" value={0} /></Card>
        </Col>
        <Col xs={24} md={6}>
          <Card><Statistic title="待抢单" value={0} /></Card>
        </Col>
        <Col xs={24} md={6}>
          <Card><Statistic title="处理中" value={0} /></Card>
        </Col>
        <Col xs={24} md={6}>
          <Card><Statistic title="超时预警" value={0} /></Card>
        </Col>
      </Row>
      <PagePlaceholder
        title="服务台作业台首页"
        description="这里预留给服务台成员查看队列概况和快捷操作。"
        modules={["工作台概览", "个人待办", "组内队列", "SLA 风险摘要"]}
      />
    </div>
  );
}

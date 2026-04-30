import { Card, List, Typography } from "antd";

export function PagePlaceholder({ title, description, modules = [] }) {
  return (
    <div className="page-grid">
      <div>
        <Typography.Title level={2}>{title}</Typography.Title>
        <Typography.Paragraph>{description}</Typography.Paragraph>
      </div>
      <Card title="预留内容">
        <List
          dataSource={modules}
          renderItem={(item) => <List.Item>{item}</List.Item>}
        />
      </Card>
    </div>
  );
}

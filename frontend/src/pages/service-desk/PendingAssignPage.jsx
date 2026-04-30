import { PagePlaceholder } from "../../components/PagePlaceholder.jsx";

export function PendingAssignPage() {
  return (
    <PagePlaceholder
      title="待分派"
      description="这里预留给组长处理高敏工单和人工分派。"
      modules={["待分派列表", "高敏标记", "处理人选择", "分派记录"]}
    />
  );
}

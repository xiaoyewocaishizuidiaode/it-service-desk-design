import { PagePlaceholder } from "../../components/PagePlaceholder.jsx";

export function ApprovalDetailPage() {
  return (
    <PagePlaceholder
      title="审批详情"
      description="这里预留给单张工单的审批上下文、风险信息和审批动作。"
      modules={["申请信息卡片", "审批流节点", "风险说明", "审批动作区"]}
    />
  );
}

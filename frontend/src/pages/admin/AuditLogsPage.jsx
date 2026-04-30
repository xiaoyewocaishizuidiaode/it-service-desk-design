import { PagePlaceholder } from "../../components/PagePlaceholder.jsx";

export function AuditLogsPage() {
  return (
    <PagePlaceholder
      title="审计日志"
      description="这里预留给审批、分派、状态流转和关键操作留痕查询。"
      modules={["日志列表", "按工单筛选", "按操作人筛选", "前后快照查看"]}
    />
  );
}

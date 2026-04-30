import { PagePlaceholder } from "../../components/PagePlaceholder.jsx";

export function ServiceDeskDetailPage() {
  return (
    <PagePlaceholder
      title="工单详情"
      description="这里预留给服务台查看完整工单、审批结果和处理记录。"
      modules={["工单基础信息", "审批历史", "处理记录", "结果快照"]}
    />
  );
}

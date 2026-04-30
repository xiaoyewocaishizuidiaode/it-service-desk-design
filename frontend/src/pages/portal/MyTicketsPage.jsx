import { PagePlaceholder } from "../../components/PagePlaceholder.jsx";

export function MyTicketsPage() {
  return (
    <PagePlaceholder
      title="我的申请"
      description="这里预留给员工查看自己提交的工单、状态和审批进度。"
      modules={["申请列表", "状态筛选", "工单详情", "审批进度时间线"]}
    />
  );
}

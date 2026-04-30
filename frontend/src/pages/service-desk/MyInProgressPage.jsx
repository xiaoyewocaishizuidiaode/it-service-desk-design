import { PagePlaceholder } from "../../components/PagePlaceholder.jsx";

export function MyInProgressPage() {
  return (
    <PagePlaceholder
      title="我的处理中"
      description="这里预留给处理人查看自己正在处理的工单。"
      modules={["处理中列表", "处理进度", "完成登记", "退回补充说明"]}
    />
  );
}

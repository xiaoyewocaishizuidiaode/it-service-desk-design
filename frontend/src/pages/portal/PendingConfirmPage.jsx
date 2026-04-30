import { PagePlaceholder } from "../../components/PagePlaceholder.jsx";

export function PendingConfirmPage() {
  return (
    <PagePlaceholder
      title="待确认"
      description="这里预留给员工确认处理结果，或退回服务台继续处理。"
      modules={["待确认列表", "处理结果查看", "确认完成", "退回说明"]}
    />
  );
}

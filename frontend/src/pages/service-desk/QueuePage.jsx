import { PagePlaceholder } from "../../components/PagePlaceholder.jsx";

export function QueuePage() {
  return (
    <PagePlaceholder
      title="待抢单"
      description="这里预留给服务台成员查看可抢工单。"
      modules={["公共队列列表", "筛选排序", "抢单按钮", "优先级标识"]}
    />
  );
}

import { PagePlaceholder } from "../../components/PagePlaceholder.jsx";

export function KnowledgeAdminPage() {
  return (
    <PagePlaceholder
      title="知识库"
      description="这里预留给知识文章、标签、分类和推荐策略管理。"
      modules={["文章列表", "分类标签", "命中策略", "工单转知识"]}
    />
  );
}

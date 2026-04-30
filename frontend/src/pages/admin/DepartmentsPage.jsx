import { PagePlaceholder } from "../../components/PagePlaceholder.jsx";

export function DepartmentsPage() {
  return (
    <PagePlaceholder
      title="部门管理"
      description="这里预留给组织架构、部门树和负责人维护。"
      modules={["部门树", "负责人维护", "层级关系", "同步标识"]}
    />
  );
}

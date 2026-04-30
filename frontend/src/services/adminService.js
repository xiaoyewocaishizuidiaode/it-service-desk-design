import { apiGet } from "./apiClient.js";

export function loadOverviewReport() {
  return apiGet("/api/admin/reports/overview");
}

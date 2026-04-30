import { apiGet } from "./apiClient.js";

export function listPendingApprovals() {
  return apiGet("/api/approvals/pending");
}

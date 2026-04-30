import { apiGet } from "./apiClient.js";

export function listQueueTickets() {
  return apiGet("/api/service-desk/queue");
}

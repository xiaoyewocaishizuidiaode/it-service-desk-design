import { apiGet } from "./apiClient.js";

export function listTickets() {
  return apiGet("/api/portal/tickets");
}

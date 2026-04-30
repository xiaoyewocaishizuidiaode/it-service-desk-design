const API_BASE_URL = "http://localhost:8080";

export async function apiGet(path) {
  const response = await fetch(`${API_BASE_URL}${path}`);
  return response.json();
}

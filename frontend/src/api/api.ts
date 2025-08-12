import axios from "axios";

const API_BASE = process.env.BACKEND_URL || "http://localhost:4567";

export async function triggerTestRun(targets?: string) {
  const res = await axios.post(`${API_BASE}/run`, { targets });
  return res;
}

export async function getLatestRun(number?: number) {
  const res = await axios.get(`${API_BASE}/runs/latest`, {
    params: number ? { count: number } : {},
  });
  return res;
}

export async function getRuns() {
  const res = await axios.get(`${API_BASE}/runs`);
  return res;
}

export async function getRunById(id: number) {
  const res = await axios.get(`${API_BASE}/runs/${id}`);
  return res;
}

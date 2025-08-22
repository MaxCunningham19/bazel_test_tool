import { Test } from "./Test";

export interface Run {
  id: string;
  status: string;
  started_at: string;
  completed_at: string;
  duration_seconds: number;
  tests: Test[];
}

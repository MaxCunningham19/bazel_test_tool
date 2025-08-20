export interface TestRun {
  id: number;
  status: string;
  tests: string[];
  duration_seconds: number;
  finished_at: string;
}

export interface TestRun {
  run_id: number;
  status: string;
  flaky_tests: string[];
  stable_tests: string[];
  duration_seconds: number;
  finished_at: string;
}

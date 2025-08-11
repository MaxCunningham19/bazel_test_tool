import React from "react";

export interface TestRun {
  run_id: number;
  status: string;
  flaky_tests: string[];
  stable_tests: string[];
  duration_seconds: number;
  finished_at: string;
}

export default function TestBox({ run }: { run: TestRun }) {
  return (
    <div id={run.run_id.toString()}>
      <h2> Run Id: {run.run_id ?? "N/A"}</h2>
      <p> Status: {run.status}</p>
      {/* todo make pretty */}
    </div>
  );
}

import React from "react";
import { TestRun } from "../types";

export default function TestBox({ run }: { run: TestRun }) {
  return (
    <div id={run.run_id.toString()}>
      <h2> Run Id: {run.run_id ?? "N/A"}</h2>
      <p> Status: {run.status}</p>
      {/* todo make pretty */}
    </div>
  );
}

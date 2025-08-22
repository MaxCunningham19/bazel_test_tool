import React, { useState } from "react";
import { Run } from "../types";
import TestBox from "./TestBox";
interface RunBoxProps {
  run: Run;
}

export default function RunBox({ run }: RunBoxProps) {
  return (
    <div className="test-box" id={String(run.id)}>
      <header className="test-box-header">
        <h2>Run #{run.id ?? "N/A"}</h2>
        <span className={`status status-${run.status.toLowerCase()}`}>{run.status}</span>
      </header>

      <section className="test-box-meta">
        <div>
          <strong>Duration:</strong> {run.duration_seconds}s
        </div>
        <div>
          <strong>Finished At:</strong> {new Date(run.completed_at).toLocaleString()}
        </div>
      </section>

      <section className="test-box-tests">
        <div>
          {run.tests.map((test) => (
            <li>
              <TestBox key={test.test_id} test={test} />
            </li>
          ))}
        </div>
      </section>
    </div>
  );
}

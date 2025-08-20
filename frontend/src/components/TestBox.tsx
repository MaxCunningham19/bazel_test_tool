import React, { useState } from "react";
import { TestRun } from "../types";

interface TestBoxProps {
  run: TestRun;
}

export default function TestBox({ run }: TestBoxProps) {
  const [showFlaky, setShowFlaky] = useState(false);
  const [showStable, setShowStable] = useState(false);

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
          <strong>Finished At:</strong> {new Date(run.finished_at).toLocaleString()}
        </div>
      </section>

      <section className="test-box-tests">
        <div>
          <button className="toggle-button" onClick={() => setShowFlaky((prev) => !prev)}>
            Flaky Tests ({run.tests.length})
          </button>
          {showFlaky &&
            (run.tests.length > 0 ? (
              <ul>
                {run.tests.map((t) => (
                  <li key={t}>{t}</li>
                ))}
              </ul>
            ) : (
              <p>None</p>
            ))}
        </div>

        {/* <div>
          <button className="toggle-button" onClick={() => setShowStable((prev) => !prev)}>
            Stable Tests ({run.stable_tests.length})
          </button>
          {showStable &&
            (run.stable_tests.length > 0 ? (
              <ul>
                {run.stable_tests.map((t) => (
                  <li key={t}>{t}</li>
                ))}
              </ul>
            ) : (
              <p>None</p>
            ))}
        </div> */}
      </section>
    </div>
  );
}

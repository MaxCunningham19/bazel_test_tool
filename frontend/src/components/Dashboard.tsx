import React, { useEffect, useState } from "react";
import TestBox from "./TestBox";
import { TestRun } from "../types";
import { getLatestRun, triggerTestRun } from "../api/api";

export default function Dashboard() {
  const [run, setRun] = useState<any>(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    getLatestRun(3).then((data) => {
      setRun(data.data);
    });
  }, []);

  const handleRunTests = async () => {
    setLoading(true);
    const data = await triggerTestRun();
    if (data.status === 200) {
      getLatestRun(3).then((data) => {
        setRun(data.data);
      });
    }
    setLoading(false);
  };

  return (
    <div>
      <h1>Dashboard</h1>
      <button onClick={handleRunTests} disabled={loading}>
        {loading ? "Processing ..." : "Trigger tests"}
      </button>
      {run &&
        run.map((run: TestRun) => {
          return <TestBox key={run.run_id} run={run} />;
        })}
    </div>
  );
}

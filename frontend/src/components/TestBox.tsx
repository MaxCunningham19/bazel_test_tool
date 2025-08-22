import React, { useState } from "react";
import { Test } from "../types";

interface TestBoxProps {
  test: Test;
}

export default function TestBox({ test }: TestBoxProps) {
  return (
    <div>
      <h3>{test.name}</h3>
      <p>ID: {test.test_id}</p>
      <p>Status: {test.status}</p>
      <p>Path: {test.path}</p>
      <p>Duration: {test.duration_seconds.toFixed(2)}s</p>
    </div>
  );
}

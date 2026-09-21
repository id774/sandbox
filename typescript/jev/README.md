# Jev

## Overview

This directory groups the TypeScript samples that explore Jev. The samples are
kept as separate, self-contained examples because they demonstrate different
aspects of using Jev while sharing the same technology.

## Layout

- `decision_logic`: demonstrates Jev-shaped `Noul`, `Choice`, and `Score`
  outputs together with probability and confidence, calibration,
  expected-loss decision thresholds, audit records, score distributions, and
  operational logging. See
  [`decision_logic/README.md`](decision_logic/README.md).
- `typed_decisions`: demonstrates how Jev's typed decisions can be validated at
  an application boundary and connected to deterministic TypeScript business
  logic and routing. See
  [`typed_decisions/README.md`](typed_decisions/README.md).
- `regression_testing`: demonstrates fixed evaluation cases, deterministic
  decision unit tests, and a live Jev regression evaluation using a
  Cloudflare Workers AI remote binding. See
  [`regression_testing/README.md`](regression_testing/README.md).
- `metamorphic_testing`: demonstrates metamorphic testing of Jev's
  probabilistic decision, checking that a relation such as `same-decision`
  or `not-less-risky` holds between the final decisions for a source input
  and a related follow-up input, using a live Cloudflare Workers AI remote
  binding. See
  [`metamorphic_testing/README.md`](metamorphic_testing/README.md).

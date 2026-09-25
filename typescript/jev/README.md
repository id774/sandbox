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
- `answer_shapes`: demonstrates choosing and consuming Jev `Choice`, `Score`,
  and `Noul` answers from the value shape required by downstream code: a finite
  label, an ordered scale, or a proposition probability. See
  [`answer_shapes/README.md`](answer_shapes/README.md).
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
- `async_ticket_routing`: demonstrates asynchronous support-ticket routing
  with Cloudflare Queues and D1, including typed Jev evaluation, deterministic
  final routing, retry state, Dead Letter Queue handling, and final-state
  duplicate suppression. See
  [`async_ticket_routing/README.md`](async_ticket_routing/README.md).
- `tool_guard`: demonstrates agent tool-call gating by combining Jev-shaped
  risk, approval, user-request, and untrusted-input judgments with a
  deterministic `allow` / `ask` / `deny` policy. See
  [`tool_guard/README.md`](tool_guard/README.md).
- `rule_selection`: demonstrates selecting only the standing rules relevant
  to the current request by applying a deterministic threshold to Jev-shaped
  relevance probabilities. See
  [`rule_selection/README.md`](rule_selection/README.md).
- `context_filtering`: demonstrates filtering candidate context by semantic
  relevance before passing selected material to a later processing stage. See
  [`context_filtering/README.md`](context_filtering/README.md).
- `semantic_lint`: demonstrates semantic code checks whose probabilistic
  findings are converted into a deterministic CI failure decision. See
  [`semantic_lint/README.md`](semantic_lint/README.md).
- `browser_action_selection`: demonstrates choosing among already observed
  browser actions while keeping target execution in deterministic code. See
  [`browser_action_selection/README.md`](browser_action_selection/README.md).
- `candidate_screening`: demonstrates screening a fixed candidate profile
  against required criteria while keeping evidence selection and the final
  review boundary explicit. See
  [`candidate_screening/README.md`](candidate_screening/README.md).
- `email_triage`: demonstrates mapping a fixed email to a category, urgency
  score, and human-written probability before deterministic presentation. See
  [`email_triage/README.md`](email_triage/README.md).
- `home_automation`: demonstrates turning a sensor state and a Jev-shaped
  probability into a deterministic home-automation notification decision. See
  [`home_automation/README.md`](home_automation/README.md).
- `transaction_risk`: demonstrates evaluating hard transaction rules before
  Jev-shaped risk judgments and combining both into a final deterministic
  action. See
  [`transaction_risk/README.md`](transaction_risk/README.md).
- `market_state`: demonstrates interpreting precomputed market features with
  Jev-shaped judgments while keeping risk limits and quote policy in ordinary
  code. See
  [`market_state/README.md`](market_state/README.md).
- `mcp_decisions`: demonstrates consuming a Jev-backed MCP-style routing
  decision as a finite application-domain value. See
  [`mcp_decisions/README.md`](mcp_decisions/README.md).

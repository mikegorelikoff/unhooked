# Start with a real workflow

[Install hx](install-and-agents.md) and use a scratch Git repository. This guide walks through a tour, then uses a real specification skill to show how a gate blocks and releases a step.

## Take the tour

From a terminal:

```sh
mkdir hx-demo
cd hx-demo
git init
hx init
hx doctor
hx start .agents/skills/hx-tour
```

Choose `repo` storage and `md` output to match the paths below. Choose telemetry off for the local example. The basic pack includes the tour and spec example. Choose the full pack to also use the review and test-planning skills linked at the end. Select Claude Code or Codex to connect an agent, or choose no agent to follow the guide in a terminal by yourself.

For a reproducible solo setup in a new test repository, replace the interactive `hx init` command with `hx init --yes --storage repo --agents none --skill-set basic --docs md --telemetry off`.

| Position | What to do | Expected result |
| --- | --- | --- |
| Step 1 | Say what you want the run to accomplish. Run `hx done`. | The CLI prints the gates lesson in step 2. |
| Step 2 | Name an example gate a real skill could use, such as `file-exists`. Run `hx done`. | The CLI prints step 3. The tour introduces gates without declaring an automated gate itself. |
| Step 3 | Run `hx resume`, then `hx done`. | Resume prints step 3 again. Done completes the tour. |

To resume in a new terminal, add the install directory to its `PATH` and change back to the same repository. If you continue in an agent chat, ask it to run `hx resume` and follow the current step. After completion, use `hx status --run <run-id>` with the ID printed by `hx start` to inspect that run.

## Work a real ticket

Assume ticket `DEMO-42` asks the import API to return the original job ID for repeated requests with the same idempotency key. The following commands use a single artifact in the scratch repository from the tour. They demonstrate the workflow without making application code changes.

### Start the spec and record the requirement

```sh
hx route "spec this ticket DEMO-42"
hx start .agents/skills/hx-spec --set workflow.ticket=DEMO-42
hx artifact new --ticket DEMO-42 --slug import-retry

hx artifact add requirement --level MUST \
  --statement "The import service MUST reuse an existing job for the same idempotency key" \
  --why "Prevent duplicate import jobs"

hx artifact add criterion --req REQ-DEMO-001 --pattern event \
  --trigger "a retry arrives with a known key" \
  --system "import service" \
  --response "return the existing job ID" \
  --why "Make retry behavior testable"
```

Routing prints `hx-spec`. It only previews the match. The next command starts the run. `hx artifact add` prints the IDs it assigns. This scratch example uses `REQ-DEMO-001` and `AC-DEMO-001-01`.

### See a gate block advancement

```sh
hx artifact add question \
  --text "Should a repeat request return the original job ID?" \
  --blocking --why "Confirm the retry response"

hx done
hx done
```

The first `hx done` advances from gathering the ticket to resolving questions. The second reports `no-blocking-questions` for `Q-01` and leaves you at step 2. Record the stakeholder's answer. The example assumes the product owner confirmed the original job ID:

```sh
hx artifact answer Q-01 \
  --answer "Return the original job ID" \
  --why "Confirmed with the product owner"
hx done
```

The CLI now reaches step 3. If someone closes the agent session while the question is open, `hx resume` will still return to step 2 in the same worktree.

### Add evidence and hand off to review

```sh
hx artifact add scenario --ac AC-DEMO-001-01 \
  --title "Reuse an existing import job" \
  --step "Given an import job exists for the key" \
  --step "When the client retries with the same key" \
  --step "Then the API returns the existing job ID" \
  --why "Cover the retry response"

hx artifact check
hx artifact render
hx done
hx artifact submit --why "Ready for review"
hx done
```

The step checks the spec and its link from criterion to scenario. Submission creates a review snapshot. The run then completes. Approval is a separate decision by a reviewer.

| Result | Location |
| --- | --- |
| Requirements, criteria, scenarios and review snapshot | `specs/DEMO-42-import-retry-artifact/_unhooked/` |
| Generated spec for a person to read | `specs/DEMO-42-import-retry-artifact/spec.md` |
| Run events and current state | `.agents/hx/runs/hx-spec/<run-id>/` |

## Where to go next

With the full pack installed, use [hx-spec-review](https://github.com/mikegorelikoff/unhooked/wiki/hx-spec-review) to check the spec for gaps. Use [hx-test-cases](https://github.com/mikegorelikoff/unhooked/wiki/hx-test-cases) to turn scenarios into runnable or manual cases. For the rest of the delivery process, see the [workflow map](https://github.com/mikegorelikoff/unhooked/wiki/Workflow-map) and the [skill catalogue](https://github.com/mikegorelikoff/unhooked/wiki/Skills).

// Demonstrates browser action selection in which ordinary code prepares the
// observed targets, a Jev-shaped Choice selects a target ID, and ordinary code
// performs the side effect. The browser and the Jev response are simulated
// locally, so no browser, network access, or credentials are needed.
// Run: tsc --target es2020 select_action.ts && node select_action.js

const targets = ["save", "cancel", "done"] as const;

type Target = typeof targets[number];
type ExecutedAction = "save" | "cancel" | "none";

interface ChoiceAnswer {
    choice: string;
    confidence: number;
    probabilities: Record<string, number>;
}

const task = "Save the settings.";

// Fixed demonstration data, not a live model result.
function chooseTarget(input: string, observed: readonly Target[]): ChoiceAnswer {
    void input;
    void observed;
    return {
        choice: "save",
        confidence: 0.95,
        probabilities: {
            save: 0.95,
            cancel: 0.01,
            done: 0.04,
        },
    };
}

function isTarget(value: string): value is Target {
    return targets.includes(value as Target);
}

function execute(target: Target): ExecutedAction {
    switch (target) {
        case "save":
            return "save";
        case "cancel":
            return "cancel";
        case "done":
            return "none";
    }
}

const selected = chooseTarget(task, targets).choice;
if (!isTarget(selected)) {
    throw new Error(`Unexpected target: ${selected}`);
}

console.log(`selected action: ${selected}`);
console.log(`executed action: ${execute(selected)}`);

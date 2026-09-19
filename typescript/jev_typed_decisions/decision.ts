// Demonstrates how to place Jev's typed decisions at the boundary between
// unstructured input and ordinary TypeScript business logic. The Jev response
// is fixed locally so the sample requires no network access or credentials.
// Run: tsc --target es2020 decision.ts && node decision.js

const departments = [
    "account",
    "billing",
    "technical",
    "other",
] as const;

type Department = typeof departments[number];

interface SupportState {
    ticket: {
        subject: string;
        message: string;
    };
    account: {
        locked: boolean;
        plan: string;
    };
}

interface NoulAnswer {
    type: "noul";
    noul: number;
}

interface ChoiceAnswer {
    type: "choice";
    choice: string;
    confidence: number;
    probabilities: Record<string, number>;
}

interface ScoreAnswer {
    type: "score";
    score: number;
    confidence: number;
    legend: Record<string, string>;
    probabilities: Record<string, number>;
}

interface JevResponse {
    answers: {
        needs_human_attention: NoulAnswer;
        department: ChoiceAnswer;
        urgency: ScoreAnswer;
    };
}

const questions = {
    needs_human_attention: {
        type: "noul",
        instructions: "Does this support request require human attention?",
        criteria: {
            true: "A human should inspect the request before automated handling continues",
            false: "Automated handling may continue without human inspection",
        },
    },
    department: {
        type: "choice",
        instructions: "Which team should handle this support request?",
        criteria: {
            account: "Login, password, profile, or security issues",
            billing: "Charges, invoices, refunds, or subscriptions",
            technical: "Product bugs, outages, or integrations",
            other: "Requests that do not fit the other departments",
        },
    },
    urgency: {
        type: "score",
        instructions: "How urgent is this request?",
        criteria: [
            "Normal",
            "Urgent",
            "Critical",
        ],
    },
} as const;

const supportResponse: JevResponse = {
    answers: {
        needs_human_attention: {
            type: "noul",
            noul: 0.35,
        },
        department: {
            type: "choice",
            choice: "account",
            confidence: 1,
            probabilities: {
                account: 1,
                billing: 0,
                technical: 0,
                other: 0,
            },
        },
        urgency: {
            type: "score",
            score: 1,
            confidence: 0.9,
            legend: {
                "0": "Normal",
                "1": "Urgent",
                "2": "Critical",
            },
            probabilities: {
                "0": 0.1,
                "1": 0.8,
                "2": 0.1,
            },
        },
    },
};

let jevCallCount = 0;

const env = {
    AI: {
        async run(model: string, input: unknown): Promise<JevResponse> {
            void model;
            void input;
            jevCallCount += 1;
            return supportResponse;
        },
    },
};

function isDepartment(value: string): value is Department {
    return departments.includes(value as Department);
}

function routeDepartment(department: Department): string {
    switch (department) {
        case "account":
            return "/queues/account";
        case "billing":
            return "/queues/billing";
        case "technical":
            return "/queues/technical";
        case "other":
            return "/queues/general";
    }
}

interface RoutingResult {
    source: "rule" | "jev";
    department?: Department;
    queue: string;
}

async function routeSupportRequest(state: SupportState): Promise<RoutingResult> {
    if (state.account.locked) {
        return {
            source: "rule",
            queue: "/queues/security",
        };
    }

    const response = await env.AI.run(
        "typesafe/jev",
        {
            state,
            questions,
        },
    );

    const choice = response.answers.department.choice;
    if (!isDepartment(choice)) {
        throw new Error(`Unexpected department: ${choice}`);
    }

    return {
        source: "jev",
        department: choice,
        queue: routeDepartment(choice),
    };
}

async function main(): Promise<void> {
    const unlockedState: SupportState = {
        ticket: {
            subject: "Login failure",
            message: "I cannot log in after changing my password, and the reset email never arrives.",
        },
        account: {
            locked: false,
            plan: "business",
        },
    };

    const lockedState: SupportState = {
        ...unlockedState,
        account: {
            ...unlockedState.account,
            locked: true,
        },
    };

    console.log("Unlocked account");
    const unlockedResult = await routeSupportRequest(unlockedState);
    console.log(`  decision source: ${unlockedResult.source}`);
    console.log(`  department: ${unlockedResult.department}`);
    console.log(`  queue: ${unlockedResult.queue}`);
    console.log();

    console.log("Locked account");
    const lockedResult = await routeSupportRequest(lockedState);
    console.log(`  decision source: ${lockedResult.source}`);
    console.log(`  queue: ${lockedResult.queue}`);
    console.log();

    console.log(`Jev calls: ${jevCallCount}`);
}

void main();

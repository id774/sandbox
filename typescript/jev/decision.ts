// Reproduces Jev's API-shaped typed output with fixed data instead of a
// live call, so every code path from the companion Qiita article - Noul,
// Choice, and Score answers, probability vs. confidence, calibration,
// expected-loss review thresholds, audit records, distribution comparison,
// and an operational log record - can be traced in this single file.
// Run: tsc --target es2020 decision.ts && node decision.js

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

interface SupportResponse {
    model: string;
    answers: {
        is_urgent: NoulAnswer;
        department: ChoiceAnswer;
        frustration: ScoreAnswer;
    };
}

const supportResponse: SupportResponse = {
    model: "jev-1.13.0",
    answers: {
        is_urgent: { type: "noul", noul: 0.95 },
        department: {
            type: "choice",
            choice: "billing",
            confidence: 0.80,
            probabilities: { billing: 0.87, sales: 0, technical: 0.13 },
        },
        frustration: {
            type: "score",
            score: 1.04,
            confidence: 0.94,
            legend: { "0": "Calm", "1": "Frustrated", "2": "Very angry" },
            probabilities: { "0": 0, "1": 0.96, "2": 0.04 },
        },
    },
};

const env = {
    AI: {
        async run(model: string, input: unknown): Promise<SupportResponse> {
            return supportResponse;
        },
    },
};

interface RiskResponse {
    model: string;
    answers: {
        escalate: NoulAnswer;
    };
}

const riskResponse: RiskResponse = {
    model: "jev-1.13.0",
    answers: {
        escalate: { type: "noul", noul: 0.81 },
    },
};

interface CalibrationRow {
    probability: number;
    actualResult: boolean;
}

interface CalibrationResult {
    count: number;
    averageProbability: number;
    actualRate: number;
}

function calibrationByBucket(
    rows: CalibrationRow[],
    lower: number,
    upper: number,
): CalibrationResult | undefined {
    const inBucket = rows.filter((row) => row.probability >= lower && row.probability < upper);
    if (inBucket.length === 0) {
        return undefined;
    }
    const averageProbability = inBucket.reduce((sum, row) => sum + row.probability, 0) / inBucket.length;
    const actualRate = inBucket.filter((row) => row.actualResult === true).length / inBucket.length;
    return { count: inBucket.length, averageProbability, actualRate };
}

const calibrationRows: CalibrationRow[] = [
    { probability: 0.76, actualResult: true },
    { probability: 0.78, actualResult: true },
    { probability: 0.80, actualResult: true },
    { probability: 0.82, actualResult: true },
    { probability: 0.84, actualResult: false },
];

function shouldReview(
    probability: number,
    failureCost: number,
    reviewCost: number,
): boolean {
    const threshold = reviewCost / failureCost;
    return probability > threshold;
}

async function sendToHumanReview(): Promise<void> {
    console.log("  action: sendToHumanReview()");
}

async function approve(): Promise<void> {
    console.log("  action: approve()");
}

async function continueAutomatedFlow(): Promise<void> {
    console.log("  action: continueAutomatedFlow()");
}

async function review(reason: string): Promise<void> {
    console.log(`  action: review(${reason})`);
}

function weightedScore(
    probabilities: Record<string, number>,
): number {
    return Object.entries(probabilities).reduce(
        (sum, [level, probability]) => sum + Number(level) * probability,
        0,
    );
}

async function main(): Promise<void> {
    console.log("A. Jev-shaped request and response");
    const response = await env.AI.run(
        "typesafe/jev",
        {
            state: "Help! My payouts have been failing for 3 days.",
            questions: {
                is_urgent: {
                    type: "noul",
                    instructions: "Does this convey urgency?",
                    criteria: {
                        true: "Explicitly time-sensitive",
                        false: "No urgency expressed",
                    },
                },
                department: {
                    type: "choice",
                    instructions: "Which team should handle this?",
                    criteria: {
                        billing: "Payments, invoicing, refunds",
                        technical: "Bugs, outages, integrations",
                        sales: "Pricing, upgrades, new accounts",
                    },
                },
                frustration: {
                    type: "score",
                    instructions: "How frustrated is the customer?",
                    criteria: [
                        "Calm",
                        "Frustrated",
                        "Very angry",
                    ],
                },
            },
        },
    );
    console.log(`  model: ${response.model}`);
    console.log(`  is_urgent noul: ${response.answers.is_urgent.noul.toFixed(2)}`);
    console.log(`  department choice: ${response.answers.department.choice}`);
    console.log(`  frustration score: ${response.answers.frustration.score.toFixed(2)}`);
    console.log();

    console.log("B. Probability vs. confidence");
    const departmentAnswer = response.answers.department;
    const maxProbability = Math.max(
        ...Object.values(departmentAnswer.probabilities),
    );
    console.log(`  max probability: ${maxProbability.toFixed(2)}`);
    console.log(`  confidence: ${departmentAnswer.confidence.toFixed(2)}`);
    console.log(`  same value: ${maxProbability === departmentAnswer.confidence}`);
    console.log();

    console.log("C. Calibration bucket [0.75, 0.85)");
    const calibration = calibrationByBucket(calibrationRows, 0.75, 0.85);
    if (calibration === undefined) {
        throw new Error("calibration bucket is empty");
    }
    console.log(`  calibration count: ${calibration.count}`);
    console.log(`  average probability: ${calibration.averageProbability.toFixed(2)}`);
    console.log(`  actual rate: ${calibration.actualRate.toFixed(2)}`);
    console.log();

    console.log("D. Expected-loss fraud review");
    const fraudProbability = 0.08;
    const fraudCost = 100;
    const reviewCost = 5;
    const fraudThreshold = reviewCost / fraudCost;
    console.log(`  fraud threshold: ${fraudThreshold.toFixed(2)}`);
    console.log(`  fraud probability: ${fraudProbability.toFixed(2)}`);
    if (shouldReview(fraudProbability, fraudCost, reviewCost)) {
        console.log("  fraud decision: review");
        await sendToHumanReview();
    } else {
        console.log("  fraud decision: skip");
        await approve();
    }
    console.log();

    console.log("E. Noul escalation decision");
    const answer = riskResponse.answers.escalate;
    if (answer.type !== "noul") {
        throw new Error("Unexpected answer type");
    }
    const escalationProbability = answer.noul;
    const INCIDENT_COST = 100;
    const REVIEW_COST = 5;
    const escalationThreshold = REVIEW_COST / INCIDENT_COST;
    console.log(`  escalation probability: ${escalationProbability.toFixed(2)}`);
    console.log(`  escalation threshold: ${escalationThreshold.toFixed(2)}`);
    if (shouldReview(escalationProbability, INCIDENT_COST, REVIEW_COST)) {
        console.log("  escalation decision: review");
        await sendToHumanReview();
    } else {
        console.log("  escalation decision: skip");
        await continueAutomatedFlow();
    }
    console.log();

    console.log("F. Choice audit record");
    const department = departmentAnswer.choice;
    const auditRecord = {
        model: response.model,
        choice: departmentAnswer.choice,
        probabilities: departmentAnswer.probabilities,
        confidence: departmentAnswer.confidence,
        actualDepartment: null,
    };
    console.log(`  audit model: ${auditRecord.model}`);
    console.log(`  audit choice: ${auditRecord.choice}`);
    console.log(`  audit billing probability: ${auditRecord.probabilities.billing.toFixed(2)}`);
    console.log(`  audit confidence: ${auditRecord.confidence.toFixed(2)}`);
    console.log(`  audit actualDepartment: ${auditRecord.actualDepartment}`);
    console.log(`  department: ${department}`);
    console.log();

    console.log("G. Score distribution");
    const scoreAnswer = response.answers.frustration;
    const scoreWeightedResult = weightedScore(scoreAnswer.probabilities);
    console.log(`  score: ${scoreAnswer.score.toFixed(2)}`);
    console.log(`  weighted result: ${scoreWeightedResult.toFixed(2)}`);
    console.log(`  score confidence: ${scoreAnswer.confidence.toFixed(2)}`);
    console.log(`  level 2 probability: ${scoreAnswer.probabilities["2"].toFixed(2)}`);
    console.log();

    console.log("H. Same score, different distributions");
    const distributionA: Record<string, number> = {
        "0": 0.0,
        "1": 1.0,
        "2": 0.0,
    };
    const distributionB: Record<string, number> = {
        "0": 0.5,
        "1": 0.0,
        "2": 0.5,
    };
    console.log(`  distribution A score: ${weightedScore(distributionA).toFixed(2)}`);
    console.log(`  distribution B score: ${weightedScore(distributionB).toFixed(2)}`);
    const reviewByScore = weightedScore(distributionB) > 1.5;
    const reviewByHighRiskProbability = distributionB["2"] > 0.3;
    console.log(`  review by score > 1.5: ${reviewByScore}`);
    console.log(`  review by level 2 probability > 0.3: ${reviewByHighRiskProbability}`);
    if (reviewByScore) {
        await review("score");
    }
    if (reviewByHighRiskProbability) {
        await review("level 2 probability");
    }
    console.log();

    console.log("I. Operational log record");
    const operationalLog = {
        model_version: response.model,
        question_type: departmentAnswer.type,
        prediction: departmentAnswer.choice,
        probability: departmentAnswer.probabilities[departmentAnswer.choice],
        probabilities: departmentAnswer.probabilities,
        confidence: departmentAnswer.confidence,
        threshold: null,
        decision: `route:${departmentAnswer.choice}`,
        actual_result: null,
    };
    console.log(`  record: ${JSON.stringify(operationalLog)}`);
}

void main();

// Connects Jev's typed probabilistic output to ordinary business logic using
// fixed sample data: probability vs. confidence, a calibration bucket, an
// expected-loss review threshold, and Score distribution handling.
// Run: tsc --target es2020 decision.ts && node decision.js

interface ChoiceProbabilities {
    billing: number;
    technical: number;
    sales: number;
}

interface ChoiceDecision {
    selected: string;
    probabilities: ChoiceProbabilities;
    confidence: number;
}

const choiceDecision: ChoiceDecision = {
    selected: "billing",
    probabilities: { billing: 0.87, technical: 0.13, sales: 0 },
    confidence: 0.80,
};

interface CalibrationSample {
    predicted: number;
    actual: boolean;
}

const calibrationSamples: CalibrationSample[] = [
    { predicted: 0.76, actual: true },
    { predicted: 0.78, actual: true },
    { predicted: 0.80, actual: true },
    { predicted: 0.82, actual: true },
    { predicted: 0.84, actual: false },
];

interface CalibrationBucket {
    count: number;
    averageProbability: number;
    actualPositiveRate: number;
}

function calibrateBucket(samples: CalibrationSample[], lower: number, upper: number): CalibrationBucket {
    const inBucket = samples.filter((s) => s.predicted >= lower && s.predicted < upper);
    const count = inBucket.length;
    if (count === 0) {
        return { count: 0, averageProbability: 0, actualPositiveRate: 0 };
    }
    const averageProbability = inBucket.reduce((sum, s) => sum + s.predicted, 0) / count;
    const actualPositiveRate = inBucket.filter((s) => s.actual).length / count;
    return { count, averageProbability, actualPositiveRate };
}

interface ExpectedLossInput {
    failureCost: number;
    reviewCost: number;
    eventProbability: number;
}

interface ThresholdDecision {
    threshold: number;
    decision: "review" | "skip";
}

function decideReview(input: ExpectedLossInput): ThresholdDecision {
    const threshold = input.reviewCost / input.failureCost;
    const decision = input.eventProbability > threshold ? "review" : "skip";
    return { threshold, decision };
}

const expectedLossInput: ExpectedLossInput = {
    failureCost: 100,
    reviewCost: 5,
    eventProbability: 0.08,
};

interface ScoreLevel {
    level: number;
    probability: number;
}

const scoreLevels: ScoreLevel[] = [
    { level: 0, probability: 0 },
    { level: 1, probability: 0.96 },
    { level: 2, probability: 0.04 },
];

const publishedScore = 1.04;
const scoreConfidence = 0.94;

function weightedScore(levels: ScoreLevel[]): number {
    return levels.reduce((sum, l) => sum + l.level * l.probability, 0);
}

console.log("A. Choice probability vs. confidence");
const maxProbability = Math.max(
    choiceDecision.probabilities.billing,
    choiceDecision.probabilities.technical,
    choiceDecision.probabilities.sales,
);
console.log(`  selected: ${choiceDecision.selected}`);
console.log(
    `  probabilities: billing=${choiceDecision.probabilities.billing} ` +
        `technical=${choiceDecision.probabilities.technical} sales=${choiceDecision.probabilities.sales}`,
);
console.log(`  max probability: ${maxProbability.toFixed(2)}`);
console.log(`  confidence: ${choiceDecision.confidence.toFixed(2)}`);
console.log();

console.log("B. Calibration bucket [0.75, 0.85)");
const bucket = calibrateBucket(calibrationSamples, 0.75, 0.85);
console.log(`  bucket count: ${bucket.count}`);
console.log(`  average probability: ${bucket.averageProbability.toFixed(2)}`);
console.log(`  actual positive rate: ${bucket.actualPositiveRate.toFixed(2)}`);
console.log();

console.log("C. Expected-loss review threshold");
const thresholdDecision = decideReview(expectedLossInput);
console.log(`  failure cost: ${expectedLossInput.failureCost}`);
console.log(`  review cost: ${expectedLossInput.reviewCost}`);
console.log(`  threshold: ${thresholdDecision.threshold.toFixed(2)}`);
console.log(`  event probability: ${expectedLossInput.eventProbability.toFixed(2)}`);
console.log(`  decision: ${thresholdDecision.decision}`);
console.log();

console.log("D. Score distribution");
for (const l of scoreLevels) {
    console.log(`  level ${l.level} probability: ${l.probability.toFixed(2)}`);
}
const computedScore = weightedScore(scoreLevels);
console.log(`  score (published): ${publishedScore.toFixed(2)}`);
console.log(`  weighted result (computed): ${computedScore.toFixed(2)}`);
console.log(`  confidence: ${scoreConfidence.toFixed(2)}`);

// Demonstrates interpreting precomputed market features with Jev-shaped
// judgments while keeping the hard risk veto and the quote policy in ordinary
// code. The features and the Jev response are fixed locally, so no market
// data, order, network access, or credentials are needed.
// Run: tsc --target es2020 classify_market.ts && node classify_market.js

const regimes = ["calm", "trending", "volatile"] as const;
const directions = ["up", "down", "flat"] as const;

type Regime = typeof regimes[number];
type Direction = typeof directions[number];

interface NoulAnswer {
    noul: number;
}

interface ChoiceAnswer {
    choice: string;
    confidence: number;
    probabilities: Record<string, number>;
}

interface ScoreAnswer {
    score: number;
    confidence: number;
    legend: Record<string, string>;
    probabilities: Record<string, number>;
}

interface MarketResponse {
    regime: ChoiceAnswer;
    direction: ChoiceAnswer;
    toxicFlow: NoulAnswer;
    liquidityStress: NoulAnswer;
    inventoryPressure: ScoreAnswer;
}

interface MarketFeatures {
    spreadBps: number;
    orderBookImbalance: number;
    realizedVolatility: number;
    inventory: number;
    drawdown: number;
}

const features: MarketFeatures = {
    spreadBps: 8.2,
    orderBookImbalance: 0.71,
    realizedVolatility: 0.024,
    inventory: 0.35,
    drawdown: 0.008,
};

const maxDrawdown = 0.02;

// Fixed demonstration data, not a live model result.
function judgeMarket(input: MarketFeatures): MarketResponse {
    void input;
    return {
        regime: {
            choice: "volatile",
            confidence: 0.76,
            probabilities: { calm: 0.06, trending: 0.18, volatile: 0.76 },
        },
        direction: {
            choice: "up",
            confidence: 0.68,
            probabilities: { up: 0.68, down: 0.12, flat: 0.2 },
        },
        toxicFlow: { noul: 0.78 },
        liquidityStress: { noul: 0.64 },
        inventoryPressure: {
            score: 2.1,
            confidence: 0.6,
            legend: {
                "0": "None",
                "1": "Mild",
                "2": "Moderate",
                "3": "Heavy",
            },
            probabilities: { "0": 0.02, "1": 0.14, "2": 0.6, "3": 0.24 },
        },
    };
}

function toRegime(value: string): Regime {
    if (!regimes.includes(value as Regime)) {
        throw new Error(`Unexpected regime: ${value}`);
    }
    return value as Regime;
}

function toDirection(value: string): Direction {
    if (!directions.includes(value as Direction)) {
        throw new Error(`Unexpected direction: ${value}`);
    }
    return value as Direction;
}

if (features.drawdown >= maxDrawdown) {
    throw new Error(`Drawdown limit reached: ${features.drawdown}`);
}

const response = judgeMarket(features);
const regime = toRegime(response.regime.choice);
const direction = toDirection(response.direction.choice);
const spreadMultiplier =
    response.toxicFlow.noul >= 0.7 || response.liquidityStress.noul >= 0.7 ? 1.5 : 1.0;
const inventorySkew = response.inventoryPressure.score;

console.log(`regime: ${regime}`);
console.log(`direction: ${direction}`);
console.log(`spread multiplier: ${spreadMultiplier}`);
console.log(`inventory skew: ${inventorySkew}`);

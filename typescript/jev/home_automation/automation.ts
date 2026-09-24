// Demonstrates passing a sensor state to a Jev-shaped Noul judgment and
// letting a deterministic automation policy create a notification decision.
// The sensor and the Jev response are fixed locally, so no home automation
// server, device, network access, or credentials are needed.
// Run: tsc --target es2020 automation.ts && node automation.js

interface NoulAnswer {
    noul: number;
}

interface SensorState {
    washingMachinePowerWatts: number;
}

const sensor: SensorState = {
    washingMachinePowerWatts: 3,
};

const threshold = 0.7;

// Fixed demonstration data, not a live model result.
function judgeLaundryForgotten(input: SensorState): NoulAnswer {
    void input;
    return { noul: 0.88 };
}

const laundryForgotten = judgeLaundryForgotten(sensor).noul;
const notify = laundryForgotten >= threshold;

console.log(`power watts: ${sensor.washingMachinePowerWatts}`);
console.log(`laundry forgotten: ${laundryForgotten}`);
console.log(`notify: ${notify}`);

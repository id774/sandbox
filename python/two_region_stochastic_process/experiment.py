# experiment.py: Simulate two-region stochastic dynamics and compare estimators
#
# Description:
#   Generate seeded Euler-Maruyama time series and compare estimated
#   integrated autocorrelation times and inter-region correlations with
#   continuous-time and discrete-time reference values.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   .venv/bin/python -B python/two_region_stochastic_process/experiment.py
#
# Requirements:
#   Python 3.12 or later
#   NumPy 2.5.4 for the documented reproduction environment

import sys

import numpy as np

SEED = 20261024
D = 1.0
BURN_IN = 50.0
L = 5.0
REPEATS = 20
CONDITIONS = (("覚醒", 2.0, 1.0), ("麻酔", 4.0, 0.4))
STEP_SIZES = (0.02, 0.01)
DURATIONS = (200.0, 500.0)


def continuous_reference(alpha, beta, limit):
    slow = alpha - beta
    fast = alpha + beta
    t_inf = (alpha * alpha + beta * beta) / (alpha * (alpha * alpha - beta * beta))
    t_finite = (
        (fast / (2.0 * alpha)) * (-np.expm1(-slow * limit)) / slow
        + (slow / (2.0 * alpha)) * (-np.expm1(-fast * limit)) / fast
    )
    return t_inf, t_finite, beta / alpha


def euler_reference(alpha, beta, dt, limit, diffusion):
    rho_slow = 1.0 - (alpha - beta) * dt
    rho_fast = 1.0 - (alpha + beta) * dt
    assert abs(rho_slow) < 1.0 and abs(rho_fast) < 1.0
    var_slow = 2.0 * diffusion * dt / (1.0 - rho_slow ** 2)
    var_fast = 2.0 * diffusion * dt / (1.0 - rho_fast ** 2)
    lag = np.arange(round(limit / dt) + 1)
    corr = (var_slow * rho_slow ** lag + var_fast * rho_fast ** lag) / (var_slow + var_fast)
    t_ref = np.trapezoid(corr, dx=dt)
    s_ref = (var_slow - var_fast) / (var_slow + var_fast)
    return t_ref, s_ref


def simulate(alpha, beta, dt, duration, seed, diffusion):
    burn = round(BURN_IN / dt)
    count = round(duration / dt)
    rng = np.random.default_rng(seed)
    noise = rng.standard_normal((burn + count, 2))
    result = np.empty((count, 2))
    x1 = x2 = 0.0
    sigma = np.sqrt(2.0 * diffusion * dt)
    for i, (z1, z2) in enumerate(noise):
        next_x1 = x1 + dt * (-alpha * x1 + beta * x2) + sigma * z1
        next_x2 = x2 + dt * (beta * x1 - alpha * x2) + sigma * z2
        x1, x2 = next_x1, next_x2
        if i >= burn:
            result[i - burn, 0] = x1
            result[i - burn, 1] = x2
    return result


def estimate_time_scale(series, dt, limit):
    centered = series - series.mean()
    n = len(centered)
    max_lag = round(limit / dt)
    assert max_lag < n
    freq = np.fft.rfft(centered, n=2*n)
    autocov = np.fft.irfft(freq * freq.conj(), n=2*n)[:max_lag+1].real
    autocov /= n - np.arange(max_lag + 1)
    acf = autocov / autocov[0]
    return float(np.trapezoid(acf, dx=dt))


def main():
    print("Python", ".".join(map(str, sys.version_info[:3])), "NumPy", np.__version__)
    for condition_i, (label, alpha, beta) in enumerate(CONDITIONS):
        t_inf, t_lim, s_cont = continuous_reference(alpha, beta, L)
        print(f"{label}: T∞={t_inf:.4f} TL={t_lim:.4f} S={s_cont:.4f}")
        print("dt   期間   TE     平均T   MAE_T  SE     平均S   MAE_S")
        for dt_i, dt in enumerate(STEP_SIZES):
            for duration_i, duration in enumerate(DURATIONS):
                t_euler, s_euler = euler_reference(alpha, beta, dt, L, D)
                times, cors = [], []
                for repeat in range(REPEATS):
                    seed = SEED + condition_i * 10000 + dt_i * 1000 + duration_i * 100 + repeat
                    sample = simulate(alpha, beta, dt, duration, seed, D)
                    times.append(estimate_time_scale(sample[:, 0], dt, L))
                    cors.append(float(np.corrcoef(sample, rowvar=False)[0, 1]))
                t = np.array(times)
                s = np.array(cors)
                print(f"{dt:.2f} {duration:.0f} {t_euler:.4f} {t.mean():.4f} {np.abs(t - t_euler).mean():.4f} {s_euler:.4f} {s.mean():.4f} {np.abs(s - s_euler).mean():.4f}")


if __name__ == "__main__":
    main()

# particle_structure.py: Measure particle motion and proximity graph changes
#
# Description:
#   Compare centroid velocity and structural amplitude for fixed particle
#   positions and one-step reciprocal and nonreciprocal interactions.
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From the repository root:
#     PYTHONOPTIMIZE=0 python -B python/particle_structure/particle_structure.py
#
# Requirements:
#   - Python 3.13 (reference: 3.13.5)
#   - NumPy 2.2.4
#   - Assertions enabled; do not use -O or -OO.

import numpy as np


def proximity_edges(positions, cutoff):
    return {
        (i, j)
        for i in range(len(positions))
        for j in range(i + 1, len(positions))
        if np.linalg.norm(positions[j] - positions[i]) < cutoff
    }


def centroid_velocity(before, after, dt):
    if before.shape != after.shape:
        raise ValueError("Particle arrays must have the same shape.")
    if dt <= 0:
        raise ValueError("dt must be positive.")
    return (after.mean(axis=0) - before.mean(axis=0)) / dt


def structural_amplitude(before_edges, after_edges):
    return np.sqrt(len(before_edges ^ after_edges))


def pair_forces(positions, g_ab, g_ba, interaction_radius):
    displacement = positions[1] - positions[0]
    distance = np.linalg.norm(displacement)
    if distance == 0.0:
        raise ValueError("Coincident particles have no unit direction.")
    if distance >= interaction_radius:
        return np.zeros_like(positions)
    direction = displacement / distance
    return np.array([-g_ab * direction, g_ba * direction])


def step_pair(positions, velocities, dt, g_ab, g_ba,
              interaction_radius):
    forces = pair_forces(positions, g_ab, g_ba, interaction_radius)
    next_velocities = velocities + dt * forces
    next_positions = positions + dt * next_velocities
    return next_positions, next_velocities


def observe_transition(before, after, dt, cutoff):
    before_edges = proximity_edges(before, cutoff)
    after_edges = proximity_edges(after, cutoff)
    return {
        "velocity": centroid_velocity(before, after, dt),
        "before_edges": before_edges,
        "after_edges": after_edges,
        "changed_edges": len(before_edges ^ after_edges),
        "amplitude": structural_amplitude(before_edges, after_edges),
        "edge_count_delta": len(after_edges) - len(before_edges),
    }


def check_close(actual, expected):
    np.testing.assert_allclose(
        actual, expected, rtol=0.0, atol=1e-12, equal_nan=False,
        strict=True,
    )


def check_observation(result, velocity, before_edges, after_edges,
                      changed_edges, amplitude, edge_count_delta):
    check_close(result["velocity"], np.array(velocity, dtype=np.float64))
    assert result["before_edges"] == before_edges
    assert result["after_edges"] == after_edges
    assert result["changed_edges"] == changed_edges
    check_close(result["amplitude"], np.float64(amplitude))
    assert result["edge_count_delta"] == edge_count_delta


def print_result(name, result):
    vx, vy = result["velocity"]
    print(
        f"{name}: velocity=({vx:.1f}, {vy:.1f}), "
        f"amplitude={result['amplitude']:.1f}, "
        f"changed_edges={result['changed_edges']}, "
        f"edge_count_delta={result['edge_count_delta']}"
    )


def initial_positions():
    return np.array([
        [-0.5, -1.5],
        [ 0.5, -1.5],
        [-0.5,  1.5],
        [ 0.5,  1.5],
    ], dtype=np.float64)


def test_translation():
    before = initial_positions()
    after = before + np.array([1.0, 0.0])
    result = observe_transition(before, after, 1.0, 2.0)
    edges = {(0, 1), (2, 3)}
    check_observation(result, (1.0, 0.0), edges, edges, 0, 0.0, 0)
    print_result("translation", result)


def test_rearrangement():
    before = initial_positions()
    after = np.array([
        [-1.5, -0.5],
        [ 1.5, -0.5],
        [-1.5,  0.5],
        [ 1.5,  0.5],
    ], dtype=np.float64)
    result = observe_transition(before, after, 1.0, 2.0)
    check_observation(
        result, (0.0, 0.0), {(0, 1), (2, 3)},
        {(0, 2), (1, 3)}, 4, 2.0, 0,
    )
    print_result("rearrangement", result)


def test_pair_interaction():
    positions = np.array([[0.0, 0.0], [1.0, 0.0]], dtype=np.float64)
    velocities = np.zeros_like(positions)
    initial_x = positions.copy()
    initial_v = velocities.copy()
    cases = [
        ("reciprocal", -1.0, [[0.01, 0.0], [0.99, 0.0]],
         [[0.1, 0.0], [-0.1, 0.0]], (0.0, 0.0), 0.98),
        ("nonreciprocal", 1.0, [[0.01, 0.0], [1.01, 0.0]],
         [[0.1, 0.0], [0.1, 0.0]], (0.1, 0.0), 1.0),
    ]
    for name, g_ba, expected_x, expected_v, expected_cv, expected_d in cases:
        after, next_v = step_pair(positions, velocities, 0.1, -1.0,
                                  g_ba, 2.0)
        check_close(after, np.array(expected_x, dtype=np.float64))
        check_close(next_v, np.array(expected_v, dtype=np.float64))
        np.testing.assert_array_equal(positions, initial_x)
        np.testing.assert_array_equal(velocities, initial_v)
        distance = np.linalg.norm(after[1] - after[0])
        check_close(distance, np.float64(expected_d))
        result = observe_transition(positions, after, 0.1, 2.0)
        edges = {(0, 1)}
        check_observation(result, expected_cv, edges, edges, 0, 0.0, 0)
        print_result(name, result)
        print(f"  distance={distance:.2f}")


def test_boundaries():
    at_cutoff = np.array([[0.0, 0.0], [2.0, 0.0]])
    outside = np.array([[0.0, 0.0], [3.0, 0.0]])
    assert proximity_edges(at_cutoff, 2.0) == set()
    for positions in (at_cutoff, outside):
        check_close(pair_forces(positions, -1.0, 1.0, 2.0),
                    np.zeros_like(positions))
    with np.testing.assert_raises(ValueError):
        pair_forces(np.zeros((2, 2)), -1.0, 1.0, 2.0)
    print("boundary checks: PASS")


def main():
    test_translation()
    test_rearrangement()
    test_pair_interaction()
    test_boundaries()
    print("All checks passed.")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""
algorithm-pipeline.py
Exemple de pipeline d'optimisation externe inclus via \lstinputlisting.
Démontre le découplage entre code source externe et composition LaTeX.
"""

from dataclasses import dataclass
from typing import List, Tuple
import math


@dataclass
class OptimizationConfig:
    learning_rate: float = 0.01
    weight_decay: float = 1e-4
    max_epochs: int = 100
    tolerance: float = 1e-6


def optimize_step(
    weights: List[float],
    gradients: List[float],
    config: OptimizationConfig,
) -> Tuple[List[float], float]:
    """Exécute un pas de descente de gradient avec régularisation L2."""
    updated = []
    norm_sq = 0.0

    for w, g in zip(weights, gradients):
        # Descente avec pénalité de Tikhonov (L2)
        new_w = w - config.learning_rate * (g + config.weight_decay * w)
        updated.append(new_w)
        norm_sq += (new_w - w) ** 2

    delta_norm = math.sqrt(norm_sq)
    return updated, delta_norm


if __name__ == "__main__":
    cfg = OptimizationConfig(learning_rate=0.05)
    w_init = [1.0, -0.5, 0.25]
    g_dummy = [0.1, 0.05, -0.02]

    w_next, delta = optimize_step(w_init, g_dummy, cfg)
    print(f"Poids actualisés : {w_next}, variation : {delta:.6e}")


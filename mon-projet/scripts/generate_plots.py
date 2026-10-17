#!/usr/bin/env python3
"""
scripts/generate_plots.py
Génération automatisée de données brutes et de graphiques vectoriels pour la thèse.

Exécution recommandée via l'environnement virtuel uv :
    uv run python scripts/generate_plots.py

Ce script produit :
1. data/benchmark-results.csv : Données numériques légères pour pgfplots dans LaTeX.
2. figures/python-3d-surface.pdf : Surface 3D complexe et dense pré-rendue en PDF vectoriel.
3. figures/python-2d-benchmark.pdf : Courbe 2D haute résolution avec intervalle de confiance.
"""

from pathlib import Path
import csv
import math
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm
from matplotlib.colors import LinearSegmentedColormap

# Dossiers cibles du projet
BASE_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = BASE_DIR / "data"
FIGURES_DIR = BASE_DIR / "figures"

# Palette chromatique officielle mythesis (RGB normalisé)
HEX_PRIMARY = "#141419"    # Noir chaud graphite
HEX_SECONDARY = "#3C414B"  # Gris foncé texturé
HEX_ACCENT = "#4B729F"     # Bleu ardoise académique
HEX_MUTED = "#6E7378"      # Gris intermédiaire
HEX_BG = "#F5F5F7"         # Fond neutre très pâle


def setup_matplotlib_style():
    """Configure Matplotlib pour une harmonie typographique totale avec LaTeX/KOMA-Script."""
    plt.rcParams.update({
        "font.family": "serif",
        "font.size": 9.5,
        "axes.labelsize": 9.5,
        "axes.titlesize": 10,
        "legend.fontsize": 8.5,
        "xtick.labelsize": 8.0,
        "ytick.labelsize": 8.0,
        "figure.titlesize": 11,
        "text.color": HEX_PRIMARY,
        "axes.labelcolor": HEX_PRIMARY,
        "xtick.color": HEX_SECONDARY,
        "ytick.color": HEX_SECONDARY,
        "axes.edgecolor": HEX_MUTED,
        "axes.linewidth": 0.8,
        "grid.color": HEX_MUTED,
        "grid.linestyle": ":",
        "grid.alpha": 0.5,
    })


def generate_benchmark_csv() -> Path:
    """
    Cas 1 : Génère le jeu de données d'entraînement pour pgfplots.
    Fournit AccuracyProposed et AccuracyBaseline sur la même échelle (50% - 100%).
    """
    DATA_DIR.mkdir(parents=True, exist_ok=True)
    target_csv = DATA_DIR / "benchmark-results.csv"

    rows = []
    for it in range(1, 21):
        # Précisions comparables sur l'axe Y [50 %, 100 %]
        acc_prop = round(100.0 * (1.0 - 0.40 * math.exp(-0.24 * it)), 1)
        acc_base = round(100.0 * (0.84 - 0.32 * math.exp(-0.16 * it)), 1)

        # Fonctions de perte associées [0.0, 1.0]
        loss_prop = round(0.08 + 0.70 * math.exp(-0.30 * it), 3)
        loss_base = round(0.30 + 0.55 * math.exp(-0.18 * it), 3)

        rows.append({
            "Iteration": it,
            "AccuracyProposed": acc_prop,
            "AccuracyBaseline": acc_base,
            "LossProposed": loss_prop,
            "LossBaseline": loss_base,
        })

    with open(target_csv, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "Iteration",
                "AccuracyProposed",
                "AccuracyBaseline",
                "LossProposed",
                "LossBaseline",
            ],
        )
        writer.writeheader()
        writer.writerows(rows)

    print(f"[OK] Cas 1 - CSV pour pgfplots généré : {target_csv}")
    return target_csv


def generate_3d_surface_pdf() -> Path:
    """
    Cas 2 : Génère un graphique 3D dense et complexe (surface d'énergie / paysage de perte).
    Ce type de tracé dense comporte des milliers de polygones qu'il est indispensable
    de pré-rendre avec Python plutôt que de surcharger le moteur TeX.
    """
    FIGURES_DIR.mkdir(parents=True, exist_ok=True)
    target_pdf = FIGURES_DIR / "python-3d-surface.pdf"

    setup_matplotlib_style()

    # Dimensions : largeur calibrée sur environ 0.85\textwidth
    fig = plt.figure(figsize=(5.6, 3.8), dpi=300)
    ax = fig.add_subplot(111, projection="3d")

    # Grille haute résolution (60 x 60 = 3600 mailles)
    x = np.linspace(-3.0, 3.0, 60)
    y = np.linspace(-3.0, 3.0, 60)
    X, Y = np.meshgrid(x, y)
    R = np.sqrt(X**2 + Y**2)
    # Paysage non-convexe multi-puits
    Z = np.sin(2.2 * R) / (R + 0.6) + 0.15 * (X**2 - Y**2) / 3.0

    # Colormap personnalisée élégante inspirée de mythesis
    custom_cmap = LinearSegmentedColormap.from_list(
        "ThesisCmap", [HEX_PRIMARY, HEX_SECONDARY, HEX_ACCENT, "#8BA9C4", "#E8EFF5"]
    )

    surf = ax.plot_surface(
        X,
        Y,
        Z,
        cmap=custom_cmap,
        edgecolor=HEX_SECONDARY,
        linewidth=0.15,
        antialiased=True,
        alpha=0.92,
    )

    # Trajectoire d'optimisation projetée sur la surface
    t = np.linspace(0.2, 2.5, 30)
    x_traj = 2.4 * np.exp(-0.8 * t) * np.cos(3.0 * t)
    y_traj = 2.4 * np.exp(-0.8 * t) * np.sin(3.0 * t)
    r_traj = np.sqrt(x_traj**2 + y_traj**2)
    z_traj = np.sin(2.2 * r_traj) / (r_traj + 0.6) + 0.15 * (x_traj**2 - y_traj**2) / 3.0 + 0.05

    ax.plot(
        x_traj,
        y_traj,
        z_traj,
        color="#D9534F",
        linewidth=2.2,
        marker="o",
        markersize=3,
        label="Trajectoire de descente",
    )

    ax.set_xlabel("Paramètre $\\theta_1$", labelpad=4)
    ax.set_ylabel("Paramètre $\\theta_2$", labelpad=4)
    ax.set_zlabel("Coût $\\mathcal{L}(\\theta)$", labelpad=4)
    ax.view_init(elev=32, azim=-55)

    # Fond transparent et sobre
    ax.xaxis.pane.fill = False
    ax.yaxis.pane.fill = False
    ax.zaxis.pane.fill = False
    ax.xaxis.pane.set_edgecolor(HEX_MUTED)
    ax.yaxis.pane.set_edgecolor(HEX_MUTED)
    ax.zaxis.pane.set_edgecolor(HEX_MUTED)

    # Barre de couleur discrète
    cbar = fig.colorbar(surf, ax=ax, shrink=0.55, aspect=12, pad=0.08)
    cbar.set_label("Densité d'énergie", rotation=270, labelpad=12)

    plt.tight_layout()
    fig.savefig(target_pdf, bbox_inches="tight")
    plt.close(fig)

    print(f"[OK] Cas 2 - Surface 3D vectorielle PDF générée : {target_pdf}")
    return target_pdf


if __name__ == "__main__":
    generate_benchmark_csv()
    generate_3d_surface_pdf()

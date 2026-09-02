# Biomechanical Analysis of Human Diaphragmatic Tissue

MATLAB implementation for analyzing uniaxial tensile tests and stress-relaxation experiments on human diaphragmatic tissue (native vs. decellularized).

## Overview
This repository contains the numerical implementation used to model the non-linear viscoelastic response of human diaphragmatic tissue subjected to cyclic mechanical testing and stress relaxation.

The main focus of the code is:
* Modelling non-linear elastic behavior combined with internal viscous variables ($\epsilon_v$).
* Simulating stress-strain hysteresis and preconditioning effects over consecutive loading cycles.
* Fitting stress relaxation data using a Generalized Maxwell Model to identify the asymptotic equilibrium stress ($E_{eq}$).

## Contents
* `src/`: MATLAB scripts (`.m`) for parameter identification, numerical simulation, and data plotting.
* `MECCANICA_DEI_TESSUTI-5.pdf`: Full report detailing the theoretical background, mathematical formulation, and experimental results.

## Notes & Acknowledgments
* Experimental data and decellularization protocols (SDS, Tergitol™, SDC) originate from background academic literature in tissue engineering.
* Viscoelastic schematic figures were drawn using *ElViS-Simulator*.

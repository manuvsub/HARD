# HARD NMR Pulse Sequence

## Overview
This repository contains the NMR pulse sequence file `hard3d.x` for measuring the rotating frame relaxation rates R1ₚ and R2ₚ using adiabatic 180-degree pulses. This sequence is designed for both 13C and 15N labeled samples, and can be used in different configurations to probe slow microsecond-to-millisecond protein dynamics. The sequence was originally coded by Youlin Xia, with a focus on acquiring six 2D planes using hyperbolic secant (HS) pulses with varying "stretching" factors.

## Pulse Sequence Summary
The HARD pulse sequence implements adiabatic full passage (AFP) pulses to induce relaxation dispersions that are sensitive to slow dynamic processes such as protein folding, binding, allostery, and molecular recognition. The sequence employs hyperbolic secant pulses (HS1, HS2, HS4, HS6, HS8) in various combinations to explore the relaxation rates R1ₚ and R2ₚ, as described in the following publication:

**Reference:** S. Mangia et al., _JACS_ 132, 9979-9981 (2010) [doi:10.1021/ja1038787](https://doi.org/10.1021/ja1038787).

## Pulse Acquisition Planes
Six 2D planes are acquired:
1. **1st plane:** Reference
2. **2nd plane:** Shaped pulse HS1_R40
3. **3rd plane:** Shaped pulse HS2_R40
4. **4th plane:** Shaped pulse HS4_R40
5. **5th plane:** Shaped pulse HS6_R40
6. **6th plane:** Shaped pulse HS8_R40

Each plane corresponds to a different hyperbolic secant stretching factor, allowing for a comprehensive analysis of the relaxation dispersion across a range of dynamic processes.

## Experimental Setup
- The sequence can be run in two main modes depending on the type of relaxation being measured:
  - `zgoptns -DR1` for R1ₚ
  - `zgoptns -DR2` for R2ₚ

- If the sample is labeled with 13C or 15N, use:
  - `zgoptns -DR1 -DLABEL_CN` for R1ₚ
  - `zgoptns -DR2 -DLABEL_CN` for R2ₚ

### Gradient Specifications
- For z-only gradients, use the following ratios:
  - `gp1:gp2:gp3` = 50:80:16.2 (for N-15 labeled samples)
  
- Gradient file settings:
  - `gpnam1`, `gpnam2`, `gpnam3`: SINE.100

### Preprocessor Flags
- **LABEL_CN**: For 13C and 15N labeled samples, start the experiment with the `-DLABEL_CN` option for proper parameterization.

## Key Parameters
- `p1`, `p2`: High power pulses (90° and 180° respectively)
- `p24`: 180° shaped pulse (adiabatic)
- `d1`: Relaxation delay (typically 1-5 times T1)
- `d24`, `d25`, `d26`: Delays for 1/(4J) or 1/(8J) for YH multiplicities

## Applications
This pulse sequence is ideal for probing slow protein dynamics in both small

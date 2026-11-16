---
layout: page
permalink: /software/
title: software
description: Research software and computational tools for magnetic scattering, micromagnetics, and electromagnetism.
nav: true
nav_order: 4
---

<div class="software-grid">
  <section class="software-card software-card--featured">
    <div class="eyebrow">Featured open-source package</div>
    <h2>NuMagSANS</h2>
    <p>GPU-accelerated computation of nuclear and magnetic small-angle neutron-scattering cross sections and correlation functions from complex, position-dependent material data.</p>
    <div><span class="pill">GPU</span><span class="pill">SANS</span><span class="pill">Open source</span></div>
    <div class="card-links">
      <a href="https://github.com/AdamsMP92/NuMagSANS">GitHub repository</a>
      <a href="https://doi.org/10.1107/S160057672600258X">J. Appl. Cryst. 59, 943–959</a>
    </div>
    <div class="doi-badge">
      <a href="https://doi.org/10.5281/zenodo.18824364" aria-label="NuMagSANS version 1.0.0 on Zenodo">
        <img src="{{ '/assets/img/software/numagsans-doi.svg' | relative_url }}" alt="DOI 10.5281/zenodo.18824364">
      </a>
    </div>
  </section>

  <section class="software-card">
    <div class="eyebrow">Data analysis</div>
    <h3>MuMag2022</h3>
    <p>A browser-native Python app for fitting magnetic-field-dependent unpolarized SANS data in the approach-to-saturation regime, with exchange-stiffness profiling, uncertainty-aware residual analysis, and stability diagnostics.</p>
    <div><span class="pill">Python</span><span class="pill">SANS fitting</span><span class="pill">Web app</span></div>
    <div class="card-links">
      <a href="https://adamsmp92.github.io/MuMag2022_python/">Open web app</a>
      <a href="https://github.com/AdamsMP92/MuMag2022_python">GitHub repository</a>
      <a href="https://doi.org/10.1107/S1600576722005349">J. Appl. Cryst. 55, 1055–1062</a>
    </div>
  </section>

  <section class="software-card">
    <div class="eyebrow">Detector analysis</div>
    <h3>SANS2D Mode Analyzer</h3>
    <p>A browser-native tool for model-independent orthogonal angular–radial mode decompositions of two-dimensional small-angle scattering patterns, with uncertainty-aware fitting, symmetry diagnostics, and detector-centering tools.</p>
    <div><span class="pill">Python</span><span class="pill">2D SANS</span><span class="pill">Web app</span></div>
    <div class="card-links">
      <a href="https://adamsmp92.github.io/SANS2D_mode_analyzer_open/">Open web app</a>
      <a href="https://github.com/AdamsMP92/SANS2D_mode_analyzer_open/tree/v0.1.0">Source · v0.1.0</a>
      <a href="https://doi.org/10.5281/zenodo.24253614">Zenodo · v0.1.0</a>
    </div>
    <div class="doi-badge">
      <a href="https://doi.org/10.5281/zenodo.24253614" aria-label="SANS2D Mode Analyzer version 0.1.0 on Zenodo">
        <img src="{{ '/assets/img/software/sans2d-mode-analyzer-doi.svg' | relative_url }}" alt="DOI 10.5281/zenodo.24253614">
      </a>
    </div>
  </section>

  <section class="software-card">
    <div class="eyebrow">Simulation</div>
    <h3>SWSANS</h3>
    <p>A browser-native Python simulator for randomly oriented Stoner–Wohlfarth ensembles, Landau–Lifshitz relaxation, hysteresis, correlation tensors, and magnetic SANS observables in both scattering geometries.</p>
    <div><span class="pill">Python</span><span class="pill">Spin dynamics</span><span class="pill">Web app</span></div>
    <div class="card-links">
      <a href="https://adamsmp92.github.io/SWSANS_python/">Open web app</a>
      <a href="https://github.com/AdamsMP92/SWSANS_python/tree/v0.1.0">Source · v0.1.0</a>
      <a href="https://doi.org/10.5281/zenodo.24280735">Zenodo · v0.1.0</a>
      <a href="https://doi.org/10.1107/S205225252300180X">IUCrJ 10, 261–269</a>
    </div>
    <div class="doi-badge">
      <a href="https://doi.org/10.5281/zenodo.24280735" aria-label="SWSANS version 0.1.0 on Zenodo">
        <img src="{{ '/assets/img/software/swsans-doi.svg' | relative_url }}" alt="DOI 10.5281/zenodo.24280735">
      </a>
    </div>
  </section>

  <section class="software-card">
    <div class="eyebrow">Analytical reference</div>
    <h3>LangevinSANS</h3>
    <p>A browser-native analytical model for the reversible equilibrium magnetization and magnetic SANS of dilute, noninteracting spherical macrospins, including the exact orientational moments and unpolarized and spin-flip observables in both scattering geometries.</p>
    <div><span class="pill">Python</span><span class="pill">Langevin model</span><span class="pill">Web app</span></div>
    <div class="card-links">
      <a href="https://adamsmp92.github.io/LangevinSANS/">Open web app</a>
      <a href="https://github.com/AdamsMP92/LangevinSANS/releases/tag/v0.1.0">Release · v0.1.0</a>
    </div>
  </section>

  <section class="software-card">
    <div class="eyebrow">Reduced micromagnetics</div>
    <h3>Minimal Hyperbolic Micromagnetics</h3>
    <p>A reduced Python model for vortex nucleation and reversal in spherical magnetic nanoparticles, with optimized hyperbolic-vortex profiles, quasistatic hysteresis, and Stoner–Wohlfarth reference calculations.</p>
    <div><span class="pill">Python</span><span class="pill">Micromagnetics</span><span class="pill">Hysteresis</span><span class="pill">Web app</span></div>
    <div class="card-links">
      <a href="https://adamsmp92.github.io/MinimalHyperbolicMicromagnetics/">Open web app</a>
      <a href="https://github.com/AdamsMP92/MinimalHyperbolicMicromagnetics">GitHub repository</a>
      <a href="https://doi.org/10.1103/8rkf-j2kn">Phys. Rev. B 113, 224406</a>
    </div>
  </section>

  <section class="software-card">
    <div class="eyebrow">Engineering tool</div>
    <h3>Solenoid Calculator</h3>
    <p>A browser-native Python app for calculating wire length, DC inductance, resistance, impedance, axial magnetic flux density, and discrete winding geometry using an energy-based Fourier-space model.</p>
    <div><span class="pill">Python</span><span class="pill">Web app</span><span class="pill">Coils</span></div>
    <div class="card-links">
      <a href="https://adamsmp92.github.io/SolenoidCalculator/">Open web app</a>
      <a href="https://github.com/AdamsMP92/SolenoidCalculator/tree/v0.1.0">Source · v0.1.0</a>
      <a href="https://doi.org/10.5281/zenodo.24265601">Zenodo · v0.1.0</a>
    </div>
    <div class="doi-badge">
      <a href="https://doi.org/10.5281/zenodo.24265601" aria-label="Solenoid Calculator version 0.1.0 on Zenodo">
        <img src="{{ '/assets/img/software/solenoid-calculator-doi.svg' | relative_url }}" alt="DOI 10.5281/zenodo.24265601">
      </a>
    </div>
  </section>

  <section class="software-card">
    <div class="eyebrow">Analytical fields</div>
    <h3>Magnet Calculator</h3>
    <p>Computes magnetic fields for cuboids, cylinders, and spheres, including circular cuboid arrangements such as Halbach arrays and brushless-motor rotors.</p>
    <div><span class="pill">Magnetostatics</span><span class="pill">Benchmarking</span></div>
    <div class="card-links"><a href="https://drive.google.com/drive/folders/11YY3QsdrOn5YPNyyMXkgH3y9wzUp3Gtk?usp=share_link">App & documentation</a></div>
  </section>
</div>

<div class="notice">Unless stated otherwise in the individual repository or download, these projects are distributed under the GNU General Public License v3.0. I also contribute to the open, reproducible multiscale-modelling framework <a href="https://mammos-project.github.io/">MaMMoS</a>.</div>

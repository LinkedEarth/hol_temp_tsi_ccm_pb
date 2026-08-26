# Data preparation & exploration

## Contents

1. [Standardize Time Axes](1_setup__standardize_time_axes.ipynb)
2. [Detrending & High-Pass Filtering (Figure S5)](2_setup__detrend_highpass_1kyr.ipynb)
3. [Raw Data & Power Spectra (Figures 1 & S5)](3_plot__Fig1_real_ts_psd_unified.ipynb)

Before any analysis, the four source records (two temperature reconstructions, two
TSI reconstructions) are put on a common decadal time axis. Figure 1 summarizes these
raw series and their spectral content. Linear detrending and 1-kyr high-pass
filtering were added afterward as sensitivity checks, to test whether slow background
trends affect the CCM results; the extended comparison across every supplemental
record and treatment is Fig. S5.

## Source datasets

### Total Solar Irradiance

- **WU18** — Wu, C.-J., Krivova, N. A., Solanki, S. K., & Usoskin, I. G. (2018). Solar total and spectral irradiance reconstruction over the last 9000 years. *Astronomy & Astrophysics*, 620, A120. https://doi.org/10.1051/0004-6361/201832956
- **VIEIRA11** — Vieira, L. E. A., Solanki, S. K., Krivova, N. A., & Usoskin, I. (2011). Evolution of the solar irradiance during the Holocene. *Astronomy & Astrophysics*, 531, A6. https://doi.org/10.1051/0004-6361/201015843


### Temperature

Main manuscript:

- **ERB22** — Erb, M. P., McKay, N. P., Steiger, N., Dee, S., Hancock, C., Ivanovic, R. F., et al. (2022). Reconstructing Holocene temperatures in time and space using paleoclimate data assimilation. *EGUsphere*, 2022, 1-48. https://doi.org/10.5194/egusphere-2022-184
- **ALLEY00 (GISP2)** — Alley (2000). GISP2 ice core temperature reconstruction. https://www.ncei.noaa.gov/pub/data/paleo/icecore/greenland/summit/gisp2/isotopes/gisp2_temp_alley2000-noaa.txt

Supplementary Greenland records:

- **Döring22 (GISP2)** — Döring, M., & Leuenberger, M. C. (2022). Comparison of Holocene temperature reconstructions based on GISP2 multiple-gas-isotope measurements. *Quaternary Science Reviews*, 280, 107274. https://doi.org/10.1016/j.quascirev.2021.107274
- **Martin24 (GISP2, NEEM, NGRIP)** — Martin, K. C., Buizert, C., Brook, E., Williams, O. L., Edwards, J. S., Riddell-Young, B., et al. (2024). Greenland Ice Cores Reveal a South-To-North Difference in Holocene Thermal Maximum Timings. *Geophysical Research Letters*, 51(24), e2024GL111405. https://doi.org/10.1029/2024GL111405. Underlying dataset: https://arcticdata.io/catalog/view/doi:10.18739/A2KP7TT2N
- **Seierstad14 (GISP2, NGRIP δ¹⁸O)** — Seierstad, I. K., Abbott, P. M., Bigler, M., Blunier, T., Bourne, A. J., Brook, E., et al. (2014). Consistently dated records from the Greenland GRIP, GISP2 and NGRIP ice cores for the past 104 ka reveal regional millennial-scale δ¹⁸O gradients with possible Heinrich event imprint. *Quaternary Science Reviews*, 106, 29-46. https://doi.org/10.1016/j.quascirev.2014.10.032
- **Tian22 (transient GCM GMST)** — Tian, Z., Jiang, D., Zhang, R., & Su, B. (2022). Transient climate simulations of the Holocene: experimental design and boundary conditions. *Geoscientific Model Development*, 15(11), 4469-4487. https://doi.org/10.5194/gmd-15-4469-2022. Simulation output: https://doi.org/10.5281/zenodo.6269566


[![extended dataset](../../figures/FigS5__real_ts_psd_extended/FigS5_real_ts_psds.png)](../../figures/FigS5__real_ts_psd_extended/FigS5_real_ts_psds.pdf)
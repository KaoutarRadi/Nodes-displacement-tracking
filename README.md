<div align="center">

<h1>Deformation Tracking of Truss Lattices Under Dynamic Loading Based on Digital Image Correlation</h1>
<a href="https://doi.org/10.1016/j.mechmat.2023.104658"><img src="https://zenodo.org/badge/DOI/10.5281/zenodo.10011767.svg" alt="DOI"></a>


<p>
  Kaoutar Radi<sup>1</sup>, Fabian Allamand <sup>1</sup>, Dennis M. Kochmann<sup>1</sup>
</p>

<p>
  <sup>1</sup> ETH Zurich, Switzerland <br>
</p>

</div>

<div align="center">
    <img src="2D_HoneyComb_tension.gif" alt="" width="200" height="200">
</div>

## Introduction 

Traditional techniques like Digital Image Correlation (DIC) face challenges in tracking the time-dependent deformation of 3D-printed low-density trusses. This is due to the mismatch between strut sizes and the truss's overall field of view, complications in speckle pattern application, and the absence of a consistent bright background during tests—issues that are exacerbated at high rates and with significant 3D deformations. To address these challenges, we introduce an efficient DIC-based method designed to track nodal displacements in both periodic and non-periodic truss structures across various loading rates. The primary application of this technique is to analyze the extensive deformation in different truss designs, the techniaue can also be used to track displacements of different features in a wide range of materials under static and dynamic loading.This repository, provides the essential node tracking code, complete with examples and a comprehensive user manual.

## Setup

To effectively track the displacement of nodes or features in a sample, follow the steps outlined below:


### 1.  Parameters configuration:
- **Directory**: `src`
   - Open the `Main.m` script.
   - Define the path to the images intended for analysis.
   - Select the grid type: 
     - Options: type=1, 2, 3, 4, or 5
     - Types 1-4: Pre-programmed grids
     - Type 5: Personalized grid uploaded by the user (accepted formats: `.dat` or `.csv`). This should contain the initial coordinates of the features to be tracked.
   - Set other parameters as desired.

### 2.  PointLocations for Artificial Grid Creation:
- **Directory**: `src`
   - The `Main.m` script uses `PointLocations.m` to overlay an artificial grid on the lattice/sample's surface.
   - Grid types: 1, 2, 3 for pre-generated grids. Choose type 5 for a personalized grid.
   - ⚠️ **User Advisory**: Modifying the `PointLocations.m` script is not necessary.

### 3.  Node Displacement Tracking with `ImageTracking.m`:
- **Directory**: `src`
   - The algorithm for tracking node displacement is described within `ImageTracking.m`.
   - ⚠️ **User Advisory**: Direct changes to this script are not required.

### 4.  Output Results:
- **Directory**: User-defined (for example, `output`)
   - Execution of the `Main.m` script yields:
     - An `.avi` video showcasing the tracking analysis.
     - Dual `.txt` files capturing x and y coordinates for each image and feature.

## Examples and Trial Dataset

Given the sizable nature of our example dataset, we've chosen to host it externally. This dataset comprises:

- 🎞️ **Sample Videos**: Explore the provided videos to visualize expected outcomes..
- 📊 **Trial Data**: Utilize the example input data to perform a preliminary run of the code.

To utilize these resources:  [Download here](https://zenodo.org/records/10040069?token=eyJhbGciOiJIUzUxMiJ9.eyJpZCI6IjE5Zjc0MWM2LTk4NWEtNDI3Yy05ZjBkLWQzMGU2ODBmMDdjYyIsImRhdGEiOnt9LCJyYW5kb20iOiJjMzUzZTIyNDQyMjdlNGU5ZjA5MDkxMTQ2YzRjYmUxMCJ9.gPDNd4OQ4B-p7PWk4Jc8fcwrkWJVz5fQasQir4zgILXhIjKr1lhwnrL1TPWrqg66rRGTbDDNJYgdGA0-4mjH-A).

## Citation
If this code is useful for your research, please cite: 
Kaoutar Radi, Fabian Allamand, Dennis M. Kochmann,
Deformation tracking of truss lattices under dynamic loading based on Digital Image Correlation,
Mechanics of Materials,
Volume 183,
2023,
104658,
ISSN 0167-6636,
https://doi.org/10.1016/j.mechmat.2023.104658.

## Inquiries and Assistance

Should you have general questions or need guidance on using the code, please reach out to either the first author or the corresponding author.



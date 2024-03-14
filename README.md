Code for implementing quasi-experiment matched pairs design within fires that have areas that were affected and not affected by insect disturbance.

Steps:

- Fork this repository [Github docs](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo)

- run `renv::restore()` to reproduce `r` environment

- update the _targets.R file to include paths to files under the directories subheader 
  - fire_path <- "<path/to/my/fire/shpfile>"
  - defol_path <- "<path/to/my/insect/shpfile>"
  - RES_DIR <- "<path/to/my/results/folder>"

- update the _targets.R file to input the max, min and gap year for intersection function.

- **make sure to save _targets.R file after every change**

- Run the pipeline, using `tar_make()` from the targets package


**NOTES:**

- Fire polygon shapefile must have column `Fire_ID`, `Fire_Year` (both case sensitive) and a geometry column. It is recommended that you remove all other columns. 
- Insect disturbance shapefile must have a `Year` column with **one** row per year, and a geometry column. It is recommended that you remove all other columns.



















 [![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg

### March 11th 2024 ###

# DR
# R 4.2.3

#############
# load data #
#############

setwd("C:/Users/doria/Documents")

#############
# libraries #
#############

library(dplyr)
library(ggplot2)
library(sf)
library(writexl)
library(devtools)

######################
### Importing Data ### 
######################

# Using sf package

# Unionized MPB .shp file
mpb_union_shp <- read_sf("C:/Users/doria/Documents/RBR_bias_project/Data/mpb_single_row_per_year.shp") 
insect <- mpb_union_shp
names(insect) <- tolower(names(insect))
colnames(insect)
# List of mpb years
unique(mpb$YEAR)

# Fires .shp file
fire <- read_sf("~/RBR_bias_project/Data/Albers_bc_nfdb/NFDB_poly_20210707_BC_albers2.shp")
# colnames(fire)[colnames(fire) == 'year'] <- 'fire_year'
# names(fire) <- tolower(names(fire))
colnames(fire)
# List of fire years
unique(fire$YEAR)

# Intersect .shp file
intersect <- read_sf("C:/Users/doria/Documents//RBR_bias_project/Data/fire_mpb_intersect.shp")
colnames(intersect)

# Insect stats .shp file
insect_stats <- read_sf("C:/Users/doria/Documents//RBR_bias_project/Data/mpb_insect_stats.shp") 
colnames(insect_stats)

# Fire_area .shp file
fire2_2d <- read_sf("C:/Users/doria/Documents/RBR_bias_project/Data/fire_mpb_fire2_area.shp") 
colnames(fire2_2d)

############################################################################################################################################################

# Code for implementing quasi-experiment matched pairs design within fires that have areas that were affected and not affected by insect disturbance.

#Steps:
  
# - Fork this repository (Github docs)

# - run `renv::restore()` to reproduce `r` environment

# - update the _targets.R file to include paths to files under the directories subheader 

# - fire_path <- "<path/to/my/fire/shpfile>"

fire <- read_sf("C:/Users/doria/Documents/RBR_bias_project/Data/Albers_bc_nfdb/NFDB_poly_20210707_BC_albers.shp")
#names(fire) <- tolower(names(fire))
colnames(fire)[colnames(fire) == 'YEAR'] <- 'Fire_Year'
colnames(fire)[colnames(fire) == 'FIRE_ID'] <- 'Fire_ID'
colnames(fire)
fire2 <- fire[,c(2, 4, 29)]
colnames(fire2)

# Converting fire to 2D in order to write to .shp file
# fire is the multipolygon (3D)
fire_2D <- sf::st_zm(fire2) # dropping Z dimension

# write fire with fire_year column
st_write(fire_2D, "C:/Users/doria/Documents/RBR_bias_project/Data/Albers_bc_nfdb/NFDB_poly_20210707_BC_albers2.shp")
fire2 <- read_sf("C:/Users/doria/Documents/RBR_bias_project/Data/Albers_bc_nfdb/NFDB_poly_20210707_BC_albers2.shp")
colnames(fire2)
# [1] "Fire_ID"   "Fire_Year" "geometry" 

# Checking if warning changed shape_area after removing Z value in fire sf object
identical(fire$Shape_Area, fire2$Shape_Area)

# - defol_path <- "<path/to/my/insect/shpfile>"

mpb_union_shp <- read_sf("C:/Users/doria/Documents/RBR_bias_project/Data/mpb_single_row_per_year.shp")
insect <- mpb_union_shp
names(mpb_union_shp) <- tolower(names(mpb_union_shp))
colnames(mpb_union_shp2)
st_write(mpb_union_shp, "C:/Users/doria/Documents/RBR_bias_project/Data/mpb_single_row_per_year2.shp")
mpb_union_shp2 <- read_sf("C:/Users/doria/Documents/RBR_bias_project/Data/mpb_single_row_per_year2.shp")

colnames(mpb_union_shp2)

colnames(fire)[colnames(fire) == 'FIRE_YEAR'] <- 'Fire_Year'
colnames(fire2)[colnames(fire2) == 'Fire_Id'] <- 'Fire_ID'

# - RES_DIR <- "<path/to/my/results/folder>"

RES_DIR <- "C:/Users/doria/Documents/RBR_bias_project/insect_fire_overlap_results"

# - update the _targets.R file to input the max, min and gap year for intersection function.

# - **make sure to save targets file**
  
#  - Run the pipeline, using tar_make() from the targets package

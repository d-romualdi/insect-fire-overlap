### March 12th 2024 ###

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

### OG fire df ###
fire <- read_sf("~/RBR_bias_project/Data/Albers_bc_nfdb/NFDB_poly_20210707_BC_albers.shp")
colnames(fire)

# Need Fire_ID, Fire_Year, and geometry columns only
# Rename columns using dplyr

# Assuming 'sf_object' is your sf object and 'old_column_name' and 'new_column_name' are the old and new column names respectively
fire_new <- fire %>%
  rename(Fire_Year = YEAR)

fire_new <- fire %>%
  rename(Fire_Year = YEAR,
         Fire_ID = FIRE_ID)

colnames(fire_new)

# colnames(fire)[colnames(fire) == 'YEAR'] <- 'Fire_Year'
# colnames(fire)[colnames(fire) == 'FIRE_ID'] <- 'Fire_ID'

fire2 <- fire_new[, c(2, 4, 29)]
colnames(fire2)

# Write new fire df with select columns only

# Converting fire to 2D in order to write to .shp file
# fire is the multipolygon (3D)
fire_2D <- sf::st_zm(fire2) # dropping Z dimension
colnames(fire_2D)

st_write(fire_2D, "C:/Users/doria/Documents/RBR_bias_project/Data/Albers_bc_nfdb/NFDB_poly_20210707_BC_albers2.shp")

# Reading new fire polygon df
fire_polys <- read_sf("C:/Users/doria/Documents/RBR_bias_project/Data/Albers_bc_nfdb/NFDB_poly_20210707_BC_albers2.shp")
head(fire_polys)

# Checking 
identical(fire2$Fire_ID, fire_2D$Fire_ID)

# str
str(fire_polys)


### Unionized MPB df ###
mpb_union_shp <- read_sf("C:/Users/doria/Documents/RBR_bias_project/Data/mpb_single_row_per_year.shp")
colnames(mpb_union_shp)

# str
str(mpb_union_shp)


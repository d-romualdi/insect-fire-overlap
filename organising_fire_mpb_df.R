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
st_write(fire_2D, "C:/Users/doria/Documents/RBR_bias_project/Data/Albers_bc_nfdb/fire_polys/NFDB_poly_20210707_BC_albers_new.shp")


# Reading new fire polygon df
fire_polys <- read_sf("C:/Users/doria/Documents/RBR_bias_project/Data/Albers_bc_nfdb/NFDB_poly_20210707_BC_albers2.shp")
fire_polys_new <- read_sf("C:/Users/doria/Documents/RBR_bias_project/Data/Albers_bc_nfdb/fire_polys/NFDB_poly_20210707_BC_albers_new.shp")
head(fire_polys_new)

# Checking 
identical(fire2$Fire_ID, fire_2D$Fire_ID)

# str
str(fire_polys)

# Identify invalid geometries
fire_polys_invalid_geoms <- fire_polys_new[!st_is_valid(fire_polys_new), ]
fire_polys_invalid_geoms2 <- fire_polys_new[!st_is_valid(fire_polys_new), ]

# Fix invalid geometries
fire_polys_fixed_geoms <- st_make_valid(fire_polys_invalid_geoms)

# Replace fixed geometries in the original object
fire_polys_new[!st_is_valid(fire_polys_new), ] <- fire_polys_fixed_geoms

# Write new fire polygon .shp
st_write(fire_polys_new, "C:/Users/doria/Documents/RBR_bias_project/Data/Albers_bc_nfdb/fire_polys/NFDB_poly_20210707_BC_albers_new_valid_polys.shp")

# Read in new fire polygons with valid geometries
fire_polygons_valid_geoms <- read_sf("C:/Users/doria/Documents/RBR_bias_project/Data/Albers_bc_nfdb/fire_polys/NFDB_poly_20210707_BC_albers_new_valid_polys.shp")

### Unionized MPB df ###
mpb_union_shp <- read_sf("C:/Users/doria/Documents/RBR_bias_project/Data/mpb_single_row_per_year.shp")
colnames(mpb_union_shp)

mpb_invalid_geoms <- mpb_union_shp[!st_is_valid(mpb_union_shp), ]

# str
str(mpb_union_shp)


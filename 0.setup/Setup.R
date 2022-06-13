# You need to download R (suggested version 4.0.2, follow the links to get the
# right version for your Operating System) from here: https://www.r-project.org/
#
# We suggest also to download RStudio Free, which is an editor to write R code.
# RStudio can be downloaded from here: https://rstudio.com/
#
# Then you should run the commands available in this script, which install some
# packages required to perform these analyses.
#
# These commands have been successfully tested on this system
#
# >  sessionInfo()
# R version 4.0.2 (2020-06-22)
# Platform: x86_64-apple-darwin17.0 (64-bit)
# Running under: macOS Catalina 10.15.6

#####################################
# Installation of required packages #
#####################################

# Devtools is required to install packages from Github directly, you should
# already have it (unless you've downloaded a brand new R version)
install.packages('devtools')

# We use these two packages in this tutorial. They will download automatically
# all the required dependencies, some of them are also my packages, but many
# of them are pretty standard CRAN packages. Reply Yes to any question regarding
# the installation of extra packages, and installation by binary (rather than
# sources) works as well.

# Get the MOBSTER tool for subclonal deconvolution, and CNAqc for data QC
devtools::install_github("caravagn/mobster")
devtools::install_github("caravagn/CNAqc")
devtools::install_github("caravagn/ctree")

# Extra package(s)
install.packages('tidyverse')
install.packages('wesanderson')
install.packages('reshape2')
install.packages('ggpubr')
install.packages('cowplot')


# This should now work
library(mobster)
library(CNAqc)
library(ctree)
library(tidyverse)

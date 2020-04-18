
# load packages
library(tidyverse)
library(here)

# source scripts
source(here("helpers.R"))
source(here("workers.R"))

# parameters that define the art
param <- list(
  seed = 3,
  cycles = 13,
  splits = 2,
  scales = c(.5, .8, .9, .95),
  angles = c(-10, -5, 0, 5, 15, 20, 25)
)

# make art!
set.seed(param$seed)
dat <- grow_tree(param)
pic <- draw_tree(dat)
plot(pic)


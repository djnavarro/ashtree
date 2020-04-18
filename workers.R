# contains all the "work horse" functions for ashtree

# grow sapling to initiate tree growth ------------------------------------

grow_sapling <- function() {
  
  sapling <- tibble(
    old_x = 0,  # sapling grows from the origin
    old_y = 0,  # sapling grows from the origin
    new_x = 0,  # sapling doesn't grow horizontally
    new_y = 1,  # sapling does grow vertically
    angle = 90, # angle from horizontal is 90 degrees
    scale = 1,  # length of the sapling is 1
  )
  return(sapling)
}



# grow a single tip -------------------------------------------------------

grow_from <- function(tips, param) {
  
  # read off the relevant settings
  all_scales <- param$scales
  all_angles <- param$angles
  
  # mutate the tips tibble
  new_growth <- tips %>%
    mutate(
      old_x = new_x,                                # begin where last seg ended
      old_y = new_y,                                # begin where last seg ended
      scale = adjust_scale(scale, all_scales),      # change segment length
      angle = adjust_angle(angle, all_angles),      # change segment angle
      new_x = adjust_x(old_x, scale, angle),        # end where this seg ends!
      new_y = adjust_y(old_y, scale, angle)         # end where this seg ends!
    )
  return(new_growth)
}


# grow one tip into multiple new tips (or branches) -----------------------

grow_multi <- function(tips, param) {
  
  branches <- map_dfr(
    .x = 1:param$splits,
    .f = ~ grow_from(tips, param)
  )
  return(branches)
}



# accumulate (multi-tip) growth over several cycles -----------------------

grow_tree <- function(param) {

  tree <- accumulate(
    .x = 1:param$cycles, 
    .f = ~ grow_multi(., param), 
    .init = grow_sapling()
  )
  tree <- bind_rows(tree)
  return(tree)
}



# draw a picture of a tree ------------------------------------------------

draw_tree <- function(tree) {
  
  pic <- ggplot(
    data = tree, 
    mapping = aes(
      x = old_x,
      y = old_y,
      xend = new_x,
      yend = new_y
    )
  ) + 
    geom_segment() + 
    theme_void() + 
    coord_equal()
  
  return(pic)
}
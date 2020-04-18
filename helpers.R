# contains all the low level "helper" functions for ashtree,
# written in somewhat more succinct form than in the videos!

# converts degrees to radians
radians <- function(degree) {
  2 * pi * degree / 360
}

# adjusts the length of a segment
adjust_scale <- function(s, scales) {
  s * sample(x = scales, size = length(s), replace = TRUE)
}

# adjusts the orientation of a segment
adjust_angle <- function(a, angles) {
  a + sample(x = angles, size = length(a), replace = TRUE)
}

# adjusts the x co-ordinate
adjust_x <- function(x, scale, angle) {
  x + scale * cos(radians(angle))
}

# adjusts the t co-ordinate
adjust_y <- function(y, scale, angle) {
  y + scale * sin(radians(angle))
}


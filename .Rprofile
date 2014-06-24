.Library <-paste0(Sys.getenv("HOME"),"/x86_64-pc-linux-gnu-library/2.12")

Sys.setenv(R_HISTSIZE='100000')
Sys.setenv(R_HISTFILE="/usr/local/google/home/caneff/.Rhistory")


# auto width adjustment
.adjustWidth <- function(...){
  try(options(width=Sys.getenv("COLUMNS")),silent=TRUE)
  TRUE
}
.adjustWidthCallBack <- addTaskCallback(.adjustWidth)

try(library(ggplot2,quietly=TRUE),silent=TRUE)
try(library(scales,quietly=TRUE),silent=TRUE)
try(library(data.table),silent=TRUE)
try(library(RColorBrewer,quietly=TRUE),silent=TRUE)
try(library(dichromat,quietly=TRUE),silent=TRUE)

options(datatable.alloccol=1000)
options(datatable.allocwarn=FALSE)

#gcinfo(TRUE)
options(datatable.verbose=FALSE)
options(stringsAsFactors=FALSE)

MakePlot <- function(g, filename, height=6, width=7) {
  plot.dir <- sprintf("%s/plots/%s",
    Sys.getenv("HOME"),
    strftime(Sys.time(),"%Y%m%d"))

  if(!file.exists(plot.dir)){
    dir.create(plot.dir, showWarnings=FALSE)
  }

  ggsave(
      plot=g,
      filename=sprintf("%s/%s", plot.dir, filename),
      width=width,
      height=height,
      type="cairo-png")
}

.undistract <- function(min.seconds=30) {
  # This function enables a system alert to trigger after an R command running
  # for more than min.seconds seconds finishes running.  This is useful in an
  # interactive session for something like a Dremel query that takes 2 minutes
  # to run, so that you can do something else and get alerted when the command
  # finishes to continue your analysis.
  #
  # This is based off the undistract-me package for Linux:
  # https://github.com/jml/undistract-me. The major difference is that a trigger
  # can't be made for the beginning of a command in R, only at the end of the
  # command, so the current time is only updated at the end of a command. This
  # means that if you go more than min.seconds seconds between the end of your
  # last command and the beginning of a new one, you will trigger an alert even
  # if the new command is less than min.seconds seconds long.
  #
  # Args: min.seconds: Minimum seconds between commands needed to trigger an
  # alert.
  #

  last.command.time <- Sys.time()

  function(expr, value, ok, visible) {
    new.command.time <- Sys.time()

    time.diff <- as.numeric(new.command.time - last.command.time, "secs")

    if (time.diff > min.seconds) {
      if (ok) {
        system(
          sprintf('notify-send -i system "R command completed in %s seconds."',
            round(time.diff, 2)
          )
        )
      } else {
        system(
          sprintf('notify-send -i error "R command failed in %s seconds."',
            round(time.diff, 2)
          )
        )
      }
    }

    # Update the last command time to reset the counter.
    last.command.time <<- new.command.time
    return(TRUE)
  }
}

invisible(addTaskCallback(.undistract(60)))

.Last <- function() {
  if (!any(commandArgs()=='--no-readline') && interactive()){
    require(utils)
    try(savehistory(Sys.getenv("R_HISTFILE")))
  }
}
.savehist <- function(expr,
                      value, ok, visible) {
  if (!any(commandArgs()=='--no-readline') && interactive()){
    require(utils)
    try(savehistory(Sys.getenv("R_HISTFILE")))
  }
  return(TRUE)
}
invisible(addTaskCallback(.savehist))


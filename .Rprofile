Sys.setenv(R_HISTSIZE='100000')
Sys.setenv(R_HISTFILE="~/.Rhistory")
.Library <-paste0(Sys.getenv("HOME"),"/x86_64-pc-linux-gnu-library/2.12"

.Last <- function() {
  if (!any(commandArgs()=='--no-readline') && interactive()){
    require(utils)
    try(savehistory(Sys.getenv("R_HISTFILE")))
  }
}

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

MakePlot <- function(g, filename,height=6,width=7) {
  plot.dir <- sprintf("%s/plots/%s",
    Sys.getenv("HOME"),
    strftime(Sys.time(),"%Y%m%d"))

  if(!file.exists(plot.dir)){
    dir.create(plot.dir, showWarnings=FALSE)
  }

  ggsave(plot=g,
    filename=sprintf("%s/%s", plot.dir, filename),
    width=width,
    height=height,
    type="cairo-png")
}

undistract <- function(numSeconds=30) {
  time <- Sys.time()
  function(expr,value,ok,visible) {
    new.time <- Sys.time();
    if(ok && as.numeric(new.time-time,"secs")>numSeconds){
      system(sprintf('notify-send  -i system "R Program Complete" "%s"', new.time-time))
    }
    time<<-new.time
    return(TRUE)
  }
}

invisible(addTaskCallback(undistract(60)))


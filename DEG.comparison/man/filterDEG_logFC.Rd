\name{filterDEG_logFC}
\alias{filterDEG_logFC}
\title{
Filter logFC and plot DEG results
}
\description{
Function adapted from systemPipeR.
Filters and plots DEG results for a given set of sample comparisons. The gene idenifiers of all (i) Up_or_Down, (ii) Up and (iii) Down regulated genes are stored as separate list components and the corresponding summary statistics, stored in a fourth list component, is plotted in form of a stacked bar plot.
}
\usage{
filterDEG_logFC(degDF, filter, plot = TRUE, method)
}
\arguments{
  \item{degDF}{
  \code{data.frame} generated by \code{run_RPKM}
}
  \item{filter}{
  Named vector with filter cutoffs of format \code{c(Fold=2)} where \code{Fold} refers to the fold change cutoff (unlogged).
}
  \item{plot}{
  Allows to turn plotting behavior on and off with default set to \code{TRUE}. 
}
 \item{method}{
  Defines the method name in the plot.
}
}
\value{
Returns \code{list} with four components
  \item{UporDown}{List of up or down regulated gene/transcript indentifiers meeting the chosen filter settings for all comparisons defined in data frames \code{log2FC}.}
  \item{Up}{Same as above but only for up regulated genes/transcript.}
  \item{Down}{Same as above but only for down regulated genes/transcript.}
}
\references{
Thomas Girke (2015). systemPipeR: systemPipeR: NGS workflow and report generation environment. R package version 1.0.12.
https://github.com/tgirke/systemPipeR
}
\author{
Daniela Cassol
}
\seealso{
\code{run_RPKM}
}
\examples{
targetspath <- system.file("extdata", "targets.txt", package="DEG.comparison")
targets <- read.delim(targetspath, comment="#")
cmp <- readComp(file=targetspath, format="matrix", delim="-")
rpkmDFeByg <- system.file("extdata", "rpkmDFeByg.xls", package="DEG.comparison")
rpkmDFeByg <- read.delim(rpkmDFeByg, row.names=1)
#Settings
Comp1 <- list(Factor=(Reduce(union, targets$Factor)), Sample=c(colnames(rpkmDFeByg)), 
              group=c(1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8))

Comp2 <- list(AP1.4_AP1.67=c("AP1.4", "AP1.67"), AP3.4_AP3.67=c("AP3.4", "AP3.67"), 
              AG.4_AG.67=c("AG.4", "AG.67"), AP1.4_AP3.4=c("AP1.4", "AP3.4"), 
              AP1.4_AG.4=c("AP1.4", "AG.4"), AP3.4_AG.4=c("AP3.4", "AG.4"), 
              AP1.67_AP3.67=c("AP1.67", "AP3.67"), AP1.67_AG.67=c("AP1.67", "AG.67"), 
              AP3.67_AG.67=c("AP3.67", "AG.67"))

##Compute mean values for replicates and logFC for comparisons
RPKM_FC <- run_RPKM (rpkmDFeByg, Comp1, Comp2) 
DEG_list_RPKM <- filterDEG_logFC(degDF=RPKM_FC, filter=c(Fold=2), method="RPKM")
DEG_list_RPKM$Summary[1:4,]
}
\keyword{run_DEGs}
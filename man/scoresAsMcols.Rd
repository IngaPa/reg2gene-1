% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DataIntegRFunctions.R
\name{scoresAsMcols}
\alias{scoresAsMcols}
\title{Function that rearranges list of scores calculated per cell type}
\usage{
scoresAsMcols(scores.per.cell.type, sampleIDs)
}
\arguments{
\item{scores.per.cell.type}{list of result score matrices for each biwgig
file}

\item{sampleIDs}{A vector of unique sample ids/names of bigwig files}
}
\value{
a dataframe of quatified scores per genome window and bigwig files.
Each row corresponds to ranges in the genome, and columns correspond to the 
bigwig files.
}
\description{
Function that rearranges list of scores calculated per cell type
}
\author{
Inga Patarcic
}
\keyword{internal}

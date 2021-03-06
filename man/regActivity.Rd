% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DataIntegRFunctions.R
\name{regActivity}
\alias{regActivity}
\title{Calculates regulatory activity over pre-defined regions}
\usage{
regActivity(regRegions, activitySignals, sampleIDs = NULL, isCovNA = FALSE,
  weightCol = NULL, summaryOperation = "mean", normalize = NULL,
  mc.cores = 1)
}
\arguments{
\item{regRegions}{a GRanges object that contains regulatory regions
over which the regulatory activity will be calculated. 
It is strongly suggested to adjust 
seqlengths of this object to be equal to the seqlenghts Hsapiens from the 
appropriate package (BSgenome.Hsapiens.UCSC.hg19 or whatever needed version).}

\item{activitySignals}{a named list of BigWig files. Names correspond to 
unique sample ids/names.}

\item{sampleIDs}{NULL (default). A vector of unique sample
ids/names(.bw files), ordered as the bigwig files are ordered. When NULL
basenames of .bw files is used as a unique sample ids/names.}

\item{isCovNA}{(def:FALSE), if this is set to TRUE, uncovered
bases are set to NA, this is important when dealing with methylation
data, where uncovered bases on a bigWig file do not mean zero methylation.}

\item{weightCol}{a numeric column in meta data part used as weights. Useful
when genomic regions have scores other than their coverage values, 
such as percent methylation, conservation scores, GC content, etc.}

\item{summaryOperation}{"mean"(default).  An argument for 
\code{\link[genomation]{ScoreMatrixBin}} that is in the nutshell of 
quantifying enhancer activity across pre-defined enhancer regions.
This designates which summary operation should be used over the regions.
Currently, only mean is available, but "median" or "sum" will be implemented
in the future.}

\item{normalize}{NULL(default). Optional "quantile" and "ratio"
If set to "quantile" activity measures are quantile normalized as 
implemented in \code{\link[preprocessCore]{normalize.quantiles}} and
returned ; if set to "ratio" then "median ratio method" implemented
as \code{\link[DESeq2]{estimateSizeFactorsForMatrix}} is used to normalize 
activity measures.}

\item{mc.cores}{(def:1) Define the number of cores to use;
at most how many child processes will be run simultaneously 
using mclapply from parallel package. Parallelization requires at 
least two cores.}
}
\value{
a GRanges object where its meta-columns correspond
        to calculated acvitity measures and column names 
        correspond to provided sample ids or names.
}
\description{
The function calculates regulatory activity from histone
modification, DNAse or methylation signals for pre-defined regulatory
regions and returns a GRanges object with regulatory region locations
and their activity over a set of samples.
}
\details{
regulatory activity is measured by averaging logFC for
histone modification ChIP-seq profiles, or DNAse signal, or methylation
per base.Currently, relevant bigWig files are required to calculate activity       
activity. This function might be extended to work with BAM files
in the future.
}
\examples{
# INPUT1: defining .bw files:

test.bw <- system.file("extdata", "test.bw",package = "reg2gene")
test2.bw <- system.file("extdata", "test2.bw",package = "reg2gene")

# INPUT2: defining regulatory regions:regRegions

regRegions <- GRanges(c(rep("chr1",4),rep("chr2",2)),
                      IRanges(c(1,7,9,15,1,15),c(4,8,14,20,4,20)),
                                            c(rep("+",3),rep("-",3)))
regRegions$reg <-  regRegions[c(1,1,3:6)]
regRegions$name2 <- regRegions$name <- paste0("TEST_Reg",
                                        c(1,1,3:length(regRegions)))
                        
 # OUTPUT  regActivity():                                                      
regActivity(regRegions,c(test.bw,test2.bw))   

# Additionaly, sample names can changed with sampleIDs argument

regActivity(regRegions,c(test.bw,test2.bw),sampleIDs=c("Cell1","Cell2"))

# Additionaly, it supports different normalization procedures:

regActivity(regRegions,c(test.bw,test2.bw),normalize ="ratio")
regActivity(regRegions,c(test.bw,test2.bw),normalize ="quantile")

}

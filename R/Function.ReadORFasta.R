#' Function.ReadORFasta: function to read and format a fasta file containing multiple OR amino acid sequences
#'
#' This function returns a data frame with the first column representing the OR sequence names, and the second column containing a string for each OR amino acid sequence
#' @param string.PathFastaFile String containing system path to fasta file. Make sure: no slash characters in the sequence names
#' @keywords olfactory receptors, chemosensation, coleoptera, beetle genomes, 
#' @return dataframe.ORSequences Returns a data.frame with four columns: Species (genome), Sequence names (fasta names), sequence scaffolds (taken from fasta file), and sequence strings (amino acid strings for each OR gene)
#' @export
#' @examples
#' 
#' ################
#' # load depends #
#' ################
#' library(seqinr)
#' 
#' #########################
#' # read input fasta file #
#' #########################
#' handle.InputFastaFile <- Function.ReadORFasta(string.PathFastaFile = '~/Desktop/Beetle ORs Protein Translations.fasta')


#################################
# Simulate.ModelSelection_5Models #
#################################
Function.ReadORFasta <- function(string.PathFastaFile){
  
  #########################
  # read input fasta file #
  #########################
  handle.OR_GeneFasta <- read.fasta(file = string.PathFastaFile, seqtype = "AA", as.string = T, set.attributes = F, whole.header = T)
  numeric.NumberOfSequences <- length(handle.OR_GeneFasta)
  vector.SequenceData <- rep(NA, numeric.NumberOfSequences)
  vector.SequenceSpecies <- rep(NA, numeric.NumberOfSequences)
  vector.SequenceNames <- rep(NA, numeric.NumberOfSequences)
  vector.SequenceScaffolds <- rep(NA, numeric.NumberOfSequences)
  
  ##########################
  # loop through sequences #
  ##########################
  for (i in 1:numeric.NumberOfSequences){
    vector.SequenceData_i <- handle.OR_GeneFasta[[i]][1:length(handle.OR_GeneFasta[[i]])]
    string.SequenceData_i <- toString(paste0(vector.SequenceData_i, collapse = ""))
    vector.SequenceData[i] <- toupper(toString(string.SequenceData_i))
    
    #############################
    # parse names and scaffolds #
    #############################
    string.SequenceName_Data <- names(handle.OR_GeneFasta)[i]
    vector.SequenceName_Data <- strsplit(x = string.SequenceName_Data, split = '\\s+')[[1]]
    string.SequenceSpeciesNames <- substr(x = vector.SequenceName_Data[1], start = 1, stop = 4)
    vector.SequenceSpecies[i] <- string.SequenceSpeciesNames
    vector.SequenceNames[i] <- vector.SequenceName_Data[1]
    vector.SequenceScaffolds[i] <- toString(vector.SequenceName_Data[2:length(vector.SequenceName_Data)])

  }
  
  #########################
  # compile to data frame #
  #########################
  dataframe.ORSequences <- data.frame(SequenceSpecies = vector.SequenceSpecies,
                                      SequenceName = vector.SequenceNames, 
                                      SequenceScaffolds = vector.SequenceScaffolds,
                                      SequenceData = vector.SequenceData)
  
  
  return(dataframe.ORSequences)
  
}
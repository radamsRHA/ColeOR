#' Function.RunDeepTMHMM: function to run DeepTMHMM on a single amino acid sequence
#'
#' This function returns a subdirectory containing the results from DeepTMHMM
#' @param string.PathDir String containing the directory path to where the analyses will be conducted
#' @param string.SequenceName String containing the name of the sequence (used to name the directory as well)
#' @param string.SequenceData String containing the sequence data for a single sequence to run DeepTMHMM
#' @param string.SpeciesName String containing the name of species (genome) taken from the original fasta file
#' @param string.SequenceScaffold String containing the name of the scaffold with putative BLAST hits
#' @keywords olfactory receptors, chemosensation, coleoptera, beetle genomes, 
#' @return Directory External directory with results from DeepTMHMM
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
#' handle.InputFastaFile <- Function.ReadORFasta(string.PathFastaFile = '~/Desktop/ChemoGenes_ProteinSet1.fasta')
#' 
#' #################################
#' # run Deep TMHMM on single gene #
#' #################################
#' Function.RunDeepTMHMM(string.SequenceName = handle.InputFastaFile$SequenceName[1],
#'                       string.SequenceData = handle.InputFastaFile$SequenceData[2], 
#'                       string.PathDir = '~/Desktop/')

#################################
# Simulate.ModelSelection_5Models #
#################################
Function.RunDeepTMHMM <- function(string.SequenceName, string.SpeciesName, string.SequenceScaffold, string.SequenceData, string.PathDir){
  
  #####################################################
  # Define directory used for DeepTMHMM #
  #####################################################
  string.CurrentDir <- getwd()
  string.Path_Directory_DeepTMHMM = paste(string.PathDir, '/Conduct.DeepTMHMM_XXX_', Sys.Date(), '/', sep = "")
  string.Path_Directory_DeepTMHMM <- gsub(pattern = "XXX", replacement = string.SequenceName, x = string.Path_Directory_DeepTMHMM)
  unlink(string.Path_Directory_DeepTMHMM, recursive = T)
  dir.create(string.Path_Directory_DeepTMHMM, showWarnings = T, recursive = T)
  
  ####################
  # write fasta file #
  ####################
  string.PathFastFile <- paste0(string.Path_Directory_DeepTMHMM, '/FastaFile_', string.SpeciesName, '_', string.SequenceName, '_', paste0(string.SequenceScaffold, collapse = ""), '.fasta')
  string.FastaFile <- paste0('FastaFile_', string.SpeciesName, '_', string.SequenceName, '_', paste0(string.SequenceScaffold,collapse = ""), '.fasta')
  print(string.FastaFile)
  string.SequenceData <- toupper(string.SequenceData)
  write.fasta(sequences = string.SequenceData, names = string.SequenceName, file.out = string.PathFastFile)
  
  #######################
  # change to directory #
  #######################
  setwd(string.Path_Directory_DeepTMHMM)
  print(getwd())
  
  ##################
  # run Deep TMHMM #
  ##################
  string.RunDeepTMHMM <- "biolib run DTU/DeepTMHMM --fasta XXX"
  string.RunDeepTMHMM <- gsub(pattern = "XXX", replacement = string.FastaFile, x = string.RunDeepTMHMM)
  system(string.RunDeepTMHMM, timeout = 1440)
  
  
  setwd(string.CurrentDir)
  
  
}
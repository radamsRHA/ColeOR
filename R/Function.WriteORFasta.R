#' Function.WriteORFasta: function to create directory and write file for amino acid sequence for OR gene
#'
#' This function returns a directory with fasta file containing amino acid sequence
#' @param string.PathDir String containing the directory path to where the analyses will be conducted
#' @param string.SequenceName String containing the name of the OR sequence
#' @param string.SpeciesName String containing the name of species (genome) taken from the original fasta file
#' @param string.SequenceScaffold String containing the name of the scaffold with putative BLAST hits
#' @param string.SequenceData String containing the sequence data (amino acid sequence from Function.ReadORFasta)
#' @keywords olfactory receptors, chemosensation, coleoptera, beetle genomes, 
#' @return File Function creates a directory and writes OR amino acid sequence to file in directory
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
#' 
#' #################################
#' # run Deep TMHMM on single gene #
#' #################################
#' Function.WriteORFasta(string.SequenceName = handle.InputFastaFile$SequenceName[1],
#'                       string.SpeciesName = handle.InputFastaFile$SequenceSpecies[1],
#'                       string.SequenceScaffold = handle.InputFastaFile$SequenceScaffolds[1],
#'                       string.SequenceData = handle.InputFastaFile$SequenceData[1], 
#'                       string.PathDir = '~/Desktop/')

#########################
# Function.WriteORFasta #
#########################
Function.WriteORFasta <- function(string.SpeciesName, string.SequenceName, string.SequenceScaffold, string.SequenceData, string.PathDir){
  
  ####################
  # write fasta file #
  ####################
  string.PathFastFile <- paste0(string.PathDir, '/FastaFile_', string.SpeciesName, '_', string.SequenceName, '_', string.SequenceScaffold, '.fasta')
  string.SequenceData <- toupper(string.SequenceData)
  write.fasta(sequences = string.SequenceData, names = string.SequenceName, file.out = string.PathFastFile)
  
  
}
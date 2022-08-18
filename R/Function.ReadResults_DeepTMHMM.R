#' Function.ReadResults_DeepTMHMM: function to read the results from DeepTMTHMM
#'
#' This function returns a vector with results from DeepTMHMM
#' @param string.Path_RESULTS String containing path to DeepTMHMM results
#' @param string.SequenceName String containing the name of the sequence (used to name the directory as well)
#' @param string.SpeciesName String containing the name of species (genome) taken from the original fasta file
#' @param string.SequenceScaffold String containing the name of the scaffold with putative BLAST hits
#' @keywords olfactory receptors, chemosensation, coleoptera, beetle genomes, 
#' @return vector.RESULTS Vector containing results that summerize the TMD inferences
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
#' ##################################
#' ## run Deep TMHMM on single gene #
#' ##################################
#' #Function.RunDeepTMHMM(string.SequenceName = handle.InputFastaFile$SequenceName[1],
#' #                      string.SequenceData = handle.InputFastaFile$SequenceData[1], 
#' #                      string.SpeciesName = handle.InputFastaFile$SequenceSpecies[1], 
#' #                      string.SequenceScaffold = handle.InputFastaFile$SequenceScaffolds[1],
#' #                      string.PathDir = '~/Desktop/')
#' 
#' ################
#' # read results #
#' ################
#' Function.ReadResults_DeepTMHMM(string.SequenceName = handle.InputFastaFile$SequenceName[1],
#'                                string.SpeciesName = handle.InputFastaFile$SequenceSpecies[1], 
#'                                string.SequenceScaffold = handle.InputFastaFile$SequenceScaffolds[1],
#'                                string.Path_RESULTS = '~/Desktop/Conduct.DeepTMHMM_AglaOr1_Orco_2022-08-02/biolib_results/')


#################################
# Function.ReadResults_DeepTMHMM #
#################################
Function.ReadResults_DeepTMHMM <- function(string.Path_RESULTS, string.SequenceName, string.SpeciesName, string.SequenceScaffold){
  
  ###################
  # read input path #
  ###################
  vector.ListOutputFiles <- list.files(string.Path_RESULTS, full.names = T)
  string.Path_GFF <- paste0(string.Path_RESULTS, "/TMRs.gff3")
  handle.PredictionsFile <- readLines(string.Path_GFF)
  vector.RESULTS <- rep(NA, 21)
  names(vector.RESULTS) <- c("Species", "OR_ID", "Scaffold", "NumberPredicted", "Suffix", 
                             "TMD_01_Start", "TMD_01_End",
                             "TMD_02_Start", "TMD_02_End",
                             "TMD_03_Start", "TMD_03_End", 
                             "TMD_04_Start", "TMD_04_End", 
                             "TMD_05_Start", "TMD_05_End", 
                             "TMD_06_Start", "TMD_06_End", 
                             "TMD_07_Start", "TMD_07_End", 
                             "TMD_08_Start", "Length")
  vector.RESULTS["Species"] <- string.SpeciesName
  vector.RESULTS["OR_ID"] <- string.SequenceName
  vector.RESULTS["Scaffold"] <- string.SequenceScaffold
  
  ####################
  # read input lines #
  ####################
  handle.Length <- handle.PredictionsFile[2]
  handle.Length <- as.numeric(strsplit(x = handle.Length, split = "Length: ")[[1]][2])
  handle.PredictedTMRS <- handle.PredictionsFile[3]
  handle.PredictedTMRS <- as.numeric(strsplit(x = handle.PredictedTMRS, split = "TMRs: ")[[1]][2])
  vector.RESULTS["Length"] <- handle.Length
  vector.RESULTS["NumberPredicted"] <- handle.PredictedTMRS
  
  ########################
  # search for TMhelices #
  ########################
  vector.Lines_TMhelix <- grep(pattern = "TMhelix", x = handle.PredictionsFile,ignore.case = T)
  numeric.CountTMD <- 0
  for (i in vector.Lines_TMhelix){
    numeric.CountTMD <- numeric.CountTMD + 1
    string.HelixData <-  handle.PredictionsFile[i]
    string.Match_Start <- "TMD_0X_Start"
    string.Match_Start <- gsub(pattern = "X", replacement = numeric.CountTMD, x = string.Match_Start)
    string.Match_End <- "TMD_0X_End"
    string.Match_End <- gsub(pattern = "X", replacement = numeric.CountTMD, x = string.Match_End)
    
    string.Start <- as.numeric(strsplit(x = string.HelixData, split = '\\s+')[[1]][3])
    string.End <- as.numeric(strsplit(x = string.HelixData, split = '\\s+')[[1]][4])
    vector.RESULTS[string.Match_Start] <- string.Start
    vector.RESULTS[string.Match_End] <- string.End
    
  }
  
  return(vector.RESULTS)
}
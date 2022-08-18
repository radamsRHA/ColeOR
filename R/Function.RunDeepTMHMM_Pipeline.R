#' Function.RunDeepTMHMM_Pipeline: function to run DeepTMHMM on each sequence of a AA fast file
#'
#' This function returns a data.frame containing results of DeepTMHMM running on each sequence in fasta file
#' @param string.PathDir String containing the directory path to where the analyses will be conducted
#' @param string.FastaFile String containing the path to the input AA fasta file
#' @keywords olfactory receptors, chemosensation, coleoptera, beetle genomes, 
#' @return handle.DF_Results Data.frame containing results from fasta file
#' @export
#' @examples
#' 
#' ################
#' # load depends #
#' ################
#' library(seqinr)
#' 
#' ##############################
#' # run on complete fasta file #
#' ##############################
#' handle.RESULTS <- Function.RunDeepTMHMM_Pipeline(string.PathDir = '~/Desktop/', string.FastaFile = '~/Desktop/Test.fasta')
#' 
#' ANOTHER EXAMPLE:
#' ################
#' # Load depends #
#' ################
#' library(ColeOR)
#' library(seqinr)
#' 
#' #####################################
#' # Read example chromosome alignment #
#' #####################################
#' String.Path_ExampleModels <-  system.file("extdata", "ExampleModelsORs.fasta", package="ColeOR")
#' 
#' #######################
#' # run TMD predictions #
#' #######################
#' handle.RESULTS <- Function.RunDeepTMHMM_Pipeline(string.PathDir = '~/Desktop/', 
#'                                                 string.FastaFile = String.Path_ExampleModels)

#################################
# Function.RunDeepTMHMM_Pipeline #
#################################
Function.RunDeepTMHMM_Pipeline <- function(string.PathDir, string.FastaFile){
  
  #####################################################
  # Define directory used for DeepTMHMM #
  #####################################################
  string.CurrentDir <- getwd()
  string.Path_Directory_DeepTMHMM = paste(string.PathDir, '/Conduct.DeepTMHMM_Pipeline', sep = "")
  unlink(string.Path_Directory_DeepTMHMM, recursive = T)
  dir.create(string.Path_Directory_DeepTMHMM, showWarnings = T, recursive = T)
  
  #########################
  # read input fasta file #
  #########################
  handle.InputFastaFile <- Function.ReadORFasta(string.PathFastaFile = string.FastaFile)
  numeric.NumberSequences <- length(handle.InputFastaFile[,1])
  
  ###################
  # collect results #
  ###################
  handle.MatrixRESULTS <- matrix(nrow = numeric.NumberSequences, ncol = 21)
  colnames(handle.MatrixRESULTS) <- c("Species", "OR_ID", "Scaffold", "NumberPredicted", "Suffix", 
                             "TMD_01_Start", "TMD_01_End",
                             "TMD_02_Start", "TMD_02_End",
                             "TMD_03_Start", "TMD_03_End", 
                             "TMD_04_Start", "TMD_04_End", 
                             "TMD_05_Start", "TMD_05_End", 
                             "TMD_06_Start", "TMD_06_End", 
                             "TMD_07_Start", "TMD_07_End", 
                             "TMD_08_Start", "Length")
  
  
  ##############################
  # loop through sequence data #
  ##############################
  for (i in 1:numeric.NumberSequences){
    
    ############################
    # get sequence information #
    ############################
    string.SequenceName_i <- handle.InputFastaFile$SequenceName[i]
    string.SequenceSpecies_i <- handle.InputFastaFile$SequenceSpecies[i]
    string.SequenceScaffold_i <- handle.InputFastaFile$SequenceScaffolds[i]
    string.SequenceData_i <- handle.InputFastaFile$SequenceData[i]
    
    ##################
    # run Deep TMHMM #
    ##################
    handle.DeepTMHM <- Function.RunDeepTMHMM(string.SequenceName = string.SequenceName_i, 
                                             string.SpeciesName = string.SequenceSpecies_i, 
                                             string.SequenceScaffold = string.SequenceScaffold_i, 
                                             string.SequenceData = string.SequenceData_i, 
                                             string.PathDir = string.Path_Directory_DeepTMHMM)
    ################
    # read results #
    ################
    string.Path2Results <- paste0(string.Path_Directory_DeepTMHMM, '/Conduct.DeepTMHMM_', string.SequenceName_i, '_', Sys.Date(), '/biolib_results/')
    vector.RESULTS <- Function.ReadResults_DeepTMHMM(string.Path_RESULTS = string.Path2Results, 
                                                     string.SequenceName = string.SequenceName_i, 
                                                     string.SpeciesName = string.SequenceSpecies_i, 
                                                     string.SequenceScaffold = string.SequenceScaffold_i)
    
    handle.MatrixRESULTS[i,] <- vector.RESULTS
    
    setwd(string.CurrentDir)
    
    ######################
    # write temp results #
    ######################
    string.Path_TempFile <- paste0(string.Path_Directory_DeepTMHMM, '/TempResults_TMHMM.txt')
    write.table(x = handle.MatrixRESULTS, file = string.Path_TempFile, append = F, quote = F, sep = '\t', row.names = F)
    
  }
  
  handle.DF_Results <- as.data.frame(handle.MatrixRESULTS)
  return(handle.DF_Results)
}
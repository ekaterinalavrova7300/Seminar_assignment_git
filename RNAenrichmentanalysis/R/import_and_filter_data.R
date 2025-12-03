#'import_and_filter_data
#'@description
#'Imports count_table using the file path
#'then filters the low expressed genes in the count_table
#'based on per sample CPM
#'
#'@param count_table computer path to the count_table
#'@param min_CPM Minimum threshold for filtering
#'@param min_sample Minimum samples that pass the cpm threshold for every gene
#'
#'@return
#'Filtered count table
#'
#'
#'@examples
#'count_table_path = system.file("extdata","E-MTAB-2523.counts.txt",package = "RNAenrichmentanalysis")
#'filtered_count_table = import_and_filter_data(
#' count_table = count_table_path,
#' min_CPM = 1,
#' min_sample = 2
#' )
#'
#'
#' @import edgeR
#' @export



#Create function
import_and_filter_data = function(count_table, min_CPM = 1, min_sample = 2){



  #Read in count table
  count_table = read.table(count_table, header = TRUE, row.names = 1, sep = "\t")
  #Calculates CPM for each sample
  cpm_results = cpm(count_table)

  #Creates a logical vector indicating if there are 2 or more samples per gene that have cpm greater than 1
  filtered_cpm = rowSums( cpm_results > min_CPM) >= min_sample

  #Keeps only the genes that are TRUE in the filtered_cpm
  filtered_count_table = count_table[filtered_cpm,]

  #Returns the filtered counts
  return (filtered_count_table)

}

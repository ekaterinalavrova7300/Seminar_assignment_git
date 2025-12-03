#'import_and_filter_data
#'@description
#'Imports count_table using the file path
#'then filters the low expressed genes in the count_table
#'based on CPM
#'
#'@param count_table computer path to the count_table
#'@param min_CPM Minimum threshold for filtering
#'
#'@return
#'Filtered count table
#'
#'
#'@examples
#'count_table_path = system.file("extdata","count_table.txt",package = "RNAenrichmentanalysis")
#'Filtered_count_table = import_and_filter_data(
#' count_table = count_table_path,
#' min_CPM = 1
#' )
#'
#' @export
#' @import edgeR



#Create function
import_and_filter_data = function(count_table, min_CPM = 1){



  #Read in count table
  count_table = read.table(count_table, header = TRUE, row.names = 1, sep = "\t")
  #Calculates CPM for each sample
  cpm_results = cpm(count_table)

  #Creates a logical vector indicating if average cpm for all samples of a gene is higher than min CPM or not
  filtered_cpm = rowMeans(cpm_results) > min_CPM

  #Keeps only the genes that are higher than mean CPM
  filtered_count_table = count_table[filtered_cpm,]

  #Returns the filtered counts
  return (filtered_count_table)

}

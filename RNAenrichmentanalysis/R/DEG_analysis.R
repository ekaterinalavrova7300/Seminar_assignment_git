#' DEG_analysis
#' @description Create a table containing differential expressed genes
#' (using the filtered count_table) that
#' are filtered according to Log2 fold change and FDR
#' optionally you can add excel_file to print an excel life with the data
#' @param filtered_count_table Count-table without low-counts filtered by CPM
#' @param sample_table computer path to the sample_table
#' @param fdr_threshold False discovery rate used for filtering DEGs
#' @param logFC_threshold Log2 fold change used for filtering DEGs
#' @param excel_file name of the excel life to be printed: NULL is default.
#' @examples
#' # example code
#' sample_table_path = system.file("extdata","E-MTAB-2523_sample_table.txt",package = "RNAenrichmentanalysis")
#'  filtered_DEG =
#'  DEG_analysis (filtered_count_table,
#'  sample_table = sample_table_path,
#'  fdr_threshold = 0.05,
#'  logFC_threshold = 1,
#'  excel_file= NULL )
#'
#'
#' @return A data frame of filtered DEGs
#' @export
#' @import edgeR openxlsx
#'
#'
#'


#Create a function which only keeps the most significant DEGs and filteres them
DEG_analysis = function(filtered_count_table,sample_table, fdr_threshold = 0.05,
                        logFC_threshold = 1, excel_file= NULL ){

  #Import sample_table
  sample_table = read.delim(sample_table, header = TRUE, sep = "\t")

  #Creates a DGEList by combining counts and condition of sample (disease or not)
  dgelist = DGEList(counts = filtered_count_table,
                group = sample_table$disease)

  #Produces a matrix indicating which sample that belongs to which group
  design = model.matrix(~ disease, data = sample_table )

  #Normalization for library size
  normalized_dgelist = calcNormFactors(dgelist)


  #Estimates dispersion of counts, accounts for variability
   dge_dispersion= estimateDisp(normalized_dgelist, design)

  #fits linear model to each gene
  fit = glmFit(dge_dispersion, design)

  #Likelihood ration test, creates a table with statistical results such as Containing Log2FC and FDR
  LRT = glmLRT(fit, coef = 2)

  #Creates a data frame from LRT data
  DEG_df = as.data.frame(LRT$table)

  #Add FDR to the dataframe
  DEG_df$FDR = p.adjust(DEG_df$PValue,method = "BH")


  #Filter away genes with too low Log2fold change and too high false discovery rate
  filtered_DEG = DEG_df[abs(DEG_df$logFC)> logFC_threshold & DEG_df$FDR <fdr_threshold,]

  #creating an if part of the function if the excel_file is not true
  if (!is.null(excel_file)){
    wb= createWorkbook()

    #add worksheet to write the data on
    addWorksheet(wb, "DEG Data")

    #put the data on the sheet
    writeData(wb, "DEG Data", filtered_DEG)

    #save the data into the excel file
    saveWorkbook(wb, file = excel_file, overwrite = TRUE)
    
  }
  return(filtered_DEG)
}








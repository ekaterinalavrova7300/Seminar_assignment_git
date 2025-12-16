# Seminar\_assignment\_git

Package name: 
RNA enrichment analysis package 

Installation instructions and usage instructions: 
These instructions can be found in the user manual vignette on github. You do not need to pull down the repository. The package is installed using the code in the user_manual vignette. 

What the package does and problem it solves:
The first function takes a count table containing gene expression data and filters it by removing low gene expression values based on CPM.
Further the second function takes the filtered count table and generates a differential gene expression data frame that is filtered by removing differentially expressed genes which have too high FDR or too low Log FC.
In addition you can request that the function also create an excel file of the data by naming it and storing it as an xlsx

The remaining functions use enrichGO and enrichKEGG from the cluster profiler package to perform enrichment analysis on the DEGs. Returning a list including both the EnrichKEGG and EnrichGO resutls
Further, plots of the enrichment analysis are created. The function returns a 3 plot list representing the enrichment analysis results of either GO or KEGG as requested. 
In summary the package performs gene expression analysis and enrichment analysis. Comparing pathway enrichment between cancer and healthy patients.  









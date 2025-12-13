# Seminar\_assignment\_git

Package name: 
RNA enrichment analysis package 

Installation instructions and usage instructions: 
These instructions can be found in the user manual vignette on github. You do not need to pull down the repository. The package is installed using the code in the user_manual vignette. 

What the package does and problem it solves:
The first function takes a count table containing gene expression data and filters it is removing low expression values based on CPM. Further the second function takes the filtered count table and generates a differential gene expression data frame that is filtered by removing differentially expressed genes which have too high FDR or too low Log FC. 
The remaining functions use enrichGO and enrichKEGG  from the cluster profiler package to perform enrichment analysis on the DEGs. Further, plots of the enrichment analysis are created. The package returns a csv file containing the DEGs and 3 plots representing the enrichment analysis results. 
In summary the package performs gene expression analysis and enrichment analysis. In this case with the data files provided the groups that are compared are RNA from FFPE and FF samples. To see if FFPE data still contains the relevant biological information despite the chemical modifications of it. 









#'plots
#'@description
#'take the data from Over_representation (OR_data) and define category number
#'create 3 different plots based on the data
#'
#'
#'@param OR_data a list of the GO data and KEGG data for the graphs ensure you use the $ to specify results of the enrichment
#'@param categories is how many categories would be used for the plot
#'
#'@return returns an excel document with the DEG data
#'
#'@example
#' Plots<- function(OR_data$GO, categories="20")
#'
#'@import openxlsx enrichplot
#'@export
#'

#Plot function defining the inputs
Plots<- function(OR_data, categories="20"){

  #tree plot
  OR_termsim<- pairwise_termsim(OR_data)
  tree<- treeplot(OR_termsim, showCategory=categories)

  #dot plot
  dot<- dotplot(OR_data, title="plot of enriched data", showCategory=categories)

  #cnet plot
  netplot<- cnetplot(OR_data, showCategory=categories, foldChange=NULL)

  #list of plots that will be returned
  allplots<-list(tree_plot=tree, dot_plot=dot, net_plot<-netplot)

  return(allplots)

}

#'Plots
#'@description
#'take the data from Over_representation (OR_data) and define category number
#'you want the plot to work with.
#'create 3 different plots based on the data
#'suppress warning messages
#'return as a list the three plots
#'
#'@param OR_data a list of the GO data and KEGG data for the graphs
#'ensure you use the $ to specify results of the enrichment
#'@param categories is how many categories would be used for the plot
#'
#'@return returns a list with the 3 plots
#'
#'@example
#' Plots<- function(OR_data$GO, categories=20)
#'
#'@import openxlsx enrichplot
#'@export
#'

#Plot function defining the inputs
Plots<- function(OR_data, categories = 20){

  #tree plot
  OR_termsim<- pairwise_termsim(OR_data)
  tree<- suppressWarnings(suppressMessages(treeplot(OR_termsim,
    showCategory = categories)))

  #dot plot
  dot<- dotplot(OR_data, title="plot of enriched data", showCategory=categories)

  #network plot
  netplot<- cnetplot(OR_data, showCategory=categories,
    node_label= "category", layout= "fr",
    color.params = list(foldChange=NULL, edge=TRUE))

  #list of plots that will be returned
  allplots<-list(tree_plot = tree, dot_plot = dot, net_plot = netplot)
  #returns the 3 plots
  return(allplots)

}

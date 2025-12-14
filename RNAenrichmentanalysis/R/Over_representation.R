#'Over_representation
#'@description
#'use the analysed data from DEG_analysis (filtered_DEG)
#'convert EntrezIDs to SYMBOL
#'do an over representation analysis using clusterProfiler
#'All this requires the data from the earlier DEG_analysis
#'
#'@param filtered_DEG data.frame that will be used for the analysis
#'@param GO which of the 3 types of GO terms BP for biological pathways
#'MF for molecular function, CC for cellular component, otherwise ALL is default
#'
#'@return data results from the Over representation analysis named OR_data
#'
#'@examples
#'Over_representation_analysis(filtered_DEG, GO="ALL")
#'to call upon GO data OR_data$GO for KEGG OR_data$KEGG
#'
#'
#'@import clusterProfiler org.Hs.eg.db
#'@export
#'

#Create function
Over_representation_analysis= function(filtered_DEG, GO="ALL"){

  #taking the gene IDs to use for conversion
  ENTIDs=rownames(filtered_DEG)

  #conversion of ENTREZIDs to SYMBOL
  IDlist=bitr(ENTIDs, fromType="SYMBOL", toType="ENTREZID", OrgDb=org.Hs.eg.db)

  #taking the EntrezIDs specifically
  entID=IDlist$ENTREZID

  #using the IDs to get the KEGG data meaning the representation of biochemical pathways
  KEGG_data=enrichKEGG(gene=entID, organism="hsa")

  #using the Ids to get the GO data meaning the if it is a biological process, molecular function, or cellular component in this case all
  GO_data=enrichGO(gene=entID, OrgDb=org.Hs.eg.db, keyType="ENTREZID", ont=GO)

  #creating a class to print both results
  OR_data= list(KEGG=KEGG_data, GO=GO_data)

  #return the over representation analysis data both enrichGO and enrichKEGG
  return(OR_data)
}

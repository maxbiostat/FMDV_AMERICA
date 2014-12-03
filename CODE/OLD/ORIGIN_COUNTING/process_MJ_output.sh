java -cp beast-test/build/dist/beast.jar dr.app.tools.BranchJumpPlotter Country A_MJ_new.trees A_MJ_new_fancy.trees
java -cp beast-test/build/dist/beast.jar dr.app.tools.TaxaOriginTrait Country Dropbox/FMDV_AMERICA/CODE/ORIGIN_COUNTING/A_epidemic_taxa.txt A_MJ_new_fancy.trees origin_counting_A
Rscript Dropbox/FMDV_AMERICA/CODE/ORIGIN_COUNTING/jumpTree_output_analysis.R

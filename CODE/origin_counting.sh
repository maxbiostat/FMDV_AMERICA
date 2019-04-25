#!/usr/bin/bash
#### This simple script will process "Markov jumps" .trees output from BEAST (with complete history logging) and return comma-separated files [.csv] with the transition counts for the chosen taxa.
#### These .csv can then be used to produce plots of the posterior distribution of transition counts using the 'origins_FMDV_AMERICA.R' script
#### The procedures here depend on the TaxaOriginTrait.java and BranchJumpPlotter.java classes in BEAST, written by Matthew Hall (Oxford) <- thanks, Matthew!
#### copyleft (or the one to blame): Carvalho, LMF (2019)

### step 0) creating the 'epidemic taxa' .txt files

## Serotype A

# Argentina 2001 -- early sequences
echo -e "A_086_KX002196_Argentina_2001-02-18\nA_086_KX002196_Argentina_2001-02-18" > A_Arg_early.txt
# Argentina 2001 -- later sequences
echo -e "A_151_AM180022_Argentina_2001-10-15\nA_152_KX002192_Argentina_2001-11-15" > A_Arg_late.txt
# Ecuador 2002
echo "A_156_JQ082929_Ecuador_2002-06-15" > A_Ecu.txt
# Brazil 2001
echo -e "A_123_JQ082912_Brazil_2001-05-15\nA_124_JQ082913_Brazil_2001-05-15\nA_125_JQ082914_Brazil_2001-05-15" > A_Bra.txt
# Uruguay 2001
echo -e "A_112_JQ082910_Uruguay_2001-04-15\nA_113_JQ082911_Uruguay_2001-04-15\nA_137_AY593802_Uruguay_2001-07-15"> A_Uru.txt
# Bolivia 2001
echo -e "A_115_JQ082916_Bolivia_2001-05-07\nA_116_JQ082917_Bolivia_2001-05-10\nA_129_JQ082918_Bolivia_2001-06-07\nA_144_JQ082919_Bolivia_2001-07-23\nA_146_JQ082920_Bolivia_2001-08-07" > A_Bol.txt
# Colombia 2008
echo -e "A_178_JQ082923_Colombia_2008-06-06\nA_179_JQ082924_Colombia_2008-06-06\nA_180_JQ082925_Colombia_2008-06-06\nA_181_JQ082926_Colombia_2008-06-06\nA_182_JQ082927_Colombia_2008-06-06\nA_183_JQ082928_Colombia_2008-06-06" > A_Col.txt

## Serotype O

# Colombia 1994
echo -e "O_023_HQ695747_Colombia_1994-07-15\nO_027_HQ695751_Colombia_1994-07-15\nO_038_HQ695762_Colombia_1994-07-15" > O_Col.txt
# Venezuela 2003
echo "O_106_HQ695845_Venezuela_2003-09-01" > O_Ven.txt
# Ecuador 2002
echo "O_088_HQ695783_Ecuador_2002-06-15" > O_Ecu.txt
# Peru 2008
echo "O_179_HQ695844_Peru_2008-06-18" > O_Per.txt
# Paraguay 2011
echo "O_210_JX514427_Paraguay_2011-09-15" > O_Par.txt

##%% WARNING: this is quite compute-intensive, so you may want to go out for a coffee :0)

### step 1) creating a .trees file with the "fancy" trees [with an extra internal node] we need to summarise the jumps

java -Xmx15g -cp path/to/beast/beast.jar dr.app.tools.BranchJumpPlotter Country A_MJ.trees A_MJ_fancy.trees
java -Xmx15g -cp path/to/beast/beast.jar dr.app.tools.BranchJumpPlotter Country O_MJ.trees O_MJ_fancy.trees

### step 2) annotating the _fancy.trees files to get the desired posteriors. 

java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait country A_Arg_early.txt A_MJ_fancy.trees A_Arg_early_2001.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait country  A_Arg_late.txt A_MJ_fancy.trees A_Arg_late_2001.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait country  A_Ecu.txt A_MJ_fancy.trees A_Ecu_2002.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait country  A_Bra.txt A_MJ_fancy.trees A_Bra_2001.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait country  A_Uru.txt A_MJ_fancy.trees A_Uru_2001.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait country  A_Bol.txt A_MJ_fancy.trees A_Bol_2001.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait country  A_Col.txt A_MJ_fancy.trees A_Col_2008.csv
#
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait country  O_Col.txt O_MJ_fancy.trees O_Col_1994.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait country  O_Ven.txt O_MJ_fancy.trees O_Ven_2003.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait country O_Ecu.txt O_MJ_fancy.trees O_Ecu_2002.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait country O_Per.txt O_MJ_fancy.trees O_Per_2008.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait country O_Par.txt O_MJ_fancy.trees O_Par_2011.csv

rm *.txt # assuming you no longer need'em



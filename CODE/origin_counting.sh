#!/usr/bin/bash
#### This simple script will process "Markov jumps" .trees output from BEAST (with complete history logging) and return comma-separated files [.csv] with the transition counts for the chosen taxa.
#### These .csv can then be used to produce plots of the posterior distribution of transition counts using the 'origins_FMDV_AMERICA.R' script
#### The procedures here depend on the TaxaOriginTrait.java and BranchJumpPlotter.java classes in BEAST, written by Matthew Hall <- thanks, Matthew!
#### copyleft (or the one to blame): Carvalho, LMF (2014)

### step 0) creating the 'epidemic taxa' .txt files

## Serotype A
# Argentina 2001
echo -e "A(c)_TLauquen_Arg_01\nA_Rivadavia_Arg_01\n A_Chapaleu_Arg_01\n A_Union_Arg_01\n A_Diamante_Arg_01\n A_Lobos_Arg_01\nA_Junin_Arg_01\nA_Daireaux_Arg_01\nA(c)_BuenosAires_Arg_01\n A_LaPampa_Arg_01" > A_Arg.txt
# Ecuador 2002
echo "A_Ecu_02" > A_Ecu.txt
# Brazil 2001
echo -e "A(b)_RS_Bra_01\nA(c)_RS_Bra_01\nA(d)_RS_Bra_01" > A_Bra.txt
# Uruguay 2001
echo -e "A_TreitayTres_Uru_01\nA_Colonia_Uru_01"> A_Uru.txt
# Bolivia 2001
echo -e "A(b)_Sta.Cruz_Bol_01\nA_Cochabamba_Bol_01\nA_Oruro_Bol_01\nA_Potosi_Bol_01" > A_Bol.txt
# Colombia 2008
echo -e "A(g)_N.deSantander_Col_08\nA(b)_N.deSantander_Col_08\nA(c)_N.deSantander_Col_08" > A_Col.txt

## Serotype O
# Colombia 1994
echo -e "gi|332739419|gb|HQ695758.1|O_Cauca_Col_94_a_\ngi|332739423|gb|HQ695760.1|O_Narino_Col_94\ngi|332739425|gb|HQ695761.1|O_Cauca_Col_94__b_\ngi|332739427|gb|HQ695762.1|O_Casanare_Col_94\ngi|332739403|gb|HQ695750.1|O_Boyaca_Col_94__b_\ngi|332739407|gb|HQ695752.1|O_Valle_Col_94\n
gi|332739399|gb|HQ695748.1|O_Santander_Col_94\ngi|332739401|gb|HQ695749.1|O_Boyaca_Col_94__a_\ngi|332739405|gb|HQ695751.1|O_Boyaca_Col_94__c_\ngi|332739397|gb|HQ695747.1|O_Cundinamarca_Col_94__a_\ngi|332739417|gb|HQ695757.1|O_Cundinamarca_Col_94__e_\ngi|332739421|gb|HQ695759.1|\nO_Cundinamarca_Col_94__f_\ngi|332739409|gb|HQ695753.1|O_Boyaca_Col_94__d_\ngi|332739411|gb|HQ695754.1|O_Cundinamarca_Col_94__b_\ngi|332739413|gb|HQ695755.1|O_Cundinamarca_Col_94__c_\ngi|332739415|gb|HQ695756.1|O_Cundinamarca_Col_94__d_\n" > O_Col.txt
# Venezuela 2003
echo "gi|332739593|gb|HQ695845.1|O_Yaracuy_Ven_03__21081_" > O_Ven.txt
# Ecuador 2002
echo "gi|332739469|gb|HQ695783.1|O_Esmeraldas_Ecu_02__003-02_" > O_Ecu.txt
# Peru 2004
echo "gi|332739591|gb|HQ695844.1|O_Lima_Peru_04" > O_Per.txt

##%% WARNING: this is quite compute-intensive, so you may want to go out for a coffee :0)

### step 1) creating a .trees file with the "fancy" trees [with an extra internal node] we need to summarise the jumps

java -Xmx15g -cp path/to/beast/beast.jar dr.app.tools.BranchJumpPlotter Country A_MJ.trees A_MJ_fancy.trees
java -Xmx15g -cp path/to/beast/beast.jar dr.app.tools.BranchJumpPlotter Country O_MJ.trees O_MJ_fancy.trees

### step 2) annotating the _fancy.trees files to get the desired posteriors. 

java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait A_Arg.txt A_MJ_fancy.trees A_Arg_2001.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait A_Ecu.txt A_MJ_fancy.trees A_Ecu_2002.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait A_Bra.txt A_MJ_fancy.trees A_Bra_2001.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait A_Uru.txt A_MJ_fancy.trees A_Uru_2001.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait A_Bol.txt A_MJ_fancy.trees A_Bol_2001.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait A_Col.txt A_MJ_fancy.trees A_Col_2008.csv
#
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait O_Col.txt O_MJ_fancy.trees O_Col_1994.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait O_Ven.txt O_MJ_fancy.trees O_Ven_2003.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait O_Ecu.txt O_MJ_fancy.trees O_Ecu_2002.csv
java -cp path/to/beast/beast.jar dr.app.tools.TaxaOriginTrait O_Per.txt O_MJ_fancy.trees O_Per_2004.csv

rm *.txt # assuming you no longer need'em



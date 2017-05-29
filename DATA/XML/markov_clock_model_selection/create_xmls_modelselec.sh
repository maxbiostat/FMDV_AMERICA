#!/bin/bash
for file in *.fasta
do
./convert_to_xml.sh $file beastgen.3part.HKYG.STRICT.SG.template hky_strict 
./convert_to_xml.sh $file beastgen.3part.HKYG.UCLN.SG.template hky_uln
./convert_to_xml.sh $file beastgen.3part.TN93G.STRICT.SG.template tn93_strict
./convert_to_xml.sh $file beastgen.3part.TN93G.UCLN.SG.template tn93_uln
./convert_to_xml.sh $file beastgen.3part.GTRG.STRICT.SG.template gtr_strict
./convert_to_xml.sh $file beastgen.3part.GTRG.UCLN.SG.template gtr_uln      
done

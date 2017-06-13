## Data acquisition
In the interest of reproducibility we detail the data collection procedure we employed.

1. We went to [GenBank](https://www.ncbi.nlm.nih.gov/genbank/) and downloaded [all](https://github.com/maxbiostat/FMDV_AMERICA/blob/master/DATA/SEQUENCES/data_acquisition/all_fmdv.gb) FMDV sequences with length `>600 bp`. 
2. Next, filtered for sequences that included the `1D (VP1)` gene ([result](https://github.com/maxbiostat/FMDV_AMERICA/blob/master/DATA/SEQUENCES/data_acquisition/VP1.fasta));
3. We kept only the serotype [A](https://github.com/maxbiostat/FMDV_AMERICA/blob/master/DATA/SEQUENCES/data_acquisition/SA_serotype_A.gb) and [O](https://github.com/maxbiostat/FMDV_AMERICA/blob/master/DATA/SEQUENCES/data_acquisition/SA_serotype_O.gb) sequences;
4. Finally, we kept all the sequences from South America for which a country and year of isolation were available ([metadata](https://github.com/maxbiostat/FMDV_AMERICA/blob/master/DATA/SEQUENCES/data_acquisition/VP1_serotypesA%26O_SA_metadata.csv)). 
5. Sequences from samples extensively passaged in culture were also excluded. 
The resulting data sets for serotypes [A](https://github.com/maxbiostat/FMDV_AMERICA/blob/master/DATA/SEQUENCES/serotype_A_VP1_renamed_unaligned.fasta) and [O](https://github.com/maxbiostat/FMDV_AMERICA/blob/master/DATA/SEQUENCES/serotype_A_VP1_renamed_unaligned.fasta) comprised `184` and `215` sequences, respectively. 
Final data sets were obtained by aligning using [MAFFT](http://mafft.cbrc.jp/alignment/software/).

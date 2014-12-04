``XMLs``

These are some of the BEAST configuration files, aka, XMLs to reproduce pretty much all the analyses reported in the paper.

For serotype ``S`` (A or O), we provide:

** ``S``_asymmetric_equal_rates.xml**: the equal rates prior, which places the same (reasonably) diffuse Gamma prior on all rates in the CTMC; 

**``S``_{``cattle, pig, sheep``}.xml**: the {``cattle, pigs, sheep``} predictor, elicited from FAO trade data, also provided in this repository;

**``S``_geographic_distances.xml**: inverse (normalised) geographic distances between countries as a predictor;

**``S``_Markov_Jumps.xml**: this XML contains the necessary blocks to do robust counting for all geographic transitions with complete history logging;

**``S``_subsample_``i``.xml**: XMLS for the downsampling sensitivity analysis (``i=1, 2,...,5``); 

**A_without_Argentina.xml**: estimating stuff without Argentina for serotype A to assess the impact of over-representation;

**O_without_Ecuador.xml**: Same experiment for serotype O, but excluding the sequences from Ecuador.

# Analysis of changes in mutations and fitness along Pango branches

## Prep

Run `python ../scripts/prepare-pango-relationships.py --seq-counts results/sarscov2_lineages_scaffolded_fitness.tsv --output-relationships source-data/pango_variant_relationships.tsv`.

Recombinant viruses don't have a canonical parent. Manually update `XEC` to have parent `KP.3.3` based on spike sequence and `XBB` to have parent `BA.2.75.3` (this is the closest lineage to the canonical RBD parent of `BM.1.1.1` that's in the dataset). _This identification of best parents of recombinant lineages should probably be automated._

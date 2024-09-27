# Comparing fitness dynamics across SARS-CoV-2, influenza H3 and influenza H1

## Sequence counts

_Only SARS-CoV-2 currently implemented_

Data for the project consists of daily sequence counts of clades of SARS-CoV-2,
influenza H3 and influenza H1. Sequence counts are provisioned to the
`sequence-counts/` directory. From top-level directory run
```
nextstrain build sequence-counts all_sequence_counts
```
to produce the sequence counts files
```
sequence-counts/results/sarscov2/seq_counts.tsv
```

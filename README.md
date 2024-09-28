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

## MLR estimates

_Only SARS-CoV-2 currently implemented_

Run MLR models using [evofr package](https://github.com/blab/evofr).

Copy sequence counts from `sequence-counts` directory
```
mkdir -p mlr-estimates/data/sarscov2
cp sequence-counts/results/sarscov2/seq_counts.tsv mlr-estimates/data/sarscov2/
```

Run the snakemake pipeline with
```
nextstrain build mlr-estimates
```
to produce the MLR output JSON files
```
mlr-estimates/results/sarscov2/mlr_results.json
```

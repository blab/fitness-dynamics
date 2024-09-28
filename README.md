# Comparing fitness dynamics across SARS-CoV-2, influenza H3 and influenza H1

_Only SARS-CoV-2 currently implemented_

Run the entire workflow with
```
nextstrain build .
```

## Sequence counts

Data for the project consists of daily sequence counts of clades of SARS-CoV-2,
influenza H3 and influenza H1. Sequence counts are provisioned to the
`sequence-counts/` directory. From top-level directory run
```
nextstrain build . all_sequence_counts
```
to produce the sequence counts files
```
sequence-counts/sarscov2/prepared_seq_counts.tsv
```

## MLR estimates

Run MLR models using [evofr package](https://github.com/blab/evofr). Run the
model with
```
nextstrain build . all_mlr_estimates
```
to produce the MLR output JSON files
```
mlr-estimates/sarscov2/mlr_results.json
```

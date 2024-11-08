# Comparing fitness dynamics across 7PET V.c. clades
Forked from https://github.com/blab/fitness-dynamics

## Provision metadata locally

```
zstd -c data/7PET_metadata.tsv > data/7PET_metadata.tsv.zst
```

## Workflow

Once metadata is provisioned locally, run the entire workflow with
```
nextstrain build . all_mlr_estimates
```

### Sequence counts

Data for the project consists of sequence counts of clades of V.c. 
Sequence counts are provisioned to the `sequence-counts/` directory.

 From top-level directory run
```
nextstrain build . all_sequence_counts
```
to produce the sequence counts files
```
sequence-counts/7PET/prepared_seq_counts.tsv
```
Currently, clade counts are provisioned for just India, Bangladesh, China, and DRC.

### MLR estimates

Run MLR models using [evofr package](https://github.com/blab/evofr). Run the
model with
```
nextstrain build . all_mlr_estimates
```
to produce the MLR output JSON files
```
mlr-estimates/7PET/mlr_results.json
```

# Comparing fitness dynamics across SARS-CoV-2, influenza H3 and influenza H1

## Provision metadata locally

```
mkdir data
cd data
```

For SARS-CoV-2
```
aws s3 cp s3://nextstrain-ncov-private/metadata.tsv.zst sarscov2_metadata.tsv.zst
zstd -c -d sarscov2_metadata.tsv.zst \
   | tsv-select -H -f strain,date,country,clade_nextstrain,QC_overall_status \
   | zstd -c > sarscov2_subset_metadata.tsv.zst
```
and move to `fitness-dynamics/data/`.

For H3N2, clone https://github.com/blab/flu-geo-fitness and then run
```
nextstrain build . data/h3n2/metadata_with_nextclade.tsv
cd data/h3n2/
sed -i -e 's/\tseqName\t/\tstrain\t/' metadata_with_nextclade.tsv
sed -i -e 's/\tUsa\t/\tUSA\t/g' metadata_with_nextclade.tsv
sed -i -e '1s/$/\tinclusion/; 2,$s/$/\tglobal/' metadata_with_nextclade.tsv
tsv-select -H -f strain,date,country,inclusion,subclade,qc.overallStatus metadata_with_nextclade.tsv > metadata_selected.tsv
tsv-filter -H --str-ne subclade:unassigned --str-gt date:2000-01-01 metadata_selected.tsv > metadata_filtered.tsv
zstd -c metadata_filtered.tsv > h3n2_subset_metadata.tsv.zst
```
and move to `fitness-dynamics/data/`.

## Workflow

Once metadata is provisioned locally, run the entire workflow with
```
nextstrain build . all_mlr_estimates
```

### Sequence counts

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
Currently, clade counts are provisioned for just the USA.

### MLR estimates

Run MLR models using [evofr package](https://github.com/blab/evofr). Run the
model with
```
nextstrain build . all_mlr_estimates
```
to produce the MLR output JSON files
```
mlr-estimates/sarscov2/mlr_results.json
```

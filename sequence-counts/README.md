# Sequence counts

_Only SARS-CoV-2 currently implemented_

Download metadata for SARS-CoV-2 and seasonal influenza and summarize sequence
counts. This directory is a streamlined version of
[`forecasts-ncov/ingest`](https://github.com/nextstrain/forecasts-ncov/tree/main/ingest).

## Running locally

Please follow [installation
instructions](https://docs.nextstrain.org/en/latest/install.html#installation-steps)
for Nextstrain's software tools.

[config/defaults.yaml](config/defaults.yaml) contains all of the default
configuration parameters used for the ingest workflow. Use Snakemake's
`--configfile`/`--config` options to override these default values.

Running the workflow for sequence counts requires AWS credentials to download
the metadata from AWS S3: - AWS_ACCESS_KEY_ID - AWS_SECRET_ACCESS_KEY

To summarize the sequence counts locally run:

```
nextstrain build . all_sequence_counts
```

If you only want to run the sequence counts for a single virus (e.g. `sarscov2`) run:

```
nextstrain build . all_sequence_counts --config viruses="[sarscov2]"
```

## Output

Running this workflow results in the files

```
results/sarscov2/seq_counts.tsv
```

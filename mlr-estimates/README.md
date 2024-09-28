# MLR estimates

_Only SARS-CoV-2 currently implemented_

Run MLR model on sequence counts. This directory is a streamlined version of
[`forecasts-ncov/`](https://github.com/nextstrain/forecasts-ncov/).

Start by copying sequence counts from `sequence-counts` directory
```
mkdir -p data/sarscov2
cp ../sequence-counts/results/sarscov2/seq_counts.tsv data/sarscov2/
```

Run the snakemake pipeline with
```
nextstrain build .
```

## Installation

Please follow [installation instructions](https://docs.nextstrain.org/en/latest/install.html#installation-steps) for Nextstrain's software tools.

### Data Prep Configurations

The `prepare_data` params in `config/config.yaml` are used to subset the full
case counts and clades counts data to specific date range, locations, and clades.

The pipeline is set to only include data from:

- the past 150 days
    - excluding sequences from the last 12 days since they may be overly enriched for variants
- locations that have at least 500 sequences in the last 30 days
    - excluding locations specifically listed in `defaults/global_excluded_locations.txt`
- clades that have at least 5000 sequences in the last 150 days

### Model configurations

The specific model configurations are housed in separate config YAML files or each model.
These separate config files must be provided in the main config as `mlr_config`.
Note the inputs and outputs for the models are overridden in the Snakemake pipeline to conform to the Snakemake input/output framework.

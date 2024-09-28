"""
Summarize sequence counts from existing metadata for a particular virus
"""

rule subset_metadata:
    output:
        subset_metadata = "sequence-counts/{virus}/subset_metadata.tsv.zst"
    params:
        s3_src = lambda w: config[w.virus]["s3_metadata"],
        subset_columns = lambda w: ",".join(config[w.virus]["subset_columns"]),
    shell:
        """
        aws s3 cp {params.s3_src:q} - \
            | zstd -c -d \
            | tsv-select -H -f {params.subset_columns:q} \
            | zstd -c > {output.subset_metadata}
        """

rule summarize_clade_sequence_counts:
    input:
        subset_metadata = "sequence-counts/{virus}/subset_metadata.tsv.zst"
    output:
        clade_seq_counts = "sequence-counts/{virus}/seq_counts.tsv"
    params:
        seq_count_options = lambda w: config[w.virus]["seq_count_options"]
    shell:
        """
        ./scripts/summarize-clade-sequence-counts \
            --metadata {input.subset_metadata} \
            --output {output.clade_seq_counts} \
            {params.seq_count_options}
        """

def _get_prepare_data_option(wildcards, option_name):
    """
    Return the option for prepare data from the config based on the
    wildcards.virus values.

    If the *option* exists as a key within config[wildcard.virus]
    then return as "--{option-name} {option_value}". Or else return an empty string.
    """
    option_value = config.get(wildcards.virus, {}) \
                         .get(option_name)

    if option_value is not None:
        # Change underscores of YAML keys to dashes for proper CLI option names
        option_name = option_name.replace('_', '-')
        return f'--{option_name} {option_value}'

    return ''

rule prepare_clade_data:
    """Preparing clade counts for analysis"""
    input:
        sequence_counts = "sequence-counts/{virus}/seq_counts.tsv"
    output:
        sequence_counts = "sequence-counts/{virus}/prepared_seq_counts.tsv"
    log:
        "logs/{virus}/prepare_clade_data.txt"
    params:
        max_date = lambda wildcards: _get_prepare_data_option(wildcards, 'max_date'),
        included_days = lambda wildcards: _get_prepare_data_option(wildcards, 'included_days'),
        location_min_seq = lambda wildcards: _get_prepare_data_option(wildcards, 'location_min_seq'),
        location_min_seq_days = lambda wildcards: _get_prepare_data_option(wildcards, 'location_min_seq_days'),
        excluded_locations = lambda wildcards: _get_prepare_data_option(wildcards, 'excluded_locations'),
        clade_min_seq = lambda wildcards: _get_prepare_data_option(wildcards, 'clade_min_seq'),
        clade_min_seq_days = lambda wildcards: _get_prepare_data_option(wildcards, 'clade_min_seq_days'),
        force_include_clades = lambda wildcards: _get_prepare_data_option(wildcards, 'force_include_clades'),
    shell:
        """
        python ./scripts/prepare-data.py \
            --seq-counts {input.sequence_counts} \
            {params.max_date} \
            {params.included_days} \
            {params.location_min_seq} \
            {params.location_min_seq_days} \
            {params.excluded_locations} \
            {params.clade_min_seq} \
            {params.clade_min_seq_days} \
            {params.force_include_clades} \
            --output-seq-counts {output.sequence_counts} 2>&1 | tee {log}
        """

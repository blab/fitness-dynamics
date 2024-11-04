import argparse
import pandas as pd
from pango_aliasor.aliasor import Aliasor

def find_closest_parents(variant: str, variants: list[str], aliasor: Aliasor):
    parent = aliasor.parent(variant)
    while parent != "":
        if parent in variants:
            return parent
        parent = aliasor.parent(parent)
    return parent

def main():
    parser = argparse.ArgumentParser(description = "Given input sequence counts, generate a file mapping lineages to closest parental lineage.")
    parser.add_argument("--seq-counts", type=str, required=True, help="input TSV of collapsed sequence counts")
    parser.add_argument("--output-relationships", type=str, required=True, help="output TSV of pango-variant-relationships")
    args = parser.parse_args()

    aliasor = Aliasor()
    seq_counts = pd.read_csv(args.seq_counts, sep="\t")
    variants = seq_counts.variant.unique()

    parent_map = []
    for variant in variants:
        closest_parent = find_closest_parents(variant, variants, aliasor)
        parent_map.append({"variant": variant, "closest_parent": closest_parent})

    variant_relationships = pd.DataFrame(parent_map)
    variant_relationships.to_csv(args.output_relationships, sep="\t", index=False)

if __name__ == "__main__":
    main()

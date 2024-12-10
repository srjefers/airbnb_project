import os
import argparse
import numpy as np
import pandas as pd

def main(params: argparse.Namespace) -> None:
    """
        main    -> void
        @type params    argparse.Namespace
        Funtion defined to read, cleand and export data.
    """
    try:
        file_path = params.file_path
        export_path = params.export_path
        df = pd.read_csv(file_path, sep=',', header=0)

        df["last_review"] = pd.to_datetime(df["last_review"])
        df['name'] = df['name'].str.capitalize()
        df['host_name'] = df['host_name'].str.capitalize()

        df.drop_duplicates(inplace=True)

        df['reviews_per_month'] = df['reviews_per_month'].fillna(0)
        df['last_review'] = df['last_review'].fillna(df['last_review'].min())
        df['name'] = df['name'].fillna('None')
        df['host_name'] = df['host_name'].fillna('None')

        assert df.isna().sum().sum() == 0, print("Missing Values fund!")

        df.to_csv(export_path, index=False)
    except BaseException as error:
        print('An exception ocurred: {0}'.format(str(error)))
    finally:
        print('END')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Read, clean and export.')

    parser.add_argument('--file_path', help='File path')
    parser.add_argument('--export_path', help='Export path')
    
    args = parser.parse_args()
    main(args)
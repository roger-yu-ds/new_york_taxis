import pyspark.sql.functions as F


def count_missing(spark_df, sort=True):
    """
    Counts number of nulls and nans in each column
    """
    df = spark_df.select([F.count(F.when(F.isnan(c) | F.isnull(c), c)).alias(c)
                          for (c, c_type) in spark_df.dtypes if c_type not in (
                          'timestamp', 'string', 'date')]).toPandas()

    if len(df) == 0:
        print("There are no any missing values!")
        return None

    if sort:
        return df.rename(index={0: 'count'}).T.sort_values("count",
                                                           ascending=False)

    return df

# Getting Option Data

These SQL scripts can be used to fetch/download historical option data from IvyDB.

There are multiple queries in this repo because there are different tables offered in the IvyDB where we need to attain data from it's easier to split it up than download everything in a single query.

Because we will be building a deep learning model, we will be needing a TON of data. However because the intention is to download `.csv` files directly from the OptionMetrics IvyDB, the size of these downloads can get massive if trying to download everything at a single time so these queries will technically be required to run multiple (for each year) times or in "batches"




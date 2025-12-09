# A Guide to Collecting Option Data

These SQL scripts can be used to fetch/download historical option data from IvyDB.

There are multiple queries in this repo because there are different tables offered in the IvyDB where we need to attain data from so it's easier to split it up than download everything in a single query.

We plan on building a deep learning model and will be needing a TON of data. However because the intention is to download `.csv` files directly from the OptionMetrics IvyDB, the size of these downloads can get massive if trying to download everything at a single time so these queries will technically be required to run multiple (for each year) times or in "batches"

So here's the plan:

We would be needing the historical option prices of each option contract in a ticker's option chain across the entire universie of tickers that IvyDB offers. 

For each option contract we would need to track:

- Daily Close Prices
- The Greeks (delta, gamma, vega, theta)
- Bid/Ask 
- Volume
- Open Interest
- Implieved Volatility

This is what `option_chain.sql` aims to collect in the `/OptionTBs` folder. 

However since this is a massive scale of data, so that's why we would have to split this up by year by year, starting from 2010. 



-- Top 100 S&P 500 stocks (by avg market cap 2020-2025), full option chain
-- Date range: 2020-01-01 to 2025-12-31
DECLARE @fromDate DATE = '2020-01-01';
DECLARE @toDate   DATE = '2025-12-31';

WITH SP500_Top100 AS (
    -- Rank all US common stocks by average market cap over the period;
    -- top 100 serves as a proxy for the largest S&P 500 constituents.
    SELECT TOP 100
        sp.SecurityID
    FROM Security_Price sp
    JOIN Security s ON s.SecurityID = sp.SecurityID
    WHERE sp.Date BETWEEN @fromDate AND @toDate
      AND s.IssueType  = '0'   -- Common Stock only
      AND s.IndexFlag  = '0'   -- Exclude indices
      AND sp.ClosePrice       > 0
      AND sp.SharesOutstanding > 0
    GROUP BY sp.SecurityID
    ORDER BY AVG(ABS(sp.ClosePrice) * CAST(sp.SharesOutstanding AS FLOAT) * 1000) DESC
)
SELECT
    op.SecurityID,
    sn.Ticker,
    op.Date,
    op.Symbol,
    op.SymbolFlag,
    CAST(op.Strike AS FLOAT) / 1000.0 AS Strike,  -- IvyDB stores strike * 1000
    op.Expiration,
    op.CallPut,
    op.BestBid,
    op.BestOffer,
    op.Volume,
    op.OpenInterest,
    op.SpecialSettlement,
    op.ImpliedVolatility,
    op.Delta,
    op.Gamma,
    op.Vega,
    op.Theta,
    op.AMSettlement,
    op.ContractSize,
    op.ExpiryIndicator,
    op.AdjustmentFactor
FROM Option_Price op
JOIN Security_Name sn
  ON sn.SecurityID = op.SecurityID
 AND sn.Date = (
        SELECT MAX(sn2.Date)
        FROM Security_Name sn2
        WHERE sn2.SecurityID = op.SecurityID
          AND sn2.Date <= op.Date
    )
WHERE op.Date BETWEEN @fromDate AND @toDate
  AND op.SecurityID IN (SELECT SecurityID FROM SP500_Top100)
ORDER BY sn.Ticker, op.Date, op.Expiration, Strike, op.CallPut;

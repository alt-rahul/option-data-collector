-- Standardized ATM forward option prices for top 100 S&P 500 stocks
-- Date range: 2020-01-01 to 2025-12-31
DECLARE @fromDate DATE = '2020-01-01';
DECLARE @toDate   DATE = '2025-12-31';

WITH SP500_Top100 AS (
    SELECT TOP 100
        sp.SecurityID
    FROM Security_Price sp
    JOIN Security s ON s.SecurityID = sp.SecurityID
    WHERE sp.Date BETWEEN @fromDate AND @toDate
      AND s.IssueType  = '0'
      AND s.IndexFlag  = '0'
      AND sp.ClosePrice       > 0
      AND sp.SharesOutstanding > 0
    GROUP BY sp.SecurityID
    ORDER BY AVG(ABS(sp.ClosePrice) * CAST(sp.SharesOutstanding AS FLOAT) * 1000) DESC
)
SELECT
    sop.SecurityID,
    sn.Ticker,
    sop.Date,
    sop.Days,
    sop.CallPut,
    sop.ForwardPrice,
    sop.Strike,
    sop.OptionPrice,
    sop.ImpliedVolatility,
    sop.Delta,
    sop.Gamma,
    sop.Vega,
    sop.Theta
FROM Std_Option_Price sop
JOIN Security_Name sn
  ON sn.SecurityID = sop.SecurityID
 AND sn.Date = (
        SELECT MAX(sn2.Date)
        FROM Security_Name sn2
        WHERE sn2.SecurityID = sop.SecurityID
          AND sn2.Date <= sop.Date
    )
WHERE sop.Date BETWEEN @fromDate AND @toDate
  AND sop.SecurityID IN (SELECT SecurityID FROM SP500_Top100)
ORDER BY sn.Ticker, sop.Date, sop.Days, sop.CallPut;

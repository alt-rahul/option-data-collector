DECLARE @Year     INT  = 2010; -- this line is where you can change the year
DECLARE @fromDate DATE = DATEFROMPARTS(@Year, 1, 1);
DECLARE @toDate   DATE = DATEFROMPARTS(@Year, 12, 31);

SELECT
    op.SecurityID,
    sn.Ticker,
    op.Date,
    op.Symbol,
    op.SymbolFlag,
    CAST(op.Strike AS FLOAT) / 1000.0 AS Strike,  -- IvyDB strike * 1000 (in the documentation IvyDB said it multiples strike prices by a 1000)
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
ORDER BY sn.Ticker, op.Date, op.Expiration, Strike, op.CallPut;

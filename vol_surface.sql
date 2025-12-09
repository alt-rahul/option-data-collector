DECLARE @Year     INT  = 2010;
DECLARE @fromDate DATE = DATEFROMPARTS(@Year, 1, 1);
DECLARE @toDate   DATE = DATEFROMPARTS(@Year, 12, 31);

SELECT
    vs.SecurityID,
    sn.Ticker,
    vs.Date,
    vs.Days,             
    vs.Delta,             
    vs.CallPut,           
    vs.ImpliedVolatility,
    vs.ImpliedStrike,
    vs.ImpliedPremium,
    vs.Dispersion
FROM Volatility_Surface vs
JOIN Security_Name sn
  ON sn.SecurityID = vs.SecurityID
 AND sn.Date = (
        SELECT MAX(sn2.Date)
        FROM Security_Name sn2
        WHERE sn2.SecurityID = vs.SecurityID
          AND sn2.Date <= vs.Date
    )
WHERE vs.Date BETWEEN @fromDate AND @toDate
ORDER BY sn.Ticker, vs.Date, vs.Days, vs.CallPut, vs.Delta;
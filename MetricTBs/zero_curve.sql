-- Risk-free zero curve (market-wide, no security filter)
-- Date range: 2020-01-01 to 2025-12-31
DECLARE @fromDate DATE = '2020-01-01';
DECLARE @toDate   DATE = '2025-12-31';

SELECT
    zc.Date,
    zc.Days,
    zc.Rate
FROM Zero_Curve zc
WHERE zc.Date BETWEEN @fromDate AND @toDate
ORDER BY zc.Date, zc.Days;

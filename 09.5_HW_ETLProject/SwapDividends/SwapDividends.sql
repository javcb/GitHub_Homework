use Core
Declare @StartDate DATETIME,
              @EndDate DATETIME
 
Set @StartDate = '2018-12-01 00:00:00'
Set @EndDate = DATEADD(d, -1, DATEADD(m, DATEDIFF(m, 0, '2017-10-15 00:00:00') + 1, 0))
 
--Create Procedure SwapDividendBalances as
select sec.SecurityCode, format(cacs.ExDate, 'MM/dd/yy') as Ex_Date, format(cacs.PayDate, 'MM/dd/yy') as Pay_Date, format(lots.TaxLotDate, 'MM/dd/yy') as Lot_Date, brk.BrokerCode, port.PortfolioCode
 
       -----------------subquery to get eligible lots vs open lots----------------------------
       , format(sum(case when lots.TaxLotDate <= ExDate then lots.Quantity else 0 end), '###,###,###') as Eligible_Lots
       , format(sum(div.BaseAmount),'###,###,###') as USD_Div
       , format(sum(case when lots.DateId = CONVERT(VARCHAR(10), @EndDate, 112)
                                  and lots.TaxLotDate <= cacs.ExDate
                                  then lots.Quantity else 0 end), '###,###,###') as Remaining_Lots
       , format(sum(div.BaseAmount)/5,'###,###,###') as Remaining_Div 
       --, format(sum(lots.Quantity), '###,###,###') as Remaining_Lots
--            from dbo.TaxLots_NEW where lots.DateId = CONVERT(VARCHAR(10), @EndDate, 112))
 
from dbo.Security as sec
inner join dbo.CorporateAction as cacs on sec.SecurityId = cacs.SecurityId
inner join dbo.TaxLots_NEW as lots on sec.SecurityId = lots.SecurityId
--inner join dbo.RealizedGainloss as rgl on sec.SecurityId = rgl.SecurityId
inner join dbo.PositionAdjustment as div on sec.SecurityId = div.SecurityId
inner join dbo.Broker as brk on lots.PrimeBrokerId = brk.BrokerId
inner join dbo.Portfolio as port on lots.PortfolioId = port.PortfolioId
 
where
       SecurityCode like '%_SW%'
       and PortfolioCode like 'SFI%'
       and (div.PositionAdjustmentTypeId in (1, 2))
       --and (div.PortfolioId = 3)
       and (cacs.ExDate <= @EndDate)
       and (cacs.PayDate > @EndDate)
       and (div.DateId = CONVERT(VARCHAR(10), cacs.ExDate, 112))
       and (lots.DateId = CONVERT(VARCHAR(10), @EndDate, 112))
--     and (lots.TaxLotDate < ExDate)
       and (lots.PortfolioId = div.PortfolioId)
       --and (div.DateId = CONVERT(VARCHAR(10), lots.TaxLotDate, 112))     
       --and (rgl.TaxLotOpenDate < ExDate)
       --and (rgl.CloseDate between @StartDate and @EndDate)
       group by sec.SecurityCode, cacs.ExDate, lots.TaxLotDate, cacs.PayDate, brk.BrokerCode, port.PortfolioCode;
--Go
 
--Exec SwapDividendBalances;
 
--select top 10 * from dbo.PositionAdjustment;
 
--select * from dbo.PositionAdjustmentType;
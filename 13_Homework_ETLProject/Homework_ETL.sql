-- create database financials;

use financials;

select * from fx_brl;

select pg.date, pg.PX_LAST, fx.PX_LAST FROM pags AS pg
INNER JOIN fx_brl as fx ON pg.Date = fx.Date;

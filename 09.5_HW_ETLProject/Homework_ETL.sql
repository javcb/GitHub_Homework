-- create database financials;

use financials;

select * from fx_brl;

select pg.date, pg.PX_LAST AS foreign_px, fx.PX_LAST AS fx_rate FROM pags_brl AS pg
INNER JOIN fx_brl as fx ON pg.Date = fx.Date;

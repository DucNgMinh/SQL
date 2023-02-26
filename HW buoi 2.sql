select * from SalesLT.Test_Assesment_Raw

-- TOTAL
-- Total no. of clients
select count(distinct  [Member Account Code]) from SalesLT.Test_Assesment_Raw -- 339
-- Total Sales
select sum([Sales Amt]) / 23500
from SalesLT.Test_Assesment_Raw
-- Total transactions
select count(distinct Invoice)
from SalesLT.Test_Assesment_Raw
-- Total Items Sold
select sum([Sales Qty])
from SalesLT.Test_Assesment_Raw
-- Transactions with >2 items
select distinct count(*) OVER (  ) as [Total_>2_Transaction]
from SalesLT.Test_Assesment_Raw
group by Invoice
having sum([Sales Qty]) >= 2
-- ATV (Average transaction value)
select (sum([Sales Amt]) / 23500) / (count(distinct Invoice))
from SalesLT.Test_Assesment_Raw
-- UPT (Unit per transaction)
select cast(sum([Sales Qty]) as float)/ cast(count(distinct Invoice) as float)
from SalesLT.Test_Assesment_Raw
----------------------------------------------------------
-- Platium (> $50K)
-- Segment
select  [Member Account Code] ,sum([Sales Amt]) / 23500 as Total_Records,
        count(distinct Invoice) as Total_Transactions, sum([Sales Qty]) as Total_Item_sold
from  SalesLT.Test_Assesment_Raw
group by [Member Account Code]
having  sum([Sales Amt]) / 23500 > 50000
order by sum([Sales Amt]) desc
-- Count
select distinct count(*) OVER (  ) as Total_Records
from SalesLT.Test_Assesment_Raw
group by [Member Account Code]
having sum([Sales Amt]) / 23500 > 50000
-- Total Sales
select sum(Total_Records)
from ( select sum([Sales Amt]) / 23500 as Total_Records
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having  sum([Sales Amt]) / 23500 > 50000) as Platium_Table
-- Total transactions
select sum(Total_Transactions)
from (select count(distinct Invoice) as Total_Transactions
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having  sum([Sales Amt]) / 23500 > 50000) as PL_table
-- Total Items Sold
select sum (Total_Item_sold)
from (select sum([Sales Qty]) as Total_Item_sold
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having  sum([Sales Amt]) / 23500 > 50000 ) as PL_table
-- Transactions with >2 items
select distinct count(*) OVER (  ) as [Total_>2_Transaction]
from SalesLT.Test_Assesment_Raw
where [Member Account Code] in (select  [Member Account Code]
                                from  SalesLT.Test_Assesment_Raw
                                group by [Member Account Code]
                                having sum([Sales Amt]) / 23500 > 50000)
group by Invoice
having sum([Sales Qty]) >= 2
-- ATV (Average transaction value)
select sum(Total_Records) / sum(Total_Transactions)
from ( select sum([Sales Amt]) / 23500 as Total_Records, count(distinct Invoice) as Total_Transactions
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having  sum([Sales Amt]) / 23500 > 50000) as Platium_Table
-- UPT (Unit per transaction)
select cast(sum(Total_Item_sold) as float) / cast(sum(Total_Transactions) as float)
from (select sum([Sales Qty]) as Total_Item_sold, count(distinct Invoice) as Total_Transactions
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having  sum([Sales Amt]) / 23500 > 50000 ) as PL_table
----------------------------------------------------------
-- Gold ($25K- <$50K)
-- Count
select distinct count(*) OVER (  ) as Total_Records
from SalesLT.Test_Assesment_Raw
group by [Member Account Code]
having sum([Sales Amt]) / 23500 > 25000 and sum([Sales Amt]) / 23500 < 50000
-- Total Sales
select sum(Total_Records)
from ( select  sum([Sales Amt]) / 23500  as Total_Records
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having  sum([Sales Amt]) / 23500 > 25000 and sum([Sales Amt]) / 23500 < 50000) as Gold_Table
-- Total transactions
select sum(Total_Transactions)
from (select count(distinct Invoice) as Total_Transactions
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 > 25000 and sum([Sales Amt]) / 23500 < 50000) as G_table
-- Total Items Sold
select sum (Total_Item_sold)
from (select sum([Sales Qty]) as Total_Item_sold
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 > 25000 and sum([Sales Amt]) / 23500 < 50000) as G_table
-- Transactions with >2 items
select distinct count(*) OVER (  ) as [Total_>2_Transaction]
from SalesLT.Test_Assesment_Raw
where [Member Account Code] in (select  [Member Account Code]
                                from  SalesLT.Test_Assesment_Raw
                                group by [Member Account Code]
                                having sum([Sales Amt]) / 23500 > 25000 and sum([Sales Amt]) / 23500 < 50000)
group by Invoice
having sum([Sales Qty]) >= 2
-- ATV (Average transaction value)
select sum(Total_Records) / sum(Total_Transactions)
from ( select sum([Sales Amt]) / 23500 as Total_Records, count(distinct Invoice) as Total_Transactions
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 > 25000 and sum([Sales Amt]) / 23500 < 50000) as Platium_Table
-- UPT (Unit per transaction)
select cast(sum(Total_Item_sold) as float) / cast(sum(Total_Transactions) as float)
from (select sum([Sales Qty]) as Total_Item_sold, count(distinct Invoice) as Total_Transactions
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 > 25000 and sum([Sales Amt]) / 23500 < 50000) as PL_table
----------------------------------------------------------
-- Sliver ($10K- < $25K)
-- Count
select distinct count(*) OVER (  ) as Total_Records
from SalesLT.Test_Assesment_Raw
group by [Member Account Code]
having sum([Sales Amt]) / 23500 > 10000 and sum([Sales Amt]) / 23500 < 25000
-- Total Sales
select sum(Total_Records)
from ( select sum([Sales Amt]) / 23500  as Total_Records
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 > 10000 and sum([Sales Amt]) / 23500 < 25000) as Sliver_Table
-- Total transactions
select sum(Total_Transactions)
from (select count(distinct Invoice) as Total_Transactions
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 > 10000 and sum([Sales Amt]) / 23500 < 25000) as S_table
-- Total Items Sold
select sum (Total_Item_sold)
from (select sum([Sales Qty]) as Total_Item_sold
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 > 10000 and sum([Sales Amt]) / 23500 < 25000) as S_table
-- Transactions with >2 items
select distinct count(*) OVER (  ) as [Total_>2_Transaction]
from SalesLT.Test_Assesment_Raw
where [Member Account Code] in (select  [Member Account Code]
                                from  SalesLT.Test_Assesment_Raw
                                group by [Member Account Code]
                                having sum([Sales Amt]) / 23500 > 10000 and sum([Sales Amt]) / 23500 < 25000)
group by Invoice
having sum([Sales Qty]) >= 2
-- ATV (Average transaction value)
select sum(Total_Records) / sum(Total_Transactions)
from ( select sum([Sales Amt]) / 23500 as Total_Records, count(distinct Invoice) as Total_Transactions
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 > 10000 and sum([Sales Amt]) / 23500 < 25000) as Platium_Table
-- UPT (Unit per transaction)
select cast(sum(Total_Item_sold) as float) / cast(sum(Total_Transactions) as float)
from (select sum([Sales Qty]) as Total_Item_sold, count(distinct Invoice) as Total_Transactions
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 > 10000 and sum([Sales Amt]) / 23500 < 25000) as PL_table

----------------------------------------------------------
-- CLIENTELING or CT ($3K - <$10K)
-- Count
select distinct count(*) OVER (  ) as Total_Records
from SalesLT.Test_Assesment_Raw
group by [Member Account Code]
having sum([Sales Amt]) / 23500 > 3000 and sum([Sales Amt]) / 23500 < 10000
-- Total Sales
select sum(Total_Records)
from ( select sum([Sales Amt]) / 23500  as Total_Records
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 > 3000 and sum([Sales Amt]) / 23500 < 10000) as CT_Table
-- Total transactions
select sum(Total_Transactions)
from (select count(distinct Invoice) as Total_Transactions
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 > 3000 and sum([Sales Amt]) / 23500 < 10000) as CT_Table
-- Total Items Sold
select sum (Total_Item_sold)
from (select sum([Sales Qty]) as Total_Item_sold
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 > 3000 and sum([Sales Amt]) / 23500 < 10000) as CT_Table
-- Transactions with >2 items
select distinct count(*) OVER (  ) as [Total_>2_Transaction]
from SalesLT.Test_Assesment_Raw
where [Member Account Code] in (select  [Member Account Code]
                                from  SalesLT.Test_Assesment_Raw
                                group by [Member Account Code]
                                having sum([Sales Amt]) / 23500 > 3000 and sum([Sales Amt]) / 23500 < 10000)
group by Invoice
having sum([Sales Qty]) >= 2
-- ATV (Average transaction value)
select sum(Total_Records) / sum(Total_Transactions)
from ( select sum([Sales Amt]) / 23500 as Total_Records, count(distinct Invoice) as Total_Transactions
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 > 3000 and sum([Sales Amt]) / 23500 < 10000) as Platium_Table
-- UPT (Unit per transaction)
select cast(sum(Total_Item_sold) as float) / cast(sum(Total_Transactions) as float)
from (select sum([Sales Qty]) as Total_Item_sold, count(distinct Invoice) as Total_Transactions
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 > 3000 and sum([Sales Amt]) / 23500 < 10000) as PL_table
----------------------------------------------------------
-- OTHERS (Spend threshold < $3K)
-- Count
select distinct count(*) OVER (  ) as Total_Records
from SalesLT.Test_Assesment_Raw
group by [Member Account Code]
having sum([Sales Amt]) / 23500 < 3000
-- Total Sales
select sum(Total_Records)
from ( select sum([Sales Amt]) / 23500  as Total_Records
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 < 3000) as O_Table
-- Total transactions
select sum(Total_Transactions)
from (select count(distinct Invoice) as Total_Transactions
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 < 3000) as O_Table
-- Total Items Sold
select sum (Total_Item_sold)
from (select sum([Sales Qty]) as Total_Item_sold
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 < 3000) as O_Table
-- Transactions with >2 items
select distinct count(*) OVER (  ) as [Total_>2_Transaction]
from SalesLT.Test_Assesment_Raw
where [Member Account Code] in (select  [Member Account Code]
                                from  SalesLT.Test_Assesment_Raw
                                group by [Member Account Code]
                                having sum([Sales Amt]) / 23500 < 3000)
group by Invoice
having sum([Sales Qty]) >= 2
-- ATV (Average transaction value)
select sum(Total_Records) / sum(Total_Transactions)
from ( select sum([Sales Amt]) / 23500 as Total_Records, count(distinct Invoice) as Total_Transactions
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 < 3000) as Platium_Table
-- UPT (Unit per transaction)
select cast(sum(Total_Item_sold) as float) / cast(sum(Total_Transactions) as float)
from (select sum([Sales Qty]) as Total_Item_sold, count(distinct Invoice) as Total_Transactions
        from  SalesLT.Test_Assesment_Raw
        group by [Member Account Code]
        having sum([Sales Amt]) / 23500 < 3000) as PL_table
----------------------------------------------------------
--Top 10 Member Account Code:	1. By Sales Quantity
select top 10 [Member Account Code], count(distinct (Invoice)) as [No_Invoice]
from SalesLT.Test_Assesment_Raw
group by [Member Account Code]
order by count(distinct (Invoice)) desc

-- Top 10 Member Account Code:	2. By Sales Amount
select top 10 [Member Account Code], sum([Sales Amt]) / 23500
from SalesLT.Test_Assesment_Raw
group by [Member Account Code]
order by sum([Sales Amt]) desc

----------------------------------------------------------
select [Member Account Code], (sum([Sales Amt]) / 23500) as Revenue_USD,
case when (sum([Sales Amt]) / 23500) >= 50000 then 'PLATIUM'
when (sum([Sales Amt]) / 23500) < 50000 and (sum([Sales Amt]) / 23500) >= 25000 then 'GOLD'
when (sum([Sales Amt]) / 23500) < 25000 and (sum([Sales Amt]) / 23500) >= 10000 then 'SLIVER'
when (sum([Sales Amt]) / 23500) < 10000 and (sum([Sales Amt]) / 23500) >= 3000 then 'CT'
else 'OTHER' end as segmentation
from SalesLT.Test_Assesment_Raw
group by [Member Account Code]
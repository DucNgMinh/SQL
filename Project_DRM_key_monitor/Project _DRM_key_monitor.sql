-- Using these databases:

-- Log_BHD_MovieID
-- Log_FimPlus_MovieID
-- Log_Get_DRM_List
-- MV_PropertiesShowVN
-- Customer
-- CustomerService

-- xác định những phim có DRM
select id
into #Is_DRM
from SalesLT.MV_PropertiesShowVN
where isDRM = 1

-- merge 2 table Film_Plus và Film_BHD
select *
into #merge_log_customer
from ((select CustomerID, MovieId, FORMAT(date, 'yyyy-MM-dd') as date
        from SalesLT.Log_Fimplus_MovieID)
        union
        (select CustomerID, MovieId, FORMAT(date, 'yyyy-MM-dd') as date
        from SalesLT.Log_BHD_MovieID)) a

-- test join
select a.date, a.Number_of_customer, b.date,  b.Number_of_customer
from    (select date, count(MovieId) as Number_of_customer
        from #merge_log_customer right join #Is_DRM on MovieId = id
        group by date) a
full join
(select Date, count(Mac) as Number_of_customer
from SalesLT.Log_Get_DRM_List
group by Date) b on a.date = b.date

-- output
select ISNULL(a.date, b.Date), ISNULL(a.Number_of_customer, 0) + ISNULL(b.Number_of_customer, 0)
from ( -- tính số lần xem phim Film_Plus và Film_BHD là DRM và groupby theo date
        select date, count(MovieId) as Number_of_customer
        from #merge_log_customer right join #Is_DRM on MovieId = id
        group by date) a
full join
    ( -- tính số lần xem phim gói là DRM
    select Date, count(Mac) as Number_of_customer
    from SalesLT.Log_Get_DRM_List
    group by Date) b on a.date = b.Date
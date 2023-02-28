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
select date, count(distinct CustomerID) as Number_of_FilmPlus
into #FilmPlus_count
from (select CustomerID, MovieId, FORMAT(date, 'yyyy-MM-dd') as date
        from SalesLT.Log_Fimplus_MovieID right join #Is_DRM on MovieId = id) a
group by date

select date, count(distinct CustomerID) as Number_of_Moive
into #BHD_Movie_count
from (select CustomerID, MovieId, FORMAT(date, 'yyyy-MM-dd') as date
        from SalesLT.Log_BHD_MovieID right join #Is_DRM on MovieId = id) a
group by date

select Date, count(distinct Mac) as Number_of_Get_DRM
into #Get_DRM_count
from SalesLT.Log_Get_DRM_List
group by Date

-- output
select ISNULL(a.DATE , #Get_DRM_count.Date), a.Number_of_FilmPlus, a.Number_of_Moive, #Get_DRM_count.Number_of_Get_DRM
from( select ISNULL(#FilmPlus_count.date, BMc.Date) as DATE, #FilmPlus_count.Number_of_FilmPlus , BMc.Number_of_Moive
    from #FilmPlus_count full join #BHD_Movie_count BMc on #FilmPlus_count.date = BMc.date) a
full join #Get_DRM_count on a.DATE = #Get_DRM_count.Date


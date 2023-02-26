SELECT top (10) * from SalesLT.Socom_1

select count(distinct [Nhà sản xuất]) from SalesLT.Socom_1

select [Nguồn lưu lượng (Traffic)], count(distinct SKU) from SalesLT.Socom_1
group by  [Nguồn lưu lượng (Traffic)]


select * from sales 

select * from SalesLT.sales_outlet

select  * from SalesLT.[sales-targets]

select SalesLT.sales_outlet.sales_outlet_id, total_goal
from SalesLT.sales_outlet left join SalesLT.[sales-targets] on sales_outlet.sales_outlet_id = [sales-targets].sales_outlet_id

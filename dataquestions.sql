-- QUERY
-- 1.Phân chia giới tính của nhân viên trong công ty
SELECT gender, count(*)
FROM HR
GROUP BY gender;

-- 2. Sự phân chia chủng tộc/sắc tộc của nhân viên trong công ty
SELECT race, count(*)
FROM HR
GROUP BY race;

-- 3. Sự phân bố độ tuổi theo giới tính của nhân viên trong công ty
SELECT 
	CASE 
		WHEN age>=18 AND age<=25 THEN '18-25'
        WHEN age>=26 AND age<=34 THEN '26-34'
        WHEN age>=35 AND age<=44 THEN '35-44'
        WHEN age>=45 AND age<=54 THEN '45-54'
        WHEN age>=55 AND age<=65 THEN '55-65'
	ELSE '65 +'
    END AS age_group,
    gender, count(*)
FROM HR
GROUP BY age_group, gender
ORDER BY age_group;

-- 4. nhân viên làm việc tại trụ sở chính so với các địa điểm ở xa
select location, count(*)
from hr
group by location;

-- 5. Thời gian làm việc trung bình của nhân viên đã bị chấm dứt là bao lâu
select round(avg(datediff(termdate,hire_date))/365, 2) as avg_length_employment
from hr;

-- 6. Sự phân bố giới tính giữa các bộ phận và chức danh công việc khác nhau như thế nào
select gender, department, count(*)
from hr
group by gender, department
order by department;

-- 7. Việc phân bổ các chức danh công việc trong công ty
select jobtitle, count(*)
from hr
group by jobtitle
order by jobtitle;

-- 8. Phòng nào có tỷ lệ nghỉ việc cao nhất
with sub as (select department,
	count(*) as total_count,
    sum(case when termdate <> curdate() then 1 else 0 end) as termdate_count
from hr
group by department)

select department,
		total_count,
        termdate_count,
        termdate_count/total_count as termdate_rate
from sub;

-- 9. Sự phân bổ nhân viên giữa các địa điểm theo  tiểu bang 
select location_state, count(*)
from hr
group by location_state
order by count(*) desc;

-- 10. Số lượng nhân viên của công ty đã thay đổi như thế nào theo thời gian dựa trên ngày kí hợp đồng và thời hạn
with sub as (select year(hire_date) as year,
		count(*) as hires,
        sum(case when termdate < curdate() then 1 else 0 end) as termnations
from hr
group by year
order by year)
select year,
		hires,
        termnations,
        hires-termnations as change_eml,
        round((hires-termnations)/hires*100, 2) as change_percent
from sub;

-- 11. Phân bổ nhiệm kỳ cho từng bộ phận như thế nào(thoiwf gian lamf vieecj trung binhf cuar nhana vieen truowcs khi ho roi ddi hoac bij sa thair)
select department,
		round(avg(datediff(curdate(),termdate)/365),0) as avg_time
from hr
where termdate < current_date()
group by department
order by avg_time desc;

        
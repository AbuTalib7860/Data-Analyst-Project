-- Data Cleaning

use world_layoffs;
select * from layoffs;

-- 1. Remove Duplicates
-- 2. Standardize Data
-- 3. Null Or Blank values
-- 4. Remove Any Columns or Rows

create table layoffs_staging like layoffs;
select * from layoffs_staging;
insert layoffs_staging select * from layoffs;

-- 1. Remove Duplicates
select *, row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date` )as row_num from layoffs_staging;

with duplicate_cte as(
select *, row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions )as row_num from layoffs_staging)
select*from duplicate_cte where row_num>1;
select * from layoffs_staging where company='Casper';
with duplicate_cte as(
select *, row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions )as row_num from layoffs_staging)
delete from duplicate_cte where row_num>1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs_staging2;
insert into layoffs_staging2 
select *, row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions )as row_num from layoffs_staging;
select * from layoffs_staging2 where row_num >1;
delete from layoffs_staging2 where row_num >1;
select * from layoffs_staging2;


-- 2. Standardize Data
select company, trim(company) from layoffs_staging2;
update layoffs_staging2 set company = trim(company);


select distinct industry from layoffs_staging2 order by 1;
select distinct industry from layoffs_staging2 where industry like 'Crypto%';
update layoffs_staging2 set industry = 'Crypto' where industry like 'Crypto%';
select distinct industry from layoffs_staging2;


select distinct location from layoffs_staging2 order by 1;

select distinct country from layoffs_staging2 order by 1;
select distinct country from layoffs_staging2 where country like 'United States%';
update layoffs_staging2 set country='United States' where country like 'United States%';


select `date` from layoffs_staging2;
select `date`, str_to_date(`date`,'%m/%d/%Y') from layoffs_staging2;
update layoffs_staging2 set `date` = str_to_date(`date`,'%m/%d/%Y');
alter table layoffs_staging2 modify column `date` date;


-- 3. Null Or Blank values

select * from layoffs_staging2;
select * from layoffs_staging2 where total_laid_off is null and percentage_laid_off is null;

select * from layoffs_staging2 where industry is null or industry ='';
select * from layoffs_staging2 where company ='Airbnb';

update layoffs_staging2 set industry = null where industry='';

select * from layoffs_staging2 t1 join layoffs_staging2 t2 
on t1.company=t2.company
 where t1.industry is null and t2.industry is not null;

update layoffs_staging2 t1 
join layoffs_staging2 t2 
on t1.company=t2.company set t1.industry=t2.industry
 where t1.industry is null  and t2.industry is not null;
 
 
 -- 4. Remove Any Columns OR Rows
 
 select * from layoffs_staging2;
select * from layoffs_staging2 where total_laid_off is null and percentage_laid_off is null;
delete from layoffs_staging2 where total_laid_off is null and percentage_laid_off is null;
alter table layoffs_staging2 drop column row_num;
 
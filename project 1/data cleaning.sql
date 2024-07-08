select * 
 from layoffs ;
 
 -- 1 remove duplicated 
 -- 2. standardize data 
 -- 3. null /blank values
 -- 4. remove any columns (not needed)
 
 
 create table layoffs_staging
 like layoffs;
 
 select * 
  from layoffs_staging;

insert layoffs_staging
select *
    from layoffs;
    
-- row_number is defined here so we can see duplicate item if exist when row_num>1 

SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company,location, industry , total_laid_off, percentage_laid_off,'date',stage , country ,funds_raised_millions) AS row_num
from layoffs_staging;

WITH duplicate_cte AS
(
 SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company,location, industry , total_laid_off, percentage_laid_off,'date',stage , country ,funds_raised_millions) AS row_num
from layoffs_staging
)

select *
from duplicate_cte
where row_num >1 ;
    
SELECT *
FROM layoffs_staging
WHERE company = 'Casper';
    
    -- new table is created where column row_num is added and duplicate is further removed 
    
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
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2  
SELECT *, 
ROW_NUMBER() OVER (
PARTITION BY company,location, industry , total_laid_off, percentage_laid_off,'date',stage , country ,funds_raised_millions) AS row_num
from layoffs_staging;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM layoffs_staging2 WHERE row_num > 1;

SET SQL_SAFE_UPDATES = 1;  -- Re-enable safe update mode



SELECT * 
FROM layoffs_staging2
WHERE row_num >1;

-- STANDARDIZING DATA
-- trim   helps to remove whitespaces at the beginning or end of the word
-- from standardizing data , data with same meaning but represented with different word should written same . for example crypto currency and cryptocurrency has same meaning. it should be written together.

SELECT company , TRIM(company)
From layoffs_staging2;

SET SQL_SAFE_UPDATES = 0;
UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT *
From layoffs_staging2
where industry like 'Crypto%';

SET SQL_SAFE_UPDATES = 0;

update layoffs_staging2
set industry = 'Crypto' 
where industry like 'Crypto%';

select  industry = 'Crypto'
from layoffs_staging2;

select distinct country 
from layoffs_staging2
order by 1;

select distinct country , trim(TRAILING '.' from country )
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(TRAILING '.' from country )
where country like 'United States%';

select distinct country 
from layoffs_staging2
order by 1;

select date,
str_to_date (date,'%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set date = str_to_date(date,'%m/%d/%Y');

select date 
from layoffs_staging2;
    
alter table layoffs_staging2 
modify column date DATE;



SET SQL_SAFE_UPDATES = 0;

update layoffs_staging2
set industry = null 
where industry = '';

select * 
from layoffs_staging2
where industry is null; 


select * 
from layoffs_staging2 t1
join layoffs_staging2 t2
   on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null ;   

update layoffs_staging2 t1
join layoffs_staging2 t2
   on t1.company = t2.company
set t1.industry = t2.industry 
where t1.industry is null 
and t2.industry is not null ;

select *
from layoffs_staging2
where company = 'Airbnb';

select * 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null; 

delete 
from layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null ;

alter table layoffs_staging2
drop column row_num;

   

-- Data Cleaning --

SELECT *
FROM layoffs;

-- CREATING DUPLICATE --
CREATE TABLE layoffs_staging
LIKE layoffs;

-- INSERTING VALUES INTO DUPLICATE TABLE FROM ORIGINAL --
INSERT INTO layoffs_staging
SELECT *
FROM layoffs;

-- ASSIGNING A ROW NUMBER TO THE COLUMNS TO FIND DUPLICATES --
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) AS row_numb
FROM layoffs_staging;

-- FINDING DUPLICATES WHERE ROW NUMB > 1 --
WITH duplicate_cte AS (
    SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, 'date', stage, 
country, funds_raised_millions) AS row_numb
FROM layoffs_staging)
SELECT *
FROM duplicate_cte
 WHERE row_numb > 1;
 
 SELECT *
 FROM layoffs_staging
 WHERE company = 'Casper';
 
 -- DELETING DUPLICATES--
 
 WITH duplicate_cte AS (
    SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, 'date', stage, 
country, funds_raised_millions) AS row_numb
FROM layoffs_staging)
SELECT *
FROM duplicate_cte
 WHERE row_numb > 1;
 
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
  row_numb INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2
WHERE row_numb > 1;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, 'date', stage, 
country, funds_raised_millions) AS row_numb
FROM layoffs_staging;

DELETE 
FROM layoffs_staging2
WHERE row_numb > 1;

SELECT *
FROM layoffs_staging2;

-- STANDARDIZATION OF THE DATA --

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

-- checking Industry --
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT  industry
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Fin-%';

UPDATE layoffs_staging2
SET industry = 'FinT'
WHERE industry LIKE 'Fin-%';

SELECT *
FROM layoffs_staging2
WHERE industry = 'FinT';

-- stardaizing Location --
SELECT  location
FROM layoffs_staging2
ORDER BY 1;

-- stardadazing country --
SELECT  DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United Sta%';

SELECT * 
FROM layoffs_staging2
where country = 'United States';

-- STARDARDIZING DATE --



SELECT `date`,
STR_TO_DATE(`date`, '%d/%m/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%d/%m/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2;

-- Removing Nulls
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

-- Populating Airbnb using a join statement -- 




-- setting blancs to nulls first --

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- select statement --
SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

-- looking up bally --

SELECT * 
FROM layoffs_staging2
WHERE company LIKE 'Bally%';

-- deleting total laid offs -- 
SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_numb;

-- Explortory Data Analysis --

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- USING ORDERBY TO CHECK TRENDS --

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC ;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC ;

-- USING GROUP BY to find what company got hit the most --
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- looking up date range --

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- what idustry got hit the most --
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- wht country got hit the most --
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- looking up the country with the most by date --

SELECT `date`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `date`
ORDER BY 1 DESC;

-- to group by YEAR FOR THE SAME DATA ABOVE --

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- grouping by STAGE --
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- Looking up percentages --

SELECT company, SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- looking up the progression of layofs using a ROLLING SUM --

SELECT SUBSTRING (`date`, 6, 2) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE  SUBSTRING (`date`, 6, 2) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

WITH Rolling_Total AS
(
SELECT SUBSTRING (`date`, 6, 2) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE  SUBSTRING (`date`, 6, 2) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off
SUM(total_off) OVER (ORDER BY `MONTH`) AS rolling_total
FROM Rolling_total;

SELECT company, `date`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, `date`
ORDER by 3 DESC;

-- Ranking which year with the most laid of employees --

WITH Company_Year (company, `date`, total_laid_off) AS
(SELECT company, `date`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, `date`
)
SELECT *, DENSE_RANK() OVER (PARTITION BY `date` ORDER BY total_laid_off DESC) AS Ranking_
FROM Company_Year
WHERE `date` IS NOT NULL
ORDER BY Ranking_ ASC;
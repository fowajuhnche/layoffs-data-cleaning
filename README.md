# layoffs-data-cleaning
SQL project for cleaning and standardizing layoffs data

🚀 Just wrapped up my first SQL data cleaning project! 🚀
Here’s what I did:
 1️⃣ Removed duplicates – Used ROW_NUMBER() to spot and clean duplicate entries.
 2️⃣ Standardized data – Cleaned up inconsistencies in company names, industries, and dates using functions like TRIM(), STR_TO_DATE(), and UPDATE.
 3️⃣ Handled missing values – Replaced blanks with NULLs and filled in missing details using JOIN operations.
 4️⃣ Tidied up the dataset – Removed extra columns that were no longer needed after cleaning.
Key SQL techniques I used:
ROW_NUMBER() to identify duplicates
JOIN to fill missing data
UPDATE for data standardization
DELETE to clean up unnecessary records


 Exploratory Data Analysis (EDA)  

The EDA phase of this project was focused on uncovering key trends and patterns in the layoffs dataset. By using SQL queries, I was able to clean, organize, and analyze the data to derive actionable insights. Below is a summary of the steps and queries used during the analysis:  

Key Objectives:  
1. Identify the industries, companies, and countries most affected by layoffs.  
2. Analyze the progression of layoffs over time using rolling sums and date grouping.  
3. Examine the relative impact on companies by calculating percentages and rankings.  

Insights Discovered:  
- Trends in Layoffs: 
  - Companies with the highest layoffs were identified using `ORDER BY` to sort by total layoffs and funds raised.  

- Industry and Geographic Impact:  
  - Using `GROUP BY`, I explored which industries and countries experienced the most layoffs, revealing clear patterns of vulnerability.  

- Time-Based Analysis: 
  - By grouping data by year and month, I created a timeline of layoffs, including rolling totals to track cumulative impacts.  

- Advanced Metrics:  
  - Implemented window functions like `DENSE_RANK` to rank years and companies based on layoffs.  
  - Analyzed percentages to highlight relative impacts on organizations.  

Sample Queries:  
Here are a few examples of the SQL queries used during EDA:  

1. Highest Layoffs by Company:
   
   SELECT company, SUM(total_laid_off)
   FROM layoffs_staging2
   GROUP BY company
   ORDER BY 2 DESC;
   ```

2. Layoffs by Year:
   
   SELECT YEAR(`date`), SUM(total_laid_off)
   FROM layoffs_staging2
   GROUP BY YEAR(`date`)
   ORDER BY 1 DESC;
  

3. Progression of Layoffs (Rolling Total):  
   
   WITH Rolling_Total AS (
       SELECT SUBSTRING (`date`, 6, 2) AS `MONTH`, SUM(total_laid_off) AS total_off
       FROM layoffs_staging2
       WHERE SUBSTRING (`date`, 6, 2) IS NOT NULL
       GROUP BY `MONTH`
   )
   SELECT `MONTH`, total_off,
       SUM(total_off) OVER (ORDER BY `MONTH`) AS rolling_total
   FROM Rolling_Total;
   

 Next Steps:  
The insights gathered from the EDA lay the foundation for visualization and storytelling. These findings can help inform stakeholders about historical trends and potential predictive models for layoffs.  



# layoffs-data-cleaning
SQL project for cleaning and standardizing layoffs data

 Data Cleaning Project
This project was my first deep dive into the data cleaning process, where I transformed raw, unstructured data into a clean, organized dataset ready for analysis. The goal was to prepare the layoffs dataset for meaningful insights by addressing inconsistencies, redundancies, and inaccuracies.

Key Objectives:
Ensure data accuracy and consistency across all fields.
Handle missing or null values while maintaining data integrity.
Standardize formats for dates, text, and numerical values.
Identify and resolve any duplicates or anomalies.
Steps Taken:
Data Preprocessing:

Standardized date formats to allow for chronological analysis.
Checked for null values in critical columns like total_laid_off and replaced them with appropriate defaults or interpolated values.
Handling Duplicates:

Identified duplicate records within the dataset and removed redundancies to ensure unique and reliable data entries.
Standardizing Values:

Cleaned inconsistent text data for company, industry, and country fields to ensure uniformity (e.g., correcting misspellings or inconsistent capitalization).
Anomaly Detection:

Used SQL queries to identify outliers in numerical fields such as total_laid_off and percentage_laid_off that could skew results.

 
 
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



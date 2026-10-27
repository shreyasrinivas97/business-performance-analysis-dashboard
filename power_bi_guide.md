# Power BI build guide

## 1. Load and prepare data
1. Open Power BI Desktop → **Get data → Text/CSV**.
2. Select `retail_sales_data.csv` → **Transform Data**.
3. Set `Order_Date` to Date; `Quantity` to Whole Number; `Unit_Price`, `Discount_Rate`, `Revenue`, `Cost`, and `Profit` to Decimal Number.
4. Check for nulls and duplicate `Order_ID`; then **Close & Apply**.

## 2. Create measures
In **Modeling → New measure**, add each measure:

```DAX
Total Revenue = SUM(retail_sales_data[Revenue])
Total Profit = SUM(retail_sales_data[Profit])
Total Orders = DISTINCTCOUNT(retail_sales_data[Order_ID])
Units Sold = SUM(retail_sales_data[Quantity])
Profit Margin % = DIVIDE([Total Profit], [Total Revenue], 0)
Average Order Value = DIVIDE([Total Revenue], [Total Orders], 0)
Total Cost = SUM(retail_sales_data[Cost])
```
Format `Profit Margin %` as Percentage (2 decimals), and currency measures as Currency. If Power BI imported the table under a different name, use that table name in the measures.

## 3. Recommended one-page layout
- **Top row:** Total Revenue, Total Profit, Profit Margin %, Total Orders, Units Sold.
- **Middle left:** Line chart — `Order_Date` (Month) on X-axis; `Total Revenue` and `Total Profit` on Y-axis.
- **Middle right:** Clustered bar chart — Category on Y-axis; Total Profit on X-axis.
- **Bottom left:** Clustered column chart — Region on X-axis; Total Revenue and Total Profit as values.
- **Bottom middle:** Bar chart — Sales_Channel and Total Revenue.
- **Bottom right:** Table with Product, Category, Units Sold, Total Revenue, Total Profit; sort by Total Revenue descending.
- Add slicers for Order_Date, Region, Category, and Sales_Channel.

## 4. Insights to look for
- Which category generates the highest revenue and which generates the highest profit?
- Which region has the strongest profit contribution?
- Are any sales channels high-revenue but low-margin?
- Do discounts appear to coincide with lower profit margins?
- Are there months with unusual sales changes?

Write conclusions only after viewing the generated report; the dataset is synthetic, so frame any findings as practice analysis rather than actual market insights.

## 5. Screenshot for your portfolio
Once your report is built, take a screenshot of the completed Power BI report and add it to the repository as `dashboard_screenshot.png`. Do not claim a Power BI dashboard is complete until you have built it in Power BI Desktop.

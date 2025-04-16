# nearest_distances
Calculate nearest distances for locations using eastings & northings using DuckDB

## Steps:
1. Download latest DuckDb version: [DuckDB](https://duckdb.org/docs/installation/)
2. Extract and save in an executable folder (e.g. c:\tmp)
3. Open command line in folder and run DuckDB. _This will use an in-memory DB_
4. Prepare your data with, at least:
   - a) An `id` key column to uniquely identify rows and join on
   - b) `easting` and `northing` columns to calculate distances
   - c) Any other columns you need, these will be exported in the results
   - Save this data in the DuckDB executable folder
5. Adjust the number of nearest matches you want using the `nearest_matches` variable
6. Copy/paste the SQL code into DuckDB and let it run. It may take a while if you have lots of records (tested with ~20k)

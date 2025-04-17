# nearest_distances
Calculate nearest distances for locations using eastings & northings using DuckDB.

The process assumes you have a set of locations and you want to match these to each other to find those which are closest together. Hence it produces the cartesian product of all locations (excluding self-matches), calculates a fairly close approximation of the distance between each combination using easting/northing references (base on Pythagoras), and then returns the N closest of these. DuckDB is used because it's faster for this sort of calculation.

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
6. Ensure the `.sql` file is in the same folder and then execute
    ```
    duckdb < duck_db_pythagoras_calculations.sql
    ```

NB: It may take a while if you have lots of records (tested with ~20k records)

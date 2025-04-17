# Nearest Distance calculations
Calculate nearest distances for locations using eastings & northings via DuckDB.

The process assumes you have a set of locations and you want to match these to each other to find those which are closest together. The SQL produces the cartesian product of all locations (excluding self-matches), calculates a pretty close approximation of the distance between each combination using easting/northing references (based on Pythagoras), and then sorts these to return the `N` closest configured using a variable. The process uses DuckDB as it's fast for these sorts of calculation.

## Steps of the process:
1. Download latest DuckDb version: [DuckDB](https://duckdb.org/docs/installation/)
2. Extract and save in an executable folder (e.g. c:\tmp)
3. Open command line in folder where DuckDB is. 
4. Prepare your data with, at least:
    - a) An `id` key column to uniquely identify the rows, and join on
    - b) `easting` and `northing` columns, used to calculate distances
    - c) Any other columns you need, and these will be re-exported in the results
    - Save this as a CSV named `matching_source.csv` in the same folder as DuckDB
5. Adjust the number of matches you want returned using the `nearest_matches` variable in the SQL file
6. Ensure the `.sql` file is in the same folder as DuckDB and then execute:
    ```
    duckdb < duck_db_pythagoras_calculations.sql
    ```
    _This will use an in-memory DB_ which ought to be fine for most cases
7. A file called `match_output_v.csv` will be created which includes all columns from the original source, plus:
    - `matched_id`, `distance_away` and `distance_order`, for each match in order
    - The number of rows returned for each location per `nearest_matches`

NB: It may take a while if you have lots of records (tested with ~20k records)

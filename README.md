# IDS Graph Visualisation

This project provides a demonstation of importing IDS data (from tools such as Silk, Bro and Snort) into a graph database (Neo4j) so that we can visually inspect the IDS data.

It's really just experimental at this stage.

# Usage

There are two stages to using this repo.
* import data from the IDS's into Neo4j
* view the data using an AngularJS2 user interface (I think it might actually be AngularJS4, but I'm new to Angular)

In short, we must transfer data from the log files into the Neo4j database. We start the database listening on the localhost on port 7474. We then fire up the UI to see the results.

See the subdirectories [ETL](etl/README.md) and [UI](ui/README.md) for more details.
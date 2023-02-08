CREATE TABLE test (
    id INTEGER NOT NULL PRIMARY KEY
);
SELECT AddGeometryColumn('test', 'shape', 2193, 'POINT', 'XY');

INSERT INTO test VALUES (1, MakePoint(1746172, 5427069, 2193));

SELECT CreateSpatialIndex('test', 'shape');

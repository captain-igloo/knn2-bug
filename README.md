KNN2 returns rows where the radius is greater than that specified.

```
$ docker build -t knn2-bug .
$ docker run knn2-bug "select * from knn2 where f_table_name = 'test' AND ref_geometry = MakePoint(1746260, 5427154) AND radius = 100 AND max_items = 1;"
```

The output is:

```
MAIN|test|shape||100.0|1|0|1|1|122.347864713692|122.347864713692
```

So the distance in this case is 122m away but the radius in the query is 100m.

If you set the radius to be smaller, the row is not included (correctly):

```
$ docker run knn2-bug "select * from knn2 where f_table_name = 'test' AND ref_geometry = MakePoint(1746260, 5427154) AND radius = 50 AND max_items = 1;"
```

See https://www.gaia-gis.it/fossil/libspatialite/tktview/6fa0670c7bdf44be72babdec1f262c59b9e697d8


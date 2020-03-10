Benchmarking raw mapping, pluck, pluck+ map, pluck_all, and pluck_to_hash in rails.

The purpose of this research is knowing which is the best for collecting records. This is still early research, will updated in the future.

I avoid `as_json` because many benchmarks have stated that `as_json` is the worst.

To reproduce the benchmark:
```
console > ActiveRecord::Base.logger.level = 1
console > Benchmarking.new.call
```
Condition:
1. 20 columns for User table
2. Ruby 2.6.5
3. Rails 6.0.2.1
4. Postgresql 9.5
5. No limit for DB query

Note:
1. The seed CSVs are in `./lib/data/*.csv`

Iteration (total records):
1. 1_000
2. 5_000
3. 10_000
4. 50_000
5. 100_000
6. 150_000

1_000 records:
```
User count: 1000

1st Benchmarking (computation time)...
Rehearsal --------------------------------------------------
map              0.098189   0.000000   0.098189 (  0.101133)
pluck            0.012563   0.000000   0.012563 (  0.013810)
pluck + map      0.021662   0.000000   0.021662 (  0.022901)
pluck_all        0.019378   0.000000   0.019378 (  0.020921)
pluck_to_hash    0.035684   0.000000   0.035684 (  0.036995)
----------------------------------------- total: 0.187476sec

                     user     system      total        real
map              0.045869   0.000000   0.045869 (  0.047465)
pluck            0.012776   0.000000   0.012776 (  0.014008)
pluck + map      0.014055   0.000000   0.014055 (  0.015537)
pluck_all        0.020234   0.000000   0.020234 (  0.021755)
pluck_to_hash    0.030284   0.000000   0.030284 (  0.031516)

2nd Benchmarking (iteration per second)...
Warming up --------------------------------------
                 map     2.000  i/100ms
               pluck     7.000  i/100ms
         pluck + map     7.000  i/100ms
           pluck_all     5.000  i/100ms
      pluck_to_hash      3.000  i/100ms
Calculating -------------------------------------
                 map     23.129  (± 4.3%) i/s -     48.000  in   2.076380s
               pluck     83.869  (± 3.6%) i/s -    168.000  in   2.005351s
         pluck + map     75.037  (± 2.7%) i/s -    154.000  in   2.053922s
           pluck_all     50.902  (± 3.9%) i/s -    105.000  in   2.064878s
      pluck_to_hash      32.004  (± 3.1%) i/s -     66.000  in   2.063071s

Comparison:
               pluck:       83.9 i/s
         pluck + map:       75.0 i/s - 1.12x  slower
           pluck_all:       50.9 i/s - 1.65x  slower
      pluck_to_hash :       32.0 i/s - 2.62x  slower
                 map:       23.1 i/s - 3.63x  slower


3rd Benchmarking (memory allocation)...
Calculating -------------------------------------
                 map     6.641M memsize (     5.469M retained)
                        65.116k objects (    63.005k retained)
                        50.000  strings (    50.000  retained)
               pluck     1.884M memsize (   888.000  retained)
                        38.154k objects (     3.000  retained)
                        50.000  strings (     1.000  retained)
         pluck + map     2.820M memsize (   888.000  retained)
                        39.155k objects (     3.000  retained)
                        50.000  strings (     1.000  retained)
           pluck_all     2.624M memsize (   928.000  retained)
                        38.334k objects (     4.000  retained)
                        50.000  strings (     1.000  retained)
      pluck_to_hash     10.654M memsize (   888.000  retained)
                       107.172k objects (     3.000  retained)
                        50.000  strings (     1.000  retained)

Comparison:
               pluck:    1884280 allocated
           pluck_all:    2624312 allocated - 1.39x more
         pluck + map:    2820320 allocated - 1.50x more
                 map:    6640992 allocated - 3.52x more
      pluck_to_hash :   10654136 allocated - 5.65x more
```

5_000 records:
```
User count: 5000

1st Benchmarking (computation time)...
Rehearsal --------------------------------------------------
map              0.299461   0.012045   0.311506 (  0.319321)
pluck            0.052265   0.004389   0.056654 (  0.060814)
pluck + map      0.068989   0.003736   0.072725 (  0.076635)
pluck_all        0.103866   0.000020   0.103886 (  0.107947)
pluck_to_hash    0.225800   0.000184   0.225984 (  0.230903)
----------------------------------------- total: 0.770755sec

                     user     system      total        real
map              0.204485   0.004047   0.208532 (  0.214788)
pluck            0.054522   0.000000   0.054522 (  0.059755)
pluck + map      0.048983   0.007579   0.056562 (  0.061417)
pluck_all        0.087587   0.003847   0.091434 (  0.096618)
pluck_to_hash    0.153479   0.000092   0.153571 (  0.158700)

2nd Benchmarking (iteration per second)...
Warming up --------------------------------------
                 map     1.000  i/100ms
               pluck     1.000  i/100ms
         pluck + map     1.000  i/100ms
           pluck_all     1.000  i/100ms
      pluck_to_hash      1.000  i/100ms
Calculating -------------------------------------
                 map      4.619  (± 0.0%) i/s -     10.000  in   2.166926s
               pluck     16.517  (± 0.0%) i/s -     34.000  in   2.059771s
         pluck + map     14.736  (± 6.8%) i/s -     30.000  in   2.044091s
           pluck_all     10.120  (± 0.0%) i/s -     21.000  in   2.076165s
      pluck_to_hash       6.586  (±15.2%) i/s -     13.000  in   2.033361s

Comparison:
               pluck:       16.5 i/s
         pluck + map:       14.7 i/s - 1.12x  slower
           pluck_all:       10.1 i/s - 1.63x  slower
      pluck_to_hash :        6.6 i/s - 2.51x  slower
                 map:        4.6 i/s - 3.58x  slower


3rd Benchmarking (memory allocation)...
Calculating -------------------------------------
                 map    33.169M memsize (    27.341M retained)
                       325.116k objects (   315.005k retained)
                        50.000  strings (    50.000  retained)
               pluck     9.372M memsize (   888.000  retained)
                       190.154k objects (     3.000  retained)
                        50.000  strings (     1.000  retained)
         pluck + map    14.052M memsize (   888.000  retained)
                       195.155k objects (     3.000  retained)
                        50.000  strings (     1.000  retained)
           pluck_all    13.040M memsize (   928.000  retained)
                       190.334k objects (     4.000  retained)
                        50.000  strings (     1.000  retained)
      pluck_to_hash     53.214M memsize (   888.000  retained)
                       535.172k objects (     3.000  retained)
                        50.000  strings (     1.000  retained)

Comparison:
               pluck:    9372280 allocated
           pluck_all:   13040288 allocated - 1.39x more
         pluck + map:   14052320 allocated - 1.50x more
                 map:   33168944 allocated - 3.54x more
      pluck_to_hash :   53214136 allocated - 5.68x more
```

10_000 records:
```
User count: 10000

1st Benchmarking (computation time)...
Rehearsal --------------------------------------------------
map              0.513401   0.013371   0.526772 (  0.540751)
pluck            0.209123   0.015730   0.224853 (  0.232538)
pluck + map      0.149200   0.004133   0.153333 (  0.164048)
pluck_all        0.172368   0.000385   0.172753 (  0.183457)
pluck_to_hash    0.298585   0.000461   0.299046 (  0.307496)
----------------------------------------- total: 1.376757sec

                     user     system      total        real
map              0.394183   0.012348   0.406531 (  0.418312)
pluck            0.101573   0.000000   0.101573 (  0.113351)
pluck + map      0.105160   0.000000   0.105160 (  0.116371)
pluck_all        0.176093   0.003510   0.179603 (  0.191376)
pluck_to_hash    0.316427   0.000000   0.316427 (  0.327497)

2nd Benchmarking (iteration per second)...
Warming up --------------------------------------
                 map     1.000  i/100ms
               pluck     1.000  i/100ms
         pluck + map     1.000  i/100ms
           pluck_all     1.000  i/100ms
      pluck_to_hash      1.000  i/100ms
Calculating -------------------------------------
                 map      2.140  (± 0.0%) i/s -      5.000  in   2.339074s
               pluck      8.738  (± 0.0%) i/s -     18.000  in   2.063371s
         pluck + map      8.124  (± 0.0%) i/s -     17.000  in   2.094784s
           pluck_all      5.338  (± 0.0%) i/s -     11.000  in   2.062006s
      pluck_to_hash       2.975  (± 0.0%) i/s -      7.000  in   2.379071s

Comparison:
               pluck:        8.7 i/s
         pluck + map:        8.1 i/s - 1.08x  slower
           pluck_all:        5.3 i/s - 1.64x  slower
      pluck_to_hash :        3.0 i/s - 2.94x  slower
                 map:        2.1 i/s - 4.08x  slower


3rd Benchmarking (memory allocation)...
Calculating -------------------------------------
                 map    66.269M memsize (    54.651M retained)
                       650.116k objects (   630.005k retained)
                        50.000  strings (    50.000  retained)
               pluck    18.732M memsize (   888.000  retained)
                       380.154k objects (     3.000  retained)
                        50.000  strings (     1.000  retained)
         pluck + map    28.092M memsize (   888.000  retained)
                       390.155k objects (     3.000  retained)
                        50.000  strings (     1.000  retained)
           pluck_all    26.030M memsize (   928.000  retained)
                       380.334k objects (     4.000  retained)
                        50.000  strings (     1.000  retained)
      pluck_to_hash    106.414M memsize (   888.000  retained)
                         1.070M objects (     3.000  retained)
                        50.000  strings (     1.000  retained)

Comparison:
               pluck:   18732280 allocated
           pluck_all:   26030184 allocated - 1.39x more
         pluck + map:   28092320 allocated - 1.50x more
                 map:   66268736 allocated - 3.54x more
      pluck_to_hash :  106414136 allocated - 5.68x more
```

50_000 records:
```
User count: 50000

1st Benchmarking (computation time)...
Rehearsal --------------------------------------------------
map              3.498618   0.072091   3.570709 (  3.617245)
pluck            0.456679   0.032203   0.488882 (  0.532634)
pluck + map      0.683851   0.027709   0.711560 (  0.750596)
pluck_all        1.198362   0.020189   1.218551 (  1.258880)
pluck_to_hash    1.603715   0.004141   1.607856 (  1.653269)
----------------------------------------- total: 7.597558sec

                     user     system      total        real
map              3.021492   0.000000   3.021492 (  3.075048)
pluck            0.461127   0.003648   0.464775 (  0.517436)
pluck + map      0.640119   0.007924   0.648043 (  0.699815)
pluck_all        0.925029   0.008374   0.933403 (  0.993112)
pluck_to_hash    1.860904   0.007895   1.868799 (  1.919054)

2nd Benchmarking (iteration per second)...
Warming up --------------------------------------
                 map     1.000  i/100ms
               pluck     1.000  i/100ms
         pluck + map     1.000  i/100ms
           pluck_all     1.000  i/100ms
      pluck_to_hash      1.000  i/100ms
Calculating -------------------------------------
                 map      0.358  (± 0.0%) i/s -      1.000  in   2.796498s
               pluck      1.859  (± 0.0%) i/s -      4.000  in   2.159543s
         pluck + map      1.321  (± 0.0%) i/s -      3.000  in   2.287014s
           pluck_all      0.956  (± 0.0%) i/s -      2.000  in   2.137202s
      pluck_to_hash       0.588  (± 0.0%) i/s -      2.000  in   3.408785s

Comparison:
               pluck:        1.9 i/s
         pluck + map:        1.3 i/s - 1.41x  slower
           pluck_all:        1.0 i/s - 1.95x  slower
      pluck_to_hash :        0.6 i/s - 3.16x  slower
                 map:        0.4 i/s - 5.20x  slower


3rd Benchmarking (memory allocation)...
Calculating -------------------------------------
                 map   331.317M memsize (   273.710M retained)
                         3.250M objects (     3.150M retained)
                        50.000  strings (    50.000  retained)
               pluck    93.612M memsize (   888.000  retained)
                         1.900M objects (     3.000  retained)
                        50.000  strings (     1.000  retained)
         pluck + map   140.412M memsize (   888.000  retained)
                         1.950M objects (     3.000  retained)
                        50.000  strings (     1.000  retained)
           pluck_all   130.075M memsize (   928.000  retained)
                         1.900M objects (     4.000  retained)
                        50.000  strings (     1.000  retained)
      pluck_to_hash    532.014M memsize (   888.000  retained)
                         5.350M objects (     3.000  retained)
                        50.000  strings (     1.000  retained)

Comparison:
               pluck:   93612280 allocated
           pluck_all:  130074528 allocated - 1.39x more
         pluck + map:  140412320 allocated - 1.50x more
                 map:  331317424 allocated - 3.54x more
      pluck_to_hash :  532014136 allocated - 5.68x more
```

100_000 records:
```
User count: 100000

1st Benchmarking (computation time)...
Rehearsal --------------------------------------------------
map              8.072061   0.231988   8.304049 (  8.414657)
pluck            1.528179   0.031877   1.560056 (  1.663788)
pluck + map      1.960579   0.024053   1.984632 (  2.114030)
pluck_all        2.015920   0.008485   2.024405 (  2.117514)
pluck_to_hash    3.702269   0.011736   3.714005 (  3.809000)
---------------------------------------- total: 17.587147sec

                     user     system      total        real
map              6.022514   0.016143   6.038657 (  6.130699)
pluck            1.111072   0.000388   1.111460 (  1.211779)
pluck + map      1.521913   0.008054   1.529967 (  1.635111)
pluck_all        2.235455   0.016092   2.251547 (  2.378318)
pluck_to_hash    3.157268   0.016195   3.173463 (  3.271163)

2nd Benchmarking (iteration per second)...
Warming up --------------------------------------
                 map     1.000  i/100ms
               pluck     1.000  i/100ms
         pluck + map     1.000  i/100ms
           pluck_all     1.000  i/100ms
      pluck_to_hash      1.000  i/100ms
Calculating -------------------------------------
                 map      0.133  (± 0.0%) i/s -      1.000  in   7.500780s
               pluck      0.795  (± 0.0%) i/s -      2.000  in   2.541874s
         pluck + map      0.602  (± 0.0%) i/s -      2.000  in   3.325233s
           pluck_all      0.394  (± 0.0%) i/s -      1.000  in   2.539895s
      pluck_to_hash       0.283  (± 0.0%) i/s -      1.000  in   3.531340s

Comparison:
               pluck:        0.8 i/s
         pluck + map:        0.6 i/s - 1.32x  slower
           pluck_all:        0.4 i/s - 2.02x  slower
      pluck_to_hash :        0.3 i/s - 2.81x  slower
                 map:        0.1 i/s - 5.97x  slower


3rd Benchmarking (memory allocation)...
Calculating -------------------------------------
                 map   662.852M memsize (   546.623M retained)
                         6.500M objects (     6.300M retained)
                        50.000  strings (    50.000  retained)
               pluck   187.212M memsize (   888.000  retained)
                         3.800M objects (     3.000  retained)
                        50.000  strings (     1.000  retained)
         pluck + map   280.812M memsize (   888.000  retained)
                         3.900M objects (     3.000  retained)
                        50.000  strings (     1.000  retained)
           pluck_all   260.242M memsize (   928.000  retained)
                         3.800M objects (     4.000  retained)
                        50.000  strings (     1.000  retained)
      pluck_to_hash      1.064B memsize (   888.000  retained)
                        10.700M objects (     3.000  retained)
                        50.000  strings (     1.000  retained)

Comparison:
               pluck:  187212280 allocated
           pluck_all:  260242064 allocated - 1.39x more
         pluck + map:  280812320 allocated - 1.50x more
                 map:  662852496 allocated - 3.54x more
      pluck_to_hash : 1064015064 allocated - 5.68x more
```
150_000 records:
```
User count: 150000

1st Benchmarking (computation time)...
Rehearsal --------------------------------------------------
map             12.840149   0.395742  13.235891 ( 13.405972)
pluck            1.716401   0.108963   1.825364 (  1.963149)
pluck + map      3.282409   0.052076   3.334485 (  3.461505)
pluck_all        3.538375   0.035789   3.574164 (  3.719665)
pluck_to_hash    5.467220   0.012392   5.479612 (  5.617068)
---------------------------------------- total: 27.449516sec

                     user     system      total        real
map             10.179698   0.047143  10.226841 ( 10.369526)
pluck            1.810056   0.019949   1.830005 (  1.976608)
pluck + map      2.511327   0.016246   2.527573 (  2.674145)
pluck_all        3.351025   0.031985   3.383010 (  3.532227)
pluck_to_hash    5.163056   0.024184   5.187240 (  5.332552)

2nd Benchmarking (iteration per second)...
Warming up --------------------------------------
                 map     1.000  i/100ms
               pluck     1.000  i/100ms
         pluck + map     1.000  i/100ms
           pluck_all     1.000  i/100ms
      pluck_to_hash      1.000  i/100ms
Calculating -------------------------------------
                 map      0.096  (± 0.0%) i/s -      1.000  in  10.440622s
               pluck      0.559  (± 0.0%) i/s -      2.000  in   3.609355s
         pluck + map      0.413  (± 0.0%) i/s -      1.000  in   2.420296s
           pluck_all      0.285  (± 0.0%) i/s -      1.000  in   3.505057s
      pluck_to_hash       0.187  (± 0.0%) i/s -      1.000  in   5.356537s

Comparison:
               pluck:        0.6 i/s
         pluck + map:        0.4 i/s - 1.35x  slower
           pluck_all:        0.3 i/s - 1.96x  slower
      pluck_to_hash :        0.2 i/s - 2.99x  slower
                 map:        0.1 i/s - 5.83x  slower


3rd Benchmarking (memory allocation)...
Calculating -------------------------------------
                 map   994.275M memsize (   819.933M retained)
                         9.750M objects (     9.450M retained)
                        50.000  strings (    50.000  retained)
               pluck   280.812M memsize (   888.000  retained)
                         5.700M objects (     3.000  retained)
                        50.000  strings (     1.000  retained)
         pluck + map   421.212M memsize (   888.000  retained)
                         5.850M objects (     3.000  retained)
                        50.000  strings (     1.000  retained)
           pluck_all   390.353M memsize (   928.000  retained)
                         5.700M objects (     4.000  retained)
                        50.000  strings (     1.000  retained)
      pluck_to_hash      1.596B memsize (     1.816k retained)
                        16.050M objects (    11.000  retained)
                        50.000  strings (     2.000  retained)

Comparison:
               pluck:  280812280 allocated
           pluck_all:  390352848 allocated - 1.39x more
         pluck + map:  421212320 allocated - 1.50x more
                 map:  994274992 allocated - 3.54x more
      pluck_to_hash : 1596015064 allocated - 5.68x more
```

Conclusion:
1. While pluck is the most powerful, it only resulting in array of array, not array of hash like we intended;
2. `pluck + map` has higher performance than `pluck_all`, but the earlier need to be configured as you can see in the `is_pluck_map` method;
3. Use `pluck_all` rather than `pluck_to_hash` if we want to use gem.
#!/bin/sh

for f in submitted/*.rb; do
  echo "Esercizio 1\n=============\n" > $f.rspec_results;
  rspec -c -r ./$f ./spec/exercise1_spec.rb >> ./$f.rspec_results;

  echo "Esercizio 2\n=============\n" >> $f.rspec_results;
  rspec -c -r ./$f ./spec/exercise2_spec.rb >> ./$f.rspec_results;

  echo "Esercizio 3\n=============\n" >> $f.rspec_results;
  rspec -c -r ./$f ./spec/exercise3_spec.rb >> ./$f.rspec_results;
done;

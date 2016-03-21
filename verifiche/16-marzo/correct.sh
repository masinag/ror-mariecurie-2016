#!/bin/sh

for f in *.rb; do
  if [[ $f != "exercise_spec.rb" ]]; then
    rspec -c -r ./$f exercise_spec.rb > ./$f.rspec_results;
  fi
done;

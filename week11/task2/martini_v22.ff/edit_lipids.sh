#!/bin/bash

if [ ! -f bck.martini_v2.0_lipids_all_201506.itp ]; then
  cp martini_v2.0_lipids_all_201506.itp bck.martini_v2.0_lipids_all_201506.itp
fi

awk '
BEGIN {
  a = 0
  r = 0
  first_a = 0
  last_a = 0
  last_b = 0
}

{
  print
}

$1 ~ /\[/ {
  r = 0
  a = 0
  f = 0
}

r > 0 && NF > 1 && ! /;/ {
  atoms[++i] = $1

  if (f < 1) {
    first_a = $1
    f = 1
  }
  if ( ($5 ~ /[CD].A/) || ($4 ~ /CH../ && $5 ~ /[RC]./) ) {
    last_a = $1
    resname = $4
  }
  if ($5 ~ /[CD].B/)
    last_b = $1
}

a > 0 && NF == 0 {
  lipid = resname == "POPC" ? "_POPC" : ""
  printf "\n#ifdef CYLINDER_RADIUS%s\n[ position_restraints ]\n", lipid
  for (j = 1; j <= i; ++j)
    printf "%6d %6d %6d %s%s %6d\n", j, 2, 8, "-CYLINDER_RADIUS", lipid, 25000
  print "#endif"

  print "\n#ifdef POSRES_HEAD_TAIL\n[ position_restraints ]"
  if (first_a > 0)
    printf "%6d %6d   %6d %6d %6d\n", first_a, 1,   0, 0, 500
  if (last_a > 0)
    printf "%6d %6d   %6d %6d %6d\n", last_a, 1,   0, 0, 500
  if (last_b > 0)
    printf "%6d %6d   %6d %6d %6d\n", last_b, 1,   0, 0, 500
  print "#endif"

  i = 0
  a = 0

  last_a = 0
  last_b = 0
}

$1 ~ /\[/ && /atoms/ {
  r = 1
}

$1 ~ /\[/ && /angles/ {
  a = 1
}

END {
  if (i > 0) {
    lipid = resname == "POPC" ? "_POPC" : ""
    printf "\n#ifdef CYLINDER_RADIUS%s\n[ position_restraints ]\n", lipid

    for (j = 1; j <= i; ++j)
      printf "%6d %6d %6d %s%s %6d\n", j, 2, 8, "-CYLINDER_RADIUS", lipid, 25000
    print "#endif"

    print "\n#ifdef POSRES_HEAD_TAIL\n[ position_restraints ]"
    printf "%6d %6d   %6d %6d %6d\n", first_a, 1,   0, 0, 500
    printf "%6d %6d   %6d %6d %6d\n", last_a, 1,   0, 0, 500
    printf "%6d %6d   %6d %6d %6d\n", last_b, 1,   0, 0, 500
    print "#endif"
  }
}

' bck.martini_v2.0_lipids_all_201506.itp > martini_v2.0_lipids_all_201506.itp

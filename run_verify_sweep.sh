#!/bin/bash
set -uo pipefail

LOCAL_LANGS="chapel d-lang erlang fortran fsharp hare idris2 lisp mercury nasm-x86_64 objective-c octave odin pascal pony prolog sml snobol4 tinygo typescript vala verilog"
REJECTED=$(grep -v '^#' /Users/timfrison/src/github.com/ofthemachine/100hellos/.rejected-languages | grep -v '^$' | tr '\n' ' ')
ROSETTA_SKIP="bqn racket csharp fsharp visual-basic mercury fortran"

is_local() { echo " $LOCAL_LANGS " | grep -q " $1 "; }
is_rejected() { echo " $REJECTED " | grep -q " $1 "; }
is_rosetta_skip() { echo " $ROSETTA_SKIP " | grep -q " $1 "; }

scripts=$(ls */fraglet/verify_*.sh 2>/dev/null | sort)
total=$(echo "$scripts" | wc -l | tr -d ' ')
pass=0 fail=0 skip=0 i=0

for script in $scripts; do
    lang=$(echo "$script" | cut -d/ -f1)
    test_type=$(basename "$script" .sh | sed 's/verify_//')
    i=$((i+1))

    if is_rejected "$lang"; then
        skip=$((skip+1))
        continue
    fi

    if is_rosetta_skip "$lang"; then
        echo -n "($i/$total) $lang/$test_type ... "
        echo "SKIP (Rosetta)"
        skip=$((skip+1))
        continue
    fi

    if is_local "$lang"; then
        tag="local"
        image="100hellos/${lang}:local"
    else
        tag="latest"
        image="100hellos/${lang}:latest"
    fi

    echo -n "($i/$total) $lang/$test_type [:$tag] ... "

    test_timeout=90
    if [ "$lang" = "tinygo" ]; then test_timeout=300; fi
    result=$(timeout $test_timeout bash "$script" "$image" 2>&1)
    rc=$?

    if [ $rc -eq 0 ] && echo "$result" | grep -q "verified"; then
        echo "PASS"
        pass=$((pass+1))
    elif [ $rc -eq 124 ]; then
        echo "TIMEOUT"
        fail=$((fail+1))
    else
        echo "FAIL (rc=$rc)"
        echo "  $(echo "$result" | tail -1)"
        fail=$((fail+1))
    fi

    # Check for dangling containers
    danglers=$(docker ps --filter "ancestor=100hellos/${lang}" -q 2>/dev/null)
    if [ -n "$danglers" ]; then
        echo "  WARNING: dangling container(s) detected, stopping..."
        docker stop $danglers >/dev/null 2>&1
        docker rm $danglers >/dev/null 2>&1
    fi
done

echo ""
echo "=== RESULTS ==="
echo "Pass: $pass  Fail: $fail  Skip: $skip  Total: $total"

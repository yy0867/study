#!/bin/bash

probno=$1

if [ -n probno ]
then
    git add "${probno}.swift"
    git commit -m "백준 ${probno} 풀이 추가"
    git push
else
    echo "Usage: bash push.sh [problem_number]"
fi

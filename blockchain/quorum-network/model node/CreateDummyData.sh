#!/bin/sh
touch MyPy.py

FILE="./MyPy.py"

/bin/cat <<EOM >$FILE
print("@@@@@@@@@@@@@@@@@@@@@")
print("GREAT")
print("@@@@@@@@@@@@@@@@@@@@@")
EOM

touch requirements.txt

FILE="./requirements.txt"

/bin/cat <<EOM >$FILE
numpy
pandas
EOM

alias flake="sudo docker run -ti --rm -v $(pwd):/apps alpine/flake8"
flake MyPy.py
echo great

sudo docker build -f dockerfile -t mytestapp .

sudo docker run -it --rm --name MyScript -v "$PWD":/usr/src/myapp mytestapp
#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WIN_GOALS OPP_GOALS
do
if [[ $YEAR != year ]]
then
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
if [[ -z $WINNER_ID ]]
then
INSERT_INTO_TEAMS_W=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
if [[ $INSERT_INTO_TEAMS == "INSERT 0 1" ]]
then
echo Inserted into teams, $WINNER
fi
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
fi
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
if [[ -z $OPPONENT_ID ]]
then
INSERT_INTO_TEAMS_O=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
if [[ $INSERT_INTO_TEAMS_W == "INSERT 0 1" ]]
then
echo Inserted into teams, $OPPONENT
fi
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
fi
INSERT_INTO_GAMES=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND',$WINNER_ID, $OPPONENT_ID, $WIN_GOALS, $OPP_GOALS)")
if [[ $INSERT_INTO_GAMES == "INSERT 0 1" ]]
then
echo Inserted into games, $ROUND, $WINNER
fi
fi
done
# Do not change code above this line. Use the PSQL variable above to query your database.

#!/bin/bash

RANDOM_NUMBER=$RANDOM
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

# Read username and get user info
READ_USERNAME() {
echo "Enter your username:"
read USERNAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME' ")

# If user exists
if [[ $USER_ID ]]
then
  	# Get user info
	echo "You exist!"
   	GAMES_PLAYED=$($PSQL "SELECT COUNT(game_id) FROM games WHERE user_id = '$USER_ID'")
   	echo -e "You have played $GAMES_PLAYED games."
   	BEST_GAME=$($PSQL "SELECT min(number_guesses) FROM games WHERE user_id = '$USER_ID'")
   	echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses"
else
   	# If not, insert user.
   	echo "Welcome, $USERNAME! It looks like this is your first time here."
   	INSERT_USER=$($PSQL "INSERT INTO users (username) VALUES ('$USERNAME');")
   	echo $INSERT_USER
fi
}


# Function to check if a value is an integer
is_integer() {
    local value=$1
    if [[ $value =~ ^[0-9]+$ ]]; then
        return 0  # It's an integer
    else
        return 1  # It's not an integer
    fi
}




#Play game
GAME() {
#Generate random number
SECRET_NUMBER=$(shuf -i 1-1000 -n 1)
echo $SECRET_NUMBER

# Ask the player to guess a number
echo "Guess the secret number between 1 and 1000:"


while true; do
    read GUESS
    
    if is_integer "$GUESS"; then
        echo "You entered: $GUESS"
        break
    else
        echo "Error: '$GUESS' is not an integer." >&2
    fi
done



# Determine number of guesses
NUMBER_OF_GUESSES=1

# While the guess isn't correct, tell the player if they're going well or not
while [ "$GUESS" -ne "$SECRET_NUMBER" ] && is_integer "$GUESS"
do
	NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES + 1))
	# Message if guess is larger than secret number
	if [ "$GUESS" -lt "$SECRET_NUMBER" ]
	then
		echo -e "Its higher than that, guess again:"
	# Message if smaller
	else
		echo -e "Its lower than that, guess again:"
	# Read new guess
	fi
	read GUESS
done

echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

INSERT_GAME_RESULT=$($PSQL "INSERT INTO games (user_id, number_guesses) VALUES ($USER_ID, $NUMBER_OF_GUESSES)")
echo $INSERT_GAME_RESULT
}


# Call the functions
READ_USERNAME
GAME

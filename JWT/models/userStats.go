package models

type UserStats struct {
	ID           int    `json:"id"`
	Wins         int    `json:"wins"`
	Losses       int    `json:"losses"`
	Skips        int    `json:"skips"`
	GamesPlayed  int    `json:"gamesPlayed"`
	RightAnswers int    `json:"right_guesses"`
	Created      string `json:"created_at"`
	Updated      string `json:"updated_at"`
}

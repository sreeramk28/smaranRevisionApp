create table FlashUsers (
	username varchar(20),
	password varchar(20),
	email varchar(30),
	name varchar(30),
	primary key(username)
);
create table Decks (
	username varchar(20),
	deckname varchar(20)
);
create table FlashDecks (
	username varchar(20),
	deckname varchar(20),
	question varchar(100),
	answer varchar(500),
	mindex int,
	primary key(username, deckname, question)
);

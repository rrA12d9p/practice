DROP TABLE IF EXISTS users;

CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	username TEXT NOT NULL UNIQUE
);

CREATE TABLE posts (
	id SERIAL PRIMARY KEY,
	body varchar(142) NOT NULL,
	user_id integer NOT NULL
)
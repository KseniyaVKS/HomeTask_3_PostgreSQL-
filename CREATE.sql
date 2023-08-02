CREATE TABLE IF NOT EXISTS Musicians (
	musician_id SERIAL PRIMARY KEY,	
	nickname VARCHAR(40) NOT NULL	
);

CREATE TABLE IF NOT EXISTS Genres (
	genre_id SERIAL PRIMARY KEY,	
	name VARCHAR(40) UNIQUE	
);

CREATE TABLE IF NOT EXISTS genre_musician (
	g_m_id SERIAL PRIMARY KEY,
	genre_id INTEGER NOT NULL REFERENCES Genres(genre_id),
	musician_id INTEGER NOT NULL REFERENCES Musicians(musician_id)
);

CREATE TABLE IF NOT EXISTS Albums (
	album_id SERIAL PRIMARY KEY,	
	name VARCHAR(40) NOT null,
	release INTEGER not null CHECK(release between 1800 and 3000)
);

CREATE TABLE IF NOT EXISTS album_musician (
	a_m_id SERIAL PRIMARY KEY,
	album_id INTEGER NOT NULL REFERENCES Albums(album_id),
	musician_id INTEGER NOT NULL REFERENCES Musicians(musician_id)
);

CREATE TABLE IF NOT EXISTS Tracks (
	track_id SERIAL PRIMARY KEY,	
	name VARCHAR(40) NOT null,
	duration INTEGER not null CHECK(duration between 10 and 9999999999),
	album_id INTEGER NOT NULL REFERENCES Albums(album_id)
);

CREATE TABLE IF NOT EXISTS Collections (
	collection_id SERIAL PRIMARY KEY,	
	name VARCHAR(40) NOT null,
	release INTEGER NOT null CHECK(release between 1800 and 3000)
);


CREATE TABLE IF NOT EXISTS track_collection (
	t_c_id SERIAL PRIMARY KEY,
	track_id INTEGER NOT NULL REFERENCES Tracks(track_id),
	collection_id INTEGER NOT NULL REFERENCES Collections(collection_id)
);

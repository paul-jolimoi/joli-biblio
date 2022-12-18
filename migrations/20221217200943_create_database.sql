CREATE TABLE jb_author (
	id_author INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    firstname VARCHAR NOT NULL,
    lastname VARCHAR NOT NULL
);

CREATE TABLE jb_reader (
	id_reader INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    firstname VARCHAR,
    lastname VARCHAR,
    email VARCHAR NOT NULL
);

CREATE TABLE jb_book (
    id_book INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR NOT NULL,
    id_author INTEGER NOT NULL,
    id_reader INTEGER,
  	FOREIGN KEY(id_author) REFERENCES jb_author(id_author),	
  	FOREIGN KEY(id_reader) REFERENCES jb_reader(id_reader)
);

INSERT INTO jb_author (firstname, lastname) VALUES ('Roger', 'Zelazny'), ('George RR', 'Martin'), ('JRR', 'Tolkien'), ('Guillermo', 'Del Toro');
INSERT INTO jb_reader (firstname, lastname, email) VALUES ('Paul', 'Fayoux', 'paul@jolimoi.com');
INSERT INTO jb_book (title, id_author) VALUES 
  ("Nine Prince in Amber", 1),
  ("A song of ice and fire", 2),
  ("The lord of the ring", 3),
  ("The strain", 4)
;
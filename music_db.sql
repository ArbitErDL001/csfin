CREATE DATABASE music_db;
USE music_db;

CREATE TABLE songs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  artist VARCHAR(150) NOT NULL,
  album VARCHAR(200),
  genre VARCHAR(100),
  release_year INT,
  duration_seconds INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO songs (title, artist, album, genre, release_year, duration_seconds) VALUES
('As the World Caves In', 'Matt Maltese', 'Bad Contestant', 'Indie Pop', 2017, 240),
('Clementine', 'Grentperez', 'Single', 'Indie Pop', 2021, 200),
('Choose Your Fighter', 'Ava Max', 'Diamonds & Dancefloors', 'Pop', 2023, 210),
('Freaks', 'Jordan Clarke', 'Single', 'Indie Pop', 2018, 190),
('I Think They Call This Love', 'Unknown Artist', 'Single', 'Pop', 2020, 200),
('Ikuyo', 'Kyle', 'Light of Mine', 'Hip Hop', 2018, 180),
('Lose Yourself', 'Eminem', '8 Mile Soundtrack', 'Hip Hop', 2002, 326),
('Love Machine', 'Jamie Page', 'Single', 'Pop', 2020, 215),
('Me and My Broken Heart', 'Rixton', 'Let the Road', 'Pop', 2014, 220),
('Multo', 'Cup of Joe', 'Single', 'OPM', 2022, 240),
('No Surprises', 'Radiohead', 'OK Computer', 'Alternative Rock', 1997, 230),
('Rolling in the Deep', 'Adele', '21', 'Soul', 2010, 228),
('Shape of You', 'Ed Sheeran', 'Divide', 'Pop', 2017, 233),
('Stairway to Heaven', 'Led Zeppelin', 'Led Zeppelin IV', 'Rock', 1971, 482),
('The Man Who Can\'t Be Moved', 'The Script', 'The Script', 'Pop Rock', 2008, 270),
('This December', 'Rick Montenegro', 'Single', 'Pop', 2021, 220),
('Uhaw', 'Dilaw', 'Single', 'OPM', 2023, 250),
('Violet\'s Tale', 'Ren', 'Single', 'Indie', 2022, 230),
('Wonderwall', 'Oasis', '(What\'s the Story) Morning Glory?', 'Britpop', 1995, 258),
('Yours', 'Jake Scott', 'Yours', 'Pop', 2018, 210);

-- Users table for application authentication
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(150) NOT NULL UNIQUE,
  password VARCHAR(64) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Example admin user (password: adminpass)
-- Password stored as SHA256 hex digest
INSERT INTO users (username, password) VALUES
('admin', '713bfda78870bf9d1b261f565286f85e97ee614efe5f0faf7c34e7ca4f65baca');
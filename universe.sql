psql --username=freecodecamp –dbname=postgres

CREATE DATABASE universe;

\c universe

CREATE TABLE star(
	star_id SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL UNIQUE,
	distance_in_light_years NUMERIC(5, 2) NOT NULL,
	brightness_of_star NUMERIC(3, 2) NOT NULL,
	approval_date DATE
);

INSERT INTO
	star(name, distance_in_light_years, brightness_of_star, approval_date) 
VALUES
	(‘Sadalsuud', 612.00, 2.90, '2016-08-21'), 
	('Hamal', 66.00, 2.01, '2016-07-20'), 
	('Arcturus', 37.00, 0.05, '2016-06-30'), 
	('Deneb Algedi', 39.00, 2.85, '2017-02-01'), 
	('Rigil Kentaurus', 4.36, 0.01, '2016-11-06'), 
	('Beta Comae Berenices', 30.00, 4.26, NULL), 
	('Regulus', 77.00, 1.36, '2016-06-30'), 
	('Aldebaran', 65.23, 0.85, '2016-06-30'), 
	('Diphda', 96.22, 2.04, '2016-08-21'), 
	('Enif', 688.20, 2.40, '2016-07-20'), 
	('Kaus Australis', 143.20, 1.85, '2016-07-20'), 
	('Rasalhague', 48.60, 2.08, '2016-07-20'), 
	('Spica', 260.90, 1.04, '2016-06-30');

CREATE TABLE constellation(
	constellation_id SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL UNIQUE, 
	year_discovered INT, 
	meaning VARCHAR(50) NOT NULL, 
	star_id INT NOT NULL
);

ALTER TABLE constellation ADD FOREIGN KEY(star_id) REFERENCES star(star_id);

INSERT INTO 
	constellation(name, year_discovered, meaning, star_id)
VALUES 
	('Aquarius', NULL, 'Water-bearer', 1), 
	('Aries', NULL, 'Ram', 2), 
	('Bootes', NULL, 'Herdsman', 3), 
	('Capricornus', NULL, 'Sea goat', 4), 
	('Centaurus', NULL, 'Centaur', 5), 
	('Cetus', NULL, 'Sea monster (later interpreted as a whale)', 9), 
	('Coma Berenices', 1536, ‘Berenice'’s hair’, 6), 
	('Leo', NULL, 'Lion', 7), 
	('Ophiuchus', NULL, 'Serpent-bearer', 12), 
	('Pegasus', NULL, 'Pegasus (mythological winged horse)', 10), 
	('Sagittarius', NULL, 'Archer', 11), 
	('Taurus', NULL, 'Bull', 8), 
	('Virgo', NULL, 'Virgin or maiden', 13);

CREATE TABLE galaxy(
	galaxy_id SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL UNIQUE, 
	meaning TEXT NOT NULL, 
	is_visible_to_naked_eye BOOLEAN NOT NULL, 
	constellation_id INT NOT NULL
); 

ALTER TABLE galaxy ADD FOREIGN KEY(constellation_id) REFERENCES constellation(constellation_id);

INSERT INTO
	galaxy(name, meaning, is_visible_to_naked_eye, constellation_id)
VALUES
	('Backward Galaxy', 'It seems to rotate in the opposite direction to what it should according to its shape.', False, 5), 
	('Centaurus A', ‘Named because it’’s located in the Centaurus constellation’, True, 5), 
	('Black Eye Galaxy', 'It looks like an eye with a dark stripe underneath', False, 7), 
	('Coma Pinwheel Galaxy', 'It looks like a paper pinwheel', False, 7), 
	('Malin 1', 'Named after its discoverer, David Malin', False, 7), 
	('Mice Galaxies', 'Two galaxies with long tails that look like a mouse', False, 7), 
	('Needle Galaxy', 'Named because of its thin appearance', False, 7), 
	('Butterfly Galaxies', 'Binary galaxies. It looks like a pair of butterfly wings', False, 13),
	('Sombrero Galaxy', 'Looks like a sombrero', False, 13), 
	('Little Sombrero Galaxy', 'It looks like a sombrero, but it’s smaller than the Sombrero Galaxy', False, 10), 
	('Milky Way', 'Our own galaxy. It is said to look like a band of light', True, 11), 
	('Wolf-Lundmark-Melotte', 'Named after the astronomers that co-discovered it', False, 6);

ALTER TABLE star ADD COLUMN galaxy_id INT REFERENCES galaxy(galaxy_id); 

UPDATE star SET galaxy_id = 11;

ALTER TABLE star ALTER COLUMN galaxy_id SET NOT NULL;

CREATE TABLE planet(
	planet_id SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL UNIQUE, 
	orbital_period_in_years NUMERIC(7, 2) NOT NULL, 
	rotation_period_in_days NUMERIC(5, 2), 
	has_moon BOOLEAN NOT NULL, 
	star_id INT NOT NULL
); 

ALTER TABLE planet ADD FOREIGN KEY(star_id) REFERENCES star(star_id);

INSERT INTO
	planet(name, orbital_period_in_years, rotation_period_in_days, has_moon, star_id)
VALUES
	('Mercury', 0.24, 58.65, False, 13), 
	('Venus', 0.62, 243.02, False, 7), 
	('Earth', 1.00, 1.00, True, 5), 
	('Mars', 1.88, 1.03, True, 8), 
	('Jupiter', 11.86, 0.41, True, 9), 
	('Saturn', 29.45, 0.44, True, 4), 
	('Uranus', 84.02, 0.72, True, 2), 
	('Neptune', 164.79, 0.67, True, 1), 
	('Ceres', 4.60, 0.38, False, 7), 
	('Orcus', 247.50, NULL, True, 11), 
	('Pluto', 247.90, 6.39, True, 11), 
	('Haumea', 283.80, 0.16, True, 3), 
	('Quaoar', 288.00, 0.37, True, 12), 
	('Makemake', 306.20, 0.95, True, 6), 
	('Gonggong', 552.50, 0.93, True, 1), 
	('Eris', 559.00, 14.56, True, 9), 
	('Sedna', 12059.00, 0.43, False, 8), 
	('Salacia', 273.98, 0.25, True, 10), 
	('Varda', 313.12, 0.23, True, 1);

CREATE TABLE moon(
	moon_id SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL UNIQUE, 
	year_discovered INT, 
	diameter_in_km INT,
	planet_id INT NOT NULL
); 

ALTER TABLE moon ADD FOREIGN KEY(planet_id) REFERENCES planet(planet_id);

INSERT INTO 
	moon(name, year_discovered, diameter_in_km, planet_id)
VALUES
	('Moon', NULL, 3476, 3), 
	('Phobos', 1877, 23, 4), 
	('Deimos', 1877, 13, 4), 
	('Io', 1610, 3630, 5), 
	('Europa', 1610, 3138, 5), 
	('Ganymede', 1610, 5262, 5), 
	('Callisto', 1610, 4800, 5), 
	('Amalthea', 1892, 200, 5), 
	('Himalia', 1904, 170, 5), 
	('Thebe', 1979, 90, 5), 
	('Mimas', 1789, 394, 6), 
	('Enceladus', 1789, 502, 6), 
	('Tethys', 1684, 1048, 6), 
	('Dione', 1684, 1120, 6), 
	('Rhea', 1672, 1530, 6), 
	('Titan', 1655, 5150, 6), 
	('Hyperion', 1848, 270, 6), 
	('Iapetus', 1671, 1435, 6), 
	('Phoebe', 1899, 220, 6), 
	('Janus', 1966, 190, 6), 
	('Epimetheus', 1966, 120, 6), 
	('Atlas', 1980, 40, 6), 
	('Prometheus', 1980, 80, 6), 
	('Pandora', 1980, 100, 6), 
	('Pan', 1990, 20, 6), 
	('Ariel', 1851, 1160, 7), 
	('Umbriel', 1851, 1190, 7), 
	('Titania', 1787, 1610, 7), 
	('Oberon', 1787, 1550, 7), 
	('Miranda', 1948, 485, 7), 
	('Puck', 1985, 170, 7), 
	('Triton', 1846, 2720, 8), 
	('Nereid', 1949, 340, 8), 
	('Despina', 1989, 150, 8), 
	('Galatea', 1989, 150, 8), 
	('Larissa', 1981, 400, 8), 
	('Vanth', 2005, NULL, 10), 
	('Charon', 1978, 1200, 11), 
	('Nix', 2005, 46, 11), 
	('Hydra', 2005, 61, 11), 
	('Kerberos', 2011, 28, 11), 
	('Styx', 2012, 20, 11), 
	('Actaea', 2006, NULL, 18), 
	(“Hi’iaka”, 2005, 400, 12), 
	('Namaka', 2005, 200, 12), 
	('Weywot', 2007, NULL, 13), 
	('Ilmare', 2009, NULL, 19), 
	('Xiangliu', 2010, NULL, 15), 
	('Dysnomia', 2005, 684, 16), 
	('MK2', 2016, 160, 14);
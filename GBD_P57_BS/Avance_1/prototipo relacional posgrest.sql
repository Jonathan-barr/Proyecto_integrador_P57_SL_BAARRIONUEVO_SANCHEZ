
CREATE TABLE locaciones (
                id_locaciones VARCHAR(10) NOT NULL,
                paises VARCHAR(60) NOT NULL,
                CONSTRAINT locaciones_pk PRIMARY KEY (id_locaciones)
);


CREATE TABLE cast (
                id_actores VARCHAR(10) NOT NULL,
                nombres VARCHAR(100) NOT NULL,
                CONSTRAINT cast_pk PRIMARY KEY (id_actores)
);


CREATE TABLE director (
                id_director VARCHAR(10) NOT NULL,
                director VARCHAR(40) NOT NULL,
                CONSTRAINT director_pk PRIMARY KEY (id_director)
);


CREATE TABLE titulos_netflix (
                show_id VARCHAR(10) NOT NULL,
                tittle VARCHAR(40) NOT NULL,
                date_added DATE NOT NULL,
                type VARCHAR(10) NOT NULL,
                rating VARCHAR(10) NOT NULL,
                release_year INTEGER NOT NULL,
                listed_in VARCHAR(40) NOT NULL,
                duration VARCHAR(15) NOT NULL,
                description VARCHAR(300) NOT NULL,
                id_director VARCHAR NOT NULL,
                id_actores VARCHAR NOT NULL,
                id_locaciones VARCHAR NOT NULL,
                CONSTRAINT titulos_netflix_pk PRIMARY KEY (show_id)
);


ALTER TABLE titulos_netflix ADD CONSTRAINT country_titulos_netflix_fk
FOREIGN KEY (id_locaciones)
REFERENCES locaciones (id_locaciones)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE titulos_netflix ADD CONSTRAINT actores_titulos_netflix_fk
FOREIGN KEY (id_actores)
REFERENCES cast (id_actores)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE titulos_netflix ADD CONSTRAINT director_titulos_netflix_fk
FOREIGN KEY (id_director)
REFERENCES director (id_director)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

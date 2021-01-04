
CREATE TABLE dim_director (
                sk_director VARCHAR(10) NOT NULL,
                pk_id_director VARCHAR(10) NOT NULL,
                version INTEGER NOT NULL,
                Valido_Hasta DATE NOT NULL,
                Valido_Desde DATE NOT NULL,
                director VARCHAR(40) NOT NULL,
                CONSTRAINT dim_director_pk PRIMARY KEY (sk_director)
);


CREATE TABLE dim_cast (
                sk_cast VARCHAR(10) NOT NULL,
                pk_id_actores VARCHAR(10) NOT NULL,
                version INTEGER NOT NULL,
                Valido_Hasta DATE NOT NULL,
                Valido_Desde DATE NOT NULL,
                nombres VARCHAR(100) NOT NULL,
                CONSTRAINT dim_cast_pk PRIMARY KEY (sk_cast)
);


CREATE TABLE dim_locaciones (
                sk_locaciones VARCHAR(10) NOT NULL,
                pk_id_locaciones VARCHAR(10) NOT NULL,
                version INTEGER NOT NULL,
                Valido_Hasta DATE NOT NULL,
                Valido_Desde DATE NOT NULL,
                paises VARCHAR(60) NOT NULL,
                CONSTRAINT dim_locaciones_pk PRIMARY KEY (sk_locaciones)
);


CREATE TABLE titulos_netflix (
                sk_locaciones VARCHAR(10) NOT NULL,
                sk_director VARCHAR(10) NOT NULL,
                sk_cast VARCHAR(10) NOT NULL,
                show_id VARCHAR(10) NOT NULL,
                tittle VARCHAR(40) NOT NULL,
                date_added DATE NOT NULL,
                type VARCHAR(10) NOT NULL,
                rating VARCHAR(10) NOT NULL,
                release_year INTEGER NOT NULL,
                listed_in VARCHAR(40) NOT NULL,
                duration VARCHAR(15) NOT NULL,
                description VARCHAR(300) NOT NULL,
                CONSTRAINT titulos_netflix_pk PRIMARY KEY (sk_locaciones, sk_director, sk_cast, show_id)
);


ALTER TABLE titulos_netflix ADD CONSTRAINT director_titulos_netflix_fk
FOREIGN KEY (sk_director)
REFERENCES dim_director (sk_director)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE titulos_netflix ADD CONSTRAINT actores_titulos_netflix_fk
FOREIGN KEY (sk_cast)
REFERENCES dim_cast (sk_cast)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE titulos_netflix ADD CONSTRAINT country_titulos_netflix_fk
FOREIGN KEY (sk_locaciones)
REFERENCES dim_locaciones (sk_locaciones)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

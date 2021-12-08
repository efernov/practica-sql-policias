DROP TABLE POLICIA CASCADE CONSTRAINTS;
CREATE TABLE POLICIA(
codigo_p NUMBER(5) PRIMARY KEY,
nombre_p VARCHAR2(20) NOT NULL,
categoria NUMBER(30) NOT NULL,
funcion VARCHAR2(15),
jefe VARCHAR2(20),
CONSTRAINT categoriaNumber CHECK (categoria BETWEEN 1 AND 30),
CONSTRAINT jefenomismo CHECK (jefe!= nombre_p),
CONSTRAINT tipofuncion CHECK (funcion IN ('administrativo','detective','patrulla'))
);



CREATE TABLE ARMA (
codigo_a CHAR(5),
antiguedad DATE NOT NULL,
clase VARCHAR2(9) NOT NULL,
cod_policia NUMBER(5),
habilidad NUMBER(10),
PRIMARY KEY (codigo_a)
);

ALTER TABLE ARMA
ADD CONSTRAINT añadoupdate FOREIGN KEY (clase) REFERENCES CLASE (nombre);



CREATE TABLE CLASE (
nombre VARCHAR2(9) PRIMARY KEY,
peso NUMBER(4, 2)
);

ALTER TABLE CLASE
MODIFY nombre VARCHAR2(11);

CREATE TABLE DELINCUENTE (
DNI VARCHAR2(10) PRIMARY KEY,
nombre_d VARCHAR2(20),
apodo VARCHAR2(15),
descripcion VARCHAR2(40),
telefono NUMBER(9)
);

CREATE TABLE CASO (
codigo_c NUMBER(5) PRIMARY KEY,
descripcion VARCHAR2(30),
juzgado NUMBER(15) NOT NULL,
estado CHAR(7), 
CONSTRAINT numberJuzgado CHECK (juzgado BETWEEN 1 AND 15),
CONSTRAINT abierto_cerrado CHECK (estado IN('abierto','cerrado'))
);

CREATE TABLE INVOLUCRADO (
DNI_D VARCHAR2(10),
cod_caso NUMBER(5),
cargo VARCHAR2(9),
CONSTRAINT ClavePrimaria PRIMARY KEY (DNI_D, cod_caso),
CONSTRAINT fKDNI FOREIGN KEY (DNI_D) REFERENCES DELINCUENTE (DNI) ON DELETE CASCADE,
CONSTRAINT fkcod FOREIGN KEY (cod_caso) REFERENCES CASO (codigo_c) ON DELETE CASCADE,
CONSTRAINT tipocargo CHECK (cargo IN ('robo', 'hurto', 'homicidio', 'asesinato'))
);

CREATE TABLE INVESTIGA (
cod_policia NUMBER(5),
cod_caso NUMBER(5),
CONSTRAINT PKinvestiga PRIMARY KEY (cod_policia, cod_caso),
CONSTRAINT fkcod_pol FOREIGN KEY (cod_policia) REFERENCES POLICIA (codigo_p) ON DELETE CASCADE,
CONSTRAINT fkcod_caso FOREIGN KEY (cod_caso) REFERENCES CASO (codigo_c) ON DELETE CASCADE
);


SELECT * FROM POLICIA;

INSERT INTO POLICIA (codigo_p, nombre_p, categoria, funcion) VALUES 
(12345, 'Peláez', 20, 'administrativo');

INSERT INTO POLICIA (codigo_p, nombre_p, categoria, funcion) VALUES 
(12346, 'Baretta', 8, 'detective');

INSERT INTO POLICIA (codigo_p, nombre_p, categoria, funcion) VALUES
(12347, 'Romerales', 2, 'patrulla');

INSERT INTO POLICIA (codigo_p, nombre_p, categoria, funcion) VALUES
(12348, 'Peralta', 14, 'administrativo');

INSERT INTO POLICIA (codigo_p, nombre_p, categoria, funcion) VALUES
(12349, '86', 23, 'detective');

UPDATE policia
SET jefe = 'Baretta'
WHERE nombre_p = 'Romerales';

UPDATE policia
SET jefe = 'Baretta'
WHERE nombre_p = '86';

UPDATE policia
SET jefe = 'Peláez'
WHERE nombre_p = 'Peralta';

INSERT INTO CLASE 
VALUES ('Mosqueton', 12.5);

INSERT INTO CLASE
VALUES ('Pistola', 1.7); 

INSERT INTO CLASE
VALUES ('Metralleta', 15.4);

INSERT INTO CLASE
VALUES ('Ballesta', 9.25);

INSERT INTO CLASE
VALUES ('Bazooka', 20.8);

SELECT * FROM CLASE;

SELECT * FROM ARMA;

INSERT INTO ARMA (codigo_a, antiguedad, clase) VALUES (11111, TO_DATE('10/12/1945','DD/MM/YYYY'), 'Pistola');

INSERT INTO ARMA (codigo_a, antiguedad, clase) VALUES
(22222, TO_DATE('07/03/1980', 'DD/MM/YYYY'), 'Pistola');

INSERT INTO ARMA (codigo_a, antiguedad, clase) VALUES
(33333, to_date('20/01/1901', 'DD/MM/YYYY'), 'Mosqueton');

INSERT INTO ARMA (codigo_a, antiguedad, clase) VALUES
(44444, to_date('25/05/2003', 'DD/MM/YYYY'), 'Bazooka');

INSERT INTO ARMA (codigo_a, antiguedad, clase) VALUES
(55555, to_date('01/01/1899', 'DD/MM/YYYY'), 'Ballesta');

UPDATE ARMA
SET cod_policia = 12346
WHERE codigo_a = 11111;

UPDATE ARMA
SET cod_policia = 12346
WHERE codigo_a = 44444;

UPDATE ARMA
SET cod_policia = 12349
WHERE codigo_a = 22222;

UPDATE ARMA
SET cod_policia = 12347
WHERE codigo_a = 33333;

UPDATE ARMA
SET cod_policia = 12347
WHERE codigo_a = 55555;

UPDATE ARMA
SET habilidad = 9
WHERE cod_Policia = 12346 AND codigo_a = 44444;

UPDATE ARMA
SET habilidad = 3
WHERE cod_Policia = 12346 AND codigo_a = 11111;

UPDATE ARMA
SET habilidad = 1
WHERE cod_Policia = 12349 AND codigo_a = 22222;

UPDATE ARMA
SET habilidad = 4
WHERE cod_Policia = 12347 AND codigo_a = 55555;

UPDATE ARMA
SET habilidad = 3
WHERE cod_Policia = 12347 AND codigo_a = 33333;

SELECT* FROM DELINCUENTE;

INSERT INTO DELINCUENTE (DNI, nombre_d) VALUES
(12345678, 'Juan Pérez');

INSERT INTO DELINCUENTE (DNI, nombre_d, apodo, descripcion) VALUES
(23456789, 'Antonio Bautista', 'Quebrantahuesos', 'Ex-boxeador');

INSERT INTO DELINCUENTE (DNI, nombre_d, apodo, descripcion) VALUES
(34567890, 'Maria Amparo Peña', 'Mascarilla', 'Tiene 7 nietos y 2 bisnietos');

INSERT INTO DELINCUENTE (DNI, nombre_d, apodo, descripcion) VALUES
(45678901, 'Benito Laden', 'Barbitas', 'Sin noticias de él desde hace tiempo');

INSERT INTO DELINCUENTE (DNI, nombre_d, apodo, telefono) VALUES
(56789012, 'Malo Maloso', 'Cocacolo', 5551234);

INSERT INTO CASO (codigo_c, descripcion, juzgado, estado) VALUES 
(12345, 'Robobo de la Jojoya', 1, 'cerrado');

INSERT INTO CASO (codigo_c, descripcion, juzgado, estado) VALUES 
(23456, 'Robo de Portatil', 2, 'cerrado');

INSERT INTO CASO (codigo_c, descripcion, juzgado, estado) VALUES 
(34567, 'Madrid Connection', 1, 'abierto');

INSERT INTO CASO (codigo_c, descripcion, juzgado, estado) VALUES 
(45678, 'Tormenta Mostoleña', 4, 'abierto');

INSERT INTO CASO (codigo_c, descripcion, juzgado, estado) VALUES 
(56789, 'Pintadas en Universidad', 4, 'abierto');

SELECT * FROM CASO;

UPDATE CASO
SET estado = 'abierto'
WHERE codigo_c = 45678;

INSERT INTO INVOLUCRADO (DNI_D, cod_caso, cargo) VALUES
(45678901, 45678, 'asesinato');

INSERT INTO INVOLUCRADO (DNI_D, cod_caso, cargo) VALUES
(56789012, 45678, 'asesinato');

INSERT INTO INVOLUCRADO (DNI_D, cod_caso, cargo) VALUES
(23456789, 12345, 'robo');

INSERT INTO INVOLUCRADO (DNI_D, cod_caso, cargo) VALUES
(34567890, 23456, 'robo');

INSERT INTO INVOLUCRADO (DNI_D, cod_caso, cargo) VALUES
(34567890, 34567, 'hurto');

UPDATE INVOLUCRADO
SET cargo = 'homicidio'
WHERE cod_caso = 34567 AND dni_d = 23456789;

SELECT * FROM INVOLUCRADO;

INSERT INTO INVESTIGA (cod_policia, cod_caso) VALUES 
(12345, 12345);

INSERT INTO INVESTIGA (cod_policia, cod_caso) VALUES 
(12345, 23456);

INSERT INTO INVESTIGA (cod_policia, cod_caso) VALUES 
(12345, 34567);

INSERT INTO INVESTIGA (cod_policia, cod_caso) VALUES 
(12345, 45678);

INSERT INTO INVESTIGA (cod_policia, cod_caso) VALUES 
(12345, 56789);

INSERT INTO INVESTIGA (cod_policia, cod_caso) VALUES 
(12348, 12345);

INSERT INTO INVESTIGA (cod_policia, cod_caso) VALUES 
(12346, 23456);

INSERT INTO INVESTIGA (cod_policia, cod_caso) VALUES 
(12346, 56789);

INSERT INTO INVESTIGA (cod_policia, cod_caso) VALUES 
(12347, 23456);

INSERT INTO INVESTIGA (cod_policia, cod_caso) VALUES 
(12347, 56789);

INSERT INTO INVESTIGA (cod_policia, cod_caso) VALUES 
(12349, 12345);

INSERT INTO INVESTIGA (cod_policia, cod_caso) VALUES 
(12349, 34567);

INSERT INTO INVESTIGA (cod_policia, cod_caso) VALUES 
(12349, 45678);

INSERT INTO INVESTIGA (cod_policia, cod_caso) VALUES 
(12349, 56789);

SELECT * FROM INVESTIGA;

UPDATE POLICIA
SET jefe = 'Baretta'
WHERE nombre_p = 'Baretta';

ALTER TABLE POLICIA
DROP CONSTRAINT jefenomismo;

ALTER TABLE POLICIA
ADD CONSTRAINT jefenomismo CHECK (jefe!= 'Romerales');

SELECT * FROM POLICIA;

//3.2 Dos delincuentes no pueden tener el mismo apodo

ALTER TABLE DELINCUENTE
ADD CONSTRAINT mismoApodo CHECK (apodo!= apodo);

//3.3 insertar nuevo delincuente y deshabilitar restricción anterior



//3.4 modificar el esquema para guardar telefono movil polcias

ALTER TABLE POLICIA
ADD Tel_movil NUMBER(10); 

UPDATE POLICIA
SET Tel_movil = 665257325
WHERE nombre_p = 'Baretta';

//4.- Modifique la categoria de los policias, de tal forma que se incremente 
en 1 la de aquellos cuya categoria esté por debajo de la media.

UPDATE POLICIA
SET categoria = categoria + 1
WHERE categoria < ( SELECT AVG(categoria) FROM POLICIA);

//5.- Elimine los delincuentes no implicados en ningun caso

DELETE FROM DELINCUENTE
WHERE NOT EXIST (SELECT *
        FROM DELINCUENTE, INVOLUCRADO
        WHERE (DNI = DNI_D));

SELECT *
FROM DELINCUENTE , INVOLUCRADO
WHERE (DNI = DNI_D);

//6.-Cree una vista con dos columnas 

CREATE VIEW JUZGADO_CASO_ABIERTO
AS (SELECT juzgado, COUNT(estado) AS numero_casos_abiertos 
    FROM CASO
    WHERE (estado = 'abierto')
    GROUP BY juzgado);
    
SELECT * FROM JUZGADO_CASO_ABIERTO;

//inserte un nuevo juzgado en la vista

INSERT INTO JUZGADO_CASO_ABIERTO (juzgado, numero_casos_abiertos)
VALUES (3, 2);  //nO PERMITE INSERCIONES "virtual column not allowed here"

//7.1- Nombres de policias aue investigan casos que lleva el juzgado nº 4

SELECT nombre_p
FROM POLICIA, INVESTIGA, CASO
WHERE codigo_p = cod_policia AND cod_caso = codigo_c AND juzgado = 4;

//7.2- Clases de Armas que no tiene nadie asignadas

SELECT nombre
FROM CLASE JOIN ARMA
ON nombre = clase;


SELECT nombre
FROM CLASE
WHERE nombre NOT EXIST (SELECT nombre
                FROM CLASE JOIN ARMA
                ON nombre = clase);


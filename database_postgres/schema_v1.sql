-- Database: mande_db

-- DROP DATABASE mande_db;

CREATE DATABASE mande_db
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    TEMPLATE template0;

\c mande_db


CREATE TABLE medio_pago (
	id SERIAL PRIMARY KEY,
	numero_cuenta INT,
	tipo VARCHAR(35),
	fecha_expiracion DATE,
    cvc INT check (cvc <= 3),
    creado timestamp,
    actualizado timestamp
);

CREATE TABLE disponibilidad (
    id SERIAL PRIMARY KEY,
    estado boolean default 0,
    creado timestamp,
    actualizado timestamp
);

CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    medio_pago_id INT,
    nombre VARCHAR(45),
    apellido VARCHAR(45),
    tipo_documento VARCHAR(45),
    numero_documento INT,
    fecha_nacimiento DATE,
    email VARCHAR(50),
    direccion VARCHAR(50),
    foto_perfil VARCHAR(100),
    num_celular INT,
    imagen_recibo VARCHAR(100),
    CONSTRAINT fk_medio_pago
    FOREIGN KEY (medio_pago_id) 
        REFERENCES medio_pago(id),
    creado timestamp,
    actualizado timestamp
);

CREATE TABLE trabajador (
    id SERIAL PRIMARY KEY,
    medio_pago_id INT,
    disponibilidad_id INT,
    nombre VARCHAR(45),
    apellido VARCHAR(45),
    tipo_documento VARCHAR(45),
    numero_documento INT,
    fecha_nacimiento DATE,
    email VARCHAR(50),
    direccion VARCHAR(50),
    foto_perfil VARCHAR(100),
    num_celular INT,
    imagen_documento VARCHAR(100),
    CONSTRAINT fk_medio_pago
    FOREIGN KEY (medio_pago_id) 
        REFERENCES medio_pago(id),
    creado timestamp,
    actualizado timestamp
);

CREATE TABLE labor (
	id SERIAL PRIMARY KEY,
    nombre VARCHAR(45),
    descripcion VARCHAR(150),
    creado timestamp,
    actualizado timestamp
);

CREATE TABLE labor_trabajador (
    id SERIAL PRIMARY KEY,
    labor_id int,
    trabajador_id int,
    CONSTRAINT fk_trabajador
    FOREIGN KEY (trabajador_id) 
        REFERENCES trabajador(id),
    CONSTRAINT fk_labor
    FOREIGN KEY (labor_id) 
        REFERENCES labor(id),
    creado timestamp,
    actualizado timestamp
);

CREATE TABLE pago (
    id SERIAL PRIMARY KEY,
    cliente_id INT,
    fecha DATE,
    monto INT,
    CONSTRAINT fk_cliente
    FOREIGN KEY (cliente_id) 
        REFERENCES cliente(id),
    actualizado timestamp
);

CREATE TABLE servicio (
    id SERIAL PRIMARY KEY,
    descripcion VARCHAR(150),
    fecha DATE,
    monto INT,
    pago_id INT,
    trabajador_id INT,
    cliente_id INT,
    CONSTRAINT fk_trabajador
    FOREIGN KEY (trabajador_id) 
        REFERENCES trabajador(id),
    CONSTRAINT fk_cliente
    FOREIGN KEY (cliente_id) 
        REFERENCES cliente(id),
    CONSTRAINT fk_pago
    FOREIGN KEY (pago_id) 
        REFERENCES pago(id),
    actualizado timestamp
);

CREATE TABLE calificacion (
    id SERIAL PRIMARY KEY,
    valor INT,
    servicio_id INT,
    trabajador_id INT,
    cliente_id INT,
    CONSTRAINT fk_servicio
    FOREIGN KEY (servicio_id) 
        REFERENCES servicio(id),
    CONSTRAINT fk_trabajador
    FOREIGN KEY (trabajador_id) 
        REFERENCES trabajador(id),
    CONSTRAINT fk_cliente
    FOREIGN KEY (cliente_id) 
        REFERENCES cliente(id),
    creado timestamp,
    actualizado timestamp
);
-- 
-- Modelo de base de datos para PostgreSQL
--

BEGIN TRANSACTION;

--
-- Usuarios
-- Esta tabla es para personalización
--
DROP TABLE IF EXISTS usuarios CASCADE;
CREATE TABLE usuarios (
    pk bigserial NOT NULL,
    nombres varchar(255),
    apellidos varchar(255),
    fecha_nacimiento date,
    genero int NOT NULL DEFAULT '0',
    facebook varchar(255),
    email varchar(255),
    password varchar(255),
    UNIQUE (email),
    PRIMARY KEY (pk)
);


--
-- Tipo de Comercio
-- Mecanismo para clasificar los comercios
-- 
DROP TABLE IF EXISTS tipos_comercios CASCADE;
CREATE TABLE tipos_comercios (
    pk serial NOT NULL,
    nombre varchar(255) NOT NULL,
    descripcion text,
    UNIQUE (nombre),
    PRIMARY KEY (pk)
);

--
-- Comercio
-- Esta tabla está pensada para centralizar las tiendas departamentales
-- por ejemplo Falabella
--
DROP TABLE IF EXISTS comercios CASCADE;
CREATE TABLE comercios (
    pk serial NOT NULL,
    nombre_fantasia varchar(255) NOT NULL,
    razon_social varchar(255) NOT NULL,
    rut int NOT NULL,
    facebook varchar(255),
    twitter varchar(255),
    UNIQUE (rut),
    PRIMARY KEY (pk)
);

--
-- Tiendas
-- Esta tabla existe para detallar cada tienda, si es monotienda 
-- tendrá un comercio y una tienda.
--
DROP TABLE IF EXISTS tiendas CASCADE;
CREATE TABLE tiendas (
    pk bigserial NOT NULL,
    comercio_fk int NOT NULL REFERENCES comercios(pk) ON UPDATE CASCADE ON DELETE CASCADE,
    latitud double precision NOT NULL,
    longitud double precision NOT NULL,
    telefono varchar(255) NOT NULL,
    direccion text,
    valoracion real NOT NULL DEFAULT '0',
    UNIQUE (comercio_fk, latitud, longitud),
    PRIMARY KEY (pk)
);


--
-- Roles
-- Roles genérico para backend
--
DROP TABLE IF EXISTS roles CASCADE;
CREATE TABLE roles (
        pk serial NOT NULL,
        nombre varchar(255) NOT NULL,
        descripcion text,
        UNIQUE(nombre),
        PRIMARY KEY (pk)
);


--
-- Roles Usuarios
--
DROP TABLE IF EXISTS roles_usuarios CASCADE;
CREATE TABLE roles_usuarios (
        pk bigserial NOT NULL,
        usuario_fk int NOT NULL REFERENCES usuarios(pk) ON UPDATE CASCADE ON DELETE CASCADE,
        rol_fk int NOT NULL REFERENCES roles(pk) ON UPDATE CASCADE ON DELETE CASCADE,
        UNIQUE (usuario_fk, rol_fk),
        PRIMARY KEY (pk)
);

-- Instalar cómo super usuario la extensión:
-- CREATE EXTENSION cube;
-- CREATE EXTENSION earthdistance;

COMMIT;

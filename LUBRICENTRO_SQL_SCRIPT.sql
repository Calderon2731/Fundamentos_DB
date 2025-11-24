------------------ CREACION Y USO DE LA BASE DE DATOS ------------------

CREATE DATABASE LUBRICENTRO_LOS_ANGELES;

USE LUBRICENTRO_LOS_ANGELES;


---------------------------------------------------------------------------
---------------------------- CREACION TABLAS ------------------------------
---------------------------------------------------------------------------

------------------ TIPO CLIENTE ------------------

CREATE TABLE TIPO_CLIENTE(
    id_tipo_cliente INT IDENTITY (1,1),
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('frecuente','ocasional')),
    CONSTRAINT PK_TIPO_CLIENTE PRIMARY KEY (id_tipo_cliente)
);

CREATE TABLE CLIENTE(
id_cliente INT IDENTITY (1,1),
id_tipo_cliente INT  NOT NULL, --FK
nombre VARCHAR(20) NOT NULL,
apellido_1 VARCHAR(20) NOT NULL,
apellido_2 VARCHAR(20) NOT NULL,
CONSTRAINT PK_CLIENTE PRIMARY KEY (id_cliente),
CONSTRAINT FK_TIPO_CLIENTE_CLIENTE FOREIGN KEY (id_tipo_cliente) REFERENCES TIPO_CLIENTE (id_tipo_cliente)
);

---TELEFONOS DE LOS CLIENTES
CREATE TABLE TELEFONOS_CLIENTE(
id_telefono_cliente INT IDENTITY (1,1),
telefono VARCHAR(20) NOT NULL,
CONSTRAINT PK_TELEFONOS_CLIENTE PRIMARY KEY(id_telefono_cliente)
);
---TABLA INTERMEDIA
CREATE TABLE TELEFONO_CLIENTE_CLIENTE(
id_telefono_cliente_cliente  INT IDENTITY(1,1) ,
id_telefono_cliente INT NOT NULL,
id_cliente INT NOT NULL,
CONSTRAINT PK_TELEFONO_CLIENTE_CLIENTE PRIMARY KEY(id_telefono_cliente_cliente),
CONSTRAINT FK_TELEFONOS_CLIENTE FOREIGN KEY (id_telefono_cliente) REFERENCES TELEFONOS_CLIENTE(id_telefono_cliente),
CONSTRAINT FK_CLIENTE_TELEFONO FOREIGN KEY (id_Cliente) REFERENCES CLIENTE(id_cliente)
);

---TABLA DE CORREO ELECTRONICO
CREATE TABLE CORREOS_CLIENTES(
id_correos_cliente INT IDENTITY (1,1),
correo_electronico VARCHAR(100) NOT NULL,
CONSTRAINT PK_CORREOS_CLIENTES PRIMARY KEY (id_correos_cliente)
);
---TABLA INTERMEDIA DE CORREOS ELECTRONICOS
CREATE TABLE CORREOS_CLIENTES_CLIENTE(
id_correos_cliente_cliente INT IDENTITY (1,1) ,
id_cliente INT NOT NULL,
id_correos_cliente INT NOT NULL,
CONSTRAINT PK_CORREOS_CLIENTES_CLIENTES PRIMARY KEY(id_correos_cliente_cliente),
CONSTRAINT FK_CLIENTE_CORREOS FOREIGN KEY(id_cliente) REFERENCES CLIENTE (id_cliente),
CONSTRAINT FK_CORREOS_CLIENTES FOREIGN KEY(id_correos_cliente) REFERENCES CORREOS_CLIENTES (id_correos_cliente)
);

------------------ TRABAJADOR ------------------

------------------ TABLA ROL DE TRABAJADORES
 CREATE TABLE ROL_TRABAJADOR(
  id_rol_trabajador INT IDENTITY(1,1),
  rol VARCHAR(20) NOT NULL,
  CONSTRAINT PK_ROL_TRABAJADOR PRIMARY KEY (id_rol_trabajador)
 );


 CREATE TABLE TRABAJADORES(
 id_trabajador INT IDENTITY(1,1),
 id_rol_trabajador INT NOT NULL,
 nombre VARCHAR(20) NOT NULL,
 apellido_1 VARCHAR(20) NOT NULL,
 apellido_2 VARCHAR(20) NOT NULL,
 CONSTRAINT PK_TRABAJADORES PRIMARY KEY (id_trabajador),
 CONSTRAINT FK_ROL_TRABAJADOR FOREIGN KEY (id_rol_trabajador) REFERENCES ROL_TRABAJADOR(id_rol_trabajador)
 );
 ------------------ TABLA TELEFONOS DE TRABAJADORES
 CREATE TABLE TELEFONOS_TRABAJADORES(
 id_telefono_trabajador INT IDENTITY(1,1),
 telefono INT NOT NULL,
 CONSTRAINT PK_TELEFONOS_TRABAJADORES PRIMARY KEY (id_telefono_trabajador)
 );

 CREATE TABLE TELEFONOS_TRABAJADORES_TRABAJADORES(
  id_telefonos_trabajadores_trabajadores INT IDENTITY(1,1) ,
  id_telefono_trabajador INT NOT NULL,
  id_trabajador INT NOT NULL,
  CONSTRAINT PK_TELEFONOS_TRABAJADORES_TRABAJADORES PRIMARY KEY (id_telefonos_trabajadores_trabajadores),
  CONSTRAINT FK_ID_TELEFONO_TRABAJADOR FOREIGN KEY (id_telefono_trabajador) REFERENCES TELEFONOS_TRABAJADORES(id_telefono_trabajador),
  CONSTRAINT FK_TRABAJADOR FOREIGN KEY (id_trabajador) REFERENCES TRABAJADORES (id_trabajador)
 );

 ------------------ TABLA EMAIL DE TRABAJADORES

 CREATE TABLE EMAIL_TRABAJADORES(
  id_email_trabajador INT IDENTITY(1,1) ,
  email VARCHAR(50) NOT NULL,
  CONSTRAINT PK_EMAIL_TRABAJADORES PRIMARY KEY(id_email_trabajador)
 );

 CREATE TABLE EMAIL_TRABAJADORES_TRABAJADORES(
	id_email_trabajadores_trabajadores INT IDENTITY(1,1) ,
	id_email_trabajador INT NOT NULL,
	id_trabajador INT NOT NULL,
	CONSTRAINT PK_EMAIL_TRABAJADORES_TRABAJADORES PRIMARY KEY(id_email_trabajadores_trabajadores),
	CONSTRAINT FK_EMAIL_TRABAJADORES  FOREIGN KEY (id_email_trabajador) REFERENCES EMAIL_TRABAJADORES (id_email_trabajador),
	CONSTRAINT FK_TRABAJADORES FOREIGN KEY (id_trabajador) REFERENCES TRABAJADORES (id_trabajador)
 );

	------------------ FACTURACION ------------------

	CREATE TABLE FACTURA(
	id_factura INT IDENTITY (1,1),
	id_cliente INT NOT NULL, --FK
	monto_total INT NOT NULL,
	cantidad INT NOT NULL,
	precio_unitario DECIMAL(10,2) NOT NULL,
	estado_pago VARCHAR(10) NOT NULL CHECK (estado_pago IN ('pagado', 'pendiente')),
	fecha_emision DATE NOT NULL,
	CONSTRAINT PK_FACTURA PRIMARY KEY(id_factura),
	CONSTRAINT FK_CLIENTE_FACTURA FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente)
	);

	CREATE TABLE METODOS_PAGO(
	id_metodo_pago INT IDENTITY (1,1),
	tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('efectivo','tarjeta','sinpe')),
	CONSTRAINT PK_METODOS_PAGO PRIMARY KEY(id_metodo_pago)
	);

	CREATE TABLE FACTURA_METODOS_PAGO(
	id_factura_metodos_pago INT IDENTITY (1,1),
	id_factura INT NOT NULL, --FK
	id_metodo_pago INT NOT NULL, --FK,
	CONSTRAINT PK_FACTURA_METODOS_PAGO  PRIMARY KEY(id_factura_metodos_pago),
	CONSTRAINT FK_FACTURA_METODOS FOREIGN KEY (id_factura) REFERENCES FACTURA (id_factura),
	CONSTRAINT FK_METODOS_PAGO FOREIGN KEY (id_metodo_pago) REFERENCES METODOS_PAGO (id_metodo_pago)
	);

 ------------------ PRODUCTO ------------------

 CREATE TABLE PRODUCTO(
  codigo_producto INT IDENTITY(1,1),
  nombre VARCHAR(20) NOT NULL,
  CONSTRAINT PK_PRODUCTO PRIMARY KEY(codigo_producto)
 );

 CREATE TABLE PRODUCTO_FACTURA(
  id_producto_factura INT IDENTITY(1,1),
  codigo_producto INT NOT NULL,
  id_factura INT NOT NULL,
  CONSTRAINT PK_PRODUCTO_FACTURA PRIMARY KEY(id_producto_factura),
  CONSTRAINT FK_PRODUCTO_FACT FOREIGN KEY (codigo_producto) REFERENCES PRODUCTO (codigo_producto),
  CONSTRAINT FK_FACTURA_PRODUCTO FOREIGN KEY (id_factura) REFERENCES FACTURA (id_factura)
 );

 	 
------------------ PROVEEDOR ------------------

	 CREATE TABLE PROVEEDORES(
	  id_proveedor INT IDENTITY(1,1) ,
	  nombre VARCHAR(20) NOT NULL,	  
	  CONSTRAINT PK_PROVEEDORES PRIMARY KEY(id_proveedor)
	 );

	 --TABLA TELEFONOS
	 CREATE TABLE TELEFONOS_PROVEEDOR(
	  id_telefonos_proveedor INT IDENTITY(1,1),
	  telefono INT NOT NULL,
	  CONSTRAINT PK_TELEFONOS_PROVEEDOR PRIMARY KEY(id_telefonos_proveedor)
	 );

	--TABLA INTERMEDIA TELFONOS
	 CREATE TABLE TELEFONOS_PROVEEDOR_PROVEEDOR(
		id_telefonos_proveedor_proveedor INT IDENTITY(1,1) ,
		id_telefonos_proveedor INT NOT NULL,
		id_proveedor INT NOT NULL,
		CONSTRAINT PK_TELEFONOS_PROVEEDOR_PROVEEDOR PRIMARY KEY(id_telefonos_proveedor_proveedor),
		CONSTRAINT FK_TELEFONOS_PROVEEDOR FOREIGN KEY (id_telefonos_proveedor) REFERENCES TELEFONOS_PROVEEDOR(id_telefonos_proveedor),
		CONSTRAINT FK_PROVEEDOR_TELEFONO FOREIGN KEY (id_proveedor) REFERENCES PROVEEDORES(id_proveedor)

	--TABLA CORREOS
	 CREATE TABLE CORREOS_PROVEEDOR(
	  id_correos_proveedor INT IDENTITY(1,1),
	  correo INT NOT NULL,
	  CONSTRAINT PK_CORREOS_PROVEEDOR PRIMARY KEY(id_correos_proveedor)
	 );

	 --TABLA INTERMEDIA CORREOS
	  CREATE TABLE CORREOS_PROVEEDOR_PROVEEDOR(
		id_correos_proveedor_proveedor INT IDENTITY(1,1) ,
		id_correos_proveedor INT NOT NULL,
		id_proveedor INT NOT NULL,
		CONSTRAINT PK_CORREOS_PROVEEDOR_PROVEEDOR PRIMARY KEY(id_correos_proveedor_proveedor),
		CONSTRAINT FK_CORREOS_PROVEEDOR FOREIGN KEY (id_correos_proveedor) REFERENCES CORREOS_PROVEEDOR(id_correos_proveedor),
		CONSTRAINT FK_PROVEEDOR_CORREOS FOREIGN KEY (id_proveedor) REFERENCES PROVEEDORES(id_proveedor)

	--TABLA PROVEEDORES PRODUCTOS
	 CREATE TABLE PROVEEDORES_PRODUCTOS(
	  id_proveedor_producto INT IDENTITY(1,1),
	  id_proveedor INT NOT NULL,
	  codigo_producto INT NOT NULL,
	  CONSTRAINT PK_PROVEEDORES_PRODUCTOS PRIMARY KEY(id_proveedor_producto),
	 CONSTRAINT FK_PROVEEDORES FOREIGN KEY (id_proveedor) REFERENCES PROVEEDORES (id_proveedor),
	 CONSTRAINT FK_PRODUCTO_PROVEEDORRES FOREIGN KEY (codigo_producto) REFERENCES PRODUCTO (codigo_producto),
	 );

------------------ VEHICULO ------------------

	CREATE TABLE TIPO_VEHICULO(
	id_tipo_vehiculo INT IDENTITY (1,1) ,
	tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('carro', 'moto')),
	CONSTRAINT PK_TIPO_VEHICULO PRIMARY KEY(id_tipo_vehiculo)
	);

	CREATE TABLE FECHA_CAMBIO_ACEITE(
	id_fecha_cambio_aceite INT IDENTITY (1,1),
	fecha DATE NOT NULL,
	CONSTRAINT PK_FECHA_CAMBIO_ACEITE PRIMARY KEY(id_fecha_cambio_aceite)
	);

	CREATE TABLE VEHICULO(
	id_vehiculo INT IDENTITY (1,1),
	id_tipo_vehiculo INT NOT NULL, --FK
	id_cliente INT NOT NULL, --FK
	id_fecha_cambio_aceite INT NOT NULL, --FK
	color VARCHAR(20) NOT NULL,
	modelo VARCHAR(20) NOT NULL,
	numero_puertas INT NOT NULL,
	anno INT NOT NULL,
	marca VARCHAR(20) NOT NULL,
	CONSTRAINT PK_VEHICULO PRIMARY KEY(id_vehiculo),
	CONSTRAINT FK_TIPO_VEHICULO FOREIGN KEY (id_tipo_vehiculo) REFERENCES TIPO_VEHICULO (id_tipo_vehiculo),
	CONSTRAINT FK_CLIENTE_VEHICULO FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente),
	CONSTRAINT FK_FECHA_CAMBIO_ACEITE FOREIGN KEY (id_fecha_cambio_aceite) REFERENCES FECHA_CAMBIO_ACEITE (id_fecha_cambio_aceite)
	);


------------------ CITA ------------------

	CREATE TABLE CITA(
	 id_cita INT IDENTITY (1,1),
	 id_cliente INT NOT NULL,
	 estado_cita VARCHAR(20) NOT NULL CHECK(estado_cita IN ('espera','completada')),
	 fecha DATE NOT NULL,
	 hora TIME NOT NULL,
	 CONSTRAINT PK_CITA  PRIMARY KEY(id_cita),
	 CONSTRAINT FK_CLIENTE_CITA FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente)
	);

 
 ------------------ SERVICIO ------------------
	CREATE TABLE SERVICIO(
	id_servicio INT IDENTITY (1,1),
	id_vehiculo INT NOT NULL, --FK
	id_trabajador INT NOT NULL, --FK
	id_factura INT NOT NULL, --FK
	categoria VARCHAR(20) NOT NULL CHECK (categoria IN ('preventivo', 'urgencia')),
	estado_servicio VARCHAR(20) NOT NULL CHECK (estado_servicio IN ('completado', 'en proceso', 'sin iniciar')),
	CONSTRAINT PK_SERVICIO  PRIMARY KEY(id_servicio),
	CONSTRAINT FK_VEHICULO_SERVICIO FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO (id_vehiculo),
	CONSTRAINT FK_TRABAJADORES_SERVICIO FOREIGN KEY (id_trabajador) REFERENCES TRABAJADORES (id_trabajador),
	CONSTRAINT FK_FACTURA_SERVICIO FOREIGN KEY (id_factura) REFERENCES FACTURA (id_factura),
	);


	CREATE TABLE SERVICIO_FACTURA(
	id_servicio_factura INT IDENTITY (1,1) ,
	id_servicio INT NOT NULL, --FK
	id_factura INT NOT NULL, --FK
	CONSTRAINT PK_SERVICIO_FACTURA PRIMARY KEY(id_servicio_factura),
	CONSTRAINT FK_SERVICIO_SERVICIO_FACTURA FOREIGN KEY (id_servicio) REFERENCES SERVICIO (id_servicio),
	CONSTRAINT FK_FACTURA_SERVICIO_FACTURA FOREIGN KEY (id_factura) REFERENCES FACTURA (id_factura)
	);
---------------------------------------------------------------------------
------------------------ PROCEDIMIENTOS ALMACENADOS ----------------------- 
---------------------------------------------------------------------------

------------------ CREACION TRABAJADORES ------------------
CREATE PROCEDURE SP_INSERT_TRABAJADOR
    @rol VARCHAR(20),
    @nombre VARCHAR(20),
    @apellido_1 VARCHAR(20),
    @apellido_2 VARCHAR(20),
    @telefono INT,
    @email VARCHAR(100)
AS
BEGIN
-- Declarar IDs para asignarlos bien
	DECLARE @id_rol_trabajador INT;
	DECLARE @id_trabajador INT;
	DECLARE @id_telefono_trabajador INT;
	DECLARE @id_email_trabajador INT;
	
-- Insertar Rol

	IF NOT EXISTS (SELECT 1 FROM ROL_TRABAJADOR WHERE rol = @rol)
	BEGIN
		INSERT INTO ROL_TRABAJADOR (rol)
		VALUES (@rol)

		SET @id_rol_trabajador = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		SELECT @id_rol_trabajador = id_rol_trabajador
		FROM ROL_TRABAJADOR
		WHERE rol = @rol
	END

-- Insertar Trabajador
	INSERT INTO TRABAJADORES (id_rol_trabajador, nombre, apellido_1, apellido_2)
	VALUES (@id_rol_trabajador, @nombre, @apellido_1, @apellido_2)

	SET @id_trabajador = SCOPE_IDENTITY();

-- Insertar Telefonos
	INSERT INTO TELEFONOS_TRABAJADORES (telefono)
	VALUES (@telefono)

	SET @id_telefono_trabajador = SCOPE_IDENTITY();

	INSERT INTO TELEFONOS_TRABAJADORES_TRABAJADORES (id_telefono_trabajador, id_trabajador)
	VALUES (@id_telefono_trabajador, @id_trabajador)

-- Insertar Emails
	INSERT INTO EMAIL_TRABAJADORES (email)
	VALUES (@email)

	SET @id_email_trabajador = SCOPE_IDENTITY();

	INSERT INTO EMAIL_TRABAJADORES_TRABAJADORES (id_email_trabajador, id_trabajador)
	VALUES (@id_email_trabajador, @id_trabajador)
END;

------------------ DELETE TRABAJADORES ------------------
CREATE PROCEDURE SP_DELETE_TRABAJADOR
	@id_trabajador INT,
	@id_email_trabajador INT,
	@id_telefono_trabajador INT
	--@id_rol_trabajador INT
AS
BEGIN 
	-- Eliminar relacion de emails
	DELETE FROM EMAIL_TRABAJADORES_TRABAJADORES WHERE id_trabajador = @id_trabajador
	
	-- Eliminar relacion de telefonos
	DELETE FROM TELEFONOS_TRABAJADORES_TRABAJADORES WHERE id_trabajador = @id_trabajador
	
	-- Eliminar email
	DELETE FROM EMAIL_TRABAJADORES WHERE id_email_trabajador = @id_email_trabajador

	-- Eliminar telefono
	DELETE FROM TELEFONOS_TRABAJADORES WHERE id_telefono_trabajador = @id_trabajador

	-- Eliminar trabajador
	DELETE FROM TRABAJADORES WHERE id_trabajador = @id_trabajador

END;

------------------ UPDATE TRABAJADORES INFO PERSONAL ------------------
CREATE PROCEDURE SP_UPDATE_TRABAJADORES_INFO_PERSONAL
	@id_trabajador INT,
	@nombre VARCHAR(20),
	@apellido_1 VARCHAR(20),
	@apellido_2 VARCHAR(20),
	@telefono INT,
	@email VARCHAR(100)
AS 
BEGIN
	-- Actualizar telefono
	UPDATE TELEFONOS_TRABAJADORES
	SET telefono = @telefono
	WHERE id_telefono_trabajador = @id_trabajador

	-- Actualizar email
	UPDATE EMAIL_TRABAJADORES
	SET email = @email 
	WHERE id_email_trabajador = @id_trabajador

	-- Actualizar Nombre y Apellidos
	UPDATE TRABAJADORES
	SET nombre = @nombre,
		apellido_1 = @apellido_1,
		apellido_2 = @apellido_2
	WHERE id_trabajador = @id_trabajador
END;

------------------ INSERT CLIENTES ------------------
CREATE PROCEDURE SP_INSERT_CLIENTES
	@tipo VARCHAR(20), -- CHECK 'frecuente' , 'ocasional'
	@nombre VARCHAR(20),
	@apellido_1 VARCHAR(20),
	@apellido_2 VARCHAR(20),
	@telefono VARCHAR(20),
	@correo_electronico VARCHAR(100)
AS 
BEGIN
-- Declarar IDs para asignarlos bien
	DECLARE @id_tipo_cliente INT;
	DECLARE @id_cliente INT;
	DECLARE @id_telefono_cliente INT;
	DECLARE @id_correos_cliente INT;

-- Insertar tipo de cliente, CHECK 'frecuente' , 'ocasional'

	IF NOT EXISTS (SELECT 1 FROM TIPO_CLIENTE WHERE tipo = @tipo)
	BEGIN
		INSERT INTO TIPO_CLIENTE (tipo)
		VALUES (@tipo)

		SET @id_tipo_cliente = SCOPE_IDENTITY();
	END	
	ELSE
	BEGIN
		SELECT @id_tipo_cliente = id_tipo_cliente
		FROM TIPO_CLIENTE
		WHERE tipo = @tipo
	END
	
-- Insertar cliente
	INSERT INTO CLIENTE (id_tipo_cliente, nombre, apellido_1, apellido_2)
	VALUES (@id_tipo_cliente, @nombre, @apellido_1, @apellido_2)

	SET @id_cliente = SCOPE_IDENTITY();

-- Insertar telefono
	INSERT INTO TELEFONOS_CLIENTE (telefono)
	VALUES (@telefono)

	SET @id_telefono_cliente = SCOPE_IDENTITY();

-- Insertar correo
	INSERT INTO CORREOS_CLIENTES (correo_electronico)
	VALUES (@correo_electronico)

	SET @id_correos_cliente = SCOPE_IDENTITY();

-- Relacionar correo con cliente
	INSERT INTO CORREOS_CLIENTES_CLIENTE (id_cliente, id_correos_cliente)
	VALUES (@id_cliente, @id_cliente)

-- Relacionar telefono con cliente
	INSERT INTO TELEFONO_CLIENTE_CLIENTE (id_cliente, id_telefono_cliente)
	values (@id_cliente, @id_telefono_cliente)
END;


------------------ DELETE CLIENTES ------------------
CREATE PROCEDURE SP_DELETE_CLIENTE
    @id_cliente INT,
    @id_correos_cliente INT,
    @id_telefono_cliente INT,
    @id_tipo_cliente INT
AS
BEGIN
    -- Eliminar relacion de correos
    DELETE FROM CORREOS_CLIENTES_CLIENTE WHERE id_cliente = @id_cliente;

    -- Eliminar relacion de telefonos
    DELETE FROM TELEFONO_CLIENTE_CLIENTE WHERE id_cliente = @id_cliente;

    -- Eliminar correo
    DELETE FROM CORREOS_CLIENTES WHERE id_correos_cliente = @id_correos_cliente;

    -- Eliminar telefono
    DELETE FROM TELEFONOS_CLIENTE WHERE id_telefono_cliente = @id_telefono_cliente;

    -- Eliminar cliente
    DELETE FROM CLIENTE WHERE id_cliente = @id_cliente;

    -- Eliminar tipo de cliente
    DELETE FROM TIPO_CLIENTE WHERE id_tipo_cliente = @id_tipo_cliente;
END;

------------------ UPDATE CLIENTES INFO PERSONAL ------------------
CREATE PROCEDURE SP_UPDATE_CLIENTE_INFO
    @id_cliente INT,
    @nombre VARCHAR(20),
    @apellido_1 VARCHAR(20),
    @apellido_2 VARCHAR(20),
    @telefono VARCHAR(20),
    @correo_electronico VARCHAR(100)
AS
BEGIN
    -- Actualizar telefono
    UPDATE TELEFONOS_CLIENTE
    SET telefono = @telefono
    WHERE id_telefono_cliente = @id_cliente;

    -- Actualizar correo
    UPDATE CORREOS_CLIENTES
    SET correo_electronico = @correo_electronico
    WHERE id_correos_cliente = @id_cliente;

    -- Actualizar nombre y apellidos
    UPDATE CLIENTE
    SET nombre = @nombre,
        apellido_1 = @apellido_1,
        apellido_2 = @apellido_2
    WHERE id_cliente = @id_cliente;
END;

------------------ INSERT PROVEEDORES ------------------
CREATE PROCEDURE SP_INSERT_PROVEEDOR
    @nombre VARCHAR(20),
    @correo VARCHAR(20),
    @telefono VARCHAR(20),
    @codigo_producto INT
AS
BEGIN
    -- Declarar IDs para asignarlos correctamente
    DECLARE @id_proveedor INT;
    DECLARE @id_telefonos_proveedor INT;
    DECLARE @id_correos_proveedor INT;
    DECLARE @id_proveedor_producto INT;

    -- Insertar proveedor
    INSERT INTO PROVEEDORES (nombre)
    VALUES (@nombre);

    SET @id_proveedor = SCOPE_IDENTITY();

    -- Insertar telefono del proveedor
    INSERT INTO TELEFONOS_PROVEEDOR (telefono)
    VALUES (@telefono);

    SET @id_telefonos_proveedor = SCOPE_IDENTITY();

    -- Insertar correo del proveedor
    INSERT INTO CORREOS_PROVEEDOR (correo)
    VALUES (@correo);

    SET @id_correos_proveedor = SCOPE_IDENTITY();

	-- Insertar relacion correo con proveedor
	INSERT INTO CORREOS_PROVEEDOR_PROVEEDOR (id_proveedor, id_correos_proveedor)
	VALUES (@id_proveedor, @id_correos_proveedor)

	-- Insertar relacion telefono con proveedor
	INSERT INTO TELEFONOS_PROVEEDOR_PROVEEDOR (id_proveedor, id_telefonos_proveedor)
	VALUES (@id_proveedor, @id_telefonos_proveedor)

    -- Insertar relacion proveedor-producto
    INSERT INTO PROVEEDORES_PRODUCTOS (id_proveedor, codigo_producto)
    VALUES (@id_proveedor, @codigo_producto);

    SET @id_proveedor_producto = SCOPE_IDENTITY();
END;

------------------ DELETE PROVEEDORES ------------------
CREATE PROCEDURE SP_DELETE_PROVEEDOR
    @id_proveedor INT
AS
BEGIN
    -- Eliminar relaciones proveedor-productos
    DELETE FROM PROVEEDORES_PRODUCTOS WHERE id_proveedor = @id_proveedor;

    -- Eliminar correos del proveedor
    DELETE FROM CORREOS_PROVEEDOR WHERE id_proveedor = @id_proveedor;

    -- Eliminar telefonos del proveedor
    DELETE FROM TELEFONOS_PROVEEDOR WHERE id_proveedor = @id_proveedor;

    -- Eliminar proveedor
    DELETE FROM PROVEEDORES WHERE id_proveedor = @id_proveedor;
END;

------------------ UPDATE PROVEEDORES INFO ------------------
CREATE PROCEDURE SP_UPDATE_PROVEEDOR_INFO
    @id_proveedor INT,
    @nombre VARCHAR(20),
    @email VARCHAR(20)
AS
BEGIN
    -- Actualizar datos del proveedor
    UPDATE PROVEEDORES
    SET nombre = @nombre,
        email = @email
    WHERE id_proveedor = @id_proveedor;
END;


------------------ INSERT PRODUCTOS ------------------
CREATE PROCEDURE SP_INSERT_PRODUCTO
    @nombre VARCHAR(20),
    @id_factura INT
AS
BEGIN
    -- Declarar IDs para asignarlos correctamente
    DECLARE @codigo_producto INT;
    DECLARE @id_producto_factura INT;

    -- Insertar producto
    INSERT INTO PRODUCTO (nombre)
    VALUES (@nombre);

    SET @codigo_producto = SCOPE_IDENTITY();

    -- Insertar relacion producto-factura
    INSERT INTO PRODUCTO_FACTURA (codigo_producto, id_factura)
    VALUES (@codigo_producto, @id_factura);

    SET @id_producto_factura = SCOPE_IDENTITY();
END;

------------------ DELETE PRODUCTOS ------------------
CREATE PROCEDURE SP_DELETE_PRODUCTO
    @codigo_producto INT
AS
BEGIN
    -- Eliminar relaciones producto-factura
    DELETE FROM PRODUCTO_FACTURA WHERE codigo_producto = @codigo_producto;

    -- Eliminar producto
    DELETE FROM PRODUCTO WHERE codigo_producto = @codigo_producto;
END;

------------------ UPDATE PRODUCTO INFO ------------------
CREATE PROCEDURE SP_UPDATE_PRODUCTO_INFO
    @codigo_producto INT,
    @nombre VARCHAR(20)
AS
BEGIN
    -- Actualizar nombre del producto
    UPDATE PRODUCTO
    SET nombre = @nombre
    WHERE codigo_producto = @codigo_producto;
END;


---------------------------------------------------------------------------
------------------------- GENERACION DE REGISTROS ------------------------- 
---------------------------------------------------------------------------

----------------------- TRABAJADORES -----------------------
EXEC SP_INSERT_TRABAJADOR @rol='Administrador', @nombre='Camila', @apellido_1='Solano', @apellido_2='Gómez', @telefono=83905312, @email='camila.solano1@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Valeria', @apellido_1='Jiménez', @apellido_2='Castro', @telefono=85945337, @email='valeria.jiménez2@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Diego', @apellido_1='Mora', @apellido_2='Soto', @telefono=87529252, @email='diego.mora3@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Erick', @apellido_1='Pérez', @apellido_2='Jiménez', @telefono=89891349, @email='erick.pérez4@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Ana', @apellido_1='Castro', @apellido_2='Pérez', @telefono=86593527, @email='ana.castro5@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='María', @apellido_1='Salazar', @apellido_2='Ramírez', @telefono=81409791, @email='maría.salazar6@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Sofía', @apellido_1='Jiménez', @apellido_2='Vega', @telefono=82141459, @email='sofía.jiménez7@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Sofía', @apellido_1='Rojas', @apellido_2='Gómez', @telefono=84854016, @email='sofía.rojas8@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Valeria', @apellido_1='Solano', @apellido_2='Soto', @telefono=84538482, @email='valeria.solano9@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Gabriela', @apellido_1='Vega', @apellido_2='Soto', @telefono=87882777, @email='gabriela.vega10@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Administrador', @nombre='Luis', @apellido_1='Ramírez', @apellido_2='Vargas', @telefono=87664482, @email='luis.ramírez11@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Camila', @apellido_1='Salazar', @apellido_2='Soto', @telefono=82227694, @email='camila.salazar12@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Administrador', @nombre='Pedro', @apellido_1='Solano', @apellido_2='Campos', @telefono=81993427, @email='pedro.solano13@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Esteban', @apellido_1='Mora', @apellido_2='Jiménez', @telefono=84851179, @email='esteban.mora14@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='María', @apellido_1='Ramírez', @apellido_2='Vargas', @telefono=80062605, @email='maría.ramírez15@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Manuel', @apellido_1='Jiménez', @apellido_2='Ramírez', @telefono=82201774, @email='manuel.jiménez16@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Administrador', @nombre='Pedro', @apellido_1='García', @apellido_2='Vargas', @telefono=81094275, @email='pedro.garcía17@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='María', @apellido_1='Solano', @apellido_2='Pérez', @telefono=88172354, @email='maría.solano18@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Esteban', @apellido_1='Solano', @apellido_2='Gómez', @telefono=86241658, @email='esteban.solano19@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='María', @apellido_1='Vega', @apellido_2='Vega', @telefono=80074293, @email='maría.vega20@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Administrador', @nombre='Isabel', @apellido_1='Campos', @apellido_2='Pérez', @telefono=84551139, @email='isabel.campos21@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Administrador', @nombre='María', @apellido_1='Ramírez', @apellido_2='Solano', @telefono=80932569, @email='maría.ramírez22@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Felipe', @apellido_1='Alvarado', @apellido_2='Mora', @telefono=88990817, @email='felipe.alvarado23@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Erick', @apellido_1='Jiménez', @apellido_2='Ramírez', @telefono=80373616, @email='erick.jiménez24@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Pedro', @apellido_1='Alvarado', @apellido_2='Vega', @telefono=82041566, @email='pedro.alvarado25@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Paula', @apellido_1='García', @apellido_2='Castro', @telefono=81309626, @email='paula.garcía26@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Camila', @apellido_1='Vargas', @apellido_2='Campos', @telefono=86988594, @email='camila.vargas27@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Administrador', @nombre='Jorge', @apellido_1='Mora', @apellido_2='Jiménez', @telefono=88322975, @email='jorge.mora28@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Laura', @apellido_1='Salazar', @apellido_2='Vega', @telefono=81865331, @email='laura.salazar29@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Administrador', @nombre='Laura', @apellido_1='Castro', @apellido_2='Gómez', @telefono=81778646, @email='laura.castro30@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Administrador', @nombre='Camila', @apellido_1='Mora', @apellido_2='Ramírez', @telefono=80114709, @email='camila.mora31@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Felipe', @apellido_1='Pérez', @apellido_2='Campos', @telefono=88543695, @email='felipe.pérez32@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Isabel', @apellido_1='Ramos', @apellido_2='Pérez', @telefono=83437626, @email='isabel.ramos33@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Manuel', @apellido_1='Martínez', @apellido_2='Pérez', @telefono=83523968, @email='manuel.martínez34@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Administrador', @nombre='Luis', @apellido_1='Ramos', @apellido_2='Pérez', @telefono=80181725, @email='luis.ramos35@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Sofía', @apellido_1='García', @apellido_2='Solano', @telefono=89182492, @email='sofía.garcía36@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Felipe', @apellido_1='Rojas', @apellido_2='Jiménez', @telefono=87594887, @email='felipe.rojas37@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Laura', @apellido_1='Jiménez', @apellido_2='Ramírez', @telefono=80753858, @email='laura.jiménez38@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Administrador', @nombre='Esteban', @apellido_1='Pérez', @apellido_2='Soto', @telefono=80520175, @email='esteban.pérez39@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Administrador', @nombre='Camila', @apellido_1='Pérez', @apellido_2='Solano', @telefono=81679975, @email='camila.pérez40@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Luis', @apellido_1='Mora', @apellido_2='Jiménez', @telefono=81366079, @email='luis.mora41@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Administrador', @nombre='Ricardo', @apellido_1='Ramírez', @apellido_2='Castro', @telefono=89744705, @email='ricardo.ramírez42@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Laura', @apellido_1='Castro', @apellido_2='Solano', @telefono=86840222, @email='laura.castro43@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Carlos', @apellido_1='Jiménez', @apellido_2='Mora', @telefono=89547362, @email='carlos.jiménez44@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Diego', @apellido_1='Vargas', @apellido_2='Solano', @telefono=87523893, @email='diego.vargas45@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Manuel', @apellido_1='Campos', @apellido_2='Vargas', @telefono=88858466, @email='manuel.campos46@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Valeria', @apellido_1='Vega', @apellido_2='Gómez', @telefono=84713991, @email='valeria.vega47@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Asistente', @nombre='Pedro', @apellido_1='Rojas', @apellido_2='Castro', @telefono=82070479, @email='pedro.rojas48@lubricentrola.cr';
EXEC SP_INSERT_TRABAJADOR @rol='Mecánico', @nombre='Ana', @apellido_1='Alvarado', @apellido_2='Vargas', @telefono=87873941, @email='ana.alvarado49@lubricentrola.cr';

----------------------- CLIENTES -----------------------
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Felipe', @apellido_1='Ramos', @apellido_2='Vargas', @telefono='80587026', @correo_electronico='felipe.ramos1@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Andrés', @apellido_1='Vega', @apellido_2='Vargas', @telefono='86313774', @correo_electronico='andrés.vega2@hotmail.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Jorge', @apellido_1='Pérez', @apellido_2='Solano', @telefono='88763361', @correo_electronico='jorge.pérez3@gmail.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Erick', @apellido_1='García', @apellido_2='Soto', @telefono='81699450', @correo_electronico='erick.garcía4@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Diego', @apellido_1='Mora', @apellido_2='Vargas', @telefono='81137133', @correo_electronico='diego.mora5@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Paula', @apellido_1='Vega', @apellido_2='Ramírez', @telefono='86547136', @correo_electronico='paula.vega6@hotmail.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Isabel', @apellido_1='Salazar', @apellido_2='Campos', @telefono='80596221', @correo_electronico='isabel.salazar7@gmail.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Felipe', @apellido_1='Jiménez', @apellido_2='Campos', @telefono='82789121', @correo_electronico='felipe.jiménez8@gmail.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Pedro', @apellido_1='Vega', @apellido_2='Jiménez', @telefono='82222087', @correo_electronico='pedro.vega9@hotmail.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Andrés', @apellido_1='Ramírez', @apellido_2='Pérez', @telefono='84936226', @correo_electronico='andrés.ramírez10@gmail.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Manuel', @apellido_1='Salazar', @apellido_2='Ramírez', @telefono='85720630', @correo_electronico='manuel.salazar11@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Gabriela', @apellido_1='Ramos', @apellido_2='Salazar', @telefono='81729334', @correo_electronico='gabriela.ramos12@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Erick', @apellido_1='Fernández', @apellido_2='Gómez', @telefono='88926379', @correo_electronico='erick.fernández13@live.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Carlos', @apellido_1='Rojas', @apellido_2='Mora', @telefono='86160600', @correo_electronico='carlos.rojas14@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Jorge', @apellido_1='Solano', @apellido_2='Gómez', @telefono='89803100', @correo_electronico='jorge.solano15@hotmail.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Manuel', @apellido_1='Ramírez', @apellido_2='Mora', @telefono='85577582', @correo_electronico='manuel.ramírez16@hotmail.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Sofía', @apellido_1='Salazar', @apellido_2='Mora', @telefono='81228818', @correo_electronico='sofía.salazar17@hotmail.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Erick', @apellido_1='Vega', @apellido_2='Gómez', @telefono='86329484', @correo_electronico='erick.vega18@live.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Ricardo', @apellido_1='Alvarado', @apellido_2='Pérez', @telefono='88636783', @correo_electronico='ricardo.alvarado19@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Valeria', @apellido_1='Salazar', @apellido_2='Solano', @telefono='85700612', @correo_electronico='valeria.salazar20@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Erick', @apellido_1='Solano', @apellido_2='Pérez', @telefono='82177759', @correo_electronico='erick.solano21@hotmail.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Laura', @apellido_1='Mora', @apellido_2='Campos', @telefono='82032235', @correo_electronico='laura.mora22@live.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Luis', @apellido_1='Vargas', @apellido_2='Castro', @telefono='80541834', @correo_electronico='luis.vargas23@live.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Luis', @apellido_1='Alvarado', @apellido_2='Salazar', @telefono='88843355', @correo_electronico='luis.alvarado24@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Pedro', @apellido_1='Ramos', @apellido_2='Solano', @telefono='82841613', @correo_electronico='pedro.ramos25@hotmail.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Esteban', @apellido_1='Solano', @apellido_2='Campos', @telefono='87056702', @correo_electronico='esteban.solano26@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='María', @apellido_1='Ramos', @apellido_2='Mora', @telefono='89766573', @correo_electronico='maría.ramos27@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Diego', @apellido_1='Rojas', @apellido_2='Soto', @telefono='83863501', @correo_electronico='diego.rojas28@gmail.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Paula', @apellido_1='Vargas', @apellido_2='Soto', @telefono='85714710', @correo_electronico='paula.vargas29@gmail.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Gabriela', @apellido_1='Vargas', @apellido_2='Jiménez', @telefono='86898125', @correo_electronico='gabriela.vargas30@gmail.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Paula', @apellido_1='Rojas', @apellido_2='Jiménez', @telefono='80089052', @correo_electronico='paula.rojas31@hotmail.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Gabriela', @apellido_1='Mora', @apellido_2='Vega', @telefono='81993091', @correo_electronico='gabriela.mora32@gmail.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Luis', @apellido_1='Fernández', @apellido_2='Mora', @telefono='89063708', @correo_electronico='luis.fernández33@live.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Gabriela', @apellido_1='Castro', @apellido_2='Campos', @telefono='88290593', @correo_electronico='gabriela.castro34@hotmail.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Felipe', @apellido_1='Fernández', @apellido_2='Pérez', @telefono='89358044', @correo_electronico='felipe.fernández35@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Ana', @apellido_1='Fernández', @apellido_2='Mora', @telefono='80156751', @correo_electronico='ana.fernández37@gmail.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Diego', @apellido_1='Salazar', @apellido_2='Campos', @telefono='83911719', @correo_electronico='diego.salazar38@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Manuel', @apellido_1='Salazar', @apellido_2='Ramírez', @telefono='80794002', @correo_electronico='manuel.salazar39@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Diego', @apellido_1='Mora', @apellido_2='Jiménez', @telefono='88203613', @correo_electronico='diego.mora40@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='María', @apellido_1='Salazar', @apellido_2='Vargas', @telefono='82869921', @correo_electronico='maría.salazar41@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Sofía', @apellido_1='Ramírez', @apellido_2='Mora', @telefono='88009929', @correo_electronico='sofía.ramírez42@live.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Jorge', @apellido_1='Ramos', @apellido_2='Ramírez', @telefono='88056641', @correo_electronico='jorge.ramos43@hotmail.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Esteban', @apellido_1='Pérez', @apellido_2='Jiménez', @telefono='87730505', @correo_electronico='esteban.pérez44@hotmail.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Ricardo', @apellido_1='Martínez', @apellido_2='Vega', @telefono='87766050', @correo_electronico='ricardo.martínez45@gmail.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Luis', @apellido_1='Fernández', @apellido_2='Pérez', @telefono='84537217', @correo_electronico='luis.fernández46@live.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Diego', @apellido_1='Pérez', @apellido_2='Vargas', @telefono='86577343', @correo_electronico='diego.pérez47@yahoo.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Ricardo', @apellido_1='Solano', @apellido_2='Vega', @telefono='83687952', @correo_electronico='ricardo.solano48@live.com';
EXEC SP_INSERT_CLIENTES @tipo='frecuente', @nombre='Andrés', @apellido_1='Alvarado', @apellido_2='Jiménez', @telefono='80101786', @correo_electronico='andrés.alvarado49@gmail.com';
EXEC SP_INSERT_CLIENTES @tipo='ocasional', @nombre='Luis', @apellido_1='Solano', @apellido_2='Mora', @telefono='83928164', @correo_electronico='luis.solano50@gmail.com';


----------------------- PROVEEDORES -----------------------
EXEC SP_INSERT_PROVEEDOR @nombre='CarZone1', @email='contacto@carzone1.com', @telefono='88715460', @codigo_producto=1;
EXEC SP_INSERT_PROVEEDOR @nombre='LubricantesGlobal2', @email='contacto@lubricantesglobal2.cr', @telefono='83925394', @codigo_producto=2;
EXEC SP_INSERT_PROVEEDOR @nombre='CarCareSolutions3', @email='contacto@carcaresolutions3.com', @telefono='87322248', @codigo_producto=3;
EXEC SP_INSERT_PROVEEDOR @nombre='AceitesPremium4', @email='contacto@aceitespremium4.com', @telefono='86016247', @codigo_producto=4;
EXEC SP_INSERT_PROVEEDOR @nombre='CarZone5', @email='contacto@carzone5.cr', @telefono='87190839', @codigo_producto=5;
EXEC SP_INSERT_PROVEEDOR @nombre='AceitesPremium6', @email='contacto@aceitespremium6.com', @telefono='88698960', @codigo_producto=6;
EXEC SP_INSERT_PROVEEDOR @nombre='CarZone7', @email='contacto@carzone7.net', @telefono='85426514', @codigo_producto=7;
EXEC SP_INSERT_PROVEEDOR @nombre='MotoRepuestos8', @email='contacto@motorepuestos8.net', @telefono='81581998', @codigo_producto=8;
EXEC SP_INSERT_PROVEEDOR @nombre='PowerAuto9', @email='contacto@powerauto9.com', @telefono='84392037', @codigo_producto=9;
EXEC SP_INSERT_PROVEEDOR @nombre='SpeedParts10', @email='contacto@speedparts10.com', @telefono='89417938', @codigo_producto=10;
EXEC SP_INSERT_PROVEEDOR @nombre='AutoFix11', @email='contacto@autofix11.com', @telefono='82795402', @codigo_producto=11;
EXEC SP_INSERT_PROVEEDOR @nombre='AceitePlus12', @email='contacto@aceiteplus12.net', @telefono='80139353', @codigo_producto=12;
EXEC SP_INSERT_PROVEEDOR @nombre='AutoPartsCR13', @email='contacto@autopartscr13.cr', @telefono='89282845', @codigo_producto=13;
EXEC SP_INSERT_PROVEEDOR @nombre='AutoPartsCR14', @email='contacto@autopartscr14.com', @telefono='85779941', @codigo_producto=14;
EXEC SP_INSERT_PROVEEDOR @nombre='SpeedParts15', @email='contacto@speedparts15.com', @telefono='84710001', @codigo_producto=15;
EXEC SP_INSERT_PROVEEDOR @nombre='TurboRepuestos16', @email='contacto@turborepuestos16.com', @telefono='88876667', @codigo_producto=16;
EXEC SP_INSERT_PROVEEDOR @nombre='TurboRepuestos17', @email='contacto@turborepuestos17.net', @telefono='80394644', @codigo_producto=17;
EXEC SP_INSERT_PROVEEDOR @nombre='LubricantesGlobal18', @email='contacto@lubricantesglobal18.net', @telefono='83223406', @codigo_producto=18;
EXEC SP_INSERT_PROVEEDOR @nombre='AceitesPremium19', @email='contacto@aceitespremium19.com', @telefono='80249477', @codigo_producto=19;
EXEC SP_INSERT_PROVEEDOR @nombre='AutoMundo20', @email='contacto@automundo20.com', @telefono='83808504', @codigo_producto=20;
EXEC SP_INSERT_PROVEEDOR @nombre='PowerAuto21', @email='contacto@powerauto21.com', @telefono='85056828', @codigo_producto=21;
EXEC SP_INSERT_PROVEEDOR @nombre='AceitePlus22', @email='contacto@aceiteplus22.com', @telefono='82328997', @codigo_producto=22;
EXEC SP_INSERT_PROVEEDOR @nombre='AutoPartsCR23', @email='contacto@autopartscr23.net', @telefono='88956153', @codigo_producto=23;
EXEC SP_INSERT_PROVEEDOR @nombre='MaxPerformance24', @email='contacto@maxperformance24.com', @telefono='88702334', @codigo_producto=24;
EXEC SP_INSERT_PROVEEDOR @nombre='PowerAuto25', @email='contacto@powerauto25.cr', @telefono='88213760', @codigo_producto=25;
EXEC SP_INSERT_PROVEEDOR @nombre='SpeedParts26', @email='contacto@speedparts26.com', @telefono='82656292', @codigo_producto=26;
EXEC SP_INSERT_PROVEEDOR @nombre='AutoFix27', @email='contacto@autofix27.com', @telefono='85983136', @codigo_producto=27;
EXEC SP_INSERT_PROVEEDOR @nombre='PowerAuto28', @email='contacto@powerauto28.com', @telefono='82456541', @codigo_producto=28;
EXEC SP_INSERT_PROVEEDOR @nombre='AceitePlus29', @email='contacto@aceiteplus29.cr', @telefono='84893671', @codigo_producto=29;
EXEC SP_INSERT_PROVEEDOR @nombre='MotoRepuestos30', @email='contacto@motorepuestos30.net', @telefono='86967333', @codigo_producto=30;
EXEC SP_INSERT_PROVEEDOR @nombre='CarZone31', @email='contacto@carzone31.net', @telefono='82863303', @codigo_producto=31;
EXEC SP_INSERT_PROVEEDOR @nombre='LubriCentro32', @email='contacto@lubricentro32.net', @telefono='84948172', @codigo_producto=32;
EXEC SP_INSERT_PROVEEDOR @nombre='ProLubricantes33', @email='contacto@prolubricantes33.net', @telefono='87091752', @codigo_producto=33;
EXEC SP_INSERT_PROVEEDOR @nombre='RepuestosDeluxe34', @email='contacto@repuestosdeluxe34.com', @telefono='86396546', @codigo_producto=34;
EXEC SP_INSERT_PROVEEDOR @nombre='LubricantesGlobal35', @email='contacto@lubricantesglobal35.com', @telefono='80167092', @codigo_producto=35;
EXEC SP_INSERT_PROVEEDOR @nombre='AceitesPremium36', @email='contacto@aceitespremium36.com', @telefono='80786686', @codigo_producto=36;
EXEC SP_INSERT_PROVEEDOR @nombre='LubricantesGlobal37', @email='contacto@lubricantesglobal37.net', @telefono='89287394', @codigo_producto=37;
EXEC SP_INSERT_PROVEEDOR @nombre='FiltrosExpress38', @email='contacto@filtrosexpress38.com', @telefono='85726205', @codigo_producto=38;
EXEC SP_INSERT_PROVEEDOR @nombre='AceitesPremium39', @email='contacto@aceitespremium39.net', @telefono='80208259', @codigo_producto=39;
EXEC SP_INSERT_PROVEEDOR @nombre='EcoLubricantes40', @email='contacto@ecolubricantes40.net', @telefono='83231742', @codigo_producto=40;
EXEC SP_INSERT_PROVEEDOR @nombre='MotorTech41', @email='contacto@motortech41.com', @telefono='89596288', @codigo_producto=41;
EXEC SP_INSERT_PROVEEDOR @nombre='LubriCentro42', @email='contacto@lubricentro42.com', @telefono='89112555', @codigo_producto=42;
EXEC SP_INSERT_PROVEEDOR @nombre='AutoPartsCR43', @email='contacto@autopartscr43.net', @telefono='88963164', @codigo_producto=43;
EXEC SP_INSERT_PROVEEDOR @nombre='RepuestosDeluxe44', @email='contacto@repuestosdeluxe44.cr', @telefono='89889018', @codigo_producto=44;
EXEC SP_INSERT_PROVEEDOR @nombre='AceitePlus45', @email='contacto@aceiteplus45.cr', @telefono='83176451', @codigo_producto=45;
EXEC SP_INSERT_PROVEEDOR @nombre='AutoFix46', @email='contacto@autofix46.com', @telefono='83150568', @codigo_producto=46;
EXEC SP_INSERT_PROVEEDOR @nombre='MotoRepuestos47', @email='contacto@motorepuestos47.net', @telefono='86622217', @codigo_producto=47;
EXEC SP_INSERT_PROVEEDOR @nombre='AutoPartsCR48', @email='contacto@autopartscr48.com', @telefono='89479578', @codigo_producto=48;
EXEC SP_INSERT_PROVEEDOR @nombre='AceitePlus49', @email='contacto@aceiteplus49.net', @telefono='82475661', @codigo_producto=49;
EXEC SP_INSERT_PROVEEDOR @nombre='MotoRepuestos50', @email='contacto@motorepuestos50.com', @telefono='84961108', @codigo_producto=50;

----------------------- PRODUCTOS -----------------------
EXEC SP_INSERT_PRODUCTO @nombre='LubricanteMultiuso1', @id_factura=1;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteHidraulico2', @id_factura=2;
EXEC SP_INSERT_PRODUCTO @nombre='CorreaDistribucion3', @id_factura=3;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteDiesel4', @id_factura=4;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteMotor5', @id_factura=5;
EXEC SP_INSERT_PRODUCTO @nombre='FiltroCombustible6', @id_factura=6;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteTransmision7', @id_factura=7;
EXEC SP_INSERT_PRODUCTO @nombre='RepuestoFrenos8', @id_factura=8;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteDiesel9', @id_factura=9;
EXEC SP_INSERT_PRODUCTO @nombre='KitEmbrague10', @id_factura=10;
EXEC SP_INSERT_PRODUCTO @nombre='FiltroAire11', @id_factura=11;
EXEC SP_INSERT_PRODUCTO @nombre='LiquidoRefrigerante12', @id_factura=12;
EXEC SP_INSERT_PRODUCTO @nombre='LiquidoRefrigerante13', @id_factura=13;
EXEC SP_INSERT_PRODUCTO @nombre='Bujia14', @id_factura=14;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteGasolina15', @id_factura=15;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteCaja16', @id_factura=16;
EXEC SP_INSERT_PRODUCTO @nombre='KitEmbrague17', @id_factura=17;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteGasolina18', @id_factura=18;
EXEC SP_INSERT_PRODUCTO @nombre='Bujia19', @id_factura=19;
EXEC SP_INSERT_PRODUCTO @nombre='LubricantePremium20', @id_factura=20;
EXEC SP_INSERT_PRODUCTO @nombre='Radiador21', @id_factura=21;
EXEC SP_INSERT_PRODUCTO @nombre='PastillasFreno22', @id_factura=22;
EXEC SP_INSERT_PRODUCTO @nombre='FiltroAceite23', @id_factura=23;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteSintetico24', @id_factura=24;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteHidraulico25', @id_factura=25;
EXEC SP_INSERT_PRODUCTO @nombre='Radiador26', @id_factura=26;
EXEC SP_INSERT_PRODUCTO @nombre='LubricantePremium27', @id_factura=27;
EXEC SP_INSERT_PRODUCTO @nombre='Radiador28', @id_factura=28;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteTransmision29', @id_factura=29;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteTransmision30', @id_factura=30;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteMotor31', @id_factura=31;
EXEC SP_INSERT_PRODUCTO @nombre='FiltroAire32', @id_factura=32;
EXEC SP_INSERT_PRODUCTO @nombre='CorreaDistribucion33', @id_factura=33;
EXEC SP_INSERT_PRODUCTO @nombre='KitEmbrague34', @id_factura=34;
EXEC SP_INSERT_PRODUCTO @nombre='FiltroAire35', @id_factura=35;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteMotor36', @id_factura=36;
EXEC SP_INSERT_PRODUCTO @nombre='KitEmbrague37', @id_factura=37;
EXEC SP_INSERT_PRODUCTO @nombre='FiltroAire38', @id_factura=38;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteHidraulico39', @id_factura=39;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteSintetico40', @id_factura=40;
EXEC SP_INSERT_PRODUCTO @nombre='PastillasFreno41', @id_factura=41;
EXEC SP_INSERT_PRODUCTO @nombre='CorreaDistribucion42', @id_factura=42;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteSintetico43', @id_factura=43;
EXEC SP_INSERT_PRODUCTO @nombre='PastillasFreno44', @id_factura=44;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteMotor45', @id_factura=45;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteMotor46', @id_factura=46;
EXEC SP_INSERT_PRODUCTO @nombre='FiltroAceite47', @id_factura=47;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteDiesel48', @id_factura=48;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteGasolina49', @id_factura=49;
EXEC SP_INSERT_PRODUCTO @nombre='AceiteCaja50', @id_factura=50;

 ----- VISTAS
CREATE VIEW v_clientes
AS
 SELECT nombre,apellido_1,apellido_2 
 FROM CLIENTE;

 --- tablas : TRABAJADORES, ROL_TRABAJDOR
 CREATE VIEW v_trabajadores
 AS
 SELECT 
 t.nombre,
 t.apellido_1,
 t.apellido_2,
 r.rol
FROM TRABAJADORES t
INNER JOIN ROL_TRABAJADOR r
	ON	t.id_trabajador = r.id_rol_trabajador;

	---tablas: CLIENTE Y FACTURAS
 CREATE VIEW v_clientesFacturas 
 AS
 SELECT
 c.id_cliente,
 c.nombre,
 c.apellido_1,
 c.apellido_2,
 f.monto_total,
 f.fecha_emision
 FROM CLIENTE c
 INNER JOIN FACTURA f
	ON c.id_cliente = f.id_cliente;

	---tablas: FACTURAS, SERVICIOS, CLIENTE, SERVICIO_FACTURA
  CREATE VIEW V_Facturas_Servicios_Clientes
  AS
  SELECT
  f.id_factura,
  f.fecha_emision,
  f.monto_total,
  f.estado_pago,
  c.id_cliente,
  c.nombre AS nombre_cliente,
  c.apellido_1,
  c.apellido_2,
  s.id_servicio,
  s.categoria,
  s.estado_servicio
  FROM FACTURA f
  INNER JOIN CLIENTE c
  ON f.id_cliente = c.id_cliente
  INNER JOIN SERVICIO_FACTURA sf
  ON f.id_factura = sf.id_factura
  INNER JOIN SERVICIO s
  ON sf.id_servicio = s.id_servicio;

  ---tablas: TELEFONO_CLIENTE_CLIENTE, CORREOS_CLIENTES_CLIENTE, CLIENTE
  CREATE VIEW  v_telefonos_clientes_correos
  AS
  SELECT 
  c.id_cliente,
  c.nombre,
  c.apellido_1,
  c.apellido_2,
  tc.telefono,
  ce.correo_electronico
  FROM CLIENTE c
  INNER JOIN TELEFONO_CLIENTE_CLIENTE tcc
  ON c.id_cliente = tcc.id_Cliente
  INNER JOIN TELEFONOS_CLIENTE tc
  ON tcc.id_cliente = tc.id_Telefono_Cliente
  INNER JOIN CORREOS_CLIENTES_CLIENTE ccc
  ON c.id_cliente = ccc.id_cliente
  INNER JOIN CORREOS_CLIENTES ce
  ON ccc.id_correos_cliente = ce.id_correos_cliente;

	SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'VEHICULO';



  CREATE VIEW v_Vehiculos_Clientes
  AS
  SELECT 
  v.id_vehiculo, 
  v.marca,
  v.modelo,
  v.anno,
  v.color,
  c.nombre AS nombre_cliente,
  c.apellido_1,
  c.apellido_2,
  tv.tipo AS tipo_vehiculo,
  fca.fecha AS id_fecha_cambio_aceite
  FROM VEHICULO v
  INNER JOIN CLIENTE c
  ON v.id_cliente = c.id_cliente
  INNER JOIN TIPO_VEHICULO tv
  ON v.id_tipo_vehiculo = tv.id_tipo_vehiculo
  INNER JOIN FECHA_CAMBIO_ACEITE fca
  ON v.id_fecha_cambio_aceite = fca.id_fecha_cambio_aceite


 SELECT * FROM v_trabajadores;
	
 SELECT * FROM v_clientesFacturas ;

 SELECT * FROM V_Facturas_Servicios_Clientes;

 SELECT * FROM v_telefonos_clientes_correos;

 SELECT * FROM v_Vehiculos_Clientes;





CREATE DATABASE SantaMaria;
USE SantaMaria;

-- 🏢 Sección: GRANJA
CREATE TABLE Granjas (
    id_granja INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(255) NOT NULL
);

CREATE TABLE Galpones (
    id_galpon INT AUTO_INCREMENT PRIMARY KEY,
    id_granja INT,
    tipo ENUM('Engorde', 'Postura', 'Reproductoras') NOT NULL,
    capacidad INT NOT NULL,
    FOREIGN KEY (id_granja) REFERENCES Granjas(id_granja)
);

CREATE TABLE Lotes (
    id_lote INT AUTO_INCREMENT PRIMARY KEY,
    id_galpon INT,
    tipo_ave ENUM('Pollos de Engorde', 'Gallinas Ponedoras') NOT NULL,
    cantidad_aves INT NOT NULL,
    fecha_ingreso DATE NOT NULL,
    FOREIGN KEY (id_galpon) REFERENCES Galpones(id_galpon)
);

CREATE TABLE Aves (
    id_ave INT AUTO_INCREMENT PRIMARY KEY,
    id_lote INT,
    tipo VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    FOREIGN KEY (id_lote) REFERENCES Lotes(id_lote)
);

CREATE TABLE Produccion (
    id_produccion INT AUTO_INCREMENT PRIMARY KEY,
    id_lote INT,
    tipo_producto ENUM('Huevos', 'Carne') NOT NULL,
    cantidad INT NOT NULL,
    unidad VARCHAR(50) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_lote) REFERENCES Lotes(id_lote)
);

CREATE TABLE Salud_Aviar (
    id_salud INT AUTO_INCREMENT PRIMARY KEY,
    id_lote INT,
    enfermedad VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    veterinario VARCHAR(100),
    FOREIGN KEY (id_lote) REFERENCES Lotes(id_lote)
);

CREATE TABLE Tratamientos (
    id_tratamiento INT AUTO_INCREMENT PRIMARY KEY,
    id_salud INT,
    medicamento VARCHAR(100) NOT NULL,
    dosis VARCHAR(50) NOT NULL,
    duracion INT NOT NULL,
    FOREIGN KEY (id_salud) REFERENCES Salud_Aviar(id_salud)
);

CREATE TABLE Registro_Eventos (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    tipo_evento ENUM('Produccion', 'Venta', 'Salud', 'Gasto', 'Ingreso') NOT NULL,
    fecha DATE NOT NULL,
    id_granja INT,
    id_galpon INT,
    id_lote INT,
    id_ave INT,
    id_empleado INT,
    id_cliente INT,
    id_cuenta INT,
    cantidad DECIMAL(12,2),
    descripcion TEXT,
    FOREIGN KEY (id_granja) REFERENCES Granjas(id_granja),
    FOREIGN KEY (id_galpon) REFERENCES Galpones(id_galpon),
    FOREIGN KEY (id_lote) REFERENCES Lotes(id_lote),
    FOREIGN KEY (id_ave) REFERENCES Aves(id_ave),
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_cuenta) REFERENCES Cuentas(id_cuenta)
);

-- 💼 Sección: PERSONAL
CREATE TABLE Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(12,2) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    id_granja INT,
    FOREIGN KEY (id_granja) REFERENCES Granjas(id_granja)
);

CREATE TABLE Asistencias (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    fecha DATE NOT NULL,
    hora_entrada TIME NOT NULL,
    hora_salida TIME,
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)
);

CREATE TABLE Roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Empleados_Roles (
    id_empleado INT,
    id_rol INT,
    PRIMARY KEY (id_empleado, id_rol),
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado),
    FOREIGN KEY (id_rol) REFERENCES Roles(id_rol)
);

CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(100),
    direccion VARCHAR(255),
    tipo_cliente ENUM('Mayorista', 'Minorista', 'Empresa') NOT NULL
);

-- 💰 Sección: CONTABILIDAD
CREATE TABLE Cuentas (
    id_cuenta INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo ENUM('Activo', 'Pasivo', 'Patrimonio') NOT NULL,
    saldo DECIMAL(12,2) NOT NULL
);

CREATE TABLE Transacciones (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    id_cuenta INT,
    fecha DATE NOT NULL,
    descripcion VARCHAR(255),
    monto DECIMAL(12,2) NOT NULL,
    tipo ENUM('Ingreso', 'Egreso') NOT NULL,
    FOREIGN KEY (id_cuenta) REFERENCES Cuentas(id_cuenta)
);

CREATE TABLE Gastos (
    id_gasto INT AUTO_INCREMENT PRIMARY KEY,
    categoria VARCHAR(100) NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    fecha DATE NOT NULL
);

CREATE TABLE Ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_produccion INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_produccion) REFERENCES Produccion(id_produccion)
);

-- 🛠️ Sección: INVENTARIO
CREATE TABLE Inventario (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    cantidad INT NOT NULL,
    unidad VARCHAR(50) NOT NULL,
    id_granja INT,
    FOREIGN KEY (id_granja) REFERENCES Granjas(id_granja)
);

CREATE TABLE Proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(100),
    direccion VARCHAR(255)
);

CREATE TABLE Compras (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT,
    fecha DATE NOT NULL,
    total DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor)
);

CREATE TABLE Detalle_Compras (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_compra INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_compra) REFERENCES Compras(id_compra),
    FOREIGN KEY (id_producto) REFERENCES Inventario(id_producto)
);

INSERT INTO Granjas (nombre, ubicacion) VALUES
('Granja Santa Rosa', 'Guadalupe, Pacasmayo, Perú'),
('Granja Los Olivos', 'Guadalupe, Pacasmayo, Perú'),
('Granja El Paraíso', 'Guadalupe, Pacasmayo, Perú'),
('Granja Santa Rosa', 'Guadalupe, Pacasmayo, Perú'),
('Granja Los Olivos', 'Guadalupe, Pacasmayo, Perú'),
('Granja El Paraíso', 'Guadalupe, Pacasmayo, Perú'),
('Granja Santa Rosa', 'Guadalupe, Pacasmayo, Perú'),
('Granja Los Olivos', 'Guadalupe, Pacasmayo, Perú'),
('Granja El Paraíso', 'Guadalupe, Pacasmayo, Perú'),
('Granja Santa Rosa', 'Guadalupe, Pacasmayo, Perú'),
('Granja Los Olivos', 'Guadalupe, Pacasmayo, Perú'),
('Granja El Paraíso', 'Guadalupe, Pacasmayo, Perú'),
('Granja Santa Rosa', 'Guadalupe, Pacasmayo, Perú'),
('Granja Los Olivos', 'Guadalupe, Pacasmayo, Perú'),
('Granja El Paraíso', 'Guadalupe, Pacasmayo, Perú'),
('Granja Santa Rosa', 'Guadalupe, Pacasmayo, Perú'),
('Granja Los Olivos', 'Guadalupe, Pacasmayo, Perú'),
('Granja El Paraíso', 'Guadalupe, Pacasmayo, Perú'),
('Granja Santa Rosa', 'Guadalupe, Pacasmayo, Perú'),
('Granja Los Olivos', 'Guadalupe, Pacasmayo, Perú'),
('Granja El Paraíso', 'Guadalupe, Pacasmayo, Perú'),
('Granja Santa Rosa', 'Guadalupe, Pacasmayo, Perú'),
('Granja Los Olivos', 'Guadalupe, Pacasmayo, Perú'),
('Granja El Paraíso', 'Guadalupe, Pacasmayo, Perú'),
('Granja Santa Rosa', 'Guadalupe, Pacasmayo, Perú'),
('Granja Los Olivos', 'Guadalupe, Pacasmayo, Perú'),
('Granja El Paraíso', 'Guadalupe, Pacasmayo, Perú'),
('Granja Santa Rosa', 'Guadalupe, Pacasmayo, Perú'),
('Granja Los Olivos', 'Guadalupe, Pacasmayo, Perú'),
('Granja El Paraíso', 'Guadalupe, Pacasmayo, Perú');



INSERT INTO Galpones (id_granja, tipo, capacidad) VALUES
(1, 'Postura', 500),
(2, 'Reproductoras', 600),
(3, 'Postura', 700),
(4, 'Reproductoras', 550),
(5, 'Postura', 800),
(6, 'Reproductoras', 900),
(7, 'Postura', 750),
(8, 'Reproductoras', 850),
(9, 'Postura', 650),
(10, 'Reproductoras', 700),
(11, 'Postura', 600),
(12, 'Reproductoras', 750),
(13, 'Postura', 550),
(14, 'Reproductoras', 800),
(15, 'Postura', 700),
(16, 'Reproductoras', 950),
(17, 'Postura', 620),
(18, 'Reproductoras', 880),
(19, 'Postura', 690),
(20, 'Reproductoras', 720),
(21, 'Postura', 580),
(22, 'Reproductoras', 640),
(23, 'Postura', 710),
(24, 'Reproductoras', 760),
(25, 'Postura', 690),
(26, 'Reproductoras', 920),
(27, 'Postura', 740),
(28, 'Reproductoras', 810),
(29, 'Postura', 670),
(30, 'Reproductoras', 780);



INSERT INTO Lotes (id_galpon, tipo_ave, cantidad_aves, fecha_ingreso) VALUES
(1, 'Gallinas Ponedoras', 500, '2024-02-05'),
(2, 'Gallinas Ponedoras', 600, '2024-02-07'),
(3, 'Gallinas Ponedoras', 700, '2024-02-10'),
(4, 'Gallinas Ponedoras', 550, '2024-02-12'),
(5, 'Gallinas Ponedoras', 800, '2024-02-15'),
(6, 'Gallinas Ponedoras', 900, '2024-02-17'),
(7, 'Gallinas Ponedoras', 750, '2024-02-20'),
(8, 'Gallinas Ponedoras', 850, '2024-02-22'),
(9, 'Gallinas Ponedoras', 650, '2024-02-25'),
(10, 'Gallinas Ponedoras', 700, '2024-02-28'),
(11, 'Gallinas Ponedoras', 600, '2023-02-05'),
(12, 'Gallinas Ponedoras', 750, '2023-02-07'),
(13, 'Gallinas Ponedoras', 550, '2023-02-10'),
(14, 'Gallinas Ponedoras', 800, '2023-02-12'),
(15, 'Gallinas Ponedoras', 700, '2023-02-15'),
(16, 'Gallinas Ponedoras', 950, '2023-02-17'),
(17, 'Gallinas Ponedoras', 620, '2023-02-20'),
(18, 'Gallinas Ponedoras', 880, '2023-02-22'),
(19, 'Gallinas Ponedoras', 690, '2023-02-25'),
(20, 'Gallinas Ponedoras', 720, '2023-02-28'),
(21, 'Gallinas Ponedoras', 580, '2022-01-10'),
(22, 'Gallinas Ponedoras', 640, '2022-01-12'),
(23, 'Gallinas Ponedoras', 710, '2022-01-15'),
(24, 'Gallinas Ponedoras', 760, '2022-01-18'),
(25, 'Gallinas Ponedoras', 690, '2022-01-20'),
(26, 'Gallinas Ponedoras', 920, '2022-01-23'),
(27, 'Gallinas Ponedoras', 740, '2022-01-26'),
(28, 'Gallinas Ponedoras', 810, '2022-01-28'),
(29, 'Gallinas Ponedoras', 670, '2022-01-30'),
(30, 'Gallinas Ponedoras', 780, '2022-02-02');



INSERT INTO Aves (id_lote, tipo, edad) VALUES
(1, 'Gallina', 18),
(2, 'Pollo', 5),
(3, 'Gallina', 20),
(4, 'Pollo', 8),
(5, 'Gallina', 22),
(6, 'Pollo', 6),
(7, 'Gallina', 24),
(8, 'Pollo', 7),
(9, 'Gallina', 21),
(10, 'Pollo', 4),
(11, 'Gallina', 19),
(12, 'Pollo', 5),
(13, 'Gallina', 20),
(14, 'Pollo', 6),
(15, 'Gallina', 22),
(16, 'Pollo', 8),
(17, 'Gallina', 23),
(18, 'Pollo', 9),
(19, 'Gallina', 25),
(20, 'Pollo', 7),
(21, 'Gallina', 18),
(22, 'Pollo', 4),
(23, 'Gallina', 20),
(24, 'Pollo', 6),
(25, 'Gallina', 21),
(26, 'Pollo', 5),
(27, 'Gallina', 22),
(28, 'Pollo', 7),
(29, 'Gallina', 24),
(30, 'Pollo', 8);



INSERT INTO Produccion (id_lote, tipo_producto, cantidad, unidad, fecha) VALUES
(1, 'Huevos', 1200, 'unidades', '2024-02-05'),
(2, 'Huevos', 1350, 'unidades', '2024-02-07'),
(3, 'Huevos', 1500, 'unidades', '2024-02-10'),
(4, 'Huevos', 1250, 'unidades', '2024-02-12'),
(5, 'Huevos', 1600, 'unidades', '2024-02-15'),
(6, 'Huevos', 1800, 'unidades', '2024-02-17'),
(7, 'Huevos', 1550, 'unidades', '2024-02-20'),
(8, 'Huevos', 1700, 'unidades', '2024-02-22'),
(9, 'Huevos', 1400, 'unidades', '2024-02-25'),
(10, 'Huevos', 1450, 'unidades', '2024-02-28'),
(11, 'Huevos', 1300, 'unidades', '2023-02-05'),
(12, 'Huevos', 1400, 'unidades', '2023-02-07'),
(13, 'Huevos', 1250, 'unidades', '2023-02-10'),
(14, 'Huevos', 1550, 'unidades', '2023-02-12'),
(15, 'Huevos', 1450, 'unidades', '2023-02-15'),
(16, 'Huevos', 1750, 'unidades', '2023-02-17'),
(17, 'Huevos', 1350, 'unidades', '2023-02-20'),
(18, 'Huevos', 1650, 'unidades', '2023-02-22'),
(19, 'Huevos', 1380, 'unidades', '2023-02-25'),
(20, 'Huevos', 1420, 'unidades', '2023-02-28'),
(21, 'Huevos', 1250, 'unidades', '2022-01-10'),
(22, 'Huevos', 1300, 'unidades', '2022-01-12'),
(23, 'Huevos', 1400, 'unidades', '2022-01-15'),
(24, 'Huevos', 1450, 'unidades', '2022-01-18'),
(25, 'Huevos', 1350, 'unidades', '2022-01-20'),
(26, 'Huevos', 1750, 'unidades', '2022-01-23'),
(27, 'Huevos', 1480, 'unidades', '2022-01-26'),
(28, 'Huevos', 1600, 'unidades', '2022-01-28'),
(29, 'Huevos', 1330, 'unidades', '2022-01-30'),
(30, 'Huevos', 1500, 'unidades', '2022-02-02');



INSERT INTO Salud_Aviar (id_lote, enfermedad, fecha, veterinario) VALUES
(1, 'Newcastle', '2024-02-05', 'Dr. Juan Pérez'),
(2, 'Coccidiosis', '2024-02-07', 'Dra. María López'),
(3, 'Bronquitis infecciosa', '2024-02-10', 'Dr. Carlos Mendoza'),
(4, 'Newcastle', '2024-02-12', 'Dra. Patricia Gómez'),
(5, 'Coccidiosis', '2024-02-15', 'Dr. Ricardo Fernández'),
(6, 'Bronquitis infecciosa', '2024-02-17', 'Dra. Ana Torres'),
(7, 'Newcastle', '2024-02-20', 'Dr. Eduardo Ramírez'),
(8, 'Coccidiosis', '2024-02-22', 'Dra. Silvia Herrera'),
(9, 'Bronquitis infecciosa', '2024-02-25', 'Dr. Fernando Ortega'),
(10, 'Newcastle', '2024-02-28', 'Dra. Gabriela Ríos'),
(11, 'Newcastle', '2023-02-05', 'Dr. Juan Pérez'),
(12, 'Coccidiosis', '2023-02-07', 'Dra. María López'),
(13, 'Bronquitis infecciosa', '2023-02-10', 'Dr. Carlos Mendoza'),
(14, 'Newcastle', '2023-02-12', 'Dra. Patricia Gómez'),
(15, 'Coccidiosis', '2023-02-15', 'Dr. Ricardo Fernández'),
(16, 'Bronquitis infecciosa', '2023-02-17', 'Dra. Ana Torres'),
(17, 'Newcastle', '2023-02-20', 'Dr. Eduardo Ramírez'),
(18, 'Coccidiosis', '2023-02-22', 'Dra. Silvia Herrera'),
(19, 'Bronquitis infecciosa', '2023-02-25', 'Dr. Fernando Ortega'),
(20, 'Newcastle', '2023-02-28', 'Dra. Gabriela Ríos'),
(21, 'Newcastle', '2022-01-10', 'Dr. Juan Pérez'),
(22, 'Coccidiosis', '2022-01-12', 'Dra. María López'),
(23, 'Bronquitis infecciosa', '2022-01-15', 'Dr. Carlos Mendoza'),
(24, 'Newcastle', '2022-01-18', 'Dra. Patricia Gómez'),
(25, 'Coccidiosis', '2022-01-20', 'Dr. Ricardo Fernández'),
(26, 'Bronquitis infecciosa', '2022-01-23', 'Dra. Ana Torres'),
(27, 'Newcastle', '2022-01-26', 'Dr. Eduardo Ramírez'),
(28, 'Coccidiosis', '2022-01-28', 'Dra. Silvia Herrera'),
(29, 'Bronquitis infecciosa', '2022-01-30', 'Dr. Fernando Ortega'),
(30, 'Newcastle', '2022-02-02', 'Dra. Gabriela Ríos');


INSERT INTO Tratamientos (id_tratamiento, id_salud, medicamento, dosis, duracion) VALUES
(1, 1, 'Antibiótico A', '2 ml/L agua', 5),
(2, 2, 'Vacuna B', '1 dosis/ave', 1),
(3, 3, 'Inmunomodulador C', '5 mg/kg', 7),
(4, 4, 'Antibiótico A', '3 ml/L agua', 6),
(5, 5, 'Vacuna B', '1 dosis/ave', 1),
(6, 6, 'Inmunomodulador C', '6 mg/kg', 5),
(7, 7, 'Antibiótico D', '2.5 ml/L agua', 4),
(8, 8, 'Vacuna B', '1 dosis/ave', 1),
(9, 9, 'Inmunomodulador C', '4 mg/kg', 6),
(10, 10, 'Antibiótico A', '3 ml/L agua', 5),
(11, 11, 'Vacuna B', '1 dosis/ave', 1),
(12, 12, 'Inmunomodulador C', '5 mg/kg', 7),
(13, 13, 'Antibiótico A', '2 ml/L agua', 5),
(14, 14, 'Vacuna B', '1 dosis/ave', 1),
(15, 15, 'Inmunomodulador C', '6 mg/kg', 5),
(16, 16, 'Antibiótico D', '2.5 ml/L agua', 4),
(17, 17, 'Vacuna B', '1 dosis/ave', 1),
(18, 18, 'Inmunomodulador C', '4 mg/kg', 6),
(19, 19, 'Antibiótico A', '3 ml/L agua', 5),
(20, 20, 'Vacuna B', '1 dosis/ave', 1),
(21, 21, 'Inmunomodulador C', '5 mg/kg', 7),
(22, 22, 'Antibiótico A', '2 ml/L agua', 5),
(23, 23, 'Vacuna B', '1 dosis/ave', 1),
(24, 24, 'Inmunomodulador C', '6 mg/kg', 5),
(25, 25, 'Antibiótico D', '2.5 ml/L agua', 4),
(26, 26, 'Vacuna B', '1 dosis/ave', 1),
(27, 27, 'Inmunomodulador C', '4 mg/kg', 6),
(28, 28, 'Antibiótico A', '3 ml/L agua', 5),
(29, 29, 'Vacuna B', '1 dosis/ave', 1),
(30, 30, 'Inmunomodulador C', '5 mg/kg', 7);


INSERT INTO Empleados (id_empleado, nombre, cargo, salario, fecha_contratacion, id_granja) VALUES
(1, 'Carlos Gómez', 'Encargado de Galpón', 2500.00, '2024-02-10', 1),
(2, 'Ana Torres', 'Veterinaria', 3200.00, '2024-02-12', 2),
(3, 'José Pérez', 'Operario', 1800.00, '2024-02-15', 3),
(4, 'María López', 'Supervisora', 2800.00, '2024-02-20', 1),
(5, 'Pedro Ramírez', 'Mantenimiento', 2000.00, '2024-02-25', 2),
(6, 'Lucía Fernández', 'Administradora', 3500.00, '2024-03-01', 3),
(7, 'Javier Méndez', 'Operario', 1850.00, '2024-03-05', 1),
(8, 'Sofía Herrera', 'Veterinaria', 3300.00, '2024-03-08', 2),
(9, 'Ricardo Vargas', 'Encargado de Producción', 2900.00, '2024-03-12', 3),
(10, 'Andrea Castro', 'Supervisora', 2750.00, '2024-03-15', 1),
(11, 'David Rojas', 'Encargado de Galpón', 2550.00, '2023-02-06', 2),
(12, 'Gabriela Salinas', 'Veterinaria', 3150.00, '2023-02-10', 3),
(13, 'Fernando Díaz', 'Operario', 1900.00, '2023-02-14', 1),
(14, 'Laura Medina', 'Supervisora', 2850.00, '2023-02-18', 2),
(15, 'Sergio Núñez', 'Mantenimiento', 2050.00, '2023-02-22', 3),
(16, 'Carolina Estrada', 'Administradora', 3450.00, '2023-02-26', 1),
(17, 'Pablo Jiménez', 'Operario', 1750.00, '2023-03-02', 2),
(18, 'Valeria Guzmán', 'Veterinaria', 3250.00, '2023-03-07', 3),
(19, 'Hugo Sandoval', 'Encargado de Producción', 2950.00, '2023-03-11', 1),
(20, 'Rosa Aguilar', 'Supervisora', 2700.00, '2023-03-14', 2),
(21, 'Luis Castillo', 'Encargado de Galpón', 2600.00, '2022-01-11', 3),
(22, 'Elena Paredes', 'Veterinaria', 3100.00, '2022-01-14', 1),
(23, 'Cristian Herrera', 'Operario', 1700.00, '2022-01-18', 2),
(24, 'Daniela Flores', 'Supervisora', 2900.00, '2022-01-22', 3),
(25, 'Martín Chávez', 'Mantenimiento', 1950.00, '2022-01-26', 1),
(26, 'Estefanía Ríos', 'Administradora', 3600.00, '2022-02-01', 2),
(27, 'Roberto Vega', 'Operario', 1800.00, '2022-02-05', 3),
(28, 'Natalia Cárdenas', 'Veterinaria', 3350.00, '2022-02-09', 1),
(29, 'Óscar Ramírez', 'Encargado de Producción', 2800.00, '2022-02-13', 2),
(30, 'Verónica Acosta', 'Supervisora', 2650.00, '2022-02-17', 3);


INSERT INTO Asistencias (id_asistencia, id_empleado, fecha, hora_entrada, hora_salida) VALUES
(1, 1, '2024-02-10', '08:00:00', '13:00:00'),
(2, 2, '2024-02-11', '08:00:00', '13:00:00'),
(3, 3, '2024-02-12', '08:00:00', '13:00:00'),
(4, 4, '2024-02-13', '08:00:00', '13:00:00'),
(5, 5, '2024-02-14', '08:00:00', '13:00:00'),
(6, 6, '2024-02-15', '08:00:00', '13:00:00'),
(7, 7, '2024-02-16', '08:00:00', '13:00:00'),
(8, 8, '2024-02-17', '08:00:00', '13:00:00'),
(9, 9, '2024-02-18', '08:00:00', '13:00:00'),
(10, 10, '2024-02-19', '08:00:00', '13:00:00'),
(11, 11, '2023-02-06', '08:00:00', '13:00:00'),
(12, 12, '2023-02-07', '08:00:00', '13:00:00'),
(13, 13, '2023-02-08', '08:00:00', '13:00:00'),
(14, 14, '2023-02-09', '08:00:00', '13:00:00'),
(15, 15, '2023-02-10', '08:00:00', '13:00:00'),
(16, 16, '2023-02-11', '08:00:00', '13:00:00'),
(17, 17, '2023-02-12', '08:00:00', '13:00:00'),
(18, 18, '2023-02-13', '08:00:00', '13:00:00'),
(19, 19, '2023-02-14', '08:00:00', '13:00:00'),
(20, 20, '2023-02-15', '08:00:00', '13:00:00'),
(21, 21, '2022-01-11', '08:00:00', '13:00:00'),
(22, 22, '2022-01-12', '08:00:00', '13:00:00'),
(23, 23, '2022-01-13', '08:00:00', '13:00:00'),
(24, 24, '2022-01-14', '08:00:00', '13:00:00'),
(25, 25, '2022-01-15', '08:00:00', '13:00:00'),
(26, 26, '2022-01-16', '08:00:00', '13:00:00'),
(27, 27, '2022-01-17', '08:00:00', '13:00:00'),
(28, 28, '2022-01-18', '08:00:00', '13:00:00'),
(29, 29, '2022-01-19', '08:00:00', '13:00:00'),
(30, 30, '2022-01-20', '08:00:00', '13:00:00');


INSERT INTO Roles (id_rol, nombre) VALUES
(1, 'Administrador'),
(2, 'Veterinario'),
(3, 'Gerente'),
(4, 'Supervisor'),
(5, 'Operario'),
(6, 'Contador'),
(7, 'Vendedor'),
(8, 'Asistente'),
(9, 'Mantenimiento'),
(10, 'Seguridad');

INSERT INTO Empleados_Roles (id_empleado, id_rol)
VALUES
(1, 1),  -- Empleado 1, Rol 1
(2, 2),  -- Empleado 2, Rol 2
(3, 3),  -- Empleado 3, Rol 3
(4, 4),  -- Empleado 4, Rol 4
(5, 1),  -- Empleado 5, Rol 1
(6, 2),  -- Empleado 6, Rol 2
(7, 3),  -- Empleado 7, Rol 3
(8, 4),  -- Empleado 8, Rol 4
(9, 1),  -- Empleado 9, Rol 1
(10, 2), -- Empleado 10, Rol 2
(11, 3), -- Empleado 11, Rol 3
(12, 4), -- Empleado 12, Rol 4
(13, 1), -- Empleado 13, Rol 1
(14, 2), -- Empleado 14, Rol 2
(15, 3), -- Empleado 15, Rol 3
(16, 4), -- Empleado 16, Rol 4
(17, 1), -- Empleado 17, Rol 1
(18, 2), -- Empleado 18, Rol 2
(19, 3), -- Empleado 19, Rol 3
(20, 4), -- Empleado 20, Rol 4
(21, 1), -- Empleado 21, Rol 1
(22, 2), -- Empleado 22, Rol 2
(23, 3), -- Empleado 23, Rol 3
(24, 4), -- Empleado 24, Rol 4
(25, 1), -- Empleado 25, Rol 1
(26, 2), -- Empleado 26, Rol 2
(27, 3), -- Empleado 27, Rol 3
(28, 4), -- Empleado 28, Rol 4
(29, 1), -- Empleado 29, Rol 1
(30, 2); -- Empleado 30, Rol 2

INSERT INTO Clientes (id_cliente, nombre, contacto, direccion, tipo_cliente)
VALUES
(1, 'Juan Pérez', '912345678', 'Calle Los Pinos 101, Guadalupe', 'Minorista'),
(2, 'María López', '987654321', 'Av. Central 202, Pacasmayo', 'Mayorista'),
(3, 'Carlos García', '976543210', 'Jr. Libertad 303, Ciudad de Dios', 'Empresa'),
(4, 'Ana Rodríguez', '965432109', 'Calle Los Olivos 404, Pueblo Nuevo', 'Minorista'),
(5, 'Luis Fernández', '954321098', 'Av. Industrial 505, Trujillo', 'Mayorista'),
(6, 'Carmen González', '943210987', 'Calle Real 606, Chiclayo', 'Empresa'),
(7, 'José Martínez', '932109876', 'Calle Nueva 707, Guadalupe', 'Minorista'),
(8, 'Rosa Sánchez', '921098765', 'Av. del Mar 808, Pacasmayo', 'Mayorista'),
(9, 'David Romero', '910987654', 'Jr. del Sol 909, Ciudad de Dios', 'Empresa'),
(10, 'Laura Díaz', '909876543', 'Calle de la Amistad 111, Pueblo Nuevo', 'Minorista'),
(11, 'Miguel Torres', '898765432', 'Av. Libertad 222, Trujillo', 'Mayorista'),
(12, 'Patricia Ramírez', '887654321', 'Calle Los Cedros 333, Chiclayo', 'Empresa'),
(13, 'Jorge Morales', '876543210', 'Jr. Independencia 444, Guadalupe', 'Minorista'),
(14, 'Sandra Herrera', '865432109', 'Av. Sol 555, Pacasmayo', 'Mayorista'),
(15, 'Alberto Castro', '854321098', 'Calle Las Flores 666, Ciudad de Dios', 'Empresa'),
(16, 'Juan Pérez', '912345678', 'Calle Los Pinos 101, Guadalupe', 'Minorista'),
(17, 'María López', '987654321', 'Av. Central 202, Pacasmayo', 'Mayorista'),
(18, 'Carlos García', '976543210', 'Jr. Libertad 303, Ciudad de Dios', 'Empresa'),
(19, 'Ana Rodríguez', '965432109', 'Calle Los Olivos 404, Pueblo Nuevo', 'Minorista'),
(20, 'Luis Fernández', '954321098', 'Av. Industrial 505, Trujillo', 'Mayorista'),
(21, 'Carmen González', '943210987', 'Calle Real 606, Chiclayo', 'Empresa'),
(22, 'José Martínez', '932109876', 'Calle Nueva 707, Guadalupe', 'Minorista'),
(23, 'Rosa Sánchez', '921098765', 'Av. del Mar 808, Pacasmayo', 'Mayorista'),
(24, 'David Romero', '910987654', 'Jr. del Sol 909, Ciudad de Dios', 'Empresa'),
(25, 'Laura Díaz', '909876543', 'Calle de la Amistad 111, Pueblo Nuevo', 'Minorista'),
(26, 'Miguel Torres', '898765432', 'Av. Libertad 222, Trujillo', 'Mayorista'),
(27, 'Patricia Ramírez', '887654321', 'Calle Los Cedros 333, Chiclayo', 'Empresa'),
(28, 'Jorge Morales', '876543210', 'Jr. Independencia 444, Guadalupe', 'Minorista'),
(29, 'Sandra Herrera', '865432109', 'Av. Sol 555, Pacasmayo', 'Mayorista'),
(30, 'Alberto Castro', '854321098', 'Calle Las Flores 666, Ciudad de Dios', 'Empresa');

INSERT INTO Cuentas (nombre, tipo, saldo)
VALUES
('Caja General', 'Activo', 15000.00),
('Bancos', 'Activo', 50000.00),
('Cuentas por Pagar', 'Pasivo', 8000.00),
('Capital Social', 'Patrimonio', 100000.00),
('Proveedores', 'Pasivo', 12000.00);

INSERT INTO Transacciones (id_transaccion, id_cuenta, fecha, descripcion, monto, tipo)
VALUES
-- Transacciones para 2024
(1, 1, '2024-02-05', 'Ingreso por venta de huevos', 2000.00, 'Ingreso'),
(2, 2, '2024-02-07', 'Pago de suministros', 1500.00, 'Egreso'),
(3, 3, '2024-02-10', 'Ingreso por venta de pollos', 3000.00, 'Ingreso'),
(4, 4, '2024-02-12', 'Pago de servicios', 1200.00, 'Egreso'),
(5, 5, '2024-02-15', 'Ingreso por productos avícolas', 2500.00, 'Ingreso'),
(6, 1, '2024-02-17', 'Retiro de caja', 500.00, 'Egreso'),
(7, 2, '2024-02-20', 'Ingreso por venta de huevos', 1800.00, 'Ingreso'),
(8, 3, '2024-02-22', 'Pago a proveedor', 2200.00, 'Egreso'),
(9, 4, '2024-02-25', 'Ingreso por servicios', 2600.00, 'Ingreso'),
(10, 5, '2024-02-28', 'Pago de mantenimiento', 800.00, 'Egreso'),

-- Transacciones para 2023
(11, 1, '2023-02-05', 'Ingreso por venta de productos', 2100.00, 'Ingreso'),
(12, 2, '2023-02-07', 'Pago de salarios', 1600.00, 'Egreso'),
(13, 3, '2023-02-10', 'Ingreso por venta de pollos', 3100.00, 'Ingreso'),
(14, 4, '2023-02-12', 'Pago de servicios externos', 1300.00, 'Egreso'),
(15, 5, '2023-02-15', 'Ingreso por venta de huevos', 2400.00, 'Ingreso'),
(16, 1, '2023-02-17', 'Retiro de caja', 600.00, 'Egreso'),
(17, 2, '2023-02-20', 'Ingreso por productos avícolas', 1900.00, 'Ingreso'),
(18, 3, '2023-02-22', 'Pago a proveedor', 2300.00, 'Egreso'),
(19, 4, '2023-02-25', 'Ingreso por servicios', 2700.00, 'Ingreso'),
(20, 5, '2023-02-28', 'Pago de mantenimiento', 900.00, 'Egreso'),

-- Transacciones para 2022
(21, 1, '2022-01-10', 'Ingreso por venta de productos', 2200.00, 'Ingreso'),
(22, 2, '2022-01-12', 'Pago de suministros', 1400.00, 'Egreso'),
(23, 3, '2022-01-15', 'Ingreso por venta de pollos', 3200.00, 'Ingreso'),
(24, 4, '2022-01-18', 'Pago de servicios', 1100.00, 'Egreso'),
(25, 5, '2022-01-20', 'Ingreso por productos avícolas', 2600.00, 'Ingreso'),
(26, 1, '2022-01-23', 'Retiro de caja', 700.00, 'Egreso'),
(27, 2, '2022-01-26', 'Ingreso por venta de huevos', 2000.00, 'Ingreso'),
(28, 3, '2022-01-28', 'Pago a proveedor', 2400.00, 'Egreso'),
(29, 4, '2022-01-30', 'Ingreso por servicios', 2800.00, 'Ingreso'),
(30, 5, '2022-02-02', 'Pago de mantenimiento', 1000.00, 'Egreso');


INSERT INTO Gastos (id_gasto, categoria, monto, fecha)
VALUES
-- Registros para 2024
(1, 'Alimento', 1200.00, '2024-02-05'),
(2, 'Mantenimiento', 800.00, '2024-02-07'),
(3, 'Suministros', 1500.00, '2024-02-10'),
(4, 'Salud', 500.00, '2024-02-12'),
(5, 'Energía', 900.00, '2024-02-15'),
(6, 'Transporte', 400.00, '2024-02-17'),
(7, 'Publicidad', 300.00, '2024-02-20'),
(8, 'Impuestos', 700.00, '2024-02-22'),
(9, 'Seguridad', 600.00, '2024-02-25'),
(10, 'Otros', 350.00, '2024-02-28'),

-- Registros para 2023
(11, 'Alimento', 1100.00, '2023-02-05'),
(12, 'Mantenimiento', 850.00, '2023-02-07'),
(13, 'Suministros', 1400.00, '2023-02-10'),
(14, 'Salud', 550.00, '2023-02-12'),
(15, 'Energía', 950.00, '2023-02-15'),
(16, 'Transporte', 450.00, '2023-02-17'),
(17, 'Publicidad', 320.00, '2023-02-20'),
(18, 'Impuestos', 680.00, '2023-02-22'),
(19, 'Seguridad', 620.00, '2023-02-25'),
(20, 'Otros', 360.00, '2023-02-28'),

-- Registros para 2022
(21, 'Alimento', 1000.00, '2022-01-10'),
(22, 'Mantenimiento', 800.00, '2022-01-12'),
(23, 'Suministros', 1300.00, '2022-01-15'),
(24, 'Salud', 500.00, '2022-01-18'),
(25, 'Energía', 850.00, '2022-01-20'),
(26, 'Transporte', 400.00, '2022-01-23'),
(27, 'Publicidad', 300.00, '2022-01-26'),
(28, 'Impuestos', 650.00, '2022-01-28'),
(29, 'Seguridad', 600.00, '2022-01-30'),
(30, 'Otros', 350.00, '2022-02-02');


INSERT INTO Ventas (id_venta, id_cliente, id_produccion, cantidad, precio_unitario, fecha)
VALUES
-- Ventas correspondientes a producción de 2024 (id_produccion 1 a 10)
(1,  1,  1, 300, 0.50, '2024-02-06'),
(2,  2,  2, 400, 0.55, '2024-02-08'),
(3,  3,  3, 350, 0.60, '2024-02-11'),
(4,  4,  4, 450, 0.50, '2024-02-13'),
(5,  5,  5, 500, 0.65, '2024-02-16'),
(6,  6,  6, 550, 0.55, '2024-02-18'),
(7,  7,  7, 600, 0.60, '2024-02-21'),
(8,  8,  8, 650, 0.50, '2024-02-23'),
(9,  9,  9, 700, 0.55, '2024-02-26'),
(10, 10, 10, 750, 0.60, '2024-03-01'),

-- Ventas correspondientes a producción de 2023 (id_produccion 11 a 20)
(11, 11, 11, 300, 0.50, '2023-02-06'),
(12, 12, 12, 350, 0.55, '2023-02-08'),
(13, 13, 13, 400, 0.60, '2023-02-11'),
(14, 14, 14, 450, 0.50, '2023-02-13'),
(15, 15, 15, 500, 0.65, '2023-02-16'),
(16, 16, 16, 550, 0.55, '2023-02-18'),
(17, 17, 17, 600, 0.60, '2023-02-21'),
(18, 18, 18, 650, 0.50, '2023-02-23'),
(19, 19, 19, 700, 0.55, '2023-02-26'),
(20, 20, 20, 750, 0.60, '2023-03-01'),

-- Ventas correspondientes a producción de 2022 (id_produccion 21 a 30)
(21, 21, 21, 300, 0.50, '2022-01-11'),
(22, 22, 22, 350, 0.55, '2022-01-13'),
(23, 23, 23, 400, 0.60, '2022-01-16'),
(24, 24, 24, 450, 0.50, '2022-01-19'),
(25, 25, 25, 500, 0.65, '2022-01-21'),
(26, 26, 26, 550, 0.55, '2022-01-24'),
(27, 27, 27, 600, 0.60, '2022-01-27'),
(28, 28, 28, 650, 0.50, '2022-01-29'),
(29, 29, 29, 700, 0.55, '2022-01-31'),
(30, 30, 30, 750, 0.60, '2022-02-03');

INSERT INTO Inventario (id_producto, nombre_producto, cantidad, unidad, id_granja)
VALUES
(1, 'Pienso para pollos', 500, 'kg', 1),
(2, 'Vitamina para aves', 200, 'litros', 2),
(3, 'Antibiótico A', 150, 'unidades', 3),
(4, 'Insumos de limpieza', 300, 'unidades', 4),
(5, 'Granos de maíz', 1000, 'kg', 5),
(6, 'Saco de fertilizante', 50, 'unidades', 6),
(7, 'Semillas de maíz', 200, 'kg', 7),
(8, 'Cereal para aves', 400, 'kg', 8),
(9, 'Concentrado proteico', 250, 'kg', 9),
(10, 'Aditivo alimentario', 100, 'litros', 10),
(11, 'Suplemento vitamínico', 300, 'unidades', 11),
(12, 'Antiparasitario', 180, 'litros', 12),
(13, 'Equipos de riego', 20, 'unidades', 13),
(14, 'Herramientas de mantenimiento', 60, 'unidades', 14),
(15, 'Insumos de higiene', 500, 'unidades', 15),
(16, 'Pienso para pollos', 600, 'kg', 16),
(17, 'Vitamina para aves', 250, 'litros', 17),
(18, 'Antibiótico B', 160, 'unidades', 18),
(19, 'Insumos de limpieza', 320, 'unidades', 19),
(20, 'Granos de maíz', 1100, 'kg', 20),
(21, 'Saco de fertilizante', 55, 'unidades', 21),
(22, 'Semillas de maíz', 210, 'kg', 22),
(23, 'Cereal para aves', 420, 'kg', 23),
(24, 'Concentrado proteico', 260, 'kg', 24),
(25, 'Aditivo alimentario', 105, 'litros', 25),
(26, 'Suplemento vitamínico', 310, 'unidades', 26),
(27, 'Antiparasitario', 190, 'litros', 27),
(28, 'Equipos de riego', 22, 'unidades', 28),
(29, 'Herramientas de mantenimiento', 65, 'unidades', 29),
(30, 'Insumos de higiene', 520, 'unidades', 30);

INSERT INTO Proveedores (id_proveedor, nombre, contacto, direccion)
VALUES
(1, 'Agroinsumos del Norte', '987654321', 'Calle Los Pinos 101, Guadalupe'),
(2, 'Suministros Agropecuarios', '912345678', 'Av. Central 202, Pacasmayo'),
(3, 'Distribuidora Andina', '976543210', 'Jr. Libertad 303, Ciudad de Dios'),
(4, 'Insumos Modernos', '965432109', 'Calle Los Olivos 404, Pueblo Nuevo'),
(5, 'Fertilizantes del Sur', '954321098', 'Av. Industrial 505, Trujillo'),
(6, 'Equipos Agrícolas S.A.', '943210987', 'Calle Real 606, Chiclayo'),
(7, 'Soluciones Agro', '932109876', 'Calle Nueva 707, Guadalupe'),
(8, 'Agro Tech', '921098765', 'Av. del Mar 808, Pacasmayo'),
(9, 'Proveedores del Pacífico', '910987654', 'Jr. del Sol 909, Ciudad de Dios'),
(10, 'AgroInnovación', '909876543', 'Calle de la Amistad 111, Pueblo Nuevo');

INSERT INTO Compras (id_compra, id_proveedor, fecha, total)
VALUES
-- Compras correspondientes a 2024
(1, 1, '2024-02-05', 1500.00),
(2, 2, '2024-02-07', 2200.00),
(3, 3, '2024-02-10', 1800.00),
(4, 4, '2024-02-12', 2500.00),
(5, 5, '2024-02-15', 3000.00),
(6, 6, '2024-02-17', 1700.00),
(7, 7, '2024-02-20', 2000.00),

-- Compras correspondientes a 2023
(8, 8, '2023-02-05', 1400.00),
(9, 9, '2023-02-07', 2100.00),
(10, 10, '2023-02-10', 1900.00),
(11, 1, '2023-02-12', 2300.00),
(12, 2, '2023-02-15', 2500.00),
(13, 3, '2023-02-17', 1600.00),
(14, 4, '2023-02-20', 2200.00),

-- Compras correspondientes a 2022
(15, 5, '2022-01-10', 1300.00),
(16, 6, '2022-01-12', 2400.00),
(17, 7, '2022-01-15', 1800.00),
(18, 8, '2022-01-18', 2000.00),
(19, 9, '2022-01-20', 2100.00),
(20, 10, '2022-01-23', 1900.00);

INSERT INTO Detalle_Compras (id_detalle, id_compra, id_producto, cantidad, precio_unitario)
VALUES
(1, 1, 1, 50, 30.00),      -- Compra 1 (2024) de "Pienso para pollos"
(2, 2, 2, 20, 25.50),      -- Compra 2 (2024) de "Vitamina para aves"
(3, 3, 3, 10, 45.00),      -- Compra 3 (2024) de "Antibiótico A"
(4, 4, 4, 15, 12.00),      -- Compra 4 (2024) de "Insumos de limpieza"
(5, 5, 5, 100, 5.75),      -- Compra 5 (2024) de "Granos de maíz"
(6, 6, 6, 5, 150.00),      -- Compra 6 (2024) de "Saco de fertilizante"
(7, 7, 7, 30, 20.00),      -- Compra 7 (2024) de "Semillas de maíz"
(8, 8, 8, 40, 8.25),       -- Compra 8 (2023) de "Cereal para aves"
(9, 9, 9, 25, 14.50),      -- Compra 9 (2023) de "Concentrado proteico"
(10, 10, 10, 10, 60.00);   -- Compra 10 (2023) de "Aditivo alimentario"


INSERT INTO Registro_Eventos (id_evento, tipo_evento, fecha, id_granja, id_galpon, id_lote, id_ave, id_empleado, id_cliente, id_cuenta, cantidad, descripcion)
VALUES
(1, 'Produccion', '2024-02-10', 1, 1, 1, 1, 3, NULL, NULL, 500, 'Producción de 500 huevos de gallinas ponedoras.'),
(2, 'Venta', '2024-02-11', 1, 1, 1, 2, 2, 1, 1, 2500, 'Venta de 2500 huevos a cliente "Juan Pérez".'),
(3, 'Salud', '2024-02-12', 1, 1, 1, 3, 4, NULL, NULL, 100, 'Tratamiento con vitamina para mejorar la salud de las aves.'),
(4, 'Gasto', '2024-02-13', 2, 2, 2, 4, 1, NULL, 1, 1200, 'Compra de insumos veterinarios para mejorar la salud de las aves.'),
(5, 'Ingreso', '2024-02-14', 1, 2, 2, 5, 5, NULL, 2, 800, 'Ingreso por venta de 2000 huevos a cliente "Carlos Martínez".'),
(6, 'Produccion', '2024-02-15', 1, 2, 1, 6, 3, NULL, NULL, 1000, 'Producción de 1000 huevos por lote de gallinas ponedoras.'),
(7, 'Venta', '2024-02-16', 1, 1, 1, 7, 2, 2, 2, 3200, 'Venta de 3200 huevos de gallinas a cliente "El Comercio".'),
(8, 'Salud', '2024-02-17', 1, 1, 2, 8, 4, NULL, NULL, 150, 'Aplicación de antibiótico a las aves debido a brote de enfermedad.'),
(9, 'Gasto', '2024-02-18', 2, 2, 2, 9, 1, NULL, 3, 500, 'Gastos en el mantenimiento de galpones y limpieza de las instalaciones.'),
(10, 'Ingreso', '2024-02-19', 1, 1, 1, 10, 6, NULL, 2, 700, 'Ingreso por venta de 5000 huevos a cliente "Distribuidora ABC".'),
(11, 'Produccion', '2024-02-20', 1, 1, 1, 11, 3, NULL, NULL, 400, 'Producción de 400 pollos a partir del lote de gallinas ponedoras.'),
(12, 'Venta', '2024-02-21', 1, 2, 2, 12, 2, 3, 3, 2100, 'Venta de 2100 huevos a cliente "Supermercado 123".'),
(13, 'Salud', '2024-02-22', 1, 2, 2, 13, 4, NULL, NULL, 100, 'Tratamiento de aves con vitaminas para aumentar la producción de huevos.'),
(14, 'Gasto', '2024-02-23', 2, 1, 1, 14, 1, NULL, 1, 700, 'Compra de nuevo equipo de alimentación para las aves.'),
(15, 'Ingreso', '2024-02-24', 1, 1, 2, 15, 6, NULL, 2, 500, 'Ingreso por venta de 1000 huevos a cliente "Gonzalo López".');

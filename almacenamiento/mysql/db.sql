CREATE DATABASE IF NOT EXISTS db_medisistema;

USE db_medisistema;

CREATE TABLE IF NOT EXISTS medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    años_experiencia INT NOT NULL
);

CREATE TABLE IF NOT EXISTS pacientes (
    id_pacientes INT AUTO_INCREMENT PRIMARY KEY,
    nombre_paciente VARCHAR(100) NOT NULL,
    apellido_paciente VARCHAR(100) NOT NULL,
    documento_identidad VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS consultas_medicas (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    id_medico_fk INT NOT NULL,
    id_paciente_fk INT NOT NULL,
    fecha_consulta TIMESTAMP NOT NULL,
    estado_consulta ENUM('pendiente', 'completada', 'cancelada') NOT NULL,
    diagnostico VARCHAR(500) NOT NULL,
    motivo VARCHAR(1000) NOT NULL,
    FOREIGN KEY (id_medico_fk) REFERENCES medicos(id_medico),
    FOREIGN KEY (id_paciente_fk) REFERENCES pacientes(id_pacientes)
);

CREATE TABLE IF NOT EXISTS medico_especialidad (
    id_espec INT AUTO_INCREMENT PRIMARY KEY,
    nombre_espec VARCHAR(300) NOT NULL
);

CREATE TABLE IF NOT EXISTS especialidades (
    id_medico_fk INT NOT NULL,
    id_espec_fk INT NOT NULL,
    PRIMARY KEY (id_medico_fk, id_espec_fk),
    FOREIGN KEY (id_medico_fk) REFERENCES medicos(id_medico),
    FOREIGN KEY (id_espec_fk) REFERENCES medico_especialidad(id_espec)
);
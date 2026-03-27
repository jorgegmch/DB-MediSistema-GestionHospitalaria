USE db_medisistema;

INSERT INTO medico_especialidad (nombre_espec) VALUES
('Pediatría'),
('Cardiología'),
('Dermatología'),
('Neurología'),
('Medicina General');

INSERT INTO medicos (nombre, apellido, fecha_contratacion, años_experiencia) VALUES
('Juan', 'Pérez', '2010-05-15', 14),
('María', 'Gómez', '2012-08-20', 12),
('Carlos', 'López', '2015-03-10', 9),
('Ana', 'Martínez', '2018-11-01', 5),
('Luis', 'Rodríguez', '2020-01-25', 3);

INSERT INTO pacientes (nombre_paciente, apellido_paciente, documento_identidad, fecha_nacimiento) VALUES
('Sofía', 'García', '12345678A', '1990-04-12'),
('Mateo', 'Fernández', '87654321B', '1985-09-30'),
('Valentina', 'López', '11223344C', '2000-01-20'),
('Diego', 'Martínez', '44332211D', '1995-07-15'),
('Camila', 'Rodríguez', '55667788E', '1988-12-05'),
('Lucas', 'Sánchez', '99887766F', '1992-03-25'),
('Isabella', 'Gómez', '66778899G', '1998-06-18'),
('Santiago', 'Pérez', '33445566H', '1983-11-10'),
('Valeria', 'Fernández', '77889900I', '1995-02-28'),
('Matías', 'López', '22334455J', '2002-08-05');

INSERT INTO especialidades (id_medico_fk, id_espec_fk) VALUES
(1, 1), -- Juan Pérez - Pediatría
(2, 2), -- María Gómez - Cardiología
(3, 3), -- Carlos López - Dermatología
(4, 4), -- Ana Martínez - Neurología
(5, 5); -- Luis Rodríguez - Medicina General

INSERT INTO consultas_medicas 
(id_medico_fk, id_paciente_fk, fecha_consulta, estado_consulta, diagnostico, motivo) VALUES
-- HOY (para consultas del día)
(1, 1, CURDATE(), 'completada', 'Resfriado común', 'Fiebre y malestar general'),
(1, 2, CURDATE(), 'completada', 'Gripe', 'Dolor de garganta'),
(1, 3, CURDATE(), 'pendiente', 'Chequeo general', 'Consulta preventiva'),

-- VARIADAS
(2, 4, '2025-01-10', 'completada', 'Arritmia leve', 'Dolor en el pecho'),
(2, 5, '2025-01-12', 'cancelada', 'Hipertensión', 'Presión alta'),

-- MUCHAS CONSULTAS PARA UN MÉDICO (para >10 pacientes)
(3, 1, '2024-09-20', 'completada', 'Migraña', 'Dolor de cabeza'),
(3, 2, '2024-09-21', 'completada', 'Migraña', 'Dolor de cabeza'),
(3, 3, '2024-09-22', 'completada', 'Migraña', 'Dolor de cabeza'),
(3, 4, '2024-09-23', 'completada', 'Migraña', 'Dolor de cabeza'),
(3, 5, '2024-09-24', 'completada', 'Migraña', 'Dolor de cabeza'),
(3, 6, '2024-09-25', 'completada', 'Migraña', 'Dolor de cabeza'),
(3, 7, '2024-09-26', 'completada', 'Migraña', 'Dolor de cabeza'),
(3, 8, '2024-09-27', 'completada', 'Migraña', 'Dolor de cabeza'),
(3, 9, '2024-09-28', 'completada', 'Migraña', 'Dolor de cabeza'),
(3, 10, '2024-09-29', 'completada', 'Migraña', 'Dolor de cabeza'),

-- MÁS VARIEDAD
(4, 6, '2024-08-15', 'cancelada', 'Dermatitis', 'Irritación en la piel'),
(5, 7, '2024-07-10', 'completada', 'Chequeo general', 'Consulta rutinaria');
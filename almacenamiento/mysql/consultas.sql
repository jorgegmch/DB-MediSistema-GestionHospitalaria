USE db_medisistema;

-- 1. Listar todos los médicos con su especialidad (utilizando tabla intermedia).
SELECT m.nombre, m.apellido, me.nombre_espec
FROM medicos AS m
JOIN especialidades AS e ON m.id_medico = e.id_medico_fk
JOIN medico_especialidad AS me ON e.id_espec_fk = me.id_espec;

-- 2. Buscar médicos que cuenten con la especialidad de "Pediatría".
SELECT m.nombre, m.apellido
FROM medicos AS m
JOIN especialidades AS e ON m.id_medico = e.id_medico_fk
JOIN medico_especialidad AS me ON e.id_espec_fk = me.id_espec
WHERE me.nombre_espec = 'Pediatría';

-- 3. Contar el total de médicos registrados en la institución.
SELECT COUNT(*) AS total_medicos 
FROM medicos;

-- 4. Obtener los médicos que tienen más de 15 años de experiencia profesional.
SELECT nombre, apellido, años_experiencia
FROM medicos
WHERE años_experiencia > 15;

-- 5. Listar las especialidades únicas que ofrece el centro médico.
SELECT DISTINCT nombre_espec
FROM medico_especialidad;

-- 6. Mostrar todos los pacientes registrados en orden alfabético por apellido.
SELECT *
FROM pacientes
ORDER BY apellido_paciente ASC;

-- 7. Buscar la información de un paciente mediante su número de documento.
SELECT *
FROM pacientes
WHERE documento_identidad = '66778899G';

-- 8. Listar las consultas programadas para el día de hoy.
SELECT *
FROM consultas_medicas
WHERE fecha_consulta = CURDATE();

-- 9. Contar cuántas citas han sido marcadas como "Completadas".
SELECT COUNT(*) AS citas_completadas
FROM consultas_medicas
WHERE estado_consulta = 'completada';

-- 10. Obtener el historial completo de citas de un paciente específico.
SELECT cm.fecha_consulta, cm.estado_consulta, cm.diagnostico, cm.motivo, m.nombre AS nombre_medico, m.apellido AS apellido_medico
FROM consultas_medicas AS cm
JOIN medicos AS m ON cm.id_medico_fk = m.id_medico
WHERE cm.id_paciente_fk = (SELECT id_pacientes FROM pacientes WHERE documento_identidad = '66778899G');

-- 11. Identificar a los médicos que han atendido a más de 10 pacientes distintos.
SELECT m.nombre, m.apellido, COUNT(DISTINCT cm.id_paciente_fk) AS pacientes_atendidos
FROM medicos AS m
JOIN consultas_medicas AS cm ON m.id_medico = cm.id_medico_fk
GROUP BY m.id_medico
HAVING COUNT(DISTINCT cm.id_paciente_fk) > 10;

-- 12. Mostrar el último diagnóstico registrado para un paciente determinado.
SELECT cm.diagnostico, cm.fecha_consulta
FROM consultas_medicas AS cm
WHERE cm.id_paciente_fk = (SELECT id_pacientes FROM pacientes WHERE documento_identidad = '66778899G')
ORDER BY cm.fecha_consulta DESC
LIMIT 1;

-- 13. Calcular el promedio de consultas atendidas por cada médico al mes.
SELECT id_medico_fk, COUNT(*) / COUNT(DISTINCT DATE_FORMAT(fecha_consulta, '%Y-%m')) AS promedio_mensual
FROM consultas_medicas
GROUP BY id_medico_fk;

-- 14. Listar las especialidades que actualmente no tienen ningún médico asignado.
SELECT me.nombre_espec
FROM medico_especialidad AS me
LEFT JOIN especialidades AS e ON me.id_espec = e.id_espec_fk
WHERE e.id_espec_fk IS NULL;

-- 15. Filtrar los pacientes que tienen citas en estado "Cancelada".
SELECT p.nombre_paciente, p.apellido_paciente, p.documento_identidad
FROM pacientes AS p
JOIN consultas_medicas AS cm ON p.id_pacientes = cm.id_paciente_fk
WHERE cm.estado_consulta = 'cancelada';

-- 16. Encontrar al médico con el mayor volumen de consultas realizadas.
SELECT m.nombre, m.apellido, COUNT(*) AS total_consultas
FROM medicos AS m
JOIN consultas_medicas AS cm ON m.id_medico = cm.id_medico_fk
GROUP BY m.id_medico
ORDER BY total_consultas DESC
LIMIT 1;

-- 17. Listar los pacientes cuya edad sea superior a los 50 años.
SELECT nombre_paciente, apellido_paciente, documento_identidad, fecha_nacimiento
FROM pacientes
WHERE TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) > 50;

-- 18. Contar la cantidad de consultas realizadas desglosadas por cada especialidad.
SELECT me.nombre_espec, COUNT(*) AS total_consultas
FROM medico_especialidad AS me
JOIN especialidades AS e ON me.id_espec = e.id_espec_fk
JOIN consultas_medicas AS cm ON e.id_espec_fk = cm.id_espec_fk
GROUP BY me.nombre_espec;

-- 19. Determinar el motivo de consulta que más se ha repetido en el último semestre.
SELECT motivo, COUNT(*) AS frecuencia
FROM consultas_medicas
WHERE fecha_consulta >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY motivo
ORDER BY frecuencia DESC
LIMIT 1;

-- 20. Mostrar cada médico junto con la fecha de su última actividad registrada.
SELECT m.nombre, m.apellido, MAX(cm.fecha_consulta) AS ultima_actividad
FROM medicos AS m
LEFT JOIN consultas_medicas AS cm ON m.id_medico = cm.id_medico_fk
GROUP BY m.id_medico;
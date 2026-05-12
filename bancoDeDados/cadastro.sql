DROP DATABASE IF EXISTS hospital_gestao;
CREATE DATABASE hospital_gestao;
USE hospital_gestao;

CREATE TABLE pacientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20)
);

CREATE TABLE medicos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) UNIQUE NOT NULL,
    especialidade VARCHAR(50) NOT NULL
);

CREATE TABLE consultas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    paciente_id INT,
    medico_id INT,
    data_consulta DATETIME NOT NULL,
    status ENUM('Agendada', 'Realizada', 'Cancelada') DEFAULT 'Agendada',
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    FOREIGN KEY (medico_id) REFERENCES medicos(id)
);

CREATE OR REPLACE VIEW vw_medicos_especialidades AS
SELECT id, nome, especialidade FROM medicos;

DELIMITER //
CREATE PROCEDURE sp_agendar_consulta(
    IN p_paciente_id INT,
    IN p_medico_id INT,
    IN p_data DATETIME
)
BEGIN
    DECLARE v_conflito INT;

    SELECT COUNT(*) INTO v_conflito FROM consultas 
    WHERE medico_id = p_medico_id AND data_consulta = p_data AND status = 'Agendada';

    IF v_conflito = 0 THEN
        INSERT INTO consultas (paciente_id, medico_id, data_consulta) VALUES (p_paciente_id, p_medico_id, p_data);
        SELECT 'Consulta realizada com sucesso' AS msg;
    ELSE
        SELECT 'ERRO:horario em conflito! médico já possui esse horario marcado' AS msg;
    END IF;
END //
DELIMITER ;

INSERT INTO medicos (nome, crm, especialidade) VALUES 
('Dr. Arnaldo', 'CRM-PI 1234', 'Cardiologia'),
('Dra. Helena', 'CRM-PI 5678', 'Pediatria'),
('Dr. Carlos', 'CRM-PI 9012', 'Clínico Geral');
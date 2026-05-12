const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(express.json());
app.use(cors());

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME
});

app.post('/agendar-completo', async (req, res) => {
    const { nome, cpf, data_nascimento, telefone, especialidade } = req.body;

    try {
        const [pacienteRes] = await pool.query(
            'INSERT INTO pacientes (nome, cpf, data_nascimento, telefone) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE telefone = VALUES(telefone)',
            [nome, cpf, data_nascimento, telefone]
        );

        const [pacienteRows] = await pool.query('SELECT id FROM pacientes WHERE cpf = ?', [cpf]);
        const paciente_id = pacienteRows[0].id;

        const [medicoRows] = await pool.query('SELECT id FROM medicos WHERE especialidade = ? LIMIT 1', [especialidade]);
        
        if (medicoRows.length === 0) {
            return res.status(404).json({ status: 'erro', mensagem: `Nenhum médico encontrado para: ${especialidade}` });
        }
        
        const medico_id = medicoRows[0].id;
        const data_hora = new Date().toISOString().slice(0, 19).replace('T', ' '); 

        const [result] = await pool.query('CALL sp_agendar_consulta(?, ?, ?)', [paciente_id, medico_id, data_hora]);
        const msg = result[0][0].msg;

        res.json({ status: 'sucesso', mensagem: `Paciente ${nome} cadastrado. ${msg}` });

    } catch (error) {
        console.error(error);
        res.status(500).json({ status: 'erro', mensagem: 'Erro ao processar cadastro e agendamento.' });
    }
});

app.listen(process.env.PORT, () => {
    console.log(`API Hospitalar em: http://localhost:${process.env.PORT}`);
});
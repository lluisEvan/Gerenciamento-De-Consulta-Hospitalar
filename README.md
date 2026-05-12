# 🏥 Sistema de Gerenciamento de Consultas Hospitalares

Este é um sistema Full Stack desenvolvido para automatizar o processo de cadastro de pacientes e agendamento de consultas médicas. O projeto integra uma interface web moderna, uma API robusta em Node.js e um banco de dados relacional MySQL com lógica de negócios protegida por Stored Procedures.

## 🚀 Tecnologias Utilizadas

* **Frontend:** HTML5, CSS3 (Design Responsivo) e JavaScript (Fetch API).
* **Backend:** Node.js, Express.js.
* **Banco de Dados:** MySQL.
* **Versionamento:** Git e GitHub.

## 🛠️ Funcionalidades

* **Cadastro de Pacientes:** Registro de nome, CPF, data de nascimento e telefone.
* **Validação de Dados:** Uso de `ON DUPLICATE KEY UPDATE` para manter a integridade dos cadastros.
* **Agendamento Inteligente:** Seleção automática de médicos com base na especialidade desejada.
* **Regra de Negócio no Banco:** Stored Procedure que impede o agendamento de dois pacientes para o mesmo médico no mesmo horário.

## 📂 Estrutura do Projeto

* `/backend`: Servidor Node.js e rotas da API.
* `/frontend`: Interface do usuário.
* `/bancoDeDados`: Script SQL para criação das tabelas, views e procedures.

## 🔧 Como Executar o Projeto

1.  **Banco de Dados:**
    * Execute o script localizado em `/bancoDeDados/cadastro.sql` no seu MySQL Workbench.
2.  **Backend:**
    * Entre na pasta `backend`: `cd backend`
    * Instale as dependências: `npm install`
    * Configure o arquivo `.env` com suas credenciais.
    * Inicie o servidor: `npm start` ou `nodemon server.js`
3.  **Frontend:**
    * Basta abrir o arquivo `index.html` localizado na pasta `frontend` em qualquer navegador.

---

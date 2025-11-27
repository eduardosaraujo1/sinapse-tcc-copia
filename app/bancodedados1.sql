-- ==========================================================
-- SELECIONA O BANCO DE DADOS
-- ==========================================================
USE NidusApp;

-- ==========================================================
-- REMOVE AS TABELAS EXISTENTES (em ordem reversa de dependência)
-- ==========================================================
DROP TABLE IF EXISTS registros_diarios;
DROP TABLE IF EXISTS tarefas;
DROP TABLE IF EXISTS consultas;
DROP TABLE IF EXISTS agendamentos_medicamentos;
DROP TABLE IF EXISTS pacientes;
DROP TABLE IF EXISTS familiares;
DROP TABLE IF EXISTS cuidador;

-- ==========================================================
-- TABELA: cuidador
-- ==========================================================
CREATE TABLE cuidador (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE, 
    telefone VARCHAR(20) NULL,
    endereco VARCHAR(255) NULL,
    data_nascimento DATE NULL, 
    genero CHAR(1) NULL,      
    senha VARCHAR(255) NOT NULL,
    status_validacao ENUM('Pendente', 'Validado', 'Rejeitado') DEFAULT 'Pendente',
    formacao VARCHAR(100) NULL,
    registro_profissional VARCHAR(50) NULL,
    documento_path VARCHAR(255) NULL,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================================
-- TABELA: pacientes
-- ==========================================================
CREATE TABLE pacientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    idade INT NULL,
    peso DECIMAL(5,2) NULL,
    tipo_sanguineo VARCHAR(5) NULL,
    comorbidade TEXT NULL,
    cuidador_id INT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL UNIQUE,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cuidador_id) REFERENCES cuidador(id) ON DELETE SET NULL
);

-- ==========================================================
-- TABELA: familiares
-- ==========================================================
CREATE TABLE familiares (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE, 
    telefone VARCHAR(20) NULL,
    endereco VARCHAR(255) NULL,
    data_nascimento DATE NULL, 
    genero CHAR(1) NULL,      
    senha VARCHAR(255) NOT NULL,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================================
-- TABELA: agendamentos_medicamentos
-- ==========================================================
CREATE TABLE agendamentos_medicamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cuidador_id INT NOT NULL,
    paciente_id INT NOT NULL,
    medicamento_nome VARCHAR(255) NOT NULL,
    dosagem VARCHAR(100) NOT NULL,
    data_hora DATETIME NOT NULL,
    status ENUM('pendente', 'atrasada', 'feita', 'cancelada') DEFAULT 'pendente',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (cuidador_id) REFERENCES cuidador(id) ON DELETE CASCADE,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE
);

-- ==========================================================
-- TABELA: consultas
-- ==========================================================
CREATE TABLE consultas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    cuidador_id INT NOT NULL,
    tipo_consulta ENUM('presencial', 'telemedicina', 'domiciliar') DEFAULT 'presencial',
    especialidade VARCHAR(100) NOT NULL,
    medico_nome VARCHAR(255) NOT NULL,
    crm_medico VARCHAR(50) NULL,
    hora_consulta DATETIME NOT NULL,
    local_consulta VARCHAR(255) NULL,
    endereco_consulta TEXT NULL,
    status ENUM('pendente', 'atrasada', 'feita', 'cancelada') DEFAULT 'pendente',
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
    FOREIGN KEY (cuidador_id) REFERENCES cuidador(id) ON DELETE CASCADE
);

-- ==========================================================
-- TABELA: tarefas
-- ==========================================================
CREATE TABLE tarefas (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cuidador_id INT NOT NULL,
    paciente_id INT NOT NULL,
    descricao TEXT NULL,
    data_tarefa TEXT NULL,
    motivacao TEXT NULL,
    status ENUM('pendente', 'atrasada', 'feita', 'cancelada') DEFAULT 'pendente',
    FOREIGN KEY (cuidador_id) REFERENCES cuidador(id) ON DELETE CASCADE,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE
);

-- ==========================================================
-- TABELA: registros_diarios
-- ==========================================================
DROP TABLE IF EXISTS registros_diarios;

CREATE TABLE registros_diarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    
    -- Campos da Tela 1: Atividades
    atividades_realizadas VARCHAR(255) NULL,
    outras_atividades TEXT NULL,
    observacoes_gerais TEXT NULL,
    
    -- Campos da Tela 2: Sentimentos
    estado_geral VARCHAR(50) NULL,
    observacoes_sentimentos TEXT NULL,

    -- Campos da Tela 3: Sinais Clínicos
    temperatura DECIMAL(4,2) NULL,
    glicemia DECIMAL(6,2) NULL,
    pressao_arterial VARCHAR(20) NULL,
    outras_observacoes TEXT NULL,

    -- Data de criação
    data_registro DATETIME NOT NULL,

    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE
);



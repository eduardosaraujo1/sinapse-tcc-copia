-- Seleciona o banco
USE NidusApp;

-- Remove tabelas em ordem reversa de dependência (por causa das FKs)
DROP TABLE IF EXISTS tarefas;
DROP TABLE IF EXISTS consultas;
DROP TABLE IF EXISTS agendamentos_medicamentos;
DROP TABLE IF EXISTS pacientes;
DROP TABLE IF EXISTS familiares;
DROP TABLE IF EXISTS cuidador;
drop table if exists registros_diarios;
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
    peso DECIMAL(5, 2) NULL,
    tipo_sanguineo VARCHAR(5) NULL,
    comorbidade TEXT NULL,
    cuidador_id INT NULL,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL UNIQUE,
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
    status ENUM('pendente', 'administrado', 'cancelado') DEFAULT 'pendente',
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
    hora_consulta DATETIME NOT NULL,  -- Substitui data_consulta + hora_consulta
    local_consulta VARCHAR(255) NULL,
    endereco_consulta TEXT NULL,
    status VARCHAR(20) DEFAULT 'pendente',
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
    FOREIGN KEY (cuidador_id) REFERENCES cuidador(id) ON DELETE CASCADE,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE
);


ALTER TABLE consultas 
MODIFY COLUMN status ENUM('pendente', 'atrasada', 'feita', 'cancelada') DEFAULT 'pendente';

ALTER TABLE agendamentos_medicamentos 
MODIFY COLUMN status ENUM('pendente', 'atrasada', 'feita', 'cancelada') DEFAULT 'pendente';

ALTER TABLE tarefas 
ADD COLUMN status ENUM('pendente', 'atrasada', 'feita', 'cancelada') DEFAULT 'pendente';

CREATE TABLE registros_diarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    -- Chave Estrangeira
    paciente_id INT NOT NULL, 
    
    -- Campos da Tela 1: Atividades
    atividades_realizadas VARCHAR(255) NOT NULL,
    outras_atividades TEXT,
    observacoes_gerais TEXT,
    
    -- Campos da Tela 2: Sentimentos (Adicionados aqui)
    estado_geral VARCHAR(50) NULL,           -- NULLable porque é preenchido na 2ª etapa
    observacoes_sentimentos TEXT NULL,       -- NULLable porque é preenchido na 2ª etapa

    -- Data e hora em que o registro foi criado
    data_registro DATETIME NOT NULL,
    
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id)
        ON DELETE CASCADE
);

ALTER TABLE registros_diarios MODIFY atividades_realizadas VARCHAR(255) NULL;

ALTER TABLE registros_diarios 
ADD COLUMN temperatura DECIMAL(4,2) NULL,
ADD COLUMN glicemia DECIMAL(6,2) NULL,
ADD COLUMN pressao_arterial VARCHAR(20) NULL,
ADD COLUMN outras_observacoes TEXT NULL;



USE securedms;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    username VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cases (
    id INT AUTO_INCREMENT PRIMARY KEY,
    case_id VARCHAR(50) NOT NULL UNIQUE,
    case_title VARCHAR(255) NOT NULL,
    status VARCHAR(50) DEFAULT 'ACTIVE',
    description TEXT,
    created_by INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE evidence (
    id INT AUTO_INCREMENT PRIMARY KEY,
    evidence_id VARCHAR(50) NOT NULL UNIQUE,
    case_id VARCHAR(50) NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(500),
    evidence_type VARCHAR(100) NOT NULL,
    collected_from VARCHAR(255),
    sha256_hash CHAR(64) NOT NULL,
    status VARCHAR(50) DEFAULT 'Verified',
    uploaded_by INT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE documents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    document_name VARCHAR(255) NOT NULL,
    case_id VARCHAR(50) NOT NULL,
    department VARCHAR(150),
    classification VARCHAR(100),
    access_level VARCHAR(255),
    status VARCHAR(50) DEFAULT 'Pending',
    file_path VARCHAR(500),
    uploaded_by INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE custody_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    evidence_id VARCHAR(50) NOT NULL,
    action VARCHAR(100) NOT NULL,
    performed_by INT NULL,
    department VARCHAR(150),
    location VARCHAR(255),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE audit_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NULL,
    action VARCHAR(100) NOT NULL,
    document_or_evidence VARCHAR(255),
    ip_address VARCHAR(45),
    session_id VARCHAR(255),
    details TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_role VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE blockchain_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    block_number BIGINT NOT NULL UNIQUE,
    evidence_id VARCHAR(50) NOT NULL,
    sha256_hash CHAR(64) NOT NULL,
    previous_block BIGINT NULL,
    status VARCHAR(50) DEFAULT 'Immutable',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
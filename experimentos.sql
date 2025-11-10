-- ------------------------------------------------ --
-- Script SQL para experimentações com comandos SQL --
-- ------------------------------------------------ --

-- Apaga todas as tabelas do banco de dados
-- ATENÇÃO! Só use isso no banco de dados de desenvolvimento
DROP TABLE IF EXISTS pads;
DROP TABLE IF EXISTS owners;

-- Cria a tabela "owners"
-- Precisa ser criada primeiro porque "pads" depende dela
CREATE TABLE owners (
	own_id INTEGER PRIMARY KEY AUTOINCREMENT,
	own_uid TEXT UNIQUE NOT NULL,
	own_display_name TEXT,
	own_email TEXT UNIQUE NOT NULL,
	-- URL da foto do usuário
	own_photo_url TEXT,
	-- 'DEFAULT' significa que vai ser preechido automaticamente
	own_created_at TEXT DEFAULT CURRENT_TIMESTAMP,
	own_last_login_at TEXT DEFAULT CURRENT_TIMESTAMP,
	own_status TEXT NOT NULL DEFAULT 'ON' CHECK (own_status IN ('ON', 'OFF', 'DEL')),
	-- Reservado para uso futuro
	own_metadata TEXT
);

-- Cria a tabela "pads"
-- Tem um relacionamento (chave estrangeira) com "owners"
CREATE TABLE pads (
	pad_id INTEGER PRIMARY KEY AUTOINCREMENT,
	pad_created_at TEXT DEFAULT CURRENT_TIMESTAMP,
	pad_title TEXT NOT NULL,
	pad_content TEXT,
	-- Id do "owner" deste "pad" → Chave estrangeira 
	pad_owner INTEGER,
	pad_status TEXT NOT NULL DEFAULT 'ON' CHECK (pad_status IN ('ON', 'OFF', 'DEL')),
	-- Reservado para uso futuro
	pad_metadata TEXT,
	-- Define a chave estrangeira para a tabela "owners"
	FOREIGN KEY (pad_owner) REFERENCES owners (own_id)
);

-- ------------------------------------- --
-- Insere registros de teste nas tabelas --
-- ------------------------------------- --

-- Insere alguns registros em "owners" para teste
INSERT INTO owners (
	own_uid,
	own_display_name,
	own_email,
	own_photo_url
) VALUES (
	'92U33H8E839H',
	'Joca da Silva',
	'jocasilva@gmail.com',
	'img/fotojoca.jpg'
), (
	'UT48R407348YE',
	'Maricleuza Siriliano',
	'maricleuza@gmail.com',
	'img/fotomari.png'
), (
	'U45895484H0934',
	'Setembrino Trocatapas',
	'setbrino@gmail.com',
	'img/set.png'
);

-- Insere alguns registros
INSERT INTO pads (
	pad_title,
	pad_content,
	pad_owner
) VALUES (
	'Receita de Bolo de Fubá',
	'Lorem ipsum',
	'1' -- Esse id existem em "owners"
), (
	'Como fazer churrasco',
	'Lorem ipsum',
	'3'
);


-- ----------------------------- --
-- Algumas consultas em 'owners' --
-- ----------------------------- --

-- Lista todos os registros 
SELECT * FROM owners;

-- Lista 'own_display_name' e 'own_email' de todos os registros
SELECT own_email, own_display_name FROM owners;

-- Lista em ordem alfabética pelo 'own_display_name' onde ASC é opcional
SELECT own_uid, own_display_name FROM owners ORDER BY own_display_name ASC;

-- Lista em ordem alfabética inversa pelo 'own_display_name' 
SELECT own_uid, own_display_name FROM owners ORDER BY own_display_name DESC;

-- Atualiza o campo 'own_status' do registro específico para 'OFF'
UPDATE owners SET own_status = 'OFF' WHERE own_id = '1';

-- Lista todos os registros que tem o campo 'own_status' com 'ON'
SELECT * FROM owners WHERE own_status = 'ON';

-- Lista todos os registros que tem o campo 'own_status' com 'OFF'
SELECT * FROM owners WHERE own_status = 'OFF';

-- Pesquisa e retorna os registros onde 'own_photo_url' contém 'png'
SELECT * FROM owners WHERE own_photo_url LIKE '%png';

-- Pesquisa e retorna os registros onde 'own_photo_url' contém 'foto'
SELECT * FROM owners WHERE own_photo_url LIKE '%foto%';

-- Pesquisa e retorna os registros onde 'own_photo_url' ou 'own_email' contém a string de pesquisa
SELECT * FROM owners WHERE own_display_name LIKE '%joca%' OR own_email LIKE '%gmail%';

-- Apaga um usuário específico
-- OBS: Cuidado! Isso não é recomendado em produção.
DELETE FROM owners WHERE own_id = '2';

INSERT INTO owners (
	own_uid,
	own_display_name,
	own_email,
	own_photo_url
) VALUES (
	'4R5T6Y7U8I9',
	'Clementildo da Silva',
	'clementildo@gmail.com',
	'img/fotoclemen.jpg'
);

-- Altera o 'own_display_name' do registro
UPDATE owners SET own_display_name = 'Clementildo de Souza' WHERE own_id = '4';


-- --------------------------- --
-- Algumas consultas em 'pads' --
-- --------------------------- --

-- Lista todos os "pads"
SELECT * FROM pads;

-- Lista todos os "pads" e seus respectivos "owners"
SELECT * FROM pads
INNER JOIN owners ON pad_owner = own_id;

-- Lista todos os "pads" e seus respectivos "owners"
SELECT pad_id, pad_title, own_id, own_display_name FROM pads
INNER JOIN owners ON pad_owner = own_id;






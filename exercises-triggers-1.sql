
DROP TABLE IF EXISTS  LOCACAO;
DROP TABLE IF EXISTS  RESERVA;
DROP TABLE IF EXISTS  DVD;
DROP TABLE IF EXISTS  STATUS;
DROP TABLE IF EXISTS  FILME;
DROP TABLE IF EXISTS  CATEGORIA;
DROP TABLE IF EXISTS  CLIENTE;


CREATE TABLE  CLIENTE
   (    CODCLIENTE serial, 
    	NOME_CLIENTE VARCHAR(30) NOT NULL, 
    	ENDERECO VARCHAR(50) NOT NULL, 
    	TELEFONE VARCHAR(12) NOT NULL, 
    	DATA_NASC DATE NOT NULL, 
    	CPF VARCHAR(11) NOT NULL, 
     	CONSTRAINT PK_CLIENTE PRIMARY KEY (CODCLIENTE),
	CONSTRAINT CPF_UNIQUE UNIQUE (CPF)
   );

CREATE TABLE  CATEGORIA 
   (    CODCATEGORIA serial, 
    	NOME_CATEGORIA VARCHAR(100) NOT NULL, 
     	CONSTRAINT CATEGORIA_PK PRIMARY KEY (CODCATEGORIA), 
     	CONSTRAINT CHECK_NOME_CATEGORIA CHECK ( NOME_CATEGORIA in ('drama','terror','ação','aventura','comédia'))
   );

CREATE TABLE  FILME 
   (    CODFILME serial, 
    	CODCATEGORIA int, 
    	NOME_FILME VARCHAR(100) NOT NULL, 
    	DIARIA numeric(10,2) NOT NULL, 
     	CONSTRAINT PK_FILME PRIMARY KEY (CODFILME), 
     	CONSTRAINT FK_FIL_CAT FOREIGN KEY (CODCATEGORIA)
      		REFERENCES  CATEGORIA (CODCATEGORIA)
		ON DELETE NO ACTION ON UPDATE CASCADE
   );

CREATE TABLE  STATUS 
   (    CODSTATUS SERIAL, 
    	NOME_STATUS VARCHAR(30) NOT NULL, 
     	CONSTRAINT PK_STATUS PRIMARY KEY (CODSTATUS),
     	CONSTRAINT CHECK_NOME_STATUS CHECK ( NOME_STATUS in ('reservado','disponível','indisponível','locado'))

   );

CREATE TABLE  DVD 
   (    CODDVD SERIAL, 
    	CODFILME int NOT NULL, 
    	CODSTATUS int NOT NULL, 
     	CONSTRAINT PK_DVD PRIMARY KEY (CODDVD), 
     	CONSTRAINT FK_DVD_FIL FOREIGN KEY (CODFILME)
      		REFERENCES  FILME (CODFILME) ON UPDATE CASCADE, 
     	CONSTRAINT FK_DVD_STA FOREIGN KEY (CODSTATUS)
      		REFERENCES  STATUS (CODSTATUS) ON UPDATE CASCADE
   );

CREATE TABLE  LOCACAO 
   (    CODLOCACAO SERIAL, 
    	CODDVD int NOT NULL, 
    	CODCLIENTE int NOT NULL, 
    	DATA_LOCACAO DATE NOT NULL DEFAULT NOW(), 
    	DATA_DEVOLUCAO DATE, 
     	CONSTRAINT PK_LOCACAO PRIMARY KEY (CODLOCACAO), 
     	CONSTRAINT FK_LOC_DVD FOREIGN KEY (CODDVD)
      		REFERENCES  DVD (CODDVD) ON DELETE SET NULL ON UPDATE CASCADE, 
     	CONSTRAINT FK_LOC_CLI FOREIGN KEY (CODCLIENTE)
      		REFERENCES  CLIENTE (CODCLIENTE) ON DELETE SET NULL ON UPDATE CASCADE
   );

CREATE TABLE  RESERVA 
   (    CODRESERVA SERIAL, 
    	CODDVD int NOT NULL, 
    	CODCLIENTE int NOT NULL, 
 	DATA_RESERVA DATE DEFAULT NOW(), 
    	DATA_VALIDADE DATE NOT NULL, 
     	CONSTRAINT PK_RESERVA PRIMARY KEY (CODRESERVA), 
     	CONSTRAINT FK_RES_DVD FOREIGN KEY (CODDVD)
      		REFERENCES  DVD (CODDVD) ON DELETE SET NULL ON UPDATE CASCADE, 
     	CONSTRAINT FK_RES_CLI FOREIGN KEY (CODCLIENTE)
      		REFERENCES  CLIENTE (CODCLIENTE) ON DELETE SET NULL ON UPDATE CASCADE
   );

--inserts

INSERT INTO STATUS (NOME_STATUS) VALUES ('reservado');
INSERT INTO STATUS (NOME_STATUS) VALUES ('disponível');    
INSERT INTO STATUS (NOME_STATUS) VALUES ('locado');
INSERT INTO STATUS (NOME_STATUS) VALUES ('indisponível');
    
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('comédia');    
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'aventura');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'terror');    
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'ação');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'drama');

INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('João Paulo', 'rua XV de novembro, n:18', '88119922','05-02-1990','09328457398');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Maria', 'rua XV de novembro, n:20', '88225422','07-01-1991','93573923168');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Joana', 'rua XV de novembro, n:10', '99778122','09-07-1980','71398987234');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Jeferson', 'rua XV de novembro, n:118', '84549922','09-12-1982','02128443298');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Paula', 'rua XV de novembro, n:128', '82324232','11-04-1970','57398093284');

INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (1,'Entrando numa fria', 1.50);    
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (2,'O Hobbit', 3.00);    
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (3,'Sobrenatural 2', 4.50);    
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (5,'Um sonho de liberdade', 1.50);
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (2,'Thor 2', 4.50);
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (4,'Velozes e Furiosos', 1.50);

INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (1,1);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (2,2);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (2,3);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (3,2);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (4,2);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (4,3);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (5,1);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (6,3);

INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(1,2,current_date,(current_date+4)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(5,1,current_date,(current_date+4)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(6,2,(current_date-30),(current_date-26)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(6,3,(current_date-4),(current_date-1)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(6,1,(current_date-20),(current_date-16)); 

INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(1,1,(current_date-30),(current_date-28));
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(2,3,(current_date-25),(current_date-23));
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(1,1,(current_date-1),current_date);
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(3,2,(current_date-1),null); 
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(6,2,current_date,null); 
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(8,2,current_date,null);




CREATE OR REPLACE FUNCTION log_dvd() RETURNS trigger AS
$$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO dvd_log(comando, descricao)
        VALUES ('INSERT', 'Novo DVD inserido (CODDVD=' || NEW.coddvd || ').');
        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO dvd_log(comando, descricao)
        VALUES ('DELETE', 'DVD deletado (CODDVD=' || OLD.codvd || ').');
        RETURN OLD;

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO dvd_log(comando, descricao)
        VALUES (
            'UPDATE',
            'DVD atualizado de CODDVD=' || OLD.coddvd || ' para CODDVD=' || NEW.coddvd || '.'
        );
        RETURN NEW;

    END IF;

    RETURN NULL;

END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_log_dvd ON DVD;

CREATE TRIGGER trg_log_dvd
AFTER INSERT OR DELETE OR UPDATE ON DVD
FOR EACH ROW
EXECUTE FUNCTION log_dvd();

-- 2) Faça um trigger que modifica o status de um DVD, baseado em cada um dos eventos:
-- a. Entrega de um DVD alugado
-- b. Reserva de um DVD. Considere uma reserva de 4 dias, a contar do dia atual caso o DVD esteja disponível,
-- caso contrário a reserva não deve ser efetuada.
-- A) Trigger para entrega do DVD
CREATE OR REPLACE FUNCTION atualiza_status_entrega() RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.data_devolucao IS NOT NULL THEN
        UPDATE DVD SET codstatus = (
            SELECT codstatus FROM status WHERE nome_status = 'disponível'
        ) WHERE coddvd = NEW.coddvd;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_entrega ON locacao;

CREATE TRIGGER trg_entrega
AFTER UPDATE ON locacao
FOR EACH ROW
WHEN (NEW.data_devolucao IS NOT NULL)
EXECUTE FUNCTION atualiza_status_entrega();

-- B) Trigger para reserva do DVD
CREATE OR REPLACE FUNCTION atualiza_status_reserva() RETURNS TRIGGER AS
$$
DECLARE
    status_atual VARCHAR(30);
BEGIN
    SELECT nome_status INTO status_atual
    FROM status s
    JOIN dvd d ON s.codstatus = d.codstatus
    WHERE d.coddvd = NEW.coddvd;

    IF status_atual = 'disponível' THEN
        UPDATE dvd
        SET codstatus = (SELECT codstatus FROM status WHERE nome_status = 'reservado')
        WHERE coddvd = NEW.coddvd;

        RETURN NEW;

    ELSE
        RAISE EXCEPTION 'DVD não disponível para reserva!';
    END IF;

END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_reserva ON reserva;

CREATE TRIGGER trg_reserva
BEFORE INSERT ON reserva
FOR EACH ROW
EXECUTE FUNCTION atualiza_status_reserva();






-- 3) Fazer um gatilho que controla o evento de uma locação e testa o status do DVD desejado para locação:
-- a. Caso o DVD esteja disponível, apenas é necessário mudar o status do DVD e efetivar a operação
-- b. Caso esteja reservado, deve ser verificado se a locação esta sendo realizada pelo mesmo cliente que possui a
-- reserva:
-- i. caso seja, permita a operação e altere o status do DVD
-- ii. caso não esteja, não permita a realização da operação (gere um erro com a mensagem: “Reserva
-- para outro cliente!”)
-- c. Caso esteja locado, não permita a realização da operação e gere um erro com a mensagem: “DVD locado!”
CREATE OR REPLACE FUNCTION controla_locacao() RETURNS TRIGGER AS
$$
DECLARE
    status_atual VARCHAR(30);
    cliente_reserva INT;
BEGIN
    -- Status atual do DVD
    SELECT nome_status INTO status_atual
    FROM status s
    JOIN dvd d ON s.codstatus = d.codstatus
    WHERE d.coddvd = NEW.coddvd;

    IF status_atual = 'disponível' THEN
        UPDATE dvd
        SET codstatus = (SELECT codstatus FROM status WHERE nome_status = 'locado')
        WHERE coddvd = NEW.coddvd;
        RETURN NEW;

    ELSIF status_atual = 'reservado' THEN
        SELECT codcliente INTO cliente_reserva
        FROM reserva
        WHERE coddvd = NEW.coddvd
        AND data_validade >= CURRENT_DATE
        ORDER BY data_validade ASC
        LIMIT 1;

        IF cliente_reserva = NEW.codcliente THEN
            UPDATE dvd
            SET codstatus = (SELECT codstatus FROM status WHERE nome_status = 'locado')
            WHERE coddvd = NEW.coddvd;
            RETURN NEW;
        ELSE
            RAISE EXCEPTION 'Reserva para outro cliente!';
        END IF;

    ELSIF status_atual = 'locado' THEN
        RAISE EXCEPTION 'DVD locado!';
    END IF;

    RETURN NULL;

END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_locacao ON locacao;

CREATE TRIGGER trg_locacao
BEFORE INSERT ON locacao
FOR EACH ROW
EXECUTE FUNCTION controla_locacao();

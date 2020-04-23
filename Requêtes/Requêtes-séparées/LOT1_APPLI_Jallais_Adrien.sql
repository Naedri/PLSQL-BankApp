/*LOT1_APPLI_Jallais_Adrien.txt*/

/*BANQUE*/

CREATE TABLE BANQUE(
	IdBanque INTEGER,
	LibelleBanque VARCHAR(50) CONSTRAINT NN_LibelleBanque NOT NULL,
	CPBanque CHAR(5) CONSTRAINT NN_CPBanque NOT NULL,
	AdresseBanque VARCHAR(50) CONSTRAINT NN_AdresseBanque NOT NULL,
	VilleBanque VARCHAR(30) CONSTRAINT NN_VilleBanque NOT NULL
);

ALTER TABLE BANQUE ADD CONSTRAINT PK_IdBanque PRIMARY KEY (IdBanque) ;
ALTER TABLE BANQUE ADD CONSTRAINT U_LibelleBanque UNIQUE (LibelleBanque) ;

CREATE SEQUENCE SeqIdBanque
	START WITH     1
	INCREMENT BY   1
	NOCACHE
	NOCYCLE ;
	

/*TYPECOMPTE*/

CREATE TABLE TYPECOMPTE(
	IdTypeCompte INTEGER,
	LibelleTypeCompte VARCHAR(30) CONSTRAINT NN_LibelleTypeCompte NOT NULL 
);

ALTER TABLE TYPECOMPTE ADD CONSTRAINT PK_IdTypeCompte PRIMARY KEY (IdTypeCompte) ;

CREATE SEQUENCE SeqIdTypeCompte
	START WITH     1
	INCREMENT BY   1
	NOCACHE
	NOCYCLE ;


/*OPERATION*/

CREATE TABLE OPERATION(
	IdOperation INTEGER,
	DateOperation DATE CONSTRAINT NN_DateOperation NOT NULL,
	MontantOperation NUMBER(10,2) CONSTRAINT NN_MontantOperation NOT NULL
);

ALTER TABLE OPERATION ADD CONSTRAINT PK_IdOperation PRIMARY KEY (IdOperation) ;
ALTER TABLE OPERATION MODIFY DateOperation DEFAULT sysdate ; 
/*ALTER TABLE OPERATION ADD CONSTRAINT DK_DateOperation DEFAULT 'SYSDATE' FOR DateOperation ;*/

CREATE SEQUENCE SeqIdOperation
	START WITH     1
	INCREMENT BY   1
	NOCACHE
	NOCYCLE ;


/*COMPTE*/

CREATE TABLE COMPTE(
	IdCompte INTEGER,
	LibelleCompte VARCHAR(30) CONSTRAINT NN_LibelleCompte NOT NULL, 
	SoldeCompte NUMBER(10,2) CONSTRAINT NN_SoldeCompte NOT NULL, 
	DecouvertAutorise NUMBER(10,2)  CONSTRAINT NN_DecouvertAutorise NOT NULL, 
	DateOuvertureCompte DATE CONSTRAINT NN_DateOuvertureCompte NOT NULL
);

ALTER TABLE COMPTE ADD CONSTRAINT PK_IdCompte PRIMARY KEY (IdCompte) ;
ALTER TABLE COMPTE ADD CONSTRAINT U_LibelleCompte UNIQUE (LibelleCompte) ;
ALTER TABLE COMPTE MODIFY SoldeCompte DEFAULT 0.00 ; 
/*ALTER TABLE COMPTE ADD CONSTRAINT DK_SoldeCompte DEFAULT '0' FOR SoldeCompte ;*/
ALTER TABLE COMPTE MODIFY DecouvertAutorise DEFAULT 0.00 ; 
/*ALTER TABLE COMPTE ADD CONSTRAINT DK_DecouvertAutorise DEFAULT '0' FOR DecouvertAutorise ;*/
ALTER TABLE COMPTE ADD CONSTRAINT CK_C_DecouvertAutorise CHECK(DecouvertAutorise>=0) ;
ALTER TABLE COMPTE MODIFY DateOuvertureCompte DEFAULT sysdate ;  
/*ALTER TABLE COMPTE ADD CONSTRAINT DK_DateOuvertureCompte DEFAULT 'SYSDATE' FOR DateOuvertureCompte ;*/

CREATE SEQUENCE SeqIdCompte
	START WITH     1
	INCREMENT BY   1
	NOCACHE
	NOCYCLE ;
	

/*AUDITDECOUVERT*/

CREATE TABLE AUDITDECOUVERT(
	IdAudit INTEGER,
	IdCompte INTEGER CONSTRAINT NN_A_IdCompte NOT NULL,
	LibelleCompte VARCHAR(30) CONSTRAINT NN_A_LibelleCompte NOT NULL,
	SoldeCompte NUMBER(10,2) CONSTRAINT NN_A_SoldeCompte NOT NULL,
	DecouvertAutorise NUMBER(10,2) CONSTRAINT NN_A_DecouvertAutorise NOT NULL,
	Depassement NUMBER(10,2) CONSTRAINT NN_A_Depassement NOT NULL,
	IdDerniereOperation INTEGER CONSTRAINT NN_A_IdDerniereOperation NOT NULL
);

ALTER TABLE AUDITDECOUVERT ADD CONSTRAINT PK_A_IdAudit PRIMARY KEY (IdAudit) ;
ALTER TABLE AUDITDECOUVERT ADD CONSTRAINT CK_A_DecouvertAutorise CHECK(DecouvertAutorise>=0) ;
ALTER TABLE AUDITDECOUVERT MODIFY SoldeCompte DEFAULT 0.00 ; 
/*ALTER TABLE AUDITDECOUVERT ADD CONSTRAINT DK_SOLDECOMPTE DEFAULT 0.00 FOR SOLDECOMPTE ;*/

CREATE SEQUENCE SeqIdAudit
	START WITH     1
	INCREMENT BY   1
	NOCACHE
	NOCYCLE ;




/*association COMPTE BANQUE*/
ALTER TABLE COMPTE ADD (
    IdBanque INTEGER CONSTRAINT NN_IdBanque NOT NULL
);
ALTER TABLE COMPTE ADD CONSTRAINT FK_IdBanque FOREIGN KEY(IdBanque) REFERENCES BANQUE(IdBanque) ;


/*association COMPTE TYPECOMPTE*/
ALTER TABLE COMPTE ADD (
    IdTypeCompte INTEGER CONSTRAINT NN_IdTypeCompte NOT NULL
);
ALTER TABLE COMPTE ADD CONSTRAINT FK_IdTypeCompte FOREIGN KEY(IdTypeCompte) REFERENCES TYPECOMPTE(IdTypeCompte) ;


/*association OPERATION COMPTE*/
ALTER TABLE OPERATION ADD (
    IdCompte INTEGER CONSTRAINT NN_IdCompte NOT NULL
);
ALTER TABLE OPERATION ADD CONSTRAINT FK_IdCompte FOREIGN KEY(IdCompte) REFERENCES COMPTE(IdCompte) ;





/*BANQUE*/

INSERT INTO BANQUE(IdBanque, LibelleBanque, CPBanque,VilleBanque, AdresseBanque) 
	VALUES(SeqIdBanque.NextVal, 	'Banque Postale Nantes', 	'44000', 	'Nantes', 	'20 boulevard des Anglais') ;

INSERT INTO BANQUE(IdBanque, LibelleBanque, CPBanque,VilleBanque, AdresseBanque) 
	VALUES(SeqIdBanque.NextVal, 	'Banque Postale Angers', 	'49000', 	'Angers', 	'12 rue Plantagenet') ;

INSERT INTO BANQUE(IdBanque, LibelleBanque, CPBanque,VilleBanque, AdresseBanque) 
	VALUES(SeqIdBanque.NextVal, 	'Banque Postale Paris', 	'75013', 	'Paris', 	'8 Villa des Gobelins') ;
	
INSERT INTO BANQUE(IdBanque, LibelleBanque, CPBanque,VilleBanque, AdresseBanque) 
	VALUES(SeqIdBanque.NextVal, 	'HSBC Paris', 				'75001', 	'Paris', 	'1 place de la Republique') ;
	
/*TYPECOMPTE*/

INSERT INTO TYPECOMPTE(IdTypeCompte, LibelleTypeCompte)
	VALUES(SeqIdTypeCompte.NextVal,	'LIVRET A') ;
	
INSERT INTO TYPECOMPTE(IdTypeCompte, LibelleTypeCompte)
	VALUES(SeqIdTypeCompte.NextVal, 'Compte Courant') ;
	
INSERT INTO TYPECOMPTE(IdTypeCompte, LibelleTypeCompte)
	VALUES(SeqIdTypeCompte.NextVal, 'Livret Developpement Durable') ;
	
INSERT INTO TYPECOMPTE(IdTypeCompte, LibelleTypeCompte)
	VALUES(SeqIdTypeCompte.NextVal, 'PEL') ;
	
INSERT INTO TYPECOMPTE(IdTypeCompte, LibelleTypeCompte)
	VALUES(SeqIdTypeCompte.NextVal, 'CEL') ;
	
INSERT INTO TYPECOMPTE(IdTypeCompte, LibelleTypeCompte)
	VALUES(SeqIdTypeCompte.NextVal, 'Epargne') ;

/*COMPTE*/

 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Doc','100','-10',TO_DATE('17/03/1812','DD/MM/YY'),'1','1');
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Bashful','200','-20',TO_DATE('18/03/1812','DD/MM/YY'),'2','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Sneezy','300','-30',TO_DATE('19/03/1812','DD/MM/YY'),'3','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Happy','400','-40',TO_DATE('20/03/1812','DD/MM/YY'),'4','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Dopey','500','-50',TO_DATE('21/03/1812','DD/MM/YY'),'1','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Sleepy','600','-60',TO_DATE('22/03/1812','DD/MM/YY'),'2','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Grumpy','700','-70',TO_DATE('23/03/1812','DD/MM/YY'),'3','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Pierre','800','-80',TO_DATE('17/03/1812','DD/MM/YY'),'4','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Andre','900','-90',TO_DATE('18/03/1812','DD/MM/YY'),'1','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'JacquesMaj','1000','-100',TO_DATE('19/03/1812','DD/MM/YY'),'2','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Jean','1100','-110',TO_DATE('20/03/1812','DD/MM/YY'),'3','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Philippe','1200','-120',TO_DATE('21/03/1812','DD/MM/YY'),'4','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Barthélemy','1300','-130',TO_DATE('22/03/1812','DD/MM/YY'),'1','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Thomas','1400','-140',TO_DATE('23/03/1812','DD/MM/YY'),'2','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Matthieu','1500','-150',TO_DATE('17/03/1812','DD/MM/YY'),'3','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'JacquesMin','1600','-160',TO_DATE('18/03/1812','DD/MM/YY'),'4','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Jude','1700','-170',TO_DATE('19/03/1812','DD/MM/YY'),'1','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Simon','1800','-180',TO_DATE('20/03/1812','DD/MM/YY'),'2','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Matthias','1900','-190',TO_DATE('21/03/1812','DD/MM/YY'),'3','1'); 

/*OPERATION*/

 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('17/03/1912','DD/MM/YY'),'10','1'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'20','1'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'30','1'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('20/03/1912','DD/MM/YY'),'10','1'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('21/03/1912','DD/MM/YY'),'20','1'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('22/03/1912','DD/MM/YY'),'30','2'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('23/03/1912','DD/MM/YY'),'10','2'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('17/03/1912','DD/MM/YY'),'20','2'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'30','2'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'10','2'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('20/03/1912','DD/MM/YY'),'20','3'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('21/03/1912','DD/MM/YY'),'30','3'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('22/03/1912','DD/MM/YY'),'10','3'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('23/03/1912','DD/MM/YY'),'20','3'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('17/03/1912','DD/MM/YY'),'30','3'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'10','4'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'20','4'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('20/03/1912','DD/MM/YY'),'30','4'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('21/03/1912','DD/MM/YY'),'10','4'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('17/03/1912','DD/MM/YY'),'10','4'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'20','5'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'30','5'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('20/03/1912','DD/MM/YY'),'10','5'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('21/03/1912','DD/MM/YY'),'20','5'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('22/03/1912','DD/MM/YY'),'30','5'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('23/03/1912','DD/MM/YY'),'10','6'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('17/03/1912','DD/MM/YY'),'20','6'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'30','6'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'10','6'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('20/03/1912','DD/MM/YY'),'20','6'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('21/03/1912','DD/MM/YY'),'30','7'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('22/03/1912','DD/MM/YY'),'10','7'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('23/03/1912','DD/MM/YY'),'20','7'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('17/03/1912','DD/MM/YY'),'30','7'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'10','7'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'20','8'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('20/03/1912','DD/MM/YY'),'30','8'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('21/03/1912','DD/MM/YY'),'10','8'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('17/03/1912','DD/MM/YY'),'10','8'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'20','8'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'30','9'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('20/03/1912','DD/MM/YY'),'10','9'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('21/03/1912','DD/MM/YY'),'20','9'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('22/03/1912','DD/MM/YY'),'30','9'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('23/03/1912','DD/MM/YY'),'10','9'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('17/03/1912','DD/MM/YY'),'20','10'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'30','10'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'10','10'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('20/03/1912','DD/MM/YY'),'20','10'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('21/03/1912','DD/MM/YY'),'30','10'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('22/03/1912','DD/MM/YY'),'10','11'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('23/03/1912','DD/MM/YY'),'20','11'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('17/03/1912','DD/MM/YY'),'30','11'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'10','11'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'20','11'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('20/03/1912','DD/MM/YY'),'30','12'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('21/03/1912','DD/MM/YY'),'10','12'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('17/03/1912','DD/MM/YY'),'10','12'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'20','12'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'30','12'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('20/03/1912','DD/MM/YY'),'10','13'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('21/03/1912','DD/MM/YY'),'20','13'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('22/03/1912','DD/MM/YY'),'30','13'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('23/03/1912','DD/MM/YY'),'10','13'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('17/03/1912','DD/MM/YY'),'20','13'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'30','14'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'10','14'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('20/03/1912','DD/MM/YY'),'20','14'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('21/03/1912','DD/MM/YY'),'30','14'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('22/03/1912','DD/MM/YY'),'10','14'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('23/03/1912','DD/MM/YY'),'20','15'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('17/03/1912','DD/MM/YY'),'30','15'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'10','15'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'20','15'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('20/03/1912','DD/MM/YY'),'30','15'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('21/03/1912','DD/MM/YY'),'10','16'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('17/03/1912','DD/MM/YY'),'10','16'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'20','16'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'30','16'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('20/03/1912','DD/MM/YY'),'10','16'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('21/03/1912','DD/MM/YY'),'20','17'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('22/03/1912','DD/MM/YY'),'30','17'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('23/03/1912','DD/MM/YY'),'10','17'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('17/03/1912','DD/MM/YY'),'20','17'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'30','17'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'10','18'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('20/03/1912','DD/MM/YY'),'20','18'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('21/03/1912','DD/MM/YY'),'30','18'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('22/03/1912','DD/MM/YY'),'10','18'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('23/03/1912','DD/MM/YY'),'20','18'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('17/03/1912','DD/MM/YY'),'30','19'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'10','19'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('19/03/1912','DD/MM/YY'),'20','19'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('20/03/1912','DD/MM/YY'),'30','19'); 
 INSERT INTO OPERATION(IdOperation,	DateOperation, MontantOperation, IdCompte) VALUES(SeqIdOperation.NextVal, TO_DATE('21/03/1912','DD/MM/YY'),'10','19'); 

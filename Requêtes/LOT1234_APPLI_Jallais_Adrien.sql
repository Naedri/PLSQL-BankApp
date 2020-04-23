/*LOT1_APPLI_Jallais_Adrien-1.txt*/

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



/*LOT1_APPLI_Jallais_Adrien-2.txt*/

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

 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Doc','100','10',TO_DATE('17/03/1812','DD/MM/YY'),'1','1');
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Bashful','200','20',TO_DATE('18/03/1812','DD/MM/YY'),'2','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Sneezy','300','30',TO_DATE('19/03/1812','DD/MM/YY'),'3','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Happy','400','40',TO_DATE('20/03/1812','DD/MM/YY'),'4','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Dopey','500','50',TO_DATE('21/03/1812','DD/MM/YY'),'1','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Sleepy','600','60',TO_DATE('22/03/1812','DD/MM/YY'),'2','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Grumpy','700','70',TO_DATE('23/03/1812','DD/MM/YY'),'3','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Pierre','800','80',TO_DATE('17/03/1812','DD/MM/YY'),'4','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Andre','900','90',TO_DATE('18/03/1812','DD/MM/YY'),'1','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'JacquesMaj','1000','100',TO_DATE('19/03/1812','DD/MM/YY'),'2','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Jean','1100','110',TO_DATE('20/03/1812','DD/MM/YY'),'3','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Philippe','1200','120',TO_DATE('21/03/1812','DD/MM/YY'),'4','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Barthélemy','1300','130',TO_DATE('22/03/1812','DD/MM/YY'),'1','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Thomas','1400','140',TO_DATE('23/03/1812','DD/MM/YY'),'2','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Matthieu','1500','150',TO_DATE('17/03/1812','DD/MM/YY'),'3','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'JacquesMin','1600','160',TO_DATE('18/03/1812','DD/MM/YY'),'4','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Jude','1700','170',TO_DATE('19/03/1812','DD/MM/YY'),'1','1'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Simon','1800','180',TO_DATE('20/03/1812','DD/MM/YY'),'2','2'); 
 INSERT INTO COMPTE(IdCompte,	LibelleCompte,	SoldeCompte,	DecouvertAutorise,	DateOuvertureCompte, IdBanque, IdTypeCompte ) VALUES(SeqIdCompte.NextVal, 'Matthias','1900','190',TO_DATE('21/03/1812','DD/MM/YY'),'3','1'); 
 


/*OPERATION-vague1*/

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


/*LOT2_APPLI_Jallais_Adrien.txt*/

/*interface*/
CREATE OR REPLACE PACKAGE PACK_APP_BANQUE
    IS
	    PROCEDURE AJOUTNOUVOPERATION(IdCpt INTEGER, Value NUMBER) ;
	    FUNCTION ObtMontant(IdOpt INTEGER) RETURN NUMBER ;
	    FUNCTION ObtCompte(IdOpt INTEGER) RETURN INTEGER ;
	    PROCEDURE ANNULEROPERATION(IdOpt INTEGER) ;
	    PROCEDURE MAJDECOUVERTAUTORISE (IdCpt INTEGER, Value NUMBER) ;
        PROCEDURE MAJMONTANTOPERATION (IdOpt INTEGER, Value NUMBER) ;
        PROCEDURE FAIRETRANSFERTCOMPTE (IdCptOrig INTEGER, IdCptDest INTEGER, Value NUMBER) ;
        PROCEDURE AJMONTANTSOLDE (IdCpt INTEGER, Value NUMBER) ;
        FUNCTION ObtBanque (IdCpt INTEGER ) RETURN INTEGER ;
        FUNCTION ObtLibelleBanque (IdBnq INTEGER ) RETURN VARCHAR ;
        FUNCTION BANQUEOPERATION (IdOpt INTEGER ) RETURN VARCHAR ;
        FUNCTION ObtSolde (IdCpt INTEGER) RETURN NUMBER ;
        FUNCTION ObtDecouvert (IdCpt INTEGER) RETURN NUMBER ;
        FUNCTION ObtTypeCompte (IdCpt INTEGER) RETURN NUMBER ;
END PACK_APP_BANQUE ;
/

/*body*/
CREATE OR REPLACE PACKAGE BODY PACK_APP_BANQUE 
    IS

        PROCEDURE AJOUTNOUVOPERATION(IdCpt INTEGER, Value NUMBER)
	        IS 
	        BEGIN
		        INSERT INTO OPERATION(IdOperation, DateOperation, MontantOperation, IdCompte) 
			        VALUES(SeqIdOperation.NextVal, SYSDATE, Value, IdCpt);
		        DBMS_OUTPUT.PUT_LINE('L operation ' || SeqIdOperation.CurrVal || ' a eu lieu sur le compte '|| IdCpt || ' pour un montant de '|| Value || ' .');
        END AJOUTNOUVOPERATION;
        
        
       /*ObtMontant permet d obtenir le montant de l operation indiquée*/
        FUNCTION ObtMontant(IdOpt INTEGER) RETURN NUMBER
	        IS
		        N_montant NUMBER(10,2) ;
	        BEGIN 
		        SELECT MontantOperation INTO N_montant FROM OPERATION WHERE IdOperation = IdOpt ;
	        RETURN N_montant;
        END ObtMontant; 
        
        
        /*ObtCompte permet d obtenir l identifiant du compte sur lequel a été réalisé l operation */
        FUNCTION ObtCompte(IdOpt INTEGER) RETURN INTEGER
	        IS
		        I_compte INTEGER ;
	        BEGIN 
		        SELECT IdCompte INTO I_compte FROM OPERATION WHERE IdOperation = IdOpt ;
	        RETURN I_compte;
        END ObtCompte;


        PROCEDURE ANNULEROPERATION (IdOpt INTEGER)
	        IS 
	        BEGIN
		        AJOUTNOUVOPERATION(ObtCompte(IdOpt), -ObtMontant(IdOpt)) ;
		        DBMS_OUTPUT.PUT_LINE('L operation '|| IdOpt || ' a été annulée.');
        END ANNULEROPERATION ;
        
        
        PROCEDURE MAJDECOUVERTAUTORISE (IdCpt INTEGER, Value NUMBER)
	        IS
	        BEGIN
	            IF Value < 0 THEN
			        DBMS_OUTPUT.PUT_LINE('Veuillez saisir un montant positif.');
			        RAISE_APPLICATION_ERROR(-0001,'Montant découvert négatif');
                ELSE
                    UPDATE COMPTE SET DecouvertAutorise = Value WHERE IdCompte=IdCpt;
		            DBMS_OUTPUT.PUT_LINE('Le compte suivant '|| IdCpt || ' a désormais un découvert autorisé de '|| Value || '.');
		        END IF;
        END MAJDECOUVERTAUTORISE ;
        
        
        PROCEDURE MAJMONTANTOPERATION (IdOpt INTEGER, Value NUMBER)
	        IS
	        BEGIN
		        ANNULEROPERATION(IdOpt) ;
		        AJOUTNOUVOPERATION(ObtCompte(IdOpt), Value) ;
		        DBMS_OUTPUT.PUT_LINE('Le montant de l opération suivante '|| IdOpt || ' s élève désormais à '|| Value || ' .');
        END MAJMONTANTOPERATION ;
        

        PROCEDURE FAIRETRANSFERTCOMPTE (IdCptOrig INTEGER, IdCptDest INTEGER, Value NUMBER)
	        IS
	        BEGIN
		        IF Value > 0 THEN
			        AJOUTNOUVOPERATION(IdCptOrig, -Value) ;
			        AJOUTNOUVOPERATION(IdCptDest, Value) ;
			        DBMS_OUTPUT.PUT_LINE('Un transfert d argent a eu lieu, du compte '|| IdCptOrig || ' vers le compte '|| IdCptDest || ' .');
		        ELSIF Value = 0 THEN
			        DBMS_OUTPUT.PUT_LINE('Veuillez saisir un montant différent de 0.');
			        RAISE_APPLICATION_ERROR(-1000,'Montant nul');
		        ELSIF Value < 0 THEN
			        DBMS_OUTPUT.PUT_LINE('Veuillez saisir un montant positif.');
			        RAISE_APPLICATION_ERROR(-1001,'Montant négatif');
		        END IF;
        END FAIRETRANSFERTCOMPTE ;  
        
        /*AJMONTANTSOLDE permet d ajouter au compte avec l identifiant IdCpt donné le montant Valu indiqué*/
        PROCEDURE AJMONTANTSOLDE (IdCpt INTEGER, Value NUMBER)
            IS
            BEGIN
                IF Value = 0 THEN
			        DBMS_OUTPUT.PUT_LINE('Veuillez saisir un montant différent de 0.');
			        RAISE_APPLICATION_ERROR(-1011,'Montant nul');
                ELSE
                    UPDATE COMPTE SET SoldeCompte=(SoldeCompte+Value) WHERE IdCompte = IdCpt ;
                    DBMS_OUTPUT.PUT_LINE('Un changement du solde du compte '|| IdCpt || 'a eu lieu, d un montant de '|| Value || ' euros.');
		        END IF ;
        END AJMONTANTSOLDE ;
            
        
        /*ObtBanque permet d obtenir l identifiant de la banque auquel l identifiant client appartient*/
        FUNCTION ObtBanque (IdCpt INTEGER ) RETURN INTEGER
	        IS
		        I_banque INTEGER;
	        BEGIN
		        SELECT IdBanque INTO I_banque FROM COMPTE WHERE IdCompte = IdCpt ;
	        RETURN I_banque ;
        END ObtBanque ;


        /*ObtLibelleBanque permet d obtenir le libellé de la banque pour laquelle l identifiant a été indique*/
        FUNCTION ObtLibelleBanque (IdBnq INTEGER ) RETURN VARCHAR
	        IS
		        V_banque VARCHAR (50);
	        BEGIN
		        SELECT LibelleBanque INTO V_banque FROM BANQUE WHERE IdBanque = IdBnq ;
	        RETURN V_banque ;
        END ObtLibelleBanque ;


        FUNCTION BANQUEOPERATION (IdOpt INTEGER ) RETURN VARCHAR
	        IS
	        BEGIN 
	        RETURN ObtLibelleBanque( ObtBanque( ObtCompte(IdOpt) ) ); 
        END BANQUEOPERATION ;
        
        
        FUNCTION ObtSolde (IdCpt INTEGER) RETURN NUMBER
	        IS
		        N_solde NUMBER(10,2);
	        BEGIN
		        SELECT SoldeCompte INTO N_solde FROM COMPTE WHERE IdCompte = IdCpt;
	        RETURN N_solde ;
        END ObtSolde;
        
        FUNCTION ObtDecouvert (IdCpt INTEGER) RETURN NUMBER
	        IS
		        N_decouvert NUMBER(10,2);
	        BEGIN
		        SELECT DecouvertAutorise INTO N_decouvert FROM COMPTE WHERE IdCompte = IdCpt;
	        RETURN N_decouvert ;
        END ObtDecouvert ;
        
        FUNCTION ObtTypeCompte (IdCpt INTEGER) RETURN NUMBER
	        IS
		        I_type INTEGER ;
	        BEGIN
    	        SELECT IdTypeCompte INTO I_type FROM COMPTE WHERE IdCompte = IdCpt ;
	        RETURN I_type ;
        END ObtTypeCompte ;
            
END PACK_APP_BANQUE ;
/

/*LOT2_APPLI_Jallais_Adrien_test.sql*/

SELECT * FROM COMPTE WHERE IDCOMPTE = 1;
EXECUTE PACK_APP_BANQUE.AJMONTANTSOLDE (1, 100) ;
SELECT * FROM COMPTE WHERE IDCOMPTE = 1;
EXECUTE PACK_APP_BANQUE.AJMONTANTSOLDE (1, -200) ;
SELECT * FROM COMPTE WHERE IDCOMPTE = 1;

EXECUTE DBMS_OUTPUT.PUT_LINE('le compte 1 appartient a la banque num '|| PACK_APP_BANQUE.ObtBanque(1));
EXECUTE DBMS_OUTPUT.PUT_LINE('le libele de la banque num 1 est '|| PACK_APP_BANQUE.ObtLibelleBanque(1));
EXECUTE DBMS_OUTPUT.PUT_LINE('le solde du compte 1 est le suivant '|| PACK_APP_BANQUE.ObtSolde(1));
EXECUTE DBMS_OUTPUT.PUT_LINE('le decouvert du compte 1 est le suivant '|| PACK_APP_BANQUE.ObtDecouvert(1));
EXECUTE DBMS_OUTPUT.PUT_LINE('le type du compte 1 est le suivant '|| PACK_APP_BANQUE.ObtTypeCompte(1));

EXECUTE PACK_APP_BANQUE.AJOUTNOUVOPERATION(2, 666);
SELECT * FROM OPERATION WHERE MontantOperation = 666 ;

EXECUTE DBMS_OUTPUT.PUT_LINE('l idcompte de l operation 1 est '||PACK_APP_BANQUE.ObtCompte(1));
EXECUTE DBMS_OUTPUT.PUT_LINE('l idcompte de l operation 2 est '||PACK_APP_BANQUE.ObtCompte(2));
EXECUTE DBMS_OUTPUT.PUT_LINE('l idcompte de l operation 6 est '||PACK_APP_BANQUE.ObtCompte(6));
SELECT * FROM OPERATION WHERE IdOperation IN (1,2,6);

EXECUTE DBMS_OUTPUT.PUT_LINE('l montant de l operation 1 est '||PACK_APP_BANQUE.ObtCompte(1));
EXECUTE DBMS_OUTPUT.PUT_LINE('l montant de l operation 2 est '||PACK_APP_BANQUE.ObtCompte(2));
EXECUTE DBMS_OUTPUT.PUT_LINE('l montant de l operation 6 est '||PACK_APP_BANQUE.ObtCompte(6));
SELECT * FROM OPERATION WHERE IdOperation IN (1,2,6);

EXECUTE DBMS_OUTPUT.PUT_LINE('l operation 1 a lieu par la banque au libelle suivant '||PACK_APP_BANQUE.BanqueOperation(1));
EXECUTE DBMS_OUTPUT.PUT_LINE('l operation 2 a lieu par la banque au libelle suivant '||PACK_APP_BANQUE.BanqueOperation(2));
EXECUTE DBMS_OUTPUT.PUT_LINE('l operation 6 a lieu par la banque au libelle suivant '||PACK_APP_BANQUE.BanqueOperation(6));
SELECT * FROM OPERATION WHERE IdOperation IN (1,2,6);

EXECUTE DBMS_OUTPUT.PUT_LINE('le type du compte 8 est le suivant '|| PACK_APP_BANQUE.ObtTypeCompte(8)); 
EXECUTE DBMS_OUTPUT.PUT_LINE('le type du compte 9 est le suivant '|| PACK_APP_BANQUE.ObtTypeCompte(9)); 
SELECT * FROM COMPTE WHERE IdCompte IN (8,9);


/*LOT3_APPLI_Jallais_Adrien.txt*/

CREATE OR REPLACE TRIGGER T_CalculSolde
    BEFORE INSERT OR DELETE OR UPDATE ON OPERATION
    FOR EACH ROW
    DECLARE
        N_maj_montant NUMBER(10,2);
        I_IdCompte INTEGER ;
        I_IdOperation INTEGER ;
        
        N_solde NUMBER(10,2);
        N_decouvert NUMBER(10,2);

        I_BoolAudit INTEGER;
        V_LibelleCompte VARCHAR(30);
        
    BEGIN
        /*regle1*/
        IF INSERTING THEN
            N_maj_montant := :NEW.MontantOperation;
            I_IdCompte := :NEW.IdCompte;
            I_IdOperation := :NEW.IdOperation;
            PACK_APP_BANQUE.AJMONTANTSOLDE(I_IdCompte, N_maj_montant);
        ELSIF DELETING THEN
            N_maj_montant := :OLD.MontantOperation ;
            I_IdCompte := :OLD.IdCompte;
            I_IdOperation := :OLD.IdOperation;
            PACK_APP_BANQUE.AJMONTANTSOLDE(I_IdCompte, N_maj_montant);
        ELSIF UPDATING THEN
            N_maj_montant := :NEW.MontantOperation - :OLD.MontantOperation ;
            I_IdCompte := :OLD.IdCompte;
            I_IdOperation := :OLD.IdOperation;
            PACK_APP_BANQUE.AJMONTANTSOLDE(I_IdCompte, N_maj_montant);
        END IF;

        N_solde := PACK_APP_BANQUE.ObtSolde(I_IdCompte) ;
        SELECT DecouvertAutorise INTO N_decouvert FROM COMPTE WHERE IdCompte = I_IdCompte ;
        
        /*regle3*/
        /*type 6 est epargne*/
        IF (N_solde < -N_decouvert) AND (PACK_APP_BANQUE.ObtTypeCompte(I_IdCompte) = 6) THEN
            RAISE_APPLICATION_ERROR(-3001,'Solde négatif pour epargne');
        END IF ;
        
        /*regle2*/
        IF (N_solde < -N_decouvert) THEN
            SELECT COUNT(1) INTO I_BoolAudit FROM AUDITDECOUVERT WHERE IdCompte = I_IdCompte ;
            IF I_BoolAudit = 0 THEN
                SELECT LibelleCompte INTO V_LibelleCompte FROM COMPTE WHERE IdCompte = I_IdCompte ;
                INSERT INTO AUDITDECOUVERT (IdAudit, IdCompte, LibelleCompte, SoldeCompte, DecouvertAutorise, Depassement, IdDerniereOperation)
                    VALUES (SeqIdAudit.NextVal, I_IdCompte, V_LibelleCompte, N_solde, N_decouvert, ABS(N_solde + N_decouvert), I_IdOperation) ;
            ELSE
                UPDATE AUDITDECOUVERT SET
                    SoldeCompte = N_solde, 
                    Depassement = ABS(N_solde + N_decouvert),
                    IdDerniereOperation = I_IdOperation
                WHERE IdCompte = I_IdCompte ;
            END IF ;
            DBMS_OUTPUT.PUT_LINE('Un audit de découvert a été mis en place sur le compte '|| I_IdCompte || ' pour un dépassement de '|| ABS(N_solde + N_decouvert) || ' .');
        
        ELSE
            SELECT COUNT(1) INTO I_BoolAudit FROM AUDITDECOUVERT WHERE IdCompte = I_IdCompte ;
            IF (I_BoolAudit != 0) THEN
                DELETE FROM AUDITDECOUVERT WHERE IdCompte=I_IdCompte;
            END IF;
        END IF;
        
END T_CalculSolde ;
/


/*LOT3_APPLI_Jallais_Adrien-test.sql*/


SELECT * FROM COMPTE WHERE IdCompte = 2;
SELECT * FROM OPERATION WHERE IdCompte = 2;

EXECUTE PACK_APP_BANQUE.AJOUTNOUVOPERATION(2, 1234);

SELECT * FROM COMPTE WHERE IdCompte = 2;
SELECT * FROM OPERATION WHERE IdCompte = 2;
SELECT * FROM AUDITDECOUVERT WHERE IdCompte = 2 ;

EXECUTE PACK_APP_BANQUE.AJOUTNOUVOPERATION(2, -12345);

SELECT * FROM COMPTE WHERE IdCompte = 2;
SELECT * FROM OPERATION WHERE IdCompte = 2;
SELECT * FROM AUDITDECOUVERT WHERE IdCompte = 2 ;

EXECUTE PACK_APP_BANQUE.AJOUTNOUVOPERATION(2, -12);

SELECT * FROM COMPTE WHERE IdCompte = 2;
SELECT * FROM OPERATION WHERE IdCompte = 2;
SELECT * FROM AUDITDECOUVERT WHERE IdCompte = 2 ;

EXECUTE PACK_APP_BANQUE.AJOUTNOUVOPERATION(2, 12+12345);

SELECT * FROM COMPTE WHERE IdCompte = 2;
SELECT * FROM OPERATION WHERE IdCompte = 2;
SELECT * FROM AUDITDECOUVERT WHERE IdCompte = 2 ;


/*OPERATION-vague2*/

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
 
 
/*LOT4_APPLI_Jallais_Adrien.sql*/

/*vue VW_CONSULTERCOMPTE*/
CREATE OR REPLACE VIEW VW_CONSULTERCOMPTE AS
    SELECT IdCompte "Identifiant", LibelleCompte "Libellé", (SELECT LibelleTypeCompte FROM TYPECOMPTE WHERE IdTypeCompte=IdCompte) "Type", SoldeCompte "Solde"
    FROM COMPTE ;


/*vue VW_CONSULTERDECOUVERT*/
CREATE OR REPLACE VIEW VW_CONSULTERDECOUVERT AS
    SELECT  IdCompte "Identifiant", LibelleCompte "Libellé", (SELECT LibelleTypeCompte FROM TYPECOMPTE WHERE IdTypeCompte=IdCompte) "Type", SoldeCompte "Solde", Depassement "Dépassement"
    FROM AUDITDECOUVERT ;


/*vue VW_CONSULTEROPERATION*/
CREATE OR REPLACE VIEW VW_CONSULTEROPERATION AS
    SELECT IdOperation "Identifiant", MontantOperation "Montant", DateOperation "Date"
    FROM OPERATION
    ORDER BY DateOperation DESC, IdCompte ASC ;

/*vue VW_CPT_CC*/
CREATE OR REPLACE VIEW VW_CPT_CC AS
    SELECT IdCompte "Identifiant", LibelleCompte "Libellé", SoldeCompte "Solde"
    From COMPTE
    WHERE IdTypeCompte = 2 ; 
/*type compte = 2 pour CC*/


/*trigger TRG_VW_CPT_CC*/
/*creation pour date de ce jour chez HSBC PARIS pour un Compte Courant avec un decouvert aleatoire*/
CREATE OR REPLACE TRIGGER TRG_VW_CPT_CC
    INSTEAD OF INSERT ON VW_CPT_CC
    FOR EACH ROW
    DECLARE
        V_LibelleCompte VARCHAR(30);
        N_solde NUMBER(10,2);
        N_rand_decouvert NUMBER(10,2);
        I_Banque_HSBC INTEGER;
        I_typCompte_CC INTEGER;
    BEGIN
        V_LibelleCompte := :NEW."Libelle";
        N_solde := :NEW."Solde";
        N_rand_decouvert := DBMS_RANDOM.VALUE(1,100);
        SELECT IdTypeCompte INTO I_typCompte_CC FROM TYPECOMPTE WHERE LibelleTypeCompte='Compte Courant' ;
        SELECT IdBanque INTO I_Banque_HSBC FROM BANQUE WHERE LibelleBanque='HSBC Paris';
        
        INSERT INTO COMPTE(IdCompte, LibelleCompte,    SoldeCompte, DecouvertAutorise, IdBanque, IdTypeCompte ) 
            VALUES(SeqIdCompte.NextVal, V_LibelleCompte, N_solde, N_rand_decouvert, I_Banque_HSBC, I_typCompte_CC);
End ;
/

/*LOT4_APPLI_Jallais_Adrien-test.sql*/
SELECT * FROM VW_CONSULTERCOMPTE ;
SELECT * FROM VW_CONSULTERDECOUVERT ;
SELECT * FROM VW_CONSULTEROPERATION ;
SELECT * FROM VW_CPT_CC ;

INSERT INTO VW_CPT_CC("Identifiant", "Libelle", "Solde") 
    VALUES(SeqIdCompte.NextVal, 'Adrien','1234');
INSERT INTO VW_CPT_CC("Libelle", "Solde") 
    VALUES('Cresus','4321');
    
SELECT * FROM VW_CPT_CC ; 
/*insertion possible seulement si trigger*/


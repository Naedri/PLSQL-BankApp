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
		        /*DBMS_OUTPUT.PUT_LINE('L operation ' || SeqIdOperation.CurrVal || ' a eu lieu sur le compte '|| IdCpt || ' pour un montant de '|| Value || ' .');*/
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
                    /*DBMS_OUTPUT.PUT_LINE('Un changement du solde du compte '|| IdCpt || 'a eu lieu, d un montant de '|| Value || ' euros.');*/
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

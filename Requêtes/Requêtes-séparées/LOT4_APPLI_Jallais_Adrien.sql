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

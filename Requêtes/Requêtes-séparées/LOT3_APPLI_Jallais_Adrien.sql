/*LOT3_APPLI_Jallais_Adrien.sql*/

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


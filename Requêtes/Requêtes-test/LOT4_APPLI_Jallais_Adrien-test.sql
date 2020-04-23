/*LOT4_APPLI_Jallais_Adrien-test.sql*/

SELECT * FROM VW_CONSULTERCOMPTE ;
SELECT * FROM VW_CONSULTERDECOUVERT ;
SELECT * FROM VW_CONSULTEROPERATION ;
SELECT * FROM VW_CPT_CC ;

INSERT INTO VW_CPT_CC("Identifiant", "Libelle", "Solde") 
    VALUES(SeqIdCompte.NextVal, 'Adrien','1234');
INSERT INTO VW_CPT_CC("Libelle", "Solde") 
    VALUES('Cresus','4321');
    
SELECT * FROM VW_CPT_CC ; --insertion possible 

/*LOT2_APPLI_Jallais_Adrien-test.sql*/

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

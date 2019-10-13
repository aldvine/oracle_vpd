/** USER4 **/
EXECUTE ADMIN18.set_user_ctx_pkg.set_user;
/** Affichage du role */
SELECT SYS_CONTEXT('USER_CTX','role') FROM DUAL;

/** Affiche les éléments de la vue */
SELECT * FROM ADMIN18.VUE_EVENTS WHERE idEvent = 'EVENT1';

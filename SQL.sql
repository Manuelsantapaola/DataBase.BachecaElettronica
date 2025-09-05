-- MySQL Workbench Forward Engineering 
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0; 
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0; 
SET @OLD_SQL_MODE=@@SQL_MODE, 
SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_F
OR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'; 
-- ----------------------------------------------------- 
-- Schema progeƩo
-- ----------------------------------------------------- 
DROP SCHEMA IF EXISTS `progeƩo` ;
-- ----------------------------------------------------- 
-- Schema progeƩo
-- ----------------------------------------------------- 
CREATE SCHEMA IF NOT EXISTS `progeƩo` DEFAULT CHARACTER SET uƞ8 ;
USE `progeƩo` ;
-- ----------------------------------------------------- 
-- Table `progeƩo`.`general_user`
-- ----------------------------------------------------- 
DROP TABLE IF EXISTS `progeƩo`.`general_user` ;
CREATE TABLE IF NOT EXISTS `progeƩo`.`general_user` (
 `Username` VARCHAR(45) NOT NULL, 
 `DaƟ_anagrafici` DATE NOT NULL,
 `ind_faƩurazione` VARCHAR(45) NOT NULL,
 `ind_domicilio` VARCHAR(45) NOT NULL, 
 `privilegio` ENUM('admin', 'utente') NOT NULL DEFAULT 'utente', 
 `password` CHAR(32) NOT NULL, 
 `telefono` VARCHAR(10) NULL, 
 `cellulare` VARCHAR(10) NULL, 
 `Email` VARCHAR(45) NULL, 
 PRIMARY KEY (`Username`)) 
ENGINE = InnoDB 
DEFAULT CHARACTER SET = uƞ8mb3;
-- ----------------------------------------------------- 
-- Table `progeƩo`.`Categoria`
-- ----------------------------------------------------- 
DROP TABLE IF EXISTS `progeƩo`.`Categoria` ;
CREATE TABLE IF NOT EXISTS `progeƩo`.`Categoria` (
 `IDCategoria` INT NOT NULL AUTO_INCREMENT, 
 `Nome` VARCHAR(45) NOT NULL, 
 `UsernameC` VARCHAR(45) NOT NULL, 
 PRIMARY KEY (`IDCategoria`), 
 INDEX `Ņ_Categoria_General user1_idx` (`UsernameC` ASC) VISIBLE,
 CONSTRAINT `Ņ_Categoria_General user1`
 FOREIGN KEY (`UsernameC`) 
 REFERENCES `progeƩo`.`general_user` (`Username`)
 ON DELETE NO ACTION 
 ON UPDATE NO ACTION) 
ENGINE = InnoDB; 
-- ----------------------------------------------------- 
-- Table `progeƩo`.`Annuncio`
-- ----------------------------------------------------- 
DROP TABLE IF EXISTS `progeƩo`.`Annuncio` ;
CREATE TABLE IF NOT EXISTS `progeƩo`.`Annuncio` (
 `IDAnnuncio` INT NOT NULL AUTO_INCREMENT, 
 `Ɵtolo` VARCHAR(45) NOT NULL,
 `prezzo` INT NOT NULL, 
 `oggeƩo` VARCHAR(45) NOT NULL,
 `descrizione` VARCHAR(100) NOT NULL, 
 `stato` ENUM('venduto', 'online') NOT NULL, 
 `UsernameA` VARCHAR(45) NOT NULL, 
 `IDA` INT NOT NULL, 
 PRIMARY KEY (`IDAnnuncio`, `UsernameA`), 
 INDEX `Ņ_Annuncio_General user1_idx` (`UsernameA` ASC) VISIBLE,
 INDEX `Ņ_Annuncio_Categoria1_idx` (`IDA` ASC) VISIBLE,
 CONSTRAINT `Ņ_Annuncio_General user1`
 FOREIGN KEY (`UsernameA`) 
 REFERENCES `progeƩo`.`general_user` (`Username`)
 ON DELETE NO ACTION 
 ON UPDATE NO ACTION, 
 CONSTRAINT `Ņ_Annuncio_Categoria1`
 FOREIGN KEY (`IDA`) 
 REFERENCES `progeƩo`.`Categoria` (`IDCategoria`)
 ON DELETE NO ACTION 
 ON UPDATE NO ACTION) 
ENGINE = InnoDB; 
-- ----------------------------------------------------- 
-- Table `progeƩo`.`Messaggio_privato`
-- ----------------------------------------------------- 
DROP TABLE IF EXISTS `progeƩo`.`Messaggio_privato` ;
CREATE TABLE IF NOT EXISTS `progeƩo`.`Messaggio_privato` (
 `IDMessaggio` INT NOT NULL AUTO_INCREMENT, 
 `Ɵmestamp` DATETIME NOT NULL,
 `msgtxt` VARCHAR(200) NOT NULL, 
 `IDAnnuncioM` INT NOT NULL, 
 `UsernameM` VARCHAR(45) NOT NULL, 
 `UsernameCM` VARCHAR(45) NOT NULL, 
 `UsernameRicevente` VARCHAR(45) NOT NULL, 
 PRIMARY KEY (`IDMessaggio`, `IDAnnuncioM`, `UsernameM`, `UsernameCM`, `UsernameRicevente`), 
 INDEX `Ņ_Messaggio privato_Annuncio1_idx` (`IDAnnuncioM` ASC, `UsernameM` ASC) VISIBLE,
 INDEX `Ņ_Messaggio privato_General user1_idx` (`UsernameCM` ASC) VISIBLE,
 CONSTRAINT `Ņ_Messaggio privato_Annuncio1`
 FOREIGN KEY (`IDAnnuncioM` , `UsernameM`) 
 REFERENCES `progeƩo`.`Annuncio` (`IDAnnuncio` , `UsernameA`)
 ON DELETE NO ACTION 
 ON UPDATE NO ACTION, 
 CONSTRAINT `Ņ_Messaggio privato_General user1`
 FOREIGN KEY (`UsernameCM`) 
 REFERENCES `progeƩo`.`general_user` (`Username`)
 ON DELETE NO ACTION 
 ON UPDATE NO ACTION) 
ENGINE = InnoDB; 
-- ----------------------------------------------------- 
-- Table `progeƩo`.`Commento`
-- ----------------------------------------------------- 
DROP TABLE IF EXISTS `progeƩo`.`Commento` ;
CREATE TABLE IF NOT EXISTS `progeƩo`.`Commento` (
 `IDCommento` INT NOT NULL AUTO_INCREMENT, 
 `Ɵmestamp_commento` DATETIME NOT NULL,
 `msgtxt_commento` VARCHAR(350) NOT NULL, 
 `IDAnnuncioC` INT NOT NULL, 
 `Username_Commento` VARCHAR(45) NOT NULL, 
 `UsernameCommento` VARCHAR(45) NOT NULL, 
 PRIMARY KEY (`IDCommento`, `IDAnnuncioC`, `Username_Commento`, `UsernameCommento`), 
 INDEX `Ņ_Commento_Annuncio1_idx` (`IDAnnuncioC` ASC, `Username_Commento` ASC) VISIBLE,
 INDEX `Ņ_Commento_General user1_idx` (`UsernameCommento` ASC) VISIBLE,
 CONSTRAINT `Ņ_Commento_Annuncio1`
 FOREIGN KEY (`IDAnnuncioC` , `Username_Commento`) 
 REFERENCES `progeƩo`.`Annuncio` (`IDAnnuncio` , `UsernameA`)
 ON DELETE NO ACTION 
 ON UPDATE NO ACTION, 
 CONSTRAINT `Ņ_Commento_General user1`
 FOREIGN KEY (`UsernameCommento`) 
 REFERENCES `progeƩo`.`general_user` (`Username`)
 ON DELETE NO ACTION 
 ON UPDATE NO ACTION) 
ENGINE = InnoDB; 
-- ----------------------------------------------------- 
-- Table `progeƩo`.`segui`
-- ----------------------------------------------------- 
DROP TABLE IF EXISTS `progeƩo`.`segui` ;
CREATE TABLE IF NOT EXISTS `progeƩo`.`segui` (
 `UsernameS` VARCHAR(45) NOT NULL, 
 `IDAnnuncioS` INT NOT NULL, 
 PRIMARY KEY (`UsernameS`, `IDAnnuncioS`), 
 INDEX `Ņ_General user_has_Annuncio_Annuncio1_idx` (`IDAnnuncioS` ASC) VISIBLE,
 INDEX `Ņ_General user_has_Annuncio_General user_idx` (`UsernameS` ASC) VISIBLE,
 CONSTRAINT `Ņ_General user_has_Annuncio_General user`
 FOREIGN KEY (`UsernameS`) 
 REFERENCES `progeƩo`.`general_user` (`Username`)
 ON DELETE NO ACTION 
 ON UPDATE NO ACTION, 
 CONSTRAINT `Ņ_General user_has_Annuncio_Annuncio1`
 FOREIGN KEY (`IDAnnuncioS`) 
 REFERENCES `progeƩo`.`Annuncio` (`IDAnnuncio`)
 ON DELETE NO ACTION 
 ON UPDATE NO ACTION) 
ENGINE = InnoDB; 
USE `progeƩo` ;
-- ----------------------------------------------------- 
-- procedure inserireUtente 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`inserireUtente`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `inserireUtente` (in var_username varchar(45),in var_data DATE ,in 
var_ind_faƩurazione varchar(45), in var_ind_domicilio varchar(45),
in var_password char(32), in var_privilegio enum('admin','utente'), in var_telefono varchar(10), in 
var_cellulare varchar(10), in var_email varchar(45)) 
BEGIN 
insert into `General_user`(Username, DaƟ_anagrafici, ind_faƩurazione, Ind_Domicilio, password, Privilegio, 
telefono, Cellulare, Email) 
values (var_username, var_data, var_ind_faƩurazione, var_ind_domicilio, var_password, var_privilegio, 
var_telefono, var_cellulare, var_email); 
END$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure login 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`login`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `login` (in var_username char(32), in var_pass varchar(45), out var_role 
INT) 
BEGIN 
 declare var_user_role ENUM('admin','utente'); 
 select `privilegio` from `General_user` 
 where `username` = var_username 
 and `password` = var_pass 
 into var_user_role; 
 if var_user_role='admin' then 
 
 set var_role=1; 
 elseif var_user_role= 'utente' then 
 
 set var_role=2; 
 end if; 
END$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure creare_annuncio 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`creare_annuncio`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `creare_annuncio` (in var_Ɵtolo varchar(45), in var_prezzo int, in var_oggeƩo 
varchar(45), in var_descrizione varchar(100), in var_stato enum('venduto','online') , in var_username 
varchar(45), in var_categoria varchar(45), out var_ritorno int) 
BEGIN 
 declare var INT; 
 declare var2 INT; 
declare exit handler for sqlexcepƟon
 begin 
 rollback; 
 resignal; 
 end; 
set transacƟon isolaƟon level repeatable read;
 start transacƟon;
 SELECT COUNT(*) 
 from `General_user` 
 where Username=var_username into var; 
 IF var > 0 
 then 
 SELECT COUNT(*) 
 from Categoria 
 where Nome =var_categoria into var2; 
 if var2>0 
 then 
 INSERT INTO Annuncio (Ɵtolo, prezzo, oggeƩo, descrizione, stato, UsernameA, IDA)
 values (var_Ɵtolo, var_prezzo, var_oggeƩo, var_descrizione , var_stato, var_username 
,(select IDCategoria from Categoria where (Nome=Var_categoria))); 
 
 Set var_ritorno = last_insert_id(); 
 end if; 
 end if; 
 
 commit; 
END$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure seguire_annuncio 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`seguire_annuncio`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `seguire_annuncio` (in var_idannuncio int, in var_username varchar(45)) 
BEGIN 
 declare var int; 
 declare var2 int; 
declare exit handler for sqlexcepƟon
 begin 
 rollback; 
 resignal; 
 end; 
set transacƟon isolaƟon level read commiƩed;
 start transacƟon;
 select count(*) 
 from General_user 
 where Username=var_username into var; 
 if var>0 
 then 
 select count(*) 
 from Annuncio 
 where IDAnnuncio=var_idannuncio into var2; 
 if var2>0 
 then 
 INSERT INTO segui ( UsernameS, IDAnnuncioS) 
 VALUES (var_username, var_idannuncio); 
 end if; 
 end if; 
 commit; 
END$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure creareCategoria 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`creareCategoria`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE DEFINER=`Manuel`@`localhost` PROCEDURE `creareCategoria`(in var_nome varchar(45), in 
var_username varchar(45)) 
BEGIN 
 declare var INT; 
declare exit handler for sqlexcepƟon
 begin 
 rollback; 
 resignal; 
 end; 
set transacƟon isolaƟon level repeatable read;
 start transacƟon;
 
 
 SELECT count(*) 
 from `General_user` 
 where Username=var_username into var ; 
 IF var > 0 
 then 
 
 INSERT INTO Categoria (Nome, UsernameC) 
 VALUES (var_nome, var_username); 
 
 
 end if; 
 commit; 
END$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure scrivi_commento 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`scrivi_commento`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `scrivi_commento` (in var_msgtctC varchar(350), in var_idannuncio int, in 
var_username varchar(45), in var_usernamec varchar(45)) 
BEGIN 
 declare var INT; 
 declare var2 INT; 
 declare exit handler for sqlexcepƟon
 begin 
 rollback; 
 resignal; 
 end; 
set transacƟon isolaƟon level repeatable read;
 start transacƟon;
 SELECT count(*) 
 from `Annuncio` 
 where `IDAnnuncio` = var_idannuncio into var ; 
 IF var > 0 
 then 
 SELECT count(*) 
 from `General_user` 
 where `Username`=var_username into var2 ; 
 IF var2> 0 
 then 
 INSERT INTO Commento (Ɵmestamp_commento, 
msgtxt_commento, IDAnnuncioC, Username_Commento, UsernameCommento) 
 VALUES ((now()), var_msgtctC, var_idannuncio, var_username, 
var_usernamec); 
 end if; 
 end if; 
 commit; 
END$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure scrivi_messaggio 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`scrivi_messaggio`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `scrivi_messaggio` (in var_msgtct varchar(350), in var_idannuncio int, in var_username 
varchar(45), in var_scriƩore varchar(45), in var_ricevente varchar(45))
BEGIN 
 declare var INT; 
 declare var2 INT; 
 declare exit handler for sqlexcepƟon
 begin 
 rollback; 
 resignal; 
 end; 
set transacƟon isolaƟon level repeatable read;
 start transacƟon;
 SELECT count(*) 
 from `Annuncio` 
 where `IDAnnuncio` = var_idannuncio into var ; 
 IF var > 0 
 then 
 SELECT count(*) 
 from `General_user` 
 where `Username`=var_username into var2 ; 
 IF var2> 0 
 then 
 INSERT INTO Messaggio_privato(Ɵmestamp, msgtxt, IDAnnuncioM, 
UsernameM, UsernameCM,UsernameRicevente) 
 VALUES ((now()), var_msgtct, var_idannuncio, var_username, 
var_scriƩore, var_ricevente);
 end if; 
 end if; 
 commit; 
END$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure annuncioVenduto 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`annuncioVenduto`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `annuncioVenduto` (in var_IDannuncio int, in var_stato ENUM('venduto','online')) 
begin 
 declare var int; 
declare exit handler for sqlexcepƟon
 begin 
 rollback; 
 resignal; 
 end; 
set transacƟon isolaƟon level Read commiƩed;
 start transacƟon;
 select count(*) 
 from Annuncio 
 where IDAnnuncio=var_IDannuncio into var; 
 if var>0 
 then 
 UPDATE `Annuncio` 
 SET 
 `stato` = var_stato 
 WHERE 
 `IDAnnuncio` = var_IDannuncio; 
 end if; 
 commit; 
END$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure modifica_annuncio 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`modifica_annuncio`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `modifica_annuncio` (in var_IDannuncio int, in var_Ɵtolo varchar(45), in var_prezzo int, 
in var_descrizione varchar(100)) 
BEGIN 
 declare var int; 
 declare exit handler for sqlexcepƟon
 begin 
 rollback; 
 resignal; 
 end; 
set transacƟon isolaƟon level repeatable read;
 start transacƟon;
 select count(*) 
 from Annuncio 
 where IDAnnuncio=var_IDannuncio into var; 
 if var>0 
 then 
 UPDATE `Annuncio` 
 SET 
 `Ɵtolo`= var_Ɵtolo,
 `prezzo`= var_prezzo, 
 `descrizione`=var_descrizione 
 WHERE 
 `IDAnnuncio` = var_IDannuncio; 
 end if; 
 commit; 
END$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure prendi_annunciDiunVenditore 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`prendi_annunciDiunVenditore`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `prendi_annunciDiunVenditore` (in var_username varchar(45)) 
BEGIN 
 declare var int; 
declare exit handler for sqlexcepƟon
 begin 
 rollback; 
 resignal; 
 end; 
 
 set transacƟon isolaƟon level read commiƩed;
 set transacƟon read only;
 start transacƟon;
 
 select count(*) 
 from General_user 
 where Username=var_username into var; 
 if var>0 
 then 
 select IDAnnuncio , Ɵtolo, prezzo, oggeƩo, descrizione, (select nome from Categoria where 
(IDA=IDCategoria)) as IDA 
 from Annuncio 
 where UsernameA= var_username; 
 end if; 
END$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure listaAnnunci 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`listaAnnunci`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `listaAnnunci` () 
BEGIN 
 declare var int; 
 declare exit handler for sqlexcepƟon
 begin 
 rollback; 
 resignal; 
 end; 
 
 set transacƟon isolaƟon level read commiƩed;
 set transacƟon read only;
 start transacƟon;
 select count(*) 
 from Annuncio 
 where stato != 'venduto' into var; 
 if var>0 
 then 
 select IDAnnuncio, Ɵtolo, prezzo, oggeƩo, descrizione, UsernameA, IDA
 from Annuncio; 
 
 end if; 
 commit; 
end$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure prendiUno_Annuncio 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`prendiUno_Annuncio`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `prendiUno_Annuncio` (in var_idannuncio int) 
BEGIN 
 declare var int; 
 declare exit handler for sqlexcepƟon
 begin 
 rollback; 
 resignal; 
 end; 
 
 set transacƟon isolaƟon level read commiƩed;
 set transacƟon read only;
 start transacƟon;
 select count(*) 
 from Annuncio 
 where IDAnnuncio=var_idannuncio and stato != 'venduto' into var; 
 if var>0 
 then 
 
 select IDAnnuncio, Ɵtolo, prezzo, oggeƩo, descrizione, stato, UsernameA, IDA
 from `Annuncio` 
 where IDAnnuncio=var_idannuncio; 
 else 
 signal sqlstate '45000' 
 set MESSAGE_TEXT ='Lannuncio non è più in commercio '; 
 end if; 
 commit; 
END$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure VisualizzaCommenƟ
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`VisualizzaCommenƟ`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `VisualizzaCommenƟ` (in var_id int)
BEGIN 
declare var int; 
 declare exit handler for sqlexcepƟon
 begin 
 rollback; 
 resignal; 
 end; 
 
 set transacƟon isolaƟon level read commiƩed;
 set transacƟon read only;
 start transacƟon;
 select count(*) 
 from Annuncio 
 where IDAnnuncio= var_id into var; 
 if var>0 
 then 
 select IDCommento, Ɵmestamp_commento, msgtxt_commento, UsernameCommento, 
UsernameCommento 
 from Commento 
 where IDAnnuncioC= var_id; 
 END IF; 
END$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure VisualizzaMessaggi 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`VisualizzaMessaggi`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `VisualizzaMessaggi` (in var_id int,in var_user varchar(45)) 
BEGIN 
 declare var int; 
 declare var2 int; 
declare exit handler for sqlexcepƟon
 begin 
 rollback; 
 resignal; 
 end; 
 
 set transacƟon isolaƟon level read commiƩed;
 set transacƟon read only;
 start transacƟon;
 select count(*) 
 from Annuncio 
 where IDAnnuncio= var_id into var; 
 if var>0 
 then 
 select count(*) 
 from General_user 
 where var_user=Username into var2; 
 if var2>0 
 then 
 select IDMessaggio, Ɵmestamp, msgtxt, usernameRicevente, UsernameCM, 
UsernameM, IDAnnuncioM 
 from Messaggio_privato 
 where (UsernameM= var_user or usernameRicevente = var_user ) and 
var_id=IDAnnuncioM; 
 end if; 
 end if; 
END$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure VisualizzaCategoria 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`VisualizzaCategoria`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `VisualizzaCategoria` () 
BEGIN 
declare exit handler for sqlexcepƟon
 begin 
 rollback; 
 resignal; 
 end; 
 
 set transacƟon isolaƟon level read uncommiƩed;
 set transacƟon read only;
 start transacƟon;
 select IDCategoria, nome 
 from Categoria; 
END$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure Report 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`Report`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `Report` () 
BEGIN 
 declare exit handler for sqlexcepƟon
 begin 
 rollback; 
 resignal; 
 end; 
 
 set transacƟon isolaƟon level read commiƩed;
 set transacƟon read only;
 start transacƟon;
 select UsernameA, 
 COUNT(CASE WHEN stato = 'venduto' THEN 1 END) AS annunci_venduƟ,
 COUNT(*) AS annunci_totali, 
 ROUND((COUNT(CASE WHEN stato = 'venduto' THEN 1 END) * 100.0) / COUNT(*), 2) AS 
percentuale_venduƟ
 from Annuncio 
 group by UsernameA; 
END$$ 
DELIMITER ; 
-- ----------------------------------------------------- 
-- procedure VisualizzaLeChat 
-- ----------------------------------------------------- 
USE `progeƩo`;
DROP procedure IF EXISTS `progeƩo`.`VisualizzaLeChat`;
DELIMITER $$ 
USE `progeƩo`$$
CREATE PROCEDURE `VisualizzaLeChat` (in var_User varchar(45)) 
BEGIN 
 declare exit handler for sqlexcepƟon
 begin 
 rollback; 
 resignal; 
 end; 
 
 set transacƟon isolaƟon level read commiƩed;
 set transacƟon read only;
 start transacƟon;
 select msgtxt,UsernameM, UsernameCM, UsernameRicevente, IDAnnuncioM, IDMessaggio 
 from Messaggio_privato 
 WHERE UsernameM IN ( 
 SELECT DISTINCT UsernameM 
 FROM Messaggio_privato 
 WHERE UsernameCM = var_User OR UsernameRicevente = var_User 
 
 ); 
 
END$$ 
DELIMITER ; 
USE `progeƩo`;
DELIMITER $$ 
USE `progeƩo`$$
DROP TRIGGER IF EXISTS `progeƩo`.`MexNoƟfica` $$
USE `progeƩo`$$
CREATE DEFINER = CURRENT_USER TRIGGER `progeƩo`.`MexNoƟfica` BEFORE UPDATE ON `Annuncio` FOR 
EACH ROW 
BEGIN 
declare var int; 
 declare var3 int; 
 declare varscri varchar(45); 
 select count(*) 
 from segui 
 where IDAnnuncioS = new.IDAnnuncio 
 into var; 
 set var3 = 0; 
 
 while var3 != var do 
 
 select UsernameS into varscri 
 from segui 
 where IDAnnuncioS = new.IDAnnuncio 
 LIMIT 1 OFFSET var3; 
 
 Insert into Messaggio_privato(Ɵmestamp, msgtxt, IDAnnuncioM, UsernameM, 
UsernameCM,UsernameRicevente) 
 value((NOW()), 'ho modifacato il post! vallo a guardare', new.IDAnnuncio, 
new.UsernameA,new.UsernameA, varscri); 
 
 set var3 = var3 + 1; 
 end while; 
END$$ 
USE `progeƩo`$$
DROP TRIGGER IF EXISTS `progeƩo`.`Pulizia` $$
USE `progeƩo`$$
CREATE DEFINER = CURRENT_USER TRIGGER `progeƩo`.`Pulizia` BEFORE UPDATE ON `Annuncio` FOR EACH 
ROW 
BEGIN 
 
 if new.stato='venduto' and old.stato != 'venduto' 
 then 
 delete from Messaggio_privato where IDAnnuncioM= new.IDAnnuncio; 
 delete from Commento where IDAnnuncioC=new.IDAnnuncio; 
 delete from segui where IDAnnuncioS=new.IDAnnuncio; 
 end if; 
END$$ 
USE `progeƩo`$$
DROP TRIGGER IF EXISTS `progeƩo`.`Messaggio_privato_BEFORE_INSERT` $$
USE `progeƩo`$$
CREATE DEFINER = CURRENT_USER TRIGGER `progeƩo`.`Messaggio_privato_BEFORE_INSERT` BEFORE 
INSERT ON `Messaggio_privato` FOR EACH ROW 
BEGIN 
 if length(new.msgtxt)>199 
 then 
 signal sqlstate '45000' 
 set MESSAGE_TEXT ='il messaggio supera la lunghezza consenƟta';
 end if; 
END$$ 
USE `progeƩo`$$
DROP TRIGGER IF EXISTS `progeƩo`.`Commento_BEFORE_INSERT` $$
USE `progeƩo`$$
CREATE DEFINER = CURRENT_USER TRIGGER `progeƩo`.`Commento_BEFORE_INSERT` BEFORE INSERT ON 
`Commento` FOR EACH ROW 
BEGIN 
 if length(new.msgtxt_commento)>349 
 then 
 signal sqlstate '45000' 
 set MESSAGE_TEXT ='il Commento supera la lunghezza consenƟta';
 end if; 
END$$ 
DELIMITER ; 
SET SQL_MODE = ''; 
DROP USER IF EXISTS Utente; 
SET 
SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_F
OR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'; 
CREATE USER 'Utente' IDENTIFIED BY 'Utente02!'; 
GRANT EXECUTE ON procedure `progeƩo`.`login` TO 'Utente';
GRANT UPDATE, TRIGGER, SELECT, INSERT, DELETE ON TABLE `progeƩo`.`general_user` TO 'Utente';
GRANT EXECUTE ON procedure `progeƩo`.`inserireUtente` TO 'Utente';
GRANT DELETE, INSERT, SELECT, UPDATE, TRIGGER ON TABLE `progeƩo`.`Annuncio` TO 'Utente';
GRANT DELETE, INSERT, SELECT, UPDATE, TRIGGER ON TABLE `progeƩo`.`Commento` TO 'Utente';
GRANT DELETE, INSERT, SELECT, UPDATE, TRIGGER ON TABLE `progeƩo`.`Messaggio_privato` TO 'Utente';
GRANT DELETE, INSERT, SELECT, UPDATE, TRIGGER ON TABLE `progeƩo`.`segui` TO 'Utente';
GRANT DELETE, INSERT, SELECT, UPDATE, TRIGGER ON TABLE `progeƩo`.`general_user` TO 'Utente';
GRANT EXECUTE ON procedure `progeƩo`.`creare_annuncio` TO 'Utente';
GRANT EXECUTE ON procedure `progeƩo`.`annuncioVenduto` TO 'Utente';
GRANT EXECUTE ON procedure `progeƩo`.`listaAnnunci` TO 'Utente';
GRANT EXECUTE ON procedure `progeƩo`.`modifica_annuncio` TO 'Utente';
GRANT EXECUTE ON procedure `progeƩo`.`prendi_annunciDiunVenditore` TO 'Utente';
GRANT EXECUTE ON procedure `progeƩo`.`prendiUno_Annuncio` TO 'Utente';
GRANT EXECUTE ON procedure `progeƩo`.`scrivi_commento` TO 'Utente';
GRANT EXECUTE ON procedure `progeƩo`.`scrivi_messaggio` TO 'Utente';
GRANT EXECUTE ON procedure `progeƩo`.`seguire_annuncio` TO 'Utente';
GRANT EXECUTE ON procedure `progeƩo`.`VisualizzaCategoria` TO 'Utente';
GRANT EXECUTE ON procedure `progeƩo`.`VisualizzaMessaggi` TO 'Utente';
GRANT EXECUTE ON procedure `progeƩo`.`VisualizzaCommenƟ` TO 'Utente';
GRANT EXECUTE ON procedure `progeƩo`.`VisualizzaLeChat` TO 'Utente';
SET SQL_MODE = ''; 
DROP USER IF EXISTS Login; 
SET 
SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_F
OR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'; 
CREATE USER 'Login' IDENTIFIED BY 'login'; 
GRANT EXECUTE ON procedure `progeƩo`.`login` TO 'Login';
GRANT UPDATE, TRIGGER, SELECT, INSERT, DELETE ON TABLE `progeƩo`.`general_user` TO 'Login';
GRANT EXECUTE ON procedure `progeƩo`.`inserireUtente` TO 'Login';
SET SQL_MODE = ''; 
DROP USER IF EXISTS admin; 
SET 
SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_F
OR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'; 
CREATE USER 'admin' IDENTIFIED BY 'admin'; 
GRANT EXECUTE ON procedure `progeƩo`.`login` TO 'admin';
GRANT UPDATE, TRIGGER, SELECT, INSERT, DELETE ON TABLE `progeƩo`.`general_user` TO 'admin';
GRANT EXECUTE ON procedure `progeƩo`.`inserireUtente` TO 'admin';
GRANT TRIGGER, UPDATE, SELECT, INSERT, DELETE ON TABLE `progeƩo`.`Categoria` TO 'admin';
GRANT EXECUTE ON procedure `progeƩo`.`creareCategoria` TO 'admin';
GRANT EXECUTE ON procedure `progeƩo`.`VisualizzaCategoria` TO 'admin';
GRANT EXECUTE ON procedure `progeƩo`.`Report` TO 'admin';
SET SQL_MODE=@OLD_SQL_MODE; 
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS; 
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS; 
-- ----------------------------------------------------- 
-- Data for table `progeƩo`.`general_user`
-- ----------------------------------------------------- 
START TRANSACTION; 
USE `progeƩo`;
INSERT INTO `progeƩo`.`general_user` (`Username`, `DaƟ_anagrafici`, `ind_faƩurazione`, `ind_domicilio`, 
`privilegio`, `password`, `telefono`, `cellulare`, `Email`) VALUES ('test1', '2002-08-08', '11111', '11111', 
'admin', 'test', NULL, NULL, NULL); 
INSERT INTO `progeƩo`.`general_user` (`Username`, `DaƟ_anagrafici`, `ind_faƩurazione`, `ind_domicilio`, 
`privilegio`, `password`, `telefono`, `cellulare`, `Email`) VALUES ('test2', '2002-08-07', '11112', '11112', 
'utente', 'test1', NULL, NULL, NULL); 
INSERT INTO `progeƩo`.`general_user` (`Username`, `DaƟ_anagrafici`, `ind_faƩurazione`, `ind_domicilio`, 
`privilegio`, `password`, `telefono`, `cellulare`, `Email`) VALUES ('test3', '2002-08-06', '11113', '11113', 
'utente', 'test2', NULL, NULL, NULL); 
COMMIT; 
-- ----------------------------------------------------- 
-- Data for table `progeƩo`.`Categoria`
-- ----------------------------------------------------- 
START TRANSACTION; 
USE `progeƩo`;
INSERT INTO `progeƩo`.`Categoria` (`IDCategoria`, `Nome`, `UsernameC`) VALUES (1, 'vesƟƟ', 'test1');
INSERT INTO `progeƩo`.`Categoria` (`IDCategoria`, `Nome`, `UsernameC`) VALUES (2, 'auto', 'test1');
INSERT INTO `progeƩo`.`Categoria` (`IDCategoria`, `Nome`, `UsernameC`) VALUES (3, 'moto', 'test1');
COMMIT; 
-- ----------------------------------------------------- 
-- Data for table `progeƩo`.`Annuncio`
-- ----------------------------------------------------- 
START TRANSACTION; 
USE `progeƩo`;
INSERT INTO `progeƩo`.`Annuncio` (`IDAnnuncio`, `Ɵtolo`, `prezzo`, `oggeƩo`, `descrizione`, `stato`, 
`UsernameA`, `IDA`) VALUES (1, 'value', 24, 'vesƟƟ', 'belli', 'online', 'test2', 1);
COMMIT; 

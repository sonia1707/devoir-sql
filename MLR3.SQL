DROP DATABASE IF EXISTS MLR3;

CREATE DATABASE IF NOT EXISTS MLR3;
USE MLR3;
# -----------------------------------------------------------------------------
#       TABLE : INSCRIPTION
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS INSCRIPTION
 (
   ID_STAGIAIRE CHAR(32) NOT NULL  ,
   ID_SESSION CHAR(32) NOT NULL  ,
   ID_STAGIAIRE_INSCRIPTION CHAR(32) NOT NULL  ,
   DATE_INSCRIPTION DATE NULL  
   , PRIMARY KEY (ID_STAGIAIRE,ID_SESSION) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE INSCRIPTION
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_INSCRIPTION_STAGIAIRE
     ON INSCRIPTION (ID_STAGIAIRE_INSCRIPTION ASC);

# -----------------------------------------------------------------------------
#       TABLE : FORMATEUR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS FORMATEUR
 (
   ID_FORMATEUR CHAR(32) NOT NULL  ,
   ID_STAGIAIRE CHAR(32) NOT NULL  ,
   ID_SESSION CHAR(32) NOT NULL  ,
   ID_FORMATION CHAR(32) NOT NULL  ,
   ID_FORMATEUR_ORGANISÉ_PAR CHAR(32) NOT NULL  ,
   NOM CHAR(32) NULL  ,
   PRENOM CHAR(32) NULL  ,
   SPÉCIALITÉ CHAR(32) NULL  
   , PRIMARY KEY (ID_FORMATEUR) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE FORMATEUR
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_FORMATEUR_STAGIAIRE
     ON FORMATEUR (ID_STAGIAIRE ASC);

CREATE  INDEX I_FK_FORMATEUR_SESSION
     ON FORMATEUR (ID_SESSION ASC,ID_FORMATION ASC,ID_FORMATEUR_ORGANISÉ_PAR ASC);

# -----------------------------------------------------------------------------
#       TABLE : STAGIAIRE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS STAGIAIRE
 (
   ID_STAGIAIRE CHAR(32) NOT NULL  ,
   NOM CHAR(32) NULL  ,
   PRENOM CHAR(32) NULL  ,
   SPÉCIALITÉ CHAR(32) NULL  ,
   TÉLÉPHONE INTEGER NULL  ,
   EMAIL CHAR(32) NULL  ,
   DATE_NAISSANCE DATE NULL  
   , PRIMARY KEY (ID_STAGIAIRE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : SESSION
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS SESSION
 (
   ID_SESSION CHAR(32) NOT NULL  ,
   ID_STAGIAIRE CHAR(32) NOT NULL  ,
   DATE_DEBUT DATE NULL  ,
   DATE_FIN DATE NULL  ,
   LIEU CHAR(32) NULL  ,
   ID_FORMATION CHAR(32) NOT NULL  ,
   ID_FORMATEUR CHAR(32) NOT NULL  
   , PRIMARY KEY (ID_SESSION,ID_FORMATION,ID_FORMATEUR) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE SESSION
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_SESSION_STAGIAIRE
     ON SESSION (ID_STAGIAIRE ASC);

# -----------------------------------------------------------------------------
#       TABLE : FORMATION
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS FORMATION
 (
   ID_FORMATION CHAR(32) NOT NULL  ,
   ID_STAGIAIRE CHAR(32) NOT NULL  ,
   TITRE CHAR(32) NULL  ,
   DESCRIPTION CHAR(32) NULL  ,
   DURÉE_EN_HEURES_ DATETIME NULL  
   , PRIMARY KEY (ID_FORMATION) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE FORMATION
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_FORMATION_STAGIAIRE
     ON FORMATION (ID_STAGIAIRE ASC);


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE INSCRIPTION 
  ADD FOREIGN KEY FK_INSCRIPTION_STAGIAIRE (ID_STAGIAIRE_INSCRIPTION)
      REFERENCES STAGIAIRE (ID_STAGIAIRE) ;


ALTER TABLE FORMATEUR 
  ADD FOREIGN KEY FK_FORMATEUR_STAGIAIRE (ID_STAGIAIRE)
      REFERENCES STAGIAIRE (ID_STAGIAIRE) ;


ALTER TABLE FORMATEUR 
  ADD FOREIGN KEY FK_FORMATEUR_SESSION (ID_SESSION,ID_FORMATION,ID_FORMATEUR_ORGANISÉ_PAR)
      REFERENCES SESSION (ID_SESSION,ID_FORMATION,ID_FORMATEUR) ;


ALTER TABLE SESSION 
  ADD FOREIGN KEY FK_SESSION_STAGIAIRE (ID_STAGIAIRE)
      REFERENCES STAGIAIRE (ID_STAGIAIRE) ;


ALTER TABLE FORMATION 
  ADD FOREIGN KEY FK_FORMATION_STAGIAIRE (ID_STAGIAIRE)
      REFERENCES STAGIAIRE (ID_STAGIAIRE) ;


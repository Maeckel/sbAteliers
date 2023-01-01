<?php

	$civilite = $_POST[ "civilite" ] ;
	$nom = $_POST[ "nom" ] ;
	$prenom = $_POST[ "prenom" ] ;
	$naissance = $_POST[ "naissance" ] ;
	$email = $_POST[ "email" ] ;
	$mobile = $_POST[ "mobile" ] ;
	$adresse = $_POST[ "adresse" ] ;
	$cp = $_POST[ "cp" ] ;
	$ville = $_POST[ "ville" ] ;
	$mdp = $_POST[ "mdp" ] ;
	
	if(preg_match( "/[A-Z]/" , $nom ) ){
		if(preg_match( "/[a-z]/" , $prenom ) ){
			if(preg_match( "/@([a-z]*)\.(fr|com)$/" , $email ) ){
				if(preg_match( "/^[0-9]{10}$/" , $mobile ) ){
					if(preg_match( "/^[0-9]{5}$/" , $cp ) ){
	
						require "modeles/ModeleSBAteliers.php" ;
						ModeleSBAteliers::enregistrerClient( 
								$civilite ,
								$nom ,
								$prenom ,
								$naissance ,
								$email ,
								$mobile ,
								$adresse ,
								$cp ,
								$ville ,
								$mdp
							) ;
	
						header( "Location: /sbateliers" ) ;
						
					}
				}
			}
		}
	}
	else {
		require "vues/vue-enregistrement.php";
	}

?>

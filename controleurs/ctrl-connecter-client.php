<?php

	$email = $_POST[ "email" ] ;
	$md2 = md5($_POST[ "mdp" ]) ;
	$mdp = substr($md2,0,-2);
	
	require "modeles/ModeleSBAteliers.php" ;
	$client = ModeleSBAteliers::getClient( $email , $mdp ) ;
	
	if( $client !== FALSE ){
		session_start() ;
		
		$_SESSION[ "numero" ] = $client[ "numero" ] ;
		$_SESSION[ "nom" ] = $client[ "nom" ] ; 
		$_SESSION[ "prenom" ] = $client[ "prenom" ] ; 
		
		header( "Location: /sbateliers/clients/espace" );
	}
	else {
		$erreur = 'EMail ou mot de passe incorrect.' ;
		require "vues/vue-connexion.php" ;
	}

?>

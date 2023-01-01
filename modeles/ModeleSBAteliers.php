<?php

	class ModeleSBAteliers {

		private static $connexion = null ;
		
		private function __construct(){
			self::$connexion = new PDO( 'mysql:host=localhost;dbname=sbateliers', 'Sb2022', 'azerty' ) ;
		}

		private static function getConnexion(){
			if( self::$connexion == null ){
				new ModeleSBAteliers() ;
			}
			return self::$connexion ;
		}

		public static function getClient( $email , $mdp ){
			$bd = self::getConnexion() ;
			$sql = "select numero , nom , prenom from client where email = :email and mdp = :mdp" ;
			$st = $bd->prepare( $sql ) ;
			$st->execute( array( ':email' => $email , ':mdp' => $mdp ) ) ;
			$client = $st->fetch( PDO::FETCH_ASSOC ) ;
			$st->closeCursor() ;
			return $client ;
		}
		
		public static function getAteliersAvenir(){
			$bd = self::getConnexion() ;
			$sql = "select a.numero , theme , date_heure , duree , nom , prenom "
				 . "from atelier a "
				 . "inner join responsable r "
				 . "on a.responsable = r.numero "
				 . "where date_heure > now() " ;
			$st = $bd->prepare( $sql ) ;
			$st->execute() ;
			$ateliers = $st->fetchall( PDO::FETCH_ASSOC ) ;
			$st->closeCursor() ;
			return $ateliers ;
		}
		
		public static function getprofil( $numeroClient ){
			$bd = self::getConnexion() ;
			$sql = "select civilite,date_naissance,email,mobile,adresse,cp,ville from client where numero = :numero" ;
			$st = $bd->prepare( $sql ) ;
			$st->execute( array( ':numero' => $numeroClient ) ) ;
			$client = $st->fetch( PDO::FETCH_ASSOC ) ;
			$st->closeCursor() ;
			return $client ;
		}
		
		public static function getParticipations( $numeroClient ){
			$bd = self::getConnexion() ;
			$sql = "select atelier from participer where client = :client" ;
			$st = $bd->prepare( $sql ) ;
			$st->execute( array( ':client' => $numeroClient ) ) ;
			$ateliers = $st->fetchall( PDO::FETCH_ASSOC ) ;
			$st->closeCursor() ;
			return $ateliers ;
		}
		
		
		public static function enregistrerClient(
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
			) {
				
			$bd = self::getConnexion() ;	
			
			$sql = 'insert into client(civilite,nom,prenom,date_naissance,email,mobile,adresse,cp,ville,mdp) '
				 . 'values( :civilite , :nom , :prenom , :naissance  , :email , :mobile , :adresse , :cp , :ville , :mdp )' ;
			
			$st = $bd -> prepare( $sql ) ;
			
			$st -> execute( array(
					':civilite' => $civilite ,
					':nom' => $nom ,
					':prenom' => $prenom ,
					':naissance' => $naissance ,
					':email' => $email ,
					':mobile' => $mobile ,
					':adresse' => $adresse ,
					':cp' => $cp ,
					':ville' => $ville ,
					':mdp' => $mdp
				)
			) ;
			
			$st -> closeCursor() ;
			
		}
		
		
		public static function enregistrerParticipationAtelier( $numClient , $numAtelier ){
			$bd = self::getConnexion() ;
			$sql = 'insert into participer values( :client , :atelier , CURRENT_DATE() )' ;
			$st = $bd -> prepare( $sql ) ;
			$st -> execute( array( ':client' => $numClient , ':atelier' => $numAtelier ) ) ;
			$st -> closeCursor() ;
			
			$sql = 'update atelier set nb_participants = nb_participants + 1 where numero = :atelier' ;
			$st = $bd -> prepare( $sql ) ;
			$st -> execute( array( ':atelier' => $numAtelier ) ) ;
			$st -> closeCursor() ;
			
		}
		
		
		public static function annulerParticipationAtelier( $numClient , $numAtelier ){
			$bd = self::getConnexion() ;
			$sql = 'delete from participer where client = :client and atelier = :atelier' ;
			$st = $bd -> prepare( $sql ) ;
			$st -> execute( array( ':client' => $numClient , ':atelier' => $numAtelier ) ) ;
			$st -> closeCursor() ;
			
			$sql = 'update atelier set nb_participants = nb_participants - 1 where numero = :atelier' ;
			$st = $bd -> prepare( $sql ) ;
			$st -> execute( array( ':atelier' => $numAtelier ) ) ;
			$st -> closeCursor() ;
			
		}
		
		public static function getAteliersPasses( $numeroClient ){
			
			$bd = self::getConnexion() ;
			$sql = <<<FIN_REQ_ATELIERS_PASSES
				(select a.numero as numero , a.theme as theme , a.date_heure as date_heure , r.nom as nom, r.prenom as prenom , TRUE as participe
				from participer p
				inner join atelier a
				on p.atelier = a.numero
				inner join responsable r
				on a.responsable = r.numero
				where p.client = :client
				and date_heure < now()
				)

				union

				(select a.numero as numero , a.theme as theme , a.date_heure as date_heure , r.nom as nom, r.prenom as prenom , FALSE as participe
				from atelier a
				inner join responsable r
				on a.responsable = r.numero
				where a.numero not in (
					select distinct atelier
					from participer
					where client = :client
				)
				and nb_places - nb_participants > 0
				and date_heure < now()
				)
				order by date_heure
FIN_REQ_ATELIERS_PASSES;

			$st = $bd->prepare( $sql ) ;
			$st->execute( array( ':client' => $numeroClient ) ) ;
			$ateliers = $st->fetchall( PDO::FETCH_ASSOC ) ;
			$st->closeCursor() ;
			return $ateliers ;
			
		}

		public static function getAteliersProgrammes( $numeroClient ){

			$bd = self::getConnexion() ;
			$sql = <<<FIN_REQ_ATELIERS_EN_COURS
				(select a.numero as numero , a.theme as theme , a.date_heure as date_heure , r.nom as nom, r.prenom as prenom , TRUE as participe
				from participer p
				inner join atelier a
				on p.atelier = a.numero
				inner join responsable r
				on a.responsable = r.numero
				where p.client = :client
				and date_heure > now()
				)

				union

				(select a.numero as numero , a.theme as theme , a.date_heure as date_heure , r.nom as nom, r.prenom as prenom , FALSE as participe
				from atelier a
				inner join responsable r
				on a.responsable = r.numero
				where a.numero not in (
					select distinct atelier
					from participer
					where client = :client
				)
				and nb_places - nb_participants > 0
				and date_heure > now()
				)
				order by date_heure
FIN_REQ_ATELIERS_EN_COURS;


			$st = $bd->prepare( $sql ) ;
			$st->execute( array( ':client' => $numeroClient ) ) ;
			$ateliers = $st->fetchall( PDO::FETCH_ASSOC ) ;
			$st->closeCursor() ;
			return $ateliers ;

		}

		
	};
	

?>

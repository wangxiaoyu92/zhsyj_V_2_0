<?php

/* RECEIVE VALUE */
$validateValue=$_REQUEST['fieldValue'];
$validateId=$_REQUEST['fieldId'];

/* RETURN VALUE */
$arrayToJs = array();
$arrayToJs[0] = $validateId;

if($validateValue =="vwcb"){		// validate??
	$arrayToJs[1] = true;			// RETURN TRUE
	echo json_encode($arrayToJs);	// RETURN ARRAY WITH success
}else{
	$arrayToJs[1] = false;
	echo json_encode($arrayToJs);	// RETURN ARRAY WITH ERROR
}

?>
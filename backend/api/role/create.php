<?php
require '../database.php';

// Get the posted data.
$postdata = file_get_contents("php://input");

if (isset($postdata) && !empty($postdata)) {
  // Extract the data.
  $request = json_decode($postdata);


  // // Validate.
  // if (trim($request->uid) === '' ||  trim($request->email) ==='') {
  //   return http_response_code(400);
  // }

  // Sanitize.
  $uid = mysqli_real_escape_string($con, trim($request->uid));
  $mod_id = mysqli_real_escape_string($con, trim($request->mod_id));
  $email = mysqli_real_escape_string($con, trim($request->email));
  $role = mysqli_real_escape_string($con, trim($request->role));

  // Create.
  $sql = "REPLACE INTO `role`(`uid`, `mod_id`, `email`, `role`) VALUES ('{$uid}','{$mod_id}','{$email}','{$role}')";

  if (mysqli_query($con, $sql)) {
    http_response_code(201);
    $result = [
      'role' => $role,
      'email' => $email,
      'mod_id' => $mod_id,
      'uid' => $uid
    ];
    echo json_encode($result);
  } else {
    http_response_code(422);
  }
}
?>
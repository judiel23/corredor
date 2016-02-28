<?php
  $json = exec("/report_pdf.rb");
  $data = json_decode($json);
  $url = $data->url; # assuming there is an URL field
?>
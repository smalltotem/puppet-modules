class opdemand::common {
  
  # manage orchestration inputs
  class {"opdemand::inputs":} ->
    
  # process ssh data
  class {"opdemand::ssh::authorized_keys":} ->
  class {"opdemand::ssh::known_hosts":} ->
  class {"opdemand::ssh::private_keys":} ->
  
  # update the server deployment repository
  class {"opdemand::repo::server":}
  
}

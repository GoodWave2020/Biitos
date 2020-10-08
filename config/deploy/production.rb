server '52.68.53.165', user: 'ubuntu', roles: %w{app db web}
set :ssh_options, keys: 'home/vagrant/.ssh/id_rsa'

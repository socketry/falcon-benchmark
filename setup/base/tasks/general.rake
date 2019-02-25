
task :locale do
	sh "echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen"
	sh "echo 'LANG=en_US.UTF-8' > /etc/locale.conf"
	sh "locale-gen"
end

task :network do
	sh "systemctl enable systemd-networkd"
	sh "systemctl enable systemd-resolved"
end

task :postgres do
	sh "sudo rm -rf /var/lib/postgres/data"
	sh "sudo mkdir -p /var/lib/postgres/data"
	sh "sudo chown -R postgres:postgres /var/lib/postgres"
	
	sh "sudo -u postgres initdb --locale en_US.UTF-8 -E UTF8 -D '/var/lib/postgres/data'"
	sh "sudo systemctl enable postgresql"
	
	# sh "sudo -u postgres createuser -s www"
	# sh "sudo -u postgres createdb www_test"
end

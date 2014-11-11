require 'httparty'
require 'json'

response = HTTParty.get(
  ENV['API_ENDPOINT'],
  :basic_auth => {:username => ENV['API_USER'], :password => ENV['API_PASS']}
)

host_configs = JSON.parse(response.body)["rows"]

inventory = "[drupals]\n"

host_configs.each do |config|
  host = config["value"]
  inventory += sprintf(
    "%s ansible_ssh_port=%d ansible_ssh_user=%s ansible_ssh_pass=%s bin_dir=%s tmp_dir=%s drupal_root=%s\n",
    host["hostname"], host["ssh_port"], host["ssh_user"], host["ssh_password"], host["bin_dir"], host["tmp_dir"], host["drupal_root"]
  )
end

puts inventory

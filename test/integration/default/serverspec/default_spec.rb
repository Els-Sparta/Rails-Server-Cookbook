require 'serverspec'

#Required by serverspec

set :backend, :exec

describe command('git --version') do
  its(:stdout) { should match /2\.7\.4/ }
end

# must not be sudo as rbenv install ruby for the user
describe command("ruby --version") do
  its(:stdout) { should match /2\.4./}
end

describe service("nginx") do
  it { should be_running }
  it { should be_enabled }
end

describe port(80) do
  it { should be_listening }
end

# describe http('http://localhost/8080', enable_remote_worker: true) do
#   its('status') { should cmp 200 }
# end

describe package('nodejs') do
  it { should be_installed }
end

describe package('build-essential') do
  it { should be_installed }
end

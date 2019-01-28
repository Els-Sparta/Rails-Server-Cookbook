
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

describe http('http://localhost', enable_remote_worker: true) do
  its('status') { should cmp 502 }
end

describe package ('nodejs') do
  it { should be_installed }
  its('version') { should cmp > '8.11.2*' }
end

describe npm ("pm2") do
  it { should be_installed }
end
#
# describe package('build-essential') do
#   it { should be_installed }
# end

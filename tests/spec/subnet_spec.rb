describe subnet(ENV['TF_VAR_stack_name'] + '-database-subnet-' + ENV['TF_VAR_environment'] + '-ap-southeast-2b') do
  it { should exist }
  it { should be_available }
  it { should belong_to_vpc(ENV['TF_VAR_stack_name'] + '-' + ENV['TF_VAR_environment'] + '-vpc') }
end

describe subnet(ENV['TF_VAR_stack_name'] + '-database-subnet-' + ENV['TF_VAR_environment'] + '-ap-southeast-2a') do
  it { should exist }
  it { should be_available }
  it { should belong_to_vpc(ENV['TF_VAR_stack_name'] + '-' + ENV['TF_VAR_environment'] + '-vpc') }
end

describe subnet(ENV['TF_VAR_stack_name'] + '-database-subnet-' + ENV['TF_VAR_environment'] + '-ap-southeast-2c') do
  it { should exist }
  it { should be_available }
  it { should belong_to_vpc(ENV['TF_VAR_stack_name'] + '-' + ENV['TF_VAR_environment'] + '-vpc') }
end

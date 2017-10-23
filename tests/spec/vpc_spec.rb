describe vpc(ENV['TF_VAR_stack_name'] + '-' + ENV['TF_VAR_environment'] + '-vpc') do
  it { should exist }
  it { should be_available }
  its(:cidr_block) { should eq '10.0.0.0/16' }
  it { should have_route_table(ENV['TF_VAR_stack_name'] + '-database-subnet-' + ENV['TF_VAR_environment'] + '-ap-southeast-2a') }
  it { should have_route_table(ENV['TF_VAR_stack_name'] + '-database-subnet-' + ENV['TF_VAR_environment'] + '-ap-southeast-2b') }
  it { should have_route_table(ENV['TF_VAR_stack_name'] + '-database-subnet-' + ENV['TF_VAR_environment'] + '-ap-southeast-2c') }
end

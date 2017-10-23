describe rds(ENV['TF_VAR_stack_name'] + '-' + ENV['TF_VAR_environment'] +'-mydb-rds') do
  it { should exist }
  it { should be_available }
  its(:db_instance_identifier) { should eq ENV['TF_VAR_stack_name'] + '-' + ENV['TF_VAR_environment'] + '-mydb-rds' }
  its(:db_instance_class) { should eq 'db.t2.micro' }
  its(:multi_az) { should eq false }
  it { should belong_to_vpc(ENV['TF_VAR_stack_name'] + '-' + ENV['TF_VAR_environment'] +'-vpc') }
  it { should belong_to_db_subnet_group(ENV['TF_VAR_stack_name'] + '_' + ENV['TF_VAR_environment'] +'_rds_subnet_group') }
end

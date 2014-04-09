require 'spec_helper'
require 'roodi_task'

describe RoodiTask do

  it 'allows setting the config' do
    roodi_task = RoodiTask.new :config => "config/roodi.yml"
    expect(roodi_task.config).to eq "config/roodi.yml"
  end

end
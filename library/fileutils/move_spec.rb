require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/shared/move'

describe "FileUtils.move" do
  it_behaves_like :fileutils_move, :move
end
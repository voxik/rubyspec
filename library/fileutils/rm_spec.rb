require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/shared/remove'

describe "FileUtils.rm" do
  it_behaves_like :fileutils_remove, :rm
end
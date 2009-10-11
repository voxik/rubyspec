require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/shared/copy'

describe "FileUtils.cp" do
  it_behaves_like :fileutils_copy, :cp
end
describe :fileutils_remove, :shared => true do
  require 'fileutils'

  ruby_version_is "1.9.2" do
    require File.dirname(__FILE__) + '/../../../fixtures/m17n'

    before :all do
      @file_content = 'rubyspec'
      @test_dir = tmp("rubyspec_m17n_test")
    end

    before :each do
      Dir.mkdir @test_dir
    end

    after :each do
      platform_is :windows do
        system("rmdir /s /q #{@test_dir.gsub '/', '\\'}")
      end
      platform_is_not :windows do
        system("rm -rf #{@test_dir}")
      end
    end

    it "should support files with various encodings" do
      def test_remove_with_encodings(file)
        file_path = File.join @test_dir, file
  
        File.open(file_path, "w") {|f| f.write @file_content}
  
        Dir[File.join(@test_dir, '*')].size.should == 1
  
        FileUtils.send(@method, file_path)
  
        Dir[File.join(@test_dir, '*')].size.should == 0
      end

      test_remove_with_encodings M17n.string_cp1250
      test_remove_with_encodings M17n.string_utf_8
      test_remove_with_encodings M17n.string_us_ascii
    end
  end
end

describe :fileutils_move, :shared => true do
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
      File.open(File.join(@test_dir, 'test'), "w") {|f| f.write @file_content}

      def test_move_with_encodings(source, destination)
        source_path = File.join @test_dir, source
        destination_path = File.join @test_dir, destination
  
        FileUtils.send(@method, source_path, destination_path)
        File.open(destination_path, "r") {|f| f.read.should == @file_content}
  
        Dir[File.join(@test_dir, '*')].size.should == 1
      end

      test_move_with_encodings 'test', M17n.string_cp1250
      test_move_with_encodings M17n.string_cp1250, M17n.string_utf_8
      test_move_with_encodings M17n.string_utf_8, M17n.string_us_ascii
    end
  end
end

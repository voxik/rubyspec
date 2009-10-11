require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/fixtures/classes'

ruby_version_is "1.9" do
  describe "Kernel#respond_to_missing?" do
    before :each do 
      @a = KernelSpecs::A.new  
    end

    it "returns false by default" do
      Object.new.respond_to_missing?.should be_false
    end

    it "is not called when #respond_to? would return true" do
      obj = mock('object')
      obj.stub!(:glark)
      obj.should_not_receive(:respond_to_missing?)
      obj.respond_to?(:glark).should be_true
    end

    it "is called when #respond_to? would return false" do
      obj = mock('object')
      obj.should_receive(:respond_to_missing?).with(:undefined_method)
      obj.respond_to?(:undefined_method)
    end

    it "is called with true as the second argument when #respond_to? is" do
      obj = mock('object')
      obj.should_receive(:respond_to_missing?).with(:undefined_method, true)
      obj.respond_to?(:undefined_method, true)
    end

    it "causes #respond_to? to return true if called and not returning false" do
      obj = mock('object')
      obj.should_receive(:respond_to_missing?).with(:undefined_method).and_return(:glark)
      obj.respond_to?(:undefined_method).should be_true
    end

    it "causes #respond_to? to return false if called and returning false" do
      obj = mock('object')
      obj.should_receive(:respond_to_missing?).with(:undefined_method).and_return(false)
      obj.respond_to?(:undefined_method).should be_false
    end

    it "is not called with false as a second argument when #respond_to? is" do
      obj = mock('object')
      obj.should_receive(:respond_to_missing?).with(:undefined_method)
      obj.respond_to?(:undefined_method, false)
    end

    it "isn't called when obj responds to the given public method" do    
      @a.should_not_receive(:respond_to_missing?)
      @a.respond_to?(:pub_method).should be_true
    end
    
    it "isn't called when obj responds to the given public method, include_private = true" do    
      @a.should_not_receive(:respond_to_missing?)
      @a.respond_to?(:pub_method, true).should be_true
    end

    it "isn't called when obj responds to the given protected method" do
      @a.should_not_receive(:respond_to_missing?)
      @a.respond_to?(:protected_method, false).should be_true
    end
    
    it "isn't called when obj responds to the given protected method, include_private = true" do 
      @a.should_not_receive(:respond_to_missing?)
      @a.respond_to?(:protected_method, true).should be_true
    end
    
    it "is called when obj responds to the given private method, include_private = false" do    
      @a.should_receive(:respond_to_missing?).with(:private_method)
      @a.respond_to?(:private_method)
    end 

    it "isn't called when obj responds to the given private method, include_private = true" do
      @a.should_not_receive(:respond_to_missing?)
      @a.respond_to?(:private_method, true).should be_true
    end

    it "is called for missing class methods" do
      @a.class.should_receive(:respond_to_missing?).with(:oOoOoO)
      @a.class.respond_to?(:oOoOoO)
    end
  end
end
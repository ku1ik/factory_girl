require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'spec_helper'))

require 'factory_girl/syntax/sweatshop'

describe "a factory using sweatshop syntax" do
  before do
    Factory.define :user do |factory|
      factory.first_name 'Bill'
      factory.last_name  'Nye'
      factory.email      'science@guys.net'
    end
  end

  after do
    Factory.factories.clear
  end

  it "should not raise an error when generating an invalid instance" do
    lambda { User.gen(:first_name => nil) }.should_not raise_error
  end

  it "should raise an error when forcefully generating an invalid instance" do
    lambda { User.gen!(:first_name => nil) }.should raise_error(ActiveRecord::RecordInvalid)
  end

  %w(gen gen! make).each do |method|
    describe "after generating an instance using #{method}" do
      before do
        @instance = User.send(method, :last_name => 'Rye')
      end

      it "should use attributes from the factory" do
        @instance.first_name.should == 'Bill'
      end

      it "should use attributes passed to generate" do
        @instance.last_name.should == 'Rye'
      end

      if method == 'make'
        it "should not save the record" do
          @instance.should be_new_record
        end
      else
        it "should save the record" do
          @instance.should_not be_new_record
        end
      end
    end
  end
end

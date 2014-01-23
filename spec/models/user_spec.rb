require 'spec_helper'

describe User do
	before do
		@user = User.new(first: "Example", last: "Example", email: "user@andover.edu", password: "foobar", password_confirmation: "foobar")
  end

  	subject { @user }

  	it { should respond_to(:first) }
  	it { should respond_to(:last) }
  	it { should respond_to(:email) }  
  	it { should respond_to(:password_digest) }
    it { should respond_to(:password) } 
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:authenticate) }

  	it { should be_valid }

	describe "when name is not present" do
    	before { @user.first = " " }
    	it { should_not be_valid }
  	end

	describe "when name is too long" do
		before { @user.first = "a" * 51 }
		it { should_not be_valid }
  	end

  	describe "when name is not present" do
    	before { @user.last = " " }
    	it { should_not be_valid }
  	end

	describe "when name is too long" do
		before { @user.last = "a" * 51 }
		it { should_not be_valid }
  	end

  	describe "when email format is invalid" do
    	it "should be invalid" do
     	 addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com]
      	addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  	describe "when email format is valid" do
    	it "should be valid" do
      	addresses = %w[cwolford@andover.edu]
      	addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

	describe "return value of authenticate method" do
	  before { @user.save }
	  let(:found_user) { User.find_by(email: @user.email) }

	  describe "with valid password" do
	    it { should eq found_user.authenticate(@user.password) }
	  end

	  describe "with invalid password" do
	    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

	    it { should_not eq user_for_invalid_password }
	    specify { expect(user_for_invalid_password).to be_false }
	  end
	end

end
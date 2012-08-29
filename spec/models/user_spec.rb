require 'spec_helper'

describe User do
  before(:each) do
    @attr = {:name => "Example User", :email => "user@example.com", :password => "passwd", :password_confirmation => "passwd"}
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  describe "name validation" do

    it "should require a name" do
      no_name_user = User.new(@attr.merge(:name => ""))
      no_name_user.should_not be_valid
    end

    it "should reject names that are too long" do
      long_name = 'a' * 51;
      long_name_user = User.new(@attr.merge(:name => long_name))
      long_name_user.should_not be_valid
    end
  end

  describe "email validation" do

    it "should require a email" do
      no_email_user = User.new(@attr.merge(:email => ""))
      no_email_user.should_not be_valid
    end

    it "should accept valid email address" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp user@too.many.dots.in.email.domain]
      addresses.each do |address|
        valid_email_user = User.new(@attr.merge( :email => address))
        valid_email_user.should be_valid
      end
    end

    it "should reject invalid email address" do
      addresses = %w[user@foo,com user_at_foo.bar.org first.last@foo.]
      addresses.each do |address|
        invalid_email_user = User.new(@attr.merge( :email => address))
        invalid_email_user.should_not be_valid
      end
    end

    it "should reject duplicated email address" do
      User.create!(@attr)
      dup_user = User.new(@attr)
      dup_user.should_not be_valid
    end
    
    it "should reject email address identical up to case" do
      upcased_email=@attr[:email].upcase
      User.create!(@attr.merge(:email => upcased_email))
      user_with_duplicated_email = User.new(@attr)
      user_with_duplicated_email.should_not be_valid
    end
  end

  describe "password validations" do
    
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end
    
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end
    
    it "should reject short password" do
      passwd = "a" * 3
      User.new(@attr.merge(:password => passwd)).should_not be_valid
    end
    
    it "should reject long password" do
      passwd = "a" * 21
      User.new(@attr.merge(:password => passwd)).should_not be_valid
    end
    
    it "should create new instance given valid attributes" do
      User.create!(@attr)
    end
  end

  describe "password encryptions" do
  
    before(:each) do
      @user_pe = User.create!(@attr)
    end
    
    it "should have encrypted password attribute" do
      @user_pe.should respond_to(:encrypted_password)
    end

    it "should set the ecrypted password" do
      @user_pe.encrypted_password.should_not be_blank
    end
    
    describe "password matching" do
      it "should be true if the passwords match" do
        @user_pe.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords don't match'" do
        @user_pe.has_password?("invalid").should be_false
      end
    end
    
    describe "authenticate method" do
      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end
      
      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end
      
      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user_pe
      end
    end
  end # "password encryptions"
  
  describe "POST 'create" do
    before(:each) do
      @fail_attr = {:name =>"fail", :email => "abc@def.com", :password => "", :password_confirmation => ""}
    end
    it "should not create a user" do
      lamda do
        post :create, :user => @fail_attr
      end.should_not change(User, :count)
    end
  end
end
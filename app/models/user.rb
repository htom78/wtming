class User < ActiveRecord::Base
  acts_as_authentic do |config|
    config.validate_email_field = false
    config.validate_password_field = false
  end

  attr_accessible :avatar, :password, :password_confirmation

  has_attached_file :avatar, :styles => { :large => "73x73>", :medium => "48x48>", :thumb => "24x24>" },
                  :url  => "/assets/avatars/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/avatars/:id/:style/:basename.:extension"

  validates :password, :on => "create", :confirmation => true 
  validates :password, :on => "update", :confirmation => true, :if => :password_notempty?

  validates :password_confirmation, :presence => true, :on => "update", :if => :password_notempty?
  validates :password, :presence => true, :on => "update", :if => :password_confirmation_notempty? 

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  private
    def validate_email?
      self.access_token.nil?
    end

    def validate_password?
      self.access_token.nil? and (new_record? or password_changed?)
    end

    def password_notempty?
      logger.info('the updated password is ' + self.password.to_s)
      if self.password.to_s.length == 0 
        return false
      end 
      return true
    end  
    
    def password_confirmation_notempty?
      logger.info('the updated password confirmation is ' + self.password_confirmation.to_s)
      if self.password_confirmation.to_s.length == 0
        return false
      end 
      return true
    end
end

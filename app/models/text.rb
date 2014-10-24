class Text < ActiveRecord::Base
  
  before_create :default_text
  
  protected
  def default_text
    self.text = ' ';
  end
end

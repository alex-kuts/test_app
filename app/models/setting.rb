# encoding: utf-8
class Setting < ActiveRecord::Base
  
  self.inheritance_column = nil
  
  def self.get_value(key) 
    self.find_or_create_by(:key=>key).value
  end
  
  def update_if_hange(args)
    
  end
  
  def self.get_from(key_hash) 
    @settings = self.where(:key=>key_hash.keys).order(:position)
    
    @settings.each do |s|
      if key_hash.has_key?(s.key)
        s.update(key_hash[s.key])
        
        key_hash.delete(s.key)
      else
        s.destroy
      end
    end
    
    if key_hash.length > 0
      key_hash.each do |k, v|
        v.merge!({key:k})
        @settings << self.create(v)
      end
    end
    return @settings
  end
  
  def self.get_from_yml()
    config = {}
    config_file = File.join(Rails.root, 'config', 'admin_settings.yml')
    config = YAML.load_file(File.open(config_file)) if File.exists?(config_file)
    
    key_hash = {}
    config.each do |key, val|
      val['elems'].each {|k, v| 
        val['elems'][k].merge!({'section'=>key, 'section_title'=>val['title']})
      }
      key_hash.merge! val['elems']
    end
    
    
    
    get_from(key_hash) 
  end
end

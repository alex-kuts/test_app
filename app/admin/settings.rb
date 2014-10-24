# encoding: utf-8
ActiveAdmin.register_page "Settings" do
  menu :label => "Настройки"
  
  sidebar 'Разделы' do
    sections = Setting.select(:section_title, :section).uniq
    ul do
      sections.each do |s|
        li  link_to s.section_title, admin_settings_path(:section=>s.section)
      end
    end
  end
  
  content :title=>'Настройки' do
    
    
    
    @settings = Setting.get_from_yml
    render partial: 'active_admin/settings/settings', :locals=>{settings:@settings}
    
  end
  
  page_action :save, :method => :post do
    
    params[:values].each do |k, v|
      value = Setting.where(:key=>k).first
      value.value = v
      value.save
    end
    
    redirect_to admin_settings_path
  end
end
# encoding: utf-8
ActiveAdmin.register Text do
  menu :label => "Страницы и текстовые блоки"
  config.filters = false
  
  index :title=>'Страницы и текстовые блоки', :download_links => false do
    column 'Текст/страница', :title
    column 'Ключ', :key
    actions
  end
  
  form do |f|
    f.inputs "Текстовый блок или страница" do
      f.input :title, :label => "Название"
      f.input :text, :label => 'Полное описание', as: :ckeditor,
        :input_html => { :ckeditor => {:height => 400 , :toolbar => 'Admin'} }
    end
    f.inputs "Метаданные для SEO" do
      f.input :meta_title, :label=>"Заголовок"
      f.input :meta_desc, :label=>"Описание"
      f.input :meta_key, :label=>"Кeywords"
    end
    f.actions do
      f.action(:submit, :button_html => {:name=>'commit', :value=>'Сохранить и закрыть'})
      f.action(:submit, :button_html => {:name=>'save', :value=>'Сохранить'})
      f.cancel_link
    end
  end
  
  controller do
    def permitted_params
      params.permit text: [:title, :text, 
        :meta_title, :meta_desc, :meta_key]
    end
  end
end

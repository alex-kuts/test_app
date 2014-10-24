# encoding: utf-8
module ActiveAdmin
  
  class Resource
    module Base
      def initialize(namespace, resource_class, options = {})
        @namespace = namespace
        @resource_class_name = "::#{resource_class.name}"
        @options    = options
        @sort_order = options[:sort_order]
        @member_actions, @collection_actions = [], []
        @member_actions << ControllerAction.new(:deleteimg, {:method=>:post})
      end
    end
  end
  
  module Inputs
    class FilterSelectInput < ::Formtastic::Inputs::SelectInput
      def extra_input_html_options
        {
          :class => 'chosen'
        }
      end
    end
    class FileInput < ::Formtastic::Inputs::FileInput
      def hint_html
        if hint_code
          
          template.content_tag(
            :p, 
            hint_code, 
            :class => (options[:hint_class] || builder.default_hint_class)
          )
         
        end
      end
      
      def hint_code
        if object.send("#{method}?") && !object.new_record?
          path = "deleteimg_admin_#{object_name}_path"
          template.tag(
            :img,
            :src=>object.send("#{method}_url", :admin)
          )+
          template.link_to(
            'Удалить',
            {:action=>:deleteimg}, 
            :class=>'delete_img', 
            'data-field'=>method
          )
        end
      end
      
    end
  end
  
  class FormBuilder < ::Formtastic::FormBuilder
    
    
    def commit_action_with_cancel_link
      action(:submit, :button_html => {:name=>'commit', :value=>'Сохранить и закрыть'})
      action(:submit, :button_html => {:name=>'save', :value=>'Сохранить'})
      cancel_link
    end
  end
end

class Formtastic::Inputs::SelectInput
  def extra_input_html_options
    {
      :class => 'chosen',
      :multiple => multiple?
    }
  end
end


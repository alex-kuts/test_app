# encoding: utf-8
module ActiveAdmin
  module Views
    class IndexAsGallery < ActiveAdmin::Component
  
      def build(page_presenter, collection)
        @page_presenter = page_presenter
        @collection = collection
        @resource_name = active_admin_config.resource_name.to_s.underscore.parameterize('_')
        @options = active_admin_config.dsl.sortable_options
        
        instance_eval &page_presenter.block if page_presenter.block
        
        add_class "index"
        build_table
      end
      
      # Adds links to View, Edit and Delete
      def actions(options = {}, &block)
        options = { :defaults => true }.merge(options)
        @default_actions = options[:defaults]
        @other_actions = block
      end

      def number_of_columns
        @page_presenter[:columns] || default_number_of_columns
      end

      def self.index_name
        "gallery"
      end

      protected

      def build_table
        sort_url = if (( sort_url_block = @options[:sort_url] ))
                     sort_url_block.call(self)
                   else
                     url_for(:action => :sort)
                   end
        resource_selection_toggle_panel if active_admin_config.batch_actions.any?  
        
        mass_upl
        
                 
        div :class=>"index_as_gallery sortable", 'data-sortable-url'=>sort_url do
          @collection.each do |item|
            item_gal(item)
          end
          div( :class=>"clear")
        end
        
      end
      
      def item_gal item
        cover_field = @page_presenter[:cover_field] ? @page_presenter[:cover_field] : :cover
        cover = @page_presenter[:cover] ? true : false
        div :class=> "itemGal", :id=>"#{@resource_name}_#{item.id}" do
          text_node image_tag(item.image_url(:admin), :height => '116', :width => '116')
          div :class=>"infoHover" do
            text_node link_to('Изменить', url_for(:action => :edit, :id=>item.id), :style => 'color:#fff;')
            div( :class=>"clear")
            resource_selection_cell(item) if active_admin_config.batch_actions.any?
            label('Удалить')
            div( :class=>"clear")
            if cover
              text_node radio_button_tag( 'cover', item.id, item.send(cover_field) ? true : false)
              label('Обложка')
              div( :class=>"clear")
            end
          end
        end
      end


      def mass_upl
        file_field = @page_presenter[:file_field] ? @resource_name+"[#{@page_presenter[:file_field]}]" : 
          @resource_name+'[image]'
        action = @page_presenter[:upl_action] ? @page_presenter[:upl_action] : 'upl'
        upl_url = url_for(:action => :index)+'/'+action
        render :partial => 'mass_upl', :locals => {:upl_url => upl_url, :file_field => file_field}
      end
     
      
    end
  end
end
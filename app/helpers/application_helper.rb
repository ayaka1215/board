module ApplicationHelper
    def header_link_item(name, path)
        class_name = 'nav_item'
        # 今のパスと引数のパスが同一か
        class_name << ' avtive' if current_page?(path)

        content_tag :li, class: class_name do
            link_to name, path, class: 'nav-link'
        end 
    end
end

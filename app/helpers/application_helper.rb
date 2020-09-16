module ApplicationHelper
    
    def highlight_helper(sorting_technique)
        if(params[:sorting_technique]==sorting_technique)
            return 'hilite'
        end
        if(session[:sorting_technique]==sorting_technique)
            return 'hilite'
        end
    end
    
end
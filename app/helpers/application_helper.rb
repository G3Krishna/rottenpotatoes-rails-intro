module ApplicationHelper
    
    def highlight_column(column_to_be_sorted)
        if(params[:column_to_be_sorted]==column_to_be_sorted)
            return 'hilite'
        end
        if(session[:column_to_be_sorted]==column_to_be_sorted)
            return 'hilite'
        end
    end
    
end
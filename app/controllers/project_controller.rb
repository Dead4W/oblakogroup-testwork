class ProjectController < ActionController::API

  def index

	  begin
	     render :json => {:message => "ok"}
	  rescue Exception => e
	     puts e
	  end

  end

end

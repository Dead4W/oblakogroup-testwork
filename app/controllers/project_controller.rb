class ProjectController < ActionController::API

  def index

  	  projects = Project.all.select(["id", "title"])

  	  tree = []

  	  projects.each do |project|
  	  	project_todos = {
  	  		id: project.id,
  	  		title: project.title,
  	  		todos: project.todo.all.select(["id", "text", "isCompleted"]).sort_by(&:id)
  	  	}

  	  	tree << project_todos
  	  end

      render :json => tree
  end

  def do
  	todo_project_params = params.permit(:id, :project_id)
    state = ActiveModel::Type::Boolean.new.cast(params.permit(:state)['state'])

	  t = Todo.find_by(todo_project_params)

	  unless t
	  	return render :json => {:message => "bad todo or project"}
	  end 

    t.isCompleted = state
    t.project.id
    t.save!

	  return render :json => {:todo => t.to_hash}
  end

  def new

  	if todo_params.empty?
  		return render :json => {:message => "bad todo param"}
  	end

  	if not new_project_params.empty?
  	 	p = Project.find_by(new_project_params)
    end

		if p.blank?
  	  p = Project.create(new_project_params)

  	  p.save!
  	end

    t = Todo.create(todo_params)
    t.project = p
    t.save!
      
	  return render :json => {
	  	:project => p.to_hash,
	  	:todo => t.to_hash
	  }
  end

  private
    def todo_params
      params.require(:todo).permit(:text)
    end

    def new_project_params
      params.require(:project).permit(:title)
    end

end

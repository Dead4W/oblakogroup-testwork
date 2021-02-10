class ProjectController < ActionController::API

  def index

  	  projects = Project.all.select(["id", "title"])

  	  tree = []

  	  projects.each do |project|
  	  	project_todos = {
  	  		id: project.id,
  	  		title: project.title,
  	  		todos: project.todo.all.select(["id", "text", "isCompleted"])
  	  	}

  	  	tree << project_todos
  	  end

      render :json => tree
  end

  def do
  	  todo_id = params.permit(:todo_id)['todo_id'].to_i
  	  project_id = params.permit(:project_id)['project_id'].to_i

	  t = Todo.find(todo_id)

	  unless t
	  	return render :json => {:message => "bad todo id"}
	  end 

	  if t.project.id != project_id
	  	return render :json => {:message => "bad project id"}
	  end 

      t.isCompleted = !t.isCompleted
      t.project.id
      t.save!

	  return render :json => {:todo => t.to_hash}
  end

  def new

  	  if todo_params.empty?
  	  	return render :json => {:message => "bad todo param"}
  	  end

  	  if not project_params.empty?
  	  	p = Project.find(project_params)

		if p.empty?
			return render :json => {:message => "project not finded"}
		end

  	  elsif not new_project_params.empty?
  	  	p = Project.create(new_project_params)

  	  	p.save!

        t = Todo.create(todo_params)
        t.project = p
        t.save!
  	  else

	    return render :json => {:message => "bad project param"}
  	  end

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

    def project_params
      params.require(:project).permit(:id)
    end

end

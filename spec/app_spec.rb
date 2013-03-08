require_relative('spec_helper')

describe "Todolist web interface: " do
  describe "get /todos" do
    it "retreives all todo items" do
      Todo.should_receive(:all)
      get '/todos'
    end
    it "returns a list of todos" do
      Todo.create(name: "todo1", done: "false")
      Todo.create(name: "todo2", done: "false")
      Todo.create(name: "todo3", done: "false")
      Todo.create(name: "todo4", done: "false")
      get '/todos'
      last_response.body.should have_tag 'ul.todolist'
      last_response.body.should have_tag('li.todoitem', :count => 4)
    end
    it "displays a form to create a new todo" do
      get '/todos'
      last_response.body.should have_tag 'form', with: { action: '/todos', method: 'POST' }
    end
  end 

  describe "post /todos" do
    let(:params){ {'todo' => { 'name' => "tododdd" }} }
    it "creates a new task from name given in params" do
      Todo.should_receive(:create).with(params['todo'])
      post '/todos', params
    end

    it "redirects to /todos" do
      post '/todos', params
      last_response.should be_redirect
      follow_redirect!
      last_request.path.should == '/todos'
    end
  end

  describe "delete /todos/todo_name" do
    it "destroys the todo with id given in params" do
      todo = Todo.create(name: 'test')
      delete "/todos/#{todo.id.to_s}"
      Todo.exists?(todo).should be_false
    end
  end
end

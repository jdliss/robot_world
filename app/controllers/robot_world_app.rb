class RobotWorldApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get '/' do
    @average_age = robot_world.average_robot_age
    @num_hired_per_year = robot_world.num_hired_each_year
    @num_robots_in_department = robot_world.num_robots_in(:department).sort
    @num_robots_in_city = robot_world.num_robots_in(:city).sort
    @num_robots_in_state = robot_world.num_robots_in(:state).sort
    erb :dashboard
  end

  get '/robots' do
    @robots = robot_world.all
    erb :index
  end

  get '/robots/new' do
    erb :new
  end

  post "/robots" do
    robot_world.create(params[:robot])
    redirect "/robots"
  end

  get "/robots/:id" do |id|
    @robot = robot_world.find(id.to_i)
    erb :show
  end

  get '/robots/:id/edit' do |id|
   @robot = robot_world.find(id.to_i)
   erb :edit
  end

  put '/robots/:id' do |id|
    robot_world.update(id.to_i, params[:robot])
    redirect "/robots/#{id}"
  end

  delete '/robots/:id' do |id|
    robot_world.destroy(id.to_i)
    redirect '/robots'
  end

  def robot_world
    if ENV['RACK_ENV'] == 'test'
      world = Sequel.sqlite("db/robot_world_test.sqlite")
    else
      world = Sequel.sqlite("db/robot_world.sqlite")
    end
    @robot_world ||= RobotWorld.new(world)
  end
end

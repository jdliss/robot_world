class RobotWorldApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get '/' do
    @total_robots = robot_world.total_robots
    @average_age = robot_world.average_robot_age
    num_hired_per_year = robot_world.num_hired_each_year
    num_robots_in_department = robot_world.num_robots_in(:department).sort
    num_robots_in_city = robot_world.num_robots_in(:city).sort
    num_robots_in_state = robot_world.num_robots_in(:state).sort

    @all_info = [ [num_hired_per_year, "Robots Hired per Year"],
                  [num_robots_in_department, "Robots by Department"],
                  [num_robots_in_city, "Robots by City"],
                  [num_robots_in_state, "Robots by State"]
                ]
    erb :dashboard
  end

  get '/robots' do
    robots = robot_world.all
    size = robots.size
    robots1 = robots.take(size/3)
    robots2 = robots.drop(size/3).take(size/3)
    robots3 = robots.drop(size/3).drop(size/3)
    @robots = [robots1, robots2, robots3]
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

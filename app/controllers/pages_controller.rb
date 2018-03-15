class PagesController < ApplicationController
  def index
    # code
  end

  # for web crawler only
  def robot
    render 'pages/robot.txt'
  end
end

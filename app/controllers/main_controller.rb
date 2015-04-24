class MainController < ApplicationController

  def index
  end

  def search
    @word = params[:word]
    @filename = params[:file].path
    @email = params[:email]

    Resque.enqueue(ResqueTestJob, @filename, @word, @email)

    redirect_to '/main', :notice => "New file has been generated and sended to '#{@email}'"
  end

end

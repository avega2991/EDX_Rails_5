require_relative '../jobs/resque_test_job'

class MainController < ApplicationController

  def index
    @word = String.new
  end

  def search
    @word = params[:word]
    @filename = params[:file]
    @email = params[:email]

    Resque.enqueue(ResqueTestJob, @filename, @word, @email)

    redirect_to '/main', :notice => "New file has been generated and sended to '#{@email}'"
  end

end

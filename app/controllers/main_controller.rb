require_relative '../jobs/resque_test_job'

class MainController < ApplicationController

  def index
    @word = String.new
  end

  def search
    @word = params[:word]
    @filename = 'old_file.txt'
    @email = params[:email]

    Resque.enqueue(ResqueTestJob, @word, @filename, @email)

    redirect_to '/main', :notice => "File '" << @word << ".txt' has been generated"
  end

end

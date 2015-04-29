class MainController < ApplicationController

  def index
  end

  def search
    @word = params[:word]
    @filename = params[:file].path
    @email = params[:email]

    @job_id = ResqueTestJob.create(:filename => @filename, :word => @word, :email => @email)

    params_hash = { :job_id => "#{@job_id}", :notice => "Job ##{@job_id} has been enqueued" }

    redirect_to "/main/index?#{params_hash.to_param}"
  end

  def status
    @job_id = params[:job_id]
    @job_hash = Resque::Plugins::Status::Hash.get(@job_id)
  end

end

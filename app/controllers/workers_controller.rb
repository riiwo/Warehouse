class WorkersController < ApplicationController
  before_action :set_worker, only: [:show, :edit, :update, :destroy]

  # GET /workers
  def index
    @workers = Worker.all
  end

  # GET /workers/1
  def show
    redirect_to '/workers'
  end

  # GET /workers/new
  def new
    @worker = Worker.new
  end

  # GET /workers/1/edit
  def edit
    redirect_to '/workers'
  end

  # POST /workers
  def create
    @worker = Worker.new(worker_params)

    respond_to do |format|
      if @worker.save
        format.html { redirect_to @worker, notice: 'Worker was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /workers/1
  def update
    respond_to do |format|
      if @worker.update(worker_params)
        format.html { redirect_to @worker, notice: 'Worker was successfully updated.' }
      else
        format.html { render :edit, alert: 'Try again.'  }
      end
    end
  end

  # DELETE /workers/1
  def destroy
    if @worker[:admin] == 0
      @worker.destroy
      respond_to do |format|
        format.html { redirect_to workers_url, notice: 'Worker was successfully destroyed.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to workers_url, alert: 'Can\'t delete admin user.' }
      end
    end
  end

  def add_group

  end

  def remove_group

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_worker
      @worker = Worker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def worker_params
      params.fetch(:worker, {}).permit(:username, :email, :password ,:password_confirmation, :salt)
    end
end

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :following, :followers]
  before_action :authenticate, except: [:show, :new, :create]
  before_action :correct_user, only: [:edit, :update]

  # GET /users
  # GET /users.json
  def index
	@users = User.all
	#@users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
	@title = "Sign Up"
	@user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
	@user = User.new(user_params)

	# respond_to do |format|
	  if @user.save
		# format.html {
		flash[:success] = "User was successfully created."
		  redirect_to @user
		  
		# format.json { render :show, status: :created, location: @user }
	  else
		# format.html {
		   render :new
		# format.json { render json: @user.errors, status: :unprocessable_entity }
	  end
	# end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
   # respond_to do |format|
	  if @user.update(user_params)
		#format.html {
		redirect_to @user
		flash[:succes] = "User was successfully updated."
		#format.json { render :show, status: :ok, location: @user }
	  else
		#format.html {
		render :edit
	  #  format.json { render json: @user.errors, status: :unprocessable_entity }
	  end
	#end
  end

  # DELETE /users/1
  # DELETE /users/1.json
 
  def destroy
	@user.destroy
#	respond_to do |format|
	  #format.html { 
		  flash[:success] = "User was successfully destroyed."
		redirect_to root_url
		
	  #format.json { head :no_content }
	#end
  end

	def following
    @title = "Following"
    @users = @user.following.all
    render 'show_follow'
	end

	def followers
		@title = "Followers"
		@users = @user.followers.all
	end

  private
	# Use callbacks to share common setup or constraints between actions.
	def set_user
	  @user = User.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def user_params
	  params.require(:user).permit(:handle, :name, :password, :email)
	end

	def correct_user
	  @user = User.find(params[:id])
	  redirect_to root_path unless current_user?(@user)
	end

end

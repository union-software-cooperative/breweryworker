class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :forbid, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @people = Person.filter(params.slice(:name_like))
    @people = @people.where(["union_id = ?", current_person.union_id]) if request.format.json? && !owner?
    @people = @people.order([:last_name, :first_name, :id])

    respond_to do |format|
      format.html
      format.json 
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/1/edit
  def edit
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    @person.authorizer = current_person

    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Profile successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:first_name, :last_name, :title, :address, :mobile, :fax, :email, :attachment, :union_id, :gender)
    end

    def forbid
      return forbidden if params[:action] == "destroy" && !owner?
      return forbidden unless can_edit_union?(@person.union)
    end
end

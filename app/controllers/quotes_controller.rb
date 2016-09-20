class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]
  before_action :set_quote_list, only: [:delete_relation, :add_relation]
  before_action :set_pagination, only: :index
  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.all.offset(@pag.to_i).limit(5)
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
    @lists = current_user.lists
  end

  # GET /quotes/1/edit
  def edit
    @lists = current_user.lists
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(quote_params)
    @quote.user_id = current_user[:id]
    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: 'Quote was successfully created.' }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        @quote.lists<<List.find(params[:list_ids])
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # DELETE /quotes/:quote_id/lists/:list_id
  def delete_relation
    @quote.lists.delete(@list)
  end

  # POST /quotes/:quote_id/lists/:list_id
  def add_relation
    if @list == -1
      @quote.lists.delete(@quote.lists)
    else
      @quote.lists<<(@list)
    end
  end

  private

    def set_pagination
      @pag = 0 if params[:pag].blank?
      @pag ||= params[:pag].to_i*5
    end

    def set_quote_list
      @quote = Quote.find(params[:id])
      @list = -1 if params[:quote][:list_ids].blank?
      @list ||= List.find(params[:quote][:list_ids])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.require(:quote).permit(:title, :content)
    end
end

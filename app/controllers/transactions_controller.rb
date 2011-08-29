class TransactionsController < ApplicationController
  respond_to :html, :json  

  def index
    @journal = Journal.find(params[:journal]) if params[:journal]
    @transactions = Transaction.rev_chrono
    @transactions = @transactions.for_journal(params[:journal]) if params[:journal]
    
    if params[:filter] == 'tagged' && params[:tags]
      @transactions = @transactions.with_tag(params[:tags])
    end
    
    @transactions = @transactions.page params[:page] unless params[:filter] == 'latest'
    respond_with(@transactions)
  end
  
  # GET /transactions/1/edit
  def edit
    @transaction = Transaction.find(params[:id])
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(params[:transaction])

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to home_url, notice: 'Transaction was posted to the journal.' }
        format.json { render json: @transaction, status: :created, location: @transaction }
      else
        format.html { redirect_to session[:return_to], :flash => {errors: 'Error parsing transaction!'} }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transactions/1
  # PUT /transactions/1.json
  def update
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to home_url, notice: 'Transaction was updated.' }
        format.json { render json: @transaction, status: :updated, location: @transaction }
      else
        format.html { redirect_to session[:return_to], :flash => {errors: 'Error parsing transaction!'} }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to session[:return_to], alert: 'Transaction was deleted.' }
      format.json { render json: true }
    end
  end
end

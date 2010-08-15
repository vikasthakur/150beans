class TransactionsController < ApplicationController
  # GET /transactions
  # GET /transactions.xml
  def index
    if params[:filter]
      if params[:filter] == 'all'
        @from_date = Date.civil+1
        @to_date = Date.today
      elsif params[:filter] == 'ytd'
        @from_date = Date.today.beginning_of_year
        @to_date = Date.today
      elsif params[:filter] == 'mtd'
        @from_date = Date.today.beginning_of_month
        @to_date = Date.today
      elsif params[:filter] == 'custom'
        @from_date = Date.parse(params[:from_date])
        @to_date = Date.parse(params[:to_date])
      end
    else # default uses mtd
      @from_date = Date.today.beginning_of_month
      @to_date = Date.today
    end

    @entries = Transaction.between(@from_date, @to_date)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transactions }
    end
  end

  # GET /transactions/1
  # GET /transactions/1.xml
  def show
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transaction }
    end
  end

  # GET /transactions/new
  # GET /transactions/new.xml
  def new
    @transaction = Transaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transaction }
    end
  end

  # GET /transactions/1/edit
  def edit
    @transaction = Transaction.find(params[:id])
  end

  # POST /transactions
  # POST /transactions.xml
  def create
    @transaction = Transaction.new(params[:transaction])

    respond_to do |format|
      if @transaction.save
        tx = @transaction
        @transaction.create_debit(:date => tx.date, :amount => tx.amount, :account_id => tx.debit_account_id)
        @transaction.create_credit(:date => tx.date, :amount => tx.amount, :account_id => tx.credit_account_id)

        format.html { redirect_to(transactions_url, :notice => 'Transaction was successfully created.') }
        format.xml  { render :xml => @transaction, :status => :created, :location => @transaction }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /transactions/1
  # PUT /transactions/1.xml
  def update
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to(transactions_url, :notice => 'Transaction was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.xml
  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml  { head :ok }
    end
  end
end

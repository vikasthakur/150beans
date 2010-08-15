class AccountsController < ApplicationController
  # GET /accounts
  # GET /accounts.xml
  def index
    @accounts = Account.all(:order => "type")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.xml
  def show
    @account = Account.find(params[:id])
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

    @entries = @account.entries.between(@from_date, @to_date)
    @opening_balance = @account.balance_to_date(@from_date - 1)
    @closing_balance = @account.balance_to_date(@to_date)
    @period_activity = @account.balance_in_period(@from_date, @to_date)
    @debits_total = @account.debits.between(@from_date, @to_date).sum("amount")
    @credits_total = @account.debits.between(@from_date, @to_date).sum("amount")
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.xml
  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.xml
  def create
    @account = params[:account][:type].constantize.new(params[:account])

    respond_to do |format|
      if @account.save
        format.html { redirect_to(@account, :notice => 'Account was successfully created.') }
        format.xml  { render :xml => @account, :status => :created, :location => @account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.xml
  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to(@account, :notice => 'Account was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.xml
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to(accounts_url) }
      format.xml  { head :ok }
    end
  end
end

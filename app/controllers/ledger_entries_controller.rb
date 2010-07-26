class LedgerEntriesController < ApplicationController
  # GET /ledger_entries
  # GET /ledger_entries.xml
  def index
    @ledger_entries = LedgerEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ledger_entries }
    end
  end

  # GET /ledger_entries/1
  # GET /ledger_entries/1.xml
  def show
    @ledger_entry = LedgerEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ledger_entry }
    end
  end

  # GET /ledger_entries/new
  # GET /ledger_entries/new.xml
  def new
    @ledger_entry = LedgerEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ledger_entry }
    end
  end

  # GET /ledger_entries/1/edit
  def edit
    @ledger_entry = LedgerEntry.find(params[:id])
  end

  # POST /ledger_entries
  # POST /ledger_entries.xml
  def create
    @ledger_entry = LedgerEntry.new(params[:ledger_entry])

    respond_to do |format|
      if @ledger_entry.save
        format.html { redirect_to(@ledger_entry, :notice => 'Ledger entry was successfully created.') }
        format.xml  { render :xml => @ledger_entry, :status => :created, :location => @ledger_entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ledger_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ledger_entries/1
  # PUT /ledger_entries/1.xml
  def update
    @ledger_entry = LedgerEntry.find(params[:id])

    respond_to do |format|
      if @ledger_entry.update_attributes(params[:ledger_entry])
        format.html { redirect_to(@ledger_entry, :notice => 'Ledger entry was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ledger_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ledger_entries/1
  # DELETE /ledger_entries/1.xml
  def destroy
    @ledger_entry = LedgerEntry.find(params[:id])
    @ledger_entry.destroy

    respond_to do |format|
      format.html { redirect_to(ledger_entries_url) }
      format.xml  { head :ok }
    end
  end
end

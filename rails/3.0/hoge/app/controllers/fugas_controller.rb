class FugasController < ApplicationController
  # GET /fugas
  # GET /fugas.xml
  def index
    @fugas = Fuga.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fugas }
    end
  end

  # GET /fugas/1
  # GET /fugas/1.xml
  def show
    @fuga = Fuga.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fuga }
    end
  end

  # GET /fugas/new
  # GET /fugas/new.xml
  def new
    @fuga = Fuga.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fuga }
    end
  end

  # GET /fugas/1/edit
  def edit
    @fuga = Fuga.find(params[:id])
  end

  # POST /fugas
  # POST /fugas.xml
  def create
    @fuga = Fuga.new(params[:fuga])

    respond_to do |format|
      if @fuga.save
        format.html { redirect_to(@fuga, :notice => 'Fuga was successfully created.') }
        format.xml  { render :xml => @fuga, :status => :created, :location => @fuga }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fuga.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fugas/1
  # PUT /fugas/1.xml
  def update
    @fuga = Fuga.find(params[:id])

    respond_to do |format|
      if @fuga.update_attributes(params[:fuga])
        format.html { redirect_to(@fuga, :notice => 'Fuga was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fuga.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fugas/1
  # DELETE /fugas/1.xml
  def destroy
    @fuga = Fuga.find(params[:id])
    @fuga.destroy

    respond_to do |format|
      format.html { redirect_to(fugas_url) }
      format.xml  { head :ok }
    end
  end
end

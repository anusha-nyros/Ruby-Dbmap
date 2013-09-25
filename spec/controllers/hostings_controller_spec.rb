require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe HostingsController do

  # This should return the minimal set of attributes required to create a valid
  # Hosting. As you add validations to Hosting, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # HostingsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all hostings as @hostings" do
      hosting = Hosting.create! valid_attributes
      get :index, {}, valid_session
      assigns(:hostings).should eq([hosting])
    end
  end

  describe "GET show" do
    it "assigns the requested hosting as @hosting" do
      hosting = Hosting.create! valid_attributes
      get :show, {:id => hosting.to_param}, valid_session
      assigns(:hosting).should eq(hosting)
    end
  end

  describe "GET new" do
    it "assigns a new hosting as @hosting" do
      get :new, {}, valid_session
      assigns(:hosting).should be_a_new(Hosting)
    end
  end

  describe "GET edit" do
    it "assigns the requested hosting as @hosting" do
      hosting = Hosting.create! valid_attributes
      get :edit, {:id => hosting.to_param}, valid_session
      assigns(:hosting).should eq(hosting)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Hosting" do
        expect {
          post :create, {:hosting => valid_attributes}, valid_session
        }.to change(Hosting, :count).by(1)
      end

      it "assigns a newly created hosting as @hosting" do
        post :create, {:hosting => valid_attributes}, valid_session
        assigns(:hosting).should be_a(Hosting)
        assigns(:hosting).should be_persisted
      end

      it "redirects to the created hosting" do
        post :create, {:hosting => valid_attributes}, valid_session
        response.should redirect_to(Hosting.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved hosting as @hosting" do
        # Trigger the behavior that occurs when invalid params are submitted
        Hosting.any_instance.stub(:save).and_return(false)
        post :create, {:hosting => {}}, valid_session
        assigns(:hosting).should be_a_new(Hosting)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Hosting.any_instance.stub(:save).and_return(false)
        post :create, {:hosting => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested hosting" do
        hosting = Hosting.create! valid_attributes
        # Assuming there are no other hostings in the database, this
        # specifies that the Hosting created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Hosting.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => hosting.to_param, :hosting => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested hosting as @hosting" do
        hosting = Hosting.create! valid_attributes
        put :update, {:id => hosting.to_param, :hosting => valid_attributes}, valid_session
        assigns(:hosting).should eq(hosting)
      end

      it "redirects to the hosting" do
        hosting = Hosting.create! valid_attributes
        put :update, {:id => hosting.to_param, :hosting => valid_attributes}, valid_session
        response.should redirect_to(hosting)
      end
    end

    describe "with invalid params" do
      it "assigns the hosting as @hosting" do
        hosting = Hosting.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Hosting.any_instance.stub(:save).and_return(false)
        put :update, {:id => hosting.to_param, :hosting => {}}, valid_session
        assigns(:hosting).should eq(hosting)
      end

      it "re-renders the 'edit' template" do
        hosting = Hosting.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Hosting.any_instance.stub(:save).and_return(false)
        put :update, {:id => hosting.to_param, :hosting => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested hosting" do
      hosting = Hosting.create! valid_attributes
      expect {
        delete :destroy, {:id => hosting.to_param}, valid_session
      }.to change(Hosting, :count).by(-1)
    end

    it "redirects to the hostings list" do
      hosting = Hosting.create! valid_attributes
      delete :destroy, {:id => hosting.to_param}, valid_session
      response.should redirect_to(hostings_url)
    end
  end

end
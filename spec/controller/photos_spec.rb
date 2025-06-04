require 'rails_helper'
require 'cgi'

include ActionDispatch::TestProcess::FixtureFile

RSpec.describe PhotosController, type: :request do
  include FactoryBot::Syntax::Methods
  let!(:photo) { create(:photo) }

  describe "GET /index" do
    it "returns a successful response" do
      get photos_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(photo.title)
    end
  end

  describe "GET /show" do
    it "shows the selected photo" do
      get photo_path(photo)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(photo.title)
    end
  end

  describe "GET /new" do
    it "renders the new photo form" do
      get new_photo_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /edit" do
    it "renders the edit photo form" do
      get edit_photo_path(photo)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "with valid params" do
      let(:valid_params) do
        {
          photo: {
            title: "New Title",
            description: "Test desc",
            tags: "tag1,tag2",
            image: fixture_file_upload("test_image.jpg", "image/jpeg")
          }
        }
      end

      it "creates a new photo and redirects" do
        expect {
          post photos_path, params: valid_params
        }.to change(Photo, :count).by(1)

        expect(response).to redirect_to(Photo.last)
        follow_redirect!
        expect(response.body).to include("Photo was successfully created.")
      end
    end

    context "with invalid params" do
      it "renders the new template with errors" do
        post photos_path, params: { photo: { title: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(CGI.unescapeHTML(response.body)).to include("Title can't be blank")
      end
    end
  end

  describe "PATCH /update" do
    it "updates the photo and redirects" do
      patch photo_path(photo), params: {
        photo: { title: "Updated Title" }
      }
      expect(response).to redirect_to(photo)
      follow_redirect!
      expect(response.body).to include("Updated Title")
    end
  end

  describe "DELETE /destroy" do
    it "destroys the photo and redirects to index" do
      expect {
        delete photo_path(photo)
      }.to change(Photo, :count).by(-1)

      expect(response).to redirect_to(photos_path)
      follow_redirect!
      expect(response.body).to include("Photo was successfully destroyed.")
    end
  end
end

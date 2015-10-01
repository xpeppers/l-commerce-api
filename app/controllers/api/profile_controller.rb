module Api
  class ProfileController < AuthenticatedUserController
    def show
      user_id = @authenticated_user.provider_user_id
      fullname = FacebookIdentity.full_name_from(user_id)
      picture_url = FacebookIdentity.profile_picture_url_from(user_id)
      render json: {
        full_name: fullname,
        picture_url: picture_url
      }
    end
  end
end

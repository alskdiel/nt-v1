class UserInfoController < ApplicationController
  def change_info
    if user_signed_in?
      @user_info = current_user.user_info

      @this_year = Time.now.year
      @min_year = 1900
      @occupations = ["대학생", "대학원생", "직장인", "무직", "기타"]
    else
      redirect_to root_path
    end
  end

  def update_info
    if user_signed_in?
      nickname = params[:user_info][:nickname]
      birth = params[:user_info][:birth]
      occupation = params[:user_info][:occupation]
      sex = params[:user_info][:sex]

      if nickname.present?
        current_user.user_info.update(nickname: nickname, birth: birth, occupation: occupation, sex: sex)
      else
        current_user.user_info.update(birth: birth, occupation: occupation, sex: sex)
      end


      redirect_to action: 'change_info'
    else
      redirect_to root_path
    end
  end

  def update_password
    if user_signed_in?
      password = params[:user_info][:password]
      password_confirm = params[:user_info][:password_confirm]

      if password == password_confirm
        current_user.update(password: password_confirm)
      end
    end

    redirect_to root_path
  end

  def check_current_password
    if user_signed_in?
      ret = current_user.valid_password?(params[:password])
      render json: { ret: ret }
    else
      redirect_to root_path
    end
  end
end

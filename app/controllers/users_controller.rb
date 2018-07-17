class UsersController < ApplicationController
    def my_portfolio
        @user = current_user
        @user_stocks = @user.stocks
    end

    def my_friends
        @friendships = current_user.friends
    end

    def add_friend 
        @friend = User.find(params[:friend])
        current_user.friendships.build(friend_id: @friend.id)

        if current_user.save
            flash.now[:success] = "Friend added successfully"
        else
            flash.now[:danger] = "Unable to add friend"
        end
        redirect_to my_friends_path
    end

    def show
        @user = User.find(params[:id])
        @user_stocks = @user.stocks
    end
    
    def search 
        if params[:friend].blank?
            flash.now[:danger] = "You have entered empty String"
        else
            @users =  User.any_user?(params[:friend])
            @users = current_user.except_current_user(@users)
            flash.now[:danger] = 'No user matches this criteria' unless @users
        end
        respond_to do |format|
            format.js {render partial: 'friends/result'}
        end
    end
end
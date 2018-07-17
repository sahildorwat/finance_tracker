class FriendshipsController < ApplicationController 

    def create 

    end

    def destroy
        puts params.inspect
        Friendship.where(user_id: current_user.id, friend_id: params[:id]).first.delete
        flash[:notice] = "friend successfully removed from list"
        redirect_to my_friends_path
    end
end
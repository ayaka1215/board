class BoardsController < ApplicationController
    before_action :set_target_board, only: %i[show edit update destroy]

    def index
        @boards = Board.all
    end

    def new
        @board = Board.new
        @board.attributes = flash[:board] if flash[:board]
    end

    def create
        board = Board.create(board_params)
        if board.save
            flash[:notice] = "「#{board.title}」の掲示板を作成しました"
            redirect_to board
        else
            redirect_to new_board_path, flash: {
              board: board,
              error_messages: board.errors.full_messages
            }
        end
    end

    def show
        @comment = Comment.new(board_id: @board.id)
    end

    def edit
        @board.attributes = flash[:board] if flash[:board]
    end

    def update
        if @board.update(board_params)
            flash[:notice] = "#{@board.title}の掲示板を編集しました"
            redirect_to @board
        else
            redirect_to edit_board_path, flash: {
                board: @board,
                error_messages: @board.errors.full_messages
            }
        end
    end

    def destroy
        @board.delete
        redirect_to boards_path, flash: { notice: "「#{@board.title}」の掲示板を削除しました"}
    end

    private

    def board_params
        params.require(:board).permit(:name, :title, :body)
    end

    def set_target_board
        @board = Board.find(params[:id])
    end
end

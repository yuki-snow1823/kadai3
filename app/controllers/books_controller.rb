class BooksController < ApplicationController
  before_action :authenticate_user! 
  # ログインユーザーのみに許可という動作
  before_action :correct_user, only: [:edit, :update]
  # 正しいユーザーのみ、編集とupdateができるということ
  # correct_userは下に定義


  def new
  end
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 意味：user_idがnilのままだと、子モデルのbookの方が保存できない
    if @book.save
     flash[:success] = "Book was successfully created."
     redirect_to book_path(@book.id)
   else
    @books = Book.all
    @user = current_user
    render action: :index
    # indexのアクションを無視してインデックスに行く（再定義した理由）／renderの上に書くこと/newもコピペするとミスデータが上書きされる
    end

  end

  def index
    @user = current_user
    # この考えめっちゃ大事(今ログインしているユーザー)
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id]) 
    @books = Book.all
    @user = @book.user
    @booknew = Book.new


    @post_comment = PostComment.new
  end

  def edit
    @book = Book.find(params[:id]) 
    render layout: false 
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      flash[:success] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render action: :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    if current_user != @user
      redirect_to books_path
    end
  end

end

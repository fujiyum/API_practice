class BooksController < ApplicationController

  def new
     @book = Book.new

    if params[:keyword].present?
      require 'net/http'
      url = 'https://www.googleapis.com/books/v1/volumes?q='
      request = url + params[:keyword]
      enc_str = URI.encode(request)
      uri = URI.parse(enc_str)
      json = Net::HTTP.get(uri)
      @bookjson = JSON.parse(json)

      count = 5
      @books = Array.new(count).map{Array.new(4)}
      count.times do |x|
        @books[x][0] = @bookjson.dig("items", x, "volumeInfo", "title")
        @books[x][1] = @bookjson.dig("items", x, "volumeInfo", "imageLinks", "thumbnail")
        @books[x][2] = @bookjson.dig("items", x, "volumeInfo", "authors")
        @books[x][2] = @books[x][2].join(',') if @books[x][2] #複数著者をカンマで区切る
        @books[x][3] = @bookjson.dig("items", x, "volumeInfo", "industryIdentifiers", 0, "identifier")
      end
    end

    @title = params[:title] if params[:title].present?
    @code = params[:code] if params[:code].present?
    @author = params[:author] if params[:author].present?
    @image = params[:image] if params[:image].present?

  end

  def create
    @book = Book.new(book_params)
    @book.save
    redirect_to book_path(@book.id)
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:title, :code, :author, :image)
  end


end

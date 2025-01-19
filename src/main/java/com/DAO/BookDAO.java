package com.DAO;

import java.util.List;

import com.entity.BookDtls;

public interface BookDAO {
	public boolean addBook(BookDtls b);
	public List<BookDtls> getAllBooks();
	public BookDtls getBookById(int id);
	public boolean updateBook(BookDtls b);
	public boolean deleteBooks(int id);
	
	public List<BookDtls> getNewBook();
	public List<BookDtls> getRecentBook();
	public List<BookDtls> getOldBook();
	public List<BookDtls> getAllRecentBook();
	public List<BookDtls> getAllNewBook();
	public List<BookDtls> getAllOldBook();
	public List<BookDtls> getBookByOld(String mail,String cate);
	
	public boolean oldBookDelete(String mail,String category,int Bid);
	
	public List<BookDtls> getBookBySearch(String sh);
	
}

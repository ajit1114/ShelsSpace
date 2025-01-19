package com.DAO;

import java.util.List;

import com.entity.BookDtls;
import com.entity.Cart;

public interface cartDAO {
	public boolean addCart(Cart c);
	public List<Cart> getBookByUser(int userid);
	public boolean removeItem(int bid,int uid ,int cid);
	
}

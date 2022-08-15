package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.CategoryGroupVO;
import com.spring.javagreenS_ljs.vo.CategoryVO;

public interface CategoryAdminService {
	
	public ArrayList<CategoryGroupVO> getCategoryGroupInfor();
	
	//오버로딩1
	public CategoryGroupVO getCategoryGroupInfor(String category_group_code);
	
	//오버로딩2
	public CategoryGroupVO getCategoryGroupInfor(int category_group_level);
	
	public void setCategoryGroup(CategoryGroupVO vo);

	public void setCategoryUseNot(int category_group_idx);

	public void setCategoryLevelSort(int changeLevel, int changeValue);

	public int getCategoryMaxLevel();

	public void setCategoryUse(CategoryGroupVO vo);

	public void setCategoryUpate(CategoryGroupVO vo);

	public void setCategoryGroupDelete(int category_idx);

	public void setCategory(CategoryVO vo);

	public ArrayList<CategoryGroupVO> getCategoryGroupInforOnlyUse();

	public ArrayList<CategoryVO> getCategoryInfor(int category_group_idx);

	public ArrayList<CategoryGroupVO> getCategoryOnlyUseInfor();

	public void setCategoryDelete(int category_idx);

	public CategoryVO getCategoryInfor2(int category_idx);

	public void setCategoryUseNot2(int category_idx);

	public void setCategoryUpate2(int category_idx, String category_name);

	public void setCategoryUse2(int category_idx);


}

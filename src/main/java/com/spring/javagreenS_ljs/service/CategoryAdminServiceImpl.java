package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.CategoryDAO;
import com.spring.javagreenS_ljs.vo.CategoryGroupVO;
import com.spring.javagreenS_ljs.vo.CategoryVO;

@Service
public class CategoryAdminServiceImpl implements CategoryAdminService {
	
	@Autowired
	CategoryDAO categoryDAO;

	@Override
	public CategoryGroupVO getCategoryGroupInfor(String category_group_code) {
		return categoryDAO.getCategoryGroupInfor(category_group_code);
	}

	@Override
	public void setCategoryGroup(CategoryGroupVO vo) {
		categoryDAO.setCategoryGroup(vo);
	}

	@Override
	public ArrayList<CategoryGroupVO> getCategoryGroupInfor() {
		ArrayList<CategoryGroupVO> categoryGroupList = categoryDAO.getCategoryGroupInfor2();
		for (CategoryGroupVO vo : categoryGroupList) {
			int idx = vo.getCategory_group_idx();
			
			// idx에 딸린 중분류 리스트 가져오기
			ArrayList<CategoryVO> categoryList = categoryDAO.getCategoryInfor(idx);
			vo.setCategoryList(categoryList);
		}
		return categoryGroupList;
	}

	@Override
	public void setCategoryUseNot(int category_group_idx) {
		categoryDAO.setCategoryUseNot(category_group_idx);
	}

	@Override
	public void setCategoryLevelSort(int changeLevel, int changeValue) {
		categoryDAO.setCategoryLevelSort(changeLevel, changeValue);
	}

	@Override
	public int getCategoryMaxLevel() {
		return categoryDAO.getCategoryMaxLevel();
	}

	@Override
	public void setCategoryUse(CategoryGroupVO vo) {
		categoryDAO.setCategoryUse(vo);
	}

	@Override
	public CategoryGroupVO getCategoryGroupInfor(int category_group_level) {
		return categoryDAO.getCategoryGroupInfor3(category_group_level);
	}

	@Override
	public void setCategoryUpate(CategoryGroupVO vo) {
		categoryDAO.setCategoryUpate(vo);
	}

	@Override
	public void setCategoryGroupDelete(int category_group_idx) {
		categoryDAO.setCategoryGroupDelete(category_group_idx);
	}

	@Override
	public void setCategory(CategoryVO vo) {
		categoryDAO.setCategory(vo);
	}

	@Override
	public ArrayList<CategoryGroupVO> getCategoryGroupInforOnlyUse() {
		return categoryDAO.getCategoryGroupInforOnlyUse();
	}

	@Override
	public ArrayList<CategoryVO> getCategoryInfor(int category_group_idx) {
		return categoryDAO.getCategoryInfor(category_group_idx);
	}

	@Override
	public ArrayList<CategoryGroupVO> getCategoryOnlyUseInfor() {
		ArrayList<CategoryGroupVO> categoryGroupList = categoryDAO.getCategoryGroupInforOnlyUse();
		for (CategoryGroupVO vo : categoryGroupList) {
			int idx = vo.getCategory_group_idx();
			
			// idx에 딸린 중분류 리스트 가져오기
			ArrayList<CategoryVO> categoryList = categoryDAO.getCategoryOnlyUseInfor(idx);
			vo.setCategoryList(categoryList);
		}
		return categoryGroupList;
	}

	@Override
	public void setCategoryDelete(int category_idx) {
		categoryDAO.setCategoryDelete(category_idx);
	}

	@Override
	public CategoryVO getCategoryInfor2(int category_idx) {
		return categoryDAO.getCategoryInfor2(category_idx);
	}

	@Override
	public void setCategoryUseNot2(int category_idx) {
		categoryDAO.setCategoryUseNot2(category_idx);
	}

	@Override
	public void setCategoryUpate2(int category_idx, String category_name) {
		categoryDAO.setCategoryUpate2(category_idx,category_name);
	}

	@Override
	public void setCategoryUse2(int category_idx) {
		categoryDAO.setCategoryUse2(category_idx);
	}

}

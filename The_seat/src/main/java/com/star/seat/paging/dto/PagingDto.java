package com.star.seat.paging.dto;

import java.util.List;

public class PagingDto<T> {
	private List<T> dataList;
	private int startPageNum;
	private int endPageNum;
	private int totalPageCount;
	private int pageNum;
	
	public PagingDto() {
		
	}
	
	public PagingDto(List<T> dataList, int startPageNum, int endPageNum, int totalPageCount, int pageNum) {
		super();
		this.dataList = dataList;
		this.startPageNum = startPageNum;
		this.endPageNum = endPageNum;
		this.totalPageCount = totalPageCount;
		this.pageNum = pageNum;
	}
	
	public List<T> getDataList() {
		return dataList;
	}

	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}

	public int getStartPageNum() {
		return startPageNum;
	}

	public void setStartPageNum(int startPageNum) {
		this.startPageNum = startPageNum;
	}

	public int getEndPageNum() {
		return endPageNum;
	}

	public void setEndPageNum(int endPageNum) {
		this.endPageNum = endPageNum;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	
	
}

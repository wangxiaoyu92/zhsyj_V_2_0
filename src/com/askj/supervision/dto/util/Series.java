package com.askj.supervision.dto.util;

import java.util.List;
/**
 * 数据
 * @author tang
 *
 */
public class Series {
	public String name;  
    
    public String type; //统计类别
      
    public List<Integer> data;//这里要用int 不能用String 不然前台显示不正常（特别是在做数学运算的时候）  
    public Label label;
    public Series( String name, String type, List<Integer> data,Label label) {  
        super();  
        this.name = name;  
        this.type = type;  
        this.data = data;  
        this.label=label;
    }  
}

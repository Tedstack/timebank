package com.blockchain.timebank.weixin.model;

public class TemplateParam {
    private String name;//模板名称
    private String value;//模板显示值
    private String color;//模板显示颜色

    public TemplateParam(String name,String value,String color){
        this.name=name;
        this.value=value;
        this.color=color;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }
}

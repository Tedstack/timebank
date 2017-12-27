package com.blockchain.timebank.weixin.model;


import java.util.List;
/**
 * 模板消息实体类
 * */
public class Template {
    // 消息接受方
    private String toUser;
    // 发送模板id
    private String templateId;
    // 详情点击url
    private String url;
    // 顶部颜色
    private String topColor;
    // 参数列表
    private List<TemplateParam> templateParamList;

    public String getToUser() {
        return toUser;
    }

    public void setToUser(String toUser) {
        this.toUser = toUser;
    }

    public String getTemplateId() {
        return templateId;
    }

    public void setTemplateId(String templateId) {
        this.templateId = templateId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getTopColor() {
        return topColor;
    }

    public void setTopColor(String topColor) {
        this.topColor = topColor;
    }

    public List<TemplateParam> getTemplateParamList() {
        return templateParamList;
    }

    public void setTemplateParamList(List<TemplateParam> templateParamList) {
        this.templateParamList = templateParamList;
    }

    /**
     * j将string 转换为JSON对象
     * @return
     */
    public String toJSON() {
        StringBuffer buffer = new StringBuffer();
        buffer.append("{");
        buffer.append(String.format("\"touser\":\"%s\"", this.toUser)).append(",");
        buffer.append(String.format("\"template_id\":\"%s\"", this.templateId)).append(",");
        buffer.append(String.format("\"url\":\"%s\"", this.url)).append(",");
        buffer.append(String.format("\"topcolor\":\"%s\"", this.topColor)).append(",");
        buffer.append("\"data\":{");
        TemplateParam param = null;
        for (int i = 0; i < this.templateParamList.size(); i++) {
            param = templateParamList.get(i);
            // 循环列表
            if (i < this.templateParamList.size() - 1)
                buffer.append(String.format("\"%s\": {\"value\":\"%s\",\"color\":\"%s\"},", param.getName(), param.getValue(), param.getColor()));
            else
                buffer.append(String.format("\"%s\": {\"value\":\"%s\",\"color\":\"%s\"}", param.getName(), param.getValue(), param.getColor()));
        }
        buffer.append("}");
        buffer.append("}");
        return buffer.toString();
    }

}

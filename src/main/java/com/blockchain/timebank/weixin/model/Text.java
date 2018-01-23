package com.blockchain.timebank.weixin.model;

public class Text {
    private  String toUser;
    private  String msgType;
    private  String content;

    public String getToUser() {
        return toUser;
    }

    public void setToUser(String toUser) {
        this.toUser = toUser;
    }

    public String getMsgType() {
        return msgType;
    }

    public void setMsgType(String msgType) {
        this.msgType = msgType;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    public String toJSON() {
        StringBuffer buffer = new StringBuffer();
        buffer.append("{");
        buffer.append(String.format("\"touser\":\"%s\"", this.toUser)).append(",");
        buffer.append(String.format("\"msgtype\":\"%s\"", this.msgType)).append(",");
        buffer.append("\"text\":{");
        buffer.append(String.format("\"content\":\"%s\"",this.content));
        buffer.append("}");
        buffer.append("}");
        return buffer.toString();
    }
}

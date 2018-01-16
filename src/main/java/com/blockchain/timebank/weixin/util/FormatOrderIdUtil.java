package com.blockchain.timebank.weixin.util;

import com.blockchain.timebank.entity.ViewPublishOrderDetailEntity;
import com.blockchain.timebank.entity.ViewRequestOrderDetailEntity;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class FormatOrderIdUtil {
    public static String getServiceOrderFormatId(ViewPublishOrderDetailEntity order){
        return format(order.getCreateTime(), order.getId());
    }

    public static String getRequestOrderFormatId(ViewRequestOrderDetailEntity order){
        return format(order.getCreateTime(), order.getId());
    }

    public static String format(Timestamp createTime, long orderId){
        String formatId = "";
        SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
        String prefix = sdf.format(createTime);
        String id = String.valueOf(orderId);
        if(id.length() == 1){
            formatId = prefix + "00" + id;
        } else if(id.length() == 2){
            formatId = prefix + "0" + id;
        } else{
            id = id.substring(id.length() - 3, id.length());
            formatId = prefix + id;
        }
        return formatId;
    }
}

package com.blockchain.timebank.entity;

//支付方式的定义
public class PayWay {
    public final static int PAY_WAY_TIME_VOL = 1;//志愿者币
    public final static int PAY_WAY_TIME_COIN = 2;//时间币
    public final static int PAY_WAY_TIME_BASE = 3;//时间元
    public final static int PAY_WAY_WEIXIN = 4;//微信
    public final static int PAY_WAY_ZHIFUBAO = 5;//支付宝

    public static String getPayWayName(int value) {
        if (value == PAY_WAY_TIME_VOL) return "志愿者币";
        else if (value == PAY_WAY_TIME_COIN) return "时间币";
        else if (value == PAY_WAY_TIME_BASE) return "时间元";
        else if (value == PAY_WAY_WEIXIN) return "微信";
        else if (value == PAY_WAY_ZHIFUBAO) return "支付宝";
        else return "其它";
    }
}

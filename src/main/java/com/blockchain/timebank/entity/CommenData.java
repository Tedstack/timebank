package com.blockchain.timebank.entity;

public class CommenData {
    private static long userId;
    private static long teamId;
    private static long activityId;

    public static long getUserId(){
        return userId;
    }

    public static void setUserId(long userId){
        CommenData.userId=userId;
    }

    public static long getTeamId(){
        return teamId;
    }

    public static void setTeamId(long teamId){
        CommenData.teamId=teamId;
    }

    public static long getActivityId(){
        return activityId;
    }

    public static void setActivityId(long activityId){
        CommenData.activityId=activityId;
    }
}

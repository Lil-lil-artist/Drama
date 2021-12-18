
import Debug "mo:base/Debug";
import Principal "mo:base/Principal";
import Time "mo:base/Time";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Nat64 "mo:base/Nat64";
import Hash "mo:base/Hash";
import Text "mo:base/Text";
import Option "mo:base/Option";

import AID "./Utils/AccountId";
import UserDomain "./UserDomain";

import ScriptKillDomain "./ScriptKillDomain";
// import ScriptKillRopositories "./ScriptKillRepositories";


// import ScriptKillActivity "./script_kill_create/ScriptKillActivity";


import List "mo:base/List";

shared(msg) actor class Drama() = this {

    public type ActivityID=ScriptKillDomain.ActivityId;
    public type ScriptKillStruct=ScriptKillDomain.ScriptKillStruct;
    public type UserInfo=UserDomain.UserInfo;

    /// ID Generator
    stable var idGenerator : Nat = 1111;  //相当于数据表中Index并且是递增的。也就是说活动Id是由后端生成的。


    // var activityCache = ScriptKillRopositories.newActivityCache();
    // var activityCache = HashMap.HashMap<AID.Address, Nat64>(1, AID.equal, AID.hash); //保存
    private var users = HashMap.HashMap<AID.Address, UserInfo>(1, AID.equal, AID.hash);
    
    // var activityParticipaters=HashMap.HashMap<Principal, Nat64>(0, Principal.equal, Principal.hash); //保存
    // var activityList = List.nil<Card.Card>();

    //活动map数据集
    // let activityRepository = ScriptKillRopositories.newActivityRepository();

    
    //创建一个基于activity类直接的map
    // public type activtyMap=HashMap.HashMap<ActivityID,ScriptKillStruct>;
    let activityEq=ScriptKillDomain.activityEq;
    let activityHash=ScriptKillDomain.activityHash;
    var testName = "";
    var testMap=HashMap.HashMap<Text,Text>(0,Text.equal, Text.hash);

    var activityMap=HashMap.HashMap<ActivityID,ScriptKillStruct>(0,activityEq, activityHash);
    /**
     * 创建用户
     * @return
     */
    public shared(msg) func createUser(_firstName: Text, _lastName: Text, _phone:Text,_email:Text, _personalInfo:Text):  async UserInfo {
        let address = AID.fromPrincipal(msg.caller, null);
        let addressUserOp = users.get(address);
        var userInfo :UserInfo ={
                firstName=_firstName;
                lastName=_lastName;
                phone=_phone;
                email=_email;
                personalInfo=_personalInfo;
                createTime=Time.now();
                address=address;
            };
        users.put(address, userInfo);
        return userInfo;
    };



    /**
     * 获取用户信息
     * @return
     */
    public shared(msg) func getUser(addr:Text):  async UserInfo{
       return Option.unwrap(users.get(addr));
    };


    // public type StriptKillDisplayInfoStract{

    //     activityId :ActivityId;  //这个Id看用什么比较好。
    //     activitySponsorPrincipal:Text;  //发起者Id(钱包地址)
    //     //本活动资金池
    //     totalBalance :Nat64; 
    //     //本活动众筹参与者（可以多人）
    //     // activityParticipaters: HashMap.HashMap<Text, Nat64>;

    //     timestamp : Timestamp;  //剧本杀众筹创建时间

    //     //剧本信息
    //     scriptName:Text; //剧本名称
    //     scriptType:Text;//剧本类型
    //     scriptDescription:Text;//剧本描述

    // };

    /**
    * 创建活动函数.发起者应该需要自带一定赞助费用
     * @param 剧本活动发起者
     * @param 剧本简介
     * @return
    */

    public shared(msg) func scriptSkillActivitySpon(value: Nat64,scriptName: Text,scriptType:Text,scriptDescription:Text ): async Nat{
    // public shared(msg) func scriptSkillActivitySpon(value: Nat64):  async Nat{
        
        // let from_balance = _balanceOf(msg.caller);
        // let from_balance_new = from_balance - value;
        // if (from_balance_new > 0) {  //余额足够
        // let scriptName ="111"; 
        // let scriptType="111";
        // let scriptDescription="111";

            let caller =Principal.toText(msg.caller);

            let activityId :Nat= getIdAndIncrementOne();
            // var cache = HashMap.HashMap<Text,Nat64>(0,Text.equal,Nat64.hash);
            // cache.put(caller,value); //发起者也要加入到赞助者名单中
            var cache = HashMap.HashMap<AID.Address, Nat64>(1, AID.equal, AID.hash);
            cache.put(caller,value);

            // let pa

        var _activityVoteParticipaters=HashMap.HashMap<AID.Address, Nat64>(1, AID.equal, AID.hash);
        var _activityElectParticipaters=HashMap.HashMap<AID.Address, Nat64>(1, AID.equal, AID.hash);
        var activity :ScriptKillStruct ={
                activityId=activityId;
                activitySponsorPrincipal=caller;
                totalBalance=value;
                activityParticipaters=cache;
                timestamp=Time.now();

                activityVoteParticipaters=_activityVoteParticipaters;
                activityElectParticipaters=_activityElectParticipaters;
                scriptName=scriptName;
                scriptType=scriptType;
                scriptDescription=scriptDescription;

            };
            activityMap.put(activityId,activity);
            // activityCache :=ScriptKillRopositories.createActivity(activityCache, activityRepository, activity);
            return activityId;
        // }
        // //如果钱包余额不足怎么处理，也就是执行失败怎么处理
        // 0
    };

    // private func _balanceOf(who: Principal) : Nat64 {
    //         switch (balances.get(who)) {
    //             case (?balance) {
    //                 balance
    //             };
    //             case (null) {
    //                 0
    //             };
    //         };
    //     };

    //  public query func balanceOf(who: Principal) : async Nat64 {
    //     _balanceOf(who)
    // };


    public shared(msg) func test01() : async Bool {
    //    let id= scriptSkillActivitySpon(10,"1","1","1");
    let name=activityMap.get(1111);

       true
    };


    public shared(msg) func testGet() :async Text {
    //    let id= scriptSkillActivitySpon(10,"1","1","1");
       
    //    let item=activityMap.get(1111);
    //    let name="";
    //    for (v in activityMap.vals()) {
    //        vv=Option.unwrap(v)
    //        name :=Option.unwrap(v).scriptName;
    //    };
       var name="";
       let act = activityMap.get(1111);
       if (Option.isNull(act)) {
           return "1";
       };
       name := Option.unwrap(act).scriptName;
    //    let name = Option.unwrap(act).scriptName;
       return name;
    };


    public shared(msg) func testReadVar() : async Text {
    //    let id= scriptSkillActivitySpon(10,"1","1","1");
       
       testName:="12123456";
       return testName;
    };


    public shared(msg) func testReadMap() : async Text {
    //    let id= scriptSkillActivitySpon(10,"1","1","1");
       
       testMap.put("111", "222");
       var x=Option.unwrap(testMap.get("111"));
       return x;
    };

    
    public shared(msg) func testReadMap1() : async Nat64 {
    //    let id= scriptSkillActivitySpon(10,"1","1","1");
        var cache = HashMap.HashMap<AID.Address, Nat64>(1, AID.equal, AID.hash);
       var _activityVoteParticipaters=HashMap.HashMap<AID.Address, Nat64>(1, AID.equal, AID.hash);
       _activityVoteParticipaters.put("1111", 111);
        var _activityElectParticipaters=HashMap.HashMap<AID.Address, Nat64>(1, AID.equal, AID.hash);
            var activity :ScriptKillStruct ={
                activityId=1111;
                activitySponsorPrincipal="1";
                totalBalance=11;
                activityParticipaters=cache;
                timestamp=Time.now();
                activityVoteParticipaters=_activityVoteParticipaters;
                activityElectParticipaters=_activityElectParticipaters;
                scriptName="1211";
                scriptType="scriptType";
                scriptDescription="scriptDescription";
            };
            activityMap.put(111,activity);
            let act=activityMap.get(111);
            let activityVoteParticipaters=Option.unwrap(act).activityVoteParticipaters;
            let num=activityVoteParticipaters.get("1111");
            var num1 = Option.unwrap(num);
            return num1;
            
    };

   

 /// 获取当前的id，并对id+1,这是有size effects的操作
    private func getIdAndIncrementOne() : Nat {
        let id = idGenerator;
        idGenerator += 1;
        id
    };



  /**
    * 众筹者参与众筹
     * @param 众筹者
     * @param 众筹者提供的资金
     * @return 参与者
    */
    public shared(msg) func scriptSkillParinIn(activityId:ActivityID,value: Nat64 ): async Text{
        // 余额校验这些先省去
        // let partivipater =msg.caller;
        let caller =Principal.toText(msg.caller);
        // let updeActivity:ScriptKillStruct

        let activity =activityMap.get(activityId);
        if(Option.isNull(activity)){
            return "find nonr!";
        };

        // Option.unwrap(activity).activityParticipaters.put(caller,value); //直接把成员加入到参与者map中
        //资金池添加增加。
      
        
        var activitySponsorPrincipalNew=Option.unwrap(activity).activitySponsorPrincipal;
        var balanceNew=Option.unwrap(activity).totalBalance+value;
        var cacheNew = Option.unwrap(activity).activityParticipaters;
            cacheNew.put(caller,value);
        var timestampNew=Option.unwrap(activity).timestamp;
        var scriptNamenew=Option.unwrap(activity).scriptName;
        var scriptTypeNew=Option.unwrap(activity).scriptType;
        var scriptDescriptionNew=Option.unwrap(activity).scriptDescription;
        var _activityVoteParticipaters=HashMap.HashMap<AID.Address, Nat64>(1, AID.equal, AID.hash);
        var _activityElectParticipaters=HashMap.HashMap<AID.Address, Nat64>(1, AID.equal, AID.hash);
        var activityNew :ScriptKillStruct={
                activityId=activityId;
                activitySponsorPrincipal=activitySponsorPrincipalNew;
                totalBalance=balanceNew;
                activityParticipaters=cacheNew;
                timestamp=timestampNew;
                activityElectParticipaters=_activityElectParticipaters;
                activityVoteParticipaters=_activityVoteParticipaters;
                scriptName=scriptNamenew;
                scriptType=scriptTypeNew;
                scriptDescription=scriptDescriptionNew;
        };


        activityMap.put(activityId,activityNew); //相同活动Id实现更新功能，如果不能实现就用repace函数。

        Principal.toText(msg.caller);

    };


    // /** 该环节是不需要的！！！！
    // * 创作者申请剧本杀任务 （这个还需讨论怎么具体处理）
    //  * @param 申请者
    //  * @param  ？？？
    //  * @return
    // */
    // public func scriptCreateResquest(creater: Principal) :  async Bool{

    //     true;
    // };
 


    /**
    * 赞助者投票决定谁获得创作权 
     * @param to 需要投向的庄户
     * @param  num 票数
     * @return
    */
    public shared(msg) func partivipaterVote(activityId: ActivityID,to: AID.Address, num:Nat64): async Text{
        var activity =activityMap.get(activityId);
        if(Option.isNull(activity)){
            return "not find activity";
        };
        // let toAddr =Principal.toText(to);
        var activityElectParticipaters= Option.unwrap(activity).activityElectParticipaters;
        let total = activityElectParticipaters.get(to);
        if(Option.isNull(total)){
            // 没有找到被投票人
            return "no find electParticipater";
        } else {
            let caller =Principal.toText(msg.caller);
            var activityVoteParticipaters = Option.unwrap(activity).activityVoteParticipaters;
            var voteNum = activityVoteParticipaters.get(caller);
            if(Option.isNull(total)){
                var totalNew=Option.unwrap(total)+num;
                activityVoteParticipaters.put(to, totalNew);
                var voteNumNew=Option.unwrap(voteNum)+num;
                activityVoteParticipaters.put(caller, voteNumNew);
            } else {
                var totalNew=Option.unwrap(total)+num;
                activityVoteParticipaters.put(to, totalNew);
                activityVoteParticipaters.put(caller, num);
            }
        };
        Principal.toText(msg.caller);
    };

    /**
    * 赞助者投票决定谁获得创作权V1 
     * @param to 需要投向的庄户
     * @param  num 票数
     * @return
    */
    public shared(msg) func partivipaterVoteV1(activityId: ActivityID,to: AID.Address, num:Nat64): async Text{
        var activity =activityMap.get(activityId);
        if(Option.isNull(activity)){
            return "not find activity";
        };
        // let toAddr =Principal.toText(to);
        var activityElectParticipaters= Option.unwrap(activity).activityElectParticipaters;
        let total = activityElectParticipaters.get(to);
        if(Option.isNull(total)){
            let a=0;
        };
        let caller =Principal.toText(msg.caller);
        var activityVoteParticipaters = Option.unwrap(activity).activityVoteParticipaters;
        var voteNum = activityVoteParticipaters.get(caller);
        if(Option.isNull(total)){
            var totalNew=num;
            activityVoteParticipaters.put(to, totalNew);
            var voteNumNew=Option.unwrap(voteNum)+num;
            activityVoteParticipaters.put(caller, voteNumNew);
        } else {
            var totalNew=Option.unwrap(total)+num;
            activityVoteParticipaters.put(to, totalNew);
            activityVoteParticipaters.put(caller, num);
        };
        
        Principal.toText(msg.caller);
    };

    /**
     * 获取最终投票胜出的用户
     * @param activityId 活动id
     * @return
    */
    public shared(msg)  func getWoteWinner(activityId:ActivityID):  async Text{
        
        let activity =activityMap.get(activityId);
        if(Option.isNull(activity)){
            return "";
        };
        var maxTotal : Nat64 = 0;
        var winner = "";
        var activityVoteParticipaters=Option.unwrap(activity).activityVoteParticipaters;
        for ((k, v)  in activityVoteParticipaters.entries()) {
            if (v > maxTotal ) {
                maxTotal:= v;
                winner := k;
            }
        };
        return winner;
    };



    /**
    * 活动结束
     * @param 
     * @param  ？？？
     * @return
    */
    // public func scriptKillActivityStop(){



    // }



    /**
    * 获得活动数据
     * @param 
     * @param  ？？？
     * @return
    */


    // public shared(msg) func getActivityInfo(activityId: ActivityID) : async ?StriptKillDisplayInfoStract {
        
    //     let activityInfo =activityMap.get(activityId);
    //     if(Option.isNull(activityInfo)){
    //       return  null;

    //     };
    //     for ((k,v) in Option.unwrap(activity).activityParticipaters.entries()) {
    //         list := list # Principal.toText(k) # "  " # Nat64.toText(v) # "\n";
    //     };



    //    {



    //    }
    // };


    //合约升级





    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };

   public func dojob(name : Text) : async Text {
        return "Hello, " # name # "!";
    };



/**
    * 获得活动数据
     * @param 
     * @param  ？？？
     * @return
    */

    public type activityInfoText={
        
        activityId :ActivityID;  //这个Id看用什么比较好。
        activitySponsorPrincipal:Text;  //发起者Id(钱包地址)
        //本活动资金池
        totalBalance :Nat64; 
        //本活动众筹参与者（可以多人）
        // activityParticipaters:[participater];

        timestamp : Int;  //剧本杀众筹创建时间

        //剧本信息
        scriptName:Text; //剧本名称
        scriptType:Text;//剧本类型
        scriptDescription:Text;//剧本描

        body1 :Blob;  //活动参与者转为文本显示
        body2 :Blob;  //活动参与者转为文本显示
        body3 :Blob;  //活动参与者转为文本显示

    };


    public query func getActivityInfo(activityId: ActivityID) : async activityInfoText {
//    var list = "Total " # Nat.toText(balances.size()) # " hodl: \n\n" # "Principal:                                                       balances: \n";
       
        //  var list = "Total " # Nat.toText(1) # " hodl: \n\n" # "Principal:                                                       balances: \n";

        let activity =activityMap.get(activityId);
        // if(Option.isNull(activityInfo)){
        //   return  null;

        // };

        // int i=0;
        // var participaters:[Text,Text]=

        // var list = "Total " # Nat.toText(balances.size()) # " hodl: \n\n" # "Principal:
        var list = "Total " # Nat.toText(1) # " hodl: \n\n" # "Principal:                                                       balances: \n";
        for ((k,v) in Option.unwrap(activity).activityParticipaters.entries()) {

            list := list # k # "  " # Nat64.toText(v) # "\n";
        };

        var list2 = "Total " # Nat.toText(1) # " hodl: \n\n" # "Principal:                                                       balances: \n";
        for ((k,v) in Option.unwrap(activity).activityElectParticipaters.entries()) {
            list2 := list2 # k # "  " # Nat64.toText(v) # "\n";
        };

        var list3 = "Total " # Nat.toText(1) # " hodl: \n\n" # "Principal:                                                       balances: \n";
        for ((k,v) in Option.unwrap(activity).activityVoteParticipaters.entries()) {
            list3 := list3 # k # "  " # Nat64.toText(v) # "\n";
        };

       var activitySponsorPrincipalNew=Option.unwrap(activity).activitySponsorPrincipal;
        var balanceNew=Option.unwrap(activity).totalBalance;

        var timestampNew=Option.unwrap(activity).timestamp;
        var scriptNamenew=Option.unwrap(activity).scriptName;
        var scriptTypeNew=Option.unwrap(activity).scriptType;
        var scriptDescriptionNew=Option.unwrap(activity).scriptDescription;

       {
            activityId=activityId;
            activitySponsorPrincipal=activitySponsorPrincipalNew;
            totalBalance=balanceNew;
            timestamp=timestampNew;
            scriptName=scriptNamenew;
            scriptType=scriptTypeNew;
            scriptDescription=scriptDescriptionNew;

            body1=Text.encodeUtf8(list);
            body2=Text.encodeUtf8(list2);
            body3=Text.encodeUtf8(list3);

       }
        

            // Iter.toArray(activityMap.entries());

    };


};


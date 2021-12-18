import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";


//每一个剧本杀创作可以看做事一个活动的发起，下面是每一个活动所包含的基本信息。
module {


    
    // public type StatusEnum = Text; //

    // /// 活动数据
    // public type ActivityId = Nat;  //这个Id看用什么比较好。
    // public type ActivitySponsorPrincipal = Text;  //发起者Id(钱包地址)

    // //本活动资金池
    // public type TotalBalance = HashMap.HashMap<Principal, Nat64>(0, Principal.equal, Principal.hash);
    // //本活动创作申请者（可以多人）

    // //本活动众筹参与者（可以多人）


    // //本活动

    // //
    public type Timestamp = Int;  //剧本杀众筹创建时间



 /// 用户数据
public type ActivityId = Nat;  //这个Id是什么？怎么生成的。可能是个索引
public type ActivityPrincipal = Text;  //地址

// public type ActivityMap=HashMap.HashMap<K, V>(0,Principal.s,Nat64);

 public type ScriptKillStruct= {
        /// 活动数据
        activityId :ActivityId;  //这个Id看用什么比较好。
        activitySponsorPrincipal:Text;  //发起者Id(钱包地址)
        //本活动资金池
        totalBalance :Nat64; 

        //本活动众筹参与者（可以多人）
        // activityParticipaters: HashMap.HashMap<Principal, Nat64>;
       activityParticipaters :HashMap.HashMap<Principal, Nat64>;
         //本活动创作申请者（可以多人）该参数不需要了，有赞助者共同创作。
        // scriptCreateResquestors:Text;

        //可能还需要投票的数据，成员及每个成员对应的票数！！！！
        // activityParticipaters :HashMap.HashMap<Principal, num>;
        // activityParticipaters :HashMap.HashMap<Principal, totalnum>;

        //剧本杀消费者和活动无关，所以不需要记录相关数据
        timestamp : Timestamp;  //剧本杀众筹创建时间

        //剧本信息
        scriptName:Text; //剧本名称
        scriptType:Text;//剧本类型
        scriptDescription:Text;//剧本描述
        // cionName:Text;//币种名

    };



    // /// User eq
    public let activityEq = Nat.equal;
    public let activityHash = Hash.hash


}

import AID "./Utils/AccountId";
import Array "mo:base/Array";
import HashMap "mo:base/HashMap";
import Time "mo:base/Time";

module {
    public type UserInfo = {
        address: AID.Address;
        createTime: Time.Time;
        name: Text;
        firstName: Text;
        lastName: Text;
        phone: Text;
        email: Text;
        personalInfo: Text;
        alias: Text;
        avatar: Text;
    };
};
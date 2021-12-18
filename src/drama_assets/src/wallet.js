// import { hello } from "../../declarations/hello";
// import { Principal } from '@dfinity/principal';

// 链接钱包
document.getElementById('wallet').addEventListener('click', async (e) => {
  e.preventDefault();
  // replace with project canisterId
  const canisterId = "rrkah-fqaaa-aaaaa-aaaaq-cai";
  const whitelist = [canisterId,];
  const host = "https://mainnet.dfinity.network";
  // const result = await window.ic.plug.requestConnect({ whitelist, host });
  const result = await window.ic.plug.requestConnect();
  const connectionState = result ? "allowed" : "denied";
  console.log(connectionState);
});

// 钱包转账（需要测试）
document.getElementById('transform').addEventListener('click', async(e) => {
  e.preventDefault();
  // 超时
  // const fromID = await window.ic.plug.agent.getPrincipal(); 
  const toID = document.getElementById("transferTo").value;
  const value = document.getElementById("amount").value;
  const amount = parseInt(parseFloat(value) * 100000000);
  const params = {
    to: toID,
    amount: amount,
  };
  const result = await window.ic.plug.requestTransfer(params);
  console.log(result);
  // await hello.trans_record(fromID, Principal.fromTex(toID), amount);
});

/*
// 记录用户信息
document.getElementById('user').addEventListener('click', async (e) => {
  e.preventDefault();
  const name = document.getElementById("name").value.toString();
  const introduction = document.getElementById("introduction").value.toString();
  await hello.login(name, introduction);
  alert("Your profile has been recorded!");
  console.log(name + " is registered!");
});


// 获取用和余额
document.getElementById('balance').addEventListener('click', async (e) => {
  e.preventDefault();
  // 超时
  const result = await window.ic.plug.requestBalance();
  console.log(result);
});
*/

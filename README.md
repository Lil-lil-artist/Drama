# Drama
## A Decentralized asynchronous digital art collaboration and asset management platform on Dfinity ecosystem

### Project vision:

**Unleash the creative enthusiasm and talent of long-tail creators, promote the complementarity and group wisdom of different creators in a community-based way**, build artworks that belong to the community, and release the rights of works to the community. In the early stage, drama was used as the creative form, and then gradually expanded to **any other art categories suitable for asynchronous creation**. And the platform will use On-chain storage ability of Dfinity to gradually become a **Decentralized digital art collaboration and asset management platform, (decentralized Github for digital art)**.

The specific implementation is as follows:
Build a art creation platform called **Drama** , whose governance token DRM is a fungible token, and users can log in with internet identity on the front-end webpage:

(DRM is the token for the Drama platform, drama token (GRB ) in the following paragraphs means the speficic token for a specific drama, eg: GRB in the drama token (GRB ) for the specific drama Green Book)

+ Users enter the type of drama, outline, total amount of tokens, crowdfunding period and other information, click the "Create Drama" button, then the smart contract destroy a small amount of DRM as the cost of the operation, in order to deal with the problem of excessive spam that may occur in the reverse Gas mechanism .Then the smart contract automatically starts crowdfunding DRM as a drama community fund (the drama community fund can be used to reward drama creators) and creates drama token (GRB ). 5% of the crowdfunding tokens enter the Drama platform vault, and the remaining 95% enter the drama community vault. If the user is not satisfied with the drama in the future, he can also redeem the DRM in crowdfunding proportionally with the drama token through the smart contract. **Thereby constructing a minimum value for drama tokens**.

+ If the crowdfunding completes the target crowdfunding amount within the specified time (if  crowdfunding fails, all crowdfunding tokens will be automatically refunded to the crowdfunding participants), the contract will automatically allocate tokens, and the drama token (GRB ) received by the user are proportional to the DRM contributed by the user ( 5% of the crowdfunding DRM goes to the Drama platform vault, and the remaining 95% goes to the specific drama community vault). After the drama token (GRB ) are distributed, all IC users (do not need to hold the drama token (GRB ) so that there will be a larger creator community) can propose a chapter summary proposal for the first chapter of the drama. Users who hold drama token (GRB ) can vote on the direction of the drama. 5% of the vote will be distributed to the proponent of the chapter summary proposal, 5% will go to the drama community fund (for distribution to subsequent drama writers), and the remaining 90% will be locked. After the chapter is confirmed, the locked drama token will be returned to the voter. In this process, voters will invest their tokens for their preferred chapter trend due to interest binding, and users who propose chapter summary proposals and chapter drama writers also have incentives for creation.
+ After the deadline for the first chapter proposal, the chapter summary proposal with the most votes becomes the final chapter. Then the selection process of the drama writer will begin. Users who apply to write a drama can introduce their past artworks and the required compensation for writing and other information to initiate a application proposal in the community. Then the community voted for the writer. After the voting period ends, the writer receives a 30% proportional remuneration as a deposit. After the writing is completed, the community will discuss and modify, and then vote to decide whether to pass (when the voting time expires, the version is passed if the vote of approval is greater than the rejection). After passed, the writer immediately received the remaining 20% of the reward, and the remaining 50% of the reward was released linearly within three months. Then the drama creation entered the chapter 2 stage, and so on. When the creation of each chapter is completed, there is also a vote on whether the drama is over (if the final votes are greater than the continued votes, then it is over). If it is over, the whole work will be published as an NFT, and the drama sales staff hired by the drama community will sell the copyright, royalties will be divided according to the drama token (GRB ) held by each user. (The distribution mechanism considering voting activity would be introduced in the future.)
+ Users can also pay DRM to unlock each chapter of the drama for reading.

(All the above specific figures are for reference only, and would be changed by community discussion)

In the future, the drama NFT can be used as an IP to further build movies, games, vr content, metaverse and other expansion businesses. (The specific decision will be made by the community DAO governance, and the SNS system of the Dfinity ecosystem may be introduced.)

### Feasibility:

+ From a technical point of view: it is necessary to construct a fungible token standard on Dfinity (similar to the erc20 standard on Ethereum) and a non-fungible token (similar to the erc721/1155 standard on Ethereum). Then integrate voting, crowdfunding and other mechanisms. All can be done.
+ From the perspective of application value: it unleashes the creativity of a large number of people who could not participate in the creation of drama, and at the same time complements everyone's creativity (different people’s creative points could be in different parts of the drama, and some people may be able to create unexpected endings, some people are better at creating romantic stories).
+ In terms of compatibility with Web3, this project uses the token economy to revitalize the interaction between creators, consumers and investors. At the same time, the assets on the chain are in line with web3.
+ Adaptability to the Dfinity platform: The drama can be completely stored on the chain, without the need for additional IPFS like the Ethereum platform, and the construction of NFT assets is more uniform. At the same time, integrating Dfinity's own SNS DAO governance system makes it easier to complete DAO governance.

### Contribution to ecosystem :

+ Start the Create-to-Earn wave on IC
+ Extend the application on IC
+ Provide IC with more NFT assets for trading on NFT trading platforms

### Economic model and token function:

DRM:

+ Part of the DRM will be used in the early stage to reward the participants of drama creation to promote the platform
+ The foundation reserves a part for later incentives for contributer to the platform (creators, commercial resource cooperation), this part of the fund gradually shifts to DRM holders DAO governance
+ Deflation: Submitting,voting and other operations on the platform Drama will destroy DRM.



drama token (GRB):

+ Can be used to vote for the creation process.
+ Incentives for drama chapter proponents and writers
+ Enter the drama vault for subsequent business resource
+ Used to calculate the copyright revenue share of the created drama.
+ Can be used to redeem crowdfunding funds

### Creativity:

Completely original, no similar projects on the market have been found so far.

<p align="right">Lil lil artist</p>	
<p align="right">2021.12.17</p>																																																											                                     																												



(Just a demo, all design might be discussed and improved.)

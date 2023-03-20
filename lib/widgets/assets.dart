import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../Model/wallet.dart';
import '../constants.dart';

enum _TAB { ntf, token }

class Assets extends StatefulWidget {
  const Assets({Key? key, required this.walletFuture}) : super(key: key);
  final Future<SolWalletData> walletFuture;

  @override
  State<Assets> createState() => _AssetsState();
}

class _AssetsState extends State<Assets> {
  _TAB tab = _TAB.ntf;
  @override
  Widget build(BuildContext context) {
    Map<Widget, VoidCallback> buttons = {
      const Text('NFTs'): () {
        // setState(() {
        //   tab = _TAB.ntf;
        // });
      },
      const Text('Tokens'): () {
        // setState(() {
        //   tab = _TAB.token;
        // });
        dialog(context);
      },
      SvgPicture.asset('assets/sliders.svg'): () {
        dialog(context);
      },
    };
    return FutureBuilder<SolWalletData>(
        future: widget.walletFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            final bool isETH = data!.chain?.toLowerCase() == 'eth';
            final List<NftList> nfts = data.nftList ?? [];
            final List<WalletTokenList> tokens = data.tokenList ?? [];
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Assets',
                    style: textTheme(context).bodyLarge,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(
                            3,
                            (index) => Row(
                                  children: [
                                    ElevatedButton(
                                        onPressed:
                                            buttons.values.elementAt(index),
                                        child: buttons.keys.elementAt(index)),
                                    const SizedBox(width: 10)
                                  ],
                                )),
                      ),
                      GestureDetector(
                        onTap: () => dialog(context),
                        child: SvgPicture.asset('assets/search.svg'),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        tab == _TAB.ntf ? 'NFT Collection' : 'Token',
                        style: textTheme(context).labelMedium,
                      ),
                      const Spacer(),
                      if (_TAB.ntf == tab)
                        Text(
                          'Floor',
                          style: textTheme(context).labelMedium,
                        ),
                      const SizedBox(width: 20),
                      Text(
                        'Holdings',
                        style: textTheme(context).labelMedium,
                      )
                    ],
                  ),
                  tab == _TAB.ntf
                      ? nfts.isEmpty
                          ? Center(
                              child: Text(
                                'No NFT available',
                                style: textTheme(context).labelMedium,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: nfts.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () => dialog(context),
                                  contentPadding: EdgeInsets.zero,
                                  horizontalTitleGap: 10,
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: kLighterColor,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                nfts[index].imgUrl!)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  title: Text(
                                    nfts[index].name!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(data.chain ?? 'null'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CircleAvatar(
                                                radius: 10,
                                                backgroundImage: isETH
                                                    ? null
                                                    : const AssetImage(
                                                        'assets/solana-sol-logo-12828AD23D-seeklogo.com.png',
                                                      ),
                                                child: isETH
                                                    ? Image.asset(
                                                        'assets/Ethereum-Logo-PNG-HD-Image.png')
                                                    : null,
                                              ),
                                              Text(
                                                nfts[index]
                                                    .floorPrice!
                                                    .toStringAsFixed(2),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              checkCoinIcon(
                                                  (nfts[index].percentChange ??
                                                          0)
                                                      .toString()),
                                              Text(
                                                '${(nfts[index].percentChange ?? 0).toStringAsFixed(2).substring(
                                                      (nfts[index].percentChange ??
                                                                  0) <
                                                              0
                                                          ? 1
                                                          : 0,
                                                    )}%',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: checkCoinColor((nfts[
                                                                    index]
                                                                .percentChange ??
                                                            0)
                                                        .toString())),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(width: 6),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CircleAvatar(
                                                radius: 10,
                                                backgroundImage: isETH
                                                    ? null
                                                    : const AssetImage(
                                                        'assets/solana-sol-logo-12828AD23D-seeklogo.com.png',
                                                      ),
                                                child: isETH
                                                    ? Image.asset(
                                                        'assets/Ethereum-Logo-PNG-HD-Image.png')
                                                    : null,
                                              ),
                                              Text((nfts[index].floorPrice! *
                                                      nfts[index].qty!)
                                                  .toStringAsFixed(2)),
                                            ],
                                          ),
                                          Text(
                                            '${nfts[index].qty} NFT',
                                            style: const TextStyle(
                                                color: kGreyColor),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                      : tokens.isEmpty
                          ? Center(
                              child: Text(
                                'No Tokens available',
                                style: textTheme(context).labelMedium,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: tokens.length,
                              itemBuilder: (context, index) {
                                final WalletTokenList tok = tokens[index];
                                return ListTile(
                                  onTap: () => dialog(context),
                                  contentPadding: EdgeInsets.zero,
                                  horizontalTitleGap: 10,
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: kLighterColor,
                                        image: DecorationImage(
                                            image: NetworkImage(tok.icon)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  title: Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            tok.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            tok.symbol.toUpperCase(),
                                            style: const TextStyle(
                                                color: kGreyColor,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '\$${tok.volume}',
                                            style: const TextStyle(
                                                color: kGreyColor,
                                                fontSize: 15),
                                          ),
                                          Row(
                                            children: [
                                              checkCoinIcon((tok.priceChange24h)
                                                  .toString()),
                                              Text(
                                                '${(tok.priceChange24h).toStringAsFixed(2).substring(
                                                      (tok.priceChange24h) < 0
                                                          ? 1
                                                          : 0,
                                                    )}%',
                                                style: TextStyle(
                                                    color: checkCoinColor(tok
                                                        .priceChange24h
                                                        .toString())),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '\$${(tok.price * tok.qty).toStringAsFixed(2)}',
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        '${tok.qty} Tokens',
                                        style:
                                            const TextStyle(color: kGreyColor),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                ],
              ),
            );
          } else {
            return Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

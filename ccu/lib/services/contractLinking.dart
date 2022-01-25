import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://10.0.2.2:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  final String _privateKey = "22ba2a4e04cd71c24162a9c0aea58167e7ea731d75af8a54ee64bdb3e0bbc6d6";

  Web3Client? _client;
  String? _abiCode;

  EthereumAddress? _contractAddress;
  Credentials? _credentials;

  DeployedContract? _contract;
  ContractFunction? _name;
  ContractFunction? _currentTokens;
  ContractFunction? _set;
  ContractFunction? _decrement;
  ContractFunction? _increment;

  bool isLoading = true;
  String? name;
  String? currentTokens;

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    final abiStringFile =
        await rootBundle.loadString("src/artifacts/Tdl.json");
    final jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
    //_credentials = await _client!.credentialsFromPrivateKey(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, "Tdl"), _contractAddress!);
    _name = _contract!.function("name");
    _currentTokens = _contract!.function("currentTokens");
    _set = _contract!.function("set");
    _decrement = _contract!.function("decrement");
    _increment = _contract!.function("increment");

    getData();
  }

  getData() async {

    List personName = await _client!
        .call(contract: _contract!, function: _name!, params: []);
    List tdl = await _client!
        .call(contract: _contract!, function: _currentTokens!, params: []);
    name = personName[0];
    currentTokens = tdl[0].toString();
    print("$name , $currentTokens");
    isLoading = false;
    notifyListeners();
  }

  addData(String nameData) async {
    isLoading = true;
    notifyListeners();
    await _client!.sendTransaction(
        _credentials!,
        Transaction.callContract(
            contract: _contract!,
            function: _set!,
            parameters: [nameData]));
    getData();
  }

  increaseTdl(int incrementBy) async {
    isLoading = true;
    notifyListeners();
    await _client!.sendTransaction(
        _credentials!,
        Transaction.callContract(
            contract: _contract!,
            function: _increment!,
            parameters: [BigInt.from(incrementBy)]));
    getData();
  }

  decreaseTdl(int decrementBy) async {
    isLoading = true;
    notifyListeners();
    await _client!.sendTransaction(
        _credentials!,
        Transaction.callContract(
            contract: _contract!,
            function: _decrement!,
            parameters: [BigInt.from(decrementBy)]));
    getData();
  }
	
}
